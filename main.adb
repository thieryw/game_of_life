with ada.text_io,ada.integer_text_io,game_types,game_functions,display,ada.calendar ;
use ada.text_io ;


procedure main is
        
        cells : game_types.array_of_cell ;

        f : file_type ;

begin

        

        cells := game_functions.initialize_cells ;



        loop

                game_functions.render_game(cells) ;
                cells := game_functions.evolve_cells(cells) ;


                delay 1.0 ;


        end loop ;



end main ;
