---
title: "About"
description: "About Guy Taylor"
date: 2018-08-24T17:09:43+01:00
menu: "Main"

hideTitle: true
hideDescription: true

---

<style type="text/css">
    #head-shot-container {
        width: 200px;
        height: 200px;
    }
    #head-shot-container img {
        transition: opacity 1s ease;
    }
    #head-shot {
        opacity: 1;
        z-index: 0;
    }
    #head-shot-hover {
        opacity: 0;
        z-index: 1;
        position: relative;
        top: -200px;
    }
    #head-shot-container:hover #head-shot {
        opacity: 0;
    }
    #head-shot-container:hover #head-shot-hover {
        opacity: 1;
    }
</style>

<div class="media">
    <div id="head-shot-container" class="align-self-start mr-3">
        <img class="rounded-circle" src="head-shot.jpg" alt="Head shot of Guy" id="head-shot">
        <img class="rounded-circle" src="head-shot-hover.png" alt="Cartoon image of Guy" id="head-shot-hover">
    </div>
    <div class="media-body">
        <h5 class="mt-0">Guy Taylor</h5>
        <p>I am a Software Engineer working in Edinburgh who enjoys great coffee, walking in the middle of nowhere and hacking on interesting things.</p>
        <p>In tech I am interested in communications, security and anything that is actually interesting.</p>
    </div>
</div>
