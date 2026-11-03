---
layout: page
title: Mutual Aid Tinctures
feature_image: "/assets/images/webp/leaves1.webp"
tinctures:
  - name: Immune boost
    herbs: Echinacea and elderberry
    alcohol: true
    dose: Take 2-4 dropperfuls 6x/day at first sign of sickness
  - name: Calm heart
    herbs: Tulsi, skullcap, rose
    alcohol: false
    dose: 1-2 dropperfuls as needed
  - name: Calm tummy
    herbs: Tulsi, skullcap, chamomile
    alcohol: false
    dose: 1-2 dropperfuls as needed
  - name: Hop to bed
    herbs: Hops, lemon balm, valerian, skullcap
    alcohol: true
    dose: 1-2 dropperfuls as needed
  - name: Into the flow
    herbs: Blue vervain, skullcap, lavender, milky oats, rose
    alcohol: true
    dose: 1-2 dropperfuls as needed to promote calm
  - name: Bronchial support
    herbs: White pine, horehound, mullein flower, thyme, elecampane
    alcohol: true
    dose: Take 1 dropperful 4x/day
  - name: Long-term immune support
    herbs: Astragalus, codonopsis, schisandra, eleuthero, cinnamon, licorice, prickly ash
    alcohol: true
    dose: Take 5 dropperfuls per day
    note: Some med interactions
  - name: Mental clarity
    herbs: Gotu kola, tulsi, ginkgo, bacopa, rosemary
    alcohol: true
    dose: Take 2-3 dropperfuls as needed
---

From our Herb Blending 4 Palestine group - email mo (at) mokatzchristy.com for more info!

Know a community who could use this medicine? Reach out to me and we can distribute!

<a class="button" href="https://forms.gle/LtuKSn3ycRv4LSSx9">Sign up for the next blending session</a>

## Currently Available Tinctures

_The alcohol contained in the tinctures is very minimal - approx the alcohol in a ripe banana!_

<div class="tincture-grid">
{% for t in page.tinctures %}
  <div class="tincture">
    <h4>{{ t.name }}</h4>
    <p class="tincture__herbs">{{ t.herbs }}</p>
    <span class="tincture__tag">{% if t.alcohol %}Contains alcohol{% else %}Alcohol free{% endif %}</span>
    <p>{{ t.dose }}</p>
    {% if t.note %}<p class="tincture__note">{{ t.note }}</p>{% endif %}
  </div>
{% endfor %}
</div>

## Single Extracts

**Glycerites:** Lemon balm

**Tinctures:** Maca, kava, clove, peppermint
