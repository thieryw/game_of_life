package display is

        type grid is array(1..50,1..100) of boolean ;

        screen : grid ;

        procedure render(screen : grid) ;

end display ;

        
