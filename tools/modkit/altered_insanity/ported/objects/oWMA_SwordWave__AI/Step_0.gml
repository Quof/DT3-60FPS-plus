if global.gamePaused=false
{
  var tA,tMul;
  if warTarget.DIFFICULTY=1 {tA=-0.1} else {tA=-0.2}
  //(the mod: 4 times as fast, and fading half as fast, while playing as character 3)
  if (global.activeCharacter!=3) {tMul=1} else {tMul=4}
  if gDeltaTime!=1 {moveSpd=scrTickAcc(moveSpd,tA,0)} //moves (copies the speed) first, then changes it: above 30fps the tick's change is spread before the move (scrTickAcc, scrTickAccBPre)
  //speed=moveSpd (character 3: speed=moveSpd*4)
  _speed=(moveSpd+scrTickAccBPre(0))*tMul //60fps change: _speed (correctSpeedDirection below), each 30fps tick at the speed it started with
  if gDeltaTime==1 {moveSpd+=tA}
  //image_alpha-=0.075 (character 3: image_alpha-=0.0375)
  if (global.activeCharacter!=3) {image_alpha-=0.075*gDeltaTime} //60fps change: per frame
  else {image_alpha-=0.0375*gDeltaTime} //60fps change: per frame
  if image_alpha<=0.3 {bCanDealDamage=0}
  if image_alpha<=0 {instance_destroy()}
}
else {_speed=0}

correctSpeedDirection(self)
