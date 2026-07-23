#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
viscidTop=1
makeActive()
setCollisionBounds(1,0,sprite_width,sprite_height)
baseY=y
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//if the character is standing on the switch
if global.gamePaused=false
{
  if (ownerID1.y=ownerID1.baseY+16) or (ownerID2.y=ownerID2.baseY+16)
  {
    if y>baseY-64 {yVel=-1}
    else {yVel=0}
  }
  else
  {
    if y<baseY {yVel=1}
    else {yVel=0}
  }

  if yVel!=0
  {
    if oGame.time mod 2=0
    {
      var tEffect,efRanScl;
      efRanScl=random(0.3)
      tEffect=instance_create(x-8+random(32),baseY+5+random(3),oEffect)
      tEffect.sprite_index=sZeldaEnemyDie; tEffect.image_xscale=0.7+efRanScl; tEffect.image_yscale=0.7+efRanScl
      tEffect.image_speed=0.3+random(0.3); tEffect.image_alpha=0.7
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
  }
}
