---
tags:
  - dataview
---
```dataview
table
	length(rows) as COUNT,
	rows.file.link as CARDS

from
	#character/card
where
	file.folder != "Templates"
	
sort file.frontmatter.type
group by type as TYPE
```