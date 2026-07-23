#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Needs drillMax.
event_inherited()
image_speed=0
image_xscale=1.1

//Enemy base statistics
eName="Drill Waying"
eLevel=18
maxLife=350
life=maxLife
pointWorth=20
atkPower=5
resType[0]=2
resType[1]=2
resType[2]=4
stunResist=4
baseItemChance=65
baseDropIndex=75
moneyWorth=5
affiliation=4
hitSound=global.snd_EnemyHitMM
dieSound=0
dieEffect=0
inactiveDist*=1.5

drillProg=0
waitTime=0

jeremyText="When it detects a hostile, that's you, to be in proximity, it will block off the pathway. The only way to get past it is to destroy the odd looking screw."
chaoText="I don't remember these being all that threatening in the original games, aside from that optional level with Vile, but even then, they weren't too much of a hindrance. I hope the Virus doesn't make better use of them."
devText="Since the Gate 4 intro stage and fortress stages would all be primarily interior levels, I wanted all the Maverick levels to feature mostly exterior environments. Like the Mavericks themselves, the tilesets used were one from each SNES game, which didn't necessarily have to match the Maverick itself."

colBase=instance_create(x,y+16,oSolid)
colBase.sprite_index=sDrillWayingBase; colBase.visible=1
colDrill=instance_create(x,y-16,oDrillWayingDrill)
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
    if drillProg=0 //Start drill
    {
      colDrill.yVel=-4
      colDrill.image_yscale+=0.25
      y-=4
      image_speed=0.3
      if colDrill.image_yscale=drillMax {image_index=0; drillProg=1}
    }
    else if drillProg=1 //Slight wait
    {
      waitTime+=1
      if waitTime=1
      {
        colDrill.yVel=0
        image_speed=0
      }
      else if waitTime=25 {image_speed=0.15; drillProg=2}
    }
    else if drillProg=2 //Slowly spin down
    {
      y+=1
      if y=ystart {image_speed=0; image_index=0; drillProg=3}
    }
  }
  else if life<=0
  {
    playSound(global.snd_EnemyDieMM,0,1,1)
    tEffect=instance_create(x,y-8,oEffect)
    tEffect.sprite_index=sMMExplosion
    tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    with colBase
    {
      tEffect=instance_create(x,y-8,oEffect)
      tEffect.sprite_index=sMMExplosion
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      instance_destroy()
    }
    with colDrill
    {
      for(i=0;i<image_yscale;i+=1)
      {
        tEffect=instance_create(x,y+8+(i*16),oEffect)
        tEffect.sprite_index=sMMExplosion
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
      }
      instance_destroy()
    }
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
draw_sprite_ext(sprite_index,image_index,x,y,1,1,image_angle,image_blend,image_alpha)
