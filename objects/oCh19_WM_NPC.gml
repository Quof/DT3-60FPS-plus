#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
makeActive()
setCollisionBounds(-16,-40,16,-1)
image_speed=0.15
myScale=1.25
image_xscale=myScale
image_yscale=myScale
runAcc=7
jumpAcc=-7
wallCling=0
actProg=0
actTime=0
wallJumpTime=-100
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if type=0 //---------------------------------------- SF_A (First) ----------------------------------------
  {
    if actProg=0
    {
      actTime+=1
      if actTime>=10 {actTime=0; actProg+=1}
    }
    else if actProg=1 {xVel=runAcc; actProg+=1}
    else if actProg=2
    {
      if oPlayer1.x>=416 {xVel=runAcc}
      if x>=672 {actProg+=1}
    }
    else if actProg=3
    {
      if oPlayer1.x>=880 {xVel=runAcc}
      if x>=1024 {actProg+=1}
    }
    else if actProg=4
    {
      if x>=1552
      {
        var tEffect;
        tEffect=instance_create(x,y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        x=1376; y=32
        xVel=0; yVel=0
        image_alpha=0
        actProg+=1
      }
    }
    else if actProg=5
    {
      actTime+=1
      if actTime=30
      {
        msgCreate(0,0,"Jerry","What the hell?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if actTime=90
      {
        msgCreate(0,0,"Claire","He probably knows a few tricks to this place.",0,1,oMessagePerson,0)
        newMessage.fadingTime=90
      }
      if oPlayer1.x>=1856
      {
        actProg+=1
        global.gameProgress=4810
      }
    }
  }
  else if type=1 //---------------------------------------- SF_B (Second) ----------------------------------------
  {
    if actProg=0
    {
      if oPlayer1.x>=752
      {
        if global.gameProgress<=4820
        {
          image_xscale=-myScale
          actProg=1
        }
        else {actProg=2}
      }
    }
    else if actProg=1
    {
      actTime+=1
      if actTime=10
      {
        msgCreate(0,0,"Warmaster","Still following me.",6,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if actTime=70
      {
        msgCreate(0,0,"Jerry","We don't have much of a choice.",0,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if actTime=150
      {
        msgCreate(0,0,"Warmaster","If you stop what you're doing, you can prevent future disasters. Hex won't have to use that ship's weapon.",6,2,oMessagePerson,0)
        newMessage.fadingTime=180
      }
      else if actTime=330
      {
        msgCreate(0,0,"Jerry","Why are you helping him? You have to know he's bad news.",0,1,oMessagePerson,0)
        newMessage.fadingTime=120
      }
      else if actTime=450
      {
        msgCreate(0,0,"Warmaster","Hex provides a unique opportunity. He can help us attain peace here.",6,1,oMessagePerson,0)
        newMessage.fadingTime=140
      }
      else if actTime=590
      {
        msgCreate(0,0,"Jerry","What...?",0,1,oMessagePerson,0)
        newMessage.fadingTime=60
      }
      else if actTime=610
      {
        image_xscale=myScale
        actTime=0; actProg+=1
        global.gameProgress=4830
      }
    }
    else if actProg=2
    {
      if oPlayer1.x>=768 {xVel=runAcc}
      if x>=1024 {actProg+=1}
    }
    else if actProg=3
    {
      if x>=4592
      {
        var tEffect;
        tEffect=instance_create(x,y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        x=4272; y=848
        xVel=0; yVel=0
        image_alpha=0
        actProg+=1
      }
    }
    else if actProg=4
    {
      if oPlayer1.x>=4240
      {
        actProg+=1
        global.gameProgress=4840
      }
    }
  }
  else if type=2 //---------------------------------------- SF_C (Third) ----------------------------------------
  {
    if actProg=0
    {
      if oPlayer1.x>=160
      {
        if global.gameProgress<=4850
        {
          image_xscale=-myScale
          actProg=1
        }
        else {actProg=2}
      }
    }
    else if actProg=1
    {
      actTime+=1
      if actTime=10
      {
        msgCreate(0,0,"Warmaster","I will create a utopia for bots.",6,1,oMessagePerson,0)
        newMessage.fadingTime=80
      }
      else if actTime=90
      {
        msgCreate(0,0,"Jerry","The program was trying to do that. It would have done that already if it wasn't for the Virus.",0,2,oMessagePerson,0)
        newMessage.fadingTime=170
      }
      else if actTime=260
      {
        msgCreate(0,0,"Warmaster","You are wrong. The program had lost most of its control when you and Jeremy destroyed the Data Reallocation Modules and the damage done by the Virus is now irreversable.",6,3,oMessagePerson,0)
        newMessage.fadingTime=250
      }
      else if actTime=510
      {
        msgCreate(0,0,"Jerry","What are you saying?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if actTime=580
      {
        msgCreate(0,0,"Warmaster","The program will never regain control. You, me, all of us are on our own.",6,1,oMessagePerson,0)
        newMessage.fadingTime=160
      }
      else if actTime=740
      {
        msgCreate(0,0,"Jerry","Then what's your problem?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if actTime=810
      {
        msgCreate(0,0,"Warmaster","Your kind cannot be trusted. They should be quarantined.",6,1,oMessagePerson,0)
        newMessage.fadingTime=130
      }
      else if actTime=940
      {
        msgCreate(0,0,"Jerry","Seriously? We're really going there?",0,1,oMessagePerson,0)
        newMessage.fadingTime=70
      }
      else if actTime=960
      {
        image_xscale=myScale
        actTime=0; actProg+=1
        global.gameProgress=4860
      }
    }
    else if actProg=2
    {
      if oPlayer1.x>=176 {xVel=runAcc}
      if x>=384 {actProg+=1}
    }
    else if actProg=3
    {
      if y>=624 {xVel=runAcc; actProg+=1}
    }
    else if actProg=4
    {
      if x>=2176
      {
        var tEffect;
        tEffect=instance_create(x,y-20,oEffect)
        tEffect.sprite_index=sEfEnergyRip; tEffect.image_speed=0.5; tEffect.image_alpha=0.5
        tEffect.newBlend=-1; tEffect.followID=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0
        x=1968; y=448
        xVel=0; yVel=0
        image_alpha=0
        actProg+=1
      }
    }
    else if actProg=5
    {
      if oPlayer1.x>=2640
      {
        actProg+=1
        global.gameProgress=4870
      }
    }
  }
  else if type=3 //---------------------------------------- SF_G (Fourth) ----------------------------------------
  {
    if actProg=0
    {
      if oPlayer1.x>=64
      {
        xVel=runAcc; actProg+=1
      }
    }
    else if actProg=1
    {
      if x>=2336 {actProg+=1}
      if oPlayer1.x>=2288 and x<=944 //If Warmaster gets stuck
      {
        x=2304; y=512
        msgCreate(0,0,"Warmaster","Don't think I'm out just because some odd physics bug occurred.",6,1,oMessagePerson,0)
        newMessage.fadingTime=130
        wallCling=0
        wallJumpTime=-100
        xVel=runAcc; actProg+=1
      }
    }
    else if actProg=2
    {
      if x<oPlayer1.x {xVel=16}
      else
      {
        var tMyDist;
        tMyDist=point_distance(x,0,oPlayer1.x,0)
        if tMyDist>=0 and tMyDist<=96 {xVel=13}
        else if tMyDist>=97 and tMyDist<=160 {xVel=11}
        else if tMyDist>=161 {xVel=7.5}

        if tMyDist>=528
        {
          var tGOMess;
          tGOMess=instance_create(0,0,oSituationalGO_Message)
          tGOMess.type=0
          oPlayer1.life-=oPlayer1.maxLife
        }
      }

      if actTime=0
      {
        if x>=3776
        {
          msgCreate(0,0,"Jerry","Oh what? He runs right through the spikes!",0,1,oMessagePerson,0)
          newMessage.fadingTime=90
          actTime=1
        }
      }

      if x>=11536
      {
        image_xscale=-1.25
        xVel=0
        actTime=0; actProg+=1
      }
    }
    else if actProg=3
    {
      if oPlayer1.x>=11472
      {
        oBikeViewFollow.viewProg=1
        oEvSF.sceneProgress=2
        actProg=4
      }
    }
  }

  //Movement Physics
  wallCling=0
  if yVel<12 {yVel+=0.3}
  if isCollisionBottom(1)
    yVel=0
  if isCollisionLeft(1)
  {
    if wallJumpTime<0 {xVel=0}
    wallCling=1
  }
  if isCollisionRight(1)
  {
    if wallJumpTime<0 {xVel=0}
    wallCling=1
  }
  if isCollisionSolid()
    y-=2

  if wallJumpTime>=100 //Wall jump
  {
    wallJumpTime+=1
    if wallJumpTime=105 {image_xscale=myScale; x+=2; xVel=runAcc; yVel=jumpAcc}
    else if wallJumpTime=107 {wallJumpTime=-100}
    if wallJumpTime=205 {image_xscale=-myScale; x-=2; xVel=-runAcc; yVel=jumpAcc; wallJumpTime=-100}
    else if wallJumpTime=207 {wallJumpTime=-100}
  }

  moveTo(xVel,yVel)

  //---------- Animation ----------
  if wallCling=0
  {
    if xVel=0 {sprite_index=sWarmasterA_Idle; image_speed=0.15}
    else
    {
      sprite_index=sWarmasterA_Run
      image_speed=(xVel*4.75)/100
    }

    if yVel<0 {sprite_index=sWarmasterA_JumpUp; image_speed=0.33}
    else if yVel>0 {sprite_index=sWarmasterA_JumpDown; image_speed=0.33}
  }
  else if wallCling=1
  {
    sprite_index=sWarmasterA_WallGrab
  }
}
#define Collision_oCh19_WM_Pathset
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if other.type=0 //Stop
{
  xVel=0
}
else if other.type=1 //Jump
{
  y-=2
  jumpAcc=other.jumpAcc
  yVel=jumpAcc
}
else if other.type=2 //Left wall
{
  jumpAcc=other.jumpAcc
  wallJumpTime=100
}
else if other.type=3 //Right wall
{
  jumpAcc=other.jumpAcc
  wallJumpTime=200
}

with other {instance_destroy()}
