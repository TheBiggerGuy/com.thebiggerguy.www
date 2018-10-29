---
title: "Audible"
description: "Audible file format"
date: 2018-08-27T14:08:22+01:00

logoicon: "fas fa-headphones"

---

## TagLib\#

TagLib\# is a media format meta data parser. It is wired into audio players to read artist, album, etc. to organise users audio and video collections.

I added support for reading the Audible AA file format meta data. This allowed the Banshee music player to manage audio books on mobile MP3 players. This format had never previously been documented so it required reverse engineering the binary file format.

* Project Homepage: https://github.com/mono/taglib-sharp
* Bug Report: https://bugzilla.gnome.org/show_bug.cgi?id=601543
* Upstream Commit: https://github.com/mono/taglib-sharp/commit/3be76517089d5f13f57d3b0d9032f206618243de
