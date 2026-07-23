/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Options submenu.
*/

draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_left)

var tOptAvail,tOptExcess,tOptCurOff;
tOptAvail=mO_CurPos
if tOptAvail>5 {tOptAvail=5}
tOptExcess=5-mO_CurPos
for(i=0;i<tOptAvail;i+=1)
{
  textDropShadow(ds_list_find_value(optNameList,(mO_CurPos-1)-i),contentMenuX+14,contentMenuY+80-(i*15),textColorMain,textColorShadow,1)
  textDropShadow(ds_list_find_value(optValueList,(mO_CurPos-1)-i),contentMenuX+148,contentMenuY+80-(i*15),textColorMain,textColorShadow,1)
}
if tOptExcess>0
{
  tOptCurOff=4-mO_CurPos
  for(i=0;i<tOptExcess;i+=1)
  {
    textDropShadow(ds_list_find_value(optNameList,mO_OptMax-tOptCurOff-1+i),contentMenuX+14,contentMenuY+20+(i*15),textColorMain,textColorShadow,1)
    textDropShadow(ds_list_find_value(optValueList,mO_OptMax-tOptCurOff-1+i),contentMenuX+148,contentMenuY+20+(i*15),textColorMain,textColorShadow,1)
  }
}

var tOptAvail,tOptExcess;
tOptAvail=mO_OptMax-mO_CurPos+1
if tOptAvail>6 {tOptAvail=6}
tOptExcess=6-tOptAvail
for(i=0;i<tOptAvail;i+=1)
{
  textDropShadow(ds_list_find_value(optNameList,(mO_CurPos-1)+i),contentMenuX+14,contentMenuY+80+(i*15),textColorMain,textColorShadow,1)
  textDropShadow(ds_list_find_value(optValueList,(mO_CurPos-1)+i),contentMenuX+148,contentMenuY+80+(i*15),textColorMain,textColorShadow,1)
}
if tOptExcess>0
{
  var tYInc;
  tYInc=75
  for(i=0;i<tOptExcess;i+=1)
  {
    textDropShadow(ds_list_find_value(optNameList,i),contentMenuX+14,contentMenuY+95+tYInc-(tOptExcess*15)+(i*15),textColorMain,textColorShadow,1)
    textDropShadow(ds_list_find_value(optValueList,i),contentMenuX+148,contentMenuY+95+tYInc-(tOptExcess*15)+(i*15),textColorMain,textColorShadow,1)
  }
}

draw_sprite_ext(sPauseM_OptionsFade,0,contentMenuX+1,contentMenuY+14,204,1,0,c_white,1)
if subMenu=7
{
  if mO_CurPos=1
    menuInfoText="Edit the field controls."
  else if mO_CurPos=2
    menuInfoText="Press left or right to change the music volume or press the confirm key to mute or max out the volume."
  else if mO_CurPos=3
    menuInfoText="Press left or right to change the sound volume or press the confirm key to mute or max out the volume."
  else if mO_CurPos=4
    menuInfoText="Show AP earned after defeating an enemy."
  else if mO_CurPos=5
  {
    if global.optShowDamage<2 {menuInfoText="Show the damage dealt to enemies."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=6
  {
    if global.optEnemyHP<2 {menuInfoText="Show enemy life on the bottom-right of the screen when in combat."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=7
    menuInfoText="Give an on-screen warning when health is low."
  else if mO_CurPos=8
    menuInfoText="Display the area name upon entering."
  else if mO_CurPos=9
    menuInfoText="Show current hit combo on screen."
  else if mO_CurPos=10
    menuInfoText="Show current kill chain on screen."
  else if mO_CurPos=11
    menuInfoText="Show current kill streak on screen."
  else if mO_CurPos=12
    menuInfoText="Show the chain meter on screen."
  else if mO_CurPos=13
    menuInfoText="Remember the cursor position when the pause menu is closed."
  else if mO_CurPos=14
    menuInfoText="Higher priorities give the game more CPU time. Use a higher setting if the game suffers from lag."
  else if mO_CurPos=15
    menuInfoText="Set VSync on/off. Turning this off may reduce some lag, but may cause the game window to tear."
  else if mO_CurPos=16
  {
    if global.optShowHUD<2 {menuInfoText="Toggle HUD on/off.#Hey, if you want to play blind and naked, be my guest."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=17
    menuInfoText="Change the cursor speed for the Skill Tree and Map submenu."
  else if mO_CurPos=18
    menuInfoText="Show Primary Attack Types when switching characters or Ability Sets."
  else if mO_CurPos=19
    menuInfoText="Show info when Chao hovers over an enemy."
  else if mO_CurPos=20
    menuInfoText="Show a small window of the idle character in split sections when standing still for 1 second."
  else if mO_CurPos=21
    menuInfoText="Allow Chao to roam on her own when the mouse is not moving.#Note: Turning this off will also disable her possible hints."
  else if mO_CurPos=22
    menuInfoText="Enable Gamepad support. Keep this off if you prefer to use your own software for keybindings."
  else if mO_CurPos=23
    menuInfoText="Display what keys are being pressed."
  else if mO_CurPos=24
    menuInfoText="Press left or right to decrease/increase the window scaling size.#Always in 4:3 ratio.#F3 (or confirm on this menu) toggles the screensize through 1x/2x/3x sizes."
  else if mO_CurPos=25
    menuInfoText="Display your Awesome Score. This value is completely pointless and exists#simply because it can. It tracks everything you've done."
  else if mO_CurPos=26
    menuInfoText="Show Internetz earned when picked up."
  else if mO_CurPos=27
    menuInfoText="For icons depicting when certain mobility options are available:#Turn this on to display those icons below your character instead of at the top-left."
  else if mO_CurPos=28
    menuInfoText="Play a sound when new text boxes appear.#Now you'll never miss a thing again!"
  else if mO_CurPos=29
    menuInfoText="Enable [Up] and [Down] to execute dashing.#Turn this off if you only want dashing initiated with the dash buttons."
  else if mO_CurPos=30
    menuInfoText="Turning this on will cause [Dash Right] to become [Dash Forward], and [Dash Left] to be [Dash Back]."

  draw_set_color(textColorShadow)
  draw_rectangle(contentMenuX+9,contentMenuY+79,contentMenuX+199,contentMenuY+93,1)
  //draw_sprite(sPauseM_AbilArrow,0,contentMenuX+mO_CurX,contentMenuY+mO_CurY) //Display cursor

  //Display scroll bar
  draw_rectangle(contentMenuX+310,contentMenuY+28,contentMenuX+315,contentMenuY+29+(mO_OptMax*4),1)
  draw_set_color(textColorMain)
  draw_rectangle(contentMenuX+311,contentMenuY+25+(mO_CurPos*4),contentMenuX+314,contentMenuY+28+(mO_CurPos*4),0)
}
