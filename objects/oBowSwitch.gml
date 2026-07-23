#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_yscale=0.1
myProg=0
progTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if myProg=0
  {
    image_yscale+=0.1
    if image_yscale=1 {myProg=1}
  }
  else if myProg=2
  {
    progTime+=1
    if progTime=1
    {
      playSound(global.snd_RBSwitch,0,1,1)
      image_index=1
    }
    else if progTime=10
    {
      playSound(global.snd_Fireball,0,0.99,1)
      if x<oBowser.xCenter
      {
        for(i=0;i<10;i+=1)
        {
          var tNewAttack;
          tNewAttack=instance_create(oBowser.xCenter+(i*16),0,oPassBullet)
          tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=3+(i*0.1)
          tNewAttack.direction=270; tNewAttack.decayTime=-100; tNewAttack.damageType="ELEMENTAL"
        }
      }
      else
      {
        for(i=0;i<10;i+=1)
        {
          var tNewAttack;
          tNewAttack=instance_create(oBowser.xCenter-(i*16),0,oPassBullet)
          tNewAttack.sprite_index=sBowserFire1; tNewAttack.atkPower=3; tNewAttack.bulletSpeed=3+(i*0.1)
          tNewAttack.direction=270; tNewAttack.decayTime=-100; tNewAttack.damageType="ELEMENTAL"
        }
      }
    }
    else if progTime=30
    {
      var tEffect,tDir;
      tDir=0
      for(i=0;i<8;i+=1)
      {
        tEffect=instance_create(x,bbox_bottom-4,oEffect)
        tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5; tEffect.direction=tDir; tEffect.image_angle=tDir
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        tDir+=360/8
      }
      instance_destroy()
    }
  }
}
