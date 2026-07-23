#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.bTowerDefense=1 {tdStat_Resources=400; maxWave=10}
else if global.bTowerDefense=2 {tdStat_Resources=600; maxWave=10}
else if global.bTowerDefense=3 {tdStat_Resources=1000; maxWave=10}
else if global.bTowerDefense=4 {tdStat_Resources=2500; maxWave=10}
else if global.bTowerDefense=5 {tdStat_Resources=3000; maxWave=10}
else {tdStat_Resources=500; maxWave=10}

tdStat_Turrets=0
tdStat_Wave=0
tdStat_Stability=10

turretCapacityCost=400
stabilityCapacityCost=400
recoverCost=100
repairCooldown=0

maxTurrets=20
maxStability=10

bCanConstruct=1
bCanUpgrade=0
bCanDeconstruct=0
bCanBaseUpgrade=0

statDisplayTime=0
turretID=-1

tiStat_Type=""
tiStat_Lv=1
tiStat_Power=1
tiStat_FireRate=1
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  if repairCooldown>0 {repairCooldown-=1}
  if statDisplayTime>0 {statDisplayTime-=1}
  bCanUpgrade=0
  bCanDeconstruct=0
  bCanConstruct=1
  bCanBaseUpgrade=0
  tdStat_Turrets=instance_number(oTD_Turret)
  if tdStat_Turrets=maxTurrets {bCanConstruct=0}

  if tdStat_Stability<=0 {oPlayer1.life-=oPlayer1.maxLife}
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optShowHUD=1
{
  statusWinX=view_xview[0]+379
  statusWinY=view_yview[0]+292
  draw_sprite(sTD_StatusWindow,0,statusWinX,statusWinY)
  draw_set_alpha(1)
  draw_set_font(fnt_TDInfo)
  draw_set_halign(fa_right)
  textDropShadow(tdStat_Resources,statusWinX+91,statusWinY+11,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
  textDropShadow(string(tdStat_Turrets) +string(" / ") +string(maxTurrets),statusWinX+91,statusWinY+19,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
  textDropShadow(string(tdStat_Wave) +string(" / ") +string(maxWave),statusWinX+91,statusWinY+27,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
  textDropShadow(instance_number(oEnemyBase),statusWinX+91,statusWinY+35,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
  textDropShadow(string(tdStat_Stability) +string(" / ") +string(maxStability),statusWinX+91,statusWinY+43,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)

  if statDisplayTime>0
  {
    turretWinX=view_xview[0]+296
    turretWinY=view_yview[0]+300
    draw_sprite(sTD_TurretWindow,0,turretWinX,turretWinY)
    textDropShadow(tiStat_Type,turretWinX+74,turretWinY+11,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
    textDropShadow(tiStat_Lv,turretWinX+74,turretWinY+19,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
    textDropShadow(tiStat_Power,turretWinX+74,turretWinY+27,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
    textDropShadow(tiStat_FireRate,turretWinX+74,turretWinY+35,make_color_rgb(255,248,155),make_color_rgb(16,8,8),1)
  }

  if room_speed=60
  {
    draw_set_alpha(1)
    draw_set_font(fnt_PauseMenuText)
    draw_set_halign(fa_middle)
    textDropShadow("2x",view_xview[0]+240,view_yview[0]+336,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
  }
}
