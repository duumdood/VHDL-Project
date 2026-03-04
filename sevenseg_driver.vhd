entity sevenseg_driver is
    Port (
        clk     : in std_logic;
        rst     : in std_logic;

        value_in    : in unsigned(15 downto 0);

        seg     : out std_logic_vector(6 downto 0);
        an      : out std_logic_vector(3 downto 0)
    );
end sevenseg_driver;

architecture behavioral of sevenseg_driver is
begin
    -- Multiplexing logic (เติมภายหลัง)
end behavioral;
