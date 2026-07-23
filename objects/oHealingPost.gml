#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0.2
sizeMod=0
distSize=0
bSizeUp=false
effectDelay=0
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[3]=1 and global.gamePaused=false
{
  oPlayer1.life=oPlayer1.maxLife
  global.pLife=global.pMaxLife

  var tEquipA;
  tEquipA=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=20
    {
      tEquipA=15
      break;
    }
  }
  global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
  global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-tEquipA
  global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
  global.hudMega_BusterEn[0]=32
  global.hudMega_ShotIceEn[0]=32
  global.hudMega_GravityEn[0]=32
  global.hudSamus_CannonEn[0]=0
  global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
  global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]

  playSound(global.snd_HealingPlant,0,1,1)
  var tEffect;
  tEffect=instance_create(oPlayer1.x,oPlayer1.y-(oPlayer1.sprite_height/2),oEffect)
  tEffect.sprite_index=sHeal
  tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sHealingPost,-1,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_alpha(0.45)
if bSizeUp=false
{
  sizeMod-=0.08
  if sizeMod<=-2
    bSizeUp=true
}
else
{
  sizeMod+=0.08
  if sizeMod>=6
    bSizeUp=false
}
distSize=-point_distance(oPlayer1.x,oPlayer1.y,x,y)/16
if distSize<-16
  distSize=-16
draw_set_blend_mode(bm_add)
draw_circle_color(x,y-(40*image_yscale),28+sizeMod+distSize,make_color_rgb(72,248,64),c_black,false)
draw_set_blend_mode(bm_normal)
if global.gamePaused=false
{
  if effectDelay=0
  {
    var tFFScl,ranX,ranY,tEffect;
    tFFScl=random(0.15)
    ranX=x-(sprite_width/2)+random(14)
    ranY=y-(sprite_height)+random(sprite_height/2)

    tEffect=instance_create(ranX,ranY,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1; tEffect.image_alpha=0.3
    tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl; tEffect.direction=random(360)
    tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01; tEffect.fadeSpd=0.005
    tEffect.image_blend=make_color_rgb(67+random(10),243+random(10),59+random(10))
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0

    effectDelay=10+round(random(10))
  }
  else
    effectDelay-=1
}
