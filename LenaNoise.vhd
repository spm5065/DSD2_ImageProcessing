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

entity LenaNoise is
end LenaNoise;

architecture Behavioral of LenaNoise is
file		infile			: text open read_mode is "LenaNoise.pgm"; 	--file to read
file		infile1			: text open read_mode is "LenaNoise.pgm";
file		infile2			: text open read_mode is "LenaNoise.pgm";
file		testfile			: text open write_mode is "OutTest.pgm"; 
file		threeoutfile	: text open write_mode is "LenaNoiseOut3x.pgm"; 	--file to write
file 		fiveoutfile		: text open write_mode is "LenaNoiseOut5x.pgm";


type pixels3 is array (1 to 414720,1 to 9) of integer range 0 to 255;
type pixels5 is array (1 to 414720,1 to 25) of integer range 0 to 255;
signal txt : pixels3;
signal fxf : pixels5;
shared variable magic, comment, DIM, max : line;
shared variable done,done2,done3,complete: boolean := false;
shared	variable t : pixels3 ;             
shared variable f : pixels5 ;
signal hi:std_logic:='0';
begin
		
	Process
		variable inline 	      : line;								--line
		variable outline	      : line;
		variable value, space	: integer;
		variable index		      : integer := 0;
		variable status			: boolean := true;
		variable row				: integer := 1;
		variable col				: integer := 0;
		variable m,m1,m2:line;
		begin
		  
			readline(infile,magic);			
			writeline(testfile,magic);
			readline(infile1,magic);
			writeline(fiveoutfile,magic);
			readline(infile2,magic);			
			writeline(threeoutfile,magic);
			readline(infile,comment);			
			writeline(threeoutfile,comment);
			readline(infile1,comment);
			writeline(testfile,comment);
			readline(infile2,comment);
			writeline(fiveoutfile,comment);
			readline(infile,DIM);			
			writeline(testfile,DIM);
			readline(infile1,DIM);
			writeline(fiveoutfile,DIM);
			readline(infile2,DIM);
			writeline(threeoutfile,DIM);
			readline(infile,max);
			writeline(testfile,max);
			readline(infile1,max);			
			writeline(threeoutfile,max);
			readline(infile2,max);	
			writeline(fiveoutfile,max);
			
			while not endfile(infile) loop
				
				readline(infile,inline);
				while(status = true) loop
				read(inline, value, status);
				if status = true then
				write(outline, value);
				write(outline,' ');
				--index := index + 1;
					
						col := col + 1;
					if(col > 720) then
						row := row + 1;
						col := 1;
					end if;
						index := (720*(row-1) + col);
						if (index > 414720) then
						  done := true;
						  exit;
						end if;
						txt(index,5) <=  value;
						fxf(index,13) <=  value;
							  if (col > 1) then
								  fxf(index-1,14) <= value;
								  txt(index-1,6) <= value;
								end if;
								if (col > 2) then  
								  fxf(index-2,15) <= value;
								end if;  
								if (col <720) then  
								  fxf(index+1,12) <= value;
								  txt(index+1,4) <= value;
								end if;
								if (col <719) then  
								  fxf(index+2,11) <= value;
								end if;
							if (row>1) then
								txt(index-720,8) <=  value;
								fxf(index-720,18) <=  value;
								if (col>1) then
									txt(index-721,9) <=  value;
									fxf(index-721,19) <=  value;
								end if;	
								if (col>2) then
									fxf(index-722,20) <=  value;
								end if;
								if (col<720) then
									txt(index - 719,7) <=  value;
									fxf(index - 719,17) <=  value;
								end if;
								if (col<719) then
									fxf(index - 718,16) <=  value;
								end if;	
							end if;
							if (row > 2) then
								fxf(index-1440,23) <=  value;
								if (col > 2)then
									fxf(index-1442,25) <=  value;
								end if;
								if (col>1)  then
									fxf(index-1441,24) <=  value;
								end if;
								if (col<720)  then
									fxf(index-1439,22) <=  value;
								end if;
								if (col<719)  then
									fxf(index-1438,21) <=  value;
								end if;
							end if;
							if (row<576) then
								txt(index+720,2) <= value;
								fxf(index+720,8) <= value;
								if (col > 1) then
								  fxf(index+719,9) <= value;
								  txt(index+719,3) <= value;
								end if;
								if (col > 2) then  
								  fxf(index+718,10) <= value;
								end if;
								if (col <720) then  
								  fxf(index+721,7) <= value;
								  txt(index+721,1) <= value;
								end if;
								if (col <719) then  
								  fxf(index+722,6) <= value;
								end if;  
							end if;
							if (row<575) then
							  fxf(index+1440,3) <= value;
							  if (col > 1) then
								  fxf(index+1439,4) <= value;
								end if;
								if (col > 2) then  
								  fxf(index+1438,5) <= value;
								end if;
								if (col <720) then  
								  fxf(index+1441,2) <= value;
								end if;
								if (col <719) then  
								  fxf(index+1442,1) <= value;
								end if; 
							end if;
										  
				  		end if;
						end loop;
						
          status := true;
					writeline(testfile,outline);
					end loop;
--					txt <= (others => (others => 0));
--          fxf <= (others => (others => 0));
				writeline(testfile,outline);
				done := true;
			wait for 2 ns;	
				txt <= t;
	      fxf <= f;
	      done3 := true;
			wait;
			
	end process;
	
	process
	  variable changed : boolean := true;
	  variable temp,temp2    : integer;
	  
begin
	    while (done = true)and(done2 = false) loop
	      f := fxf;
	      t := txt;
Labl:   for Iray in 1 to 414720 loop
	       changed := true;
	       while changed = true loop
	         changed := false;
Label2:    for index in 1 to 8 loop
	           if t(Iray,index) > t(Iray,index+1) then
	             changed             := true;
	             temp                := t(Iray,index);
	             temp2               := t(Iray,index+1);	             
	             t(Iray,index)   := temp2;
	             t(Iray,index+1) := temp;
	           end if;  
	         end loop;
	       end loop; 
	       changed := true;
	       while changed = true loop
	         changed := false;
Label3:    for index in 1 to 24 loop
	           if f(Iray,index) > f(Iray,index+1) then
	             changed             := true;
	             temp                := f(Iray,index);
	             temp2               := f(Iray,index+1);	             
	             f(Iray,index)   := temp2;
	             f(Iray,index+1) := temp;
	           end if;  
	         end loop;
	       end loop; 
	       end loop;
	     done2 := true;
        wait;
	     end loop;
      wait for 1 ns;
	 end process;
	 
	 process
	   variable linewr : integer := 0;
	   variable tout,fout : line;
	   begin
	   wait for 3 ns;
	    
			for final in 1 to 414720 loop
			  linewr := linewr +1;
			  if linewr >= 20 then
			    linewr := 0;
			    writeline(fiveoutfile,fout);
			    writeline(threeoutfile,tout);
			  end if;
			  write(fout,fxf(final,13));
			  write(fout,' ');
			  write(tout,txt(final,5));
			  write(tout,' ');
			end loop;  
		  complete := true;
		  wait;
		  end process;	
end Behavioral;

