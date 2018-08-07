library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

entity instruction_memory is 

port (
	read_address : in std_logic_vector(4 downto 0);
	instruction : out std_logic_vector(31 downto 0)
	);
	
end instruction_memory;

architecture op of instruction_memory is



	type mem is array (0 to 31) of std_logic_vector(31 downto 0);
	
	signal ROM : mem :=
	(
			"00100100000010000000000000000000",
			"00100100000010010000000000000001",
			"00100100000010100000000000000000",
			"00100100000010110000000000000100",
			"00100100000011000010000000000000",
			"10101101100010100000000000000000",
			"00000001010010010101000000100001",
			"00100101100011000000000000000100",
			"00101101010000010000000000010000",
			"00010100001000001111111111111011",
			"00100101100011000000000000001000",
			"00000001010010010101000000100011",
			"10101101100010101111111111111000",
			"00000001100010110110000000100001",
			"00010001010000000000000000000001",
			"00001000000000000000000000001011",
			"00100100000011000001111111111000",
			"00100100000010110000000000100000",
			"10001101100011010000000000001000",
			"00100101101011011000000000000000",
			"10101101100011010000000000001000",
			"00000001010010010101000000100001",
			"00100101100011000000000000000100",
			"00000001010010110000100000101011",
			"00010100001000001111111111111001",
			"00100100010000100000000000001010",
			"00000000000000000000000000001100",
			
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000",
			"00000000000000000000000000000000"
			
		);
	
begin

instruction <= ROM(to_integer(unsigned(read_address)));
	
end op; 	
	
	
	
