/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Options submenu.
*/

draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_middle)
draw_sprite(sPauseM_OptionsHeader,0,contentMenuX+170,contentMenuY+26)
textDropShadow(global.ctrlCharSwap,contentMenuX+127,contentMenuY+20,textColorMain,textColorShadow,1)
textDropShadow(global.ctrlAbilSwap,contentMenuX+213,contentMenuY+20,textColorMain,textColorShadow,1)
//Display option submenu
var tXMarkCheck,tMarkW,tMarkH;
tXMarkCheck=0
tMarkW=6; tMarkH=2
if mO_OptSubMenu=1
{
  tXMarkCheck=147
  draw_set_alpha(0.5)
  textDropShadow("AUDIO",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("GRAPHICS",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("CONTROL",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}
else if mO_OptSubMenu=2
{
  tXMarkCheck=155
  draw_set_alpha(0.5)
  textDropShadow("CONTROL",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("DISPLAY",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("GRAPHICS",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}
else if mO_OptSubMenu=3
{
  tXMarkCheck=163
  draw_set_alpha(0.5)
  textDropShadow("GRAPHICS",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("GAMEPLAY",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("DISPLAY",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}
else if mO_OptSubMenu=4
{
  tXMarkCheck=171
  draw_set_alpha(0.5)
  textDropShadow("DISPLAY",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("UNREAL GUY",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("GAMEPLAY",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}
else if mO_OptSubMenu=5
{
  tXMarkCheck=179
  draw_set_alpha(0.5)
  textDropShadow("GAMEPLAY",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("AUDIO",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("UNREAL GUY",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}
else if mO_OptSubMenu=6
{
  tXMarkCheck=187
  draw_set_alpha(0.5)
  textDropShadow("UNREAL GUY",contentMenuX+76,contentMenuY+20,textColorMain,textColorShadow,1)
  textDropShadow("CONTROL",contentMenuX+264,contentMenuY+20,textColorMain,textColorShadow,1)
  draw_set_alpha(1)
  textDropShadow("AUDIO",contentMenuX+170,contentMenuY+20,textColorMain,textColorShadow,1)
}

//Show current option submenu placement
draw_set_color(textColorMain)
draw_rectangle(contentMenuX+tXMarkCheck,contentMenuY+34,contentMenuX+tXMarkCheck+tMarkW,contentMenuY+34+tMarkH,0)

draw_set_halign(fa_left)
if mO_OptSubMenu=1 //------------------------- CONTROL -------------------------
{
  textDropShadow("Change Controls",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("Gamepad Setup",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Gamepad Input",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("D-Pad Dash",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Right is Forward",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow("Show Key State",contentMenuX+28,contentMenuY+103,textColorMain,textColorShadow,1)
  textDropShadow("Cursor Repeat Speed",contentMenuX+28,contentMenuY+115,textColorMain,textColorShadow,1)
  textDropShadow("Keep Menu Position",contentMenuX+28,contentMenuY+127,textColorMain,textColorShadow,1)
  textDropShadow("Swap Type",contentMenuX+28,contentMenuY+139,textColorMain,textColorShadow,1)

  if global.optGamePad=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  else if global.optGamePad=1 {textDropShadow("On",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  if global.optDPadDash=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optDPadDash=1 {textDropShadow("On",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  if global.optRightIsForward=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  else if global.optRightIsForward=1 {textDropShadow("On",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  if global.optShowKeyState=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  else if global.optShowKeyState=1 {textDropShadow("On",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  textDropShadow(global.optCursorRepeat,contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)
  if global.optKeepMenuPos=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  else if global.optKeepMenuPos=1 {textDropShadow("On",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  if global.optSwapType=0 {textDropShadow("Standard",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.optSwapType=1 {textDropShadow("Dedicated",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.optSwapType=2 {textDropShadow("Dedicated (Fixed)",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.optSwapType=3 {textDropShadow("Hold+Direction",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}

  if mO_CurPos=1 {menuInfoText="Change the control setup. This is for keyboard controls only. It only changes gamepad controls if you're using 3rd party software to bind keys to controller inputs."}
  else if mO_CurPos=2 {menuInfoText="Change the gamepad control setup. This is only if you're using the built in gamepad controls. (Turn on 'Gamepad Input' in the next option down for these to take effect.)"}
  else if mO_CurPos=3 {menuInfoText="Enable Gamepad support. Keep this off if you prefer to use your own software for keybindings."}
  else if mO_CurPos=4 {menuInfoText="Enable [Up] and [Down] to execute dashing.#Turn this off if you only want dashing initiated with the dash buttons."}
  else if mO_CurPos=5 {menuInfoText="Turning this on will cause [Dash Right] to become [Dash Forward], and [Dash Left] to be [Dash Back].#Experiment with these (when dashing is obtained) to see which suits you best."}
  else if mO_CurPos=6 {menuInfoText="Display what keys are being pressed."}
  else if mO_CurPos=7 {menuInfoText="Change the cursor speed for the Skill Tree and Map submenu."}
  else if mO_CurPos=8 {menuInfoText="Remember the cursor position when the pause menu is closed."}
  else if mO_CurPos=9
  {
    if global.optSwapType=0 {menuInfoText="Character Swap changes characters, Ability Swap changes abilities... yep."}
    else if global.optSwapType=1 {menuInfoText="Each character gets their own dedicated button. For example, pressing the Character Swap button will always change to Jerry if he is not the active character. If he is active, it will change his ability set. The Ability Swap button would be dedicated to Claire."}
    else if global.optSwapType=2 {menuInfoText="Same as Dedicated, but swapping to the other character defaults to their primary melee Ability Set."}
    else if global.optSwapType=3 {menuInfoText="To swap characters and abilities, hold down the Ability Swap button and press a directional key to swap to a character and/or ability. When abilities are available, the HUD will note which direction to press. The Character Swap key is for special cases, otherwise it functions the same as Standard."}
  }
}
else if mO_OptSubMenu=2 //------------------------- GRAPHICS -------------------------
{
  textDropShadow("Game Priority",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("V-Sync",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Window Scaling",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("Window Resizing",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Show Low Health Warn",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow("Game Over Settings",contentMenuX+28,contentMenuY+103,textColorMain,textColorShadow,1)
  textDropShadow("Player Trail",contentMenuX+28,contentMenuY+115,textColorMain,textColorShadow,1)
  textDropShadow("Weapon Trail",contentMenuX+28,contentMenuY+127,textColorMain,textColorShadow,1)
  textDropShadow("Jerry's Hat",contentMenuX+28,contentMenuY+139,textColorMain,textColorShadow,1)
  textDropShadow("Claire's Hat",contentMenuX+28,contentMenuY+151,textColorMain,textColorShadow,1)

  if global.gamePriority=0 {textDropShadow("Normal",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else if global.gamePriority=1 {textDropShadow("High",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else if global.gamePriority=2 {textDropShadow("Highest",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  if global.optVSync=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  else if global.optVSync=1 {textDropShadow("On",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  textDropShadow(string(global.optWindowSize) +string("x"),contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)
  if global.optCanResizeWindow=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optCanResizeWindow=1 {textDropShadow("On",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  if global.optLowHealthWarn=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  else if global.optLowHealthWarn=1 {textDropShadow("On",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  if global.optBitrateExplosion=0 {textDropShadow("Normal",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  else if global.optBitrateExplosion=1 {textDropShadow("Reduce Static Effect",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  else if global.optBitrateExplosion=2 {textDropShadow("Auto Skip",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  if global.optPlayerTrail=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  else if global.optPlayerTrail=1 {textDropShadow("On",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  if global.optWeaponTrail=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  else if global.optWeaponTrail=1 {textDropShadow("On",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}

  hatSpriteJ=sNull
  hatSpriteC=sNull
  if global.wearingHatJ=0 {textDropShadow("No hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.wearingHatJ=1 {textDropShadow("Classy Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_01}
  else if global.wearingHatJ=2 {textDropShadow("Top Hat?",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_02}
  else if global.wearingHatJ=3 {textDropShadow("Cap... Hat??",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_03}
  else if global.wearingHatJ=4 {textDropShadow("Ah yeah, Crown Hat!",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_04}
  else if global.wearingHatJ=5 {textDropShadow("!Watermelon Hat!",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_05}
  else if global.wearingHatJ=6 {textDropShadow("Party Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_06}
  else if global.wearingHatJ=7 {textDropShadow("Applejack's Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_07}
  else if global.wearingHatJ=8 {textDropShadow("Wing Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_08}
  else if global.wearingHatJ=9 {textDropShadow("Bird Hat!!!",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_09}
  else if global.wearingHatJ=10 {textDropShadow("Arby's Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_10}
  else if global.wearingHatJ=11 {textDropShadow("Wizard Hat (But no robe)",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_11}
  else if global.wearingHatJ=12 {textDropShadow("Bitchen Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_12}
  else if global.wearingHatJ=13 {textDropShadow("Buttface Hat",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_13}
  else if global.wearingHatJ=14 {textDropShadow("Cat in the Hat... Hat?",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_14}
  else if global.wearingHatJ=15 {textDropShadow("Twitch Hat?",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1); hatSpriteJ=sDLC_Hat_15}

  if global.wearingHatC=0 {textDropShadow("No hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1)}
  else if global.wearingHatC=1 {textDropShadow("Classy Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_01}
  else if global.wearingHatC=2 {textDropShadow("Top Hat?",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_02}
  else if global.wearingHatC=3 {textDropShadow("Cap... Hat??",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_03}
  else if global.wearingHatC=4 {textDropShadow("Ah yeah, Crown Hat!",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_04}
  else if global.wearingHatC=5 {textDropShadow("!Watermelon Hat!",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_05}
  else if global.wearingHatC=6 {textDropShadow("Party Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_06}
  else if global.wearingHatC=7 {textDropShadow("Applejack's Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_07}
  else if global.wearingHatC=8 {textDropShadow("Wing Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_08}
  else if global.wearingHatC=9 {textDropShadow("Bird Hat!!!",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_09}
  else if global.wearingHatC=10 {textDropShadow("Arby's Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_10}
  else if global.wearingHatC=11 {textDropShadow("Wizard Hat (But no robe)",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_11}
  else if global.wearingHatC=12 {textDropShadow("Bitchen Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_12}
  else if global.wearingHatC=13 {textDropShadow("Buttface Hat",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_13}
  else if global.wearingHatC=14 {textDropShadow("Cat in the Hat... Hat?",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_14}
  else if global.wearingHatC=15 {textDropShadow("Twitch Hat?",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1); hatSpriteC=sDLC_Hat_15}

  if mO_CurPos=9 or mO_CurPos=10
  {
    var tMainHatMenuX,tMainHatMenuY;
    tMainHatMenuX=contentMenuX+124
    tMainHatMenuY=contentMenuY+28
    draw_sprite(sPauseM_HatMenu,0,tMainHatMenuX,tMainHatMenuY)
    draw_sprite(hatSpriteJ,0,tMainHatMenuX-50,tMainHatMenuY+70)
    draw_sprite(hatSpriteC,0,tMainHatMenuX+50,tMainHatMenuY+70)
  }

  if mO_CurPos=1 {menuInfoText="Higher priorities give the game more CPU time. Use a higher setting if the game suffers from lag."}
  else if mO_CurPos=2 {menuInfoText="Set V-Sync on/off. Turning this off may reduce some lag, but may cause the game window to tear."}
  else if mO_CurPos=3 {menuInfoText="Press left or right to decrease/increase the window scaling size.#Always in 4:3 ratio.#F3 (or Confirm on this menu) toggles the screensize through 1x/2x/3x sizes."}
  else if mO_CurPos=4 {menuInfoText="Turning this off locks the mouse from being able to resize the window."}
  else if mO_CurPos=5 {menuInfoText="Give an on-screen warning when health is low. Keep this off if you want to keep your bitrate low when recording the game. Goes well with the option below this."}
  else if mO_CurPos=6
  {
    if global.optBitrateExplosion=0 {menuInfoText="Normal Game Over settings."}
    else if global.optBitrateExplosion=1 {menuInfoText="Removes the 'STATIC BITRATE EXPLOSIN' when you get a Game Over. In other words, you no longer get that static effect when you lose. Useful to those who record their gameplay and want to keep filesizes lower."}
    else if global.optBitrateExplosion=2 {menuInfoText="Will return to game play and skip the Game Over screen upon death. Not recommended for first time players."}
  }
  else if mO_CurPos=7 {menuInfoText="When this is on, the player character will leave a trail behind them.#Note from Zephyr: I sometimes used this for testing things. Have fun, though I recommend having it off for most things."}
  else if mO_CurPos=8 {menuInfoText="When this is on, some of your weapons will leave a trail behind them.#Note from Zephyr: Same as above."}
  else if mO_CurPos=9 or mO_CurPos=10 {menuInfoText="Wear various kinds of hats!#Press left or right to change hats. Confirm will remove your hat."}
}
else if mO_OptSubMenu=3 //------------------------- DISPLAY -------------------------
{
  textDropShadow("Show HUD",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("Centralize Mobility HUD",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Show Split Window",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("Show Combat Awards",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Show Chain Time",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow("Show Area",contentMenuX+28,contentMenuY+103,textColorMain,textColorShadow,1)
  textDropShadow("Show Awesome Points",contentMenuX+28,contentMenuY+115,textColorMain,textColorShadow,1)
  textDropShadow("Show Map Header",contentMenuX+28,contentMenuY+127,textColorMain,textColorShadow,1)
  textDropShadow("Show Death Counter",contentMenuX+28,contentMenuY+139,textColorMain,textColorShadow,1)

  if global.optShowHUD=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else if global.optShowHUD=1 {textDropShadow("On",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else {textDropShadow("Disabled",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  if global.optCentralizeHUD=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  else if global.optCentralizeHUD=1 {textDropShadow("On",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  textDropShadow(global.optSplitWindow,contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)
  if global.optShowCombatAward=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optShowCombatAward=1 {textDropShadow("On",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  if global.optShowChainMeter=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  else if global.optShowChainMeter=1 {textDropShadow("On",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  if global.optShowArea=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  else if global.optShowArea=1 {textDropShadow("On",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  if global.optShowScore=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  else if global.optShowScore=1 {textDropShadow("On",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  if global.optShowMapHeader=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  else if global.optShowMapHeader=1 {textDropShadow("On",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  if global.optDeathCounter=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.optDeathCounter=1 {textDropShadow("On",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}

  if mO_CurPos=1
  {
    if global.optShowHUD<2 {menuInfoText="Toggle HUD on/off.#Hey, if you want to play blind and naked, be my guest."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=2 {menuInfoText="For icons depicting when certain mobility options are available.#Turn this on to display those icons below your character instead of the top-left of the screen."}
  else if mO_CurPos=3 {menuInfoText="Display a small window of the idle character in split sections when standing still for x seconds. x is the amount of frames you must stand still. 30 = 1 second.#0 for off; 1 is always on; max = 60.#Press left or right to change this."}
  else if mO_CurPos=4 {menuInfoText="Display current hit combos, kill chains, and kill streaks on screen."}
  else if mO_CurPos=5 {menuInfoText="Display the combo chain meter on screen."}
  else if mO_CurPos=6 {menuInfoText="Display the area name upon entry."}
  else if mO_CurPos=7 {menuInfoText="Display your Awesome Score. This value is completely pointless and exists simply because it can. It tracks everything you've done."}
  else if mO_CurPos=8 {menuInfoText="Display the map header, the one displayed in the game's window header, when entering a map. This is useful if you want to read those map headers but prefer to play fullscreen. Note that if Jeremy or Chao are blocked, for story purposes, this option will not work."}
  else if mO_CurPos=9 {menuInfoText="Display a death counter on the bottom-left of the screen. Because why not?"}
}
else if mO_OptSubMenu=4 //------------------------- GAMEPLAY -------------------------
{
  textDropShadow("Show Damage",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("Show AP Earned",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Show Enemy HP",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("Show Money Pickup",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Show Atk Type",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow("Let Chao Roam",contentMenuX+28,contentMenuY+103,textColorMain,textColorShadow,1)
  textDropShadow("Show Hover Info",contentMenuX+28,contentMenuY+115,textColorMain,textColorShadow,1)
  textDropShadow("Chao Seek Enemy",contentMenuX+28,contentMenuY+127,textColorMain,textColorShadow,1)
  textDropShadow("No Air Stall on Down",contentMenuX+28,contentMenuY+139,textColorMain,textColorShadow,1)
  textDropShadow("Morph Controls",contentMenuX+28,contentMenuY+151,textColorMain,textColorShadow,1)

  var tMorphText;
  if global.optShowDamage=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else if global.optShowDamage=1 {textDropShadow("On",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  else {textDropShadow("Disabled",contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)}
  if global.optShowPointsEarned=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  else if global.optShowPointsEarned=1 {textDropShadow("On",contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)}
  if global.optEnemyHP=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  else if global.optEnemyHP=1 {textDropShadow("On",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  else {textDropShadow("Disabled",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  if global.optShowMoney=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optShowMoney=1 {textDropShadow("On",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  if global.optAtkTShow=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  else if global.optAtkTShow=1 {textDropShadow("On",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  if global.optChaoRoam=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  else if global.optChaoRoam=1 {textDropShadow("On",contentMenuX+164,contentMenuY+103,textColorMain,textColorShadow,1)}
  if global.optShowHoverInfo=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  else if global.optShowHoverInfo=1 {textDropShadow("On",contentMenuX+164,contentMenuY+115,textColorMain,textColorShadow,1)}
  if global.optChaoAttack=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  else if global.optChaoAttack=1 {textDropShadow("Nearest to her",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  else if global.optChaoAttack=2 {textDropShadow("Nearest to you",contentMenuX+164,contentMenuY+127,textColorMain,textColorShadow,1)}
  if global.optNoBounce=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  else if global.optNoBounce=1 {textDropShadow("On",contentMenuX+164,contentMenuY+139,textColorMain,textColorShadow,1)}
  if global.optMorphControls=0
  {
    textDropShadow("Off",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1)
    tMorphText="Only use [Button C] for morph/unmorph."
  }
  else if global.optMorphControls=1
  {
    textDropShadow("Up to Unmorph",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1)
    tMorphText="Allow [Up] to unmorph."
  }
  else if global.optMorphControls=2
  {
    textDropShadow("Double Tap",contentMenuX+164,contentMenuY+151,textColorMain,textColorShadow,1)
    tMorphText="Allow [Up] to unmorph and double tapping [Down] to morph."
  }

  if mO_CurPos=1
  {
    if global.optShowDamage<2 {menuInfoText="Show the damage dealt to enemies."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=2 {menuInfoText="Show AP earned after defeating an enemy."}
  else if mO_CurPos=3
  {
    if global.optEnemyHP<2 {menuInfoText="Show enemy life on the bottom-right of the screen when in combat."}
    else {menuInfoText="Disabled..."}
  }
  else if mO_CurPos=4 {menuInfoText="Show Internetz earned when picked up."}
  else if mO_CurPos=5 {menuInfoText="Show Attack Types when switching characters or Ability Sets."}
  else if mO_CurPos=6 {menuInfoText="Allow Chao to roam on her own when the mouse is not moving."}
  else if mO_CurPos=7 {menuInfoText="Show info when Chao hovers over an enemy."}
  else if mO_CurPos=8 {menuInfoText="This makes Chao seek out the nearest enemy to her (or you) and hover over it. 'Let Chao Roam' must be on for this. It's kinda like turning her into an info attack drone if you turn on 'Show Hover Info' as well."}
  else if mO_CurPos=9 {menuInfoText="Turn this on if you would like to have holding down not activate the air stall when dealing damage to an enemy in the air."}
  else if mO_CurPos=10 {menuInfoText=string("Controls for morphing and unmorphing.#-Current Controls-#") +string(tMorphText)}
}
else if mO_OptSubMenu=5 //------------------------- UNREAL GUY -------------------------
{
  textDropShadow("Unreal Kill Chain Audio",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Kill Chain Display",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Killing Spree Audio",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Killing Spree Display",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Guy Voice Volume",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Guy Voice Pitch",contentMenuX+28,contentMenuY+103,textColorMain,textColorShadow,1)
  textDropShadow("Unreal Guy Sound Test",contentMenuX+28,contentMenuY+115,textColorMain,textColorShadow,1)

  if global.optUnrealGuyChainAudio=0 {textDropShadow("Off",contentMenuX+176,contentMenuY+43,textColorMain,textColorShadow,1)}
  else if global.optUnrealGuyChainAudio=1 {textDropShadow("On",contentMenuX+176,contentMenuY+43,textColorMain,textColorShadow,1)}
  if global.optUnrealGuyChainVisual=0 {textDropShadow("Off",contentMenuX+176,contentMenuY+55,textColorMain,textColorShadow,1)}
  else if global.optUnrealGuyChainVisual=1 {textDropShadow("On",contentMenuX+176,contentMenuY+55,textColorMain,textColorShadow,1)}
  if global.optUnrealGuySpreeAudio=0 {textDropShadow("Off",contentMenuX+176,contentMenuY+67,textColorMain,textColorShadow,1)}
  else if global.optUnrealGuySpreeAudio=1 {textDropShadow("On",contentMenuX+176,contentMenuY+67,textColorMain,textColorShadow,1)}
  if global.optUnrealGuySpreeVisual=0 {textDropShadow("Off",contentMenuX+176,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optUnrealGuySpreeVisual=1 {textDropShadow("On",contentMenuX+176,contentMenuY+79,textColorMain,textColorShadow,1)}
  textDropShadow(global.optUnrealVolume,contentMenuX+176,contentMenuY+91,textColorMain,textColorShadow,1)
  textDropShadow(global.optUnrealPitch,contentMenuX+176,contentMenuY+103,textColorMain,textColorShadow,1)

  if mO_CurPos=1 {menuInfoText="Allow the Unreal Guy to proclaim your awesomeness during Kill Chains!"}
  else if mO_CurPos=2 {menuInfoText="Allow the Unreal Guy to display your murder rampages... err uh, Kill Chains on screen!"}
  else if mO_CurPos=3 {menuInfoText="Allow the Unreal Guy to shout out how awesome you are during your Killing Sprees!"}
  else if mO_CurPos=4 {menuInfoText="Allow the Unreal Guy to display your Killing Sprees on screen!"}
  else if mO_CurPos=5 {menuInfoText="Change the volume of Unreal Guy. He's a pretty excited guy, so maybe reigning in his enthusiasm is more to your liking.#Press left and right to change volume."}
  else if mO_CurPos=6 {menuInfoText="Change the pitch of Unreal Guy. Cause he's a silly guy and doesn't mind.#Press left and right to change pitch."}
  else if mO_CurPos=7 {menuInfoText="Test the volume level of Unreal Guy."}
}
else if mO_OptSubMenu=6 //------------------------- AUDIO -------------------------
{
  textDropShadow("Music Volume",contentMenuX+28,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow("Sound Volume",contentMenuX+28,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("Message Plink",contentMenuX+28,contentMenuY+67,textColorMain,textColorShadow,1)
  textDropShadow("Low Dash Warn",contentMenuX+28,contentMenuY+79,textColorMain,textColorShadow,1)
  textDropShadow("Chao Item Warn",contentMenuX+28,contentMenuY+91,textColorMain,textColorShadow,1)

  textDropShadow(global.optMusic,contentMenuX+164,contentMenuY+43,textColorMain,textColorShadow,1)
  textDropShadow(global.optSound,contentMenuX+164,contentMenuY+55,textColorMain,textColorShadow,1)
  if global.optMessagePlink=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  else if global.optMessagePlink=1 {textDropShadow("On",contentMenuX+164,contentMenuY+67,textColorMain,textColorShadow,1)}
  if global.optDashWarn=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  else if global.optDashWarn=1 {textDropShadow("On",contentMenuX+164,contentMenuY+79,textColorMain,textColorShadow,1)}
  if global.optChaoItemWarn=0 {textDropShadow("Off",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}
  else if global.optChaoItemWarn=1 {textDropShadow("On",contentMenuX+164,contentMenuY+91,textColorMain,textColorShadow,1)}

  if mO_CurPos=1 {menuInfoText="Press left or right to change the music volume or press the confirm key to mute or max out the volume.#0 to mute, max = 100."}
  else if mO_CurPos=2 {menuInfoText="Press left or right to change the sound volume or press the confirm key to mute or max out the volume.#0 to mute, max = 100."}
  else if mO_CurPos=3 {menuInfoText="Play a sound when new text boxes appear.#Now you'll never miss a thing again!"}
  else if mO_CurPos=4 {menuInfoText="Play a sound when no dashes remain.#Also play a sound when a dash is available."}
  else if mO_CurPos=5 {menuInfoText="When a certain item is obtained, Chao will alert you that a collectible is in the map you enter."}
}

if subMenu=7
{
  draw_sprite(sPauseM_AbilArrow,0,contentMenuX+mO_CurX,contentMenuY+mO_CurY) //Display cursor
}
