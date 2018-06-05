with ada.text_io,ada.integer_text_io ;
use ada.text_io ;

package body display is

        procedure render(screen : grid) is

                --Clear screen character for UNIX
                procedure clear_screen is
                begin
                        ada.text_io.put(ASCII.ESC & "[2J") ;
                end clear_screen ;

                screen_buffer : string(1..((screen'length(1) + 2) * (screen'length(2) + 2) + (screen'length(1) + 2))) ;
                buffer_index : integer := 1 ;

        begin

                for i in screen'first(1)-1..screen'last(1)+1 loop

                        for j in screen'first(2)-1..screen'last(2)+1 loop

                                if 
                                        i = screen'first(1)-1 
                                        or 
                                        i = screen'last(1)+1 then
                                        screen_buffer(buffer_index) := '-' ;
                                elsif 
                                        j = screen'first(2)-1 
                                        or 
                                        j = screen'last(2)+1 
                                then 
                                        screen_buffer(buffer_index) := ('|') ;
                                else
                                        if screen(i,j) = true then

                                                screen_buffer(buffer_index) := ('#') ;

                                        else

                                                screen_buffer(buffer_index) := (' ') ;

                                        end if ;

                                end if ;

                                buffer_index := buffer_index + 1 ;

                        end loop ;

                        screen_buffer(buffer_index) := character'val(10) ;

                        buffer_index := buffer_index+1 ;


                end loop ;

                clear_screen ;

                put(screen_buffer) ;


        end render ;


end display ;
