with display ;


package game_types is




        type cell is (DEAD,ALIVE) ;

        type array_of_cell is array(display.screen'range(1),display.screen'range(2)) of cell ;

        type coordinates is
                record
                        x : integer := display.screen'length(1) ;
                        y : integer := display.screen'length(2) ;
                end record ;
        

        
end game_types ;
