library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit is 

port(
	clk,reset : in std_logic;
	opcode : in std_logic_vector(5 downto 0);
	
	reg_dst : out std_logic;
	jump : out std_logic;
	branch : out std_logic;
	mem_read : out std_logic;
	mem_reg : out std_logic;
	alu_op : out std_logic_vector(1 downto 0);
	mem_write : out std_logic;
	alu_src : out std_logic;
	reg_write : out std_logic
	
);

end control_unit;

architecture op of control_unit is 

begin

	process(reset, opcode, clk)
		begin
		if(reset = '1') then
				reg_dst <= '0';
				jump <= '0';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
		else
		case opcode is
			when "000000" =>
				reg_dst <= '1';
				jump <= '0'; -- 000000 opcode is addu/sltu/subu
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "10";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '1';	
			when "100011" => --lw
				reg_dst <= '0';
				jump <= '0';
				branch <= '0';
				mem_read <= '1'; 
				mem_reg <= '1';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '1';
				reg_write <= '1';	
			when "101011" => --sw
				reg_dst <= '0';
				jump <= '0';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "00";
				mem_write <= '1';
				alu_src <= '1';
				reg_write <= '0';
			when "000100" => --beq
				reg_dst <= '0';
				jump <= '0';
				branch <= '1';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "01";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
			when "001001" =>
				reg_dst <= '0';
				jump <= '0';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '1';
				reg_write <= '1';
				
			when "000101" => --bne
				reg_dst <= '0';
				jump <= '0';
				branch <= '1';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "01";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
				
			when "000010" => --j
				reg_dst <= '1';
				jump <= '1';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '0';
				reg_write <= '0';
			when "001011" => --sltiu
				reg_dst <= '0';
				jump <= '0';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "11";
				mem_write <= '0';
				alu_src <= '1';
				reg_write <= '1';
			when others =>
				reg_dst <= '1';
				jump <= '0';
				branch <= '0';
				mem_read <= '0'; 
				mem_reg <= '0';
				alu_op <= "00";
				mem_write <= '0';
				alu_src <= '1';
				reg_write <= '1';
			end case;
			end if;
			end process;
			

				
end op;				