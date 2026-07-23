if (ds_map_exists(global.objectIDMap, argument0))
{
    return ds_map_find_value(global.objectIDMap, argument0);
}
else
{
    return noone;
}
