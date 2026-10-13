event_inherited()
bCanTakeDamage=false; bCanDealDamage=false
image_alpha=0
image_xscale=2; image_yscale=2
bActive=1

//Enemy base statistics
eName="Decimator Armor"
eLevel=36
maxLife=3200
life=maxLife
pointWorth=40
atkPower=10
stunResist=50
resType[4]=5
affiliation=7
dieEffect=0

bShotReady=0
myProg=0
progTime=0
shotTime=110
shotDelay=195
shotDir=0
warnRad=0
checkHP=0
deathAnim=0

jeremyText="As the name states, it's a big piece of armor. While this is active, the Decimator is completely immune to damage. Oh yeah, watch out for those lasers."
chaoText="That regeneration I mentioned from the laser pads is slower when the armor is active. Which is good because you can't deal any damage to counter that regeneration... Oh, check this out! Every time you destroy its attachments, the Decimator takes a lot of damage. Hmm, so all you gotta do is get through its attachment phases quickly and it should fall super fast. This attachment gains half resist to NORMAL attacks at 75%."
devText="This boss is definitely set to be a fairly difficult one, as it's the barrier between this point and the final level. Lore wise, it's also CHAOS's most advanced bot at their disposal."

    if global.inBossChallenge
    {
    devText="SURPRISE! Remember when I said 'most abilities'? I took away the laser pads because you could just neuter Deci by leaving one alive until you kill CACA. Can't have that! Anyway, the laser attack from here meshes nicely with the morph ball phase from CACA, otherwise it's rough to dodge with everything else CACA can do, dispatch this quickly!"
    }
