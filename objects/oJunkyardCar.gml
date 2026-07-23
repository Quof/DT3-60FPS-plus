#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Junkyard Car"
eLevel=27
maxLife=430
life=maxLife
pointWorth=40
atkPower=8
resType[0]=1
resType[1]=1
stunResist=10
baseItemChance=40
baseDropIndex=90
moneyWorth=5
pickupDropMod=25
affiliation=7
dieSound=0
dieEffect=0
gunShot=0
hoodFrame=-1

jeremyText="As you've probably already seen, it's a broken down car with a missile launcher installed. You can use it for leverage as well."
chaoText="Holy out of place sprites, Claire! Yet another thing from 'Contra: Hard Corps'"
devText="This car was initially just a prop to look silly and be destroyed, but I saw the gun on the sprite and got other plans. It still keeps its silly status, at least I think so."

mySolid=instance_create(x,y,oSolid); mySolid.sprite_index=sprite_index; mySolid.visible=0
mySolid.image_xscale=0.95*image_xscale; mySolid.image_yscale=0.95
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  makeEnemyActive(0)
  if bActive=true and stunnedTime=0 and life>0
  {
    gunShot+=1
    if gunShot=55 {hoodFrame=0}
    else if gunShot=60 {hoodFrame=1}
    else if gunShot=75
    {
      playSound(global.snd_HardHit3,0,0.95,15000)
      var tMissile;
      tMissile=instance_create(x+(42*image_xscale),y-21,oHomingMissile)
      tMissile.atkPower=atkPower; tMissile.targetTime=20; tMissile.sprite_index=sJunkCarMissile
      tMissile.bulletSpeed=7; tMissile.seekThres=20; tMissile.minSpd=3; tMissile.maxSpd=8
      tMissile.turnSpd=4; tMissile.accel=0.2
      if image_xscale=1 {tMissile.direction=0} else {tMissile.direction=180}
    }
    else if gunShot=80 {hoodFrame=0}
    else if gunShot=85 {hoodFrame=-1; gunShot=0}
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    for(i=0;i<3;i+=1)
    {
      tEffect=instance_create(x-(24*image_xscale),y-15,oEffect)
      tEffect.sprite_index=sRobotExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=-1
    }
    for(i=0;i<4;i+=1)
    {
      tDir=random_range(-3,3)
      tEffect=instance_create(x+random_range(-12,12),y-15,oEffectGrav); tEffect.sprite_index=sJunkCarPieces
      tEffect.image_speed=0; tEffect.type=2; tEffect.image_index=i
      tEffect.xSpd=tDir; tEffect.ySpd=-2-random(1); tEffect.fadeSpd=0.04; tEffect.rotation=choose(-tDir,tDir)
      tEffect.grav=0.2; tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
    }
    with mySolid {instance_destroy()}
    instance_destroy()
  }
  enemyStepEvent()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if hoodFrame>-1 {draw_sprite_ext(sJunkCarHood,hoodFrame,x,y,image_xscale,image_yscale,direction,image_blend,image_alpha)}
