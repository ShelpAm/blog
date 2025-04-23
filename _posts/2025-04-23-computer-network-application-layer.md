---
categories: notes-computer-network
math: true
---

## DNS (Domain Name System)

DNS uses port 53 to communicate, and can be implemented by both TCP and UDP. (Usaully UDP)

!! Use prompt here.

Except when

- Secondary name server syncs with primary servers.
- The result returned from server is too long (, and thus truncated to 512 bytes, usaully),
  - Now some clients signals that it can receive more than 512 B data,

it uses TCP.

DNS resolvers are classified by a variety of query methods, such as _recursive_, _non-recursive_, and _iterative_.

- Local machine queries local name server by recursive query.
- Local name server queries authoritative name server by iterative query.

It works as shown below.

![dns-system](/assets/images/dns-system.png)

### DNS Resource Record (RR)

Format: \<`name`, `TTL`, `class`, `type`, `value`\>

where

- `name` is domain name.
- `TTL` is time to live.
- `class` is internet class, whose value can only be 0b0001 (Internet).
- `type` is the type of RR, which has following possible values:
  - A - Address
  - NS - Name server
  - CNAME - Canonical name (alias of name)
  - MX - Mail server name
  - PTR - Pointer (for reverse queries)
  - SOA - Gerneral info of DNS server, which is usaully the first record among servers
- `value` is the value of the record.

## HTTP (HyperText Transfer Protocol)

HTTP is stateless. It didn't remember what it did.

### Versions

- HTTP 1.0, no pipeline，非持续连接
  - Disconnects after sending/receiving data.
- HTTP 1.1, features pipeline，持续连接
  - Can send subsequent request without receiving acknowledgements from the server.
- HTTP 2.0, features multiplexing of requests and responses to avoid some of the head-of-line
  blocking problem (队头阻塞) in HTTP 1 (even when HTTP pipelining is used).
- HTTP 3.0, switches to [QUIC](https://en.wikipedia.org/wiki/QUIC).

### Format

Request

```
Method URL Version\<CRLF\>
Header field name 1: value 1\<CRLF\>
...
Header field name n: value n\<CRLF\>
\<CRLF\>
Body
```

Response

TODO


## FTP (File Transfer Protocol)

FTP has two modes

- Active mode
  - In which server listens on port 21 for control connection
  - 


- Passive mode
  - Behavior
