if room=rSerasFunhouse and sceneProgress=2
{
/*
+some global variable to find which version was beaten
bossRoomTally(48)
*/
    if global.currentBoss="SeraEX"
    {
        if global.ddlcBoss mod 2=0 {global.ddlcBoss+=1}
    }
    global.currentBoss=""
    global.bossTrack=0
    global.newMapX=80; global.newMapY=608; room_goto(rSanctuary)
}
/*else if room=rTeamRocket and global.gamePaused=false
{
    if sceneDelay<10 {sceneDelay+=1}
    if sceneDelay>=10 and !instance_exists(oCHAOS_Hydrateer)
    {
        global.newMapX=240; global.newMapY=496; room_goto(rSanctuary)
    }
}*/
