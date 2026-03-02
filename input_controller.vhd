library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity input_controller is
    Port (
        clk              : in  std_logic;
        sw               : in  std_logic_vector(15 downto 0);
        btn              : in  std_logic_vector(4 downto 0);

        mode_select      : out std_logic;
        voter_id         : out std_logic_vector(7 downto 0);
        admin_pass       : out std_logic_vector(3 downto 0);
        candidate_select : out std_logic_vector(1 downto 0);

        btn_confirm      : out std_logic;
        btn_left         : out std_logic;
        btn_right        : out std_logic;
        btn_up           : out std_logic;
        btn_down         : out std_logic
    );
end input_controller;

architecture behavioral of input_controller is
begin

    -- Temporary direct mapping (replace with debounce later)
    mode_select      <= sw(15);
    voter_id         <= sw(7 downto 0);
    admin_pass       <= sw(3 downto 0);
    candidate_select <= sw(1 downto 0);

    btn_confirm <= btn(0);
    btn_left    <= btn(1);
    btn_right   <= btn(2);
    btn_up      <= btn(3);
    btn_down    <= btn(4);

end behavioral;
