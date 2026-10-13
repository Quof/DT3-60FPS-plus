//yOffset+=ySpeed
yOffset+=ySpeed*gDeltaTime //60fps change
x = view_xview[0]+xOffset
y = view_yview[0]+350-yOffset
//life -=1
life -=1*gDeltaTime //60fps change

if life = 0
    instance_destroy()
