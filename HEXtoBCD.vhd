LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity HEXtoBCD is
	port (A : in std_logic_vector (7 downto 0);
			Z : out std_logic_vector (7 downto 0));
end HEXtoBCD;

architecture model of HEXtoBCD is	
	type truth_table is array (natural range <>) of std_logic_vector(3 downto 0);
	constant TT: truth_table (0 to 9) := ( "0000" , "0001" , "0010" , "0011" , "0100" , "0101" , "0110" , "0111" , "1000" , "1001" );
	
	signal n1, n2 : integer range 0 to 9;
	signal v, v1 : integer;
	signal Z1, Z2 : std_logic_vector (3 downto 0);
	begin
		v <= CONV_INTEGER(A);
		n2 <= v mod 10;
		v1 <= v/10;
		n1 <= v1 mod 10;
		Z2 <= TT(n2);
		Z1 <= TT(n1);
		Z <= Z1 & Z2;
end model;