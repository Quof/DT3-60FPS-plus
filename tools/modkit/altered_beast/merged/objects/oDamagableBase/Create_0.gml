bPlayable=false

if !variable_local_exists("_speed") {_speed=0}
if !variable_local_exists("_direction") {_direction=0}
if !variable_local_exists("_hspeed") {_hspeed=0}
if !variable_local_exists("_vspeed") {_vspeed=0}

charEnemyCreateEvent()

increaseResists=0
if global.alterEquip=1
        {
            for(i=0;i<3;i+=1)
            {
              if global.equipJerry[i]=10 {increaseResists=1}
              if global.equipClaire[i]=10 {increaseResists=1}
            }
        } 

armor = 0
hasArmor=0
if global.alterEquip=1
        {
            for(i=0;i<3;i+=1)
            {
              if global.equipJerry[i]=11 {armor = 3; hasArmor = 1}
              if global.equipClaire[i]=11 {armor = 3; hasArmor = 1}
            }
        } 
weakened=0
defense=0

if global.alterEquip=1
{
      for(i=0;i<3;i+=1)
      {
        if global.equipJerry[i]=31 {defense=25}
        if global.equipClaire[i]=31 {defense=25}
      }
}

birdKill=1
