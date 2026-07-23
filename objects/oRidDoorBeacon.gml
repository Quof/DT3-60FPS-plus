#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanDealDamage=false

//Enemy base statistics
eName="Door Beacon"
eLevel=20
maxLife=500
life=maxLife
pointWorth=10
resType[0]=2
resType[1]=2
affiliation=5
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0

anim=0
shotTime=10

if room=rSamus5_Lv1_D {jeremyText="This seems to be linked to that barrier blocking the Morph Ball upgrade. Destroying both of these should bring the barrier down."}
else {jeremyText="You just need to destroy this to open up a nearby door."}
chaoText="Ridley must have known you would come here, which probably means Hex has something to do with this."
devText="Having an encounter with Ridley early on, I felt, would raise the tension in the Gate. Hopefully it does what it's supposed to do."
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0 and bActive=1
  {
    anim+=1
    if anim=4 {image_index=1}
    else if anim=8 {image_index=2}
    else if anim=12 {image_index=3}
    else if anim=16 {image_index=2}
    else if anim=20 {image_index=1}
    else if anim=24 {image_index=0; anim=0}

    if room=rSamus5_Lv1_F and bActive=1 //Shoot on final Ridley chase map
    {
      if checkScreenArea(x,y,32)=1
      {
        shotTime+=1
        if shotTime=75
        {
          var tEffect;
          tEffect=instance_create(x+8,y+8,oEffect)
          tEffect.sprite_index=sMMchargeComplete; tEffect.depth=7
          tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        }
        else if shotTime=100
        {
          var tNewAttack,tDir;
          tDir=point_direction(x+8,y+8,oPlayer1.x,oPlayer1.y-26)
          tDir-=40
          for(i=0;i<5;i+=1)
          {
            tNewAttack=instance_create(x+8,y+8,oPassBullet)
            tNewAttack.sprite_index=sWolfHeadShot; tNewAttack.atkPower=8; tNewAttack.bulletSpeed=3
            tNewAttack.direction=tDir; tNewAttack.image_speed=0.33; tNewAttack.decayTime=-100; tNewAttack.depth=7
            tDir+=20
          }
          shotTime=0
        }
      }
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x+8,y+10,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    instance_destroy()
  }
  enemyStepEvent()
}
