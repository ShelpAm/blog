---
math: true
---

## End-to-end routing

### Approaches

- Flooding. As its name, packets go anywhere (it may form loops).
- Sourcing routing. Source router put the full path (from source to destination) in packets.
- Forwarding table.
- Spanning tree

## Other types of routing

- Multipath
  - Is when we spread the packets over multiple links, in order to spread the load as evenly as we
  can accross the network.
- Multicast
  - Opposite to _unicast_

## Metrics

And there are many different metrics to determine the best paths:

- Min distance
- Min hop-count
- Min delay
- Max throughput
- Least-loaded path
- Most reliable path
- Lowest cost path
- Most secure path

## Shortest path spanning tree

### Distributed Bellman-Ford Algorithm

We can learn this with a concrete example:

![bellman-ford-example](/assets/images/bellman-ford-example.png)
_A bellman ford example_

Assume routers know cost of link to each neighbor.

Router $$R_i$$ maintains value cost $$C_i$$ to reach $$R_8$$. Vector $$C = (C_1, C_2, C_3, \dots, C_7)$$ is
the distance vector to $$R_8$$. Initially, set $$C = (\infty, \infty, \dots, \infty)$$

1. After $$T$$ seconds, $$R_i$$ sends $$C_i$$ to its neighbors.
2. If $$R_i$$ learns lower cost path, update $$C_i$$
3. Repeat.

#### A problem with bellman-ford: "Bad news travels slowly"

> This problem is also known as _Counting to Infinity Problem_.
{: .prompt-tip }

This problem occurs when some links break. For example, say we have a graph, where
$$V = \{ R_1, R_2, R_3 \}$$, and $$E = \{ (R_1 \to R_2),\ (R_2 \to R_1),\ (R_2 \to R_3) \}$$
. Afterwards, distance vector $$C = (2, 1, 0)$$ (to $$R_3$$).

When $$(R_2 \to R_3)$$ breaks, $$C$$ will be updated to $$(2, \infty, 0)$$.

From then on, the following two events takes place simultaneously:

- $$R_1$$ reports to $$R_2$$ that $$R_3$$ is at a cost of $$C_1 + 1 = 3$$. So update $$C_2 \gets 3$$.
- $$R_2$$ reports to $$R_1$$ that $$R_3$$ is unreachable. And $$C_1$$ will be updated to $$\infty$$.

After that, now comes that $$C = (\infty, 3, 0)$$.

Again, $$C = (4, \infty, 0)$$.

So eventually, the distance vector will keep being updated forever!

**Solutions**:

- Set infinity = "some small integer" (e.g. 16). Stop when count = 16.
- Split Horizon: Because $$R_2$$ received lowest cost path from $$R_3$$, it does not advertise
cost to $$R_3$$.
- Split-horizon with poison reverse: $$R_2$$ advertises infinity to $$R_3$$

#### Bellman Ford in practice

Bellman-Ford algorithm is an example of Distance Vector algorithm.

It was used in the first Internet routing protocol, called Routing Information Protocol (**RIP**).

It requires little computation on the routers, is distributed, and will eventually converged.

### Dijkstra

This algorithm is almost the same as what you learned in Data Structure & Algorithm class, except
that:

- **No min-heap-optimization**. Nodes pull together to calculate the result, no such a 'super' node
  to process all the nodes.
- Everything is calculated from scratch every time there's a change.

#### Dijkstra in practice

Dijkstra is an example of a link state algorithm.

- link state is known by every router.
- Each router finds the shortest path spanning tree to every other router.

It is the basis of Open Shortest Path First (**OSPF**) a very widely used routing protocol.

## Interior Gateway Protocol (**IGP**)

RIP, OSPF and ISIS are all IGP. They cooperate with BGP, offering AS route messages.

## Exterior Gateway Protocol (**EGP**)

Today, when people say EGP, they usually mean [BGP](#border-gateway-protocol-bgp), which is the **de facto Exterior Gateway Protocol**
on the Internet.

## Border Gateway Protocol (**BGP**)

BGP is the modern, scalable, and flexible protocol used to exchange routes between ASes.

All AS's in the Internet **MUST** connect using BGP-4.

BPG

- Is a path vector algorithm, allowing loops to be detected easily.
- Has a rich and complex interface to let AS's choose a local, private policy.
  - Each AS decides a local policy for traffic engineering, security and any private preferences.

### iBGP (Internal BGP) and eBGP (External BGP)

In eBGP, if one AS receives updates (usually in the form of `To reach x.y.z.w/n, go through [ASaaa,
ASbbb, ASccc, ..., ASxxx]`), it appends itself (say ASyyy) to the list, like `To reach x.y.z.w/n, go
through [ASyyy, ASaaa, ASbbb, ASccc, ..., ASxxx]`.

See more examples in [BGP example]({% link computer-network/bgp-example.md %}) and <https://chatgpt.com/s/t_6850fc64a8948191887e5740c07fe17f>.

In iBGP, one router advertises information it learned from other ASes to all other routers within
the same AS.

Rules routers follow in iBGP:
- iBGP routers do NOT advertise routes learned from one iBGP peer to another iBGP peer to prevent loops.
- Therefore, all iBGP routers must be fully meshed (each peer connected to every other peer), OR use **route reflectors** or **confederations** to scale.

### Four types of messages in BGP

- Open: Establish a BGP session.
- Keep-Alive: Handshake at regular intervals.
- Notification: Shuts down a peering session.
- Update: _Announcing_ new routes or _withdrawing_ previously announced routes.

> RIP is built on top of UDP:520.
>
> OSPF is built on top of IP:89.
>
> BGP is built on top of TCP:179.
{: .prompt-tip }
