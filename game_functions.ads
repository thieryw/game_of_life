with game_types,ada.text_io ;
use ada.text_io ;


package game_functions is

        function initialize_cells return game_types.array_of_cell ;
        procedure render_game(cells : game_types.array_of_cell) ;
        function evolve_cells(cells : game_types.array_of_cell) return game_types.array_of_cell ;

end game_functions ;
