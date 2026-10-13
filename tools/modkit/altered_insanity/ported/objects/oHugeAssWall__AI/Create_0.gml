event_inherited()
bCanDealDamage=false

//Enemy base statistics
eName="Huge Ass Wall"
eLevel=28
maxLife=1400
life=maxLife
pointWorth=80
atkPower=8
resType[0]=1
resType[1]=1
stunResist=50
affiliation=7
dieSound=0
dieEffect=0
gunShot=10
gunDelay=60

jeremyText="The wall itself doesn't do anything aside from get in the way. Once you take down those turrets though, its weak point will slowly fire bullets toward you. Huh, they also don't spawn if you enter the map from the right side of them."
chaoText="This is from Contra 3. They would block your path... I don't know what else to really say about them.#Oh right! If you come from the right, they won't appear."
devText="The Rayman and Contra 3 sprites going together didn't look as bad as I thought it would. I expected it to look really bad and was kinda going for it to look horrible."
extraInfo="Gets in the way."

deathAnim=0

if room = rC5_NoWalk15
{
  myTurretA=0
  myTurretB=0
  mySolid=0
}

alarm[0]=1
