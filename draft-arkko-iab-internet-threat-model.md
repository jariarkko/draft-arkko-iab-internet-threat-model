---
title: Changes in the Internet Threat Model
abbrev: Internet Threat Model
docname: draft-arkko-iab-internet-threat-model
updates: RFC3552, RFC7258
date:
category: info

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
  RFC1192:
  RFC1958:
  RFC3935: 
  RFC3552:
  RFC6973:
  RFC7258:
  BCP188:
  I-D.nottingham-for-the-users:

--- abstract

blaa blaa tbd

--- middle

# Introduction {#introduction}

Communications security has been at the center of many security improvements in the Internet. The goal has been to ensure that communications are protected against outside observers and attackers. At the IETF, this apporach has been formalized in BCP 72 {{RFC3552}}, which defined the Internet threat model in 2003.

The purpose of a threat model is to outline what threats exist in order to assist the protocol designer. But RFC 3552 also ruled some threats to be in scope and of primary interest, and some threats out of scope {{RFC3552}}:

   The Internet environment has a fairly well understood threat model.
   In general, we assume that the end-systems engaging in a protocol
   exchange have not themselves been compromised.  Protecting against an
   attack when one of the end-systems has been compromised is
   extraordinarily difficult.  It is, however, possible to design
   protocols which minimize the extent of the damage done under these
   circumstances.

   By contrast, we assume that the attacker has nearly complete control
   of the communications channel over which the end-systems communicate.
   This means that the attacker can read any PDU (Protocol Data Unit) on
   the network and undetectably remove, change, or inject forged packets
   onto the wire. 

However, the communications-security -only threat model is becoming outdated. This is due to three factors:

* Advances in protecting most of our communications with strong cryptographic means. And where this is not true, there are many projects working on protecting the rest.

* Adversaries increasing their pressure against other means, from compromising devics to legal coercion of centralized endpoints in conversations.

* New adversaries and risks have arisen, e.g., due to creation of large centralized information sources

In short, attacks are migrating towards the currently easier targets, which no longer necessarily includes direct attacks on traffic flows. In addition, an organized, traded and profitable economy has arisen both from the "surveillance economy" part of the Internet ecosystem and actual surveillance activities.

This memo suggests that the existing threat model, while important and still valid, is no longer alone sufficient to cater for the pressing security issues in the Internet. For instance, while it continues to be very important to protect Internet communications against outsiders, it is also necessary to protect the communications against endpoints that are compromised, malicous, or whose interests simply do not align with the interests of the users. There are many trade-offs in the Internet around what information is revealed to whom. In many cases users may make choices according to their preferences. In other cases the Internet infrastructure or protocols lead to particular choices. It is imperative that IETF and others developing technology for the infrastructure recognise the dangers, and take measures to ensure that non-communications security threats are minimized.

The rest of this memo is organized as follows. {{commsec}} and {{beyondcommsec}} outline the situation with respect to communications security or beyond it. {{reale2e}} discusses how the author believes the Internet threat model should evolve, and what types of threats should be seen as critical ones and in-scope. {{guidelines}} will also discuss high-level guidance to addressing these threats. Finally, {{otherwork}} highlights other discussions in this problem space and {{concl}} draws some conclusions for next steps.

# Improvements in Communications Security {#commsec}

# Issues in Security Beyond Communications Security {#beyondcommsec}

* Advances in protecting most of our communications with strong cryptographic means. And where this is not true, there are many projects working on protecting the rest.

* Adversaries increasing their pressure against other means (devices, endpoint coercion, surveillance/hacking the endanpoints, legal)
New adversaries and risks have arisen, e.g., due to creation of large centralized information sources
We need a new model.



# The Real End-to-end Principle {#reale2e}

## Guidelines {#guidelines}

# Other Work {#otherwork}

# Conclusions {#concl}

# Acknowledgements

The author would like to thank John Mattsson, Mirja Kuehlewind, Alissa Cooper, Stephen Farrell, Eric Rescorla, Simone Ferlin, Kathleen Moriarty, and the IAB for interesting discussions in this problem space.
