if distance_to_object(oIdentifier) < 5 and transformStyle = 0 and decayTime > 3
{
    //summon the quad
    tQuad = instance_create(x-11,y-11,oChaoChoiceQuadrent)
    tQuad.transformStyle = 2
    tQuad.transformColor = 1
    tQuad.targetCircleID = id
    
    tQuad = instance_create(x+11,y-11,oChaoChoiceQuadrent)
    tQuad.transformStyle = 2
    tQuad.transformColor = 2
    tQuad.targetCircleID = id
    tQuad.image_angle = 270
    
    tQuad = instance_create(x-11,y+11,oChaoChoiceQuadrent)
    tQuad.transformStyle = 2
    tQuad.transformColor = 3
    tQuad.targetCircleID = id
    tQuad.image_angle = 90
    
    tQuad = instance_create(x+11,y+11,oChaoChoiceQuadrent)
    tQuad.transformStyle = 2
    tQuad.transformColor = 4
    tQuad.targetCircleID = id
    tQuad.image_angle = 180
}
