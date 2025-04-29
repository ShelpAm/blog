---
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

    $$ D_T = N/R $$ seconds

    where:

    $$ D_T $$ is the transmission delay in seconds;

    $$ N $$ is the number of bits;

    $$ R $$ is the rate of transmission (say, in bits per second).

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
  
  有效数据率 (平均吞吐量):

  $$ Average Throughput = \frac{Data Length}{Transmission Delay + RTT} $$

- 信道利用率 - 信道占用时间占总时间的百分比
- 网络利用率 - 全网络的信道利用率的加权平均值。

  若 $$ D $$ 是当前时延，$$ D_0 $$ 是空闲时延，$$ U $$ 是网络利用率，则：

  $$ D = \frac{D_0}{1 - U} $$

  即网络利用率越高，时延越高。

## Network protocol

> What are network protocols?

Rules, standards or conventions built up for data switching in network.

Protocols are "horizontal"; services are "vertical".

### Three elements of a network protocol:

- Syntax (语法)
- Semantics (语义)
- Timing (同步)

### Terminologies

Entity
: Hardwares and softwares which can send/receive information.

> Peer Entity (对等实体) 间通信使得每层可以为上一层提供服务。
{: .prompt-tip }

Protocol Data Unit (PDU)
: The basic unit of data switching between protocols.

Service Data Unit (SDU)
: The basic unit of data switching between services.

Service primitives
: Commands defined for service delivery.

Service Access Point (SAP)
: Interface for service delivery.

### Open System Interconnection (OSI) model

Seven layers in OSI model are the followings:

- Physical
- Data Link
- Network
- Transport
- Session
- Presentation
- Application

The following are PDUs of them:

- For physical layer, it is _bit_.
- For data link layer, it is _frame_.
- For network layer, it is _packet_ or _datagram_.
- For transport layer, it is _segment_.
- For application layer, it is _message_.

### TCP/IP model

- 4 Layers
  - Application layer, transport layer, internet layer, and link layer
- Now widely used

### Socket

Sockets addresses are made up with IP address and port number.

> Remote socket, local socket combined with transport protocol form socket pairs.
> (This may be obsolete)

