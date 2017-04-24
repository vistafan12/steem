---
title: Announcing Steem
author: <a href="https://steemit.com/" target="_blank">SteemIt</a>
---

Summary...

<!--more-->


## Overview
- A brand new BitShares codebase has been rebuilt from the ground up with the following features:

{% assign technologies = (site.features | where: 'lang', page.lang | sort: 'priority') %}
{% for technology in technologies  %}
  - [{{ technology.title }}]({{ technology.url }})
{% endfor %}

--------

