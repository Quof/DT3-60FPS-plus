#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-3,-3,3,3)
image_speed=0.4
global.recAtkNum+=1
global.stSamus_Bomb[2]+=1

lifeTime=30
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
if global.gamePaused=false
{
  if global.location=91
  {
    if bombType=0 //Float up
    {
      y-=0.8
    }
  }

  if bombType=1
  {
    yVel+=0.2
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionBottom(1)
    {
      bounces-=1
      if bounces=0
      {
        xVel=0
        yVel=0
      }
      else
        yVel/=2*-1
    }
    if isCollisionTop(1)
      yVel=1
    moveTo(xVel,yVel)
  }

  lifeTime-=1
  if lifeTime=0
  {
    playSound(global.snd_MetroidBomb,0,0.95,1)
    if bombType=0 {global.hudSamus_Bombs[0]-=1}
    var tExpLight;
    tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=1.25; tExpLight.image_yscale=1.25

    if global.location=91
    {
      if bombType=0 //Bomberman bomb
      {
        bomb=instance_create(x,y,oBombermanExplode)
        var xx1,yy2,xx3,yy4,collChk;
        xx1=-64 //Left
        yy2=-64 //Up
        xx3=64 //Right
        yy4=64 //Down
        collChk=10

        bombMax=2
        for(i=0;i<bombMax;i+=1) //Left
        {
          if !collision_rectangle(x+xx1-collChk-(i*64),y-collChk,x+xx1+collChk-(i*64),y+collChk,oSolid,1,1)
          {
            bomb=instance_create(x+xx1-(i*64),y,oBombermanExplode)
            bomb.image_angle=180
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
        for(i=0;i<bombMax;i+=1) //Up
        {
          if !collision_rectangle(x-collChk,y+yy2-collChk-(i*64),x+collChk,y+yy2+collChk-(i*64),oSolid,1,1)
          {
            bomb=instance_create(x,y+yy2-(i*64),oBombermanExplode)
            bomb.image_angle=90
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
        for(i=0;i<bombMax;i+=1) //Right
        {
          if !collision_rectangle(x+xx3-collChk+(i*64),y-collChk,x+xx3+collChk+(i*64),y+collChk,oSolid,1,1)
          {
            bomb=instance_create(x+xx3+(i*64),y,oBombermanExplode)
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
        for(i=0;i<bombMax;i+=1) //Down
        {
          if !collision_rectangle(x-collChk,y+yy4-collChk+(i*64),x+collChk,y+yy4+collChk+(i*64),oSolid,1,1)
          {
            bomb=instance_create(x,y+yy4+(i*64),oBombermanExplode)
            bomb.image_angle=270
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
      }
      else //Standard bomb
      {
        bomb=instance_create(x,y,oSamusBExplosion)
        bomb.bombType=bombType
      }
    }
    else //Standard bomb
    {
      bomb=instance_create(x,y,oSamusBExplosion)
      bomb.bombType=bombType
    }
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_alpha(0.66)
draw_set_color(c_black)
draw_circle(x,y,lifeTime/2,1)
draw_set_color(c_white)
draw_circle(x,y,(lifeTime/2)+1,1)
