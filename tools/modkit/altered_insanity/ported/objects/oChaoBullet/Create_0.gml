event_inherited()

damageType="SHOT"
weaponTag=120
if global.inBossChallenge = 0
{
    atkPower=15*(1+oIdentifier.grazePercent)
}
else
{
    atkPower = 100
}
global.recAtkNum+=1
stunTime=1

maxSpeed = 12
_speed=0 //60fps change (added): moves by _speed/_direction (correctSpeedDirection in the step); whoever makes it sets _direction
_direction=0

explodeLevel = 0 //exploding bullets, explode on contact with terrain (not enemy) explosion is more powerful than bullet
bounceLevel = 0 //bouncing bullets, bounce off walls, growing more powerful each time
homeLevel = 0 //homing bullets, homes in on enemies
splitLevel = 0 //split bullets, splits after a second
meleeLevel = 0 //melee bullets, short range high damage
shieldLevel = 0 //shield bullets, very weak bullets that delete enemy projectiles

arcLevel = 0 //thunder arc, aoe elec pulse every so often


explosionPower = 0 //100+50 per level
explosionSize = 0 //0.7+0.1 per level

maxBounces = 0 //1+2 per level

maxTurnAngle = 0

maxSplits = 0 //1+1 per level
splitTime = 0 //35 - 5 per level

alarm[0] = 1

blend[0] = c_white
blend[1] = c_white
blend[2] = c_white
