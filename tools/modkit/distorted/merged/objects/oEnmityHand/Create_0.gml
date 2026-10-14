event_inherited()
bCanTakeDamage=true //false
bActive=true //spsp ns, allows hands to get hit
image_speed=0

//Enemy base statistics
eName="Enmity Hand"
eLevel=14
maxLife=2500
life=maxLife
dead=maxLife/2 //spsp ns
atkPower=5
bIsBoss=false //true
bNoBonus=true

resType[0]=2
resType[1]=4
resType[2]=4
resType[3]=3
resType[4]=3
resType[5]=3

atkProg=0
atkTime=250+irandom(150)
atkDelay=460
moveSpd=1

reviveFull=300
reviveTime=0

ceilingAtk=0

jeremyText="Stunning the hands will also lower the boss's melee resist. These will go through a sequence with tracking you from the side and attacking from there. Afterwards, it will perform a few attacks from the ceiling and then repeat this process."
chaoText="A bit before the hand is ready to attack, it will start to close its fist. Look for that sign to start guiding the hand to a more optimal position for yourself.#Eww... I'm starting to word things in Jeremy's style."
devText="I love encounters with multiple parts. The tricky part for me when designing them is keeping the battle frantic, even after destroying multiple parts. The player still needs to be rewarded for doing what is expected of them though. Typically, when a weaker part is destroyed, a slight boost in other attributes for the opponent occurs, which is never as beneficial for the opponent as the missing part."
