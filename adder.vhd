library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_signed.all;

entity adder is 

port(a,b: in std_logic_vector(31 downto 0);
	  c : out std_logic_vector(31 downto 0)
	  );

end adder;

architecture op of adder is

begin

c <= a+b;

end op;

