library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use IEEE.numeric_std.all;

entity alu is 

port(a,b : in std_logic_vector(31 downto 0);
	  control : in std_logic_vector(3 downto 0);
	  result : out std_logic_vector(31 downto 0);
	  zero : out std_logic
	  );

end alu;

architecture op of alu is
signal c : std_logic_vector(31 downto 0);

begin

		
		c <=	std_logic_vector(unsigned(a) + unsigned(b)) when (control="0000") else -- adding (used for any instructions that involve adding)
						std_logic_vector(unsigned(a) - unsigned(b)) when (control="0001") else
						"00000000000000000000000000000001" when (control="0010" and a < b) else -- slt 
						"00000000000000000000000000000000";
		
				
			
	  
zero <= '1' when c <= "00000000000000000000000000000000" else '0';

result <= c;


end op;