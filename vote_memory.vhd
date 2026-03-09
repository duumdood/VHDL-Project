----------------------------------------------------------------------------------
-- Module Name: vote_memory - Behavioral
-- Project Name: Advanced Electronic Voting System (Nexys A7)
-- Description: This module manages the voter database to prevent double-voting.
--              It uses an internal array (RAM-based) to store the status of each ID.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Required for converting unsigned voter_id to integer index

entity vote_memory is
    Port (
        -- [INPUT]: Global Clock signal from the Nexys A7 board (via top.vhd)
        clk         : in std_logic;
        
        -- [INPUT]: System Reset signal (Active High)
        -- Source: Triggered by Admin command or Global Reset button in top.vhd
        rst         : in std_logic;

        -- [INPUT]: 10-bit unsigned integer representing the Voter's ID (0 to 1023)
        -- Source: Received from 'digit_input.vhd' module after the user finishes entering their ID
        voter_id    : in unsigned(9 downto 0);
        
        -- [INPUT]: Control signal to initiate a memory check/write operation
        -- Source: Triggered by 'main_fsm.vhd' during the Validation Stage (e.g., Stage U5)
        vote_valid  : in std_logic;

        -- [OUTPUT]: Status flag indicating if the current Voter ID has already voted
        -- Destination: Sent to 'main_fsm.vhd' to decide whether to permit or block the vote
        -- Value: '1' if ID exists in memory (Voted), '0' if ID is new (Not voted yet)
        voted_flag  : out std_logic
    );
end vote_memory;

architecture behavioral of vote_memory is

    ------------------------------------------------------------------------------
    -- Internal Memory Declaration
    ------------------------------------------------------------------------------
    -- Define a custom array type representing 1024 distinct voter slots
    -- Each slot stores 1 bit: '0' for "Available" and '1' for "Already Voted"
    type voter_array is array (0 to 1023) of std_logic;

    -- Initialize the memory array and set all slots to '0' (Clear status)
    signal voter_memory : voter_array := (others => '0');

    -- Internal register to buffer the output flag before driving the port
    signal voted_flag_reg : std_logic := '0';

begin

    ------------------------------------------------------------------------------
    -- Main Memory Logic Process
    ------------------------------------------------------------------------------
    -- Synchronous process triggered by the rising edge of the system clock
    process(clk)
    begin
        if rising_edge(clk) then
            
            -- [RESET LOGIC]: Triggered when rst is high
            -- Wipes all recorded votes from memory (useful for starting a new election)
            if rst = '1' then
                voter_memory <= (others => '0'); -- Clear all 1024 bits in the array
                voted_flag_reg <= '0';           -- Reset the duplicate vote warning flag
                
            -- [VOTING LOGIC]: Triggered when the FSM sends a validation pulse
            elsif vote_valid = '1' then
                
                -- Check the specific index in the array corresponding to the voter_id
                -- to_integer() is used to map the 10-bit unsigned input to an array index
                if voter_memory(to_integer(voter_id)) = '1' then
                    
                    -- CASE 1: The ID is already marked as '1' (Double-voting detected)
                    -- Result: Set the flag to '1' to inform the FSM of the violation
                    voted_flag_reg <= '1'; 
                    
                else
                    
                    -- CASE 2: The ID is marked as '0' (First-time voter)
                    -- Result: Set flag to '0' (Valid) and update memory to '1' (Mark as voted)
                    voted_flag_reg <= '0'; 
                    
                    -- Record the vote by setting the specific array bit to '1'
                    -- This prevents the same ID from being used again in the future
                    voter_memory(to_integer(voter_id)) <= '1';
                    
                end if;
            end if;
        end if;
    end process;

    ------------------------------------------------------------------------------
    -- Concurrent Assignment
    ------------------------------------------------------------------------------
    -- Continuously drive the output port with the value stored in the internal register
    voted_flag <= voted_flag_reg;

end behavioral;