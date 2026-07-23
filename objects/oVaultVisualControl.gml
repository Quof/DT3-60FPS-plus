#define Create_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
instance_create(0,0,oVaultBlackFadeDown)
instance_create(0,0,oVaultTrailManager)

lightballTime=irandom(120)
binaryTime=300+irandom(210)
#define Step_0
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
if !instance_exists(oVaultLightball)
{
  lightballTime+=1
  if lightballTime>=240
  {
    var tNewBall,tXPos,tYPos,tPosYSet;
    tXPos=view_xview[0]+random(480)
    tPosYSet=choose(1,2)
    if tPosYSet=1 {tYPos=view_yview[0]-32}
    else {tYPos=view_yview[0]+384}
    tNewBall=instance_create(tXPos,tYPos,oVaultLightball)
    if tPosYSet=1
    {
      if tXPos<oPlayer1.x {tNewBall.direction=315}
      else {tNewBall.direction=225}
    }
    else
    {
      if tXPos<oPlayer1.x {tNewBall.direction=45}
      else {tNewBall.direction=135}
    }
    lightballTime=irandom(30)
  }
}

if instance_number(oVaultBackBinary)<2
{
  binaryTime+=1
  if binaryTime>=600
  {
    var tNewBinary;
    event_user(0)
    tNewBinary=instance_create(view_xview[0]+496,view_yview[0]+8+random(300),oVaultBackBinary)
    tNewBinary.binaryString=tBinaryString
    binaryTime=irandom(180)
  }
}
#define Other_10
/*"/*'/**//* YYD ACTION
lib_id=1
action_id=603
applies_to=self
*/
//Random binary message
var tRanMessage;
tRanMessage=irandom_range(1,4)
if tRanMessage=1 {tBinaryString="010001000100100101000101"} //DIE
else if tRanMessage=2 {tBinaryString="01001010011001010111001001100101011011010111100100100000011101110110100101101100011011000010000001110011011101010110011001100110011001010111001000100001"} //Jeremy will suffer!
else if tRanMessage=3 {tBinaryString="01010100011010000110100101110011001000000111011101101001011011000110110000100000011000100110010100100000011110010110111101110101011100100010000001110000011100100110100101110011011011110110111000100001"} //This will be your prison!
else if tRanMessage=4 {tBinaryString="01001010011001010111001001100101011011010111100100100000011000110111001001100101011000010111010001100101011001000010000001110100011010000110010100100000010101100110100101110010011101010111001100101110"} //Jeremy created the Virus.
