---
layout: archive
title: "Sitemap"
permalink: /sitemap/
author_profile: true
---

{% include base_path %}

{% for link in site.data.navigation.main %}
- [{{ link.title }}]({{ base_path }}{{ link.url }})
{% endfor %}
- [XML sitemap]({{ base_path }}/sitemap.xml)
