#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Ice Shot
event_inherited()
image_speed=0

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="ELEMENTAL"

moveTime=0
moveSpd=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  speed=moveSpd
  if type=0 //Fired downward and shatter on ground
  {
    if moveSpd<10 {moveSpd+=0.2}
    if y>=warTarget.yGround
    {
      var tAtk,tDir;
      tDir=75
      for(i=0;i<3;i+=1)
      {
        tAtk=instance_create(x,y,oWMC_IceShotA)
        tAtk.sprite_index=sWarmasterC_IceShot; tAtk.atkPower=atkPower; tAtk.moveSpd=9; tAtk.type=1
        tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=tDir; tAtk.image_angle=tDir
        tAtk.image_xscale=0.75; tAtk.image_yscale=0.75; tAtk.warTarget=warTarget
        tDir+=15
      }
      event_user(0)
    }
  }
  else if type=1 //Broken shard (from type 0) going up and break on ceiling
  {
    if x<=warTarget.xCenter-warTarget.roomSpan or x>=warTarget.xCenter+warTarget.roomSpan
    {
      event_user(0)
    }

    if y<=warTarget.yGround-warTarget.roomHeight
    {
      var tAtk;
      tAtk=instance_create(x,y,oWMC_IceShotA)
      tAtk.sprite_index=sWarmasterC_IceShard; tAtk.atkPower=atkPower; tAtk.moveSpd=3; tAtk.type=2
      tAtk.decayTime=-100; tAtk.damageType="ELEMENTAL"; tAtk.direction=270; tAtk.image_angle=270; tAtk.warTarget=warTarget
      event_user(0)
    }
  }
  else if type=2 //Drop from ceiling
  {
    if moveSpd<6 {moveSpd+=0.1}
    if y>=warTarget.yGround
    {
      event_user(0)
    }
  }
}
else {speed=0}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
playSound(global.snd_Drip,0,0.82,44100)
tEffect=instance_create(x,y,oEffect)
tEffect.sprite_index=sMMchargeComplete; tEffect.image_speed=0.5; tEffect.image_xscale=0.3; tEffect.image_yscale=0.3
tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
instance_destroy()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.15,image_yscale*1.15,image_angle,image_blend,0.4)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale*1.3,image_yscale*1.3,image_angle,image_blend,0.2)
