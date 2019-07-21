library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.pkg_pwm.all;

entity pwm is port (
      clk: in std_logic;
      Control_PWM : in t_PWM;
      reset : in std_logic;
      PWM_OUT : out std_logic
      ); -- sortie
end pwm;

architecture behavior of pwm is

signal cnt : std_logic_vector(31 downto 0);
signal s : std_logic;

begin
process (clk,reset) begin
  if reset ='0' then 
     s<='0';
     cnt<= (others=>'0');
  elsif (clk'event and clk='1') then
    if (cnt < Control_PWM.Duty_cycle) then s <='1'; --met la sortie à 1 jusqu'a 
    else s <='0';               --la valeur du rapport cyclique
    end if;
    if (cnt >= Control_PWM.Period) then cnt<=(others =>'0'); --remet à 0 quand on a
    else cnt <= cnt + 1;                 -- compté jusqu'a 10
    end if;
  end if;
end process;
PWM_OUT <= s;
end behavior;