```dataview
list
	length(rows)
from
	#fate/card
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
	#fate/card

where
	file.folder != "Templates"
	and status = "Pending"

sort
	file.link
```

---
# ![[Production Status#Testing]]
```dataview
table without id
	file.link as TESTING,
	code as CODE,
	type as TYPE

from
	#fate/card

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
	#fate/card

where
	file.folder != "Templates"
	and status = "Revision"
```