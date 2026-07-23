#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=true
bCanDealDamage=0

//Enemy base statistics
eName="Hanging Bomb"
eLevel=34
maxLife=40
life=maxLife
pointWorth=30
atkPower=12
baseItemChance=40

jeremyText="This thing does nothing but hang from these rails. However, they will blow up platforms along that rail so you'd better do something about them before the platform reaches these. The platform gets 2 chances from what I'm seeing."
chaoText="This sprite comes from the Knuckles Chaotix game on the Sega Genesis."
devText="While filling up the world with a few more side areas, a few new enemies made it in like this one that filled a specific role for these areas."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if x<oPlayer1.x {image_xscale=1}
  else {image_xscale=-1}

  if instance_exists(oPlatformRailA)
  {
    if point_distance(x,y,oPlatformRailA.x,oPlatformRailA.y)<=24
    {
      playSound(global.snd_MorphBomb,0,1,1)
      platfromToFuckUp=instance_nearest(x,y,oPlatformRailA) //Typo intentional
      with platfromToFuckUp
      {
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sBombExplosion; tEffect.image_speed=0.33; tEffect.image_xscale=2; tEffect.image_yscale=1.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        myHP-=1
      }
      tEffect=instance_create(x-(12*image_xscale),y+18,oEffect)
      tEffect.sprite_index=sRobotExplosion; tEffect.image_speed=0.33
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
  }
  enemyStepEvent()
}
