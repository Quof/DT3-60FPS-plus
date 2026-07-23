#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
event_inherited()
global.gamePaused=true
fadeAlpha=1
fadeColor=c_black

charJerry=instance_create(80,272,oMisc)
charJerry.sprite_index=sJerryIdle
charJerry.image_speed=0.1
charJerry.type=1

charClaire=instance_create(32,272,oMisc)
charClaire.sprite_index=sClaireIdle
charClaire.image_speed=0.1
charClaire.type=1

charChao=instance_create(56,192,oMisc)
charChao.sprite_index=sChaoFairy
charChao.image_speed=0.4
charChao.type=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if sceneProgress=0
{
  sceneDelay+=1
  if sceneDelay>=30
  {
    fadeAlpha-=0.02
    if fadeAlpha<=0
    {
      sceneDelay=0
      sceneProgress+=1
    }
  }
}
else if sceneProgress=1 and bWaitForInput=false
  msgCreate(0,0,"","When the arrow appears on the bottom-right of the message, press the [J] key to advance the scene further.#If you would like to skip a cutscene, press [M]. Note that not all cutscenes may be skipped.",7,3,oMessageCutscene,1)
else if sceneProgress=2 and bWaitForInput=false
  msgCreate(0,0,"Jerry","So you know what to do Jeremy?",0,3,oMessageCutscene,1)
else if sceneProgress=3 and bWaitForInput=false
  msgCreate(0,0,"Jeremy","Yes, I'm going to send you all to the mainland where Central City is located. Though I doubt I will be able to teleport you directly to the city, so we'll just have to make due with what we have.",0,3,oMessageCutscene,1)
else if sceneProgress=4 and bWaitForInput=false
  msgCreate(0,0,"Jerry","Okay, I'm ready when you are.",0,3,oMessageCutscene,1)
else if sceneProgress=5 and bWaitForInput=false
  msgCreate(0,0,"Claire","So am I.",0,3,oMessageCutscene,1)
else if sceneProgress=6 and bWaitForInput=false
  msgCreate(0,0,"Chao","Beam us up, Jeremy.",0,3,oMessageCutscene,1)
else if sceneProgress=7 and bWaitForInput=false
  msgCreate(0,0,"Jeremy","We're lucky I'm still able to use this teleport function at all. I'm sure the Virus will lock it down after I use it.#Anyway, here we go...",0,3,oMessageCutscene,1)
else if sceneProgress=8
{
  sceneDelay+=1
  if sceneDelay=1
  {
    playSound(global.snd_MMBeamUp,0,1,1)
    oMisc.sprite_index=sPlayerDiscombobulate
    oMisc.image_index=1; oMisc.image_speed=0
  }
  else if sceneDelay=4 {oMisc.image_index=0}
  else if sceneDelay>=5 and sceneDelay<=25 {oMisc.y-=16}
  else if sceneDelay>=40 {sceneDelay=0; sceneProgress+=1}
}
else if sceneProgress=9
{
  fadeAlpha+=0.02
  if fadeAlpha>=1 {sceneProgress+=1}
}
else if sceneProgress=10 {room_goto(rMain_1)}

keyWaitForInput()

if oKeyCodes.kCodePressed[11]=1 //Cutscene skip
{
  bWaitForInput=true
  with oMessageCutscene {instance_destroy()}
  fadeAlpha=1
  sceneProgress=10
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_set_alpha(fadeAlpha)
draw_set_color(fadeColor)
draw_rectangle(0,0,room_width,room_height,0)
