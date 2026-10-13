if dashMomentumTime > 0
{
    tAlterDash=0
    if global.alterEquip=1
    {
        if global.activeCharacter=0
        {
          for(i=0;i<3;i+=1)
            if global.equipJerry[i]=6
              tAlterDash=1
        }
        else
        {
          for(i=0;i<3;i+=1)
            if global.equipClaire[i]=6
              tAlterDash=1
        }
    }
    if (tAlterDash=1)
    {
        //Re-enable air dash
        if oPlayer1.canAirDash=0 {oHUD.airDashScl=3}
          oPlayer1.canAirDash=1
          
          //Re-enable double jump
        if oPlayer1.doubleJumpCheck=0 {oHUD.doubleJumpScl=2}
          oPlayer1.doubleJumpCheck=1
        pMoveGravDash()
    }
}
