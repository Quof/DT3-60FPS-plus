#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
bActive=1
bShowHealthBar=false
bShowDamage=false
image_xscale=1.5; image_yscale=1.5

//Enemy base statistics
eName="Elpizo Ball"
maxLife=10000
life=maxLife
atkPower=6
affiliation=4
bNoBonus=true
bIsBoss=true
shotMax=200
efFrame=0

myColor=0
glowColor[0]=make_color_rgb(144,248,248)
glowColor[1]=make_color_rgb(94,198,248)
glowColor[2]=make_color_rgb(144,198,198)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  life=maxLife
  shotTime+=1
  if shotTime>=shotMax
  {
    playSound(global.snd_CShotA,0,0.9,42000)
    var tNewAtk,tDir;
    tDir=point_direction(x,y,oPlayer1.x,returnPlayerYCenter())
    for(i=0;i<3;i+=1)
    {
      tNewAtk=instance_create(x,y,oPassBullet)
      tNewAtk.sprite_index=sE_Bubble; tNewAtk.image_speed=0.5; tNewAtk.image_blend=c_orange
      tNewAtk.atkPower=atkPower; tNewAtk.decayTime=-100; tNewAtk.direction=tDir
      if i=0 {tNewAtk.bulletSpeed=6}
      else {tNewAtk.bulletSpeed=1}
      tDir+=120
    }
    shotTime=0
  }
  enemyStepEvent()
}
#define Other_24
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oElpizo.specHP-=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(1)
if oGame.time mod 2=0 {myColor+=1}
if myColor=3 {myColor=0}
draw_set_color(glowColor[myColor])
draw_circle(x,y,11,0)
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

if shotTime>=shotMax-30
{
  efFrame+=0.33
  draw_sprite_ext(sMMcharging,efFrame,x,y,2,2,image_angle,image_blend,image_alpha)
  draw_sprite_ext(sMMcharging,efFrame+2,x,y,1,1,image_angle,image_blend,image_alpha)
}
