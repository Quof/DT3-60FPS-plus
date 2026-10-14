if other.sprite_index=sMMXbuster3 and resType[3]>1 //spsp ns
{
    resType[3]+=1
    event_inherited()
    resType[3]-=1
}
else
{
    event_inherited()
}
