#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
makeActive()
setCollisionBounds(-16,-16,16,16)
image_speed=0.15
bActive=1

//Enemy base statistics
eName="Metroid Parasite"
eLevel=20
maxLife=10000
life=maxLife
pointWorth=36
atkPower=12
for(i=0;i<6;i+=1)
{
  resType[i]=1
}
hitSound=global.snd_MetEnemyHitA
dieSound=4
dieEffect=4
bIsBoss=true
bNoBonus=true

scaleUp=1
shellScale=1
moveSpd=2.4
updateCheck=0
triggerProg=0
stopTime=0

jeremyText="Get away from this. You can't do anything to it nor am I seeing any way to. Just run, and then run some more!##Just saw this, you can dash through this thing as it doesn't seem to be affected by the Gate rules."
chaoText="This thing will track you through all the halls of this place. It can't go through walls though..."
devText="I thought about making this Nightmare Gate a mini labyrinth to give it more of a Metroid feel, but Metroid isn't all about branching doorways. That said, I used it to play with slippery ice physics instead. This wasn't a thing that I wanted too prominent in the game, so it was given a small part here instead."
extraInfo="Incredible tracking ability."

myGrid=mp_grid_create(0,0,room_width/16,room_height/16,16,16)
mp_grid_add_instances(myGrid,oSolid,1)
myPath=path_add()
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if scaleUp=1 //Shell scale
{
  shellScale+=0.005
  if shellScale>=1.1 {scaleUp=0}
}
else if scaleUp=0
{
  shellScale-=0.005
  if shellScale<=0.9 {scaleUp=1}
}

if global.gamePaused=false
{
  if stopTime<=0
  {
    if room=rExtGateF_2 //Go faster as more switches are triggered
    {
      if triggerProg=0 {if instance_number(oSwitchBarrier)<5 {moveSpd+=0.3; triggerProg+=1}}
      else if triggerProg=1 {if instance_number(oSwitchBarrier)<4 {moveSpd+=0.3; triggerProg+=1}}
      else if triggerProg=2 {if instance_number(oSwitchBarrier)<3 {moveSpd+=0.3; triggerProg+=1}}
      else if triggerProg=3 {if instance_number(oSwitchBarrier)<2 {moveSpd+=0.3; triggerProg+=1}}
    }

    //Update grid
    updateCheck+=1
    if updateCheck>=4
    {
      mp_grid_clear_all(myGrid)
      mp_grid_add_instances(myGrid,oSolid,1)
      updateCheck=0
    }

    if place_meeting(x,y,oDummyPlat) //Check if door closed on Parasite
    {
      path_end()
      if x>oPlayer1.x {x-=4}
      else if x<oPlayer1.x {x+=4}
    }
    else //Update path
    {
      if point_distance(x,y,oPlayer1.x,oPlayer1.y-26)<512 {moveSpd=4}
      else {moveSpd=6}
      mp_grid_path(myGrid,myPath,x,y,oPlayer1.x,oPlayer1.y-26,1)
      path_start(myPath,moveSpd,2,1)
    }
    enemyStepEvent()
  }
  else
  {
    path_end()
    stopTime-=1
  }
}
else {path_end()}
#define Collision_oPlayer1
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
stopTime=20
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sMetParasiteShell,image_index,x,y,shellScale,shellScale,image_angle,image_blend,image_alpha)

distToPlayer=point_distance(x,y,oPlayer1.x,oPlayer1.y-26)
if distToPlayer>160
{
  var arrowDir;
  arrowDir=point_direction(oPlayer1.x,oPlayer1.y-26,x,y)
  draw_sprite_ext(sPauseM_Cursor,0,oPlayer1.x+lengthdir_x(72,arrowDir),oPlayer1.y-26+lengthdir_y(72,arrowDir),1,1,arrowDir,c_white,1)
}
