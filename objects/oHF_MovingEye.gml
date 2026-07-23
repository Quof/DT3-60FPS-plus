#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1

//Enemy base statistics
eName="Hex Eye"
eLevel=40
maxLife=100
life=maxLife
atkPower=9
dieEffect=0
bNoBonus=true
jeremyText="Let's see if I can pull up some real data on these. Uuuugh, nope. All it tells me is that touching these will cause instant death. Also there's a note here in the data...#'Jeremy, you're going to fail.'#Great, Hex is still toying with me. Don't rely on anything I've told you in this fight. Hex is able to change what I see."
chaoText="Interesting enough, you can deal damage to these. You just... damn, I can't convey that to you. Jeremy is right, if Hex catches on, he'll close up this opportunity. Hex may be able to see what I'm telling you here."
devText="Hex still blocks dev commentary."

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
path_start(pth_Hex_EyeA,moveSpeed,1,true)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if life>0
  {
    path_speed=moveSpeed
    image_angle=direction
  }
  else if life<=0
  {
    tEfCir=instance_create(x,y,oEfCircleBlast)
    tEfCir.image_alpha=0.75; tEfCir.myRad=4; tEfCir.radScl=3; tEfCir.fadeSpeed=0.08
    instance_destroy()
  }
  enemyStepEvent()
}
else {path_speed=0}
