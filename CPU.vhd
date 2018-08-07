-- 104271577

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;
use ieee.numeric_std.all;

entity CPU is 

port(clk : in std_logic;
	  reset : in std_logic;
	  alu1_out : out std_logic_vector(31 downto 0);
	  PC_out : out std_logic_vector(31 downto 0)
	  );

end CPU;

architecture operation of CPU is

signal syscall : std_logic:= '0';

--PC
signal pc, pc_2, pc_4 : std_logic_vector(31 downto 0):= x"00000000";--Initial and next states of PC


signal shift_2 : std_logic_vector(27 downto 0);

signal jump_addr : std_logic_vector(31 downto 0);
signal read_addr : std_logic_vector(4 downto 0);
signal instruction : std_logic_vector(31 downto 0);

signal adder1 : std_logic_vector(31 downto 0);

--signal opcode : std_logic_vector(5 downto 0);
--signal fmt : std_logic_vector(4 downto 0);
--signal ft : std_logic_vector(4 downto 0);
--signal fs : std_logic_vector(4 downto 0);
--signal fd : std_logic_vector(4 downto 0);
--signal funct : std_logic_vector(5 downto 0); 


signal sign_ext : std_logic_vector(31 downto 0);
signal mem_read_data : std_logic_vector(31 downto 0);


-- ALU I/O 
signal alu_in2 : std_logic_vector(31 downto 0);
signal zero_flag : std_logic;
signal alu_control : std_logic_vector(3 downto 0);
signal alu_out : std_logic_vector(31 downto 0);

signal mem_write_data : std_logic_vector(31 downto 0);

-- Register I/O
signal read_reg1 : std_logic_vector(4 downto 0);
signal read_reg2 : std_logic_vector(4 downto 0);
signal write_reg : std_logic_vector(4 downto 0);
signal write_data : std_logic_vector(31 downto 0);
signal read_data1 : std_logic_vector(31 downto 0);
signal read_data2 : std_logic_vector(31 downto 0);

-- Control I/O

signal reg_dst : std_logic;
signal jump : std_logic;
signal branch : std_logic;
signal mem_read : std_logic;
signal mem_reg : std_logic;
signal mem_write : std_logic;
signal alu_src : std_logic;
signal reg_write : std_logic;
signal alu_op : std_logic_vector(1 downto 0);

begin

read_reg1 <= instruction(25 downto 21);
read_reg2 <= instruction(20 downto 16);
write_reg <= instruction(15 downto 11) when reg_dst = '1' else
				 instruction(20 downto 16);
				 
--process for pc counter as shown in datapath



pc_4 <= pc + x"00000004";


shift_2 <= instruction(25 downto 0) & "00"; -- logical shifter
jump_addr <= pc_4(31 downto 28) & shift_2; 



sign_ext <= std_logic_vector(resize(signed(instruction(15 downto 0)),32));


adder1 <= pc_4 + (sign_ext(29 downto 0) & "00");


process(clk, reset)
	begin
	
	if(reset='1') then
		pc <= x"00000000";
	elsif(clk='1' and clk'event) then
			pc <= pc_4;
		if branch = '1' then --takes care of branch operations i.e beq and bne
			if zero_flag = '1' and instruction(31 downto 26) = "000100" then
				pc <= adder1;
			elsif zero_flag = '0' and instruction(31 downto 26) = "000101" then
				pc <= adder1;
			end if;
		elsif jump = '1' then
			pc <= jump_addr;
		else	
			
			
		
		end if;
		
			
	end if;
end process;


read_addr <= pc(6 downto 2);

alu_in2 <= sign_ext when alu_src='1' else read_data2;

controller : entity work.control_unit port map(clk,reset,instruction(31 downto 26),reg_dst,jump,branch,mem_read,mem_reg,alu_op,mem_write,alu_src,reg_write);
	
instruction_mem : entity work.instruction_memory port map(read_addr,instruction);


registers : entity work.reg_file port map (clk, reg_write, read_reg1, read_reg2, write_reg, write_data, read_data1, read_data2); 

alunit : entity work.alu port map(read_data1, alu_in2, alu_control, alu_out, zero_flag);

alu_controller : entity work.alu_ctrl port map(instruction(5 downto 0), alu_op, alu_control);

write_data <= alu_out when (mem_reg = '0') else
				  mem_read_data when (mem_reg = '1');

mem_write_data <= read_data2;

data_mem : entity work.data_memory port map(clk, mem_write, mem_read, alu_out, mem_write_data, mem_read_data);

alu1_out <= alu_out;
PC_out <= pc;

end operation;

