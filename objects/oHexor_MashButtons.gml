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

bCanHit=1
atkHits=0
hitSound=0
timeToStop=210

charAnim=1

idleTime=0

jerryObj=instance_create(0,0,oMisc)
jerryObj.sprite_index=sJerryKneel; jerryObj.image_xscale=-1; jerryObj.depth=15
jerryObj.image_speed=0; jerryObj.type=1
claireObj=instance_create(0,0,oMisc)
claireObj.sprite_index=sClaireHairWhip; claireObj.depth=15
claireObj.image_speed=0; claireObj.type=1

alarm[0]=1
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
    var playerAttack;
    if charAnim=0
    {
      oPlayer1.sprite_index=sJF_Atk_PunchA; oPlayer1.image_index=0
      playerAttack=instance_create(x+(17*image_xscale),y-49,oJFinAtk_A); playerAttack.image_xscale=image_xscale
    }
    else if charAnim=1
    {
      oPlayer1.sprite_index=sJF_Atk_KickA; oPlayer1.image_index=1
      playerAttack=instance_create(x+(21*image_xscale),y-40,oJFinAtk_B); playerAttack.image_xscale=image_xscale
    }
    else if charAnim=2
    {
      oPlayer1.sprite_index=sJF_Atk_KickB; oPlayer1.image_index=1
      playerAttack=instance_create(x+(20*image_xscale),y-46,oJFinAtk_C); playerAttack.image_xscale=image_xscale
    }

    charAnim+=1
    if charAnim>=3 {charAnim=0}

    //---------- SCREEN HIT EFFECT ----------
    atkHits+=1
    hitSound=irandom_range(1,3)
    soundPitch=22050+irandom_range(-2050,2050)
    if hitSound=1 {playSound(global.snd_ComicHit1,0,0.95,soundPitch)}
    else if hitSound=2 {playSound(global.snd_ComicHit2,0,0.92,soundPitch)}
    else if hitSound=3 {playSound(global.snd_ComicHit3,0,0.95,soundPitch); hitSound=0}

    var tEffect,tXPos,tYPos,tDir;
    tXPos=view_xview[0]+240+random_range(-112,112)
    tYPos=view_yview[0]+160+random(160)
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

//---------- Count down till finisher is done ----------
if atkHits>100
{
  io_clear()
  oEvCh21MainA.sceneProgress=30
  instance_destroy()
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
