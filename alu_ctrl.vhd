library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity alu_ctrl is 

port(funct : in std_logic_vector(5 downto 0);
	  alu_op : in std_logic_vector(1 downto 0);
	  control : out std_logic_vector(3 downto 0)
	  );

end alu_ctrl;

architecture op of alu_ctrl is

begin

	process(funct,alu_op)
		begin
		
		case alu_op is
			when "00" =>
				control <= "0000";
			when "01" =>
				control <= "0001";
			when "10" =>
				if (funct <= "100001") then
					control <= "0000";
				elsif (funct <= "100011") then
					control <= "0001";
				elsif (funct <= "101011") then
					control <= "0010";
				end if;
			when "11" =>
				control <= "0010";
				
			when others => end case;
	end process;
	
end op;
				


