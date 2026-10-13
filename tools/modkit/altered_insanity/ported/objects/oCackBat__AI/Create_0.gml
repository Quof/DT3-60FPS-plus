event_inherited()

//Enemy base statistics
eName="Cack Bat"
eLevel=6
maxLife=100
life=maxLife
atkPower=4
pointWorth=4
affiliation=1
inactiveDist*=1.25
dieEffect=0
jeremyText="A bat summoned by Cackletta. It will only fly across the room in a futile attempt to get in your way. Fortunately for you, they actually work against her."
chaoText="These are gross looking. Claire is right, Cackletta has no taste."
devText="When I started making the death sequence for this encounter, that's when I knew I wanted to periodically have unique death animations in DT3. Aside from the 'oh that's kinda cool' factor, it makes things a little more dramatic at times, at least I think so. Visually, DT1 was very mediocre, and since I've gotten a lot better in presenting, it was only right to take a bit of extra time and place nifty things like that in."

    if global.inBossChallenge
    {
    devText="Wow, you scanned this one too. The batter is up, don't strike out!"
    }
