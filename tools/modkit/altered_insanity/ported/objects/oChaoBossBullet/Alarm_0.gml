///Set special parameters
atkPower = 1
colorList = ds_list_create()
if explodeLevel > 0
{
    explosionPower = 100 + (50 * explodeLevel)
    explosionSize = 0.7 + (0.1 * explodeLevel)
    atkPower -= 50 - (20 * explodeLevel)
    for (i=0; i<explodeLevel; i+=1)
    {
        ds_list_add(colorList, c_red)
    };
    
    
}
if bounceLevel > 0
{
    maxBounces = 2 + 1*bounceLevel
    for (i=0; i<bounceLevel; i+=1)
    {
        ds_list_add(colorList, c_blue)
    };
}
if homeLevel > 0
{
    maxTurnAngle = 3 + (2 * homeLevel)
    for (i=0; i<bounceLevel; i+=1)
    {
        ds_list_add(colorList, c_green)
    };
}
if splitLevel > 0
{
    maxSplits = 1 + 1* splitLevel
    atkPower -= 10 + (10 * splitLevel)
    //alarm[1] = 18 - (2 * splitLevel)
    alarm[1] = (18 - (2 * splitLevel))/gDeltaTime //60fps change: alarms count frames
    
    for (i=0; i<splitLevel; i+=1)
    {
        ds_list_add(colorList, c_yellow)
    };
}

   


if ds_list_size(colorList) = 1
{
    blend[0] = ds_list_find_value(colorList,0)
}
if ds_list_size(colorList) = 2
{
    blend[1] = ds_list_find_value(colorList,1)
}
if ds_list_size(colorList) = 3
{
    blend[2] = ds_list_find_value(colorList,2)
}

ds_list_destroy(colorList)
