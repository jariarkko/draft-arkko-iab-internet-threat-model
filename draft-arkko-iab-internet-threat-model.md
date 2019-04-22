---
title: Changes in the Internet Threat Model
abbrev: Internet Threat Model
docname: draft-arkko-iab-internet-threat-model
updates: RFC3552, RFC7258
date:
category: bcp

ipr: trust200902
keyword: Internet-Draft

stand_alone: yes
pi: [sortrefs, symrefs]

author:
  -
    ins: J. Arkko
    name: Jari Arkko
    org: Ericsson
    email: jari.arkko@piuha.net

normative:

informative:
  RFC1958:
  RFC3935: 
  RFC3552:
  RFC6797:
  RFC6973:
  RFC7258:
  RFC7469:
  RFC7540:
  RFC7817:
  RFC8446:
  RFC8484:
  RFC8555:
  BCP188:
  I-D.nottingham-for-the-users:
  I-D.ietf-tls-esni:
  I-D.ietf-quic-transport:
  I-D.ietf-httpbis-expect-ct:
  I-D.iab-wire-image:
  Saltzer:
   title: End-To-End Arguments in System Design
   author:
    - ins: J.H. Saltzer
    - ins: D.P.Reed
    - ins: D.D.Clark
   seriesinfo: ACM TOCS, Vol 2, Number 4, November 1984, pp 277-288.
   
--- abstract

Communications security has been at the center of many security improvements in the Internet. The goal has been to ensure that communications are protected against outside observers and attackers. This memo suggests that the existing threat model, while important and still valid, is no longer alone sufficient to cater for the pressing security issues in the Internet. For instance, it is also necessary to protect the communications against endpoints that are compromised, malicous, or whose interests simply do not align with the interests of the users. While such protection is difficult, there are some measures that can be taken.

It is particularly important to ensure that as we continue to develop Internet technology, non-communications security related threats are properly understood. This memo updates RFC 3552 and RFC 7258 to include proper consideration of non-communications security threats.

--- middle

# Introduction {#introduction}

Communications security has been at the center of many security improvements in the Internet. The goal has been to ensure that communications are protected against outside observers and attackers. At the IETF, this approach has been formalized in BCP 72 {{RFC3552}}, which defined the Internet threat model in 2003.

The purpose of a threat model is to outline what threats exist in order to assist the protocol designer. But RFC 3552 also ruled some threats to be in scope and of primary interest, and some threats out of scope {{RFC3552}}:

> The Internet environment has a fairly well understood threat model.
> In general, we assume that the end-systems engaging in a protocol
> exchange have not themselves been compromised.  Protecting against an
> attack when one of the end-systems has been compromised is
> extraordinarily difficult.  It is, however, possible to design
> protocols which minimize the extent of the damage done under these
> circumstances.
> 
> By contrast, we assume that the attacker has nearly complete control
> of the communications channel over which the end-systems communicate.
> This means that the attacker can read any PDU (Protocol Data Unit) on
> the network and undetectably remove, change, or inject forged packets
> onto the wire. 

However, the communications-security -only threat model is becoming outdated. This is due to three factors:

* Advances in protecting most of our communications with strong cryptographic means. (And for things that this is not true yet, there typically are ongoing projects working on protecting them.)

* Adversaries increasing their pressure against other means, from compromising devics to legal coercion of centralized endpoints in conversations.

* New adversaries and risks have arisen, e.g., due to creation of large centralized information sources

In short, attacks are migrating towards the currently easier targets, which no longer necessarily include direct attacks on traffic flows. In addition, information about users and ability to influence, often without their permission, has become a common practice for many Internet services.

This memo suggests that the existing threat model, while important and still valid, is no longer alone sufficient to cater for the pressing security issues in the Internet. For instance, while it continues to be very important to protect Internet communications against outsiders, it is also necessary to protect the communications against endpoints that are compromised, malicous, or whose interests simply do not align with the interests of the users.

Of course, there are many trade-offs in the Internet on who one chooses to interact with and why or how. It is not the role of this memo to dictate those choices. But it is important that we understand the implications of different practices. It is also important that when it comes to basic Internet infrastructure, our technology choices favour minimal exposure towards the non-communications threats.

It is particularly important to ensure that non-communications security related threats are properly understood for any new Internet technology. This memo updates RFC 3552 and RFC 7258 to include proper consideration of non-communications security threats.

The rest of this memo is organized as follows. {{commsec}} and {{beyondcommsec}} outline the situation with respect to communications security or beyond it. {{reale2e}} discusses how the author believes the Internet threat model should evolve, and what types of threats should be seen as critical ones and in-scope. {{guidelines}} will also discuss high-level guidance to addressing these threats.

{{changes3552}} and {{changes7258}} outline the author's suggested changes to RFC 3552 and RFC 7258. Finally, {{otherwork}} highlights other discussions in this problem space and {{concl}} draws some conclusions for next steps.

# Improvements in Communications Security {#commsec}

The fraction of Internet traffic that is cryptographically protected has grown tremendously in the last few years. Several factors have contributed to this change, from Snowden revelations to business reasons and to better available technology such as HTTP/2 {{RFC7540}}, TLS 1.3 {{RFC8446}}, QUIC {{I-D.ietf-quic-transport}}.

In many networks, the majority of traffic has flipped from cleartext to encrypted. Reaching the level of (almost) all traffic being encrypted is now longer unthinkable but rather a likely outcome in a few years.

At the same time, technology developments and policy choices have driven the scope of cryptographic protection from protecting only the pure payload to protecting much of the rest, including far more header and meta-data information than was protected before. For instance, efforts are ongoing in the IETF to assist encrypting transport headers {{I-D.ietf-quic-transport}}, server domain name information in TLS {{I-D.ietf-tls-esni}}, and domain name queries {{RFC8484}}.

The have also been iprovements to ensure that the security protocols that are in use actually have suitable credentials and that those credentials have not been compromised, see for instance, HSTS {{RFC6797}}, HPKP {{RFC7469}}, Expect-CT {{I-D.ietf-httpbis-expect-ct}}, and Let's Encrypt {{RFC8555}}.

This is not to say that all problems in communications security have been resolved -- far from it. But the situation is definitely different from what it was a few years ago. Remaining issues will be and are worked on; the fight between defence and attack will also continue. Communications security will stay at the top of the agenda in any Internet technology development.

# Issues in Security Beyond Communications Security {#beyondcommsec}

There are, however, significant issues beyond communications security in the Internet. To begin with, it is no longer necessarily clear that one can trust all the endpoints. Users may not be in as much control over their own devices as they used to be. Perhaps more obviously, the pattern of communications in today's Internet is almost always via a third party that has at least as much information than the other parties have. For instance, these third parties are typically endpoints for any transport layer security connections. With the exception of some messaging applications, the third parties also see the cleartext communications.

With the growth of trading users' information by many of these third parties, it becomes necessary to take precautions against endpoints that are compromised, malicous, or whose interests simply do not align with the interests of the users.

Specifically, the following issues need attention:

* Security of users' devices and the ability of the user to control their own equipment.

* Coercion of some endpoints to reveal information to authorities or surveillance organizations, sometimes even in an extra-territorial fashion.

* Application design patterns that result in cleartext information passing through a third party or the application owner.

* Network and application architectures that result in a lot of information collected in a (logically) central location.

* Leverage and control points outside the hands of the users or end-user device owners.

For instance, while e-mail transport security {{RFC7817}} has become much more widely distributed in recent years, progress in securing e-mail messages between users has been much slower. This has lead to a situation where e-mail content is considered a critical resource by mail providers who use it for machine learning, advertisement targeting, and other purposes.

 Domain Name System (DNS) shows signs of ageing but due to the legacy of deployed systems, has changed very slowly. Newer technology {{RFC8484}} developed at the IETF enables DNS queries to be performed confidentially, but its deployment is happening mostly in browsers that use global DNS resolver services, such as Cloudflare's 1.1.1.1 or Google's 8.8.8.8. This results in faster evolution and better security for end users.

However, if one steps back and considers the overall security effects of these developments, the resulting effects can be different. While the security of the actual protocol exchanges improves with the introduction of this new technology, at the same time this implies a move from using a worldwide distributed set of DNS resolvers into more centralised global resolvers. While these resolvers are very well maintained (and a great service), they are potentiall high-value targets for pervasive monitoring and Denial-of-Service (DoS) attacks. In 2016, for example, DoS attacks were launched against Dyn, one of the largest DNS providers, leading to some outages. It is difficult to imagine that DNS resolvers wouldn't be a target in many future attacks or pervasive monitoring projects.

Unfortunately, there is little that even large service providers can do to refuse authority-sanctioned pervasive monitoring. As a result it seems that the only reasonable course of defense is to ensure that no such information or control point exists.

# The Real End-to-end Argument {#reale2e}

{{RFC1958}} notes that "end-to-end functions can best be realised by end-to-end protocols":

> The basic argument is that, as a first principle, certain
> required end-to-end functions can only be performed correctly
> by the end-systems themselves. A specific case is that any
> network, however carefully designed, will be subject to
> failures of transmission at some statistically determined rate.
> The best way to cope with this is to accept it, and give
> responsibility for the integrity of communication to the end
> systems. Another specific case is end-to-end security.

The "end-to-end argument" was originally described by Saltzer et al {{Saltzer}}. They said:

> The function in question can completely and correctly be
> implemented only with the knowledge and help of the
> application standing at the endpoints of the communication
> system. Therefore, providing that questioned function as a
> feature of the communication system itself is not possible.

These functional arguments align with other, practical arguments about the evolution of the Internet under the end-to-end model. The endpoints evolve quickly, often with simply having one party change the necessary software on both ends. Whereas waiting for network upgrades would involve potentially a large number of parties from application owners to multiple network operators.

The end-to-end model supports permissionless innovation where new innovation can flourish in the Internet without excessive wait for other parties to act.

But the details matter. What is considered an endpoint? What characteristics of Internet are we trying to optimize? This memo makes the argument that, for security purposes, there is a significant distinction between actual endpoints from a user's interaction perspective (e.g., another user) and from a system perspective (e.g., a third party relaying a message).

This memo proposes the "real end-to-end argument" to guide the development of protocols meant for interaction among two "real ends" as opposed to, say, two endpoints of components in a larger system. For instance, a transport connection between two components of a system is not an end-to-end connection even if it encompasses all the protocol layers up to the application layer. It is not end-to-end, if the information or control function it carries actually extends beyond those components. For instance, just because an e-mail server can read the contents of an e-mail message does not make it a legitimate recipient of the e-mail.

The proposed real end-to-end argument is as follows:

> Real end-to-end functions can best be realised by end-to-end
> protocols. The role and authority of any additional parties
> necessary to carry out a function should match their (sub)function.

For instance, a particular piece of information may be necessary for the actual other endpoint (such as message contents for another user)information . The same piece of information may not be necessary for any additional parties, unless the information had to do with, say, routing information for the message to reach the other user. When information is only needed by the actual other endpoint, it should be protected and be only relayed to the actual other endpoint. Protocol design should ensure that the additional parties do not have access to the information.

Note that it may well be that the easiest design approach is to send all information to a third party and have majority of actual functionality reside in that third party. But this is a case of a clear tradeoff between ease of change by evolving that third party vs. providing reasonable security against misuse of information.

## Guidelines {#guidelines}

As {{RFC3935}} says:

   We embrace technical concepts such as decentralized control, edge-user empowerment and sharing of resources, because those concepts resonate with the core values of the IETF community.

To be more specific, this memo suggests the following guidelines for protocol designers:

1. Information passed to another party in a protocol exchange should be minimized to guard against the potential compromise of that party.

2. Information passed via another party who does not intrinsically need the information to perform its function should be encrypted end-to-end to its intended recipient. This guideline is general, and holds equally for sending TCP/IP packets, TLS connections, or application-layer interactions. As {{I-D.iab-wire-image}} notes, it is a useful design rule to avoid "accidental invariance" (the deployment of on-path devices that over-time start to make assumptions about protocols). However, it is also a necessary security design rule to avoid "accidental disclosure" where information originally thought to be benign and untapped over-time becomes a significant information leak.

3. Any passing of control functions to other parties should be minimized to guard against the potential misuse of those control functions. This applies to both technical (e.g., nodes that assign resources) and process control functions (e.g., the ability to allocate number or develop extensions). Control functions can also become a matter of contest and power struggle, even in cases where their function as such is minimal, as we saw with the IANA transition debates.

4. Protocol and network design should avoid the creation of centralized resources or control points.

# Changes in RFC 3552 {#changes3552}

This memo suggestes that the following additional change be adopted in RFC 3552:

OLD:

> In general, we assume that the end-systems engaging in a protocol
> exchange have not themselves been compromised.  Protecting against an
> attack when one of the end-systems has been compromised is
> extraordinarily difficult.  It is, however, possible to design
> protocols which minimize the extent of the damage done under these
> circumstances.

NEW:

> In general, we assume that the end-system engaging in a protocol
> exchange has not itself been compromised.  Protecting against an
> attack of a protocol implementation itself is extraordinarily
> difficult.  It is, however, possible to design protocols which
> minimize the extent of the damage done when the other parties in
> a protocol become compromised or do not act in the best interests
> the end-system implementing a protocol.

In addition, the following new section should be added for the capabilities required to mount an attack:

NEW:

3.x. Other endpoint compromise

> In this attack, the other endpoints in the protocol become
> compromised. As a result, they can, for instance, misuse any
> information that the end-system implemeting a protocol has sent to the
> compromised endpoint.

# Changes in RFC 7258 {#changes7258}

This memo suggestes that the following additional guideline be adopted in RFC 7258. This new text should be added after the 2nd paragraph in Section 2:

NEW:

> PM attacks include those cases where information collected by a
> legitimate protocol participant is misused for PM purposes. The
> attacks also include those cases where a protocol or network
> architecture results in centralized data storage or control functions
> relating to many users, raising the risk of said misuse.

# Other Work {#otherwork}

To be filled in...

# Conclusions {#concl}

To be filled in...

# Acknowledgements

The author would like to thank John Mattsson, Mirja Kuehlewind, Alissa Cooper, Stephen Farrell, Eric Rescorla, Simone Ferlin, Kathleen Moriarty, Brian Trammell, Mark Nottingham, Christian Huitema, Ted Hardie, and the IAB for interesting discussions in this problem space.
