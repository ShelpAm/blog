---
math: true
---

## User Datagram Protocol (UDP)

- Checksum includes pseudo header

## Transport Control Protocol (TCP)

### Automatic Repeat reQuest (ARQ)

There are three ARQ protocols as follows:

- Stop and Wait protocol
- Go Back N (GBN) protocol
- Selective Repeat (SR) protocol

They all have Sender Window (SWND) and Receiver Window (RWND), and meat the following table:

|ARQ|SWND|RWND|
|:--|:--|:----|
|SW |1  |1    |
|GBN|>=1|1    |
|SR |>=1|>=1  |

### Reliable transmission

This is based on ARQ, learning a lot from it. (but [not the same](#relationship-between-tcp-and-arq))

### Flow control

RWND is of the receiver.

### Congestion control

TCP has a congestion control mechnism. It helps protect the Internet from blocked by flooding
packets.

Congestion Window (CWND) is of sender. The sender window is calculated as:

$$ SWND = \min\{CWND, RWND\} $$

Four algorithms build the congestion control mechnism up. They're:

- Slow start - Scaling CWND with a multiplicative factor 2 until Slow Start Threshold (ssthresh).
  (If scaled CWND is non-less than ssthresh then set the CWND to ssthresh and consider it reaches
  ssthresh)
- Congestion avoidance - After reached ssthresh, adding CWND by 1 until timeout. After timeout,
  then set ssthresh to $$ CWND / 2 $$ and CWND to 1.
- Fast retransmission - Trigger together with [Fast recovery](#fast-recovery).
- Fast recovery <a href="#" id="fast-recovery"></a>
  - If a peer receives three duplicate ACKs, fast retransmission and fast recovery start. It begins
    to send those unreceived packets and divide CWND by 2 (without touching ssthresh).

### Relationship between TCP and ARQ

They are NEITHER the same NOR fully inclusive. They share some property but never have the
relationship of inheritance.

TCP combines advantages of those, and has its own rules, as following list.

- TCP's ACK is an acknowledgement for NEXT UNRECEIVED byte, which the others' ACK is for LAST
  RECEIVED packet.
- TCP also has SWND and RWND non-less than 1.

### Format

- Checksum includes pseudo header

> Note that checksum in IP doesn't include pseudo header, because it doesn't have such a pseudo :)
> (If it does, then who offers it?)
{: .prompt-info }

### States

To be continued.
