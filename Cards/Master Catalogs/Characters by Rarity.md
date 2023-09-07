---
tags:
  - dataview
---
```dataview
list without id
	"Rarity " + key +": " +length(rows)
group by file.frontmatter.rarity
```