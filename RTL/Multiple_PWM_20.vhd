library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.pkg_pwm.all;
use work.pkg_apb3.all;

entity multiple_pwm_20 is port (
      clk: in std_logic;
      apb3_master : in apb3;
      apb3_master_Back : out apb3_Back;
      reset : in std_logic;
      PWM_OUT_20 : out std_logic_vector(19 downto 0)
      ); -- sortie
end multiple_pwm_20;

architecture behavior of multiple_pwm_20 is
signal       Control_PWM_20 : pwm_array_20;
	signal Regs_Out : apb3_Reg_array(39 downto 0); -- example

begin


  GEN_PWM_20 : FOR i IN 0 to 19 generate
    PWMX : pwm 
    port map(
            clk=>clk,
          Control_PWM =>Control_PWM_20(i),
          reset =>reset,
          PWM_OUT=>PWM_OUT_20(i)
      );
    Control_PWM_20(i).Period<=Regs_Out(2*i);
    Control_PWM_20(i).Duty_cycle<=Regs_Out(1+2*i);
  end generate GEN_PWM_20;
apb3_reader_PWM : apb3_reader
generic map( 
        Number_Reg => 40,
        REG_DEFINITION =>(W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W,W)
)
port map(
      reset =>reset,
      apb3_master =>apb3_master,
      apb3_master_Back =>apb3_master_Back,

      Regs_In =>(others=>(others=>'0')),
      Regs_Out=>Regs_Out

);
end behavior;