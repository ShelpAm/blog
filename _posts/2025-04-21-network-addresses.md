---
title: Network addresses
categories: notes-computer-networking
---

## Introduction

There are many kinds of networks, like private, public, reserved, and loopback.

## Address spaces

Private networks shares the following addresses:

- 10.0.0.0/8
- 172.16.0.0/12
- 192.168.0.0/16

169.254.0.0/16 is for link-local address.

127.0.0.0/8 is for loopback.

Basically, other IP addresses could be regarded as public addresses. But to see in detail, refer to
[RFC6890][rfc6890].

[rfc6890]: https://www.rfc-editor.org/rfc/rfc6890

## See also

- <https://www.rfc-editor.org/rfc/rfc6890> for Special-Purpose IP Address Registries
- <https://www.rfc-editor.org/rfc/rfc3927> for Link-Local Addresses

