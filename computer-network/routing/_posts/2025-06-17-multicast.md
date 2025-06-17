---
---

## What is multicast

Imagine this scenario:

![multicast-example](/assets/images/multicast-example.png)
_An example of network topology for multicast_

Now A wants to send same packets to address group containing B, C, E, and X. It can simply send
packets over and over again for 4 times, but it can improve the efficiency of sending the same
packets by delegating the responsibility of replicating the packets to the network. And after that,
A only sends one packets and the network replicates it and forwards it.

In other words, it moves the duty of replicating packets from the host A to the network.


## Techniques and principles

### Reverse Path Broadcast (**RPB**) aka Reverse Path Forwarding (**RPF**) and Pruning

In this mechanism, the protocol will form a shortest path spanning tree via the following ways:

1. The sources (say A) sends out the packet.
2. The router that receives the packet (say from interface x) will ask itself, if it was sending a
   unicast packet to A, is this (x) the interface through which it would send it?
3. If the answer is yes, so therefore, it will send it out every other interface. Otherwise, it
   drops the packet.

> So, it's a little bit like flooding, but it's asking more detailed question: is this the interface
> through which I would send it if it was a unicast packet going to A?
{: .prompt-tip }

#### Plus Pruning

If some device receives a packet from a multicast group but isn't interested it, it sends prune
messages towards the source. So therefore the source won't forward packet through corresponding
interface again (for a sane period of time).

### One versus multiple trees

It's clear that the resulting tree is specifically for a single source, but not all. So we must
build multiples trees for multiple sources.

Sometimes, we set a rendezvous as center to deliver packets.

So, there's really a design choice in practice as to whether we maintain one tree or one
for every source.

## Practice

### IGMP - group management


### DVMRP - the first multicast routing protocol


### PIM - protocol independent multicast
