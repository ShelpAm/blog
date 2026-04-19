---
title: Review on Elastic On-Device LLM Service
math: true
---

## Motivation

Different LLM requests need different levels of LLM services, such as
time-to-first-token (TTFT) and time-per-output-token (TPOT).

For instance, voice assistants require low TTFT to provide a responsive user
experience. Meanwhile, UI-automation needs low TTFT and acceptable TPOT
to ensure smooth interactions.

## Related work

Nowadays a common practice is to deploy a single yet powerful LLM as a general
task solver for multiple requests. But they lacks a elasticity to serve requests
that have diversified service-level objectives (SLOs) on inference latancy.

Other solutions include deploying multiple LLMs with different sizes and
capabilities, but it can be costly and inefficient.

## Design

This method involves two novel sights:

- Ont-shot reordering of permutation consistent units
- Dual-head tiny language model for prompt-model orchestration

### One-shot reordering of permutation consistent units

### Dual-head tiny language model for prompt-model orchestration


