/*
mods change (added): the game's object events that run a mod's version in place of theirs without being cleared first
(object_event_clear takes long for an object many others inherit from: seconds for oDamagableBase). Each starts with a
line that, when global.modEvOvr[its place in the list] is an object (one scrModEvRegister made for a mod's version),
performs that object's same event and ends; while it's -1 (no mod has one) the line does nothing.
tools\modkit\addevoverride.py adds that line to an event and keeps the list here (and checks they agree).
rIntro's creation code calls this before any instance exists, since those events check it every time they run;
scrModInit calls it too, in case.
*/
var i;
global.modEvList="oDamagableBase Collision_oAttackBase,oEnemyBase Collision_oClaireParryWindow,oEProjectileBase Collision_oJMechShield"
global.modEvCount=3
for(i=0;i<global.modEvCount;i+=1) {global.modEvOvr[i]=-1}
