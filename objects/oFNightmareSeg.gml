#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bCanTakeDamage=false
bActive=true

//Enemy base statistics
eName="Final Nightmare"
maxLife=100
life=maxLife
atkPower=4
affiliation=9
bIsBoss=true
bNoBonus=true

moveTime=0
moveSeq=0
armDist=0
leftSpd=1
rightSpd=1

atkTime=0

jeremyText=""
chaoText=""
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //Phase 1
  {
    //Movement
    if moveSeq=0 //Extend arms
    {
      armDist+=0.08
      if armDist>=10 {armDist=10;moveSeq+=1}
    }
    else if moveSeq=1 //Wait time
    {
      moveTime+=1
      if moveTime>=30 {moveSeq+=1}
    }
    else if moveSeq=2 //Rotate arms
    {
      if armSide=0 {direction-=leftSpd} //Left
      else if armSide=1 {direction+=rightSpd} //Right
    }

    //Bomb Attack
    if atkTime>=1
    {
      atkTime+=1
      if atkTime=30
      {
        playSound(global.snd_HardHit3,0,0.95,24000)
        var tFire;
        tFire=instance_create(x,y,oPassBullet)
        tFire.sprite_index=sFNBomb; tFire.atkPower=atkPower; tFire.bulletSpeed=6
        tFire.direction=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
        tFire.decayTime=-100
        atkTime=0
      }
    }
  }
  else if type=1 //Phase 3
  {
    //Movement
    if moveSeq=0 //Extend arms
    {
      armDist+=0.09
      if armDist>=8 {armDist=8;moveSeq+=1}
    }
    else if moveSeq=1 //Wait time
    {
      moveTime+=1
      if moveTime>=30 {moveTime=0;moveSeq+=1}
    }
    else if moveSeq=2 //Rotate arms
    {
      if armSide=0 {direction-=leftSpd} //Left
      else if armSide=1 {direction+=rightSpd*1.1} //Right

      atkTime+=1
      if atkTime>200
      {
        var chkDir;
        chkDir=point_direction(oFinalNightmare.x,oFinalNightmare.y,oPlayer1.x,returnPlayerYCenter())
        if direction>chkDir-2 and direction<chkDir+2 {moveSeq+=1}
      }
    }
    else if moveSeq=3 //Wait time
    {
      moveTime+=1
      var tStopTime;
      if armSide=0 {tStopTime=31}
      else if armSide=1 {tStopTime=30}

      if moveTime>=tStopTime {moveTime=0;moveSeq+=1}
    }
    else if moveSeq=4 //Extend arm (Punch)
    {
      armDist+=2
      if armDist>=30 {armDist=30;moveSeq+=1}
    }
    else if moveSeq=5 //Wait time
    {
      moveTime+=1
      if moveTime>=15 {moveTime=0;moveSeq+=1}
    }
    else if moveSeq=6 //Retract arm
    {
      armDist-=1
      if armDist<=8 {armDist=8;atkTime=0;moveSeq=2}
    }
  }
  x=oFinalNightmare.x+lengthdir_x(3+(armDist*segment),direction)
  y=oFinalNightmare.y+lengthdir_y(3+(armDist*segment),direction)

  //----- Damage to player -----
  if bEnd=0
  {
    if collision_circle(x,y,circleRad,oPlayer1,1,1)
    {
      if bCanDealDamage=true
      {
        with oPlayer1
          hitPlayer(oFNightmareSeg)
      }
    }
  }
}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bEnd=1 {event_inherited()}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bEnd=1 {event_inherited()}
else
{
  draw_set_color(c_black)
  draw_set_alpha(image_alpha)
  draw_circle(x,y,circleRad,0)
}

if atkTime>0 and type=0
{
  draw_set_color(c_gray)
  draw_set_alpha(1-(atkTime/40))
  draw_circle(x,y,24-(atkTime/1.5),1)
}
