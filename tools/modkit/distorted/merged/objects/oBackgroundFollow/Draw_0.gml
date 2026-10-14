if type=0 //stationary background
  draw_background_stretched_ext(backSet,view_xview[0]+x,view_yview[0]+y,wSize,hSize,image_blend,image_alpha)
else if type=1 //tiled background, stationary/move
  draw_background_tiled_ext(backSet,x+xx,y+yy,image_xscale,image_yscale,image_blend,image_alpha)
else if type=2 or type=5 //tiled background, move scaled with screen
  draw_background_tiled_ext(backSet,view_xview[0]*xMoveScale,view_yview[0]*yMoveScale,image_xscale,image_yscale,image_blend,image_alpha)
else if type=3 //tiled background, move scaled with screen, x/y adjust
  draw_background_tiled_ext(backSet,(view_xview[0]+xAdjust)*xMoveScale,(view_yview[0]+yAdjust)*yMoveScale,image_xscale,image_yscale,image_blend,image_alpha)
else if type=4 //stationary background - extra
  draw_background_general(backSet,0,0,256,176,x,y,image_xscale,image_yscale,image_angle,image_blend,image_blend,image_blend,image_blend,image_alpha)
else if type=6 //spsp ns DAbom
  draw_background_tiled_ext(backSet,x+xx,y+yy,image_xscale,image_yscale,image_blend,image_alpha)

if view_current=0
{
  xx+=xScrollSpeed*gDeltaTime
  yy+=yScrollSpeed*gDeltaTime
}
