/*
normalized gallery change (added): puts in a boss's normalized build (scrNormLoadout) for a gallery fight, after
scrNormState(0) has kept the real one aside. Called by oBossGalleryDoor with the lever (oGalleryLever) on.
Swift Foot (the extra dash invulnerability frame) is never taken away. HP and ammo start full, and the boss rooms'
storeStatus(1) restores to that.
argument0: door type
*/
var tSwift;
tSwift=global.skillTree[23]
if scrNormLoadout(argument0)=0 {scrNormState(1); exit} //no build for this door: the player's own is used
if tSwift>global.skillTree[23] {global.skillTree[23]=tSwift}

with oPlayer1 {maxLife=global.pMaxLife}
scrFullStatRestore()
global.pCurrBreath=global.pBreathMax
storeStatus(0)
