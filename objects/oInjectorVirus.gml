#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0.3
visible=0

//Enemy base statistics
eName="Injector Virus"
eLevel=30
maxLife=175
life=maxLife
pointWorth=20
atkPower=7
resType[1]=5
stunResist=50
baseItemChance=30
baseDropIndex=90
pickupDropMod=10
detectDistX=188
detectDistY=156
dieEffect=0
myTarget=-1
startUpTime=0

currHspd=0; currVspd=0

deathAnim=0

jeremyText="Take these out as quick as you can, if they reach any of the facility's bots, they'll infect them and turn that bot on you. It's very very worth noting that the blue ones can infect non-aggressive bots such as consoles affecting doors and bridges. These have a limited sight distance, keep that in mind."
chaoText="The Virus hasn't been as actively aggressive toward you as it has been here. It knows you're close to shutting it down. We've come this far though, I know it won't stop us."
devText="Early on, the way these infect friendly bots and then turn those bots on the player was how all Virus infected enemies were going to work, but I scrapped that idea and decided to save it for late game only. There were a few complications back then that were later worked out, but over all, it felt better to save this till now."
extraInfo="Infects bots."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if type=1
{
  baseColor=make_color_rgb(50,50,255)
  image_blend=baseColor
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if bActive=0 {makeEnemyActive(1)}
  if life>0
  {
    if bActive=true and stunnedTime=0
    {
      startUpTime+=1
      if startUpTime=1 //Appear
      {
        visible=1
        var tEffect;
        tEffect=instance_create(x,y,oEffect)
        tEffect.sprite_index=sAtkTypeShield; tEffect.followID=-1; tEffect.image_xscale=0.75; tEffect.image_yscale=0.75
        tEffect.newBlend=1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_alpha=0.75; tEffect.image_speed=0.75
      }
      if startUpTime>=15
      {
        if myTarget=-1 //Find new target
        {
          if type=0 //Find facility bot
          {
            if instance_exists(oInfectMe) //Check if a new target exists
            {
              var tTestTgt,tTestDist;
              tTestTgt=instance_nearest(x,y,oInfectMe)
              tTestDist=point_distance(x,y,tTestTgt.x,tTestTgt.y)
              if tTestDist<=416 //Make sure target is close enough
              {
                myTarget=instance_nearest(x,y,oInfectMe)
              }
            }
          }
          else if type=1 //Find facility console
          {
            if instance_exists(oHPF_ConInfect) //Check if a new target exists
            {
              var tTestTgt,tTestDist;
              tTestTgt=instance_nearest(x,y,oHPF_ConInfect)
              tTestDist=point_distance(x,y,tTestTgt.x,tTestTgt.y)
              if tTestDist<=448 //Make sure target is close enough
              {
                myTarget=instance_nearest(x,y,oHPF_ConInfect)
              }
            }
          }
          //Track player
          var myDist,targetSpd;
          targetSpd=5
          myDist=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
          myDist=round(myDist)

          if myDist<=40 {targetSpd=2}
          else if myDist>=41 and myDist<=80 {targetSpd=4}
          else if myDist>=81 and myDist<=128 {targetSpd=5}
          else if myDist>=129 and myDist<=192 {targetSpd=6}
          else if myDist>=193 and myDist<=240 {targetSpd=7}
          else if myDist>=241 {targetSpd=8}

          maxSpeed=targetSpd
          if x>oPlayer1.x
          {
            if currHspd>-maxSpeed {currHspd-=0.2}
            else {currHspd+=0.2}
          }
          else if x<oPlayer1.x
          {
            if currHspd<maxSpeed {currHspd+=0.2}
            else {currHspd-=0.2}
          }
          if y>oPlayer1.y-26
          {
            if currVspd>-maxSpeed {currVspd-=0.2}
            else {currVspd+=0.2}
          }
          else if y<oPlayer1.y-26
          {
            if currVspd<maxSpeed {currVspd+=0.2}
            else {currVspd-=0.2}
          }
          hspeed=currHspd; vspeed=currVspd
        }
        else
        {
          if instance_exists(myTarget) //Target exists, go toward target
          {
            var myDist,targetSpd;
            targetSpd=5
            myDist=point_distance(x,y,myTarget.x,myTarget.y)
            myDist=round(myDist)

            if myDist<=40 {targetSpd=2}
            else if myDist>=41 and myDist<=80 {targetSpd=4}
            else if myDist>=81 and myDist<=128 {targetSpd=5}
            else if myDist>=129 and myDist<=192 {targetSpd=6}
            else if myDist>=193 and myDist<=240 {targetSpd=7}
            else if myDist>=241 {targetSpd=8}

            maxSpeed=targetSpd

            if x>myTarget.x
            {
              if currHspd>-maxSpeed {currHspd-=0.2}
              else {currHspd+=0.2}
            }
            else if x<myTarget.x
            {
              if currHspd<maxSpeed {currHspd+=0.2}
              else {currHspd-=0.2}
            }
            if y>myTarget.y
            {
              if currVspd>-maxSpeed {currVspd-=0.2}
              else {currVspd+=0.2}
            }
            else if y<myTarget.y
            {
              if currVspd<maxSpeed {currVspd+=0.2}
              else {currVspd-=0.2}
            }
            hspeed=currHspd; vspeed=currVspd
          }
          else {myTarget=-1} //No target exists, reset to find a new target
        }
      }
    }
    else {hspeed=0; vspeed=0}
  }
  else if life<=0
  {
    deathAnim+=1
    if deathAnim=1
    {
      playSound(global.snd_HardHit1,0,0.9,1)
      image_speed=0
      hspeed=0; vspeed=0
      baseColor=c_red; image_blend=c_red
      tEffect=instance_create(x,y,oEffect)
      tEffect.sprite_index=sDeathFlameA; tEffect.image_speed=0.33
      tEffect.image_xscale=2; tEffect.image_yscale=2; tEffect.image_alpha=0.8
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
    }
    image_alpha-=0.03
    if image_alpha<0 {instance_destroy()}
  }
  enemyStepEvent()
}
else {hspeed=0; vspeed=0}
#define Collision_oInfectMe
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 and type=0
{
  playSound(global.snd_Infect,0,0.95,22050+random(2205))
  with other.myOwner.id
  {
    event_user(0)
  }
  var tEffect,tDir;
  tDir=0
  for(i=0;i<16;i+=1)
  {
    tEffect=instance_create(x,y,oEffectB)
    tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75
    tEffect.image_speed=0.15; tEffect.direction=tDir+irandom_range(-4,4); tEffect.friction=0.01
    tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01
    tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
    tDir+=360/16
  }
  instance_destroy()
}
#define Collision_oHPF_ConInfect
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if life>0 and type=1
{
  playSound(global.snd_Infect,0,0.92,44100+random(4410))
  with other
  {
    if instance_exists(myOwner)
    {
      if myOwner.bActivate=0 {myOwner.bActivate=1}
    }
    var tEffect,tDir;
    tDir=0
    for(i=0;i<16;i+=1)
    {
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sVirusGel; tEffect.image_alpha=0.75
      tEffect.image_speed=0.15; tEffect.direction=tDir+irandom_range(-4,4); tEffect.friction=0.01
      tEffect.speed=random(1)+1; tEffect.fadeSpd=0.01; tEffect.image_blend=image_blend
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      tDir+=360/16
    }
    instance_destroy()
  }
  instance_destroy()
}
