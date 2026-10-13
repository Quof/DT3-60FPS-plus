if distance_to_object(oIdentifier) < 5
{
    if transformStyle!=3 and transformColor != 1
    {
        if transformStyle = 0
        {
            //summon the quad
            tQuad = instance_create(x-11,y-11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 1
            tQuad.transformColor = 1
            tQuad.targetCircleID = id
            
            tQuad = instance_create(x+11,y-11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 1
            tQuad.transformColor = 2
            tQuad.targetCircleID = id
            tQuad.image_angle = 270
            
            tQuad = instance_create(x-11,y+11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 1
            tQuad.transformColor = 3
            tQuad.targetCircleID = id
            tQuad.image_angle = 90
            
            tQuad = instance_create(x+11,y+11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 1
            tQuad.transformColor = 4
            tQuad.targetCircleID = id
            tQuad.image_angle = 180
        }
        
        else if transformStyle = 1
        {
            //summon the quad
            tQuad = instance_create(x-11,y-11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 3
            tQuad.transformColor = 1
            tQuad.targetCircleID = id
            
            tQuad = instance_create(x+11,y-11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 3
            tQuad.transformColor = 2
            tQuad.targetCircleID = id
            tQuad.image_angle = 270
            
            tQuad = instance_create(x-11,y+11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 3
            tQuad.transformColor = 3
            tQuad.targetCircleID = id
            tQuad.image_angle = 90
            
            tQuad = instance_create(x+11,y+11,oChaoChoiceQuadrent)
            tQuad.transformStyle = 3
            tQuad.transformColor = 4
            tQuad.targetCircleID = id
            tQuad.image_angle = 180
        }
    }
    /*if (bulletColor3 = 0) and (transformStyle = 0 or transformStyle = 4)
    {
        //summon the bullet ring
        tQuad = instance_create(x-32, y-16,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 1
        tQuad.targetCircleID = id
        
        tQuad = instance_create(x-16, y-32,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 2
        tQuad.targetCircleID = id
        
        tQuad = instance_create(x+16, y-32,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 3
        tQuad.targetCircleID = id
        tQuad.image_angle = 180
        
        tQuad = instance_create(x+32, y-16,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 4
        tQuad.targetCircleID = id
        tQuad.image_angle = 180
        
        tQuad = instance_create(x-32, y+16,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 5
        tQuad.targetCircleID = id
        
        tQuad = instance_create(x-16, y+32,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 6
        tQuad.targetCircleID = id
        
        tQuad = instance_create(x+16, y+32,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 7
        tQuad.targetCircleID = id
        tQuad.image_angle = 180
        
        tQuad = instance_create(x+32, y+16,oChaoChoiceQuadrent)
        tQuad.sprite_index = oChaoBullet
        tQuad.transformStyle = 4
        tQuad.transformColor = 8
        tQuad.targetCircleID = id
        tQuad.image_angle = 180
    }*/
}
