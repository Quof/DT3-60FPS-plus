if (other.bCanHitSwitch=1 or other.weaponTag=21 or other.weaponTag=51) and hit=0//excludes sword wave, includes birds and chainsaws
{
    event_inherited()
    playSound(global.snd_RBSwitch,0,1,1)
    hit=1
}
