//Seeker Orb
event_inherited()
image_speed=0.33
image_alpha=1

//Enemy base statistics
bShowHealthBar=false
bShowDamage=false
bCanTakeDamage=false
bCanDealDamage=false
damageType="ELEMENTAL"
size=2
atkTime=0
currHspd=0
currVspd=0
rotDir=0
moveMag=0

if !variable_local_exists("delay")
    delay=60
pause=delay
for(i=0;i<delay;i+=1) {Xtrail[i]=0; Ytrail[i]=0}

myGrapplePoint=instance_create(x,y,oStrikeChainPoint)
myGrapplePoint.visible=0

image_blend=make_color_rgb(39,201,109)

eName="Your Best Friend"
eLevel=64
maxLife=1
life=maxLife
pointWorth=0
atkPower=0
baseItemChance=0
pickupDropMod=0
moneyWorth=0
affiliation=4

jeremyText="This isn't really an enemy, it has no way to damage you. It just follows you around. If it bothers you, you can always destry it with an explosive type weapon."
chaoText="Jeremy neglected to mention that you can grapple this thing. It'll keep moving even when you're on it. Due to its behaviour, staying on it will force it to loop until you jump off."
devText="Grappling wind orbs or Rocketeers just didn't work out in early distorted versions. To have a chance of making decent gampeplay, the movements of whatever you're trying to grapple need to be both predictable and manipulable. So now this exists."
devText+="#Make sure you don't accidentally break them and make the room unwinnable :^)"
