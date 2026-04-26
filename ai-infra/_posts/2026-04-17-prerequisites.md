---
title: AI Infra - Prerequisites about Machine/Deep Learning
math: true
---

## Feed-forward network

Feed-forward network is a type of network whose output is not a part of its
input.

## Multi-layer perception

Multi-layer perception (MLP) is a type of feed-forward neural network that
consists of multiple layers of nodes, which are called hidden layers, where each
layer is fully connected to the next one. The MLP is designed to learn complex
patterns in data by using non-linear activation functions and backpropagation
for training.

There're other neural networks like CNN, RNN.

### Deep neural network

Deep neural network (DNN) is a type of neural network that has multiple (at
least 4) hidden layers. It's often complex and mixed.

## Architecture of Transformer

Here we'll introduce the architecture of Transformer in the order of data flow.

### Tokenization

Words are  into segments and then converted to integer representations.

### Embedding

Integer representations are hard to learn, so convert them into embedding vector
via a lookup table.

In equivalent word, integer $x$ means selecting the $x$-th row from the
embedding matrix $M$ using a one-hot representation of $x$:

$\mathrm{Embed}(x) = [0, 0, ..., 1, ..., 0] M$

And the dimension of the embedding vector is called _hidden size_ and written as
$d_{\mathrm{emb}}$ and $d_{\mathrm{model}}$.

### Positional encoding

Didn't comprehend the positional encoding in detail. So just skip this
(temporarily).

### Encoder and decoder

#### Encoder

The encoder consists of two sublayers:
- Multi-headed self-attension
- Feed-forward network.

Multi-headed self-attention layer has Q K V.

Feed-Forward network is a 2-layered MLP:

$$\mathrm{FFN}(x) = \phi(xW^{(1)} + b^{(1)})W^{(2)} + b^{(2)}$$

where $\phi$ is activation function. The original paper used ReLU activation.

See <https://en.wikipedia.org/wiki/Transformer_(deep_learning)#Encoder>

### Unembedding

Mostly the same as embedding, except that unembedding converts the embedding
vector ($x$) into probability distribution over the vocabulary.

$\mathrm{UnEmbed}(x) = \mathrm{softmax}(xW + b)$

Some archtecture use $M^T$ as $W$ to keep memory-efficient and to avoid
divergence during training.

$xW$ here calculates the dot product between the embedding and the unembedding
matrix, which can be interpreted as measuring the similarity between the
embedding and each word in the vocabulary.

## FAQ

- Why models based on Transformer architecture can be trained in parallel?

  Because not like RNN, training of Transformer does not depend on the last
  generated token.
