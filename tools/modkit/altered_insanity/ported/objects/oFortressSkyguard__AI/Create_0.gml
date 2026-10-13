event_inherited()
image_xscale=-1
bShowHealthBar=false
oHUD.dragoonBossCheck=1
oHUD.enemyCheckID=id
bActive=1

//Enemy base statistics
eName="Fortress Skyguard"
eLevel=38
maxLife=1300
life=maxLife
atkPower=12
bIsBoss=true
bNoBonus=true
affiliation=7
dieEffect=0
weaponGive=300
bossProgress=0
activateBoss=0
myLives=1

moveBehavior=0
moveProg=0
otherUse=0
atkTimeA=100; atkDirA=0; atkExtA=0; atkStuffA=0
atkTimeB=0; atkDirB=0; atkExtB=20; atkStuffB=0
atkTimeC=0; atkDirC=0; atkExtC=0; atkStuffC=0

deathAnim=0

segmentProg=0
segmentTime=0
segSideGunX=-17
segSideGunY=-16
segFrontGuardX=0
segFrontGuardY=0
segFrontGunX=0
segFrontGunY=32
segWingsX=0
segWingsY=0
segWingsAngle=0

jeremyText="This thing cannot be eaten, sadly. As for its attack patterns, it seems to be borrowing heavily from bullet hell games."
chaoText="I've got nothing to share on this thing since it has no data to look at for your eating ability."
devText="N/A"

if (global.challengeRoom = 9)
{
    jeremyText="Wow. Good luck fighting this guy without the ship!"
    chaoText="This was hard enough to dodge with a small shmup hitbox, how can you dodge any of this now???"
    devText="I'm honestly suprised our buddy G.A.F. just works without any finagling here. Enjoy :)"
    resType[4]=2
}
