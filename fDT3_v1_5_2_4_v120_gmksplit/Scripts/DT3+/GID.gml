/* !scriptId=203 */
var id = ds_map_find_value(global.ObjectIDMap, argument0)
if(is_undefined(id))
{
    return noone;
}
else
{
    return id;
}
