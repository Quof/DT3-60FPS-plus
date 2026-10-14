event_inherited()
makeActive()
setCollisionBounds(-6,-14,6,-1)
image_speed=0.2

//Enemy base statistics
eName="Octorok"
eLevel=7
maxLife=125
life=maxLife
pointWorth=9
atkPower=4
resType[1]=5
resType[2]=4
baseItemChance=50
affiliation=2
hitSound=global.snd_EnemyHitZelda
dieSound=3
dieEffect=3

shootTime=0
shootDelay=55

alarm[0]=1

jeremyText="Stays in one place and hops. Once it reaches the height of it's short hop, it fires off a rock. Some of these even moved around. Ugh, this game gave me nightmares."
chaoText="Ever noticed how Octoroks are vastly different from game to game a lot of times?"
devText="Ideas for the early distorted areas were hard to come by because the player's options are so limited. Beefing up some of these guys is one of those ideas. It's not a game changer, but I do think it's neat."

if room=rLink2_CaveP_B1
{
    resType[0]=1
    resType[1]=1
    resType[2]=1
    resType[3]=1
    resType[4]=1
    resType[5]=1
    sprite_index=sOctorokBlue
    jeremyText="Blue Octoroks are invincible. Don't ask why, they just are."
} //spsp
