---
permalink: /documentation/
layout: index_doc
title: Documentation
redirect_from:

---

# User Documentation

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

<br/>
<br/>

# Technical Documentation

-----

{% assign documentation = (site.documentation | where: 'lang', page.lang | sort: 'priority') %}
{% for doc in documentation  %}
<div class="row tech-toc">

  <div class="col-md-10 col-md-offset-1">
   <h3 class="tech-title"><a href="{{ doc.url }}">{{ doc.title }}</a> - {{ doc.subtitle }}</h3>

    {{ doc.summary }}
  </div>

</div>
{% endfor %}
