#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
parent="enemy"
setCollisionBounds(-1,-1,1,1)
event_inherited()
bShowHealthBar=true

alarm[10]=2
#define Alarm_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.modeButtface=1
{
  eName="Buttface McGee"
}
#define Step_2
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if setNewName=0
{
  if variable_local_exists("newName")
  {
    eName=newName
  }
  setNewName=1
}
#define Collision_oClaireParryWindow
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.location=58 or global.location=76 or global.location=107
{
  if bCanBeBlocked=1 and bParryOpp=1 and bCanDealDamage=1
  {
    playSound(global.snd_MMBulletDeflect,0,1,10000)
    global.hudGame_WeaponEn[0]+=3
    if global.hudGame_WeaponEn[0]>global.hudGame_WeaponEn[1] {global.hudGame_WeaponEn[0]=global.hudGame_WeaponEn[1]}
    awardAwesome(50)
    global.recParried+=1
    oPlayer1.blockForceTime=0
    global.stJGame_C[0]=5000
    oPlayer1.attackState=0
    var tEffect;
    tEffect=instance_create(oPlayer1.x,oPlayer1.y-2,oEffect); tEffect.image_blend=c_blue; tEffect.image_speed=0.5
    tEffect.sprite_index=sAirDashWave; tEffect.followID=oPlayer1.id; tEffect.xFollow=0; tEffect.yFollow=-2
    tEffect.newBlend=-1; tEffect.decay=-100; tEffect.xSpd=0; tEffect.ySpd=0; tEffect.image_xscale=-oPlayer1.image_xscale
    with other {instance_destroy()}
  }
}
#define Mouse_4
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.gamePaused=false and jeremyText!="" and oIdentifier.bCanScan=1 and bCanBeScanned=1 and life>0
{
  with oMessageEnemy {instance_destroy()}
  var newMessage;
  newMessage=instance_create(view_xview[0]+32,view_yview[0]+24,oMessageEnemy)
  newMessage.enemyID=id
  var tNoScan;
  tNoScan="01010101 01001110 01000001 01010110 01000001 01001001 01001100 01000001 01000010 01001100 01000101"
  if global.charScan[0]=1 {newMessage.scanText=jeremyText}
  else
  {
    newMessage.scanText=tNoScan
    newMessage.jeremyText=tNoScan
  }
  if global.charScan[1]!=1 {newMessage.chaoText=tNoScan}
  if moneyWorth=0 {newMessage.moneyType=0}
  else if moneyWorth=1 {newMessage.moneyType=sCoin_1}
  else if moneyWorth=5 {newMessage.moneyType=sCoin_5}
  else if moneyWorth=10 {newMessage.moneyType=sCoin_10}
  else if moneyWorth=20 {newMessage.moneyType=sCoin_20}
  newMessage.effectX=mouse_x
  newMessage.effectY=mouse_y
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if global.optShowHoverInfo=1 and bIsBoss=0 and hoverAlpha!=-1
{
  if place_meeting(x,y,oIdentifier) {hoverAlpha=1.5}
  if hoverAlpha>0 and oIdentifier.bCanScan=1
  {
    hoverAlpha-=0.05
    draw_set_font(fnt_EnemyName)
    draw_set_halign(fa_center)
    draw_set_alpha(hoverAlpha)
    var tHoverX,tHoverY;
    tHoverX=floor(bbox_left+(abs(sprite_width)/2))
    tHoverY=floor(bbox_top-14)
    textDropShadow(string(eName) +string(" (") +string(life) +string(")"),tHoverX,tHoverY-12,make_color_rgb(0,255,0),c_black,1)

    var tCheckWorth;
    tCheckWorth=pointWorth
    if global.pAPLevel>eLevel //Smaller award
    {
      var tLvDif,tLvMod,tLvTotal;
      tLvDif=abs(global.pAPLevel-eLevel)
      tLvMod=tCheckWorth*0.08
      tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

      tCheckWorth-=tLvTotal
      if tCheckWorth<round(pointWorth/3) {tCheckWorth=round(pointWorth/3)}
      if tCheckWorth<1 {tCheckWorth=1}
    }
    else if global.pAPLevel<eLevel //Bigger award
    {
      var tLvDif,tLvMod,tLvTotal;
      tLvDif=abs(global.pAPLevel-eLevel)
      tLvMod=tCheckWorth*0.05
      tLvTotal=(tLvMod*tLvDif)+(tLvDif*1.5)

      tCheckWorth+=tLvTotal
      if tCheckWorth>pointWorth*2 {tCheckWorth=pointWorth*2}
    }
    textDropShadow(string("AP Award: ") +string(round(tCheckWorth)),tHoverX,tHoverY,make_color_rgb(0,255,0),c_black,1)
  }
}
event_inherited()
