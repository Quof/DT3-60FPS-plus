#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
imagespeed = 0

makeActive()
setCollisionBounds(-9,-13,9,-1)
visible=0

hopTime=0
hopNum=0
hopSeq=choose(0,1)
if hopSeq=0 {hopMax=4+irandom(4)}
else {hopMax=20+irandom(20)}
hopSpd=6+irandom(2)
image_speed=0
image_xscale=choose(-1,1)

bDoNotDestroy=0
behavior=-1
bCanChirp=0
bSpotted=0
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
visible=1
behavior=2
if variable_local_exists("diveIn")
{
  sprite_index=sDiveBird_Fly
  image_speed=0.33
  //x=choose(-48,room_width+48) //Test
  //y=ystart+random_range(-room_height/1.75,room_height/1.75) //Test
  image_blend=make_color_rgb(170+random(85),170+random(85),170+random(85)) //Test
  visible=0
  bDoNotDestroy=1
  flyBackTime=irandom(60)
  behavior=0
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed = 0
if global.gamePaused=false && gDeltaDoTicks
{
  if behavior=0 //Slight wait
  {
    flyBackTime-=1
    if flyBackTime<=0
    {
      sprite_index=sDiveBird_Fly
      imagespeed=0.33
      visible=1
      x=choose(-48,room_width+48)
      y=ystart+random_range(-room_height/1.75,room_height/1.75)
      if bCanChirp=1 //Bird chirp
      {
        if random(10)>3
        {
          playSound(global.snd_BirdsA,0,1,15000+random(25000))
        }
      }
      behavior+=1
    }
  }
  else if behavior=1 //Fly to spot (0=left, 1=right)
  {
    speed=5
    direction=point_direction(x,y,xstart,ystart)
    if direction>=90 and direction<=270 {image_xscale=-1}
    else {image_xscale=1}
    if point_distance(x,y,xstart,ystart)<6
    {
      //x=destX; y=destY
      x=xstart; y=ystart
      sprite_index=sDiveBird_Hop
      image_index=0
      imagespeed=0
      speed=0
      behavior+=1
    }
  }
  else if behavior=2 //Hop around
  {
    hopTime+=1
    if hopSeq=0 //Hop hop hop
    {
      if hopTime mod hopSpd=0
      {
        xVel=image_xscale
        y-=2
        yVel=-2.5
        image_index=1

        //Check if at cliff edge and turn around
        tDrop=0
        if aiCheckHoriz(1,1,0,8,4)
        {
          if aiCheckVert(0,1,8,8,4)=1
            tDrop=1
        }
        if tDrop=0
        {
          xVel*=-1
          image_xscale*=-1
        }
        hopNum+=1
      }

      if hopNum=hopMax
      {
        hopTime=0
        hopNum=0
        hopMax=20+irandom(20)
        hopSeq=1
      }
    }
    else if hopSeq=1 //Wait
    {
      if hopTime=hopMax
      {
        hopTime=hopSpd-1
        hopMax=4+irandom(4)
        hopSpd=6+irandom(2)
        image_xscale=choose(-1,1)
        hopSeq=0
      }
    }

    yVel+=1
    if isCollisionBottom(1)
    {
      xVel=0
      yVel=0
      image_index=0
    }
    if isCollisionLeft(1) {xVel=1; image_xscale=1}
    if isCollisionRight(1) {xVel=-1; image_xscale=-1}
    if isCollisionSolid() {y-=2}

    moveTo(xVel,yVel)
    if y>room_height+24 {instance_destroy()}

    if global.activeCharacter=0 //Fly away if Jerry is too close
    {
      var myDist;
      myDist=point_distance(x,y-7,oPlayer1.x,oPlayer1.y-26)
      if myDist<56
      {
        var tEffect,tXspd;
        for(i=0;i<3;i+=1)
        {
          tXspd=random_range(-1.5,1.5)
          tEffect=instance_create(x,y-7,oEffectGrav)
          tEffect.type=2; tEffect.sprite_index=sDiveBirdFeather; tEffect.image_blend=image_blend
          tEffect.image_xscale=0.75; tEffect.image_yscale=0.75; tEffect.xSpd=tXspd; tEffect.ySpd=-1.5-random(1)
          tEffect.fadeSpd=0.05; tEffect.rotation=-tXspd*6; tEffect.grav=0.2
          tEffect.newBlend=-1; tEffect.decay=-100; tEffect.followID=-1
        }
        global.recBirdsScared+=1
        if x>oPlayer1.x {xSpd=5+random(2); image_xscale=1}
        else {xSpd=-5-random(2); image_xscale=-1}
        ySpd=-3.5-random(1)
        sprite_index=sDiveBird_Fly
        imagespeed=0.33
        hopTime=0
        behavior+=1
      }
    }
  }
  else if behavior=3 //Flying away
  {
    x+=xSpd
    y+=ySpd

    if instance_exists(oEnemyBase)
    {
      eDistCheck=instance_nearest(x,y-7,oEnemyBase)
      if point_distance(x,y-7,eDistCheck.bbox_left+(eDistCheck.sprite_width/2),eDistCheck.bbox_top+(eDistCheck.sprite_height/2))<112
      {
        sprite_index=sDiveBird_Hover
        direction=point_direction(x,y-7,eDistCheck.bbox_left+(eDistCheck.sprite_width/2),eDistCheck.bbox_top+(eDistCheck.sprite_height/2))-180
        if direction>=90 and direction<=270 {image_xscale=1}
        else {image_xscale=-1}
        imagespeed=0.33
        behavior+=1
      }
    }
  }
  else if behavior=4 //Ready to dive
  {
    speed=2
    hopTime+=1
    if hopTime=25
    {
      if instance_exists(eDistCheck)
        eDirCheck=point_direction(x,y-7,eDistCheck.bbox_left+(eDistCheck.sprite_width/2),eDistCheck.bbox_top+(eDistCheck.sprite_height/2))
      else
        eDirCheck=random(360)
      diveAtk=instance_create(x,y,oAtkDiveBird)
      diveAtk.direction=eDirCheck; diveAtk.image_angle=eDirCheck+45; diveAtk.image_blend=image_blend
      if bDoNotDestroy=1
      {
        visible=0
        flyBackTime=40+irandom(200)
        behavior=0
      }
      else {instance_destroy()}
    }
  }
}
else {speed=0}

if bSpotted=0
{
  if checkScreenArea(x,y,2)=1
  {
    global.recBirdsSeen+=1
    bSpotted=1
  }
}

if gDeltaDoTicks
    image_index += imagespeed
#define Other_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if behavior>=2
{
  if bDoNotDestroy=0 {instance_destroy()}
  else
  {
    bCanChirp=1
    visible=0
    flyBackTime=40+irandom(200)
    behavior=0
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
magicInterpDrawStart()
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
magicInterpDrawEnd()
