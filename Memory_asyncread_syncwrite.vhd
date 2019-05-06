library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

-- since The Memory is asynchronous read, there is no read signal, but you can use it based on your preference.
-- this memory gives 16 Bit data in one clock cycle, so edit the file to your requirement.

entity Memory_asyncread_syncwrite is 
	port (t1_out,t2_out,pc_out: in std_logic_vector(15 downto 0); S,NS: in std_logic_vector(19 downto 0); clk,rst: in std_logic;
				mem_d_out: out std_logic_vector(15 downto 0));
end entity;

architecture Form of Memory_asyncread_syncwrite is 
type regarray is array(31 downto 0) of std_logic_vector(15 downto 0);   -- defining a new type
signal Memory: regarray:=(
0 => x"c044",1 => x"c287",2 => x"6400",3 => x"0004",4 => x"0051",5 => x"ffff",6 => x"2050",7 => x"24e2",8 => x"8c03",9 => x"0bb8",10 => x"2051",11 => x"9bc0",12 => x"ffff",13 => x"11c2",14 => x"ffff",15 => x"ffff",16 => x"9440",22 => x"83f5",25 => x"ffed",others => "0000000000000000");
signal mem_a: std_logic_vector(15 downto 0) := "0000000000000000";
signal mem_d_in:std_logic_vector(15 downto 0) := "0000000000000000";
signal WR: std_logic;
-- you can use the above mentioned way to initialise the memory with the instructions and the data as required to test your processor
begin
WR <= S(10) or S(15);

mem_d_in <= 
x"0000" when rst='1' else
t1_out when S(15)='1' else
t2_out when S(10)='1';

mem_a <=
x"0000" when rst='1' else
pc_out when NS(0)='1' else
t1_out when (S(8) or S(10))='1' else
t2_out when (S(11) or S(15))='1';

mem_d_out <= Memory(conv_integer(mem_a));
Mem_write:
process (WR,mem_d_in,mem_a,clk)
	begin
	if(WR = '1') then
		if(rising_edge(clk)) then
			Memory(conv_integer(mem_a)) <= mem_d_in;
		end if;
	end if;
	end process;
end Form;
