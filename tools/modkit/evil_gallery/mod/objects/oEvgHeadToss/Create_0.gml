//Evil Boss Gallery: Evil Helmethead's tossed head (his Step makes it, with owner, dir and the head's sprite): out the
//way dir says, slowing (v0, acc), arcing 34 up, and back to where it left after 2*v0/acc ticks (70: 122 out at the
//furthest), spinning, at 1.5x size. Back, it's his again (owner.headOff 0). It can't be hurt
event_inherited()
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
damageType="NORMAL"
image_speed=0
image_xscale=1.5
image_yscale=1.5
owner=noone
dir=1
tossT=0
x0=x
y0=y
v0=7
acc=0.2
