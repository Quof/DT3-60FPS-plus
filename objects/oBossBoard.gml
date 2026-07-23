#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
io_clear()
resetKeyCodes()
playSound(global.snd_MenuOpen,0,1,1)
currentPage=1
textColorA=make_color_rgb(0,64,61)
textColorBronze=make_color_rgb(190,118,71)
textColorSilver=make_color_rgb(78,111,117)
textColorGold=make_color_rgb(220,168,63)
textColorShadow=make_color_rgb(12,12,12)

totalBossTime=0
bShowTotalTime=1
for(i=0;i<65;i+=1) //Check total time
{
  if global.bossGalleryTime[i]<99999 {totalBossTime+=global.bossGalleryTime[i]}
  else {bShowTotalTime=0}
}

//------------------------------ PAGE 1 ------------------------------
awardTimes[0,0]=65
awardTimes[0,1]=45
awardTimes[0,2]=24
awardTimes[1,0]=140
awardTimes[1,1]=125
awardTimes[1,2]=116
awardTimes[2,0]=190
awardTimes[2,1]=160
awardTimes[2,2]=56
awardTimes[3,0]=55
awardTimes[3,1]=30
awardTimes[3,2]=17
awardTimes[4,0]=65
awardTimes[4,1]=35
awardTimes[4,2]=22
awardTimes[5,0]=40
awardTimes[5,1]=20
awardTimes[5,2]=9
awardTimes[6,0]=40
awardTimes[6,1]=20
awardTimes[6,2]=8
awardTimes[7,0]=90
awardTimes[7,1]=65
awardTimes[7,2]=34
awardTimes[8,0]=165
awardTimes[8,1]=130
awardTimes[8,2]=95
awardTimes[9,0]=70
awardTimes[9,1]=40
awardTimes[9,2]=25
awardTimes[10,0]=65
awardTimes[10,1]=40
awardTimes[10,2]=18
awardTimes[11,0]=60
awardTimes[11,1]=40
awardTimes[11,2]=20
awardTimes[12,0]=90
awardTimes[12,1]=60
awardTimes[12,2]=35
awardTimes[13,0]=85
awardTimes[13,1]=65
awardTimes[13,2]=45
awardTimes[14,0]=40
awardTimes[14,1]=20
awardTimes[14,2]=8
//------------------------------ PAGE 2 ------------------------------
awardTimes[15,0]=85
awardTimes[15,1]=55
awardTimes[15,2]=38
awardTimes[16,0]=105
awardTimes[16,1]=85
awardTimes[16,2]=40
awardTimes[17,0]=55
awardTimes[17,1]=36
awardTimes[17,2]=19
awardTimes[18,0]=60
awardTimes[18,1]=40
awardTimes[18,2]=21
awardTimes[19,0]=70
awardTimes[19,1]=45
awardTimes[19,2]=13
awardTimes[20,0]=65
awardTimes[20,1]=45
awardTimes[20,2]=25
awardTimes[21,0]=75
awardTimes[21,1]=50
awardTimes[21,2]=29
awardTimes[22,0]=60
awardTimes[22,1]=30
awardTimes[22,2]=18
awardTimes[23,0]=75
awardTimes[23,1]=50
awardTimes[23,2]=31
awardTimes[24,0]=95
awardTimes[24,1]=65
awardTimes[24,2]=36
awardTimes[25,0]=85
awardTimes[25,1]=50
awardTimes[25,2]=23
awardTimes[26,0]=180
awardTimes[26,1]=140
awardTimes[26,2]=100
awardTimes[27,0]=140
awardTimes[27,1]=125
awardTimes[27,2]=107
awardTimes[28,0]=100
awardTimes[28,1]=65
awardTimes[28,2]=21
awardTimes[29,0]=110
awardTimes[29,1]=80
awardTimes[29,2]=51
//------------------------------ PAGE 3 ------------------------------
awardTimes[30,0]=90
awardTimes[30,1]=60
awardTimes[30,2]=21
awardTimes[31,0]=50
awardTimes[31,1]=25
awardTimes[31,2]=12
awardTimes[32,0]=90
awardTimes[32,1]=45
awardTimes[32,2]=9
awardTimes[33,0]=45
awardTimes[33,1]=25
awardTimes[33,2]=9
awardTimes[34,0]=55
awardTimes[34,1]=30
awardTimes[34,2]=12
awardTimes[35,0]=80
awardTimes[35,1]=50
awardTimes[35,2]=24
awardTimes[36,0]=80
awardTimes[36,1]=45
awardTimes[36,2]=7
awardTimes[37,0]=75
awardTimes[37,1]=45
awardTimes[37,2]=21
awardTimes[38,0]=65
awardTimes[38,1]=40
awardTimes[38,2]=16
awardTimes[39,0]=125
awardTimes[39,1]=90
awardTimes[39,2]=61
awardTimes[40,0]=130
awardTimes[40,1]=120
awardTimes[40,2]=110
awardTimes[41,0]=50
awardTimes[41,1]=25
awardTimes[41,2]=10
awardTimes[42,0]=45
awardTimes[42,1]=20
awardTimes[42,2]=8
awardTimes[43,0]=50
awardTimes[43,1]=30
awardTimes[43,2]=13
awardTimes[44,0]=85
awardTimes[44,1]=45
awardTimes[44,2]=23
//------------------------------ PAGE 4 ------------------------------
awardTimes[45,0]=85
awardTimes[45,1]=45
awardTimes[45,2]=19
awardTimes[46,0]=90
awardTimes[46,1]=45
awardTimes[46,2]=16
awardTimes[47,0]=125
awardTimes[47,1]=70
awardTimes[47,2]=40
awardTimes[48,0]=120
awardTimes[48,1]=65
awardTimes[48,2]=45
awardTimes[49,0]=130
awardTimes[49,1]=90
awardTimes[49,2]=63
awardTimes[50,0]=160
awardTimes[50,1]=120
awardTimes[50,2]=70
awardTimes[51,0]=180
awardTimes[51,1]=140
awardTimes[51,2]=100
awardTimes[52,0]=100
awardTimes[52,1]=70
awardTimes[52,2]=40
awardTimes[53,0]=100
awardTimes[53,1]=70
awardTimes[53,2]=47
awardTimes[54,0]=280
awardTimes[54,1]=220
awardTimes[54,2]=185
awardTimes[55,0]=150
awardTimes[55,1]=120
awardTimes[55,2]=82
awardTimes[56,0]=165
awardTimes[56,1]=130
awardTimes[56,2]=85
awardTimes[57,0]=350
awardTimes[57,1]=270
awardTimes[57,2]=220
awardTimes[58,0]=400
awardTimes[58,1]=340
awardTimes[58,2]=275
awardTimes[59,0]=240
awardTimes[59,1]=180
awardTimes[59,2]=120
//------------------------------ PAGE 5 ------------------------------
awardTimes[60,0]=180
awardTimes[60,1]=120
awardTimes[60,2]=76
awardTimes[61,0]=310
awardTimes[61,1]=250
awardTimes[61,2]=190
awardTimes[62,0]=340
awardTimes[62,1]=280
awardTimes[62,2]=214
awardTimes[63,0]=540
awardTimes[63,1]=420
awardTimes[63,2]=343
awardTimes[64,0]=310
awardTimes[64,1]=260
awardTimes[64,2]=210

var tCheckForAllGold;
tCheckForAllGold=0
for(i=0;i<65;i+=1)
{
  if global.bossGalleryTime[i]<=awardTimes[i,0] //Achievement - [Got an Onion]
  {
    var tCheckAchieve;
    tCheckAchieve=string_char_at(global.tokenRecognitions,47)
    if tCheckAchieve="0"
    {
      var tAchievement;
      tAchievement=instance_create(0,0,oAchievementNotice)
      tAchievement.myAchievement="Got an Onion"; tAchievement.checkNum=47
    }
  }

  if global.bossGalleryTime[i]<=awardTimes[i,2] //Achievement - [Stay Gold Ponyboy]
  {
    tCheckForAllGold+=1
  }
}

if tCheckForAllGold>=65
{
  var tCheckAchieve;
  tCheckAchieve=string_char_at(global.tokenRecognitionsSetTwo,13)
  if tCheckAchieve="0"
  {
    var tAchievement;
    tAchievement=instance_create(0,0,oAchievementNoticeSS)
    tAchievement.myAchievement="Stay Gold Ponyboy"; tAchievement.checkNum=13
  }
}
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if oKeyCodes.kCodePressed[1]=1 or oKeyCodes.kCodePressed[3]=1 //Left/Up
{
  playSound(global.snd_MenuCursor,0,1,1)
  if currentPage=1 {currentPage=5}
  else {currentPage-=1}
}
else if oKeyCodes.kCodePressed[2]=1 or oKeyCodes.kCodePressed[4]=1 //Right/Down
{
  playSound(global.snd_MenuCursor,0,1,1)
  if currentPage=5 {currentPage=1}
  else {currentPage+=1}
}
else if oKeyCodes.kCodePressed[6]=1 //Close board
{
  io_clear()
  resetKeyCodes()
  playSound(global.snd_MenuClose,0,1,1)
  global.gamePaused=0
  instance_destroy()
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
boardX=view_xview[0]+37
boardY=view_yview[0]+20
draw_sprite_ext(sprite_index,image_index,boardX,boardY,image_xscale,image_yscale,image_angle,image_blend,image_alpha)
draw_set_font(fnt_NES)
draw_set_alpha(1)
draw_set_halign(fa_left)
draw_set_color(textColorA)
if bShowTotalTime=1 {draw_text(boardX+215,boardY+291,totalBossTime)}
else {draw_text(boardX+215,boardY+291,"-----")}
draw_text(boardX+351,boardY+291,currentPage)
bossName=""

if currentPage=1
{
  for(i=0;i<15;i+=1)
  {
    if global.bossGalleryTime[i]<99999
    {
      if i=0 {bossName="Bowser"}
      else if i=1 {bossName="Cackletta"}
      else if i=2 {bossName="Kamek"}
      else if i=3 {bossName="Helmethead"}
      else if i=4 {bossName="Dead Hand"}
      else if i=5 {bossName="Barba"}
      else if i=6 {bossName="Thunderbird"}
      else if i=7 {bossName="Aqua Serpent"}
      else if i=8 {bossName="Final Nightmare"}
      else if i=9 {bossName="Control Virus"}
      else if i=10 {bossName="Large Vampire Bat"}
      else if i=11 {bossName="Dracula"}
      else if i=12 {bossName="Menace"}
      else if i=13 {bossName="Death"}
      else if i=14 {bossName="Death (Legion)"}
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),bossName)
      draw_text(boardX+217,boardY+33+(17*i),global.bossGalleryTime[i])
      for(ii=0;ii<3;ii+=1) //Display par times
      {
        if ii=0 {draw_set_color(textColorBronze)}
        else if ii=1 {draw_set_color(textColorSilver)}
        else if ii=2 {draw_set_color(textColorGold)}
        draw_text(boardX+282+(37*ii),boardY+33+(17*i),awardTimes[i,ii])
        if global.bossGalleryTime[i]<=awardTimes[i,ii] {draw_sprite_ext(sBossGalleryMedals,ii,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)}
      }
    }
    else
    {
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),"----------")
      draw_text(boardX+217,boardY+33+(17*i),"-----")
    }
  }
}
else if currentPage=2
{
  for(i=0;i<15;i+=1)
  {
    if global.bossGalleryTime[i+15]<99999
    {
      if i=0 {bossName="Blackmore"}
      else if i=1 {bossName="Enmity"}
      else if i=2 {bossName="Maoh the Gaint"}
      else if i=3 {bossName="Storm Eagle"}
      else if i=4 {bossName="Overdrive Ostrich"}
      else if i=5 {bossName="Gravity Beetle"}
      else if i=6 {bossName="Bospider"}
      else if i=7 {bossName="Bit & Byte"}
      else if i=8 {bossName="Sigma"}
      else if i=9 {bossName="Sigma Epsilon"}
      else if i=10 {bossName="Elpizo"}
      else if i=11 {bossName="Army Eye"}
      else if i=12 {bossName="Hex (Vault)"}
      else if i=13 {bossName="Shadow Form"}
      else if i=14 {bossName="Vault Demon"}
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),bossName)
      draw_text(boardX+217,boardY+33+(17*i),global.bossGalleryTime[i+15])
      for(ii=0;ii<3;ii+=1) //Display par times
      {
        if ii=0 {draw_set_color(textColorBronze)}
        else if ii=1 {draw_set_color(textColorSilver)}
        else if ii=2 {draw_set_color(textColorGold)}
        draw_text(boardX+282+(37*ii),boardY+33+(17*i),awardTimes[i+15,ii])
        if global.bossGalleryTime[i+15]<=awardTimes[i+15,ii] {draw_sprite_ext(sBossGalleryMedals,ii,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)}
      }
    }
    else
    {
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),"----------")
      draw_text(boardX+217,boardY+33+(17*i),"-----")
    }
  }
}
else if currentPage=3
{
  for(i=0;i<15;i+=1)
  {
    if global.bossGalleryTime[i+30]<99999
    {
      if i=0 {bossName="Arachnus"}
      else if i=1 {bossName="King Worm"}
      else if i=2 {bossName="Kraid"}
      else if i=3 {bossName="Mother Brain"}
      else if i=4 {bossName="Ridley"}
      else if i=5 {bossName="Ridley (Lava)"}
      else if i=6 {bossName="Ridley (Tunnel)"}
      else if i=7 {bossName="Nightmare"}
      else if i=8
      {
        if global.modeWahfuu=1 {bossName="Wahfuu Jr."}
        else {bossName="Sand Crawler"}
      }
      else if i=9 {bossName="Malevolence"}
      else if i=10 {bossName="Leviathan"}
      else if i=11 {bossName="The Stone Golem"}
      else if i=12 {bossName="The Flame Elemental"}
      else if i=13 {bossName="High Heels Girl"}
      else if i=14 {bossName="The Unforgotten"}
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),bossName)
      draw_text(boardX+217,boardY+33+(17*i),global.bossGalleryTime[i+30])
      for(ii=0;ii<3;ii+=1) //Display par times
      {
        if ii=0 {draw_set_color(textColorBronze)}
        else if ii=1 {draw_set_color(textColorSilver)}
        else if ii=2 {draw_set_color(textColorGold)}
        draw_text(boardX+282+(37*ii),boardY+33+(17*i),awardTimes[i+30,ii])
        if global.bossGalleryTime[i+30]<=awardTimes[i+30,ii] {draw_sprite_ext(sBossGalleryMedals,ii,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)}
      }
    }
    else
    {
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),"----------")
      draw_text(boardX+217,boardY+33+(17*i),"-----")
    }
  }
}
else if currentPage=4
{
  for(i=0;i<15;i+=1)
  {
    if global.bossGalleryTime[i+45]<99999
    {
      if i=0 {bossName="The Chosen One"}
      else if i=1 {bossName="Sephiroth"}
      else if i=2 {bossName="Antipathy"}
      else if i=3 {bossName="Sera"}
      else if i=4 {bossName="Brain Machine"}
      else if i=5 {bossName="Blade Bot"}
      else if i=6 {bossName="Combat Apparatus"}
      else if i=7 {bossName="Giant Blargg"}
      else if i=8 {bossName="Defective"}
      else if i=9 {bossName="Shadow Eura"}
      else if i=10 {bossName="Decimator 10000"}
      else if i=11 {bossName="Decimator 20000"}
      else if i=12
      {
        if global.modeWahfuu=1 {bossName="Wahfuu"}
        else {bossName="Abomination"}
      }
      else if i=13 {bossName="Hex (Warship)"}
      else if i=14 {bossName="CHAOS Warmaster"}
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),bossName)
      draw_text(boardX+217,boardY+33+(17*i),global.bossGalleryTime[i+45])
      for(ii=0;ii<3;ii+=1) //Display par times
      {
        if ii=0 {draw_set_color(textColorBronze)}
        else if ii=1 {draw_set_color(textColorSilver)}
        else if ii=2 {draw_set_color(textColorGold)}
        draw_text(boardX+282+(37*ii),boardY+33+(17*i),awardTimes[i+45,ii])
        if global.bossGalleryTime[i+45]<=awardTimes[i+45,ii] {draw_sprite_ext(sBossGalleryMedals,ii,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)}
      }
    }
    else
    {
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),"----------")
      draw_text(boardX+217,boardY+33+(17*i),"-----")
    }
  }
}
else if currentPage=5
{
  for(i=0;i<5;i+=1)
  {
    if global.bossGalleryTime[i+60]<99999
    {
      if i=0 {bossName="Parasitic Seed"}
      else if i=1 {bossName="Virus Parasite"}
      else if i=2 {bossName="Hexor"}
      else if i=3 {bossName="The Executive"}
      else if i=4 {bossName="CHAOS Warmaster EX"}
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),bossName)
      draw_text(boardX+217,boardY+33+(17*i),global.bossGalleryTime[i+60])
      for(ii=0;ii<3;ii+=1) //Display par times
      {
        if ii=0 {draw_set_color(textColorBronze)}
        else if ii=1 {draw_set_color(textColorSilver)}
        else if ii=2 {draw_set_color(textColorGold)}
        draw_text(boardX+282+(37*ii),boardY+33+(17*i),awardTimes[i+60,ii])
        if global.bossGalleryTime[i+60]<=awardTimes[i+60,ii] {draw_sprite_ext(sBossGalleryMedals,ii,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)}
      }
    }
    else
    {
      draw_set_color(textColorA)
      draw_text(boardX+21,boardY+33+(17*i),"----------")
      draw_text(boardX+217,boardY+33+(17*i),"-----")
    }
  }
}
