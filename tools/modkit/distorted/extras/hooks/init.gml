//Distorted's game variables (the original added them to initGameVars). Runs when the mods are loaded and again each
//time the game's variables are set up (a new game, loading a save).

//a bigger wallet (a save has its own, read after this)
global.pMoneyMax=30000
//playing in Distorted mode
global.bDistortedMode=1
//Ice mode (the anicephysicsengine title screen code, and the Water Palace's rooms), and the Sanctuary's fights
global.modeNice=0
global.RType=0
//colour zones left by defeated enemies (Vault rooms)
global.deathZonesOn=0
//DDLC: access to the hubs, the bosses beaten in the Sanctuary, the platforming screens' main and side progression, and
//the worst/best screens (saved: the save and load hooks)
global.ddlcMain=0
global.ddlcBoss=0
global.hexMain=0
global.hexSide=0
global.hexWhy=0
//the 2x speed room (see the roomStart hook, which ends it in any other room)
if !variable_global_exists("distSpeedRoom") {global.distSpeedRoom=0}

//the window's title (the original set it in rIntro, the first room, which runs before the mods are loaded)
set_application_title("DT3 Distorted: the spinach special")

//the Hex Worm's paths: Distorted moved their points (set once, when the mods are loaded)
if !variable_global_exists("distPaths")
{
  global.distPaths=1
  path_clear_points(pth_HW_A)
  path_add_point(pth_HW_A,512,64,100)
  path_add_point(pth_HW_A,480,64,100)
  path_add_point(pth_HW_A,352,64,100)
  path_add_point(pth_HW_A,128,32,100)
  path_add_point(pth_HW_A,-16,112,100)
  path_add_point(pth_HW_A,48,384,100)
  path_add_point(pth_HW_A,304,272,100)
  path_add_point(pth_HW_A,272,128,100)
  path_add_point(pth_HW_A,144,16,100)
  path_add_point(pth_HW_A,0,80,100)
  path_add_point(pth_HW_A,80,256,100)
  path_add_point(pth_HW_A,208,0,100)

  path_clear_points(pth_HW_B)
  path_add_point(pth_HW_B,432,0,100)
  path_add_point(pth_HW_B,432,48,100)
  path_add_point(pth_HW_B,112,64,100)
  path_add_point(pth_HW_B,0,80,100)
  path_add_point(pth_HW_B,192,352,100)
  path_add_point(pth_HW_B,96,0,100)
  path_add_point(pth_HW_B,448,336,100)
  path_add_point(pth_HW_B,48,336,100)
  path_add_point(pth_HW_B,160,240,100)
  path_add_point(pth_HW_B,288,272,100)
  path_add_point(pth_HW_B,416,80,100)
  path_add_point(pth_HW_B,128,32,100)
  path_add_point(pth_HW_B,192,144,100)
  path_add_point(pth_HW_B,208,320,100)
  path_add_point(pth_HW_B,304,176,100)
  path_add_point(pth_HW_B,224,128,100)
  path_add_point(pth_HW_B,-32,48,100)

  path_clear_points(pth_HW_C)
  path_add_point(pth_HW_C,416,384,100)
  path_add_point(pth_HW_C,416,352,100)
  path_add_point(pth_HW_C,416,320,100)
  path_add_point(pth_HW_C,448,160,100)
  path_add_point(pth_HW_C,416,48,100)
  path_add_point(pth_HW_C,384,48,100)
  path_add_point(pth_HW_C,352,328,100)
  path_add_point(pth_HW_C,320,328,100)
  path_add_point(pth_HW_C,272,48,100)
  path_add_point(pth_HW_C,240,48,100)
  path_add_point(pth_HW_C,16,144,100)
  path_add_point(pth_HW_C,16,192,100)
  path_add_point(pth_HW_C,240,336,100)
  path_add_point(pth_HW_C,208,336,100)
  path_add_point(pth_HW_C,64,328,100)
  path_add_point(pth_HW_C,32,328,100)
  path_add_point(pth_HW_C,128,-16,100)
}
