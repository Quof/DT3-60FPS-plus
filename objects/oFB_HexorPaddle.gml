#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
image_speed=0
image_index=1
bossProgress=0
moveSpd=4

topBorder=64
bottomBorder=room_height-48
leftBorder=18
rightBorder=50

maxLife=1000
life=global.finalBossHP

bWillDash=0
dashMeterMax=10000
dashEnergy=dashMeterMax
dashDelay=0

atkProg=0
atkTime=0
atkCycle=0

aimedBulletTime=60
aimedBulletDelay=180

superAimTime=0

convoProg=0
convoTime=0

bulTop=-8
bulBot=room_height+8
lifePercent=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=0
{
  //---------- Movement ----------
  //the dash slows down after the moves at 30fps: above 30fps the tick's slow-down is spread before them (scrTickAcc, scrTickAccBPre), as in oFB_PlayerPaddle
  if gDeltaTime!=1 {moveSpd=scrTickAcc(moveSpd,-0.1*(moveSpd>4),0)} //60fps change (added)
  var tMove; //60fps change (added)
  tMove=(moveSpd+scrTickAccBPre(0))*gDeltaTime //60fps change (added)
  if y>oFB_Ball.y
  {
    //y-=moveSpd
    y-=tMove //60fps change: the paddle moved its full speed every frame (2x/4x as fast at 60/120fps)
    if y<topBorder {y=topBorder}
  }
  if y<oFB_Ball.y
  {
    //y+=moveSpd
    y+=tMove //60fps change: see above
    if y>bottomBorder {y=bottomBorder}
  }

  //if moveSpd>4 {moveSpd-=0.1}
  if gDeltaTime==1 {if moveSpd>4 {moveSpd-=0.1}} //60fps change: above 30fps the slow-down is done by scrTickAcc above
  //if moveSpd>6.8
  if moveSpd>6.8 and gDeltaDoTicks //60fps change: one afterimage per tick (was 2x/4x as many at 60/120fps)
  {
    var tAfterI;
    tAfterI=instance_create(x,y,oEnemyAfterImage)
    tAfterI.sprite_index=sprite_index; tAfterI.image_speed=0; tAfterI.image_blend=c_blue
    tAfterI.depth=26; tAfterI.image_alpha=0.8; tAfterI.imageFade=0.1
    tAfterI.xScaling=0; tAfterI.yScaling=0; tAfterI.xShift=0; tAfterI.yShift=0
    tAfterI.bFollow=1; tAfterI.idFollow=id; tAfterI.xFollow=0; tAfterI.yFollow=0
  }

  //---------- Dash Rules ----------
  //if dashDelay>0 {dashDelay-=1}
  if dashDelay>0 {dashDelay-=1*gDeltaTime} //60fps change: the dash cooldown ran 2x/4x as fast at 60/120fps
  if oFB_Ball.x>=420 and bWillDash=0 and dashEnergy>=2000 and dashDelay=0
  {
    var tChkDist;
    tChkDist=point_distance(0,y,0,oFB_Ball.y)
    if tChkDist>20
    {
      bWillDash=1
    }
  }

  if bWillDash //Dash
  {
    bWillDash=0
    dashDelay=30
    moveSpd=8
    dashEnergy-=2000
  }

  if dashEnergy<dashMeterMax
  {
    //dashEnergy+=5
    dashEnergy+=5*gDeltaTime //60fps change: dash energy refilled 2x/4x as fast at 60/120fps
    if dashEnergy>dashMeterMax {dashEnergy=dashMeterMax}
  }

  //---------- Attack Pattern ----------
  atkTime+=1*gDeltaTime
  if atkProg=1
  {
    if atkTime=40 {var tAtk; tAtk=instance_create(16,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2}
    else if atkTime=80 {var tAtk; tAtk=instance_create(48,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2}
    else if atkTime=120 {var tAtk; tAtk=instance_create(32,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2}
    else if atkTime=160 {var tAtk; tAtk=instance_create(16,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2}
    else if atkTime=200 {var tAtk; tAtk=instance_create(48,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2}
    else if atkTime=240
    {
      var tAtk; tAtk=instance_create(32,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2
      atkCycle+=1
      if atkCycle<2 {atkTime=0}
    }
    else if atkTime=280 {atkTime=0; atkCycle=0; atkProg=2}
  }
  else if atkProg=2
  {
    if atkTime=40
    {
      var tAtk; tAtk=instance_create(16,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2
      tAtk=instance_create(32,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2
    }
    else if atkTime=80
    {
      var tAtk; tAtk=instance_create(32,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2
      tAtk=instance_create(48,bulTop,oFB_PongBullet); tAtk._direction=270; tAtk.moveSpd=2
      atkCycle+=1
      if atkCycle<8 {atkTime=0}
    }
    else if atkTime=160 {atkTime=0; atkCycle=0; atkProg=3}
  }
  else if atkProg=3
  {
    if atkTime=40
    {
      var tAtk; tAtk=instance_create(16,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2
      tAtk=instance_create(48,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2
    }
    else if atkTime=80
    {
      var tAtk; tAtk=instance_create(32,bulBot,oFB_PongBullet); tAtk._direction=90; tAtk.moveSpd=2
      atkCycle+=1
      if atkCycle<8 {atkTime=0}
    }
    else if atkTime=160 {atkTime=0; atkCycle=0; atkProg=1}
  }

  //aimedBulletTime+=1
  aimedBulletTime+=1*gDeltaTime //60fps change: aimed shots came 2x/4x as often at 60/120fps
  if aimedBulletTime>=aimedBulletDelay
  {
    var tAtk; tAtk=instance_create(x-10,y,oFB_PongBullet)
    tAtk._direction=point_direction(x-10,y,oFB_PlayerPaddle.x,oFB_PlayerPaddle.y); tAtk.moveSpd=2
    aimedBulletTime=0
  }

  //superAimTime+=1
  superAimTime+=1*gDeltaTime //60fps change: the aimed volley came 2x/4x as often at 60/120fps
  if superAimTime>=900 and superAimTime mod 2=0
  {
    var tAtk; tAtk=instance_create(x-10,y,oFB_PongBullet)
    tAtk._direction=point_direction(x-10,y,oFB_PlayerPaddle.x,oFB_PlayerPaddle.y); tAtk.moveSpd=2
  }
  if superAimTime>=920 {superAimTime=0}

  //---------- Conversation Progress ----------
  if convoProg=0
  {
    //convoTime+=1
    convoTime+=1*gDeltaTime //60fps change: the opening lines (and the start of the attacks) came 2x/4x as fast at 60/120fps
    if convoTime=30
    {
      msgCreate(60,80,"Jeremy","Oh we're really doing this, aren't we?",0,1,oMessagePerson,0)
      newMessage.fadingTime=80
    }
    else if convoTime=110
    {
      msgCreate(60,80,"Jeremy","Huh, I still have my dash and I can focus move with the jump button.",0,1,oMessagePerson,0)
      newMessage.fadingTime=120
    }
    else if convoTime=230
    {
      msgCreate(60,80,"Hexor","So can I.",0,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    else if convoTime=250
    {
      atkTime=0; atkProg=1
      convoTime=0; convoProg=1
    }
  }
  else if convoProg=2 //Final attack
  {
    //convoTime+=1
    convoTime+=1*gDeltaTime //60fps change: the final barrage fired 2x/4x as often and ended 2x/4x sooner at 60/120fps
    if convoTime mod 3=0
    {
      var tAtk,tDir;
      tDir=point_direction(x-10,y,oFB_PlayerPaddle.x,oFB_PlayerPaddle.y)-26
      for(i=0;i<5;i+=1)
      {
        tAtk=instance_create(x-10,y,oFB_PongBullet)
        tAtk._direction=tDir+(i*13); tAtk.moveSpd=2
      }
    }

    if convoTime=1
    {
      msgCreate(60,80,"Hexor","Try dodging this one.",0,0,oMessagePerson,0)
      newMessage.fadingTime=50
    }
    if convoTime>=200 //End attack
    {
      global.recAreaTrans+=1
      global.finalBossHP=life
      newLifeAmt=round((oFB_PlayerPaddle.maxLife-oFB_PlayerPaddle.life)/2)
      oFB_PlayerPaddle.life+=newLifeAmt
      global.pLife=oFB_PlayerPaddle.life
      global.jeremySuperEnergy=oFB_PlayerPaddle.jeremySuperEnergy
      transition_steps=1; transition_kind=21
      room_goto_fixed(rDistFinal_Round2)
    }
  }

  //Battle Progress
  lifePercent=life/maxLife
  if lifePercent<=0.55 and bossProgress=0
  {
    aimedBulletDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.5 and bossProgress=1
  {
    aimedBulletDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.45 and bossProgress=2
  {
    aimedBulletDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.4 and bossProgress=3
  {
    aimedBulletDelay-=20
    bossProgress+=1
  }
  else if lifePercent<=0.35 and bossProgress=4
  {
    aimedBulletDelay-=20
    convoProg=2
    bossProgress+=1
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sHexor_Main,0,x,y,-1,1,0,c_white,1)
