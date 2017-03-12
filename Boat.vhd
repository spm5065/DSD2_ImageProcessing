----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:08:52 03/05/2014 
-- Design Name: 
-- Module Name:    LenaNoise - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library STD;
use STD.textio.all;
library IEEE;
use IEEE.all;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_textio.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;0
--use UNISIM.VComponents.all;00000000

entity Boat is
generic (max_row 				: integer := 512;
			max_col 				: integer := 512;
			percentagelow  	: integer := 3;
			percentagehigh 	: integer := 3);

end Boat;

architecture Behavioral of Boat is
file		infile			: text open read_mode is "Boat.pgm"; 	--file to read
file		testfile			: text open write_mode is "BoatOutTest.pgm"; 
file		bout	: text open write_mode is "BoatOut.pgm"; 	--file to write


type histarray  is array(0 to 255) of integer;
type twodarray is array(1 to 512, 1 to 512) of integer;

shared variable hist : histarray:=(others=>0);
shared variable twodray : twodarray;
shared variable magic, comment, DIM, max : line;
shared variable done,done2,complete           : boolean := false;
shared variable glow,ghigh     : integer:=0;
signal hi:std_logic:='0';
begin
		
	Process
		variable inline 	      : line;								--line
		variable outline	      : line;
		variable value        	: integer;
		variable index		       : integer;
		variable status        : boolean;
    
		begin
		  
			readline(infile,magic);
--			writeline(testfile,magic);
			readline(infile,comment);
--			writeline(testfile,comment);
			readline(infile,DIM);
--			writeline(testfile,DIM);
			readline(infile,max);
--			writeline(testfile,max);
			while(not(endfile(infile))) loop
				for row in 1 to 512 loop
					for col in 1 to 512 loop
						read(inline, value, status);
						--write(outline, value);
						if status=false then
						    readline(infile,inline);
						    read(inline,value);
						    --write(outline, value);
						end if;
						twodray(row,col) := value;
						hist(value) := hist(value) + 1;
						end loop;
					end loop;
				end loop;
				done := true;
			   wait;
	end process;
	process
	  variable numneed :integer:= Conv_integer(262144*percentagelow/100);
	  variable numhave :integer:= 0;
	  variable cur     :integer:= -1;
	  begin
	    wait for 1 ns;
	    while numneed>numhave and done=true loop
	      cur := cur + 1;
	      numhave := numhave + hist(cur);
	    end loop;
	    glow := cur;
	    cur := 256;
	    numhave := 0;
	    while numneed>numhave loop
	      cur := cur - 1;
	      numhave := numhave + hist(cur);
	    end loop;
	    ghigh := cur;
	    for row in 1 to 512 loop
	     for col in 1 to 512 loop   
    	     if(twodray(row,col)>= ghigh) then
    	       twodray(row,col):= 255;
    	     elsif (twodray(row,col)<= glow) then
    	       twodray(row,col):= 0;
    	     else
    	       twodray(row,col):= (255*(twodray(row,col)-glow)/(ghigh-glow));
    	     end if;
	     end loop;
	   end loop;
	   done2:= true;
	   wait;
	 end process; 
	 
	 process
	   variable linewr : integer := 0;
	   variable lout : line;
	   begin
	     wait for 10 ns;
	     writeline(bout,magic);
			 writeline(bout,comment);
			 writeline(bout,DIM);
			 writeline(bout,max);
	     
	     for row in 1 to 512 loop
	       for col in 1 to 512 loop
			     linewr := linewr +1;
			  if linewr >= 20 then
			    linewr := 0;
			    writeline(bout,lout);
			  end if;
			  write(lout,twodray(row,col));
			  write(lout,' ');
			  end loop;
			end loop;
			writeline(bout,lout);  
		  complete := true;
		  wait;
		  end process;	 
end Behavioral;

