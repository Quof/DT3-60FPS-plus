with (oSequenceCrystalDestination)
{
    if set = other.set
    {
        other.positionsX[order] = x;
        other.positionsY[order] = y;
        instance_destroy()
    }
    if order > other.maxPosition and set = other.set
    {
        other.maxPosition = order
    }
}
