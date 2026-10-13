/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Equipment submenu.
*/
draw_set_font(fnt_PauseMenuText)

draw_sprite(sPauseM_EquipMenu,0,contentMenuX+161,contentMenuY+16)
draw_sprite(sJerryIdle,0,contentMenuX+23,contentMenuY+170)
draw_sprite_ext(sClaireIdle,0,contentMenuX+303,contentMenuY+170,-1,1,0,c_white,1)

draw_set_halign(fa_middle)
textDropShadow("--Defenses--",contentMenuX+161,contentMenuY+66,textColorMain,textColorShadow,1)
textDropShadow("Normal",contentMenuX+161,contentMenuY+76,textColorMain,textColorShadow,1)
textDropShadow("Elemental",contentMenuX+161,contentMenuY+86,textColorMain,textColorShadow,1)
textDropShadow("Explosion",contentMenuX+161,contentMenuY+96,textColorMain,textColorShadow,1)
textDropShadow("Direct",contentMenuX+161,contentMenuY+109,textColorMain,textColorShadow,1)
textDropShadow("Trap",contentMenuX+161,contentMenuY+119,textColorMain,textColorShadow,1)
//----- Display Jerry Defense -----
var tDefTrap,tDefElemental,tDefExplosion,tDefDirect,tDefNormal,tEqpTrap,tEqpElemental,tEqpExplosion,tEqpDirect,tEqpNormal;
tEqpTrap=0; tEqpElemental=0; tEqpExplosion=0; tEqpDirect=0; tEqpNormal=0
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=3
  {
    tEqpElemental-=2; tEqpExplosion-=2; tEqpNormal-=2
  }
  if global.equipJerry[i]=14 {tEqpElemental+=1}
  if global.equipJerry[i]=15 {tEqpExplosion+=1}
  if global.equipJerry[i]=16 {tEqpDirect+=1}
  if global.equipJerry[i]=17 {tEqpNormal+=1}
  if global.equipJerry[i]=26 {tEqpTrap+=1}
  if global.equipJerry[i]=18
  {
    tEqpElemental+=1
    tEqpExplosion+=1
    tEqpNormal+=1
  }
}
tDefElemental=global.skillTree[14]+tEqpElemental
tDefExplosion=global.skillTree[15]+tEqpExplosion
tDefDirect=global.skillTree[16]+tEqpDirect
tDefNormal=global.skillTree[17]+tEqpNormal
tDefTrap=global.skillTree[27]+tEqpTrap
textDropShadow(tDefNormal,contentMenuX+125,contentMenuY+76,textColorMain,textColorShadow,1)
textDropShadow(tDefElemental,contentMenuX+125,contentMenuY+86,textColorMain,textColorShadow,1)
textDropShadow(tDefExplosion,contentMenuX+125,contentMenuY+96,textColorMain,textColorShadow,1)
textDropShadow(tDefDirect,contentMenuX+125,contentMenuY+109,textColorMain,textColorShadow,1)
textDropShadow(tDefTrap,contentMenuX+125,contentMenuY+119,textColorMain,textColorShadow,1)
//----- Display Claire Defense -----
var tDefTrap,tDefElemental,tDefExplosion,tDefDirect,tDefNormal,tEqpTrap,tEqpElemental,tEqpExplosion,tEqpDirect,tEqpNormal;
tEqpTrap=0; tEqpElemental=0; tEqpExplosion=0; tEqpDirect=0; tEqpNormal=0
for(i=0;i<3;i+=1)
{
  if global.equipClaire[i]=3
  {
    tEqpElemental-=2; tEqpExplosion-=2; tEqpNormal-=2
  }
  if global.equipClaire[i]=14 {tEqpElemental+=1}
  if global.equipClaire[i]=15 {tEqpExplosion+=1}
  if global.equipClaire[i]=16 {tEqpDirect+=1}
  if global.equipClaire[i]=17 {tEqpNormal+=1}
  if global.equipClaire[i]=26 {tEqpTrap+=1}
  if global.equipClaire[i]=18
  {
    tEqpElemental+=1
    tEqpExplosion+=1
    tEqpNormal+=1
  }
}
tDefElemental=global.skillTree[14]+tEqpElemental
tDefExplosion=global.skillTree[15]+tEqpExplosion
tDefDirect=global.skillTree[16]+tEqpDirect
tDefNormal=global.skillTree[17]+tEqpNormal
tDefTrap=global.skillTree[27]+tEqpTrap
textDropShadow(tDefNormal,contentMenuX+195,contentMenuY+76,textColorMain,textColorShadow,1)
textDropShadow(tDefElemental,contentMenuX+195,contentMenuY+86,textColorMain,textColorShadow,1)
textDropShadow(tDefExplosion,contentMenuX+195,contentMenuY+96,textColorMain,textColorShadow,1)
textDropShadow(tDefDirect,contentMenuX+195,contentMenuY+109,textColorMain,textColorShadow,1)
textDropShadow(tDefTrap,contentMenuX+195,contentMenuY+119,textColorMain,textColorShadow,1)

//----- Jerry Stats -----
draw_set_halign(fa_left)
textDropShadow("Damage Boost",contentMenuX+5,contentMenuY+15,textColorMain,textColorShadow,1)
draw_set_halign(fa_right)
var tEqpAdj; tEqpAdj=0
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]=1 {tEqpAdj+=5}
  else if global.equipJerry[i]=2 {tEqpAdj+=10}
  else if global.equipJerry[i]=3 {tEqpAdj+=15}
  else if global.equipJerry[i]=18 {tEqpAdj-=10}
}
textDropShadow(string(global.skillTree[20]*2+tEqpAdj) +string("%"),contentMenuX+108,contentMenuY+25,textColorMain,textColorShadow,1)
if global.hasAbilToken[1]>0
{
  draw_set_halign(fa_left)
  textDropShadow("Bomb Cooldown",contentMenuX+5,contentMenuY+35,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  var tBombRec,tBombEquChk;
  tBombEquChk=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=20
    {
      tBombEquChk=20
      break;
    }
  }
  tBombRec=(120-round(global.skillTree[1]*7.5)-tBombEquChk)/30
  textDropShadow(string(tBombRec) +string(" Sec"),contentMenuX+108,contentMenuY+45,textColorMain,textColorShadow,1)
}
if global.hasAbilToken[3]>0
{
  draw_set_halign(fa_left)
  textDropShadow("X Buster Charge",contentMenuX+5,contentMenuY+55,textColorMain,textColorShadow,1)
  textDropShadow("X Special Charge",contentMenuX+5,contentMenuY+75,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  var tXBuster,tXSpecial,tXCharge;
  tXCharge=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=9
    {
      tXCharge=7
      break;
    }
  }
  tXBuster=(40-(global.skillTree[5]*2)-tXCharge)/30
  tXSpecial=(55-(global.skillTree[6]*5)-tXCharge)/30
  textDropShadow(string(tXBuster) +string(" Sec"),contentMenuX+108,contentMenuY+65,textColorMain,textColorShadow,1)
  textDropShadow(string(tXSpecial) +string(" Sec"),contentMenuX+108,contentMenuY+85,textColorMain,textColorShadow,1)
}

//----- Claire Stats -----
draw_set_halign(fa_left)
textDropShadow("Damage Boost",contentMenuX+212,contentMenuY+15,textColorMain,textColorShadow,1)
draw_set_halign(fa_right)
var tEqpAdj; tEqpAdj=0
for(i=0;i<3;i+=1)
{
  if global.equipClaire[i]=1 {tEqpAdj+=5}
  else if global.equipClaire[i]=2 {tEqpAdj+=10}
  else if global.equipClaire[i]=3 {tEqpAdj+=15}
  else if global.equipClaire[i]=18 {tEqpAdj-=10}
}
textDropShadow(string(global.skillTree[21]*2+tEqpAdj) +string("%"),contentMenuX+316,contentMenuY+25,textColorMain,textColorShadow,1)
if global.hasAbilToken[2]>0
{
  draw_set_halign(fa_left)
  textDropShadow("Heart Recovery",contentMenuX+212,contentMenuY+35,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  var tHeartRate,tEqpAdj;
  tEqpAdj=0
  equipValA=0
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=8
    {
      tEqpAdj=3
      break;
    }
  }
  tHeartRate=(21-(global.skillTree[2]*3)-tEqpAdj)/30
  textDropShadow(string(tHeartRate) +string(" Sec"),contentMenuX+316,contentMenuY+45,textColorMain,textColorShadow,1)
}
if global.hasAbilToken[4]>0
{
  draw_set_halign(fa_left)
  textDropShadow("Missile Charge",contentMenuX+212,contentMenuY+55,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  var tMissile,tMCharge;
  tMCharge=0
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=19
    {
      tMCharge=14
      break;
    }
  }
  tMissile=(55-(global.skillTree[7]*6)-tMCharge)/30
  textDropShadow(string(tMissile) +string(" Sec"),contentMenuX+316,contentMenuY+65,textColorMain,textColorShadow,1)
}

//----- Jerry Equipment Slots -----
for(i=0;i<3;i+=1)
{
  if global.equipJerry[i]>0
    draw_sprite(sEquipItemIcons,global.equipJerry[i]-1,contentMenuX+70+(i*34),contentMenuY+151)
  else if global.equipJerry[i]=-1
  {
    draw_set_color(c_red)
    draw_line_width(contentMenuX+58+(i*34),contentMenuY+139,contentMenuX+81+(i*34),contentMenuY+162,2)
    draw_line_width(contentMenuX+81+(i*34),contentMenuY+139,contentMenuX+58+(i*34),contentMenuY+162,2)
  }
}

//----- Claire Equipment Slots -----
for(i=0;i<3;i+=1)
{
  if global.equipClaire[i]>0
    draw_sprite(sEquipItemIcons,global.equipClaire[i]-1,contentMenuX+184+(i*34),contentMenuY+151)
  else if global.equipClaire[i]=-1
  {
    draw_set_color(c_red)
    draw_line_width(contentMenuX+172+(i*34),contentMenuY+139,contentMenuX+195+(i*34),contentMenuY+162,2)
    draw_line_width(contentMenuX+195+(i*34),contentMenuY+139,contentMenuX+172+(i*34),contentMenuY+162,2)
  }
}

//----- Display bottles -----
for(i=0;i<2;i+=1)
{
  if bottles[i]="1"
    draw_sprite(sPauseM_ExtraItemIcons,0,contentMenuX+152+(i*18),contentMenuY+30)
  else if bottles[i]="2"
    draw_sprite(sPauseM_ExtraItemIcons,1,contentMenuX+152+(i*18),contentMenuY+30)
  else if bottles[i]="3"
    draw_sprite(sPauseM_ExtraItemIcons,2,contentMenuX+152+(i*18),contentMenuY+30)
}
