event_inherited()


x = view_xview[0]+240
y = view_yview[0]+176
//lifeTime-=1
//instance_create(x,y,oGravEffect)
lifeTime-=1*gDeltaTime //60fps change
if gDeltaDoTicks {instance_create(x,y,oGravEffect)} //60fps change: one particle a 30fps tick
if lifeTime = 0
{
    oPlayer1.grav*=3
    instance_destroy()
}
