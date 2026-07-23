#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Requires: type(string), turLevel, turPower, turFireRate
fireCheck=0
bCostDisplayed=0
bCanFire=0
bBoosted=0
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false
{
  //----- Check player distance -----
  myDist=point_distance(x,bbox_top+(sprite_height/2),oPlayer1.x,oPlayer1.y-26)
  myDistIdle=point_distance(x,bbox_top+(sprite_height/2),oPlayerIdle.x,oPlayerIdle.y-26)
  if myDist<144 or myDistIdle<144 {bBoosted=1}
  else {bBoosted=0}
  if bBoosted=1 and oGame.time mod 3=0 //Effect if being boosted
  {
    var tEffect;
    tEffect=instance_create(bbox_left+random(abs(sprite_width)),bbox_top+random(sprite_height),oEffectB)
    tEffect.type=3; tEffect.sprite_index=sMMchargeEffect1; tEffect.image_alpha=0.8
    tEffect.direction=90; tEffect.image_angle=90; tEffect.friction=0.05; tEffect.speed=1+random(2)
    tEffect.fadeSpd=0.04; tEffect.AccelX=0; tEffect.AccelY=0; tEffect.newBlend=-1; tEffect.followID=-1; tEffect.rotation=0
  }

  if myDist<80 {oTD_HUD.bCanConstruct=0}
  if myDist<40
  {
    oTD_HUD.tiStat_Type=type
    oTD_HUD.tiStat_Lv=turLevel
    oTD_HUD.tiStat_Power=turPower
    oTD_HUD.tiStat_FireRate=turFireRate
    oTD_HUD.statDisplayTime=2
    oTD_HUD.bCanDeconstruct=1
    if turLevel<5 {oTD_HUD.bCanUpgrade=1; bCostDisplayed=1}
    else {bCostDisplayed=0}
    oTD_HUD.turretID=id
  }
  else {bCostDisplayed=0}

  //----- Behavior -----
  bCanFire=0
  if type="GROUND"
  {
    if instance_exists(oTD_Ground)
    {
      var eTargetChk,eDistChk,eAngleChk;
      eTargetChk=instance_nearest(x,y,oTD_Ground)
      eDistChk=point_distance(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
      if eDistChk<=360
      {
        bCanFire=1
      }
    }
  }
  else if type="FLOAT"
  {
    if instance_exists(oEnemyBase)
    {
      var eTargetChk,eDistChk,eAngleChk;
      eTargetChk=instance_nearest(x,y,oEnemyBase)
      eDistChk=point_distance(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
      if eDistChk<=360
      {
        eAngleChk=point_direction(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
        image_angle=eAngleChk
        bCanFire=1
      }
    }
  }
  else if type="AIR"
  {
    if instance_exists(oTD_Flyer)
    {
      var eTargetChk,eDistChk,eAngleChk;
      eTargetChk=instance_nearest(x,y,oTD_Flyer)
      eDistChk=point_distance(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
      if eDistChk<=360
      {
        eAngleChk=point_direction(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
        image_angle=eAngleChk
        if image_angle<25-turLevel {image_angle=25-turLevel}
        else if image_angle>155+turLevel {image_angle=155+turLevel}
        bCanFire=1
      }
    }
  }
  else if type="SHOCK"
  {
    if instance_exists(oEnemyBase)
    {
      var eTargetChk,eDistChk,eAngleChk;
      eTargetChk=instance_nearest(x,y,oEnemyBase)
      eDistChk=point_distance(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
      if eDistChk<=240 {bCanFire=1}
    }
  }
  else if type="MEGA"
  {
    if instance_exists(oEnemyBase)
    {
      var eTargetChk,eDistChk,eAngleChk;
      eTargetChk=instance_nearest(x,y,oEnemyBase)
      eDistChk=point_distance(x,y,eTargetChk.x,eTargetChk.bbox_top+(eTargetChk.sprite_height/2))
      if eDistChk<=360 {bCanFire=1}
    }
  }

  //----- Fire cannon -----
  var tChkFR;
  tChkFR=turFireRate
  if bBoosted=1 {tChkFR*=1.15} //+15% fire rate if boosted by player proximity

  if fireCheck<34 {fireCheck+=tChkFR}
  if fireCheck>=30 and bCanFire=1
  {
    fireCheck-=30
    var myBullet;
    if type="GROUND"
    {
      myBullet=instance_create(x+(18*image_xscale),y-23,oTDTBullet)
      myBullet.atkPower=turPower; myBullet.bulletSpeed=12; myBullet.myLevel=turLevel
      if image_xscale=1 {myBullet.direction=0}
      else {myBullet.direction=180}
    }
    else if type="FLOAT"
    {
      myBullet=instance_create(x+lengthdir_x(11,image_angle),y+lengthdir_y(11,image_angle),oTDTBullet)
      myBullet.atkPower=turPower; myBullet.direction=image_angle; myBullet.myLevel=turLevel
      myBullet.sprite_index=sTurBul_Float; myBullet.bulletSpeed=18
    }
    else if type="AIR"
    {
      myBullet=instance_create(x+lengthdir_x(18,image_angle),y+lengthdir_y(18,image_angle),oTDTAir)
      myBullet.atkPower=turPower; myBullet.direction=image_angle; myBullet.bulletSpeed=23; myBullet.myLevel=turLevel
    }
    else if type="SHOCK"
    {
      myBullet=instance_create(x,y,oTDTShock)
      myBullet.atkPower=turPower; myBullet.maxSize=1.5+(turLevel*0.3); myBullet.myLevel=turLevel
    }
    else if type="MEGA"
    {
      myBullet=instance_create(x,y-16,oTDTMissile)
      myBullet.atkPower=turPower; myBullet.bulletSpeed=7; myBullet.myLevel=turLevel
    }
  }
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
if type="AIR"
{
  draw_sprite(sTurretAcc_ALegs,0,x,y+12)
}

if bCostDisplayed=1
{
  var tTypeChk,tCost;
  if type="GROUND" {tTypeChk=1}
  else if type="FLOAT" {tTypeChk=2}
  else if type="AIR" {tTypeChk=3}
  else if type="SHOCK" {tTypeChk=4}
  else if type="MEGA" {tTypeChk=5}
  tCost=scrTD_TowerStat(tTypeChk,3)
  draw_set_alpha(1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_middle)
  textDropShadow(string("Upgrade Cost#<") +string(tCost) +string(">"),x,bbox_top-40,make_color_rgb(255,248,155),make_color_rgb(16,8,8),3)
}
