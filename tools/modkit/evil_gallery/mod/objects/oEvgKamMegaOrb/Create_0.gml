event_inherited()
//Evil Boss Gallery: Evil Kamek's mega orb (his user event 3: owner, rollSpd): one of his shapes grown big (2.4x, about
//48 across) in his hand for 30 ticks (harmless), then dropped: it falls to the floor and rolls toward the player's side
//at rollSpd, back off the arena's walls, and fades away after its third wall. Its bottom is on the floor: a full jump
//clears it, and so does standing on a side platform
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="NORMAL"
image_speed=0
image_index=irandom_range(0,2)
image_xscale=0.6
image_yscale=0.6
owner=noone
prog=0
t=0
rollSpd=2.6
xVel=0
yVel=0
hits=0
