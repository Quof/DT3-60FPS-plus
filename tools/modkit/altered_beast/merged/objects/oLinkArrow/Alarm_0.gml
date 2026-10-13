atkPower=round(atkPower*exPwr)
//var bodge
//if gDeltaTime == 1
//{
//  bodge = 0
//}
//else
//{
//  bodge = global.arrowSpeedBodge
//}
//bulletSpeed=12+(attackCharge/5)+bodge
bulletSpeed=12+(attackCharge/5) //60fps change: no speed bodge needed now that the arrow turns once per 30fps tick (the +0.75 made arrows fly 20+px further than at 30fps)
