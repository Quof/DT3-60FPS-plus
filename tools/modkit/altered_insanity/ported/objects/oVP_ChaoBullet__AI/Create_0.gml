event_inherited()

damageType="SHOT"
weaponTag=120
if room = rAbomF
{
atkPower=15*(1+oIdentifier.grazePercent)
}
else
{
    atkPower = 100
}
global.recAtkNum+=1
stunTime=1

_speed=0
_direction=0

maxSpeed = 12
