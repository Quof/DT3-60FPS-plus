event_inherited()

damageType="TRUE"
weaponTag=100
atkPower=50
bulletSpeed=14
_speed=14
stunTime=1
bCanPierce=1
_direction=0
_speed=0
_hspeed=0
_vspeed=0

if global.alterEquip=1 and (room=rWarshipZ_E2 or room=rWarshipZ_E3 or room=rBT_WarmasterA)
    {

          for(i=0;i<3;i+=1)
            if global.equipJerry[i]=22
              atkPower=100

          for(i=0;i<3;i+=1)
            if global.equipClaire[i]=22
              atkPower=100

    }
