event_inherited()
//image_angle-=25
image_angle-=25*gDeltaTime //60fps change: per frame

//correctSpeedDirection(self)
//60fps change: removed the line above; event_inherited() already runs the parent's Step, which does the move, so this bullet moved twice per step (double speed)
