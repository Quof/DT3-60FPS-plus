if bNormBoard=1 {event_user(0); exit} //normalized gallery change (added): the gallery lever's board
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
      else if i=2 {bossName="Kamek's Wand"}
      else if i=3 {bossName="Helmethead"}
      else if i=4 {bossName="Dead Hand"}
      else if i=5 {bossName="Barba"}
      else if i=6 {bossName="Thunderbird"}
      else if i=7 {bossName="Aqua(?) Serpent"}
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
      //else if i=2 {bossName="Maoh the Gaint"}
      else if i=2 {bossName="Maoh the Giant"} //typo fix
      else if i=3 {bossName="Storm Eagle"}
      else if i=4 {bossName="Overdrive Ostrich"}
      else if i=5 {bossName="Gravity Beetle"}
      else if i=6 {bossName="Arachnus"}       //spsp
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
      if i=0 {bossName="MetalSonic"}      //spsp
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
      else if i=3 {bossName="Mystery Superboss 1"}
      else if i=4 {bossName="Mystery Superboss 2 who refuses to have your times tracked"}
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
//platinum medal change (added): the platinum medal over the gold one where its par time was beaten (awardTimes[i,3], the
//boss gallery doors' platinum times), on whichever page is shown
var tFirst,tCount;
tFirst=(currentPage-1)*15
tCount=15
if currentPage=5 {tCount=5}
for(i=0;i<tCount;i+=1)
{
  if global.bossGalleryTime[tFirst+i]<99999 and awardTimes[tFirst+i,3]>=0 and global.bossGalleryTime[tFirst+i]<=awardTimes[tFirst+i,3]
  {
    scrPlatGlow(boardX+249,boardY+36+(17*i),0.5,tFirst+i,0) //platinum glow change (added): the radiant shine
    draw_sprite_ext(sBossGalleryMedals,3,boardX+249,boardY+36+(17*i),0.5,0.5,0,c_white,1)
    scrPlatGlow(boardX+249,boardY+36+(17*i),0.5,tFirst+i,1) //platinum glow change (added)
  }
}
