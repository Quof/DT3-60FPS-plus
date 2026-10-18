//Randomizer: with no empty bottle to fill (rndHintBottle), the hint's offer instead of the drinks' (the Collision
//event's prefix: rndHintCost), or that nothing is left to hint at (its rndHintLeft). Otherwise as the game's own
if global.rndActive=1 and !rndHintBottle()
{
  draw_self()
  if showMyText>0 and variable_local_exists("rndHintLeft")
  {
    var tText;
    if rndHintLeft {tText="PRESS UP TO BUY A HINT#"+string(rndHintCost())+" INTERNETZ#WHERE AN IMPORTANT ITEM IS"}
    else {tText="NOTHING LEFT TO HINT AT"}
    draw_set_alpha(1)
    draw_set_font(fnt_NES)
    draw_set_halign(fa_center)
    textDropShadow(tText,x,y-80,helpTextInner,helpTextOuter,4)
    draw_set_halign(fa_left)
  }
  exit
}
