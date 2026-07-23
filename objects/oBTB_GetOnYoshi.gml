#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-7,-34,7,-1)

image_speed=0
delay=10
spdMod=8
movePlayer=1

endProg=0
endTime=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if endProg=0 //Normal
{
  if global.gamePaused=0
  {
    if delay>0 {delay-=1}

    yVel+=0.2
    if isCollisionBottom(1)
      yVel=0
    if isCollisionLeft(1)
      xVel*=-1
    if isCollisionRight(1)
      xVel*=-1
    if isCollisionSolid()
      y-=2

    if x<=oPlayer1.x {image_xscale=1}
    else {image_xscale=-1}

    if yVel>8 {}yVel=8
    moveTo(xVel,yVel)

    if y>room_height+64
    {
      yVel=0
      y=room_height+64
    }

    if x>=3703 //Jump off Yoshi on final pit
    {
      global.gamePaused=1
      with oBTB_YoshiJump {instance_destroy()}
      oPlayer1.xVel=0; oPlayer1.xAcc=0
      oPlayer1.yVel=0; oPlayer1.yAcc=0
      oPlayer1.sprite_index=sJerryJump; oPlayer1.image_xscale=1
      var tempMplay;
      tempMplay=findMusic(1020)
      playMusic(tempMplay,0,0)
      playerXVel=3/spdMod
      playerYVel=-16/spdMod
      yoshiYVel=0
      endProg=1
    }
  }
}
else if endProg=1 //Move player to ledge
{
  //----- Player movement -----
  if playerXVel<7.8/spdMod {playerXVel+=1.2/spdMod}

  if oPlayer1.x>=3848 and oPlayer1.y>=134 {movePlayer=0}
  else {movePlayer=1}

  if movePlayer=1 {oPlayer1.x+=playerXVel}

  if (oPlayer1.y<=48) or (oPlayer1.x>=3856 and oPlayer1.y<=80)
  {
    playerYVel+=1.2/spdMod
  }
  oPlayer1.y+=playerYVel

  if oPlayer1.x>=3856
  {
    if oPlayer1.y>=128
    {
      oPlayer1.y=128
      oPlayer1.sprite_index=sJerryIdle
      oPlayer1.image_speed=0.1
      endProg=2
    }
  }
  //----- Yoshi movement -----
  if yoshiYVel<4 {yoshiYVel+=0.1}
  y+=yoshiYVel
}
else if endProg=2 //Player is on ledge
{
  //----- Yoshi movement -----
  if yoshiYVel<4 {yoshiYVel+=0.1}
  y+=yoshiYVel

  endTime+=1
  if endTime=60
  {
    oPlayer1.image_xscale=-1
    var tempMplay;
    tempMplay=findMusic(101)
    playMusic(tempMplay,0,0)
  }
  else if endTime=70
  {
    msgCreate(0,0,"Jerry","...",0,1,oMessagePerson,0); newMessage.fadingTime=30
  }
  else if endTime=100
  {
    msgCreate(0,0,"Claire","...",0,1,oMessagePerson,0); newMessage.fadingTime=30
  }
  else if endTime=130
  {
    msgCreate(0,0,"Jeremy","...",0,1,oMessagePerson,0); newMessage.fadingTime=30
  }
  else if endTime=160
  {
    msgCreate(0,0,"Chao","...",0,1,oMessagePerson,0); newMessage.fadingTime=30
  }
  else if endTime>=190
  {
    global.gamePaused=0
    endProg=3
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
  if (oKeyCodes.kCodePressed[3]=1 or oPlayer1.yVel>4) and delay=0
  {
    if global.activeCharacter=0
    {
      var tEffect;
      tEffect=instance_create(x+8,bbox_bottom+2,oEffect)
      tEffect.sprite_index=sEfThwompHit; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=1; tEffect.ySpd=0
      tEffect=instance_create(x-8,bbox_bottom+2,oEffect)
      tEffect.sprite_index=sEfThwompHit; tEffect.image_xscale=-1; tEffect.image_speed=0.5
      tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=-1; tEffect.ySpd=0

      with oPlayer1
      {
        playSound(global.snd_ThwompHit,0,0.95,1)
        grappleState=0
        attackState=ACT_ON_YOSHI
      }
      instance_destroy()
    }
    else
    {
      msgCreate(170,100,"","Claire doesn't want to ride a yoshi.",6,1,oMessagePerson,0)
      newMessage.fadingTime=70
    }
  }
}
