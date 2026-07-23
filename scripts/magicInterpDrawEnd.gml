__maginterp_entry_count -= 1
if __maginterp_entry_count == 0
{
    if !variable_local_exists("__maginterp_x")
        return 0

    x -= __maginterp_x_off
    y -= __maginterp_y_off
}
