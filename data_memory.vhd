library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity data_memory is

port(
	clk, mem_write, mem_read : in std_logic;
	mem_addr : in std_logic_vector(31 downto 0);
	write_data : in std_logic_vector(31 downto 0);
	read_data : out std_logic_vector(31 downto 0)

);

end data_memory;

architecture op of data_memory is

	type ram is array(0 to 31) of std_logic_vector(31 downto 0);
	
	signal memory : ram :=
		(  x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000",
			x"00000000");

begin

read_data <= memory(to_integer(unsigned(mem_addr(6 downto 2)))) when mem_read = '1' else x"00000000";

adding :	process(clk)
	begin
		if clk = '1' and clk'event then
			if (mem_write = '1') then
				memory(to_integer(unsigned(mem_addr(6 downto 2)))) <= write_data;
			end if;
		end if;
	end process adding;
	
	

end op;

