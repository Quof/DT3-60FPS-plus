if view_current=0
{
  //---------- Fade Back ----------
  draw_set_color(make_color_rgb(0,190,0))
  draw_set_alpha(0.25)
  draw_rectangle(view_xview[0],view_yview[0],view_xview[0]+view_wview[0],view_yview[0]+view_hview[0],false)

  //---------- Set Positions ----------
  mainMenuX=view_xview[0]+18
  mainMenuY=view_yview[0]+43
  contentMenuX=mainMenuX+114
  contentMenuY=mainMenuY+27
  infoMenuX=mainMenuX+0
  infoMenuY=mainMenuY+213

  //---------- Draw Menu ----------
  //title options change (added): no MAIN column on the title screen. sPauseM_Main is drawn without it (MAIN is x 0-99
  //of the sprite): the top bar + content panel (x 106-443) move 53px left so they're centred, and MENU INFO (full
  //width, y 214-280) stays where it is (already centred). Everything in the content panel follows contentMenuX.
  if titleMode=1
  {
    contentMenuX-=53
    draw_sprite_part(sPauseM_Main,0,106,0,338,207,contentMenuX-8,mainMenuY)
    draw_sprite_part(sPauseM_Main,0,0,214,444,67,mainMenuX,mainMenuY+214)
  }
  else
  {
  draw_sprite(sPauseM_Main,0,mainMenuX,mainMenuY)
  if global.mapTeleport=0 or global.bBossGallery=1 {draw_sprite(sPauseM_NoTeleport,0,mainMenuX+17,mainMenuY+161)}
  draw_sprite(sPauseM_Cursor,0,mainMenuX+mainCurX,mainMenuY+mainCurY)
  if subMenu>0
  {
    draw_sprite(sPauseM_AbilArrow,0,mainMenuX+mainCurX-1,mainMenuY+mainCurY-1)
    draw_set_color(make_color_rgb(240,232,136))
    draw_set_alpha(0.3)
    draw_rectangle(mainMenuX+mainCurX-10,mainMenuY+mainCurY-8,mainMenuX+mainCurX+76,mainMenuY+mainCurY+8,0)
    draw_set_alpha(1)
    draw_rectangle(mainMenuX+mainCurX-10,mainMenuY+mainCurY-8,mainMenuX+mainCurX+76,mainMenuY+mainCurY+8,1)
  }
  }

  //---------- Display Current Chapter ----------
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  draw_set_alpha(1)
  var tChapterName;
  tChapterName=""
  if global.gameProgress<=29 {tChapterName="Chapter 0: You haven't even started yet..."}
  else if global.gameProgress>=30 and global.gameProgress<=159 {tChapterName="Chapter 1: Everything Has a Beginning"}
  else if global.gameProgress>=160 and global.gameProgress<=529 {tChapterName="Chapter 2: Jerry & Claire"}
  else if global.gameProgress>=530 and global.gameProgress<=629 {tChapterName="Chapter 3: Overrun"}
  else if global.gameProgress>=630 and global.gameProgress<=929 {tChapterName="Chapter 4: Jerry's Adventure"}
  else if global.gameProgress>=930 and global.gameProgress<=1159 {tChapterName="Chapter 5: Reclaiming What's Lost"}
  else if global.gameProgress>=1160 and global.gameProgress<=1539 {tChapterName="Chapter 6: Clairvoyance"}
  else if global.gameProgress>=1540 and global.gameProgress<=1769 {tChapterName="Chapter 7: Familiar Ways"}
  else if global.gameProgress>=1770 and global.gameProgress<=2009 {tChapterName="Chapter 8: Mega Jerry"}
  else if global.gameProgress>=2010 and global.gameProgress<=2169 {tChapterName="Chapter 9: Recollection"}
  else if global.gameProgress>=2170 and global.gameProgress<=2569 {tChapterName="Chapter 10: Something Sleeps in the Darkness"}
  else if global.gameProgress>=2570 and global.gameProgress<=2599 {tChapterName="Chapter 11: Intermission"}
  else if global.gameProgress>=2600 and global.gameProgress<=2679 {tChapterName="Chapter 12: Barren Bewilderment"}
  else if global.gameProgress>=2680 and global.gameProgress<=3089 {tChapterName="Chapter 13: Claire Fusion"}
  else if global.gameProgress>=3090 and global.gameProgress<=3399 {tChapterName="Chapter 14: Truths Revealed"}
  else if global.gameProgress>=3400 and global.gameProgress<=3879 {tChapterName="Chapter 15: Rapid Prototype Game"}
  else if global.gameProgress>=3880 and global.gameProgress<=3939 {tChapterName="Chapter 16: On the Defensive"}
  else if global.gameProgress>=3940 and global.gameProgress<=4209 {tChapterName="Chapter 17: What Lies Beneath"}
  else if global.gameProgress>=4210 and global.gameProgress<=4529 {tChapterName="Chapter 18: A New Empire"}
  else if global.gameProgress>=4530 and global.gameProgress<=5049 {tChapterName="Chapter 19: That Which can be Taken"}
  else if global.gameProgress>=5050 and global.gameProgress<=5490 {tChapterName="Chapter 20: Trust"}
  else if global.gameProgress>=5500 {tChapterName="Chapter 21: Distorted Travesty"}
  //if titleMode=1 {tChapterName="Press [" +string(global.ctrlActA) +"] to save and go back to the title screen."} //title options change (added)
  //if titleMode=1 {tChapterName="Press [" +string(global.ctrlCancel) +"] to save and go back to the title screen."} //title options change (added) //controls change: the Cancel key
  if titleMode=1 {tChapterName="Press [Cancel] to save and go back to the title screen."} //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
  //controls change (added): the CONTROLS and GAMEPAD lists are as tall as the content panel now and cover this line
  if subMenu=11 or subMenu=14 {tChapterName=""}
  textDropShadow(tChapterName,contentMenuX+2,contentMenuY-23,textColorMain,textColorShadow,1)

  //textDropShadow("Press the [Home] key to reset your controls to the default settings.",mainMenuX+8,mainMenuY+282,textColorMain,textColorShadow,1) //menu info change: it's in the PROGRESS menu info now

  //----- Prizes -----
  if global.yoshiDoll>=1 {draw_sprite(sPauseM_YoshiDoll,0,contentMenuX+48,contentMenuY-27)}
  if global.yoshiDoll>=2 {draw_sprite(sPauseM_YoshiDoll,1,contentMenuX+76,contentMenuY-27)}
  if global.yoshiDoll>=3 {draw_sprite(sPauseM_YoshiDoll,2,contentMenuX+104,contentMenuY-27)}
  if global.yoshiDoll>=4 {draw_sprite(sPauseM_YoshiDoll,3,contentMenuX+132,contentMenuY-27)}

  //---------- Menu Titles ----------
  draw_set_font(fnt_PauseMenuMain)
  draw_set_color(textColorMain)
  if mainCurPos=1 //------------------------------ PROGRESS ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"PROGRESS")
    var tDiffText,tExtDiffText;
    tExtDiffText=""
    if global.bNightmareMode=0
    {
      if global.difficulty=1 {tDiffText="[ASSIST MODE]"}
      else if global.difficulty=2 {tDiffText="[STANDARD MODE]"}
      if global.bOneHitKillMode=1 {tDiffText="[ACHILLES MODE]"}
    }
    else
    {
      if global.bOneHitKillMode=0 {tDiffText="[NIGHTMARE MODE]"}
      else {tDiffText="[NIGHT TERROR MODE]"}
    }

    if global.permaEasyMode=1 {tExtDiffText=" (E)"}

    draw_text(contentMenuX+106,contentMenuY,string(tDiffText) +string(tExtDiffText))
    //menuInfoText="Your overall progress and status."
    menuInfoText="Your overall progress and status.#Press the [Home] key to reset your controls to the default settings." //menu info change: the [Home] line, from below the menu
    menuProgress()
  }
  else if mainCurPos=2 //------------------------------ EQUIPMENT ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"EQUIPMENT")
    menuInfoText="Change your equipment and use potions to heal."
    menuEquipment()

    if subMenu=2
    {
      if mEq_CurPos=7 or mEq_CurPos=8
      {
        menuInfoText=""
        if bottles[mEq_CurPos-7]="1"
          menuInfoText="Empty Bottle#You can fill it with useful things."
        else if bottles[mEq_CurPos-7]="2"
          menuInfoText="Energy Drink#Restores half of your hearts."
        else if bottles[mEq_CurPos-7]="3"
          menuInfoText="Turbo Smoothie#This amazingly tasty drink restores all of your hearts!"
      }
      else
      {
        //menuInfoText=string("Select an available equipment slot to assign an item to.#[" +string(global.ctrlActA) +string("]: Check available equipment.#[") +string(global.ctrlActB) +string("]: Unequip current slot."))
        //menuInfoText=string("Select an available equipment slot to assign an item to.#[" +string(global.ctrlConfirm) +string("]: Check available equipment.#[") +string(global.ctrlActB) +string("]: Unequip current slot.")) //controls change: the item list opens with Confirm
        menuInfoText="Select an available equipment slot to assign an item to.#[Confirm]: Check available equipment.#[Action B]: Unequip current slot." //input text change: the keys as [tokens], shown as the key set for them or the gamepad button's icon (scrDrawInput)
      }
      mSAP_FrameCount+=1*gDeltaTime
      if mSAP_FrameCount mod 8=0
      {
        if mSAP_CurFrame=0 {mSAP_CurFrame=1}
        else {mSAP_CurFrame=0}
      }
      //Display cursor
      draw_sprite(sPauseM_APCursor,mSAP_CurFrame,contentMenuX+mEq_CurX,contentMenuY+mEq_CurY)
    }
  }
  else if mainCurPos=3 //------------------------------ SPEND AP ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"SPEND AP")
    menuInfoText="Spend the AP you have gained on enhancing various aspects of your characters."
    menuSpendAP()
  }
  else if mainCurPos=4 //------------------------------ MAP ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"MAP")
    menuInfoText="View your current location in the world and how many items are in an area."
    menuMap(0)
    if mapDetails>0 {menuDetailsMap()}
    if global.debugMenu=true
    {
      draw_set_color(c_white)
      draw_text(contentMenuX+24,contentMenuY+32,mMap_CurX)
      draw_text(contentMenuX+24,contentMenuY+44,mMap_CurY)
    }
  }
  else if mainCurPos=5 //------------------------------ ABILITY SET ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"ABILITY SET")
    menuInfoText="View your Ability Set power levels and info on how they function."
    if subMenu=5
    {
      if mAS_Character="JERRY"
      {
        if mAS_Ability="LINK"
        {
          if global.hasAbilToken[1]>=1
            menuInfoText="Excels at close range combat with fast melee strikes, supplemented by powerful arrows and unlimited bombs."
          else {menuInfoText="You have not obtained Jerry's 1st Ability Set."}
        }
        else if mAS_Ability="MEGA MAN"
        {
          if global.hasAbilToken[3]>=1
            menuInfoText="Provides multi-charge levels with the X-Buster as well as a wide range of special weapons. The only downside being the special weapon energy runs out quickly."
          else {menuInfoText="You have not obtained Jerry's 2nd Ability Set."}
        }
        else if mAS_Ability="GAME"
        {
          if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
            menuInfoText="Does not seem to be linked to any specific game. Looks to be some prototype abilities in alpha stages of the program."
          else {menuInfoText="You have not obtained this Ability Set."}
        }
      }
      else if mAS_Character="CLAIRE"
      {
        if mAS_Ability="BELMONT"
        {
          if global.hasAbilToken[2]>=1
            menuInfoText="Provides decent melee range at the cost of attack speed, with exceptionally fast daggers, as well as slow but powerful bottles of holy water."
          else {menuInfoText="You have not obtained Claire's 1st Ability Set."}
        }
        else if mAS_Ability="SAMUS"
        {
          if global.hasAbilToken[4]>=1
            menuInfoText="Provides good coverage with the Cannon, but it heats up quick and the shots aren't quite as strong as others. Luckily Missiles excel in damage output."
          else {menuInfoText="You have not obtained Claire's 2nd Ability Set."}
        }
        else if mAS_Ability="GAME"
        {
          if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
            menuInfoText="Does not seem to be linked to any specific game. Looks to be some prototype abilities in alpha stages of the program."
          else {menuInfoText="You have not obtained this Ability Set."}
        }
      }
    }
    if mAS_Ability="GAME"
    {
      if global.hasAbilToken[5]>0 or global.hasAbilToken[6]>0 {menuGate6Set()}
    }
    else {menuAbilitySet()}
  }
  else if mainCurPos=6 //------------------------------ RECORDS / RECOGNITIONS ------------------------------
  {
    if mR_Tab=1
    {
      draw_text(contentMenuX+8,contentMenuY,"RECORDS")
      menuInfoText="View your battle records as well as other pointless records.#Press [Left] or [Right] to view Recognitions."
    }
    else
    {
      draw_text(contentMenuX+8,contentMenuY,"TOKEN RECOGNITIONS")
      menuInfoText="Wait what? There are Achieveme... err Recognitions in this game?!#Press [Left] or [Right] to view Records, but you uh... you probably knew that.#Press [Confirm] to check Recognition info."
    }
    menuRecords()
  }
  else if mainCurPos=7 //------------------------------ OPTIONS ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"OPTIONS")
    menuInfoText="Change various game options to your liking."
    menuOptions()
  }
  else if mainCurPos=8 //------------------------------ TELEPORT ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"TELEPORT")
    menuInfoText="Teleport out of an area."

    if global.gameProgress>=510 //Explain teleport function
    {
      draw_set_alpha(1)
      draw_set_halign(fa_left)
      draw_set_font(fnt_PauseMenuText)
      textDropShadowExt("Hey guys, Jeremy here. I'm pretty sure I can teleport you out of completed Access Gates, as well as most completed overworld dungeons.",contentMenuX+20,contentMenuY+30,textColorMain,textColorShadow,4,14,290)
    }

    if subMenu=8
    {
      menuInfoText="No teleport location available."
      if global.mapTeleport=0 //Not usable
        menuInfoText=string("Not available.")
      else if global.mapTeleport=1 //Gate A
        menuInfoText=string("Teleport to - Stratum Steppe")
      else if global.mapTeleport=2 //Gate B
        menuInfoText=string("Teleport to - Greatest Stretch - North")
      else if global.mapTeleport=3 //Gate C
        menuInfoText=string("Teleport to - Magical Canopy")
      else if global.mapTeleport=4 //Gate D
        menuInfoText=string("Teleport to - Begonia - Floating Isles")
      else if global.mapTeleport=5 //Gate E
        menuInfoText=string("Teleport to - Farreaches - Vault Entrance")
      else if global.mapTeleport=6 //Gate F
        menuInfoText=string("Teleport to - Barrens - Oasis")
      else if global.mapTeleport=7 //Gate G
        menuInfoText=string("Teleport to - Burning Stretch - Land's End")
      else if global.mapTeleport=8 //Gate H
        menuInfoText=string("Teleport to - ?????")
      else if global.mapTeleport=9 //Gate 3 (Megapolis)
      {
        if global.gameProgress>=1840
          menuInfoText=string("Teleport to - Megapolis Map")
        else
          menuInfoText=string("Teleport to - Gate 4 Entrance")
      }
      else if global.mapTeleport=14 //Vault Shift Maze
        menuInfoText=string("Teleport to - Vault Shift Maze Entrance")
      else if global.mapTeleport=15 //Vault (After completing Chapter 10)
        menuInfoText=string("Teleport to - Farreaches - Vault Entrance")
      else if global.mapTeleport=16 //Main_45
        menuInfoText=string("Teleport to - Barrens - Lower Waste")
      else if global.mapTeleport=17 //Gate 6 - Earth Temple
        menuInfoText=string("Teleport to - Gate 6: Earth Temple Entrance")
      else if global.mapTeleport=18 //Gate 6 - Fire Temple
        menuInfoText=string("Teleport to - Gate 6: Fire Temple Entrance")
      else if global.mapTeleport=19 //Gate 6 - Wind Temple
        menuInfoText=string("Teleport to - Gate 6: Wind Temple Entrance")
      else if global.mapTeleport=20 //Gate 6 - Paradise Island
        menuInfoText=string("Teleport to - Gate 6: Paradise Island Entrance")
      else if global.mapTeleport=21 //Gate 6 - Watery Cave
        menuInfoText=string("Teleport to - Gate 6: Watery Cave Entrance")
      else if global.mapTeleport=22 //Subconscious Filter
        menuInfoText=string("Teleport to - Gate 6: Subconscious Filter Exit")
      else if global.mapTeleport=23 //Gate 6 - Doom Castle
        menuInfoText=string("Teleport to - Gate 6: Doom Castle Entrance")
      else if global.mapTeleport=24 //Mountain Temple
        menuInfoText=string("Teleport to - Mountain Temple Entrance")
      else if global.mapTeleport=25 //Displaced Construction Site
        menuInfoText=string("Teleport to - Displaced Construction Site Entrance")
      else if global.mapTeleport=26 //Magical Castle
        menuInfoText=string("Teleport to - Magical Castle Entrance")
      else if global.mapTeleport=27 //Hidden Program Facility
        menuInfoText=string("Teleport to - Hidden Program Facility Entrance")
      else if global.mapTeleport=28 //Bubble Tower
        menuInfoText=string("Teleport to - Bubble Tower Entrance")
      else if global.mapTeleport=29 //Path to the Truth
        menuInfoText=string("Teleport to - Path to the Truth Entrance")
      else if global.mapTeleport=31 //Gate 1
        menuInfoText=string("Teleport to - Gate 1: Entrance")
      else if global.mapTeleport=32 //Gate 2
        menuInfoText=string("Teleport to - Gate 2: Entrance")
      else if global.mapTeleport=33 //Gate 3
        menuInfoText=string("Teleport to - Gate 3: Entrance")
      else if global.mapTeleport=34 //Gate 4
        menuInfoText=string("Teleport to - Gate 4: Entrance")
      else if global.mapTeleport=35 //Gate 5
        menuInfoText=string("Teleport to - Gate 5: Entrance")
      else if global.mapTeleport=36 //Gate 6
        menuInfoText=string("Teleport to - Gate 6: Entrance")
      else if global.mapTeleport=41 //Bubble Tower B
        menuInfoText=string("Teleport to - Bubble Tower B HUB")
      else if global.mapTeleport=66 //spsp
        menuInfoText=string("Teleport to - HexUpBase")
      else if global.mapTeleport=77 //spsp
        menuInfoText=string("Teleport to - Sanctuary")
    }
  }
  else if mainCurPos=9 //------------------------------ SAVE ------------------------------
  {
    draw_text(contentMenuX+8,contentMenuY,"SAVE")
    menuInfoText="Save your game progress and do other stuff."
    if subMenu=9
    {
      if mS_CurPos=1
        menuInfoText="Save your progress."
      else if mS_CurPos=2
        menuInfoText="Force a Game Over on yourself."
      else if mS_CurPos=3
        menuInfoText="Revert back to last time the game was saved."
      else if mS_CurPos=4
        menuInfoText="Return to the title screen."
    }

    if global.bCanSave=true
      textDropShadow("Save Progress",contentMenuX+19,contentMenuY+24,textColorMain,textColorShadow,1)
    else
    {
      textDropShadow("Save Progress",contentMenuX+19,contentMenuY+24,make_color_rgb(190,190,190),textColorShadow,1)
      textDropShadow("[Disabled]",contentMenuX+117,contentMenuY+24,make_color_rgb(255,128,128),textColorShadow,1)
    }
    if global.bCanForceGO=true
      textDropShadow("Force Game Over",contentMenuX+19,contentMenuY+50,textColorMain,textColorShadow,1)
    else
    {
      textDropShadow("Force Game Over",contentMenuX+19,contentMenuY+50,make_color_rgb(190,190,190),textColorShadow,1)
      textDropShadow("[Disabled]",contentMenuX+137,contentMenuY+50,make_color_rgb(255,128,128),textColorShadow,1)
    }
    textDropShadow("Load From Last Save Data",contentMenuX+19,contentMenuY+76,textColorMain,textColorShadow,1)
    textDropShadow("Return To Title Screen",contentMenuX+19,contentMenuY+102,textColorMain,textColorShadow,1)
    if subMenu=9 //Display cursor
      draw_sprite(sPauseM_AbilArrow,0,contentMenuX+mS_CurX,contentMenuY+mS_CurY)

    if confirmationMenu>0 //Confirmation menu
    {
      var tConfirmMenuX,tConfirmMenuY;
      tConfirmMenuX=contentMenuX+90
      tConfirmMenuY=contentMenuY+48
      draw_sprite(sMenu_ConfirmMenu,0,tConfirmMenuX,tConfirmMenuY)
      draw_sprite(sPauseM_AbilArrow,0,tConfirmMenuX+15,tConfirmMenuY+14+(confirmMenuPos*19))
    }
  }

  if subMenu=11 //------------------------------ CONTROLS ------------------------------
  {
    //draw_sprite(sPauseM_ControlMain,0,contentMenuX+122,contentMenuY+17)
    //controls change: 17 rows now (+ Confirm, Cancel, Pause, Cutscene Skip; Dash Forward above Dash Back), so the list
    //starts at the top of the content panel and ends just above MENU INFO (sPauseM_ControlMain is 226 tall)
    var tConY;
    tConY=contentMenuY-27
    draw_sprite(sPauseM_ControlMain,0,contentMenuX+122,tConY)
    //menuInfoText="Change the control setup. This is for keyboard controls only. It only changes gamepad controls if you're using 3rd party software to bind keys to controller inputs."
    menuInfoText="Change keyboard bindings.#Press the [Home] key to reset your controls to the default settings." //controls change
    //Display cursor
    //draw_sprite(sPauseM_AbilArrow,0,contentMenuX+122+mCon_CurX,contentMenuY+17+mCon_CurY)
    draw_sprite(sPauseM_AbilArrow,0,contentMenuX+122+mCon_CurX,tConY+mCon_CurY) //controls change
    //Display current controls
    draw_set_halign(fa_center)
    //textDropShadow(global.ctrlUp,contentMenuX+259,contentMenuY+33,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlDown,contentMenuX+259,contentMenuY+45,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlLeft,contentMenuX+259,contentMenuY+57,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlRight,contentMenuX+259,contentMenuY+69,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlJump,contentMenuX+259,contentMenuY+81,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlCharSwap,contentMenuX+259,contentMenuY+93,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlAbilSwap,contentMenuX+259,contentMenuY+105,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlActA,contentMenuX+259,contentMenuY+117,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlActB,contentMenuX+259,contentMenuY+129,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlActC,contentMenuX+259,contentMenuY+141,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlDashLeft,contentMenuX+259,contentMenuY+153,textColorMain,textColorShadow,1)
    //textDropShadow(global.ctrlDashRight,contentMenuX+259,contentMenuY+165,textColorMain,textColorShadow,1)
    //controls change: same spots relative to the list (its row k at tConY+16+12*(k-1))
    textDropShadow(global.ctrlUp,contentMenuX+259,tConY+16,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlDown,contentMenuX+259,tConY+28,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlLeft,contentMenuX+259,tConY+40,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlRight,contentMenuX+259,tConY+52,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlJump,contentMenuX+259,tConY+64,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlCharSwap,contentMenuX+259,tConY+76,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlAbilSwap,contentMenuX+259,tConY+88,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActA,contentMenuX+259,tConY+100,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActB,contentMenuX+259,tConY+112,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlActC,contentMenuX+259,tConY+124,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlDashRight,contentMenuX+259,tConY+136,textColorMain,textColorShadow,1) //Dash Forward
    textDropShadow(global.ctrlDashLeft,contentMenuX+259,tConY+148,textColorMain,textColorShadow,1) //Dash Back
    textDropShadow(global.ctrlConfirm,contentMenuX+259,tConY+160,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlCancel,contentMenuX+259,tConY+172,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlPause,contentMenuX+259,tConY+184,textColorMain,textColorShadow,1)
    textDropShadow(global.ctrlSkip,contentMenuX+259,tConY+196,textColorMain,textColorShadow,1)
  }
  else if subMenu=12 //------------------------------ ITEM LIST ------------------------------
  {
    menuInfoText=""
    var tItemMX,iItemMY;
    iItemMX=1
    iItemMY=2
    draw_set_color(make_color_rgb(0,120,104))
    draw_rectangle(contentMenuX+iItemMX,contentMenuY+iItemMY,contentMenuX+iItemMX+319,contentMenuY+iItemMY+133,0)
    draw_set_color(make_color_rgb(224,128,40))
    draw_rectangle(contentMenuX+iItemMX,contentMenuY+iItemMY,contentMenuX+iItemMX+319,contentMenuY+iItemMY+133,1)
    //Display slots
    var i,ii; for(i=0;i<4;i+=1)
    {
      for(ii=0;ii<10;ii+=1)
      {
        draw_sprite(sPauseM_ItemSlot,0,contentMenuX+iItemMX+7+(ii*31),contentMenuY+iItemMY+7+(i*31))
      }
    }
    //Display item icons
    draw_set_halign(fa_left)
    draw_set_font(fnt_PauseMenuMain)
    for(i=0;i<10;i+=1)
    {
      if items[i]!=0
      {
        draw_sprite(sEquipItemIcons,items[i]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+20)
        if eCheck[i]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+20,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+10]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+10]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+51)
        if eCheck[i+10]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+51,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+20]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+20]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+82)
        if eCheck[i+20]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+82,textColorMain,make_color_rgb(12,16,15),4)
      }
      if items[i+30]!=0
      {
        draw_sprite(sEquipItemIcons,items[i+30]-1,contentMenuX+iItemMX+20+(i*31),contentMenuY+iItemMY+113)
        if eCheck[i+30]!="1"
          textDropShadow("E",contentMenuX+iItemMX+24+(i*31),contentMenuY+iItemMY+113,textColorMain,make_color_rgb(12,16,15),4)
      }
    }

    equipCheck[1]=""
    equipCheck[3]=""
    if mItem_CurY=1
    {
      if items[mItem_CurX-1]!=0
        equipmentInit(2,mItem_CurX)
    }
    else if mItem_CurY=2
    {
      if items[mItem_CurX+9]!=0
        equipmentInit(2,mItem_CurX+10)
    }
    else if mItem_CurY=3
    {
      if items[mItem_CurX+19]!=0
        equipmentInit(2,mItem_CurX+20)
    }
    else if mItem_CurY=4
    {
      if items[mItem_CurX+29]!=0
        equipmentInit(2,mItem_CurX+30)
    }

    menuInfoText=equipCheck[3]
    //Display item slot info
    if equipCheck[1]!=""
    {
      draw_set_font(fnt_PauseMenuText)
      draw_set_halign(fa_left)
      draw_set_color(textColorMain)
      draw_text(infoMenuX+87,infoMenuY+2,">>" +string(equipCheck[1]))
    }

    mSAP_FrameCount+=1*gDeltaTime
    if mSAP_FrameCount mod 8=0
    {
      if mSAP_CurFrame=0 {mSAP_CurFrame=1}
      else {mSAP_CurFrame=0}
    }
    //Display cursor
    draw_sprite(sPauseM_APCursor,mSAP_CurFrame,contentMenuX+iItemMX+20+((mItem_CurX-1)*mItem_CurInc),contentMenuY+iItemMY+20+((mItem_CurY-1)*mItem_CurInc))
  }
  else if subMenu=13 //------------------------------ RECOGNITIONS ------------------------------
  {
    //Display cursor
    draw_sprite(sPauseM_Cursor,0,contentMenuX+7,contentMenuY+9+(mR_RecCurPos*24))
  }
  else if subMenu=14 //------------------------------ GAMEPAD SETUP ------------------------------
  {
    //gamepad change: the GAMEPAD list, laid out like CONTROLS (sPauseM_GamepadMain is sPauseM_ControlMain with GAMEPAD
    //in the header and a wider [ ] column for the button names). The old preset picture is kept below, commented out.
    var tGPMenuX,tGPMenuY,tGPName,tGPPad,i;
    tGPMenuX=contentMenuX+114
    //tGPMenuY=contentMenuY+17
    tGPMenuY=contentMenuY-27 //controls change: 17 rows now, so the list starts at the top of the content panel (see CONTROLS)
    draw_sprite(sPauseM_GamepadMain,0,tGPMenuX,tGPMenuY)
    //Display cursor
    draw_sprite(sPauseM_AbilArrow,0,tGPMenuX+16,tGPMenuY+22+((mGP_CurPos-1)*12))
    //Display current gamepad controls
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_center)
    draw_set_alpha(1)
    //for(i=1;i<=12;i+=1)
    for(i=1;i<=global.gpRows;i+=1) //controls change: 16 action rows
    {
      tGPName=scrGamepadName(global.gpBind[global.gpRowAct[i]])
      if mGP_Listen=1 and mGP_CurPos=i //waiting for a button: blink
      {
        if (current_time div 300) mod 2=0 {tGPName="PRESS"}
        else {tGPName=""}
      }
      textDropShadow(tGPName,tGPMenuX+161,tGPMenuY+16+((i-1)*12),textColorMain,textColorShadow,1)
    }
    draw_set_halign(fa_left)

    //if mGP_Listen=1 {menuInfoText="Press the button for " +global.gpRowName[mGP_CurPos] +" on your gamepad.#[" +string(global.ctrlActA) +"]: Cancel (or wait 5 seconds)."}
    //else if mGP_CurPos=13 {menuInfoText="Set the gamepad controls back to the defaults."}
    if mGP_Listen=1 {menuInfoText="Press the button for " +global.gpRowName[mGP_CurPos] +" on your gamepad.#[" +string(global.ctrlCancel) +"]: Cancel (or wait 5 seconds)."} //controls change: the keyboard's Cancel key
    else if mGP_CurPos=global.gpRows+1 {menuInfoText="Set the gamepad controls back to the defaults."} //controls change
    else
    {
      //menuInfoText="Select an action, then press the button for it on your gamepad. The left stick always moves too.#" +scrGamepadName(1) +": Confirm   " +scrGamepadName(2) +": Back   " +scrGamepadName(10) +": Pause   " +scrGamepadName(9) +": Skip cutscenes"
      //controls change: Confirm, Cancel, Pause and Cutscene Skip are in the list now; Quick Restart's buttons are fixed
      menuInfoText="Select an action, then press the button for it on your gamepad. The left stick always moves too. Confirm and Cancel can share a button with a game action.#Quick Restart: " +scrGamepadName(5) +" + " +scrGamepadName(6) +" on the pause menu."
      //a last line only when something is stopping the pad from working
      tGPPad=""
      if global.gpDevice<0 {tGPPad="No gamepad found.  "}
      if global.optGamePad=0 {tGPPad+="'Gamepad Input' is off, so the gamepad isn't used."}
      if tGPPad!="" {menuInfoText+="#" +tGPPad}
    }

    /*
    var tGamepadMenuX,tGamepadMenuY;
    tGamepadMenuX=contentMenuX-32
    tGamepadMenuY=contentMenuY-20
    draw_sprite(sPauseM_GamepadSetup,0,tGamepadMenuX,tGamepadMenuY)
    menuInfoText="Change the gamepad control setup. This is only if you're using the built in gamepad controls. Keep in mind this is suited to the X-Box controller. Some gamepads, such as those with the face buttons as [1,2,3,4] may have a different configuration than shown."

    //Display number of gamepad profiles
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_left)
    draw_set_alpha(1)
    draw_set_color(c_white)
    draw_text(contentMenuX+146,contentMenuY-19,string(global.optGamepadSetup) +string("/") +string(mO_OptConMax))

    //Display stick dead zone
    draw_set_halign(fa_center)
    draw_text(tGamepadMenuX+185,tGamepadMenuY+53,string(round(global.optStickDeadZone*100)) +string("%"))

    //Display current controls
    if global.optGamepadSetup=1 //----- 1.0 JERRY -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.0 JERRY")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=2 //----- 1.1 JEREMY -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.1 JEREMY")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Dash Left")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=3 //----- 1.2 CLAIRE -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.2 CLAIRE")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Jump")
    }
    else if global.optGamepadSetup=4 //----- 1.3 CHAO -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"1.3 CHAO")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Dash Left")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Jump")
    }
    else if global.optGamepadSetup=5 //----- 2.0 SWITCH PRO CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.0 SWITCH PRO CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Dash Left")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Dash Right")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Character Swap")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Ability Swap")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Action A")
    }
    else if global.optGamepadSetup=6 //----- 2.1 HITBOX CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.1 HITBOX CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Action C")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Dash Right")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Jump")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Dash Left")
    }
    else if global.optGamepadSetup=7 //----- 2.2 DS4 CONTROLLER -----
    {
      draw_text(tGamepadMenuX+185,tGamepadMenuY+15,"2.2 DS4 CONTROLLER")
      draw_text(tGamepadMenuX+57,tGamepadMenuY+32,"Character Swap")
      draw_text(tGamepadMenuX+302,tGamepadMenuY+25,"Ability Swap")
      draw_text(tGamepadMenuX+53,tGamepadMenuY+84,"Jump")
      draw_text(tGamepadMenuX+315,tGamepadMenuY+53,"Action B")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+101,"Action C")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+124,"Dash Left")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+147,"Action A")
      draw_text(tGamepadMenuX+317,tGamepadMenuY+172,"Dash Right")
    }
    */
  }
  else if subMenu=15 //------------------------------ CUSTOMIZE REMASTERED CHANGES ------------------------------
  {
    //dipswitch change (added): the dipswitch list (remasterSwitchList), laid out like the CONTROLS list. The frame
    //(sPauseM_RemasterMain) is drawn in parts so it grows with the list: header (rows 0-16), a 12px strip per dipswitch
    //(rows 17-28) and the bottom border (rows 29-35). It sits under the option tabs, centred in the content panel.
    var tDSMenuX,tDSMenuY,tDSValue,i;
    var tDSPer,tDSFirst,tDSPages,tDSRows,j; //dipswitch pages change (added): the pages (below)
    tDSMenuX=contentMenuX+25
    tDSMenuY=contentMenuY+44
    //dipswitch pages change (added): 8 dipswitches a page, what fits in the content panel at this size. The page shown is
    //the cursor's, so Up/Down go through all of them (past the last one on a page, the next page comes up); the frame stays
    //the same height on every page
    tDSPer=8
    tDSFirst=floor((mDS_CurPos-1)/tDSPer)*tDSPer
    tDSPages=ceil(global.dsCount/tDSPer)
    tDSRows=min(global.dsCount,tDSPer)
    draw_sprite_part(sPauseM_RemasterMain,0,0,0,272,17,tDSMenuX,tDSMenuY)
    //for(i=0;i<global.dsCount;i+=1) {draw_sprite_part(sPauseM_RemasterMain,0,0,17,272,12,tDSMenuX,tDSMenuY+17+(i*12))}
    //draw_sprite_part(sPauseM_RemasterMain,0,0,29,272,7,tDSMenuX,tDSMenuY+17+(global.dsCount*12))
    for(i=0;i<tDSRows;i+=1) {draw_sprite_part(sPauseM_RemasterMain,0,0,17,272,12,tDSMenuX,tDSMenuY+17+(i*12))} //dipswitch pages change: a page's rows
    draw_sprite_part(sPauseM_RemasterMain,0,0,29,272,7,tDSMenuX,tDSMenuY+17+(tDSRows*12)) //dipswitch pages change

    draw_set_alpha(1)
    draw_set_font(fnt_PauseMenuMain)
    draw_set_halign(fa_left)
    draw_set_color(textColorMain)
    draw_text(tDSMenuX+17,tDSMenuY+1,"REMASTERED CHANGES")
    //dipswitch pages change (added): the page, right of the title (the header's stripes start at +208)
    if tDSPages>1
    {
      draw_set_halign(fa_right)
      draw_text(tDSMenuX+200,tDSMenuY+1,string(tDSFirst/tDSPer+1)+"/"+string(tDSPages))
      draw_set_halign(fa_left)
    }
    //for(i=0;i<global.dsCount;i+=1)
    for(j=0;j<tDSRows and tDSFirst+j<global.dsCount;j+=1) //dipswitch pages change: the page's dipswitches (j: the row)
    {
      i=tDSFirst+j //dipswitch pages change (added)
      //Name, then a line out to the ON/OFF column
      draw_set_font(fnt_PauseMenuMain)
      draw_set_halign(fa_left)
      //dark omen change (added): greyed out while it can't be changed (scrDSLocked: New Dark Omen in the boss gallery or a
      //boss fight)
      var tDSCol;
      if scrDSLocked(i) {tDSCol=make_color_rgb(190,190,190)}
      else {tDSCol=textColorMain}
      //textDropShadow(global.dsName[i],tDSMenuX+20,tDSMenuY+16+(i*12),textColorMain,textColorShadow,1)
      //textDropShadow(global.dsName[i],tDSMenuX+20,tDSMenuY+16+(j*12),textColorMain,textColorShadow,1) //dipswitch pages change: the row
      textDropShadow(global.dsName[i],tDSMenuX+20,tDSMenuY+16+(j*12),tDSCol,textColorShadow,1) //dipswitch pages change: the row //dark omen change: tDSCol
      //autosave change (added): the value is worked out first, so the line can stop short of a longer one ("30 MIN");
      //ON and OFF keep the line ending where it did
      var tDSLineEnd;
      if global.dsVar[i]="autosaveFreq" //minutes between autosaves, 0 = off
      {
        if global.autosaveFreq=0 {tDSValue="OFF"}
        else {tDSValue=string(global.autosaveFreq)+" MIN"}
      }
      else if variable_global_get(global.dsVar[i])=true {tDSValue="ON"}
      else {tDSValue="OFF"}
      draw_set_font(fnt_PauseMenuText)
      tDSLineEnd=min(231,247-ceil(string_width(tDSValue)/2)-3)
      draw_set_font(fnt_PauseMenuMain)
      draw_set_color(textColorShadow)
      //draw_rectangle(tDSMenuX+24+string_width(global.dsName[i]),tDSMenuY+26+(i*12),tDSMenuX+231,tDSMenuY+26+(i*12),0)
      //draw_rectangle(tDSMenuX+24+string_width(global.dsName[i]),tDSMenuY+26+(i*12),tDSMenuX+tDSLineEnd,tDSMenuY+26+(i*12),0) //autosave change: tDSLineEnd
      draw_rectangle(tDSMenuX+24+string_width(global.dsName[i]),tDSMenuY+26+(j*12),tDSMenuX+tDSLineEnd,tDSMenuY+26+(j*12),0) //autosave change: tDSLineEnd //dipswitch pages change: the row
      draw_set_font(fnt_PauseMenuText)
      draw_set_halign(fa_center)
      //if variable_global_get(global.dsVar[i])=true {tDSValue="ON"}
      //else {tDSValue="OFF"}
      //textDropShadow(tDSValue,tDSMenuX+247,tDSMenuY+17+(i*12),textColorMain,textColorShadow,1)
      //textDropShadow(tDSValue,tDSMenuX+247,tDSMenuY+17+(j*12),textColorMain,textColorShadow,1) //dipswitch pages change: the row
      textDropShadow(tDSValue,tDSMenuX+247,tDSMenuY+17+(j*12),tDSCol,textColorShadow,1) //dipswitch pages change: the row //dark omen change: tDSCol
    }
    draw_set_halign(fa_left)
    //Display cursor
    //draw_sprite(sPauseM_AbilArrow,0,tDSMenuX+16,tDSMenuY+22+((mDS_CurPos-1)*12))
    draw_sprite(sPauseM_AbilArrow,0,tDSMenuX+16,tDSMenuY+22+((mDS_CurPos-1-tDSFirst)*12)) //dipswitch pages change: its row on the page
    menuInfoText=global.dsInfo[mDS_CurPos-1]
  }
  else if subMenu=16 or subMenu=17 //------------------------------ COLOR ZONE COLORS ------------------------------
  {
    //color zone change (added): the zones with their colors, and right below them (subMenu 17) the one being changed,
    //so its color block can be seen changing. Both use the sPauseM_RemasterMain frame in parts (see above), 4 rows each.
    var tCZX,tCZY,tCZRow,tCZc,tCZv,tCZx1,tCZx2,tCZm,tCZName,tCZLeft,tCZRight,i;
    tCZX=contentMenuX+25
    tCZY=contentMenuY+38
    draw_sprite_part(sPauseM_RemasterMain,0,0,0,272,17,tCZX,tCZY)
    for(i=0;i<4;i+=1) {draw_sprite_part(sPauseM_RemasterMain,0,0,17,272,12,tCZX,tCZY+17+(i*12))}
    draw_sprite_part(sPauseM_RemasterMain,0,0,29,272,7,tCZX,tCZY+65)
    draw_set_alpha(1)
    draw_set_font(fnt_PauseMenuMain)
    draw_set_halign(fa_left)
    draw_set_color(textColorMain)
    draw_text(tCZX+17,tCZY+1,"COLOR ZONES")
    for(i=1;i<=4;i+=1)
    {
      tCZRow=tCZY+16+((i-1)*12)
      textDropShadow("Color Zone " +string(i),tCZX+20,tCZRow,textColorMain,textColorShadow,1)
      draw_set_color(textColorShadow)
      draw_rectangle(tCZX+24+string_width("Color Zone " +string(i)),tCZRow+10,tCZX+219,tCZRow+10,0) //line out to the color
      draw_rectangle(tCZX+223,tCZRow+3,tCZX+258,tCZRow+10,0) //color block (border, then the color)
      draw_set_color(global.czColor[i])
      draw_rectangle(tCZX+224,tCZRow+4,tCZX+257,tCZRow+9,0)
    }
    //Display cursor
    draw_sprite(sPauseM_AbilArrow,0,tCZX+16,tCZY+22+((mCZ_CurPos-1)*12))
    menuInfoText="Select a color zone to change its color.#The zones, the color indicator at the top of the screen and the orbs that go with them all use these colors."

    if subMenu=17 //---------- The zone being changed: red, green, blue (0-255) and Default ----------
    {
      tCZY+=72
      draw_sprite_part(sPauseM_RemasterMain,0,0,0,272,17,tCZX,tCZY)
      for(i=0;i<4;i+=1) {draw_sprite_part(sPauseM_RemasterMain,0,0,17,272,12,tCZX,tCZY+17+(i*12))}
      draw_sprite_part(sPauseM_RemasterMain,0,0,29,272,7,tCZX,tCZY+65)
      draw_set_font(fnt_PauseMenuMain)
      draw_set_halign(fa_left)
      draw_set_color(textColorMain)
      draw_text(tCZX+17,tCZY+1,"COLOR ZONE " +string(mCZ_CurPos))
      tCZc=global.czColor[mCZ_CurPos]
      tCZx1=tCZX+72
      tCZx2=tCZX+222
      for(i=1;i<=4;i+=1)
      {
        tCZRow=tCZY+16+((i-1)*12)
        if i=1 {tCZName="Red"; tCZv=color_get_red(tCZc); tCZLeft=make_color_rgb(0,color_get_green(tCZc),color_get_blue(tCZc)); tCZRight=make_color_rgb(255,color_get_green(tCZc),color_get_blue(tCZc))}
        else if i=2 {tCZName="Green"; tCZv=color_get_green(tCZc); tCZLeft=make_color_rgb(color_get_red(tCZc),0,color_get_blue(tCZc)); tCZRight=make_color_rgb(color_get_red(tCZc),255,color_get_blue(tCZc))}
        else if i=3 {tCZName="Blue"; tCZv=color_get_blue(tCZc); tCZLeft=make_color_rgb(color_get_red(tCZc),color_get_green(tCZc),0); tCZRight=make_color_rgb(color_get_red(tCZc),color_get_green(tCZc),255)}
        else {tCZName="Default"}
        draw_set_font(fnt_PauseMenuMain)
        draw_set_halign(fa_left)
        textDropShadow(tCZName,tCZX+20,tCZRow,textColorMain,textColorShadow,1)
        if i<=3
        {
          //bar from none of this color to all of it (the other two as they are now), a marker, and the number
          draw_set_color(textColorShadow)
          draw_rectangle(tCZx1-1,tCZRow+4,tCZx2+1,tCZRow+9,0)
          draw_rectangle_color(tCZx1,tCZRow+5,tCZx2,tCZRow+8,tCZLeft,tCZRight,tCZRight,tCZLeft,0)
          tCZm=tCZx1+round(tCZv*(tCZx2-tCZx1)/255)
          draw_set_color(textColorShadow)
          draw_rectangle(tCZm-1,tCZRow+2,tCZm+1,tCZRow+11,0)
          draw_set_color(textColorMain)
          draw_rectangle(tCZm,tCZRow+3,tCZm,tCZRow+10,0)
          draw_set_font(fnt_PauseMenuText)
          draw_set_halign(fa_center)
          textDropShadow(string(tCZv),tCZX+247,tCZRow+1,textColorMain,textColorShadow,1)
        }
      }
      draw_set_halign(fa_left)
      //Display cursor
      draw_sprite(sPauseM_AbilArrow,0,tCZX+16,tCZY+22+((mCZ_EditPos-1)*12))
      if mCZ_EditPos=1 {menuInfoText="Press left or right to change the amount of red.#Hold it down to change it faster."}
      else if mCZ_EditPos=2 {menuInfoText="Press left or right to change the amount of green.#Hold it down to change it faster."}
      else if mCZ_EditPos=3 {menuInfoText="Press left or right to change the amount of blue.#Hold it down to change it faster."}
      else
      {
        if mCZ_CurPos=1 {tCZName="red"}
        else if mCZ_CurPos=2 {tCZName="blue"}
        else if mCZ_CurPos=3 {tCZName="green"}
        else {tCZName="yellow"}
        menuInfoText="Set Color Zone " +string(mCZ_CurPos) +" back to its original color (" +tCZName +")."
      }
    }
  }

  //---------- Menu Info ----------
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_PauseMenuText)
  textDropShadowExt(menuInfoText,infoMenuX+8,infoMenuY+15,textColorMain,textColorShadow,1,12,426)

  /*
  for(i=0;i<3;i+=1)
  {
    textDropShadow(global.equipJerry[i],contentMenuX-96,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
    textDropShadow(global.equipClaire[i],contentMenuX-80,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
  }
  for(i=0;i<24;i+=1)
  {
    textDropShadow(eCheck[i],contentMenuX-64,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
    textDropShadow(items[i],contentMenuX-48,contentMenuY-32+(i*12),textColorMain,make_color_rgb(12,16,15),4)
  }
  textDropShadow(global.equipItems,contentMenuX-32,contentMenuY-32,textColorMain,make_color_rgb(12,16,15),4)
  */

  //jukebox change (added): where the music playing is from, right-aligned in the bottom right (mMusicCredit, set in Create)
  if mMusicCredit!="" and global.optMusic>0
  {
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_right)
    textDropShadow("Music From",view_xview[0]+view_wview[0]-4,view_yview[0]+view_hview[0]-27,textColorMain,textColorShadow,4)
    scrTextFit(mMusicCredit,view_xview[0]+view_wview[0]-4,view_yview[0]+view_hview[0]-14,472,textColorMain,textColorShadow)
    draw_set_halign(fa_left)
  }
}
