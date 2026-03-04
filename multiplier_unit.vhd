entity multiplier_unit is
    Port (
        a   : in unsigned(15 downto 0);
        b   : in unsigned(15 downto 0);
        p   : out unsigned(31 downto 0)
    );
end multiplier_unit;

architecture behavioral of multiplier_unit is
begin
    p <= a * b;
end behavioral;
