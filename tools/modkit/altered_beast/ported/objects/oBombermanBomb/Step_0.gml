event_inherited()
if global.gamePaused=false
{

    if bombType=0 //Float up
    {
      y-=0.8*gDeltaTime
  }

  if bombType=1
  {
    yVel=scrGravAcc(yVel,0.2,1)
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
    moveTo(xVel*gDeltaTime,yVel*gDeltaTime)
  }

  lifeTime-=1*gDeltaTime
  if lifeTime=0
  {
    playSound(global.snd_MetroidBomb,0,0.95,1)
    if bombType=0 {global.hudSamus_Bombs[0]-=1}
    var tExpLight;
    tExpLight=instance_create(x,y,oWepEf_Light); tExpLight.image_xscale=1.25; tExpLight.image_yscale=1.25

    bomb=instance_create(x,y,oBombermanExplodeSpecial)
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
        bomb=instance_create(x+xx1-(i*64),y,oBombermanExplodeSpecial)
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
        bomb=instance_create(x,y+yy2-(i*64),oBombermanExplodeSpecial)
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
        bomb=instance_create(x+xx3+(i*64),y,oBombermanExplodeSpecial)
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
        for(i=0;i<bombMax;i+=1) //Down
        {
          if !collision_rectangle(x-collChk,y+yy4-collChk+(i*64),x+collChk,y+yy4+collChk+(i*64),oSolid,1,1)
          {
        bomb=instance_create(x,y+yy4+(i*64),oBombermanExplodeSpecial)
            bomb.image_angle=270
            if i<bombMax-1 {bomb.sprite_index=sBombermanExpB}
            else {bomb.sprite_index=sBombermanExpC}
          }
          else {break;}
        }
 
    instance_destroy()
  }
}
