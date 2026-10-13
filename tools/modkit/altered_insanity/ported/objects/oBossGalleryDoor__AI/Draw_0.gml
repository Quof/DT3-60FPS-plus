if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=480
{
  //scrGateGlow() //gate glow change (added): the gate's eyes in the best medal's colour, the gate glowing with platinum
  //mods change: only in the boss halls, the rooms with the gallery's gate behind each door (scrGateGlow draws the eyes
  //where that gate's are); and always from the best time, as the gallery lever's records (bossGalleryHitsN,
  //bossGalleryPlatN) only go up to the game's own bosses (index 64), and with the lever on it read past them for this
  //mod's (type 66 and up)
  if room=rBT_Cousinoer5_BossHall or room=rBT_Cousinoer5_BossHall2
  {
    var tNorm; tNorm=global.galleryNormalized; global.galleryNormalized=0
    scrGateGlow()
    global.galleryNormalized=tNorm
  }
  if activateTime=0
  {
    pointTime+=1*gDeltaTime
    if pointTime=20 {arrowY+=1}
    else if pointTime=40
    {
      arrowY-=1
      pointTime=0
    }
    draw_sprite(sExitArrow,arrowColor,arrowX,arrowY)
  }

  draw_set_color(c_white)
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_middle)
  //if global.galleryNormalized=1 {event_user(1); exit} //normalized gallery change (added): the gallery lever's scoring
  //(mods change: taken out: the lever's scoring is for the game's own bosses (this object has no user event 1: block in
  //object.ini), so with the lever on these doors drew nothing; they keep the best time and its medals, as in the mod)
  if global.bossGalleryTime[type-1]=99999 {draw_text(x+8,y-112,string(bossName) +string("#-Best Time-#-----"))}
  else {draw_text(x+8,y-112,string(bossName) +string("#-Best Time-#") +string(global.bossGalleryTime[type-1]))}

  //Award board
  if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=64
  {
    //draw_sprite(sBossAwardCheck,0,x+8,y+64)
    //draw_set_color(textColorGreen)
    //for(i=0;i<3;i+=1)
    //{
    //  draw_text(x-22+(i*30),y+58,award[i])
    //  if global.bossGalleryTime[type-1]<=award[i] {draw_sprite(sBossGalleryMedals,i,x-22+(i*30),y+64)}
    //}
    //platinum box change: once the platinum medal is earned, it's in its own ornate box (sBossAwardPlat, the same height)
    //to the right of the three medals' box, with its time under it in white (as it was under the medal), and the two
    //together are centred under the gate (tBX: the three medals' box 28 left of the centre)
    var tPlatGot,tBX;
    tPlatGot=0
    if variable_local_exists("hasPlat") {if global.bossGalleryTime[type-1]<=award[3] {tPlatGot=1}}
    tBX=0
    if tPlatGot=1 {tBX=-28}
    draw_sprite(sBossAwardCheck,0,x+8+tBX,y+64)
    draw_set_color(textColorGreen)
    for(i=0;i<3;i+=1)
    {
      draw_text(x-22+(i*30)+tBX,y+58,award[i])
      if global.bossGalleryTime[type-1]<=award[i] {draw_sprite(sBossGalleryMedals,i,x-22+(i*30)+tBX,y+64)}
    }
    if tPlatGot=1 //3px right of the three medals' box (its half is 59, the platinum box's 27)
    {
      draw_sprite(sBossAwardPlat,0,x+97+tBX,y+64)
      scrPlatGlow(x+97+tBX,y+64,1,type,0); draw_sprite(sBossGalleryMedals,3,x+97+tBX,y+64); scrPlatGlow(x+97+tBX,y+64,1,type,1)
      draw_set_color(c_white)
      draw_text(x+97+tBX,y+92,award[3])
    }

    //platinum box change: the platinum medal is in its own box now (above)
    //(the mod drew it here for its own doors, which have hasPlat: the box above draws it for them too)
    //if variable_local_exists("hasPlat")
    //{
    //  if global.bossGalleryTime[type-1]<=award[3]
    //  {
    //    //draw_sprite(sBossGalleryMedals,3,x+8,y+106)
    //    scrPlatGlow(x+8,y+106,1,type,0); draw_sprite(sBossGalleryMedals,3,x+8,y+106); scrPlatGlow(x+8,y+106,1,type,1) //platinum glow change: the radiant shine (scrPlatGlow)
    //    draw_set_color(c_white)
    //    draw_text(x+8,y+120,award[3])
    //  }
    //}
  }
}
