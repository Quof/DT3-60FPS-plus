/*
gate glow change (added): a boss gallery door's gate (the 112x112 tileBossRoomA part at 0,64, placed 48 left and 80 above
the door: rBossGallery's tiles) shows the best medal earned there: the skull's eyes glow steadily in that medal's colour
(none: as they are). The medal is the regular gallery's (best
time against award[0]..[3]) or, with the gallery lever on, the normalized one's (fewest hits, platinum with the New Dark
Omen: bossRoomTally). Runs in oBossGalleryDoor's Draw event (drawn over the gate, which is a tile behind it).
*/
var tMedal,tT,tGX,tGY,tCol,tCore,tA,i,tEye;

//the best medal: 0 none, 1 bronze, 2 silver, 3 gold, 4 platinum
tMedal=0
if global.galleryNormalized=1
{
  tT=global.bossGalleryHitsN[type-1]
  if global.bossGalleryPlatN[type-1]=1 {tMedal=4}
  else if tT=0 {tMedal=3}
  else if tT<=2 {tMedal=2}
  else if tT<=4 {tMedal=1}
}
else
{
  tT=global.bossGalleryTime[type-1]
  if variable_local_exists("hasPlat") {if tT<=award[3] {tMedal=4}}
  if tMedal=0
  {
    if tT<=award[2] {tMedal=3}
    else if tT<=award[1] {tMedal=2}
    else if tT<=award[0] {tMedal=1}
  }
}
if tMedal=0 {exit}

//tHalo: how strong the halo round each eye is (gate glow change (added))
var tHalo;
//if tMedal=1 {tCol=make_color_rgb(230,140,80); tCore=make_color_rgb(255,196,140)}
//if tMedal=1 {tCol=make_color_rgb(178,104,56); tCore=make_color_rgb(212,136,82)} //gate glow change: a darker bronze, still a little brighter than the skull's own browns (144,108,72)
if tMedal=1 {tCol=make_color_rgb(172,100,54); tCore=tCol; tHalo=0} //gate glow change: bronze is just the eyes lit, no halo or brighter middle; a touch darker, still about as bright as the skull's own browns (144,108,72)
//else if tMedal=2 {tCol=make_color_rgb(190,206,222); tCore=make_color_rgb(236,244,255)}
else if tMedal=2 {tCol=make_color_rgb(124,130,138); tCore=make_color_rgb(146,152,162); tHalo=0.3} //gate glow change: a much darker grey with a faint halo, so platinum stands out from it
else if tMedal=3 {tCol=make_color_rgb(255,206,72); tCore=make_color_rgb(255,242,160); tHalo=0.7}
else {tCol=make_color_rgb(226,232,255); tCore=c_white; tHalo=0.7}
tGX=x-48; tGY=y-80

//the gate, with the platinum medal: its own picture added on top in platinum, also a pixel or two around it so it
//spills past its edges, and a soft light over the arch; slowly breathing
//gate glow change: taken out (only the eyes show the medal now)
//if tMedal=4
//{
//  tA=0.75+0.25*sin(current_time/1000*2.1)
//  draw_set_blend_mode(bm_add)
//  draw_ellipse_color(tGX-6,tGY+2,tGX+117,tGY+116,make_color_rgb(round(70*tA),round(74*tA),round(92*tA)),c_black,false)
//  for(i=0;i<8;i+=1) {draw_background_part_ext(tileBossRoomA,0,64,112,112,tGX+round(lengthdir_x(2,i*45)),tGY+round(lengthdir_y(2,i*45)),1,1,tCol,0.22*tA)}
//  draw_background_part_ext(tileBossRoomA,0,64,112,112,tGX,tGY,1,1,tCol,0.35*tA)
//  draw_set_blend_mode(bm_normal)
//  draw_set_alpha(1)
//}

//the eyes: the sockets' dark pixels lit in the medal's colour, the middle ones brightest, and a small steady halo
for(tEye=0;tEye<2;tEye+=1)
{
  draw_set_color(tCol)
  if tEye=0
  {
    draw_point(tGX+51,tGY+21); draw_point(tGX+52,tGY+21)
    draw_point(tGX+49,tGY+22); draw_point(tGX+50,tGY+22); draw_point(tGX+53,tGY+22)
    draw_point(tGX+50,tGY+23)
    draw_set_color(tCore); draw_point(tGX+51,tGY+22); draw_point(tGX+52,tGY+22)
  }
  else
  {
    draw_point(tGX+60,tGY+21); draw_point(tGX+61,tGY+21); draw_point(tGX+62,tGY+21)
    draw_point(tGX+59,tGY+22); draw_point(tGX+62,tGY+22); draw_point(tGX+63,tGY+22)
    draw_point(tGX+61,tGY+23); draw_point(tGX+62,tGY+23)
    draw_set_color(tCore); draw_point(tGX+60,tGY+22); draw_point(tGX+61,tGY+22)
  }
}
//draw_set_blend_mode(bm_add)
//draw_set_alpha(0.7)
//draw_circle_color(tGX+51.5,tGY+22.5,5,tCol,c_black,false)
//draw_circle_color(tGX+61.5,tGY+22.5,5,tCol,c_black,false)
//draw_set_blend_mode(bm_normal)
//draw_set_alpha(1)
if tHalo>0 //gate glow change: each medal's own halo strength (none for bronze)
{
  draw_set_blend_mode(bm_add)
  draw_set_alpha(tHalo)
  draw_circle_color(tGX+51.5,tGY+22.5,5,tCol,c_black,false)
  draw_circle_color(tGX+61.5,tGY+22.5,5,tCol,c_black,false)
  draw_set_blend_mode(bm_normal)
  draw_set_alpha(1)
}
