---
title: Review on Elastic On-Device LLM Service
math: true
---

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

  这里我觉得论文里说的不对，PIT 里的方法是动态调整 $x$ 和 $W$ 的行列来减轻运算负
  担；而本文的方法是离线调整 $W_1$ 和 $W_2$ 的行列达到剪枝的目的。目标都不一样不
  好说谁好谁差。


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

  It uses a self-induced labeling process: traverse all submodels, find the
  most lightweight one, and label it as the answer. Then use the label for
  training.

  And there's a fallback mechanism for decision-head: if the model output a
  decision that cannot meet the requirement of SLO, it will output a randomly
  generated output strictly meeting the SLO.

They share a same "base" (12 out of 24 layers). The rational behind this is that
bottom layers of deep neural networks (DNNs) captures basic instead of
task-specific information. And this further minimizes the model size.

[meetingbank]: https://huggingface.co/datasets/microsoft/MeetingBank-LLMCompressed

## Evaluation

