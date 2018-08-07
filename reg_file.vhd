library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity reg_file is

port(
	clk : in std_logic;
	reg_write : in std_logic;
	read_reg1 : in std_logic_vector(4 downto 0);
	read_reg2 : in std_logic_vector(4 downto 0);
	write_reg : in std_logic_vector(4 downto 0);
	write_data : in std_logic_vector(31 downto 0);
	read_data1 : out std_logic_vector(31 downto 0);
	read_data2 : out std_logic_vector(31 downto 0)

);

end reg_file;

architecture op of reg_file is 

	type mem is array (0 to 31) of std_logic_vector(31 downto 0);
	
	signal ROM : mem :=
	(
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
			x"00000000",
			x"00000000"
			
			
		);

begin
 process(clk) 
 begin
	if(rising_edge(clk)) then
		if(reg_write='1') then
		ROM(to_integer(unsigned(write_reg))) <= write_data;
		end if;
	end if;
 end process;



read_data1 <= ROM(to_integer(unsigned(read_reg1)));
read_data2 <= ROM(to_integer(unsigned(read_reg2)));

end op;