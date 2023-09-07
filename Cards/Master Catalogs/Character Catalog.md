---
tags:
  - dataview
---
![[Illegal Card Codes]]
# (0) Fatecasted
The ***Fatecasted*** character set is the quintessential character set for the game; the classic cards that define the game.

>[!caution] A Proper Baseline
>This set should be treated as the baseline for ease and simplicity when trying to learn and play the game, with concepts only having around two to three important layers with any pair in the set, which are only *enhanced* (not transformed) by any cards from [[Fate Catalog#(0) Saffron]].

```dataview
table
	code as C,
	rarity as R,
	type as T,
	breakpoint as BP
	
where file.folder = "Cards/Character Series/C0. FateCasted"
```
# (1) Elemental
>[!idea] Reactivity...
>The elements set focuses on mechanics that interact with each other in reactive ways, with special fate cards and abilities that require elemental resources to gain additional benefits.

>[!caution] Intended Synergy
> This set should synergize well with [[Fate Catalog#(1) Resonance]]
```dataview
table
	code as C,
	rarity as R,
	type as T,
	breakpoint as BP
	
where file.folder = "Cards/Character Series/C1. Elemental"
```

# (2) Nature
>[!idea] As in human nature! This set should focus on options that bring out strategies that rely on certain tendencies when it comes to decision making.

```dataview
table
	code as C,
	rarity as R,
	type as T,
	breakpoint as BP
	
where file.folder = "Cards/Character Series/C2. Nature"
```
