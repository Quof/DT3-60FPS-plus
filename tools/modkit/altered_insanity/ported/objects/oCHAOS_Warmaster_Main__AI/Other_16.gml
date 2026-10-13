///DECISION MAKING
if ATTACK_FORM=1 //======================================== MAIN FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<100 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=4}
        else {currentAttack=1}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=4}
        else {currentAttack=1}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=6; superCharge=0}
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=3
        }
        else //Player is attacking
        {
          if superCharge<superMax {currentAttack=3}
          else {currentAttack=6; superCharge=0}
        }
      }
    }
  }
  else if atkNum>=1 //----- Second and third attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<100 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=6; superCharge=0}
        }
      }
      else //Player is attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else {currentAttack=4}
      }
    }
    else //-- Player is far --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=4}
        else {currentAttack=1}
      }
      else //Player is attacking
      {
        if atkInSequence mod 2=0 {currentAttack=3}
        else
        {
          if superCharge<superMax {currentAttack=3}
          else {currentAttack=6; superCharge=0}
        }
      }
    }
  }
}
else if ATTACK_FORM=2 //======================================== FIRE FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if atkInSequence mod 2=0 {currentAttack=1}
        else
        {
          if superCharge<superMax {currentAttack=6}
          else {currentAttack=2; superCharge=0}
        }
      }
      else //Player is attacking
      {
        if atkInSequence=1
        {
          if superCharge<superMax {currentAttack=1}
          else {currentAttack=2; superCharge=0}
        }
        else {currentAttack=1}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=3
        }
        else //Player is attacking
        {
          currentAttack=6
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=4
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if superCharge<superMax
        {
          if atkInSequence=1 {currentAttack=6}
          else {currentAttack=3}
        }
        else {currentAttack=2; superCharge=0}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=1}
        else {currentAttack=4}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=5
        }
        else //Player is attacking
        {
          currentAttack=1
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          if superCharge<superMax {currentAttack=6}
          else {currentAttack=2; superCharge=0}
        }
        else //Player is attacking
        {
          currentAttack=5
        }
      }
    }
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,0,oPlayer1.x,0)<120 //-- Player is close --
    {
      if oPlayer1.attackState=0 //Player is not attacking
      {
        if superCharge<superMax
        {
          if atkInSequence=1 {currentAttack=3}
          else {currentAttack=6}
        }
        else {currentAttack=2; superCharge=0}
      }
      else //Player is attacking
      {
        if atkInSequence=1 {currentAttack=5}
        else {currentAttack=6}
      }
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=2
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=5
        }
        else //Player is attacking
        {
          currentAttack=6
        }
      }
      else
      {
        if oPlayer1.attackState=0 //Player is not attacking
        {
          currentAttack=4
        }
        else //Player is attacking
        {
          currentAttack=3
        }
      }
    }
  }
}
else if ATTACK_FORM=3 //======================================== ICE FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if hoverMode=0 {currentAttack=3}
        else {currentAttack=6}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=6}
        else {currentAttack=7}
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=6}
        else {currentAttack=5}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=9}
        else {currentAttack=6}
      }
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB) {currentAttack=5}
        else {currentAttack=1; superCharge=0}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2 {currentAttack=7}
        else {currentAttack=9}
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1
      {
        if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB)
        {
          if atkInSequence=0 or atkInSequence=2 {currentAttack=9}
          else {currentAttack=5}
        }
        else {currentAttack=1; superCharge=0}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if hoverMode=1
          {
            if numOfAtks>=3 {currentAttack=2}
            else {currentAttack=5}
          }
          else {currentAttack=6}
        }
        else
        {
          if hoverMode=0 {currentAttack=3}
          else {currentAttack=7}
        }
      }
    }
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<132 //-- Player is close --
    {
      if numOfAtks<=1
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=6}
        else {currentAttack=5}
      }
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if hoverMode=0 {currentAttack=3}
          else {currentAttack=6}
        }
        else
        {
          if hoverMode=1
          {
            if numOfAtks>=3 {currentAttack=2}
            else {currentAttack=5}
          }
          else {currentAttack=7}
        }
      }
    }
    else //-- Player is far --
    {
      if numOfAtks<=1 {currentAttack=6}
      else
      {
        if atkInSequence=0 or atkInSequence=2
        {
          if superCharge<superMax or instance_exists(oWMC_IceHoverA) or instance_exists(oWMC_IceHoverB) {currentAttack=9}
          else {currentAttack=1; superCharge=0}
        }
        else {currentAttack=9}
      }
    }
  }

  if currentAttack!=1 //Change from ground to hover or vice versa (Orbiting ice must not have been chosen)
  {
    if hoverMode=0 //To hover mode
    {
      if shiftType=2 {if numOfAtks>=1 {currentAttack=8; numOfAtks=0}}
      else
      {
        if ATTACK_SPEED=3 {if numOfAtks>=2 {currentAttack=8; numOfAtks=0}}
        else {if numOfAtks>=3 {currentAttack=8; numOfAtks=0}}
      }
    }
    else //To ground mode
    {
      if numOfAtks>=6 {currentAttack=4; numOfAtks=0}
    }
  }
}
else if ATTACK_FORM=4 //======================================== WIND FORM ========================================
{
  if atkNum=0 //----- First attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=6}
      else {currentAttack=2}
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=1}
      else {currentAttack=4}
    }
  }
  else if atkNum=1 //----- Second attack -----
  {
    if superCharge<superMax
    {
      if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=3}
        else {currentAttack=4}
      }
      else //-- Player is far --
      {
        if atkInSequence=0 or atkInSequence=1 {currentAttack=2}
        else {currentAttack=6}
      }
    }
    else {currentAttack=9; superCharge=0}
  }
  else if atkNum>=2 //----- Third attack -----
  {
    if point_distance(x,y-29,oPlayer1.x,returnPlayerYCenter())<128 //-- Player is close --
    {
      if atkInSequence=0 or atkInSequence=1 {currentAttack=1}
      else {currentAttack=3}
    }
    else //-- Player is far --
    {
      if atkInSequence=0 or atkInSequence=1
      {
        if oPlayer1.attackState=0 {currentAttack=4}
        else {currentAttack=3}
      }
      else {currentAttack=2}
    }
  }
}
