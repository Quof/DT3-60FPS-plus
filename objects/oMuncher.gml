#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
bActive=true
bCanTakeDamage=false
bShowHealthBar=false
hoverAlpha=-1
image_speed=0

//Enemy base statistics
eName="Muncher"
atkPower=4
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
affiliation=1

atkProg=0

jeremyText="Ugh, Munchers. You can't hurt them, but they can hurt you. They typically always bite in twos and in sequence with each other. It make take some finesse to get by, but nothing you can't handle."
chaoText="I don't get why the bad guys don't use more of these kinds of things that you can't hurt. Oh... I'm not saying I wish it would happen, I'm just wondering why. It would be interesting if they lined these guys up out of sequence."
if room=rMario1_8 {devText="I initially had this level planned much bigger than it is, but when thinking about how much trouble they presented in the Mario 3 Pipe World, I realized that a shorter sequence would be better."}
else {devText="I'm fairly certain that some of you are cursing the existence of these in this level. :3"}
extraInfo="Completely immune to damage."
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("halfStart")
{
  atkProg=38
  y+=16
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  atkProg+=1*gDeltaTime
  if atkProg>=31 and atkProg<=38
  {
    y+=2*gDeltaTime
    if atkProg=38
      image_index=0
  }
  else if atkProg>=69 and atkProg<=76
  {
    y-=2*gDeltaTime
    if atkProg=76
    {
      image_index=1
      atkProg=0
    }
  }
}
/*
if global.gamePaused=false
{
  atkProg+=1
  if atkProg>=21 and atkProg<=28
  {
    y+=2
    if atkProg=28
      image_index=0
  }
  else if atkProg>=49 and atkProg<=56
  {
    y-=2
    if atkProg=56
    {
      image_index=1
      atkProg=0
    }
  }
}
