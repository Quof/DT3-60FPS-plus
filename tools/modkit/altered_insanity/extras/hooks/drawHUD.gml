//The timer during Altered Insanity's boss challenges, as the boss gallery's (oHUD's draw, with the HUD on).
if global.inBossChallenge and room!=rBT_Cousinoer5_BossHall and room!=rBT_Cousinoer5_BossHall2 and !(global.bBossGallery=1 and room!=rBossGallery)
{
  draw_set_alpha(1)
  draw_set_font(fnt_NES)
  draw_set_halign(fa_left)
  draw_sprite(sHUD_BossGalleryClock,0,view_xview[0]+382,view_yview[0]+8)
  textDropShadow(global.levelTimeSecond,view_xview[0]+392,view_yview[0]+8,awesomeColorA,awesomeColorB,3)
}
