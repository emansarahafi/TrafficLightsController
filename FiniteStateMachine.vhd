library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FiniteStateMachine is
	port (clk : in std_logic;
			Reset : in std_logic;
			Sa, Sd, Se, Sf : in std_logic;
			Ar, Ay, Ag, Br, By, Bg, Cr, Cy, Cg, Dg, Er, Ey, Eg, Fr, Fy, Fg : out std_logic);
end FiniteStateMachine;

architecture model of FiniteStateMachine is
component Experiment05PartA is
port (clkin : in std_logic;
		clkout : out std_logic);
end component;
component Counter60 is
	port (clk, Clr : in std_logic;
			values : out std_logic_vector (7 downto 0));
end component;

Type States is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12);
signal Pst, Nst : States;
signal clkout : std_logic;
signal lights : std_logic_vector (15 downto 0);
signal count60 : std_logic_vector (7 downto 0);
constant T60 : std_logic_vector := "00111100";
constant T30 : std_logic_vector := "00011110";
constant T20 : std_logic_vector := "00010100";
constant T10 : std_logic_vector := "00001010";
constant T05 : std_logic_vector := "00000101";
constant T02 : std_logic_vector := "00000010";
constant T01 : std_logic_vector := "00000001";

begin
	P1: process (Reset, clkout) is
	begin
		if Reset = '1' then
		Pst <= S0;
		elsif clkout'event and clkout = '1' then
			Pst <= Nst;
			count60 <= count60;
		end if;
	end process;
	
	P2: process (Pst, Sa, Sd, Se, Sf) is
		begin
			case Pst is
			when S0 => lights <= "0010011000100100";
						  if count60 < T60 then Nst <= S0;
			           else Nst <= S1;
						  end if;
			when S1 => lights <= "0010101000100100";
						  if count60 < T02 then Nst <= S1;
			           else Nst <= S2;
						  end if;
			when S2 => lights <= "0011001000100100";
						  if count60 < T01 then Nst <= S2;
			           else Nst <= S3;
						  end if;
			when S3 => lights <= "0011000100100100";
						  if count60 < T02 then Nst <= S3;
			           else Nst <= S4;
						  end if;
			when S4 => lights <= "0011000010100100";
						  if count60 < T30 then Nst <= S4;
			           else Nst <= S5;
						  end if;
			when S5 => lights <= "0101000010100100";
						  if count60 < T02 then Nst <= S5;
						  elsif (Sd = '1') then Nst <= S8;
						  elsif (Sd = '0') then Nst <= S6;
						  end if;
			when S6 => lights <= "1001000011100100";
						  if count60 < T10 then Nst <= S6;
			           else Nst <= S7;
						  end if;
			when S7 => lights <= "1001000100100100";
						  if count60 < T02 then Nst <= S7;
			           else Nst <= S8;
						  end if;
			when S8 => lights <= "1001001000010010";
						  if count60 < T02 then Nst <= S8;
			           else Nst <= S9;
						  end if;
			when S9 => lights <= "1001001000001001";
						  if count60 < T20 then Nst <= S9;
						  elsif ((Se = '0' or Sf = '0') and Sa = '1') then Nst <= S10;
						  end if;
			when S10 => lights <= "1001001000001001";
						  if count60 < T05 then Nst <= S10;
			           else Nst <= S11;
						  end if;
			when S11 => lights <= "1001001000010010";
						  if count60 < T02 then Nst <= S11;
			           else Nst <= S12;
						  end if;
			when S12 => lights <= "0100101000100100";
						  if count60 < T02 then Nst <= S12;
						  elsif ((Se = '1' or Sf = '1') and Sa = '0') then Nst <= S0;
						  end if;
			end case;
		end process;

Clock : Experiment05PartA port map(clk, clkout);
C60: Counter60 port map (clk, Reset, count60);
	
Ar <= lights(15);
Ay <= lights(14);
Ag <= lights(13);
Br <= lights(12);
By <= lights(11);
Bg <= lights(10);
Cr <= lights(9);
Cy <= lights(8);
Cg <= lights(7);
Dg <= lights(6);
Er <= lights(5);
Ey <= lights(4);
Eg <= lights(3);
Fr <= lights(2);
Fy <= lights(1);
Fg <= lights(0);

end model;