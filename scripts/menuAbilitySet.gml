/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Ability Set submenu.
*/

//Display current character and ability arrows
draw_set_color(textColorShadow)
draw_line(contentMenuX+8,contentMenuY+19,contentMenuX+8,contentMenuY+27) //char left
draw_line(contentMenuX+51,contentMenuY+19,contentMenuX+51,contentMenuY+27) //char right
draw_line(contentMenuX-1,contentMenuY+43,contentMenuX+60,contentMenuY+43) //abil top
draw_line(contentMenuX-1,contentMenuY+54,contentMenuX+60,contentMenuY+54) //abil bottom
draw_sprite_ext(sPauseM_AbilArrow,0,contentMenuX-2,contentMenuY+22,1,1,180,c_white,1) //left
draw_sprite(sPauseM_AbilArrow,0,contentMenuX+61,contentMenuY+22) //right
draw_sprite_ext(sPauseM_AbilArrow,0,contentMenuX+29,contentMenuY+33,1,1,90,c_white,1) //up
draw_sprite_ext(sPauseM_AbilArrow,0,contentMenuX+29,contentMenuY+64,1,1,270,c_white,1) //down
//Display ability lines
draw_sprite(sPauseM_AbilLine,0,contentMenuX+76,contentMenuY+16)
draw_sprite(sPauseM_AbilLine,0,contentMenuX+76,contentMenuY+69)
draw_sprite(sPauseM_AbilLine,0,contentMenuX+76,contentMenuY+122)
draw_set_color(make_color_rgb(128,240,32))
draw_line(contentMenuX+76,contentMenuY+16,contentMenuX+321,contentMenuY+16)
draw_line(contentMenuX+76,contentMenuY+69,contentMenuX+321,contentMenuY+69)
draw_line(contentMenuX+76,contentMenuY+122,contentMenuX+321,contentMenuY+122)
for(i=0;i<26;i+=1) //Display dotted lines
{
  draw_point(contentMenuX+252,contentMenuY+17+(i*2))
  draw_point(contentMenuX+252,contentMenuY+70+(i*2))
  draw_point(contentMenuX+252,contentMenuY+123+(i*2))
}
//Display stun icon
draw_sprite(sPauseM_AtkTypes,6,contentMenuX+291,contentMenuY+51)
draw_sprite(sPauseM_AtkTypes,6,contentMenuX+291,contentMenuY+104)
draw_sprite(sPauseM_AtkTypes,6,contentMenuX+291,contentMenuY+157)
//----- Find ability info -----
//0:Level, 1:Exp, 2:Next, 3:Power, 4:Name, 5:Description, 6: Stun, 7:Full Damage

var tShowStats; tShowStats=0
if mAS_Character="JERRY" //---------------------------------------- JERRY ----------------------------------------
{
  var tEqpAdj,tDmgMod;
  tEqpAdj=0
  for(i=0;i<3;i+=1)
  {
    if global.equipJerry[i]=1 {tEqpAdj+=0.05}
    else if global.equipJerry[i]=2 {tEqpAdj+=0.1}
    else if global.equipJerry[i]=3 {tEqpAdj+=0.15}
    else if global.equipJerry[i]=18 {tEqpAdj-=0.1}
  }
  tDmgMod=1+(global.skillTree[20]*0.02+tEqpAdj)

  if mAS_Ability="LINK" //-------------------- LINK --------------------
  {
    if global.hasAbilToken[1]>=1
      tShowStats=1
    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stLink_Sword[i]
    }
    mAS_AbilA[3]=100+round(global.stLink_Sword[0]*2.5)+(global.skillTree[8]*6)
    mAS_AbilA[7]=round(mAS_AbilA[3]*tDmgMod)
    mAS_AbilA[4]="Master Sword"
    mAS_AbilA[5]="The close range melee attack. Can't go wrong with this."
    mAS_AbilA[6]=8+global.skillTree[0]
    mAS_AbilType[0]="Normal"
    mAS_AbilIcon[0]=0
    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stLink_Arrow[i]
    }
    mAS_AbilB[3]=50+round(global.stLink_Arrow[0]*1.5)+global.skillTree[9]
    mAS_AbilB[7]=round(mAS_AbilB[3]*tDmgMod)
    mAS_AbilB[4]="Bow & Arrow"
    mAS_AbilB[5]="A powerful arrow attack that arcs."
    mAS_AbilB[6]=5
    mAS_AbilType[1]="Pierce"
    mAS_AbilIcon[1]=1

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stLink_Bomb[i]
    }
    mAS_AbilC[3]=220+(global.stLink_Bomb[0]*4)+(global.skillTree[9]*2)
    mAS_AbilC[7]=round(mAS_AbilC[3]*tDmgMod)
    mAS_AbilC[4]="Fuse Bomb"
    mAS_AbilC[5]="Thrown forward and explodes after 3 seconds, or when user detonated."
    mAS_AbilC[6]=22+round(global.stLink_Bomb[0]/2)
    mAS_AbilType[2]="Explosion"
    mAS_AbilIcon[2]=4
  }
  else if mAS_Ability="MEGA MAN" //-------------------- MEGA MAN --------------------
  {
    if global.hasAbilToken[3]>=1
      tShowStats=1
    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stMega_Buster[i]
    }
    mAS_AbilA[3]=30+global.stMega_Buster[0]+global.skillTree[10]
    mAS_AbilA[7]=round(mAS_AbilA[3]*tDmgMod)
    mAS_AbilA[4]="X Buster"
    mAS_AbilA[5]="The X Buster... It kicks ass!"
    mAS_AbilA[6]=1
    mAS_AbilType[0]="Shot"
    mAS_AbilIcon[0]=3

    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stMega_ShotIce[i]
    }
    mAS_AbilB[3]=50+round(global.stMega_ShotIce[0]*1.5)+global.skillTree[10]
    mAS_AbilB[7]=round(mAS_AbilB[3]*tDmgMod)
    mAS_AbilB[4]="Shotgun Ice"
    mAS_AbilB[5]="Shoots straight and splits on a surface."
    mAS_AbilB[6]=3
    mAS_AbilType[1]="Elemental"
    mAS_AbilIcon[1]=2

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stMega_Gravity[i]
    }
    mAS_AbilC[3]=45+round(global.stMega_Gravity[0]*1.5)+global.skillTree[10]
    mAS_AbilC[7]=round(mAS_AbilC[3]*tDmgMod)
    mAS_AbilC[4]="Gravity Well"
    mAS_AbilC[5]="Slow moving but powerful."
    mAS_AbilC[6]=5
    mAS_AbilType[2]="Special"
    mAS_AbilIcon[2]=5
  }
  else if mAS_Ability="GAME" //-------------------- GAME (Jerry) --------------------
  {
    if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
      tShowStats=1
    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stJGame_A[i]
    }
    mAS_AbilA[3]=15+round(global.stJGame_A[0]*0.5)
    mAS_AbilA[4]="Spam Gun"
    mAS_AbilA[5]="A spread cannon capable of shredding enemies at close range."
    mAS_AbilA[6]=1
    mAS_AbilType[0]="Shot"
    mAS_AbilIcon[0]=3

    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stJGame_B[i]
    }
    mAS_AbilB[3]=20+global.stJGame_B[0]
    mAS_AbilB[4]="Scatterbomb"
    mAS_AbilB[5]="Throw down a pod that launches a buttload of missiles."
    mAS_AbilB[6]=1
    mAS_AbilType[1]="Explosion"
    mAS_AbilIcon[1]=4

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stJGame_C[i]
    }
    mAS_AbilC[3]=20+global.stJGame_C[0]
    mAS_AbilC[4]="Bird Swarm"
    mAS_AbilC[5]="Call a swarm of birds that decimate enemies in the sky."
    mAS_AbilC[6]=1
    mAS_AbilType[2]="Special"
    mAS_AbilIcon[2]=5
  }
  draw_sprite(sJerryIdle,0,contentMenuX+30,contentMenuY+120)
}
else if mAS_Character="CLAIRE" //---------------------------------------- CLAIRE ----------------------------------------
{
  var tEqpAdj,tDmgMod;
  tEqpAdj=0
  for(i=0;i<3;i+=1)
  {
    if global.equipClaire[i]=1 {tEqpAdj+=0.05}
    else if global.equipClaire[i]=2 {tEqpAdj+=0.1}
    else if global.equipClaire[i]=3 {tEqpAdj+=0.15}
    else if global.equipClaire[i]=18 {tEqpAdj-=0.1}
  }
  tDmgMod=1+(global.skillTree[21]*0.02+tEqpAdj)

  if mAS_Ability="BELMONT" //-------------------- BELMONT --------------------
  {
    if global.hasAbilToken[2]>=1
      tShowStats=1

    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stBelmont_HairWhip[i]
    }
    mAS_AbilA[3]=105+round(global.stBelmont_HairWhip[0]*3)+(global.skillTree[11]*4)
    mAS_AbilA[7]=round(mAS_AbilA[3]*tDmgMod)
    mAS_AbilA[4]="Hair Whip"
    mAS_AbilA[5]="A holy whip of the hair with some cool on top."
    mAS_AbilA[6]=12+global.skillTree[26]
    mAS_AbilType[0]="Normal"
    mAS_AbilIcon[0]=0
    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stBelmont_Dagger[i]
    }
    mAS_AbilB[3]=65+(global.stBelmont_Dagger[0]*2)+global.skillTree[12]
    mAS_AbilB[7]=round(mAS_AbilB[3]*tDmgMod)
    mAS_AbilB[4]="Dagger"
    mAS_AbilB[5]="Thrown straight. Did I mention it's very fast?"
    mAS_AbilB[6]=7
    mAS_AbilType[1]="Pierce"
    mAS_AbilIcon[1]=1

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stBelmont_Holywater[i]
    }
    mAS_AbilC[3]=90+(global.stBelmont_Holywater[0]*2)+global.skillTree[12]
    mAS_AbilC[7]=round(mAS_AbilC[3]*tDmgMod)
    mAS_AbilC[4]="Holy Water"
    mAS_AbilC[5]="Thrown at the ground, then explodes into a flame that stuns longer."
    mAS_AbilC[6]=10
    mAS_AbilType[2]="Elemental"
    mAS_AbilIcon[2]=2
  }
  else if mAS_Ability="SAMUS" //-------------------- SAMUS --------------------
  {
    if global.hasAbilToken[4]>=1
      tShowStats=1
    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stSamus_Cannon[i]
    }
    mAS_AbilA[3]=30+global.stSamus_Cannon[0]+global.skillTree[13]
    mAS_AbilA[7]=round(mAS_AbilA[3]*tDmgMod)
    mAS_AbilA[4]="Arm Cannon"
    mAS_AbilA[5]="A normal arm cannon. Shoots straight, up, or down."
    mAS_AbilA[6]=3
    mAS_AbilType[0]="Shot"
    mAS_AbilIcon[0]=3

    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stSamus_Missile[i]
    }
    mAS_AbilB[3]=75+global.stSamus_Missile[0]+global.skillTree[13]
    mAS_AbilB[7]=round(mAS_AbilB[3]*tDmgMod)
    mAS_AbilB[4]="Missile"
    mAS_AbilB[5]="A powerful concussive blast with high stun potential."
    mAS_AbilB[6]=12
    mAS_AbilType[1]="Special"
    mAS_AbilIcon[1]=5

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stSamus_Bomb[i]
    }
    mAS_AbilC[3]=75+round(global.stSamus_Bomb[0]*2)+global.skillTree[13]
    mAS_AbilC[7]=round(mAS_AbilC[3]*tDmgMod)
    mAS_AbilC[4]="Bomb"
    mAS_AbilC[5]="A powerful explosive."
    mAS_AbilC[6]=13+round(global.stSamus_Bomb[0]/2)
    mAS_AbilType[2]="Explosion"
    mAS_AbilIcon[2]=4
  }
  else if mAS_Ability="GAME" //-------------------- GAME (Claire) --------------------
  {
    if global.hasAbilToken[5]>=1 or global.hasAbilToken[6]>=1
      tShowStats=1
    for(i=0;i<3;i+=1)
    {
      mAS_AbilA[i]=global.stCGame_A[i]
    }
    mAS_AbilA[3]=110+(global.stCGame_A[0]*3)
    mAS_AbilA[4]="Blade Strike"
    mAS_AbilA[5]="Strike with a powerful blade of gaming power."
    mAS_AbilA[6]=8
    mAS_AbilType[0]="Normal"
    mAS_AbilIcon[0]=0

    for(i=0;i<3;i+=1)
    {
      mAS_AbilB[i]=global.stCGame_B[i]
    }
    mAS_AbilB[3]=25+global.stCGame_B[0]
    mAS_AbilB[4]="Chainblade Storm"
    mAS_AbilB[5]="Summon a storm of chainsaw swords."
    mAS_AbilB[6]=3
    mAS_AbilType[1]="Pierce"
    mAS_AbilIcon[1]=1

    for(i=0;i<3;i+=1)
    {
      mAS_AbilC[i]=global.stCGame_C[i]
    }
    mAS_AbilC[3]=30+global.stCGame_C[0]
    mAS_AbilC[4]="Flame Shield"
    mAS_AbilC[5]="Creates fireballs around Claire which block projectiles."
    mAS_AbilC[6]=4
    mAS_AbilType[2]="Elemental"
    mAS_AbilIcon[2]=2
  }
  draw_sprite(sClaireIdle,0,contentMenuX+30,contentMenuY+120)
}
//Display current character and ability
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_center)
textDropShadow(mAS_Character,contentMenuX+29,contentMenuY+16,textColorMain,textColorShadow,1)
//Display ability info
if tShowStats=1
{
  textDropShadow(mAS_Ability,contentMenuX+29,contentMenuY+42,textColorMain,textColorShadow,1)

  draw_set_halign(fa_left)
  //--------------- Ability 1 ---------------
  textDropShadow(mAS_AbilA[4],contentMenuX+76,contentMenuY+16,textColorMain,textColorShadow,1)
  if mAS_AbilA[0]<10 {textDropShadow("Lv " +string(mAS_AbilA[0]),contentMenuX+192,contentMenuY+16,textColorMain,textColorShadow,1)}
  else
  {
    textDropShadow("Lv",contentMenuX+192,contentMenuY+16,textColorMain,textColorShadow,1)
    draw_sprite(sPauseM_AbilStar,0,contentMenuX+211,contentMenuY+23)
  }
  textDropShadow("Power      " +string(mAS_AbilA[3]) +string(" (") +string(mAS_AbilA[7]) +string(")"),contentMenuX+76,contentMenuY+26,textColorMain,textColorShadow,1)
  draw_sprite(sPauseM_AtkTypes,mAS_AbilIcon[0],contentMenuX+174,contentMenuY+19)
  textDropShadow(mAS_AbilType[0],contentMenuX+192,contentMenuY+26,textColorMain,textColorShadow,1)
  draw_set_halign(fa_left)
  textDropShadow("-Accuracy-",contentMenuX+255,contentMenuY+17,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if mAS_AbilA[2]>0 {tWepAcc=round((mAS_AbilA[1]/mAS_AbilA[2])*100)}
  textDropShadow(string(tWepAcc) +string("%"),contentMenuX+255,contentMenuY+37,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  textDropShadow(string(mAS_AbilA[1]) +string(" /"),contentMenuX+314,contentMenuY+27,textColorMain,textColorShadow,1)
  textDropShadow(mAS_AbilA[2],contentMenuX+321,contentMenuY+37,textColorMain,textColorShadow,1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  textDropShadowExt(mAS_AbilA[5],contentMenuX+76,contentMenuY+37,textColorMain,textColorShadow,1,10,174)
  draw_set_font(fnt_PauseMenuText)
  textDropShadow(mAS_AbilA[6],contentMenuX+310,contentMenuY+52,textColorMain,textColorShadow,1)

  //--------------- Ability 2 ---------------
  textDropShadow(mAS_AbilB[4],contentMenuX+76,contentMenuY+69,textColorMain,textColorShadow,1)
  if mAS_AbilB[0]<10 {textDropShadow("Lv " +string(mAS_AbilB[0]),contentMenuX+192,contentMenuY+69,textColorMain,textColorShadow,1)}
  else
  {
    textDropShadow("Lv",contentMenuX+192,contentMenuY+69,textColorMain,textColorShadow,1)
    draw_sprite(sPauseM_AbilStar,0,contentMenuX+211,contentMenuY+76)
  }
  textDropShadow("Power      " +string(mAS_AbilB[3]) +string(" (") +string(mAS_AbilB[7]) +string(")"),contentMenuX+76,contentMenuY+79,textColorMain,textColorShadow,1)
  draw_sprite(sPauseM_AtkTypes,mAS_AbilIcon[1],contentMenuX+174,contentMenuY+72)
  textDropShadow(mAS_AbilType[1],contentMenuX+192,contentMenuY+79,textColorMain,textColorShadow,1)
  draw_set_halign(fa_left)
  textDropShadow("-Accuracy-",contentMenuX+255,contentMenuY+70,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if mAS_AbilB[2]>0 {tWepAcc=round((mAS_AbilB[1]/mAS_AbilB[2])*100)}
  textDropShadow(string(tWepAcc) +string("%"),contentMenuX+255,contentMenuY+90,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  textDropShadow(string(mAS_AbilB[1]) +string(" /"),contentMenuX+314,contentMenuY+80,textColorMain,textColorShadow,1)
  textDropShadow(mAS_AbilB[2],contentMenuX+321,contentMenuY+90,textColorMain,textColorShadow,1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  textDropShadowExt(mAS_AbilB[5],contentMenuX+76,contentMenuY+90,textColorMain,textColorShadow,1,10,174)
  draw_set_font(fnt_PauseMenuText)
  textDropShadow(mAS_AbilB[6],contentMenuX+310,contentMenuY+105,textColorMain,textColorShadow,1)

  //--------------- Ability 3 ---------------
  textDropShadow(mAS_AbilC[4],contentMenuX+76,contentMenuY+122,textColorMain,textColorShadow,1)
  if mAS_AbilC[0]<10 {textDropShadow("Lv " +string(mAS_AbilC[0]),contentMenuX+192,contentMenuY+122,textColorMain,textColorShadow,1)}
  else
  {
    textDropShadow("Lv",contentMenuX+192,contentMenuY+122,textColorMain,textColorShadow,1)
    draw_sprite(sPauseM_AbilStar,0,contentMenuX+211,contentMenuY+129)
  }
  textDropShadow("Power      " +string(mAS_AbilC[3]) +string(" (") +string(mAS_AbilC[7]) +string(")"),contentMenuX+76,contentMenuY+132,textColorMain,textColorShadow,1)
  draw_sprite(sPauseM_AtkTypes,mAS_AbilIcon[2],contentMenuX+174,contentMenuY+125)
  textDropShadow(mAS_AbilType[2],contentMenuX+192,contentMenuY+132,textColorMain,textColorShadow,1)
  draw_set_halign(fa_left)
  textDropShadow("-Accuracy-",contentMenuX+255,contentMenuY+123,textColorMain,textColorShadow,1)
  var tWepAcc;
  tWepAcc=0
  if mAS_AbilC[2]>0 {tWepAcc=round((mAS_AbilC[1]/mAS_AbilC[2])*100)}
  textDropShadow(string(tWepAcc) +string("%"),contentMenuX+255,contentMenuY+143,textColorMain,textColorShadow,1)
  draw_set_halign(fa_right)
  textDropShadow(string(mAS_AbilC[1]) +string(" /"),contentMenuX+314,contentMenuY+133,textColorMain,textColorShadow,1)
  textDropShadow(mAS_AbilC[2],contentMenuX+321,contentMenuY+143,textColorMain,textColorShadow,1)
  draw_set_font(fnt_PauseMenuText)
  draw_set_halign(fa_left)
  textDropShadowExt(mAS_AbilC[5],contentMenuX+76,contentMenuY+143,textColorMain,textColorShadow,1,10,174)
  draw_set_font(fnt_PauseMenuText)
  textDropShadow(mAS_AbilC[6],contentMenuX+310,contentMenuY+158,textColorMain,textColorShadow,1)
}
else
  textDropShadow("?????",contentMenuX+29,contentMenuY+42,textColorMain,textColorShadow,1)
