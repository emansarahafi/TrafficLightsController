LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCDto7Seg is
	port (A : in std_logic_vector (3 downto 0);
			Z : out std_logic_vector (0 to 6));
end BCDto7Seg;

architecture model of BCDto7Seg is	
	type truth_table is array (natural range <>) of std_logic_vector(0 to 6);
	constant TT: truth_table (0 to 9) := ( "0000001" , "1001111" , "0010010" , "0000110" , "1001100" , "0100100" , "0100000" , "0001111" , "0000000" , "0000100" );
	
	signal index : integer range 0 to 9;
	begin
		index <= CONV_INTEGER(A);
		Z <= TT(index);
end model;