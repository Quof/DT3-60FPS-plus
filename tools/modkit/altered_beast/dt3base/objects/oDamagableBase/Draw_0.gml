if findTargetX<480 and findTargetY<352
  //enemyDrawEvent()
  draw_sprite_ext(sprite_index,image_index,x,y,image_xscale,image_yscale,image_angle,image_blend,image_alpha) //60fps change: enemyDrawEvent's one line, without the script call (every enemy, trap and enemy shot draws through here, every frame)
