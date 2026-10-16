//Evil Boss Gallery: the gate between the Boss Gallery and the Evil Boss Gallery, at the end of the entrance's floor (the
//mod's patch puts it in rBossGallery, the build in rEvgGallery, at the same place: the two rooms have the same layout).
//Its sprite is the door's place (16x32, as a gallery door's); it draws a dark arch over it (sEvgGateArch: the gallery's
//own arch, in dark crimson) and a swirl in the arch (sEvgPortal). Up at it goes to the other gallery, in front of its gate
arrowX=x+8
arrowY=y-24
pointTime=0
activateTime=20
glowT=0
if room=rEvgGallery {toGallery=rBossGallery; gateName="BOSS GALLERY"}
else {toGallery=rEvgGallery; gateName="EVIL BOSS GALLERY"}
