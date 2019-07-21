library ieee;

use ieee.std_logic_1164.all;
Library work;

use work.pkg_apb3.all;
package pkg_pwm is
 
 
  type t_PWM is record
    Period  :std_logic_vector (31 downto 0);
    Duty_cycle :std_logic_vector (31 downto 0);
  end record t_PWM;  
  

  component pwm is
    port (
      clk: in std_logic;
      Control_PWM : in t_PWM;
      reset : in std_logic;
      PWM_OUT : out std_logic
      ); -- sortie
  end component pwm;

type pwm_array_20 is array ( 0 to 19 ) of t_PWM;

 component multiple_pwm_20 is port (
            clk: in std_logic;
      apb3_master : in apb3;
      apb3_master_Back : out apb3_Back;
      reset : in std_logic;
      PWM_OUT_20 : out std_logic_vector(19 downto 0)
      ); -- sortie
end component multiple_pwm_20;
  
end package pkg_pwm;
 
