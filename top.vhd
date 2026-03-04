entity top is
    Port (
        clk     : in  std_logic;
        rst     : in  std_logic;

        btn_up      : in std_logic;
        btn_down    : in std_logic;
        btn_left    : in std_logic;
        btn_right   : in std_logic;
        btn_center  : in std_logic;

        seg     : out std_logic_vector(6 downto 0);
        an      : out std_logic_vector(3 downto 0)
    );
end top;

architecture structural of top is

    -- FSM signals
    signal current_state : std_logic_vector(7 downto 0);

    -- Button signals (debounced)
    signal b_up, b_down, b_left, b_right, b_center : std_logic;

    -- Digit input
    signal digit_value : unsigned(9 downto 0);
    signal digit_valid : std_logic;

    -- Display
    signal display_value : unsigned(15 downto 0);

begin

    -- Component instances (ต่อภายหลัง)
    -- main_fsm
    -- button_controller
    -- digit_input
    -- config_controller
    -- vote_memory
    -- admin_controller
    -- sevenseg_driver

end structural;
