#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
colR=255
colG=255
colB=255

cR_Seq=0
cG_Seq=0
cB_Seq=0

barColor=c_white
healthTrack=0
barOffsetX=447
alarm[0]=1
#define Alarm_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if variable_local_exists("newOffsetX")
{
  barOffsetX=newOffsetX
}
#define Draw_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if instance_exists(bossID)
{
  if bossID.life>0 and bossID.bShowHealthBar=true and global.optEnemyHP=1
  {
    if type=0 or type=3 //======================================== Normal (Castlevania) ========================================
    {
      bossBarX=view_xview[0]+barOffsetX
      bossBarY=view_yview[0]+5
      draw_sprite(sBossLifeBar,0,bossBarX,bossBarY);
      if type=3 {healthTrack=((bossID.life-10000)/(bossID.maxLife-10000))*200}
      else {healthTrack=(bossID.life/bossID.maxLife)*200}
      //----- Red -----
      if cR_Seq=0
      {
        colR-=2
        if colR<=2 {cR_Seq=1}
      }
      else
      {
        colR+=2
        if colR>=253 {cR_Seq=0}
      }
      //----- Green -----
      if cG_Seq=0
      {
        colG-=4
        if colG<=4 {cG_Seq=1}
      }
      else
      {
        colG+=4
        if colG>=251 {cG_Seq=0}
      }
      //----- Blue -----
      if cB_Seq=0
      {
        colB-=7
        if colB<=7 {cB_Seq=1}
      }
      else
      {
        colB+=7
        if colB>=248 {cB_Seq=0}
      }
      barColor=make_color_rgb(colR,colG,colB)
      draw_sprite_ext(sBossLifeTrack,0,bossBarX+17,bossBarY+200,1,healthTrack,180,barColor,1)

      if type=3 //The Executive
      {
        for(i=0;i<bossID.phaseNum-1;i+=1)
        {
          draw_sprite(sPT_EX_LifeBars,0,bossBarX+25,bossBarY+198-(i*6))
          if bossID.phaseNum-1-(bossID.atkPhase-1)>i
          {
            draw_sprite_ext(sPT_EX_LifeBars,1,bossBarX+25,bossBarY+198-(i*6),1,1,0,barColor,1)
          }
        }
      }
    }
    else if type=1 //======================================== Mega Man X ========================================
    {
      bossBarX=view_xview[0]+barOffsetX
      bossBarY=view_yview[0]+5
      draw_sprite(sBossBarMMA,0,bossBarX,bossBarY)
      draw_sprite_ext(sBossBarMMB,0,bossBarX,bossBarY+4,1,100,0,c_white,1)
      draw_sprite(sBossBarMMC,0,bossBarX,bossBarY+104)

      if lifeFill=1000 {healthTrack=round((bossID.life/bossID.maxLife)*50)}
      for(i=0;i<healthTrack;i+=1)
      {
        draw_sprite(sBossBarMMD,0,bossBarX+4,bossBarY+102-(i*2))
      }
    }
    else if type=2 //======================================== Warmaster ========================================
    {
      bossBarX=view_xview[0]+125
      bossBarY=view_yview[0]+331
      draw_sprite(sWM_Hud_LifeBack,0,bossBarX,bossBarY)
      if room!=rBT_WarmasterA {draw_sprite(sWM_Hud_FormIcon,bossID.ATTACK_FORM-1,bossBarX+2,bossBarY+2);}
      healthTrack=(bossID.life/bossID.maxLife)*200
      draw_sprite_ext(sWM_Hud_LifeTrack,0,bossBarX+15,bossBarY+11,healthTrack,1,0,barColor,1)
      //Charge bars
      if room!=rBT_WarmasterA
      {
        for(i=0;i<bossID.superCharge;i+=1)
        {
          draw_sprite(sWM_Hud_ChargeBar,0,bossBarX+19+(i*11),bossBarY+7)
        }
      }
      //Life bars
      if healthTrack=200 {draw_sprite(sWM_Hud_LifeBars,0,bossBarX+15,bossBarY+11)}
      else if healthTrack>=180 and healthTrack<=199.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,180,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=160 and healthTrack<=179.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,160,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=140 and healthTrack<=159.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,140,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=120 and healthTrack<=139.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,120,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=100 and healthTrack<=119.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,100,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=80 and healthTrack<=99.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,80,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=60 and healthTrack<=79.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,60,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=40 and healthTrack<=59.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,40,5,bossBarX+15,bossBarY+11)}
      else if healthTrack>=20 and healthTrack<=39.99 {draw_sprite_part(sWM_Hud_LifeBars,0,0,0,20,5,bossBarX+15,bossBarY+11)}
    }
  }
}
else {instance_destroy()}
