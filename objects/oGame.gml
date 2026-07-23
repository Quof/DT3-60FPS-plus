#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
gameCreateEvent()
bStatRender=false
windowUpdate=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if keyboard_check_pressed(vk_f2)
{
    if global.gameFrameRate==30
        global.gameFrameRate=60
    else if global.gameFrameRate==60
        global.gameFrameRate=120
    else
        global.gameFrameRate=30
    room_speed=global.gameFrameRate
    gDeltaTime = 30/global.gameFrameRate
    gDeltaDoTicks = 0
    gDeltaTick = 0.0
}
room_speed=global.gameFrameRate

gDeltaDoTicks = 0
gDeltaTick += gDeltaTime
while (gDeltaTick >= 1.0)
{
    gDeltaDoTicks += 1
    gDeltaTick -= 1.0
}
if gDeltaTime == 1.0 { gDeltaDoTicks = 1; gDeltaTick = 0.999999 }

if global.gamePaused=false
  gameStepEvent()

with (all)
{
    if gDeltaTime == 1.0 break;
    image_index -= image_speed
    image_index += image_speed * gDeltaTime
}
with (all)
{
    if gDeltaTime == 1.0 break;
    // I left friction-having objects mostly alone, because almost all of them are visual effects.
    // Any gameplay-affecting friction-having objects should be modified to not use friction.
    if friction != 0
    {
        x += hspeed * gDeltaTime
        y += vspeed * gDeltaTime
        x -= hspeed
        y -= vspeed
        speed += friction * (1.0 - gDeltaTime)
    }
}

//game window check
windowUpdate+=1
if windowUpdate mod 30=0
{
  if !window_get_fullscreen()
  {
    var tCheckWidth;
    tCheckWidth=round(window_get_width()*0.7333)
    window_set_size(window_get_width(),tCheckWidth)
  }
}

//play time
if global.playTimeFrameCount>=30
{
  global.playTimeFrameCount=0
  global.playTimeSecond+=1
  if global.playTimeSecond>=60
  {
    global.playTimeSecond=0
    global.playTimeMinute+=1
    if global.playTimeMinute>=60
    {
      global.playTimeMinute=0
      global.playTimeHour+=1
    }
  }

  global.sessionPlayTime+=1
  if global.sessionPlayTime=7200 //2 hour notice
  {
    createScreenText(514,336,-1,fnt_Swap,fa_left,"You have been playing for 2 hours. It might be a good idea to take a break. Remember, extended play could be hazardous to your health or something like that. Actually you seem to be having fun if you've been playing that long, so go ahead and continue.",3,c_white,1,1)
  }
  else if global.sessionPlayTime=86400 //24 hour notice
  {
    createScreenText(514,336,-1,fnt_Swap,fa_left,"Go to sleep, Quof! You have been playing for 24 hours! It's time to sleep... ... ... GO TO SLEEP!",3,c_white,1,1)
  }
}
else {global.playTimeFrameCount+=1*gDeltaTime}

//close the game
if global.bCanUseEsc=1
{
  if keyboard_check_pressed(vk_escape)
  {
    var closeGame;
    closeGame=show_question("Do you want to quit the game? :(")
    if closeGame=true {game_end()}
  }
}

//windowed mode scale change 1x/2x/3x
if keyboard_check_pressed(vk_f3)
{
  if global.optWindowSize<2 {global.optWindowSize=2}
  else if global.optWindowSize>=2 and global.optWindowSize<3 {global.optWindowSize=3}
  else {global.optWindowSize=1}
  window_set_size(480*global.optWindowSize,352*global.optWindowSize)
  window_center()
}
//windowed/fullscreen mode
if keyboard_check_pressed(vk_f4) //and room!=rAbomF
{
  windowUpdate=15
  if window_get_fullscreen()
  {
    window_set_fullscreen(false)
    window_center()
  }
  else
  {
    window_set_fullscreen(true)
    window_center()
  }
}

if global.debugMenu=true //debug commands
{
  if keyboard_check_pressed(vk_f5)
  {
    if bStatRender=false
      bStatRender=true
    else
      bStatRender=false
  }
  else if keyboard_check_pressed(vk_f7)
  {
    //global.debugMenu=false
  }
  else if keyboard_check_pressed(vk_f8)
  {
    if global.gamePaused=0
      global.gamePaused=1
    else
      global.gamePaused=0
  }
  else if keyboard_check_pressed(vk_f11)
  {
    execute_string(get_string("Command?",""))
  }

  if keyboard_check_pressed(ord("N"))
  {
    if oInvisibleSolid.visible=false
    {
      oInvisibleSolid.visible=1
      oInvisibleSlimSolid.visible=1
      oInvisibleSlimVertSolidMask.visible=1
      oInvisibleSolidMorph.visible=1
      oInvisibleRupLowSlope.visible=1
      oInvisibleLupLowSlope.visible=1
      oInvisibleRCeilingLowSlope.visible=1
      oInvisibleLCeilingLowSlope.visible=1
      oInvisibleRupSlope.visible=1
      oInvisibleLupSlope.visible=1
      oInvisibleRCeilingSlope.visible=1
      oInvisibleLCeilingSlope.visible=1
      oInvisibleRUpSteepSlope.visible=1
      oInvisibleLUpSteepSlope.visible=1
      oInvisibleRCeilingSteepSlope.visible=1
      oInvisibleLCeilingSteepSlope.visible=1
      oInvisiblePlatform.visible=1
      oIVaultHoriz.visible=1
      oIVaultVert.visible=1
      oIVaultC1.visible=1
      oIVaultC2.visible=1
      oIVaultC3.visible=1
      oIVaultC4.visible=1
      oIVaultCir1.visible=1
      oIVaultCir2.visible=1
      oIVaultCir3.visible=1
      oIVaultCir4.visible=1
    }
    else
    {
      oInvisibleSolid.visible=0
      oInvisibleSlimSolid.visible=0
      oInvisibleSlimVertSolidMask.visible=0
      oInvisibleSolidMorph.visible=0
      oInvisibleRupLowSlope.visible=0
      oInvisibleLupLowSlope.visible=0
      oInvisibleRCeilingLowSlope.visible=0
      oInvisibleLCeilingLowSlope.visible=0
      oInvisibleRupSlope.visible=0
      oInvisibleLupSlope.visible=0
      oInvisibleRCeilingSlope.visible=0
      oInvisibleLCeilingSlope.visible=0
      oInvisibleRUpSteepSlope.visible=0
      oInvisibleLUpSteepSlope.visible=0
      oInvisibleRCeilingSteepSlope.visible=0
      oInvisibleLCeilingSteepSlope.visible=0
      oInvisiblePlatform.visible=0
      oIVaultHoriz.visible=0
      oIVaultVert.visible=0
      oIVaultC1.visible=0
      oIVaultC2.visible=0
      oIVaultC3.visible=0
      oIVaultC4.visible=0
      oIVaultCir1.visible=0
      oIVaultCir2.visible=0
      oIVaultCir3.visible=0
      oIVaultCir4.visible=0
    }
  }
  else if keyboard_check_pressed(ord("B"))
  {
    oPlayer1.life=oPlayer1.maxLife
  }
  else if keyboard_check(ord("Y"))
    instance_create(0,0,oScreenEffect)
  else if keyboard_check(ord("T"))
  {
    oPlayer1.dashEnergy=oPlayer1.dashMeterMax
    global.desertHeat=1500
    global.pCurrBreath=global.pBreathMax
    global.hudLink_Arrows[0]=global.hudLink_Arrows[1]
    global.hudLink_BombEn[0]=150-(global.skillTree[1]*15)-oPlayer1.equipValA
    global.hudBelmont_WeaponEn[0]=global.hudBelmont_WeaponEn[1]
    global.hudMega_BusterEn[0]=32
    global.hudMega_ShotIceEn[0]=32
    global.hudMega_GravityEn[0]=32
    global.hudSamus_CannonEn[0]=0
    global.hudSamus_Missiles[0]=global.hudSamus_Missiles[1]
    global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]
  }

  if keyboard_check_pressed(vk_numpad1)
  {
    stopLoopingSounds()
    room_restart()
  }
  else if keyboard_check_pressed(vk_numpad3)
  {
    stopLoopingSounds()
    writeToPlayerGlobals()
    room_restart()
  }
  else if keyboard_check_pressed(vk_numpad7)
  {
    if room!=room_first
    {
      stopLoopingSounds()
      writeToPlayerGlobals()
      room_goto_previous()
    }
  }
  else if keyboard_check_pressed(vk_numpad8)
  {
    if room!=room_last
    {
      stopLoopingSounds()
      writeToPlayerGlobals()
      room_goto_next()
    }
  }
  else if keyboard_check_pressed(vk_numpad9)
  {
    stopLoopingSounds()
    stopAllMusic()
    room_goto(rIntro)
  }
  else if keyboard_check_pressed(ord("R"))
  {
    if global.debugInvincible=false
      global.debugInvincible=true
    else
      global.debugInvincible=false
  }
}
else
{
  /*if keyboard_check_pressed(vk_f7)
  {
    global.debugMenu=true
  }*/
}
#define Other_3
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
SS_Unload()
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if view_current=0
{
  if bStatRender=true
  {
    xSet=view_xview[0]+4
    ySet=view_yview[0]+80
    draw_set_color(c_black)
    draw_set_alpha(1)
    draw_set_halign(fa_left)
    draw_set_font(fnt_StatRender)
    textDropShadow("> FPS: " +string(fps),xSet,ySet,c_white,c_black,1)
    textDropShadow("> Object Num: " +string(instance_count),xSet,ySet+10,c_white,c_black,1)
    textDropShadow("> Current Map ID: " +string(room),xSet,ySet+20,c_white,c_black,1)
    textDropShadow("> Map Prev/Next: " +string(room_previous(room)) +string(" / ") +string(room_next(room)),xSet,ySet+30,c_white,c_black,1)
    textDropShadow("> Map ID Range: " +string(room_first) +string(" / ") +string(room_last),xSet,ySet+40,c_white,c_black,1)
    textDropShadow("> Game Progress: " +string(global.gameProgress) +string(" / ") +string(global.eGateProg),xSet,ySet+50,c_white,c_black,1)
    textDropShadow("> Current Music Index: " +string(global.currentMusic),xSet,ySet+60,c_white,c_black,1)
    if instance_exists(oPlayer1) and !instance_exists(oScreenCutIn)
    {
      textDropShadow("> Player X / Y Pos: " +string(oPlayer1.x) +string(" / " +string(oPlayer1.y)),xSet,ySet+80,c_white,c_black,1)
      textDropShadow("> Player X / Y Vel: " +string(oPlayer1.xVel) +string(" / ") +string(oPlayer1.yVel),xSet,ySet+90,c_white,c_black,1)
      textDropShadow("> Steps Pressed L / R: " +string(oPlayer1.kLeftPushedSteps) +string(" / ") +string(oPlayer1.kRightPushedSteps),xSet,ySet+100,c_white,c_black,1)
      textDropShadow("> Slow Fall Time / Effect: " +string(oPlayer1.slowFallTime) +string(" / ") +string(oPlayer1.slowFallEffect),xSet,ySet+110,c_white,c_black,1)
      textDropShadow("> M: " +string(global.hasShoes[0]) +string("  >J: ") +string(global.hasShoes[1]) +string("  >D: ") +string(global.hasShoes[2]) +string("  >AD: ") +string(global.hasShoes[3]) +string("  >DD: ") +string(global.canDoubleJump),xSet,ySet+120,c_white,c_black,1)
      textDropShadow("> XP: " +string(global.pAPExp) +string(" / ") +string(global.pAPNext),xSet,ySet+130,c_white,c_black,1)
      textDropShadow("> State: " +string(oPlayer1.state),xSet,ySet+140,c_white,c_black,1)
      textDropShadow("> Attack State: " +string(oPlayer1.attackState),xSet,ySet+150,c_white,c_black,1)
      textDropShadow("> Item Stock: " +string(global.equipItems) +string("   ") +string(global.extraItems),xSet,ySet+160,c_white,c_black,1)
      textDropShadow("> Player Animation Speed: " +string(oPlayer1.image_speed),xSet,ySet+170,c_white,c_black,1)
      textDropShadow("> Player Sprite Index ID/Index: " +string(oPlayer1.sprite_index) +string(" / ") +string(oPlayer1.image_index),xSet,ySet+180,c_white,c_black,1)
      textDropShadow("> Abil Token:",xSet,ySet+190,c_white,c_black,1)
      for(i=0;i<7;i+=1)
      {
        textDropShadow(global.hasAbilToken[i],xSet+64+(i*12),ySet+190,c_white,c_black,1)
      }
      textDropShadow("> Chao X / Y Pos: " +string(mouse_x) +string(",") +string(mouse_y),xSet,ySet+200,c_white,c_black,1)

      textDropShadow("> Dash Momentum: " +string(oPlayer1.dashMomentumTime),xSet+320,ySet,c_white,c_black,1)
      textDropShadow("> (J) Forward Dash Recovery: " +string(oPlayer1.groundDashRecovery),xSet+320,ySet+10,c_white,c_black,1)
      textDropShadow("> (J) Back Dash Recovery: " +string(oPlayer1.backDashRecovery),xSet+320,ySet+20,c_white,c_black,1)
      textDropShadow("> Air Dash Recovery: " +string(oPlayer1.airDashRecovery),xSet+320,ySet+30,c_white,c_black,1)
      textDropShadow("> Double Jump Anim: " +string(oPlayer1.doubleJumpAnim),xSet+320,ySet+40,c_white,c_black,1)

      textDropShadow("> kLeft: " +string(oPlayer1.kLeft),xSet+320,ySet+60,c_white,c_black,1)
      textDropShadow("> kRight: " +string(oPlayer1.kRight),xSet+320,ySet+70,c_white,c_black,1)
      textDropShadow("> kUp: " +string(oPlayer1.kUp),xSet+320,ySet+80,c_white,c_black,1)
      textDropShadow("> kDown: " +string(oPlayer1.kDown),xSet+320,ySet+90,c_white,c_black,1)
      textDropShadow("> kJump: " +string(oPlayer1.kJump),xSet+320,ySet+100,c_white,c_black,1)
      textDropShadow("> kJumpPressed: " +string(oPlayer1.kJumpPressed),xSet+320,ySet+110,c_white,c_black,1)
      textDropShadow("> kCharSwap: " +string(oPlayer1.kCharSwap),xSet+320,ySet+120,c_white,c_black,1)
      textDropShadow("> kCharSwapPressed: " +string(oPlayer1.kCharSwapPressed),xSet+320,ySet+130,c_white,c_black,1)
      textDropShadow("> kAbilSwapPressed: " +string(oPlayer1.kAbilSwapPressed),xSet+320,ySet+140,c_white,c_black,1)
      textDropShadow("> kAbilSwap: " +string(oPlayer1.kAbilSwap),xSet+320,ySet+150,c_white,c_black,1)
      textDropShadow("> kActA: " +string(oPlayer1.kActA),xSet+320,ySet+160,c_white,c_black,1)
      textDropShadow("> kActAPressed: " +string(oPlayer1.kActAPressed),xSet+320,ySet+170,c_white,c_black,1)
      textDropShadow("> kActB: " +string(oPlayer1.kActB),xSet+320,ySet+180,c_white,c_black,1)
      textDropShadow("> kActBPressed: " +string(oPlayer1.kActBPressed),xSet+320,ySet+190,c_white,c_black,1)
      textDropShadow("> kActC: " +string(oPlayer1.kActC),xSet+320,ySet+200,c_white,c_black,1)
      textDropShadow("> kActCPressed: " +string(oPlayer1.kActCPressed),xSet+320,ySet+210,c_white,c_black,1)
    }
  }

  draw_set_color(c_black)
  draw_set_alpha(1)
  draw_set_halign(fa_left)
  draw_set_font(fnt_StatRender)
  //Display key states
  if global.optShowKeyState=1
  {
    if scrController(1) {draw_sprite_ext(sKeyPressDisplay,0,view_xview[0]+98,view_yview[0]+343,1,1,180,c_white,1)} //Left
    if scrController(2) {draw_sprite_ext(sKeyPressDisplay,0,view_xview[0]+108,view_yview[0]+344,1,1,0,c_white,1)} //Right
    if scrController(3) {draw_sprite_ext(sKeyPressDisplay,0,view_xview[0]+117,view_yview[0]+343,1,1,90,c_white,1)} //Up
    if scrController(4) {draw_sprite_ext(sKeyPressDisplay,0,view_xview[0]+125,view_yview[0]+344,1,1,270,c_white,1)} //Down
    if scrController(5) {draw_sprite_ext(sKeyPressDisplay,1,view_xview[0]+135,view_yview[0]+344,1,1,0,c_white,1)} //Jump
    if scrController(6) {draw_sprite_ext(sKeyPressDisplay,2,view_xview[0]+144,view_yview[0]+344,1,1,0,c_white,1)} //Action A
    if scrController(7) {draw_sprite_ext(sKeyPressDisplay,3,view_xview[0]+153,view_yview[0]+344,1,1,0,c_white,1)} //Action B
    if scrController(8) {draw_sprite_ext(sKeyPressDisplay,4,view_xview[0]+162,view_yview[0]+344,1,1,0,c_white,1)} //Action C
    if scrController(9) {draw_sprite_ext(sKeyPressDisplay,5,view_xview[0]+171,view_yview[0]+344,1,1,0,c_white,1)} //Character Swap
    if scrController(10) {draw_sprite_ext(sKeyPressDisplay,5,view_xview[0]+179,view_yview[0]+343,1,1,180,c_white,1)} //Ability Swap
    if scrController(13) {draw_sprite_ext(sKeyPressDisplay,6,view_xview[0]+188,view_yview[0]+343,1,1,180,c_white,1)} //Dash Left
    if scrController(14) {draw_sprite_ext(sKeyPressDisplay,6,view_xview[0]+198,view_yview[0]+344,1,1,0,c_white,1)} //Dash Right
  }

  //Display debug states
  if global.debugInvincible=true
    textDropShadow("<INVINCIBILITY ON>",view_xview[0]+4,view_yview[0]+322,c_white,c_black,1)
  if global.debugMenu=true
    textDropShadow("<DEBUG MODE ON>",view_xview[0]+4,view_yview[0]+338,c_white,c_black,1)
}
