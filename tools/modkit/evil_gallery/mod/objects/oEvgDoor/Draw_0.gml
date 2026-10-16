//Evil Boss Gallery: the door's text and award board, as a gallery door's (near the player): the boss's evil name, its
//best time and fewest hits in a win (global.evgTime, evgHits), and medals for the hits: bronze for 3-4, silver for 1-2,
//gold for none. A sealed door shows the boss's name and that it's sealed, dim, and no arrow
if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=480
{
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_center)
  if evgRoom<0
  {
    draw_set_color(make_color_rgb(150,130,140))
    draw_set_alpha(0.6)
    draw_text(x+8,y-112,string(bossName)+"#-Sealed-")
    draw_set_alpha(1)
    draw_set_color(c_white)
    exit
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
  var k,tHits,tTimeText,tHitsText;
  k=type-1
  tHits=global.evgHits[k]
  tTimeText="-----"
  if global.evgTime[k]<99999 {tTimeText=string(global.evgTime[k])}
  tHitsText="-----"
  if tHits<99999 {tHitsText=string(tHits)}
  draw_set_color(make_color_rgb(255,90,110))
  draw_text(x+8,y-112,"Evil "+string(bossName))
  draw_set_color(c_white)
  draw_text(x+8,y-112,"#-Best Time | Hits-#"+tTimeText+" | "+tHitsText)

  //Award board
  if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=64
  {
    draw_sprite(sBossAwardCheck,0,x+8,y+64)
    draw_set_color(textColorGreen)
    draw_text(x-22,y+58,"3-4")
    draw_text(x+8,y+58,"1-2")
    draw_text(x+38,y+58,"0")
    if tHits<=4 {draw_sprite(sBossGalleryMedals,0,x-22,y+64)}
    if tHits<=2 {draw_sprite(sBossGalleryMedals,1,x+8,y+64)}
    if tHits=0 {draw_sprite(sBossGalleryMedals,2,x+38,y+64)}
  }
  draw_set_color(c_white)
}
