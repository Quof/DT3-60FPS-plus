if dashInvulnerabilityTime > 0
{
    if global.alterEquip=1
    {
         if global.activeCharacter=0
         {
           for(i=0;i<3;i+=1)
           {
             if global.equipJerry[i]=25
             {
                oPlayer1.bloodlust=1
             }
           }    
         }
         else
         {
           for(i=0;i<3;i+=1)
           {
             if global.equipClaire[i]=25
             {
                oPlayer1.bloodlust=1
             }
           }  
         }
     }
 }
