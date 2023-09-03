In MTG, the order of effect resolution is determined by a specific set of rules around a concept known as the stack. The way the stack functions is by resolving the most recent effect *first*, and the initiating effect of the sequence *last*. The stack functions as a way to allow pre-emptive response to something that either party had planned. This is necessary due to the random nature of the draw phase.

Fatecasted makes use of this idea by flipping it on it's head.

Since there is no draw phase and many outcomes are more deliberate, trying to take the same approach would result in the potential for overoptimization by players, and even present analysis paralysis since every action would be a possible response to every other.

We take the opposite idea, where our rules around time try to make it so that pre-emptive responses are also *reactionary* by nature. This is achieved by making time proceed instantly, resolving effects immediately. When effects are triggered "simultaneously" in wording, the order is predetermined and easily tracked.

> [!caution] A bigger difference than you think...
> This means that common sense cards in stack-based systems need to be modified to fit the timing method.
> 
> > [!failure] It makes sense...
> > For example, an instant card in MTG that allowed you to keep a creature alive by tacking on some toughness as a response to a burn spell works because the toughness is applied before the damage, meaning that the burn spell wasn't resolved immediately.
> 
> > [!success] ...until it doesn't.
> > In Fatecasted, a protection spell worded like this makes no sense. Considering how [[Character Cards#Break]] functions, the way we achieve a pre-emptive decision like this by having the effect be to Unbreak the character immediately after being broken, but the only place this card is playable is either when you are the initiator, or you have set it up on an earlier turn.

## The Edge of Fate
The only place where immediate resolution could potentially tripped up on is when a Fateline is triggered as an additional outcome from using an ability. When a Fateline is triggered because an ability was used as a basic action, treat it as if the Fateline effect were written into the ability.

> [!question] Is this an edge case?
## Simultaneous Trigger
When one or more cards have identical passive triggers and are each triggered by a single action or effect, resolve them in this order:

1. Passive triggers from Character Cards, going left to right.
2. Passive triggers from Fatelines, in order of the player's choosing.
   
Start with the initiator first for both steps, then continue in turn order.


