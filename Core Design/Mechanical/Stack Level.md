When a Fateline is seeded, its Stack Level is 0.
When a player stacks a Fate onto a seeded Fateline, that Fateline's Stack Level increases by 1.
## Variable Fates
When a fate effect is written with stack level formatted as `Stack Lv 0 / 1 / 2`, trigger the effect using the amount from the corresponding amount listed under the `X / X / X` formatted text of the effect.
## Layered Fates
When [[Fateline Activation|activating a fateline]] with separate effects per stack level listed (*ie.* not in `Stack Lv 0 / 1 / 2 `format), trigger the effects of each listed stack level equal or lower than the activation in order.

For example if [[Blink]] is activated at stack level 1, the effect should trigger as if it reads with both effects combined:
1. > Activate a [[Fate Cards|fate]] that was [[Fate Stacking|stacked]] into a [[Fatelines|fateline]] as if it were [[Fate Seeding|seeded]] into its own fateline.
2. > That card remains stacked in its [[Fatelines|fateline]].

>[!success] ...where the full effect would trigger as:
> Activate a [[Fate Cards|fate]] that was [[Fate Stacking|stacked]] into a [[Fatelines|fateline]] as if it were [[Fate Seeding|seeded]] into its own fateline. That card remains stacked in its [[Fatelines|fateline]].

## Fixed Fates
Some fates do not list a stack level; these are fixed fates.
>[!success] Still stackable!
>Fixed fates can still be stacked into (perhaps to trigger or set up something else), despite their activation effect being unchanged whether stacked or not. 