---
tags:
  - dataview
---
```dataview
table
	length(rows) as COUNT

from
	#fate/card
where
	file.folder != "Templates"
	
sort type
group by type as TYPE
```

```dataview
table without id
	file.link as "[[Fixed]]",
	code as CODE
from
	#fate/card 
where
	file.frontmatter.type = "[[Fixed]]"
```

```dataview
table without id
	file.link as "[[Layered]]",
	code as CODE
from
	#fate/card 
where
	file.frontmatter.type = "[[Layered]]"
```

```dataview
table without id
	file.link as "[[Variable]]",
	code as CODE
from
	#fate/card 
where
	file.frontmatter.type = "[[Variable]]"
```