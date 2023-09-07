```dataview
list
	length(rows)
from
	#character/card
where
	file.folder != "Templates"
group by
	status
```
# ![[Production Status#Pending]]
```dataview
table without id
	file.link as PENDING,
	code as "CODE",
	type as "TYPE"

from
	#character/card

where
	file.folder != "Templates"
	and status = "Pending"

sort
	code ascending
```

---
# ![[Production Status#Testing]]
```dataview
table without id
	file.link as TESTING,
	code as CODE,
	type as TYPE

from
	#character/card

where
	file.folder != "Templates"
	and status = "Testing"
```

---
# ![[Production Status#Marked for Revision]]
```dataview
table without id
	file.link as "MARKED FOR REVISION",
	code as CODE,
	type as TYPE

from
	#character/card

where
	file.folder != "Templates"
	and catalog = "Fatecasted"
	and status = "Revision"
```