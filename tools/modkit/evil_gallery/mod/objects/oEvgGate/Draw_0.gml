//Evil Boss Gallery: the gate: its arch (the gallery's, 48 left of the door and 80 above it), the swirl in it (4 frames,
//6 ticks each, its foot on the floor), and near the player its name and the arrow over the door (as a gallery door's)
draw_sprite(sEvgGateArch,0,x-48,y-80)
draw_sprite_ext(sEvgPortal,floor(glowT/6) mod 4,x+8,y+32,1,1,0,c_white,0.6+0.25*sin(glowT*0.08))
if point_distance(x+8,y+16,oPlayer1.x,returnPlayerYCenter())<=480
{
  if activateTime=0
  {
    pointTime+=1*gDeltaTime
    if pointTime=20 {arrowY+=1}
    else if pointTime=40
    {
      arrowY-=1
      pointTime=0
    }
    draw_sprite(sExitArrow,0,arrowX,arrowY)
  }
  draw_set_alpha(1)
  draw_set_font(fnt_EnemyName)
  draw_set_halign(fa_center)
  draw_set_color(make_color_rgb(255,80,100))
  draw_text(x+8,y-112,gateName)
  draw_set_color(c_white)
}
