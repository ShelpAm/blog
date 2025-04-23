---
categories: notes-computer-network
math: true
---

## Data switching

There are three data switching methods:

- Circuit switching: 建立连接，独占资源，类似管道。
- Message switching: 一次性发送整个报文到相邻节点。
- Packet switching: 把报文分割为多个组，分别发送到相邻节点。

## Delays in Computer Network


- Transmission delay - time it takes to push the packet's bits onto the link
  - It is given by the following formula:

    $ D_T = N/R $ seconds

    where:

    $ D_T $ is the transmission delay in seconds;

    $ N $ is the number of bits;

    $ R $ is the rate of transmission (say, in bits per second).

- Propagation delay
- Queuing delay
- Processing delay - time it takes a router to process the packet header

## Performance characteristics

- **Bandwidth (signal processing)**, a measure of the width of a frequency range
- **Bandwidth (computing)**, the rate of data transfer, bit rate or (_theoretically optimal_) throughput
  - limits the rate at which data can be sent.
- **Throughput**, the _actual_  rate of data transfer
- [**Delay**](#delays-in-computer-network) (as talked above)
- **Bandwidth-delay product**, the maximum amount of data on the network circuit at any given time,
  i.e., data that has been transmitted but not yet acknowledged
- **Round-trip time**, also known as RTT
- 信道利用率 - 信道占用时间占总时间的百分比，网络利用率 - 全网络的信道利用率的加权平均值。

  若 D 是当前时延，D_0 是空闲时延，则：
  $$ D = {fraction D_0 (1 - U)} $$
  网络利用率越高，时延越高。

## Network protocol

> What are network protocols?

Rules, standards or conventions built up for data switching in network.

### Three elements of a network protocol:

- Syntax (语法)
- Semantics (语义)
- Timing (同步)

### OSI (Open System Interconnection) model

Seven layers in OSI model are the followings:

- Physical
- Data Link
- Network
- Transport
- Session
- Presentation
- Application

where layers of Physical, Data Link, Network, Transport, Application are in 5 layers in production.

### Socket

Sockets addresses are made up with IP address and port number.

> Remote socket, local socket combined with transport protocol form socket pairs.
> (This may be obsolete)

