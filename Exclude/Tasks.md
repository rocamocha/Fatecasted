```dataview
table
	length(rows) as COUNT
from
	#character/card 
where
	file.folder != "Templates"
group by
	status as "CHARACTER"
```
```dataview
table
	length(rows) as COUNT
from
	#fate/card 
where
	file.folder != "Templates"
group by
	status as "FATE"
```
---
```dataview
table without id
	file.link as UNINITIALIZED,
	code as "CODE",
	type as "TYPE"

from
	#fate/card or #character/card 

where
	file.folder != "Templates"
	and status = null
```


- [ ] Finish initial `designs` for [[Character Catalog#(0) Fatecasted]] catalog.
- [ ] Finish initial `designs` for [[Character Catalog#(1) Elemental]]
- [ ] Finish initial `designs` for [[Character Catalog#(2) Nature]]
- [ ] Finish initial `designs` for [[Fate Catalog#(0) Saffron]]