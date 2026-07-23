#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_xscale=-1

//Enemy base statistics
eName="Ridley"
eLevel=25
maxLife=10000
life=maxLife
atkPower=8
resType[0]=2
resType[1]=2
resType[5]=4
stunResist=50
bIsBoss=true
bNoBonus=true
affiliation=5
hitSound=global.snd_MetEnemyHitA
dieEffect=0
bossProgress=0
activateBoss=0
//--------------------
bWave=1
moveWaveX=pi/2
moveWaveY=pi/2
moveSpdX=0
moveSpdY=0

atkProg=0
atkTime=0
fireballRate=0

//Body Data
ridParts[0]=instance_create(x,y,oRidleyParts); ridParts[0].depth=4; ridParts[0].type=0
ridParts[1]=instance_create(x,y,oRidleyParts); ridParts[1].sprite_index=sRidleyWings; ridParts[1].depth=5; ridParts[1].type=1
ridParts[2]=instance_create(x,y,oRidleyParts); ridParts[2].sprite_index=sRidleyArms; ridParts[2].depth=6; ridParts[2].type=2
for(i=0;i<3;i+=1)
{
  ridParts[i].myOwner=id
}

for(i=0;i<7;i+=1)
{
  ridTail[i]=instance_create(x,y,oRidleyParts); ridTail[i].sprite_index=sRidleyTailSeg; ridTail[i].depth=8; ridTail[i].type=3
  ridTail[i].tailSeg=i
  ridTail[i].myOwner=id
}
ridTail[6].sprite_index=sRidleyTailEnd; ridTail[6].depth=9
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if activateBoss=1
  {
    oGlobalEvent.enemyCount=1
    bActive=true
    jeremyText="Ugh, Ridley is STILL after you. There's gotta be something we can do to him. Just try to get out of the escape shaft for now, ignore Ridley. What I'd like to do is get him caught in the explosion when the timer goes down."
    chaoText="It's Samus' nemesis from the Metroid series. He's fought in nearly all of the games since he seems to be able to revive or be rebuilt. In one game, he built a robotic version of himself."
    devText="I knew right away when I was going to do a Metroid level, that Ridley would be the end boss. Since Gate 5 is the last of Gates that give permanent Ability Sets, and the last of its kind, I wanted it to end on a high note. I'll let you see how that goes."
    with oRidleyParts
    {
      jeremyText=oRidleyEscape.jeremyText
      chaoText=oRidleyEscape.chaoText
      devText=oRidleyEscape.devText
      resType[5]=4
    }
    activateBoss=2
  }

  if life>0
  {
    if bWave=1 //Idle wave motion
    {
      moveWaveY+=0.2
      y+=sin(moveWaveY)
      if x+16<oPlayer1.x {image_xscale=1}
      else if x-16>oPlayer1.x {image_xscale=-1}
    }

    if fireballRate>0 //-- Spit fireballs --
    {
      if atkTime mod fireballRate=0
      {
        playSound(global.snd_RidleyFire,0,0.98,1)
        var tNewAttack;
        tNewAttack=instance_create(x+(13*image_xscale),y-4,oMetBulletPass)
        tNewAttack.sprite_index=sRidleyFireball; tNewAttack.damageType="ELEMENTAL"; tNewAttack.depth=4
        tNewAttack.atkPower=atkPower; tNewAttack.bulletSpeed=8; tNewAttack.decayTime=-100
        tNewAttack.direction=point_direction(x+(9*image_xscale),y-4,oPlayer1.x,returnPlayerYCenter())+random_range(-5,5)
      }
    }

    atkTime+=1
    if atkProg=0 //-------------------- Stay under player, fly left and right, shoot fireballs --------------------
    {
      //Movement
      if x>oPlayer1.x
      {
        if moveSpdX>-4 {moveSpdX-=0.5}
      }
      else
      {
        if moveSpdX<4 {moveSpdX+=0.5}
      }

      if y>view_yview[0]+view_hview[0]-48
      {
        if moveSpdY>-4 {moveSpdY-=0.5}
      }
      else
      {
        if moveSpdY<4 {moveSpdY+=0.5}
      }
      x+=moveSpdX; y+=moveSpdY

      if atkTime=40 {ridParts[0].image_index=1}
      else if atkTime=44 {ridParts[0].image_index=2}
      else if atkTime=49
      {
        if bossProgress=0 {fireballRate=30}
        else {fireballRate=10}
      }
      else if atkTime=89 {fireballRate=0}
      else if atkTime=94 {ridParts[0].image_index=1}
      else if atkTime=98 {ridParts[0].image_index=0}
      else if atkTime>=110 {atkTime=0}
    }

    //---------- Boss Difficulty Curve ----------
    if lifePercent<=0.2
    {
      life=maxLife/5
    }
  }
  oRidleyParts.image_blend=image_blend
  oRidleyParts.image_xscale=image_xscale
  enemyStepEvent()
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
redDmgHit(0)
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if y>=view_yview[0]+view_hview[0]+32
{
  draw_sprite_ext(sExitArrow,1,x,view_yview[0]+view_hview[0]-32,2,2,0,c_white,1)
}
