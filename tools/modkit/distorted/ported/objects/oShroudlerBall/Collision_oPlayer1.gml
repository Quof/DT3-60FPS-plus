//if instance_exists(oREX)
if instance_exists(oREX) and gDeltaDoTicks //60fps change: once per 30fps tick (this event runs every frame the ball touches the player, and it passes through)
{
    oREX.life+=oREX.maxLife/30
}
event_inherited()
