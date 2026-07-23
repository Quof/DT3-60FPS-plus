/*
This script is called in the HUD pause menu and is an extension of it.
It is used to display the Spend AP submenu.
*/

var tAPmenuX,tAPmenuY;
tAPmenuX=contentMenuX
tAPmenuY=contentMenuY-8
//Display current AP and AP Level
draw_set_font(fnt_PauseMenuText)
draw_set_halign(fa_right)
draw_sprite(sPauseM_APBack,0,tAPmenuX+4,tAPmenuY+132)
textDropShadow(global.pAPLevel,tAPmenuX+64,tAPmenuY+131,textColorMain,textColorShadow,1)
textDropShadow(global.pAP,tAPmenuX+64,tAPmenuY+144,textColorMain,textColorShadow,1)
if global.pAPLevel<40
{
  draw_sprite_ext(sPauseM_ExpBar,0,tAPmenuX+12,tAPmenuY+162,(global.pAPExp/global.pAPNext)*40,1,0,c_white,1)
  draw_set_font(fnt_OtherStats)
  textDropShadow(global.pAPExp,tAPmenuX+60,tAPmenuY+166,textColorMain,textColorShadow,1)
  textDropShadow(global.pAPNext,tAPmenuX+94,tAPmenuY+166,textColorMain,textColorShadow,1)
}
else
{
  draw_sprite_ext(sPauseM_ExpBar,0,tAPmenuX+12,tAPmenuY+162,40,1,0,c_white,1)
  draw_set_font(fnt_OtherStats)
  textDropShadow("-----",tAPmenuX+60,tAPmenuY+166,textColorMain,textColorShadow,1)
  textDropShadow("-----",tAPmenuX+94,tAPmenuY+166,textColorMain,textColorShadow,1)
}
draw_set_font(fnt_PauseMenuText)
//Display skill tree
draw_sprite(sPauseM_SkillTree,0,tAPmenuX+37,tAPmenuY+30)
fullLevelColor=c_orange
//Display skill level
var tGridSpc; tGridSpc=16
if global.skillTree[0]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[0],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*9),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[0],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*9))

if global.skillTree[1]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[1],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*7),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[1],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*7))

if global.skillTree[2]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[2],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*9),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[2],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*9))

if global.skillTree[3]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[3],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*7),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[3],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*7))

if global.skillTree[4]>=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[4],tAPmenuX+5+(tGridSpc*7),tAPmenuY+15+(tGridSpc*8),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[4],tAPmenuX+5+(tGridSpc*7),tAPmenuY+15+(tGridSpc*8))

if global.skillTree[5]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[5],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*4),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[5],tAPmenuX+5+(tGridSpc*14),tAPmenuY+15+(tGridSpc*4))

if global.skillTree[6]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[6],tAPmenuX+5+(tGridSpc*13),tAPmenuY+15+(tGridSpc*3),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[6],tAPmenuX+5+(tGridSpc*13),tAPmenuY+15+(tGridSpc*3))

if global.skillTree[7]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[7],tAPmenuX+5+(tGridSpc*9),tAPmenuY+15+(tGridSpc*3),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[7],tAPmenuX+5+(tGridSpc*9),tAPmenuY+15+(tGridSpc*3))

if global.skillTree[8]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[8],tAPmenuX+5+(tGridSpc*17),tAPmenuY+15+(tGridSpc*5),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[8],tAPmenuX+5+(tGridSpc*17),tAPmenuY+15+(tGridSpc*5))

if global.skillTree[9]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[9],tAPmenuX+5+(tGridSpc*18),tAPmenuY+15+(tGridSpc*4),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[9],tAPmenuX+5+(tGridSpc*18),tAPmenuY+15+(tGridSpc*4))

if global.skillTree[10]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[10],tAPmenuX+5+(tGridSpc*17),tAPmenuY+15+(tGridSpc*3),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[10],tAPmenuX+5+(tGridSpc*17),tAPmenuY+15+(tGridSpc*3))

if global.skillTree[11]=2
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[11],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*5),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[11],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*5))

if global.skillTree[12]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[12],tAPmenuX+5+(tGridSpc*4),tAPmenuY+15+(tGridSpc*4),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[12],tAPmenuX+5+(tGridSpc*4),tAPmenuY+15+(tGridSpc*4))

if global.skillTree[13]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[13],tAPmenuX+5+(tGridSpc*4),tAPmenuY+15+(tGridSpc*6),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[13],tAPmenuX+5+(tGridSpc*4),tAPmenuY+15+(tGridSpc*6))

if global.skillTree[14]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[14],tAPmenuX+5+(tGridSpc*15),tAPmenuY+15+(tGridSpc*8),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[14],tAPmenuX+5+(tGridSpc*15),tAPmenuY+15+(tGridSpc*8))

if global.skillTree[15]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[15],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*4),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[15],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*4))

if global.skillTree[16]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[16],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*4),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[16],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*4))

if global.skillTree[17]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[17],tAPmenuX+5+(tGridSpc*18),tAPmenuY+15+(tGridSpc*2),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[17],tAPmenuX+5+(tGridSpc*18),tAPmenuY+15+(tGridSpc*2))

if global.skillTree[18]=5
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[18],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*3),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[18],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*3))

if global.skillTree[19]=5
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[19],tAPmenuX+5+(tGridSpc*10),tAPmenuY+15+(tGridSpc*2),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[19],tAPmenuX+5+(tGridSpc*10),tAPmenuY+15+(tGridSpc*2))

if global.skillTree[20]=5
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[20],tAPmenuX+5+(tGridSpc*16),tAPmenuY+15+(tGridSpc*7),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[20],tAPmenuX+5+(tGridSpc*16),tAPmenuY+15+(tGridSpc*7))

if global.skillTree[21]=5
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[21],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*7),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[21],tAPmenuX+5+(tGridSpc*6),tAPmenuY+15+(tGridSpc*7))

if global.skillTree[22]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[22],tAPmenuX+5+(tGridSpc*12),tAPmenuY+15+(tGridSpc*2),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[22],tAPmenuX+5+(tGridSpc*12),tAPmenuY+15+(tGridSpc*2))

if global.skillTree[23]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[23],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*2),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[23],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*2))

if global.skillTree[24]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[24],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*8),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[24],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*8))

if global.skillTree[25]=5
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[25],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*6),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[25],tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*6))

if global.skillTree[26]=4
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[26],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*9),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[26],tAPmenuX+5+(tGridSpc*8),tAPmenuY+15+(tGridSpc*9))

if global.skillTree[27]=1
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[27],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*7),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[27],tAPmenuX+5+(tGridSpc*3),tAPmenuY+15+(tGridSpc*7))

if global.skillTree[28]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[28],tAPmenuX+5+(tGridSpc*15),tAPmenuY+15+(tGridSpc*3),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[28],tAPmenuX+5+(tGridSpc*15),tAPmenuY+15+(tGridSpc*3))

if global.skillTree[29]=3
  draw_sprite_ext(sPauseM_SkillLv,global.skillTree[29],tAPmenuX+5+(tGridSpc*7),tAPmenuY+15+(tGridSpc*5),1,1,0,fullLevelColor,1)
else
  draw_sprite(sPauseM_SkillLv,global.skillTree[29],tAPmenuX+5+(tGridSpc*7),tAPmenuY+15+(tGridSpc*5))

if global.hasAbilToken[0]>0
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*11),tAPmenuY+15+(tGridSpc*10))
if global.hasAbilToken[1]>0 and global.skillTree[24]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*13),tAPmenuY+15+(tGridSpc*8))
if global.hasAbilToken[2]>0 and global.skillTree[24]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*9),tAPmenuY+15+(tGridSpc*8))
if global.hasAbilToken[3]>0 and global.skillTree[25]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*13),tAPmenuY+15+(tGridSpc*5))
if global.hasAbilToken[4]>0 and global.skillTree[25]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*9),tAPmenuY+15+(tGridSpc*5))
if (global.hasAbilToken[5]>0 or global.hasAbilToken[6]>0) and global.skillTree[7]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*5),tAPmenuY+15+(tGridSpc*5))
if (global.hasAbilToken[5]>0 or global.hasAbilToken[6]>0) and global.skillTree[5]>=1
  draw_sprite(sPauseM_SectionUnlock,0,tAPmenuX+5+(tGridSpc*16),tAPmenuY+15+(tGridSpc*4))

draw_set_alpha(0.5)
draw_set_font(fnt_EnemyChat)
draw_set_halign(fa_center)
textDropShadow("1",tAPmenuX+174,tAPmenuY+159,textColorMain,c_black,4)
textDropShadow("2",tAPmenuX+205,tAPmenuY+127,textColorMain,c_black,4)
textDropShadow("3",tAPmenuX+141,tAPmenuY+127,textColorMain,c_black,4)
textDropShadow("4",tAPmenuX+205,tAPmenuY+79,textColorMain,c_black,4)
textDropShadow("5",tAPmenuX+141,tAPmenuY+79,textColorMain,c_black,4)
textDropShadow("6",tAPmenuX+77,tAPmenuY+79,textColorMain,c_black,4)
textDropShadow("6",tAPmenuX+253,tAPmenuY+63,textColorMain,c_black,4)

//-- Find info text --
if subMenu=3
{
  menuInfoText=""
  info_Name=""
  info_Index=-1
  info_Lv=0
  info_Max=0
  info_Cost=0
  if mSAP_CurY=2
  {
    if mSAP_CurX=8 //---------- [23] Swift Foot ----------
    {
      info_Name="Swift Foot"
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Decimate 1#Increase dash invulnerability time by 11%. (One extra frame.)"
        if global.skillTree[7]>=1
          info_Index=23
        else
          info_Index=-1
        info_Lv=global.skillTree[23]
        info_Max=1
        if info_Lv=0
          info_Cost=8
      }
    }
    else if mSAP_CurX=10 //---------- [19] Fortune ----------
    {
      info_Name="Fortune"
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[7]>=1
          info_Index=19
        else
          info_Index=-1
        info_Lv=global.skillTree[19]
        info_Max=5
        if info_Lv=0
        {
          menuInfoText="Req: Decimate 1#Increase the chance of getting higher amounts of Internetz dropped by enemies by 3%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Decimate 1#Current Bonus: 3%#Increase the chance of getting higher amounts of Internetz dropped by enemies by 6%."
          info_Cost=1
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Decimate 1#Current Bonus: 6%#Increase the chance of getting higher amounts of Internetz dropped by enemies by 9%."
          info_Cost=1
        }
        else if info_Lv=3
        {
          menuInfoText="Req: Decimate 1#Current Bonus: 9%#Increase the chance of getting higher amounts of Internetz dropped by enemies by 12%."
          info_Cost=2
        }
        else if info_Lv=4
        {
          menuInfoText="Req: Decimate 1#Current Bonus: 12%#Increase the chance of getting higher amounts of Internetz dropped by enemies by 15%."
          info_Cost=2
        }
        else if info_Lv=5 {menuInfoText="Req: Decimate 1#Increase the chance of getting higher amounts of Internetz dropped by enemies by 15%."}
      }
    }
    else if mSAP_CurX=12 //---------- [22] Agility ----------
    {
      info_Name="Agility"
      if global.hasAbilToken[3]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[6]>=1
          info_Index=22
        else
          info_Index=-1
        info_Lv=global.skillTree[22]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Req: S Charge 1#Boost dash recovery by 8%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: S Charge 1#Current Bonus: 8%#Boost dash recovery by 16%."
          info_Cost=4
        }
        else if info_Lv=2
        {
          menuInfoText="Req: S Charge 1#Current Bonus: 16%#Boost dash recovery by 24%."
          info_Cost=6
        }
        else if info_Lv=3 {menuInfoText="Req: S Charge 1#Boost dash recovery by 24%."}
      }
    }
    else if mSAP_CurX=18 //---------- [17] Safeguard ----------
    {
      info_Name="Safeguard"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[5]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Feathery Ally 1#Decrease damage taken from Normal type sources by 1."
        if global.skillTree[10]>=1
          info_Index=17
        else
          info_Index=-1
        info_Lv=global.skillTree[17]
        info_Max=1
        if info_Lv=0
          info_Cost=15
      }
    }
  }
  else if mSAP_CurY=3
  {
    if mSAP_CurX=3 //---------- [18] Lucky ----------
    {
      info_Name="Lucky"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[12]>=1
          info_Index=18
        else
          info_Index=-1
        info_Lv=global.skillTree[18]
        info_Max=5
        if info_Lv=0
        {
          menuInfoText="Req: Mastery 1#Boost the chance of items being dropped by defeated enemies by 2%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Mastery 1#Current Bonus: 2%#Boost the chance of items being dropped by defeated enemies by 4%."
          info_Cost=1
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Mastery 1#Current Bonus: 4%#Boost the chance of items being dropped by defeated enemies by 6%."
          info_Cost=1
        }
        else if info_Lv=3
        {
          menuInfoText="Req: Mastery 1#Current Bonus: 6%#Boost the chance of items being dropped by defeated enemies by 8%."
          info_Cost=2
        }
        else if info_Lv=4
        {
          menuInfoText="Req: Mastery 1#Current Bonus: 8%#Boost the chance of items being dropped by defeated enemies by 10%."
          info_Cost=2
        }
        else if info_Lv=5 {menuInfoText="Req: Mastery 1#Boost the chance of items being dropped by defeated enemies by 10%."}
      }
    }
    else if mSAP_CurX=9 //---------- [7] Decimate ----------
    {
      info_Name="Decimate"
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=7
        info_Lv=global.skillTree[7]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the charge time of the Samus Diffusion Missiles by 10%. (If you have that unlocked anyway.)"
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 10%#Reduce the charge time of the Samus Diffusion Missiles by 20%. (If you have that unlocked anyway.)"
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 20%#Reduce the charge time of the Samus Diffusion Missiles by 30%. (If you have that unlocked anyway.)"
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the charge time of the Samus Diffusion Missiles by 30%. (If you have that unlocked anyway.)"}
      }
    }
    else if mSAP_CurX=13 //---------- [6] S Charge ----------
    {
      info_Name="S Charge"
      if global.hasAbilToken[3]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=6
        info_Lv=global.skillTree[6]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the charge time of Mega Man's Specials by 9% (If you have that unlocked anyway.)"
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 9%#Reduce the charge time of Mega Man's Specials by 18% (If you have that unlocked anyway.)"
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 18%#Reduce the charge time of Mega Man's Specials by 27% (If you have that unlocked anyway.)"
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the charge time of Mega Man's Specials by 27% (If you have that unlocked anyway.)"}
      }
    }
    else if mSAP_CurX=15 //---------- [28] Boost ----------
    {
      info_Name="Boost"
      if global.hasAbilToken[3]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[5]>=1
          info_Index=28
        else
          info_Index=-1
        info_Lv=global.skillTree[28]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Req: X Charge 1#Boost recovery rate of the X Buster by 6.5%.#Boost recovery rate of X Specials by 5%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: X Charge 1#Current Bonus: 6.5% -- 4.5%#Boost recovery rate of the X Buster by 13%.#Boost recovery rate of X Specials by 10%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Req: X Charge 1#Current Bonus: 13% -- 9%#Boost recovery rate of the X Buster by 19.5%.#Boost recovery rate of X Specials by 15%."
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Req: X Charge 1#Boost recovery rate of the X Buster by 19.5%.#Boost recovery rate of X Specials by 15%."}
      }
    }
    else if mSAP_CurX=17 //---------- [10] Feathery Ally ----------
    {
      info_Name="Feathery Ally"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[5]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=10
        info_Lv=global.skillTree[10]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce Game Power consumption of Bird Swarm by 3%.#Also boosts all Mega Man ability power by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 3% -- 1#Reduce Game Power consumption of Bird Swarm by 6%.#Also boosts all Mega Man ability power by 2."
          info_Cost=2
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 6% -- 2#Reduce Game Power consumption of Bird Swarm by 9%.#Also boosts all Mega Man ability power by 3."
          info_Cost=4
        }
        else if info_Lv=3 {menuInfoText="Reduce Game Power consumption of Bird Swarm by 9%.#Also boosts all Mega Man ability power by 3."}
      }
    }
  }
  else if mSAP_CurY=4
  {
    if mSAP_CurX=4 //---------- [12] Mastery ----------
    {
      info_Name="Mastery"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=12
        info_Lv=global.skillTree[12]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Increase Exp gain by 6%. (Gate 6 exp only.)#Also boosts Dagger and Holy Water power by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 6% -- 1#Increase Exp gain by 12%. (Gate 6 exp only.)#Also boosts Dagger and Holy Water power by 2."
          info_Cost=2
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 12% -- 2#Increase Exp gain by 18%. (Gate 6 exp only.)#Also boosts Dagger and Holy Water power by 3."
          info_Cost=3
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 18% -- 3#Increase Exp gain by 24%. (Gate 6 exp only.)#Also boosts Dagger and Holy Water power by 4."
          info_Cost=4
        }
        else if info_Lv=4 {menuInfoText="Increase Exp gain by 24%. (Gate 6 exp only.)#Also boosts Dagger and Holy Water power by 4."}
      }
    }
    else if mSAP_CurX=6 //---------- [15] Shrapnel Resist ----------
    {
      info_Name="Shrapnel Resist"
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Cooldown 1#Decrease damage taken from explosions by 1."
        if global.skillTree[29]>=1
          info_Index=15
        else
          info_Index=-1
        info_Lv=global.skillTree[15]
        info_Max=1
        if info_Lv=0
          info_Cost=7
      }
    }
    else if mSAP_CurX=11 //---------- [16] Perseverance ----------
    {
      info_Name="Perseverance"
      if global.hasAbilToken[0]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Expertise 2#Decrease damage taken from direct enemy contact by 1."
        if global.skillTree[25]>=2
          info_Index=16
        else
          info_Index=-1
        info_Lv=global.skillTree[16]
        info_Max=1
        if info_Lv=0
          info_Cost=8
      }
    }
    else if mSAP_CurX=14 //---------- [5] X Charge ----------
    {
      info_Name="X Charge"
      if global.hasAbilToken[3]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=5
        info_Lv=global.skillTree[5]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the charge time of Mega Man's X Buster by 5%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 5%#Reduce the charge time of Mega Man's X Buster by 10%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 10%#Reduce the charge time of Mega Man's X Buster by 15%."
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the charge time of Mega Man's X Buster by 15%."}
      }
    }
    else if mSAP_CurX=16 //---------- Skill Lock 6 - Claire ----------
    {
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[5]=0
      {
        menuInfoText="Req: Unlock Access Gate 6, X Charge 1"
        info_Name="Skill Lock 6"
      }
    }
    else if mSAP_CurX=18 //---------- [9] Advanced Shielding ----------
    {
      info_Name="Advanced Shielding"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[5]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=9
        info_Lv=global.skillTree[9]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Increase shield regeneration by 5%.#Also boosts Arrow power by 1 and Bomb power by 2."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 5% -- 1 - 2#Increase shield regeneration by 10%.#Also boosts Arrow power by 2 and Bomb power by 4."
          info_Cost=2
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 10% -- 2 - 4#Increase shield regeneration by 15%.#Also boosts Arrow power by 3 and Bomb power by 6."
          info_Cost=3
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 15% -- 3 - 6#Increase shield regeneration by 20%.#Also boosts Arrow power by 4 and Bomb power by 8."
          info_Cost=4
        }
        else if info_Lv=4 {menuInfoText="Increase shield regeneration by 20%.#Also boosts Arrow power by 4 and Bomb power by 8."}
      }
    }
  }
  else if mSAP_CurY=5
  {
    if mSAP_CurX=3 //---------- [11] Furious Cutter ----------
    {
      info_Name="Furious Cutter"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=11
        info_Lv=global.skillTree[11]
        info_Max=2
        if info_Lv=0
        {
          menuInfoText="Reduce Game Power consumption of Blade Strike by 1.#Also boosts Hair Whip power by 4."
          info_Cost=3
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 1 -- 4#Reduce Game Power consumption of Blade Strike by 2.#Also boosts Hair Whip power by 8."
          info_Cost=5
        }
        else if info_Lv=2 {menuInfoText="Reduce Game Power consumption of Blade Strike by 2.#Also boosts Hair Whip power by 8."}
      }
    }
    else if mSAP_CurX=5 //---------- Skill Lock 6 - Jerry ----------
    {
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        menuInfoText="Req: Unlock Access Gate 6, Decimate 1"
        info_Name="Skill Lock 6"
      }
    }
    else if mSAP_CurX=7 //---------- [29] Cooldown ----------
    {
      info_Name="Cooldown"
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=29
        info_Lv=global.skillTree[29]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the amount of heat gain per Beam shot by 10%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 10%#Reduce the amount of heat gain per Beam shot by 20%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 20%#Reduce the amount of heat gain per Beam shot by 30%."
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the amount of heat gain per Beam shot by 30%."}
      }
    }
    else if mSAP_CurX=9 //---------- Skill Lock 5 ----------
    {
      if global.hasAbilToken[4]=0 or global.skillTree[25]=0
      {
        menuInfoText="Req: Unlock Access Gate 5, Expertise 1"
        info_Name="Skill Lock 5"
      }
    }
    else if mSAP_CurX=13 //---------- Skill Lock 4 ----------
    {
      if global.hasAbilToken[3]=0 or global.skillTree[25]=0
      {
        menuInfoText="Req: Unlock Access Gate 4, Expertise 1"
        info_Name="Skill Lock 4"
      }
    }
    else if mSAP_CurX=17 //---------- [8] Rapid Fire ----------
    {
      info_Name="Rapid Fire"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[5]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText=""
        info_Index=8
        info_Lv=global.skillTree[8]
        info_Max=1
        if info_Lv=0
        {
          menuInfoText="Reduce Game Power consumption of Spam Gun by 1.#Also boosts Master Sword power by 6."
          info_Cost=8
        }
        else if info_Lv=1 {menuInfoText="Reduce Game Power consumption of Spam Gun by 1.#Also boosts Master Sword power by 6."}
      }
    }
  }
  else if mSAP_CurY=6
  {
    if mSAP_CurX=4 //---------- [13] Blades of Awesome ----------
    {
      info_Name="Blades of Awesome"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=13
        info_Lv=global.skillTree[13]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce Game Power consumption of Chainblade Storm by 3%.#Also boosts all Samus ability power by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 3% -- 1#Reduce Game Power consumption of Chainblade Storm by 6%.#Also boosts all Samus ability power by 2."
          info_Cost=2
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 6% -- 2#Reduce Game Power consumption of Chainblade Storm by 9%.#Also boosts all Samus ability power by 3."
          info_Cost=4
        }
        else if info_Lv=3 {menuInfoText="Reduce Game Power consumption of Chainblade Storm by 9%.#Also boosts all Samus ability power by 3."}
      }
    }
    else if mSAP_CurX=11 //---------- [25] Expertise ----------
    {
      info_Name="Expertise"
      if global.hasAbilToken[0]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[24]>=1
          info_Index=25
        else
          info_Index=-1
        info_Lv=global.skillTree[25]
        info_Max=5
        if info_Lv=0
        {
          menuInfoText="Req: Quick Recovery 1#Boost hit combo and chain time by 5%"
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Quick Recovery 1#Current Bonus: 5%#Boost hit combo and chain time by 10%"
          info_Cost=1
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Quick Recovery 1#Current Bonus: 10%#Boost hit combo and chain time by 15%"
          info_Cost=1
        }
        else if info_Lv=3
        {
          menuInfoText="Req: Quick Recovery 1#Current Bonus: 15%#Boost hit combo and chain time by 20%"
          info_Cost=2
        }
        else if info_Lv=4
        {
          menuInfoText="Req: Quick Recovery 1#Current Bonus: 20%#Boost hit combo and chain time by 25%"
          info_Cost=3
        }
        else if info_Lv=5 {menuInfoText="Req: Quick Recovery 1#Boost hit combo and chain time by 25%"}
      }
    }
  }
  else if mSAP_CurY=7
  {
    if mSAP_CurX=3 //---------- [27] Resilience ----------
    {
      info_Name="Resilience"
      if (global.hasAbilToken[5]=0 and global.hasAbilToken[6]=0) or global.skillTree[7]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Blades of Awesome 1#Decrease damage taken from traps by 1."
        if global.skillTree[13]>=1
          info_Index=27
        else
          info_Index=-1
        info_Lv=global.skillTree[27]
        info_Max=1
        if info_Lv=0
          info_Cost=7
      }
    }
    else if mSAP_CurX=6 //---------- [21] Charm ----------
    {
      info_Name="Charm"
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[4]>=1
          info_Index=21
        else
          info_Index=-1
        info_Lv=global.skillTree[21]
        info_Max=5
        if info_Lv=0
        {
          menuInfoText="Req: Burn 1#Boost the damage dealt by Claire by 2%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Burn 1#Current Bonus: 2%#Boost the damage dealt by Claire by 4%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Burn 1#Current Bonus: 4%#Boost the damage dealt by Claire by 6%."
          info_Cost=4
        }
        else if info_Lv=3
        {
          menuInfoText="Req: Burn 1#Current Bonus: 6%#Boost the damage dealt by Claire by 8%."
          info_Cost=5
        }
        else if info_Lv=4
        {
          menuInfoText="Req: Burn 1#Current Bonus: 8%#Boost the damage dealt by Claire by 10%."
          info_Cost=7
        }
        else if info_Lv=5 {menuInfoText="Req: Burn 1#Boost the damage dealt by Claire by 10%."}
      }
    }
    else if mSAP_CurX=8 //---------- [3] Stab ----------
    {
      info_Name="Stab"
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=3
        info_Lv=global.skillTree[3]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the amount of hearts consumed by Belmont's Dagger by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 1#Reduce the amount of hearts consumed by Belmont's Dagger by 2."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 2#Reduce the amount of hearts consumed by Belmont's Dagger by 3."
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the amount of hearts consumed by Belmont's Dagger by 3."}
        else if info_Lv=5 {info_Max=5; menuInfoText="Reduce the amount of hearts consumed by Belmont's Dagger by 5."} //Nightmare only
      }
    }
    else if mSAP_CurX=14 //---------- [1] Boom ----------
    {
      info_Name="Boom"
      if global.hasAbilToken[1]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=1
        info_Lv=global.skillTree[1]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Reduce the cooldown of Link's Bombs by 6.25%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 6.25%#Reduce the cooldown of Link's Bombs by 12.5%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 12.5%#Reduce the cooldown of Link's Bombs by 18.75%."
          info_Cost=4
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 18.75%#Reduce the cooldown of Link's Bombs by 25%."
          info_Cost=5
        }
        else if info_Lv=4 {menuInfoText="Reduce the cooldown of Link's Bombs by 25%."}
      }
    }
    else if mSAP_CurX=16 //---------- [20] Manliness ----------
    {
      info_Name="Manliness"
      if global.hasAbilToken[1]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[1]>=1
          info_Index=20
        else
          info_Index=-1
        info_Lv=global.skillTree[20]
        info_Max=5
        if info_Lv=0
        {
          menuInfoText="Req: Boom 1#Boost the damage dealt by Jerry by 2%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Boom 1#Current Bonus: 2%#Boost the damage dealt by Jerry by 4%."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Boom 1#Current Bonus: 4%#Boost the damage dealt by Jerry by 6%."
          info_Cost=4
        }
        else if info_Lv=3
        {
          menuInfoText="Req: Boom 1#Current Bonus: 6%#Boost the damage dealt by Jerry by 8%."
          info_Cost=5
        }
        else if info_Lv=4
        {
          menuInfoText="Req: Boom 1#Current Bonus: 8%#Boost the damage dealt by Jerry by 10%."
          info_Cost=7
        }
        else if info_Lv=5 {menuInfoText="Req: Boom 1#Boost the damage dealt by Jerry by 10%."}
      }
    }
  }
  else if mSAP_CurY=8
  {
    if mSAP_CurX=7 //---------- [4] Burn ----------
    {
      info_Name="Burn"
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=4
        info_Lv=global.skillTree[4]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Reduce the amount of hearts consumed by Belmont's Holy Water by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 1#Reduce the amount of hearts consumed by Belmont's Holy Water by 2."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 2#Reduce the amount of hearts consumed by Belmont's Holy Water by 3."
          info_Cost=5
        }
        else if info_Lv=3 {menuInfoText="Reduce the amount of hearts consumed by Belmont's Holy Water by 3."}
        else if info_Lv=5 {info_Max=5; menuInfoText="Reduce the amount of hearts consumed by Belmont's Holy Water by 5."} //Nightmare only
      }
    }
    else if mSAP_CurX=9 //---------- Skill Lock 3 ----------
    {
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        menuInfoText="Req: Unlock Access Gate 3, Quick Recovery 1"
        info_Name="Skill Lock 3"
      }
    }
    else if mSAP_CurX=11 //---------- [24] Quick Recovery ----------
    {
      info_Name="Quick Recovery"
      if global.hasAbilToken[0]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=24
        info_Lv=global.skillTree[24]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Decrease flinch time from taking damage by 5.5%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 5.5%#Decrease flinch time from taking damage by 11%."
          info_Cost=2
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 11%#Decrease flinch time from taking damage by 16.5%."
          info_Cost=3
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 16.5%#Decrease flinch time from taking damage by 22%."
          info_Cost=4
        }
        else if info_Lv=4 {menuInfoText="Decrease flinch time from taking damage by 22%."}
      }
    }
    else if mSAP_CurX=13 //---------- Skill Lock 2 ----------
    {
      if global.hasAbilToken[1]=0 or global.skillTree[24]=0
      {
        menuInfoText="Req: Unlock Access Gate 2, Quick Recovery 1"
        info_Name="Skill Lock 2"
      }
    }
    else if mSAP_CurX=15 //---------- [14] Elemental Resist ----------
    {
      info_Name="Elemental Resist"
      if global.hasAbilToken[1]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        menuInfoText="Req: Sword Master 2#Decrease damage taken from elemental sources by 1."
        if global.skillTree[0]>=2
          info_Index=14
        else
          info_Index=-1
        info_Lv=global.skillTree[14]
        info_Max=1
        if info_Lv=0
          info_Cost=7
      }
    }
  }
  else if mSAP_CurY=9
  {
    if mSAP_CurX=6 //---------- [2] Pulse ----------
    {
      info_Name="Pulse"
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        if global.skillTree[26]>=2
          info_Index=2
        else
          info_Index=-1
        info_Lv=global.skillTree[2]
        info_Max=3
        if info_Lv=0
        {
          menuInfoText="Req: Cool Whip 2#Boost the recovery rate of hearts by 14%."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Req: Cool Whip 2#Current Bonus: 14%#Boost the recovery rate of hearts by 28%."
          info_Cost=4
        }
        else if info_Lv=2
        {
          menuInfoText="Req: Cool Whip 2#Current Bonus: 28%#Boost the recovery rate of hearts by 42%."
          info_Cost=6
        }
        else if info_Lv=3 {menuInfoText="Req: Cool Whip 2#Boost the recovery rate of hearts by 42%."}
      }
    }
    else if mSAP_CurX=8 //---------- [26] Cool Whip ----------
    {
      info_Name="Cool Whip"
      if global.hasAbilToken[2]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=26
        info_Lv=global.skillTree[26]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Boost the stun time of hair whip attacks by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 1#Boost the stun time of hair whip attacks by 2."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 2#Boost the stun time of hair whip attacks by 3."
          info_Cost=4
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 3#Boost the stun time of hair whip attacks by 4."
          info_Cost=6
        }
        else if info_Lv=4 {menuInfoText="Boost the stun time of hair whip attacks by 4."}
      }
    }
    else if mSAP_CurX=14 //---------- [0] Sword Master ----------
    {
      info_Name="Sword Master"
      if global.hasAbilToken[1]=0 or global.skillTree[24]=0
      {
        info_Index=-1
        menuInfoText="Skill Locked."
      }
      else
      {
        info_Index=0
        info_Lv=global.skillTree[0]
        info_Max=4
        if info_Lv=0
        {
          menuInfoText="Boost the stun time of sword attacks by 1."
          info_Cost=1
        }
        else if info_Lv=1
        {
          menuInfoText="Current Bonus: 1#Boost the stun time of sword attacks by 2."
          info_Cost=3
        }
        else if info_Lv=2
        {
          menuInfoText="Current Bonus: 2#Boost the stun time of sword attacks by 3."
          info_Cost=4
        }
        else if info_Lv=3
        {
          menuInfoText="Current Bonus: 3#Boost the stun time of sword attacks by 4."
          info_Cost=6
        }
        else if info_Lv=4 {menuInfoText="Boost the stun time of sword attacks by 4."}
      }
    }
  }
  else if mSAP_CurY=10 //---------- Skill Lock 1 ----------
  {
    if mSAP_CurX=11
    {
      if global.hasAbilToken[0]=0
      {
        menuInfoText="Req: Unlock Access Gate 1"
        info_Name="Skill Lock 1"
      }
    }
  }

  draw_set_alpha(1)
  draw_set_font(fnt_PauseMenuText)
  //Display Skill header info
  if info_Name!=""
  {
    draw_set_halign(fa_left)
    draw_text(infoMenuX+87,infoMenuY+2,">>" +string(info_Name) +string(": Lv ") +string(info_Lv) +string(" / ") +string(info_Max))
    if info_Cost>0
      draw_text(infoMenuX+314,infoMenuY+2,"SP Cost: " +string(info_Cost))
  }
  //Display cursor
  mSAP_FrameCount+=1
  if mSAP_FrameCount mod 8=0
  {
    if mSAP_CurFrame=0
      mSAP_CurFrame=1
    else
      mSAP_CurFrame=0
  }
  draw_sprite(sPauseM_APCursor,mSAP_CurFrame,tAPmenuX-3+(mSAP_CurX*16),tAPmenuY+6+(mSAP_CurY*16))
}
