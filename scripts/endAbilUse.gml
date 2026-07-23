/*
This script is called to end ability use.
argument0: Which ability state to put the character in
argument1: Recovery time after ability is used
argument2: Effect to play, 0 for no effect
argument3: What speed to set the player animation to
use: endAbilUse(state,recTime,effect,animSpd)
*/
var tAbilState, tAbilRecover,tAbilEffect,tAnimSpd,tEffect;
tAbilState=argument0
tAbilRecover=argument1
tAbilEffect=argument2
tAnimSpd=argument3

image_index=0
atkAnimSpd=tAnimSpd
idleTime=0
if tAbilEffect>0
{
  tEffect=instance_create(oPlayer1.x,oPlayer1.y+4,oEffect)
  tEffect.sprite_index=sSpellCast
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
attackState=tAbilState
castRecovering=tAbilRecover
