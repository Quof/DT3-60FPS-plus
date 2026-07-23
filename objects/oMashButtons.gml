#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
/*
Variables needed at creation.
xCenter, yCenter, startJerryX, startJerryY, startClaireX, startClaireY
*/

image_speed=0.33
innerTextColor=make_color_rgb(255,0,0)
outerTextColor=make_color_rgb(255,255,0)

bCanHit=0
atkHits=0
hitSound=0
timeToStop=210

jerryAtk=0
jerryTime=0
claireAtk=0
claireTime=0

idleTime=0

jerryObj=instance_create(0,0,oMisc)
jerryObj.sprite_index=sJerryKneel; jerryObj.image_xscale=-1; jerryObj.depth=15
jerryObj.image_speed=0; jerryObj.type=1
claireObj=instance_create(0,0,oMisc)
claireObj.sprite_index=sClaireHairWhip; claireObj.depth=15
claireObj.image_speed=0; claireObj.type=1

alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
jerryObj.x=startJerryX; jerryObj.y=startJerryY
claireObj.x=startClaireX; claireObj.y=startClaireY
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanHit=1
{
  var tButtonCheck;
  tButtonCheck=0
  for(i=0;i<14;i+=1)
  {
    if oKeyCodes.kCodePressed[i]=1 {tButtonCheck=1}
  }
  if keyboard_check_pressed(vk_anykey) or tButtonCheck=1
  {
    //---------- CHARACTER ATTACK ANIMATION ----------
    if jerryAtk=0
    {
      var tJerryDir; tJerryDir=random(360)
      jerryAtk=irandom_range(1,3)
      if jerryAtk=1 {jerryObj.sprite_index=sJerrySword; jerryObj.image_index=1; jerryObj.image_speed=0}
      else if jerryAtk=2 {jerryObj.sprite_index=sJerryAirDash; jerryObj.image_index=0; jerryObj.image_speed=1}
      else if jerryAtk=3 {jerryObj.sprite_index=sJerryJumpForward; jerryObj.image_index=0; jerryObj.image_speed=1}

      jerryObj.x=xCenter+lengthdir_x(80,tJerryDir); jerryObj.y=yCenter+lengthdir_y(80,tJerryDir)
      jerryObj.visible=1; jerryObj.speed=20; jerryObj.direction=tJerryDir+180; jerryTime=8
      if tJerryDir>90 and tJerryDir<270 {jerryObj.image_xscale=1}
      else {jerryObj.image_xscale=-1}
    }
    else if claireAtk=0
    {
      var tClaireDir; tClaireDir=random(360)
      claireAtk=irandom_range(1,3)
      if claireAtk=1 {claireObj.sprite_index=sClaireThrow; claireObj.image_index=0; claireObj.image_speed=0}
      else if claireAtk=2 {claireObj.sprite_index=sClaireAirDash; claireObj.image_index=0; claireObj.image_speed=0}
      else if claireAtk=3 {claireObj.sprite_index=sClaireAirRoll; claireObj.image_index=0; claireObj.image_speed=1}

      claireObj.x=xCenter+lengthdir_x(80,tClaireDir); claireObj.y=yCenter+lengthdir_y(80,tClaireDir)
      claireObj.visible=1; claireObj.speed=20; claireObj.direction=tClaireDir+180; claireTime=8
      if tClaireDir>90 and tClaireDir<270 {claireObj.image_xscale=1}
      else {claireObj.image_xscale=-1}
    }

    //---------- SCREEN HIT EFFECT ----------
    atkHits+=1
    hitSound=irandom_range(1,3)
    soundPitch=22050+irandom_range(-2050,2050)
    if hitSound=1 {playSound(global.snd_ComicHit1,0,0.95,soundPitch)}
    else if hitSound=2 {playSound(global.snd_ComicHit2,0,0.92,soundPitch)}
    else if hitSound=3 {playSound(global.snd_ComicHit3,0,0.95,soundPitch); hitSound=0}

    var tEffect,tXPos,tYPos,tDir;
    tXPos=view_xview[0]+240-120+random(240)
    tYPos=view_yview[0]+176-88+random(176)
    tDir=random(360)
    for(i=0;i<6;i+=1)
    {
      tEffect=instance_create(tXPos,tYPos,oEffectB)
      tEffect.type=2; tEffect.sprite_index=sScaledCollision
      tEffect.image_alpha=0.8; tEffect.image_xscale=16+irandom(16); tEffect.direction=tDir
      tEffect.image_angle=tDir; tEffect.speed=8+random(2)
      tEffect.decay=7; tEffect.image_blend=make_color_rgb(255,255,0)
      tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
      tDir+=360/6
    }

    if atkHits mod 5=0
    {
      var tFlash;
      tFlash=instance_create(0,0,oScreenFlash)
      tFlash.image_alpha=0.6
      tFlash.fadeSpeed=0.2
    }
    instance_create(tXPos,tYPos,oMashHit)
  }
}

//---------- Count down character attack time ----------
if jerryTime>0
{
  jerryTime-=1
  if jerryTime=0
  {
    jerryAtk=0
    jerryObj.visible=0
  }
}
if claireTime>0
{
  claireTime-=1
  if claireTime=0
  {
    claireAtk=0
    claireObj.visible=0
  }
}

//---------- If player waits and does nothing ----------
if atkHits=0
{
  idleTime+=1
  if idleTime=360 {msgCreate(0,0,"Jerry","Uh so... we going to do anything?",0,2,oMessagePerson,0); newMessage.fadingTime=70}
  else if idleTime=430 {msgCreate(0,0,"Claire","Just waiting on you, buddy.",0,2,oMessagePerson,0); newMessage.fadingTime=70}
  else if idleTime=500 {msgCreate(0,0,"Jerry","Why can't you start it?",0,2,oMessagePerson,0); newMessage.fadingTime=60}
  else if idleTime=560 {msgCreate(0,0,"Claire","I figured you'd want to lead on something like this.",0,2,oMessagePerson,0); newMessage.fadingTime=120}
  else if idleTime=680 {msgCreate(0,0,"Jerry","Just trying not to be my sometimes over-zealous self.",0,2,oMessagePerson,0); newMessage.fadingTime=120}
  else if idleTime=800 {msgCreate(0,0,"Claire","Hey that's a change!",0,2,oMessagePerson,0); newMessage.fadingTime=60}
  else if idleTime=860 {msgCreate(0,0,"Jerry","I know right?! I'm being all super self-aware Jerry right now.",0,2,oMessagePerson,0); newMessage.fadingTime=140}
  else if idleTime=1000 {msgCreate(0,0,"Claire","Oh man everyone, I'm Jerry and I've got quirks!",0,2,oMessagePerson,0); newMessage.fadingTime=120}
  else if idleTime=1120 {msgCreate(0,0,"Jerry","Are you making fun of me?",0,2,oMessagePerson,0); newMessage.fadingTime=70}
  else if idleTime=1190 {msgCreate(0,0,"Claire","We're both making fun of you.",0,2,oMessagePerson,0); newMessage.fadingTime=70}
  else if idleTime=1260 {msgCreate(0,0,"Jerry","Touche.",0,2,oMessagePerson,0); newMessage.fadingTime=60}
}

//---------- Count down till finisher is done ----------
if atkHits>0
{
  timeToStop-=1
  if timeToStop=0 {io_clear()}
}

if bCanHit>=2
{
  bCanHit+=1
  if bCanHit=45
  {
    if atkHits>global.recMostTeamHits {global.recMostTeamHits=atkHits}
    if atkHits>=150 //Achievement
    {
      var tCheckAchieve;
      tCheckAchieve=string_char_at(global.tokenRecognitions,32)
      if tCheckAchieve="0"
      {
        var tAchievement;
        tAchievement=instance_create(0,0,oAchievementNotice)
        tAchievement.myAchievement="Press Everything to Not Die"; tAchievement.checkNum=32
      }
    }

    with jerryObj {instance_destroy()}
    with claireObj {instance_destroy()}
    instance_destroy()
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if bCanHit=1
{
  draw_sprite(sMashButtonPrompt,image_index,view_xview[0]+240,view_yview[0]+84)
}

if atkHits>0
{
  draw_set_alpha(1)
  draw_set_font(fnt_MashButtons)
  draw_set_halign(fa_left)
  textDropShadow(string("HITS ") +string(atkHits) +string("!!"),view_xview[0]+24,view_yview[0]+112,innerTextColor,outerTextColor,3)
}
