#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
bOpened=0
bHiding=0
moveWave=pi/2

swingSound=0
soundDelay=0

showControls=0
helpTextInner=make_color_rgb(159,132,105)
helpTextOuter=make_color_rgb(28,16,3)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if sprite_index=sHHouse_DresserA
  {
    if bHiding=1
    {
      oPlayer1.y=y-5
    }
  }
  else if sprite_index=sHHouse_Chandelier
  {
    moveWave+=pi/60
    image_angle+=sin(moveWave)/2

    //Chandelier swing sound
    soundDelay-=1
    if swingSound=0 //Swing right
    {
      if image_angle>-1 and soundDelay<=0
      {
        if point_distance(x,0,oPlayer1.x,0)<224
        {
          playSound(global.snd_CreakySwingA,0,1,1)
        }
        swingSound=1; soundDelay=30
      }
    }
    else if swingSound=1 //Swing left
    {
      if image_angle<1 and soundDelay<=0
      {
        if point_distance(x,0,oPlayer1.x,0)<224
        {
          playSound(global.snd_CreakySwingB,0,1,1)
        }
        swingSound=0; soundDelay=30
      }
    }
  }

  if bHiding=1
  {
    oPlayer1.xVel=0; oPlayer1.xAcc=0
    oPlayer1.x=x
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
  showControls=2
  if oKeyCodes.kCodePressed[3]=1 //################################################################################ Up
  {
    if sprite_index=sHHouse_DresserA //==================== DRESSER ====================
    {
      if bHiding=0
      {
        if bOpened=0 //Open
        {
          playSound(global.snd_DoorOpen,0,0.8,40000)
          image_index=1
          bOpened=1
        }
        else //Close
        {
          playSound(global.snd_DoorClose,0,0.8,40000)
          image_index=0
          bOpened=0
        }
      }
      else if bHiding=1 //Stand
      {
        playSound(global.snd_DoorOpen,0,0.8,40000)
        event_user(0)
        image_index=1
        bOpened=1
      }
    }
    else if sprite_index=sHHouse_Lamp //==================== LAMP ====================
    {
      playSound(global.snd_LampOn,0,1,1)
      if bOpened=0 {bOpened=1}
      else {bOpened=0}
    }
    else if sprite_index=sHHouse_Table //==================== TABLE ====================
    {
      if bHiding=1 //Stand
      {
        event_user(0)
      }
    }
    else if sprite_index=sHHouse_Fridge //==================== FRIDGE ====================
    {
      if bOpened=0 //Open
      {
        playSound(global.snd_DoorOpen,0,0.8,44000)
        image_index=1
        bOpened=1
      }
      else //Close
      {
        playSound(global.snd_DoorClose,0,0.8,44000)
        image_index=0
        bOpened=0
      }
    }
  }
  else if oKeyCodes.kCodePressed[4]=1 //################################################################################ Down
  {
    if sprite_index=sHHouse_DresserA //==================== DRESSER ====================
    {
      if bOpened=1 //Hide
      {
        playSound(global.snd_DoorClose,0,0.8,40000)
        event_user(1)
        image_index=0
        bOpened=0
      }
    }
    else if sprite_index=sHHouse_Table //==================== TABLE ====================
    {
      if bHiding=0 //Hide
      {
        event_user(1)
      }
    }
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oPlayer1.attackState=0
oPlayer1.image_blend=c_white
oPlayer1.depth=20
bHiding=0
#define Other_11
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
oPlayer1.kLeft=0
oPlayer1.kRight=0
oPlayer1.kUp=0
oPlayer1.kDown=0
oPlayer1.xVel=0; oPlayer1.xAcc=0
oPlayer1.state=oPlayer1.STANDING
oPlayer1.attackState=oPlayer1.ACT_HIDE
oPlayer1.image_blend=c_gray
oPlayer1.depth=61
bHiding=1
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if sprite_index=sHHouse_DresserA
{
  if bOpened=1
  {
    draw_sprite_ext(sHHouse_DresserB,image_index,x+21,y,1,1,0,c_white,1)
    draw_sprite_ext(sHHouse_DresserB,image_index,x-21,y,-1,1,0,c_white,1)
  }
}
else if sprite_index=sHHouse_Lamp
{
  if bOpened=1
  {
    draw_set_alpha(0.4)
    draw_set_blend_mode(bm_add)
    draw_circle_color(x,y-45,16,make_color_rgb(240,193,64),c_black,false)
    draw_sprite_ext(sHHouse_LLight,0,x,y-37,1,1,0,image_blend,0.4)
    draw_set_blend_mode(bm_normal)
  }
}
else if sprite_index=sHHouse_Table
{
  draw_sprite(sHHouse_TCloth,0,x,y-24)
}
else if sprite_index=sHHouse_Fridge
{
  if bOpened=1
  {
    draw_sprite(sHHouse_Food,0,x+8,y-22)
    draw_sprite(sHHouse_Food,1,x+3,y-10)
    draw_sprite_ext(sHHouse_FDoor,image_index,x+18,y,1,1,0,c_white,1)
  }
}

if showControls>0
{
  showControls-=1
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_left)
  if sprite_index=sHHouse_DresserA
  {
    if bHiding=0
    {
      if bOpened=0
      {
        draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
        textDropShadow("OPEN",x-12,y+13,helpTextInner,helpTextOuter,4)
      }
      else if bOpened=1
      {
        draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
        textDropShadow("CLOSE",x-12,y+13,helpTextInner,helpTextOuter,4)
        draw_sprite_ext(sGateH_UI_Arrow,0,x-22,y+26,1,1,270,c_white,1)
        textDropShadow("HIDE",x-12,y+23,helpTextInner,helpTextOuter,4)
      }
    }
    else if bHiding=1
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("STAND UP",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
  }
  else if sprite_index=sHHouse_Lamp
  {
    if bOpened=0
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("TURN ON",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
    else if bOpened=1
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("TURN OFF",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
  }
  else if sprite_index=sHHouse_Table
  {
    if bHiding=0
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,270,c_white,1)
      textDropShadow("HIDE",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
    else if bHiding=1
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("STAND UP",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
  }
  else if sprite_index=sHHouse_Fridge
  {
    if bHiding=0
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("OPEN",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
    else if bHiding=1
    {
      draw_sprite_ext(sGateH_UI_Arrow,0,x-21,y+16,1,1,90,c_white,1)
      textDropShadow("CLOSE",x-12,y+13,helpTextInner,helpTextOuter,4)
    }
  }
}
