// manipulate lockon array with creation code if necessary
if variable_local_exists("new_rotSpd")
    rotSpd=new_rotSpd
if variable_local_exists("new_rotTime")
    rotTime=new_rotTime
if variable_local_exists("onlyTarget")
{
    maxTargets=1
    targets[0]=onlyTarget
}

//consider making it die after one hit; if so, need one more in DOOM CoDM (inside the big hex ring)
