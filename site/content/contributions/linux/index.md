---
title: "Linux"
description: "Linux and system level libraries"
date: 2018-08-27T14:08:22+01:00

logoicon: "fab fa-linux"

---

## Realtek Driver

This is an out-of-tree driver for the rtl8812AU_8821AU Realtek WiFi chip.

* Commit: https://github.com/abperiasamy/rtl8812AU_8821AU_linux/commit/276dcb9626c1c5a2a5566da46e8758b1bcab2788
* Project Homepage: https://github.com/abperiasamy/rtl8812AU_8821AU_linux

## libATASmart

This is a library to read hard disk [S.M.A.R.T](http://en.wikipedia.org/wiki/S.M.A.R.T.) data. I added support to read two additional pieces of information.

* Ubuntu Bug: https://bugs.launchpad.net/ubuntu/+source/gnome-disk-utility/+bug/521864]
* Upstream Commit: http://git.0pointer.net/libatasmart.git/commit/?id=2cc510293bd7dd120e1f5a24747924ec3630aba3
* Project Homepage: http://0pointer.de/blog/projects/being-smart.html

## S.A.N.E.

This is the primary Linux scanner software stack. I enabled support for the Cannon DR-F120 scanner which required tracing the USB protocol and working out the new image format.

* Ubuntu Bug: https://bugs.launchpad.net/ubuntu/+source/sane-backends/+bug/1540706
* Upstream Bug: <s>[https://alioth.debian.org/tracker/](https://alioth.debian.org/tracker/?func=detail&atid=410366&aid=315298&group_id=30186)</s> <small>(Upstream bug-tracker moved to GitLab)</small>
* Upstream Commit: https://gitlab.com/sane-project/backends/commit/e6b6ad9d4847e86aed8be0837a19bfada881f52d

## Codecgraph

Codecgraph is a tool to aid development of [HDA](https://en.m.wikipedia.org/wiki/Intel_High_Definition_Audio) audio systems.

I added the Asus P6T motherboard.

* Project Homepage: http://helllabs.org/codecgraph/
* Upstream Commit: https://github.com/cmatsuoka/codecgraph/commit/8358e2c81490b88b880af659fb4d3a312ec3e2b5
