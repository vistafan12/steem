---
permalink: /getinvolved/
layout: index_tech
title: Get Involved
redirect_from:

---

# Get Involved

There are many ways to get inolved with the Steem community. The Steem community believes everyone should
be recognized for the value they bring to the network. Due to the power of network effect and
[Metcalfe's Law](https://en.wikipedia.org/wiki/Metcalfe%27s_law), the value of Steem is greater than
the sum of individual contributions.

> The whole is greater than the sum of its parts.  [- Aristotle](http://www.goodreads.com/quotes/20103-the-whole-is-greater-than-the-sum-of-its-parts)

Steem pays people who bring *parts* with a stake in the *whole*.

-----

{% assign features = (site.features | where: 'lang', page.lang | sort: 'priority') %}
{% for feature in features  %}
<div class="row tech-toc">

<div class="col-md-offset-0">
  <div class="col-md-2 center tech-toc-img">
    <img class="tech-toc hidden-xs" src="{{ BASE_PATH }}/{{ feature.image }}" />
  </div>
  <div class="col-md-8 ">
   <h3 class="tech-title"><a href="{{ feature.url }}">{{ feature.title }}</a> - {{ feature.subtitle }}</h3>

    {{ feature.summary }}
  </div>
</div>
</div>
{% endfor %}
