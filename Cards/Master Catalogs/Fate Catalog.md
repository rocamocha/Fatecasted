---
tags:
  - dataview
---
![[Illegal Card Codes]]
# (0) Saffron
> [!idea] Fun fact...
> The Saffron series is named after the character from "One Step from Eden." She is the versatile "balanced" character of the game for which the baseline experience is set. The Saffron series should achieve the same for [[Character Catalog#(0) Fatecasted]].

```dataview
table
	file.frontmatter.code as C,
	file.frontmatter.type as T

where
	file.folder = "Cards/Fate Series/F0. Saffron"
```
# (1) Resonance
>[!caution] Intended Synergy
> This set should synergize well with [[Character Catalog#(1) Elemental]]
```dataview
table
	file.frontmatter.code as C,
	file.frontmatter.type as T

where
	file.folder = "Cards/Fate Series/F1. Resonance"
```