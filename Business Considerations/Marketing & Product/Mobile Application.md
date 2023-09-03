A mobile application to facilitate in-person gameplay will be available to players. The functions of this mobile app will include:
1. Tracking turn phases.
2. Providing roll results.
3. Optional timer for turn phases.
4. Multi-player verification for tooling.
## Multi-player verification for tooling.
Players should feel that they are allowed to keep their devices private and near to them. Fatecasted will not require players to put their phone in the middle of the play area or to be shared. To facilitate this, players playing a game in person will be able to connect to each other in a digital instance online that interacts with a server using information provided and verified by *all* players.

For each input to the server, it must be verified by *every* player to be parsed and processed, and there will be the ability to undo processes chronologically. This will ensure players cannot cheat (whether intentionally or not) by doing things such as rolling too many times, or inputting wrong information.
>[!caution] Undo list data storage...
>The list for processes to undo should live in a pre-allocated storage file on each user's device, not the server. This will save required memory usage for the server. This will also allow players to save logs of game events when using the mobile app to assist play.
>
>>[!danger] At this time, there will be no plans to process inputs automatically and update the representation on screen, as that would basically be trying to develop a digital version of the game, which is too big of an undertaking. It's main purpose is to provide information such as  rules, card database, et cetera; as well as offer tools to make in-person play smoother.