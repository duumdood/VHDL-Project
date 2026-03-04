entity state_analyzer is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        start_analysis : in std_logic;

        done_analysis  : out std_logic
    );
end state_analyzer;

architecture behavioral of state_analyzer is
begin
    -- คำนวณผู้ชนะระดับรัฐ
    -- แจก EV
end behavioral;
