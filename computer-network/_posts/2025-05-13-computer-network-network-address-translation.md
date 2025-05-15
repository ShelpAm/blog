---
---

## Introduction

Network address translation (NAT) is a gate between local network and the Internet. It
_translates/rewrites_ _internal_ IP address to _external_ IP address

When packet is sent from internal to external, the NAT will generate (or query) a mapping, from
`<internal IP address, port>` to `<external IP address, port>` pair. And after that, external packet
to this `<external IP address, port>` pair would be translated to `<internal IP address, port>`
pair. So it's a bidirectional mapping.

Advantages:

- Secure. It turn internal IP address to a single public IP address, making attackers harder to open
  connection to your machine.

## Types

### Full Cone NAT

- Least restrictive. Any packet to NAT `<external IP address, port>` pair will be translated to
  `<internal IP address, port>` pair, regardless of what the source address and source port are.

### Restricted Cone NAT

- Only packets from an external IP address that the internal host has previously contacted will be
  translated and delivered to the internal host.

### Port Restricted NAT

- Filters both source address and source port–Only those both matched could be translated.

### Symmetric NAT

- Not only by definition port restricted, different destination, even with the same IP address,
  means a completely different mapping.

## Hairpinning

Hairpinning refers to a situation where two devices behind the same NAT communicate with each other
using their public IP addresses. This is tricky and specified in RFC.

![hairpinning example](/assets/images/hairpinning-example.png)
_A hairpinning example_

## Implications

### No incomming connections

**Solutions**

- Connection Reversal

  - Background:

    - There are A on public Internet and B behind a NAT. And we say A wants to open a connection to B.

  - Approach:

    1. B connects to a rendezvous server.
    2. A contact that server through which notify B that A wants connection to it.
    3. Then B initiate a connection to A, as reverse connection.

- Using relays

  - Background:

    - Now both A and B are behind NATs.

  - Approach:

    - Just that both A and B connect to a public _relay_ server R, and R forward every packet between
    A and B, everything is done.

- Using hole punching

  - Background:

    - Similarly, both A and B are behind NATs.

  - Approach:

    1. A and B open connections to a public server S, and S knows their NAT external IP address.
    2. So that A can initiate new connection to B's public address and port pair, vice versa.

  - Applicable scenario:

    Full Cone NAT, Restricted Cone NAT, Port Restricted NAT, but not for Symmetric NAT.

    - Why they are OK?
      - The answer is that, by simultaneous-open mode in TCP. See [RFC 5382 Page 6][rfc5382] REQ-2,
        which talks about this bahavior in NAT in detail.

[rfc5382]: https://www.rfc-editor.org/rfc/rfc5382#page-6

  > Be Cautious!
  > The following may contain wrong information, as they came from AI.
  {: .prompt-danger }

  > You might have a problem here, as I did. Why can't symmetric NAT communicate with each other?
  >
  > Okay, things go like this:
  >
  > A and B each opens a connection to rendezvous server, and expose their NAT public address. After
  > this, one can open another connection to the other, though it would be blocked by the other side
  > due to the Symmetric NAT policy, to grant another permission, with `<peer's IP address, port>`
  > pair.
  >
  > Up to now you may think: Everything is ideal for the last communication step. But think it
  > deeper, though they did guessed the peer's correct _external port_, say A guessed B's permitted
  > address port pair, `x:y` for example. Then A could use this port to send datagram to B.
  > Everything seems to be fine, right?
  >
  > But couuld A's external port be `y`? This is the first problem.
  >
  > Okay, I give up. If A's external port is `y`, is the problem fixed? I think this is fine! Who
  > can help me... :(
  {: .prompt-tip }

### No new transport!

NAT need to know the information from transport layer. So if you want to write your own transport
protocol, NAT will discard it. It doesn't know your format.

### NAT Debate

- Tremendously useful
  - Reuse addresses 
  - Security (not openning connections can be good!)
- Tremendously painful
  - Large complication to application development (especially before the behavior hasn't been
    standardized)
  - Speak Freely (pre-Skype VoIP)

### The new hourglass

NAT changed everything. It makes transport layer tightly coupled to now being used. We can deploy no
more other new transport layer protocol. Layer 3 is restricted to IP; Layer 4 is restricted to
TCP, UDP, ICMP and cannot be changed. And it looks like the following figure:

![the-new-hourglass](/assets/images/nat-results-new-hourglass.png)

## NAT operation details

See more in RFCs.

You can also view [Introduction to Computer Networking (CS 144)][NAT learning video]. It analyzes
some requirements in certain RFCs. 

[NAT learning video]: https://www.bilibili.com/video/BV1wt41167iN/?p=71&share_source=copy_web&vd_source=9d56f184caaa09e951606e4800ea1121

> Generally, reading RFCs is good. Go for it!
{: .prompt-tip }
