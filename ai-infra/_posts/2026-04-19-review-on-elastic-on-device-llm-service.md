---
title: Review on Elastic On-Device LLM Service
math: true
---

问题：不知道需要学到多深入，多具体

Need to learn later:

- Early exit networks
  - 得说一下是怎么做的


## Motivation

Nowadays a common practice for deploying LLM on-device is to deploy a single yet
powerful LLM as a general task solver for multiple requests.

But they lack a elasticity to serve requests that have diversified service-level
objectives (SLOs) on inference latency. Define those levels as different
time-to-first-token (TTFT) and time-per-output-token (TPOT).

For instance, voice assistants require low TTFT to provide a responsive user
experience. Meanwhile, UI-automation needs low TTFT and acceptable TPOT
to ensure smooth interactions.

Other solutions include deploying multiple LLMs with different sizes and
capabilities, but it can be costly and inefficient.


## Related work

- Elastic neural networks: dynamically adjust capacity at runtime
  - Early exit networks:
    - Due to autoregressive inference nature, a skipped layer’s KV cache may be
      accessed later.
    - Layers as granularity is not fine-grained enough.
  - Parameter sharing networks:
    - Need re-pretrain, and too expensive for LLMs (foundation models).
  - Adaptivenet:
    - Also needs expensive pretraining.
  - Activation sparsity:
    - Not suitable for prefill stage due to low locality.

- Efficient on-device LLM inference
  - MLC-LLM: NN-compiler with operator- and kernel- level optimization.
  - MNN and mllm: on-device inference library.
  - PowerinferV2: addresses memory issue by introducing swapping and activation
    sparsity.

  ElastiLM is orthogonal to these work.

- Foundation models as a service

  ElastiLM improves performance by elasticizing the model and prompt.

- Model collaboration
  - _Speculative decoding_ accelerates the decode stage with a draft SLM.
  - _LLMlingua_ uses an SLM to refine the LLM prompt.

  Very common in ML systems.

## Design

This method involves two novel sights:

- One-shot reordering of permutation consistent units
- Dual-head tiny language model for prompt-model orchestration

### One-shot reordering of permutation consistent units

- For Transformer-based models, attention head (containing $W_{Q/K/V/O}$) and
  MLP block (containing $W_{\mathrm{up}/\mathrm{down}}$) are two types of joint
  units, which can be reordered without affecting the output of the operation.

  By utilizing this method, we can profile unit importance through
  explainable-AI (XAI). Metric here is the delta loss after pruning the unit.

- Nevertheless, there are some layers more important than others, called "anchor
  layers". Keeping these layers from elasticized results in fine-grained
  sub-models. And based on that, introduce LoRA (Low Rank Adapter) to frozen
  $W_{Q/K/V/O}$ and $W_{\mathrm{up}/\mathrm{down}}$ of each sub-model to recover
  them from potential accuracy loss.

  LLM fine-tuning is task-agnostic, because it commonly servers as general task
  solver.

- At online inference, just elasticize the model by moving memory pointers.

Advantages of this method include:

- Identifies joint unit in two layer blocks ubiquitous in Transformer, while
  [PIT][pit] still needs online reordering the input with a single operator
  level of abstraction.

  这里我觉得论文里说的逻辑不对，PIT 里的方法是动态调整 $x$ 和 $W$ 的行列来减轻运算负
  担；而本文的方法是离线调整 $W_1$ 和 $W_2$ 的行列达到剪枝的目的。在C++中相当于
  一个是编译期优化，一个是运行时优化。目标都不一样不好说谁好谁差。
（或者说这两种方法也是正交的，可以同时实施：一个是调整输入和参数，
  一个是只调整参数）


[pit]: https://dl.acm.org/doi/10.1145/3600006.3613139

### Dual-head tiny language model for prompt-model orchestration

The model is based on MobileBert , a compact language model with only 20%
parameters of BERT_base yet just 0.7% accuracy loss on GLUE benchmark.

Input of the tiny language model (TLM) is the original sequence and TTFT, TPOT.
Encoding TTFT and TPOT as special orthogonal tokens makes them isolated (because
they have different pattern, and thus won't lead to similar weight in model).

For the two heads:

- Score-head outputs whether to retain or discard each word.

  It fine-tunes the model based on [MeetingBank][meetingbank], which contains
  compression data.

- Decision-head outputs elastification level (both for model and prompt).

  It uses a self-induced labeling process: traverse all submodels that output
  correct answer, find the most lightweight one, and label it as the answer.
  Then use the label for training.

  And there's a fallback mechanism for decision-head: if the model output a
  decision that cannot meet the requirement of SLO, it will output a randomly
  generated output strictly meeting the SLO.

They share a same "base" (12 out of 24 layers). The rational behind this is that
bottom layers of deep neural networks (DNNs) captures basic instead of
task-specific information. And this further minimizes the model size.

[meetingbank]: https://huggingface.co/datasets/microsoft/MeetingBank-LLMCompressed

## Evaluation

### 测试平台

- On cloud, a server with a 64-core CPU (750GB RAM) and 8 A40 GPUs (45GB HBM each).
- On device, COTS smartphones listed in Table 2.

### Baselines

- PFS: directly deploys pre-trained LLMs of different sizes for different SLOs.
  （直接部署不同大小的预训练模型，为不同 SLO 单独服务。）
- LPruner: a state-of-the-art parameter pruning method for elastification.
  （用于弹性化的强剪枝基线。）
- LE: layer-wise elastification that prunes parameters at layer granularity.
  （按层级做弹性剪枝。）
- LG2+CS: combines LLMLingua2 prompt compression with Contextual Sparsity at decode time.
  （把 LLMLingua2 的 prompt 压缩和解码阶段的上下文稀疏结合起来。）
- LaCo: another strong pruning baseline that can derive sub-models from the original model.
  （另一种强剪枝基线，可从原模型派生子模型。）
- ShortGPT: a pruning baseline that removes less important parts of the model.
  （通过剪掉不重要部分来压缩模型。）
- AttnDrop: a pruning baseline that drops attention-related components.
  （剪掉注意力相关组件的基线。）

### End-to-end evaluation

There're three aspects to evaluate: accuracy, memory consumption, switching overhead.

The study sets three levels of skewness: 0, 0.25, -0.25, with **accuracy** messured
by comparing the output to groundtruth.

Results show that the study outperfroms all baselines in terms of accuracy,
indicating that the method is particularly effective in scenarios with diverse
SLOs.

The following list are comparisons to baselines in terms of accuracy:

- FPS: 利用了prompt 剪枝，加上低模型切换开销，对不同 SLO 进行完全弹性化，最大利用性能。
- LPruner (SOTA): 利用了 prompt 剪枝，以及低模型切换开销。
- LG2+CS: 由于上下文稀疏的低locality，prefill 阶段性能不佳，这导致LG2需要很激进的
  prompt 剪枝来满足 SLO，进而导致准确率下降。由于很多 LLM 用的不是 ReLu，稀疏化可能不强，
  而且 attention 部分就矩阵来说也不满足稀疏性，强求稀疏化可能导致性能下降。而本文的方法
  则是通过模型的 permutation consistency 做剪枝来满足 SLO，同时适用于 prefill 和
  decoding 阶段，还会根据 SLO 来动态调整剪枝比例。
- LE/LaCo/ShortGPT/AttnDrop: 粒度更细的 unit-level 剪枝，比 layer-level 剪枝更灵活。
  LaCo 子权重不共享，也有更大的切换开销。

在内存占用上，ElastiLM 和各个基线基本持平，峰值大约在 15–17GB。这说明它的弹性设计并没有
带来额外的常驻内存负担。相反，如果像 PFS 或 LaCo 那样把不同 SLO 对应的模型都直接放在内存里，
总占用会达到 29.3GB 或 76.3GB，在商用手机上会直接 OOM，因此不可部署。

切换开销上, 由于大量内存交换和内存移动，PFS (Swap) and LPruner 有不可接受的 8.3 秒/6.2 秒
模型切换时间。而 ElastiLM 仅需 0.31 秒。

### Performance on standalone datasets

在固定 SLO、且不考虑切换开销时，ElastiLM 在单独数据集上也保持领先，说明它的优势不只来自调度，
而是方法本身有效。

### Offline stage overhead

离线阶段成本仅有 68.3 GPU时。

### Sensitivity analysis

数据敏感性实验: 改变模型数据集大小为10倍，仅对模型性能提升有 0.2%，故当前已经是甜点区间。

配置敏感性实验表明，ElastiLM 的 TLM 规模、共享层数和弹性步长都已经接近甜点区间。
40M 参数的 TLM 足够用，12 层共享底层在容量和开销之间比较平衡，而 10% 的弹性步长已
经足够细，继续缩小到 5% 基本没有额外收益。

#### Ablation study

