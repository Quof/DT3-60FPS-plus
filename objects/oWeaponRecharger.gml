#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
tEffect=instance_create(x-12+random(24),y-random(12),oEffect)
if random(4)>2 {tEffect.sprite_index=sMMshotgunIceEffect}
else {tEffect.sprite_index=sBelmontWepEffect}
tEffect.image_speed=0.2+random(0.1); tEffect.ySpd=-1.5-random(3)
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0

if oGame.time mod 2=0
{
  if image_alpha=0.3
    image_alpha=0.15
  else
    image_alpha=0.3
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: rechargeRate
if global.gamePaused=false and oGame.time mod rechargeRate=0
{
  if global.activeCharacter=0
  {
    if global.activeAbility[0]=1
    {
      if global.hudLink_Arrows[0]<global.hudLink_Arrows[1]
        global.hudLink_Arrows[0]+=1
      if global.hudLink_BombEn[0]<150-(global.skillTree[1]*15)-oPlayer1.equipValA
      {
        global.hudLink_BombEn[0]+=5
        if global.hudLink_BombEn[0]>150-(global.skillTree[1]*15)
          global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)
      }
    }
    else if global.activeAbility[0]=2
    {
      if global.hudMega_BusterEn[0]<32
        global.hudMega_BusterEn[0]+=1
      if global.hudMega_ShotIceEn[0]<32
        global.hudMega_ShotIceEn[0]+=1
      if global.hudMega_GravityEn[0]<32
        global.hudMega_GravityEn[0]+=1
    }
  }
  else if global.activeCharacter=1
  {
    if global.activeAbility[1]=1
    {
      if global.hudBelmont_WeaponEn[0]<global.hudBelmont_WeaponEn[1]
        global.hudBelmont_WeaponEn[0]+=1
    }
    else if global.activeAbility[1]=2
    {
      if global.hudSamus_Missiles[0]<global.hudSamus_Missiles[1]
        global.hudSamus_Missiles[0]+=1
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
