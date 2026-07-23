#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
imageScaling=0.9
image_xscale=imageScaling
image_yscale=imageScaling
image_speed=0.5
image_blend=make_color_rgb(72,0,68)
if room=rExtGateH_8 {moveSpd=3.805}
else {moveSpd=2}
stepMod=0
bWalking=1

armAngle=0
myDist=1000

warnAlpha=0
warnScaling=1
if room=rExtGateH_8 {extScaling=1.4}
{
  if global.gateHProg<30 {extScaling=1}
  else {extScaling=1.2}
}

bSightToPlayer=0
bCatchPlayer=0
catchSequence=0
redWarn=0

talkToClaire=0

if x<oPlayer1.x //Left of player
{
  image_xscale=imageScaling
  x+=moveSpd
}
else if x>oPlayer1.x //Right of player
{
  image_xscale=-imageScaling
  x-=moveSpd
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if room!=rExtGateH_8
  {
    if oPlayer1.attackState=oPlayer1.ACT_HIDE {moveSpd=2.75}
    else {moveSpd=2}
  }

  if bSightToPlayer=1
  {
    if y-56>=oPlayer1.y
    {
      if x<oPlayer1.x-40 //Left of player
      {
        bWalking=1
        image_speed=0.5
        image_xscale=imageScaling
        x+=moveSpd
      }
      else if x>oPlayer1.x+40 //Right of player
      {
        bWalking=1
        image_speed=0.5
        image_xscale=-imageScaling
        x-=moveSpd
      }
      else
      {
        bWalking=0
        image_speed=0
        image_index=0
      }
    }
    else
    {
      bWalking=1
      image_speed=0.5
      if x<oPlayer1.x //Left of player
      {
        image_xscale=imageScaling
        x+=moveSpd
      }
      else if x>oPlayer1.x //Right of player
      {
        image_xscale=-imageScaling
        x-=moveSpd
      }
    }
  }
  else
  {
    bWalking=1
    image_speed=0.5
    //Don't leave the map
    if x<=64 {image_xscale=imageScaling}
    else if x>=room_width-64 {image_xscale=-imageScaling}
    
    //Continue straight
    if image_xscale>0 {x+=moveSpd}
    else {x-=moveSpd}
  }
  
  //Foot step sound
  if bWalking=1
  {
    stepMod+=1
    if stepMod mod 50=0
    {
      playSound(global.snd_FootSteps,0,1,1)
    }
  }
  
  //Warning
  myDist=point_distance(x,0,oPlayer1.x,0)
  if warnAlpha>=0.2
  {
    
    warnScaling=5-(myDist/200)
    if warnScaling<1 {warnScaling=1}
    warnAlpha=0.6-(myDist/1200)
    if warnAlpha<0.2 {warnAlpha=0.2}
  }
  else {warnAlpha+=0.01}
  
  //Arm angle
  if bSightToPlayer=1 and bWalking=1
  {
    if myDist<=120
    {
      if image_xscale>0 {armAngle=60-(myDist/2)}
      else {armAngle=300+(myDist/2)}
    }
  }
  
  //Sight to player
  if collision_line(x,y-24,oPlayer1.x,oPlayer1.y-24,oSolid,0,1) //Mother has no line of sight
  {
    bSightToPlayer=0
  }
  else //Mother has line of sight
  {
    if oPlayer1.attackState=oPlayer1.ACT_HIDE //If player is hiding
    {
      //Do nothing, if the Mother already had line of sight, hiding does nothing
    }
    else //If player is not hiding
    {
      if point_distance(x,0,oPlayer1.x,0)<=192 //Mother is not far enough
      {
        bSightToPlayer=1
      }
    }
  }
  
  //Talk to Claire
  if oPlayer1.attackState=oPlayer1.ACT_HIDE {talkToClaire+=1}
  else
  {
    if talkToClaire<690 {talkToClaire+=1}
    else {talkToClaire=690}
  }
  if talkToClaire>=750
  {
    playSound(global.snd_VO_GH_02,0,1,1)
    talkToClaire=0
  }
  
  //Slow down Claire
  if room=rExtGateH_8 //Final stretch
  {
    if bSightToPlayer=1
    {
      if oPlayer1.runAcc>=2 {oPlayer1.runAcc-=0.01}
    }
    else
    {
      if oPlayer1.runAcc<=4 {oPlayer1.runAcc+=0.01}
    }
    
    if x>=1328 and myDist<=64 and moveSpd>2 {moveSpd-=0.0275}
  }
  else //House
  {
    if bSightToPlayer=1
    {
      if oPlayer1.runAcc>=2 {oPlayer1.runAcc-=0.005}
    }
    else
    {
      if oPlayer1.runAcc<=4 {oPlayer1.runAcc+=0.02}
    }
  }
}
else
{
  if bCatchPlayer=1 //Player is caught
  {
    catchSequence+=1
    if catchSequence=1 {image_speed=0}
    if catchSequence>=1 and catchSequence<=50 {redWarn+=0.02}
    if catchSequence>=51
    {
      //Reset progress
      global.tempAction[2]=1
      if global.gateHProg>=12 and global.gateHProg<=15 //1
      {
        global.gateHProg=12
        global.newMapX=160; global.newMapY=304
        room_goto(rExtGateH_2)
      }
      else if global.gateHProg>=16 and global.gateHProg<=22 //2
      {
        global.gateHProg=18
        global.newMapX=384; global.newMapY=304
        room_goto(rExtGateH_3)
      }
      else if global.gateHProg>=24 and global.gateHProg<=30 //3
      {
        global.gateHProg=24
        global.newMapX=1552; global.newMapY=304
        room_goto(rExtGateH_3)
      }
      else if global.gateHProg>=30 and global.gateHProg<=32 //4
      {
        global.gateHProg=30
        global.newMapX=544; global.newMapY=304
        room_goto(rExtGateH_7)
      }
      else if global.gateHProg=33 //5
      {
        global.newMapX=64; global.newMapY=304
        room_goto(rExtGateH_8)
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
if global.gamePaused=false
{
  if bSightToPlayer=1 //Catch player
  {
    bCatchPlayer=1
    global.gamePaused=true
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_sprite_ext(sClaireMotherArm,image_index,x-(2*image_xscale),y-42,image_xscale,image_yscale*1.5,armAngle,image_blend,image_alpha)

draw_sprite_ext(sHitWarn,0,view_xview[0],view_yview[0]-1,warnScaling*extScaling,warnScaling*extScaling,90,c_black,warnAlpha*extScaling) //top-right
draw_sprite_ext(sHitWarn,0,view_xview[0]+view_wview[0],view_yview[0],warnScaling*extScaling,warnScaling*extScaling,0,c_black,warnAlpha*extScaling) //top-left
draw_sprite_ext(sHitWarn,0,view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],warnScaling*extScaling,warnScaling*extScaling,270,c_black,warnAlpha*extScaling) //bottom-right
draw_sprite_ext(sHitWarn,0,view_xview[0]-1,view_yview[0]+view_hview[0],warnScaling*extScaling,warnScaling*extScaling,180,c_black,warnAlpha*extScaling) //bottom-left

//Red warn
if redWarn>0
{
  draw_set_color(c_red)
  draw_set_alpha(redWarn)
  draw_rectangle(0,0,room_width,room_height,0)
}
