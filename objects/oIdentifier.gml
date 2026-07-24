#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//showEmote(oIdentifier,0,-6,sEmExcite)
image_speed=0.4
effectDelay=3
effectTime=0

currentColor=0

bChaoActive=1 //turn off if Chao is not available
fairyAutoRoam=false //whether the fairy is on automove
bCanScan=1 //if Chao can scan enemies
autoMoveDelay=0 //how long the mouse can't be moved till the fairy goes into automove
willFollowMouse=1 //if Chao will follow mouse movement
mouseWindowX1=display_mouse_get_x()
mouseWindowY1=display_mouse_get_y()
mouseWindowX1=display_mouse_get_x()
mouseWindowY1=display_mouse_get_y()
maxSpeed=0 //max flight speed for fairy in automove
followTarget=oPlayer1
tgtOffsetX=0
tgtOffsetY=0

bTargetActive=0
chaoTargetFrm=0
chaoTargetX=0
chaoTargetY=0

treasureFind=0
heartEmote=100

chaoGraze=0
chaoGrazeMax=1000
grazePercent=0
degradeDelay=0
dotPointer=0

chaoEndAssisted=0 //effect of Chao assisting the player when they fall off the map during Warship escape sequence
chaoLightAssistAlpha=0

alarm[0]=1

xvel=0
yvel=0


//emote types
/*
emoteType=0
emoteTime=0
emoteFrame=0
emoteScale=0.1
emoteAlpha=1

EM_EXCITE=1
EM_IDEA=2
EM_MAD=3
EM_LOVE=4
EM_EMBARRASS=5
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("deactivate") {bChaoActive=0}
else
{
  if global.chaoRecognition=1
  {
    heartEmote=0
  }
}
global.chaoRecognition=0

if global.gameProgress>=5580 and room=rCh21_WastelandA
{
  followTarget=oNPC_GeneralA
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  event_user(0) //Treasure find

  if room=rAbomF
  {
    willFollowMouse=1
    fairyAutoRoam=0

    if chaoGraze>0 and global.gamePaused=0
    {
      if degradeDelay<=0
      {
        chaoGraze-=3
        if chaoGraze<0 {chaoGraze=0}
      }
      else {degradeDelay-=1*gDeltaTime}
    }
    grazePercent=chaoGraze/chaoGrazeMax
  }
  //-------------------- Movement --------------------
  if fairyAutoRoam=false //Chao tracks mouse
  {
    if willFollowMouse=1
    {
      if room=rAbomF //Virus Parasite
      {
        if global.gamePaused=0
        {
          if point_distance(x,y,mouse_x,mouse_y)<=32
          {
            dotPointer=0
            x=mouse_x; y=mouse_y
            xvel=0; yvel=0
          }
          else
          {
            dotPointer=1
            //direction=point_direction(x,y,mouse_x,mouse_y)
            //speed=32
            xvel=mouse_x-x
            yvel=mouse_y-y
            var len;
            len = sqrt(xvel*xvel + yvel+yvel)
            xvel *= 32/len
            yvel *= 32/len
          }
        }
        else
        {
          dotPointer=1
          //speed=0
          xvel = 0
          yvel = 0
        }
      }
      else
      {
        x=mouse_x; y=mouse_y
      }
    }
  }
  else if fairyAutoRoam=true and global.optChaoRoam=1 //Chao on automove
  {
    if global.gameProgress<=2150 and global.gameProgress>=2250 //If Jerry is not unconscious in the Vault
    {
      if global.optChaoAttack=1 //Tell Chao to go to nearest enemy to her
      {
        if instance_exists(oEnemyBase)
        {
          followTarget=instance_nearest(x,y,oEnemyBase)
        }
      }
      else if global.optChaoAttack=2 //Tell Chao to go to nearest enemy to player
      {
        if instance_exists(oEnemyBase)
        {
          followTarget=instance_nearest(oPlayer1.x,returnPlayerYCenter(),oEnemyBase)
        }
      }
    }

    if followTarget!=oPlayer1
    {
      if !instance_exists(followTarget) {followTarget=oPlayer1}
    }
    tgtOffsetX=0; tgtOffsetY=0

    if followTarget=oPlayer1
    {
      tgtOffsetY=-26
      if oPlayer1.xVel!=0
      {
        tgtOffsetX=128*oPlayer1.image_xscale
        myDist=point_distance(x,y,followTarget.x+tgtOffsetX,followTarget.y)
      }
      else {myDist=point_distance(x,y,followTarget.x,followTarget.y)}
    }
    else {myDist=point_distance(x,y,followTarget.x,followTarget.y)}

    myDist=round(myDist/32)
    if myDist>12 {myDist=12}
    if global.optChaoAttack=0
    {
      if myDist<2 {myDist=2}
    }
    else
    {
      if myDist<2.5 {myDist=2.5}
    }
    maxSpeed=myDist

    if x>followTarget.x+tgtOffsetX
    {
      if xvel>-maxSpeed {xvel-=0.1*gDeltaTime}
      else {xvel=-maxSpeed}
    }
    else if x<followTarget.x+tgtOffsetX
    {
      if xvel<maxSpeed {xvel+=0.1*gDeltaTime}
      else {xvel=maxSpeed}
    }
    if y>followTarget.y+tgtOffsetY
    {
      if yvel>-maxSpeed {yvel-=0.1*gDeltaTime}
      else {yvel=-maxSpeed}
    }
    else if y<followTarget.y+tgtOffsetY
    {
      if yvel<maxSpeed {yvel+=0.1*gDeltaTime}
      else {yvel=maxSpeed}
    }
  }
  else {xvel=0; yvel=0}

  if global.gamePaused=false
  {
    effectTime+=1*gDeltaTime
    if effectTime>=effectDelay
    {
      var tFFScl,tEffect;
      tFFScl=random(0.1)
      tEffect=instance_create(x,y,oEffectB)
      tEffect.type=3; tEffect.sprite_index=sEfFirefly; tEffect.newBlend=1
      tEffect.image_alpha=0.3; tEffect.image_xscale=0.15+tFFScl; tEffect.image_yscale=0.15+tFFScl
      tEffect.direction=random(360); tEffect.speed=random(0.5)+0.5; tEffect.friction=random(0.01)+0.01
      tEffect.fadeSpd=0.005; tEffect.image_blend=make_color_rgb(random(50),255,random(50))
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.followID=-1; tEffect.rotation=0
      effectTime=0
    }
  }

  if willFollowMouse=1 //Check if the mouse has been moved
  {
    mouseWindowX2=display_mouse_get_x()
    mouseWindowY2=display_mouse_get_y()
    if mouseWindowX1!=mouseWindowX2
    {
      mouseWindowX1=mouseWindowX2
      autoMoveDelay=0
      if fairyAutoRoam=true
      {
        //display_mouse_set(x,y)
        fairyAutoRoam=false
      }
    }
    if mouseWindowY1!=mouseWindowY2
    {
      mouseWindowY1=mouseWindowY2
      autoMoveDelay=0
      if fairyAutoRoam=true
      {
        //display_mouse_set(x,y)
        fairyAutoRoam=false
      }
    }
  }
  if autoMoveDelay<60 //Keep Chao from moving if the mouse is used by the player
  {
    if room!=rAbomF {xvel=0; yvel=0}
    if global.optChaoRoam=1 {autoMoveDelay+=1*gDeltaTime}
    if autoMoveDelay>=60 {fairyAutoRoam=true}
  }

  if heartEmote<100 //When the player loses enough times in one map and then transitions to a new one
  {
    heartEmote+=1*gDeltaTime
    if heartEmote>=35
    {
      showEmote(oIdentifier,0,-6,sEmLove)
      heartEmote=100
    }
  }

  if chaoEndAssisted>0 //When Chao assists the player during the Warship escape sequence
  {
    chaoEndAssisted+=1
    if chaoEndAssisted mod 2=0
    {
      if chaoLightAssistAlpha=0.25 {chaoLightAssistAlpha=0.75}
      else {chaoLightAssistAlpha=0.25}
    }
    if chaoEndAssisted>=145
    {
      chaoLightAssistAlpha=0.25
      chaoEndAssisted=0
    }
  }
}

x += xvel*gDeltaTime
y += yvel*gDeltaTime
#define Mouse_52
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  if room!=rEnd_SceneA
  {
    if currentColor<=5 //Normal Spray
    {
      var tFFEScl,tEEffect;
      tFFEScl=random(0.1)
      tEEffect=instance_create(x,y,oEffectB)
      tEEffect.type=3; tEEffect.sprite_index=sEfFirefly; tEEffect.newBlend=1
      tEEffect.image_alpha=0.3; tEEffect.image_xscale=0.15+tFFEScl; tEEffect.image_yscale=0.15+tFFEScl
      tEEffect.direction=random(360); tEEffect.speed=random(0.5)+0.5; tEEffect.friction=random(0.005)+0.005
      tEEffect.fadeSpd=0.0025
      if currentColor=0
        tEEffect.image_blend=make_color_rgb(random(50),255,random(50))
      else if currentColor=1
        tEEffect.image_blend=c_red
      else if currentColor=2
        tEEffect.image_blend=c_blue
      else if currentColor=3
        tEEffect.image_blend=c_yellow
      else if currentColor=4
        tEEffect.image_blend=c_silver
      else if currentColor=5
        tEEffect.image_blend=make_color_rgb(random(255),random(255),random(255))
      tEEffect.AccelX=0; tEEffect.AccelY=0; tEEffect.followID=-1; tEEffect.rotation=0
    }
    else if currentColor=6 //Drawing on screen
    {
      instance_create(x,y,oEfChaoDraw)
    }
  }
}
#define Mouse_53
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bChaoActive=1
{
  var tEfCir;
  tEfCir=instance_create(x,y,oEfCircleSoftFade)
  tEfCir.image_alpha=0.6; tEfCir.myRad=4; tEfCir.radScl=2; tEfCir.fadeSpeed=0.06
}
#define Mouse_54
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  if bTargetActive=0
  {
    playSound(global.snd_InfoOn,0,1,1)
    chaoTargetX=x
    chaoTargetY=y
    bTargetActive=1
  }
  else
  {
    playSound(global.snd_InfoOff,0,1,1)
    bTargetActive=0
  }
}
#define Mouse_60
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  if currentColor>0
  {
    currentColor-=1
    if currentColor=5 {with oEfChaoDraw {instance_destroy()}}
  }
}
#define Mouse_61
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  if currentColor<6
    currentColor+=1
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
///ITEM FINDER
if global.itemFinder=1
{
  treasureFind+=1
  if treasureFind=35
  {
    var tCheckItem;
    tCheckItem=0
    if instance_exists(oHeartPiece) {tCheckItem=1}
    if instance_exists(oMoneyChest) {tCheckItem=1}
    if instance_exists(oArrowQuiver) {tCheckItem=1}
    if instance_exists(oHeartEnergy) {tCheckItem=1}
    if instance_exists(oMissilePack) {tCheckItem=1}
    if instance_exists(oGamePower) {tCheckItem=1}
    if instance_exists(oAirUpgrade) {tCheckItem=1}
    if instance_exists(oWalletBoost) {tCheckItem=1}
    if instance_exists(oAPBoost) {tCheckItem=1}
    if instance_exists(oWeaponLevelUpgrade) {tCheckItem=1}
    if instance_exists(oLinkBombUpgrade) {tCheckItem=1}
    if instance_exists(oMorphBombUpgrade) {tCheckItem=1}
    if instance_exists(oMMBoostedCharge) {tCheckItem=1}
    if instance_exists(oMetPick_SpringBall) {tCheckItem=1}

    if tCheckItem=1
    {
      if global.optChaoItemWarn=1 {playSound(global.snd_Chao_Hey,0,1,20050+random(4000))}
      showEmote(oIdentifier,0,-6,sEmTreasure)
      heartEmote=100
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gameOver=false and bChaoActive=1
{
  if bTargetActive=1
  {
    chaoTargetFrm+=0.2
    draw_sprite(sChaoTarget,chaoTargetFrm,chaoTargetX,chaoTargetY)
  }

  if dotPointer=1
  {
    draw_set_color(c_yellow)
    draw_set_alpha(1)
    draw_rectangle(mouse_x-1,mouse_y-1,mouse_x+1,mouse_y+1,0)
  }
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)

  if chaoEndAssisted>0
  {
    draw_sprite_ext(sEfPlayerTrail,0,x,y,2,2,image_angle,image_blend,chaoLightAssistAlpha)
  }
}

//-------------------- emotes --------------------
/*
if global.gameOver=false
{
  if emoteType=EM_EXCITE //-------------------- Excited --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmExcite,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_IDEA //-------------------- Idea --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmIdea,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_MAD //-------------------- Mad --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    if emoteTime mod 4=0
    {
      emoteFrame+=1
      if emoteFrame=3
        emoteFrame=0
    }
    draw_sprite_ext(sEmMad,emoteFrame,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_LOVE //-------------------- Love --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmLove,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }
  else if emoteType=EM_EMBARRASS //-------------------- Embarrass --------------------
  {
    if emoteScale<1
      emoteScale+=0.1
    draw_sprite_ext(sEmEmbarrass,0,x,bbox_top-4,emoteScale,emoteScale,0,c_white,emoteAlpha)
  }

  if emoteType>0 //fade emotes
  {
    emoteTime+=1
    if emoteTime>=35
    {
      emoteAlpha-=0.1
      if emoteAlpha<=0
      {
        emoteTime=0
        emoteType=0
        emoteFrame=0
        emoteScale=0.1
        emoteAlpha=1
      }
    }
  }
}
