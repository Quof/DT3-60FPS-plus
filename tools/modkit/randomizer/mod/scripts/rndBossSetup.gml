//Randomizer: the boss gallery's setup for a fight of boss type argument0 (oBossGalleryDoor's user event 0: its
//currentBoss and bossTrack, for the boss room's code to make the boss), for rndBossStart and rndBossNextLink. The
//setup also puts in the character the gallery's fight is for (Jerry for Hyrule's and Mega Man's bosses, Claire for
//Castlevania's and Metroid's, and so on): in a Randomizer game, where swapping characters works in every fight
//(rndAbilApply), the player goes in as who they are. A fight the gallery has another character for (Hexor's: Jeremy's
//mech) has that one
var d,tChar;
tChar=global.activeCharacter
d=instance_create(0,0,oBossGalleryDoor)
d.type=argument0
with (d) {event_user(0)}
with (d) {instance_destroy()}
if tChar<2 and global.activeCharacter<2 and global.activeCharacter!=tChar and instance_exists(oPlayer1) {charSwitcher(tChar)}
