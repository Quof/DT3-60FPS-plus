#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
image_speed=0
bCanTakeDamage=false
bActive=true

//Enemy base statistics
eName="Aqua Serpent Body"
maxLife=100
life=maxLife
atkPower=5
affiliation=2
bIsBoss=true
bNoBonus=true

fireTime=0
fireDelay=300

jeremyText="One of the Serpent's body parts."
chaoText="What Jeremy said...#Oh yeah, during its wave pattern, the body segments can't fire bullets at you. Though when it arcs overhead, it will fire them more often."
devText="It was surprisingly easy to code this snake structure. I'm not a programmer and don't consider myself very good at scripting, even on this level, so it always surprises me how simple things can be. I do consider myself a logic thinker, which is what I tap into when coding. As for formal training, I only had a class on C++ way way back. The rest is all self taught."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
fireDelay=450+(bodySeg*130)
fireTime=180
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if oAquaSerpent.life>0
  {
    if oAquaSerpent.movePath!=2
    {
      if oAquaSerpent.movePath=1
        fireTime+=1+oAquaSerpent.bossProgress
      else if oAquaSerpent.movePath=6
        fireTime+=0.5
      else
        fireTime+=1
    }

    if fireTime>=fireDelay and fireTime<=fireDelay+39
      image_blend=c_orange
    else if fireTime>=fireDelay+40 and fireTime<=fireDelay+79
      image_blend=c_red
    else if fireTime>=fireDelay+80
    {
      playSound(global.snd_Fireball,0,0.8,28000+random(8000))
      var tFire,tDir;
      tDir=player_sprite_center()
      tFire=instance_create(x,y,oPassBullet)
      tFire.sprite_index=sWolfHeadShot; tFire.direction=tDir
      tFire.atkPower=oAquaSerpent.atkPower-1; tFire.bulletSpeed=4; tFire.decayTime=-100

      image_blend=c_white
      fireTime=0
    }
    if oAquaSerpent.movePath=2
      image_blend=c_white
  }

  if oAquaSerpent.moveBehavior=1
  {
    if bodySeg=0 //To head
    {
      if point_distance(x,y,oAquaSerpent.x,oAquaSerpent.y)>4+(oAquaSerpent.moveSpd/2)
      {
        direction=point_direction(x,y,oAquaSerpent.x,oAquaSerpent.y)
        speed=oAquaSerpent.moveSpd
      }
      else if point_distance(x,y,oAquaSerpent.x,oAquaSerpent.y)>(4+(oAquaSerpent.moveSpd/2))*1.2
      {
        direction=point_direction(x,y,oAquaSerpent.x,oAquaSerpent.y)
        speed=oAquaSerpent.moveSpd*1.25
      }
      else
        speed=0
    }
    else //To next body part
    {
      if point_distance(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)>8+(oAquaSerpent.moveSpd/1.25)
      {
        direction=point_direction(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)
        speed=oAquaSerpent.moveSpd
      }
      else if point_distance(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)>(8+(oAquaSerpent.moveSpd/1.25))*1.2
      {
        direction=point_direction(x,y,oAquaSerpent.bodyPart[bodySeg-1].x,oAquaSerpent.bodyPart[bodySeg-1].y)
        speed=oAquaSerpent.moveSpd*1.25
      }
      else
        speed=0
    }
  }
  else
    speed=0
}
else
  speed=0
