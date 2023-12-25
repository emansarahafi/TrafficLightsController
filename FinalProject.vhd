library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FinalProject is
	port (clk : in std_logic;
			Reset : in std_logic;
			Sa, Sd, Se, Sf : in std_logic;
			O0 : out std_logic_vector (0 to 6);
			O1 : out std_logic_vector (0 to 6);
			Ar, Ay, Ag, Br, By, Bg, Cr, Cy, Cg, Dg, Er, Ey, Eg, Fr, Fy, Fg : out std_logic);
end FinalProject;

architecture model of FinalProject is
component Timer90 is
	port (clk, Clr : in std_logic;
			values : out std_logic_vector (7 downto 0));
end component;
component HEXtoBCD is
	port (A : in std_logic_vector (7 downto 0);
			Z : out std_logic_vector (7 downto 0));
end component;
component BCDto7Seg is
	port (A : in std_logic_vector (3 downto 0);
			Z : out std_logic_vector (0 to 6));
end component;
component FiniteStateMachine is
	port (clk : in std_logic;
			Reset : in std_logic;
			Sa, Sd, Se, Sf : in std_logic;
			Ar, Ay, Ag, Br, By, Bg, Cr, Cy, Cg, Dg, Er, Ey, Eg, Fr, Fy, Fg : out std_logic);
end component;

signal clkout : std_logic;
signal count, Z : std_logic_vector (7 downto 0);
signal A0, A1 : std_logic_vector (3 downto 0);

begin
A0 <= Z(3 downto 0);
A1 <= Z(7 downto 4);

FSM: FiniteStateMachine port map (clk, Reset, Sa, Sd, Se, Sf, Ar, Ay, Ag, Br, By, Bg, Cr, Cy, Cg, Dg, Er, Ey, Eg, Fr, Fy, Fg);
Timer: Timer90 port map (clk, Reset, count);
HEX0Conv: HEXtoBCD port map (count, Z);
HEX0: BCDto7Seg port map (A0, O0);
HEX1: BCDto7Seg port map (A1, O1);

end model;