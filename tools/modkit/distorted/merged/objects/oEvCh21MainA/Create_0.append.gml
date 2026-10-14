if true and (room=rAbomD or room=rAbomE or room=rAbomF)     //spsp
{
    instance_create(oIdentifier.x,oIdentifier.y,oDHexFullRingBlue)
}
else if true and global.location=110 and room!=rDistFinal_Round3                       //spsp
{
    instance_create(oPlayer1.x,oPlayer1.y-16,oDHexFullRing)
}
