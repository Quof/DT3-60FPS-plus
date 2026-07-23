if !variable_local_exists("__maginterp_x")
{
    __maginterp_x = x
    __maginterp_y = y
    __maginterp_x_next = x
    __maginterp_y_next = y
    __maginterp_x_off = 0
    __maginterp_y_off = 0
    __maginterp_entry_count = 0
}

__maginterp_entry_count += 1
if __maginterp_entry_count == 1
{
    if gDeltaDoTicks == 1
    {
        __maginterp_x = __maginterp_x_next
        __maginterp_y = __maginterp_y_next
        __maginterp_x_next = x
        __maginterp_y_next = y
        __maginterp_x_off = 0
        __maginterp_y_off = 0
    }
    __maginterp_x_off = -(x - __maginterp_x) * (1.0 - gDeltaTick)
    __maginterp_y_off = -(y - __maginterp_y) * (1.0 - gDeltaTick)
    if gDeltaTime == 1.0 { __maginterp_x_off = 0; __maginterp_y_off = 0 }
    //if (gDeltaDoTicks == 1) __maginterp_x_off += 10

    x += __maginterp_x_off
    y += __maginterp_y_off
}
