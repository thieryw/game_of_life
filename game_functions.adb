with ada.text_io,ada.integer_text_io,display,game_types ;

use ada.text_io,game_types ;




package body game_functions is


        function initialize_cells return game_types.array_of_cell is
                cells : game_types.array_of_cell := (others => (others => game_types.DEAD)) ;
                initial_coordonates : game_types.coordinates := (x => 25, y => 50) ;
                begining_of_line : integer ;
                c : character ;
                f : file_type ;

        begin
                open(f,in_file,"cells.life") ;
                begining_of_line := initial_coordonates.y ;

                while not end_of_file(f) loop
                        get(f,c) ;

                        --if end_of_line(f) then
                        --        skip_line(f);
                        --end if;


                        if c = '#' then
                                skip_line(f) ;
                        else

                                if c = '*' then
                                        cells(initial_coordonates.x,initial_coordonates.y) := game_types.ALIVE ;
                                end if ;

                                initial_coordonates.y := initial_coordonates.y + 1 ;

                                if end_of_line(f) then

                                        initial_coordonates.x := initial_coordonates.x + 1 ;
                                        initial_coordonates.y := begining_of_line ;

                                end if ;
                        end if ;

                end loop ;

                close(f) ;

                return cells ;


        end initialize_cells ;



        function evolve_cells(cells : game_types.array_of_cell) return game_types.array_of_cell is
                function is_on_screen_frontier(i,j : integer) return boolean is

                begin
                        if i = display.screen'first(1) or

                                i = display.screen'last(1) or

                                j = display.screen'first(2) or

                                j = display.screen'last(2) 
                        then
                                return true ;
                        else
                                return false ;
                        end if ;


                end is_on_screen_frontier ;


                function get_live_neighbour_count(cells : game_types.array_of_cell ; i,j : integer) return integer is
                        count : integer := 0 ;
                begin
                        if not is_on_screen_frontier(i,j) then

                                for k in i-1..i+1 loop
                                        for l in j-1..j+1 loop
                                                if k /= i or l /= j then
                                                        if cells(k,l) = ALIVE then
                                                                count := count + 1 ;
                                                        end if;
                                                end if ;
                                        end loop ;
                                end loop ;


                        end if ;


                        return count ;

                end get_live_neighbour_count ;

                procedure compute_next_cell_state(i,j : integer ; cells : game_types.array_of_cell ; new_cells : in out game_types.array_of_cell) is
                        count : integer ;

                begin
                        count := get_live_neighbour_count(cells,i,j) ;

                        if cells(i,j) = ALIVE then 
                                if count < 2 or count > 3 then
                                        new_cells(i,j) := DEAD ;
                                elsif count = 2 or count = 3 then
                                        new_cells(i,j) := ALIVE ;
                                end if ;
                        elsif cells(i,j) = DEAD then 
                                if count = 3 then
                                        new_cells(i,j) := ALIVE ;
                                end if ;

                        end if ;

                end compute_next_cell_state ;

                new_cells : game_types.array_of_cell := (others => (others => DEAD)) ;

        begin

                for i in cells'range(1) loop
                        for j in cells'range(2) loop 

                                compute_next_cell_state(i,j,cells,new_cells) ;

                        end loop ;
                end loop ;

                return new_cells ;




        end evolve_cells ;





        procedure render_game(cells : game_types.array_of_cell) is 
                screen : display.grid := (others => (others => false)) ;

        begin
                for i in cells'range(1) loop 
                        for j in cells'range(2) loop 

                                if cells(i,j) = game_types.ALIVE then
                                        screen(i,j) := true ;
                                end if ;

                        end loop ;
                end loop ;

                display.render(screen) ;

        end render_game ; 





end game_functions ;
