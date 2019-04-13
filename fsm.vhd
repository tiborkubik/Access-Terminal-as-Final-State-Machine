-- fsm.vhd: Finite State Machine
-- Author(s): Tibor Kubik - xkubik34@stud.fit.vutbr.cz
--
library ieee;
use ieee.std_logic_1164.all;
-- ----------------------------------------------------------------------------
--                        Entity declaration
-- ----------------------------------------------------------------------------
entity fsm is
port(
   CLK         : in  std_logic;
   RESET       : in  std_logic;

   -- Input signals
   KEY         : in  std_logic_vector(15 downto 0);
   CNT_OF      : in  std_logic;

   -- Output signals
   FSM_CNT_CE  : out std_logic;
   FSM_MX_MEM  : out std_logic;
   FSM_MX_LCD  : out std_logic;
   FSM_LCD_WR  : out std_logic;
   FSM_LCD_CLR : out std_logic
);
end entity fsm;

-- ----------------------------------------------------------------------------
--                      Architecture declaration
-- ----------------------------------------------------------------------------
architecture behavioral of fsm is
   type t_state is (TEST1, TEST2_CODE1, TEST2_CODE2, TEST3_CODE1, TEST3_CODE2, TEST4_CODE1, TEST4_CODE2, TEST5_CODE1, TEST5_CODE2, TEST6_CODE1, TEST6_CODE2, TEST7_CODE1, TEST7_CODE2, TEST8_CODE1, TEST8_CODE2, TEST9_CODE1, TEST9_CODE2, TEST10_CODE1, TEST10_CODE2, SUCCESS, PRINT_MESSAGE_SUCCESS, WRONG_STATE, PRINT_MESSAGE, FINISH);
   signal present_state, next_state : t_state;

begin
-- -------------------------------------------------------
sync_logic : process(RESET, CLK)
begin
   if (RESET = '1') then
      present_state <= TEST1;
   elsif (CLK'event AND CLK = '1') then
      present_state <= next_state;
   end if;
end process sync_logic;

-- -------------------------------------------------------
next_state_logic : process(present_state, KEY, CNT_OF)
-- kod1 = 10666 99550 	
-- kod2 = 74668 96856
begin
   case (present_state) is
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST1 =>
      next_state <= TEST1;
      if (KEY(1) = '1') then				-- code1: 1
        	next_state <= TEST2_CODE1;
 	elsif (KEY(7) = '1') then			-- code2: 7
		next_state <= TEST2_CODE2;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
		next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST2_CODE1 =>
      next_state <= TEST2_CODE1;
      if (KEY(0) = '1') then				-- code1: 10
        	next_state <= TEST3_CODE1; 
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST2_CODE2 =>
      next_state <= TEST2_CODE2;			-- code2: 74
 	if (KEY(4) = '1') then
		next_state <= TEST3_CODE2;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST3_CODE1 =>
      next_state <= TEST3_CODE1;
      if (KEY(6) = '1') then					-- code1: 106
        	next_state <= TEST4_CODE1; 			
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST3_CODE2 =>
      next_state <= TEST3_CODE2;
      if (KEY(6) = '1') then					-- code2: 746
        	next_state <= TEST4_CODE2; 			
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST4_CODE1 =>
      next_state <= TEST4_CODE1;
      if (KEY(6) = '1') then					-- code1: 1066
        	next_state <= TEST5_CODE1; 			
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST4_CODE2 =>
      next_state <= TEST4_CODE2;
      if (KEY(6) = '1') then					
        	next_state <= TEST5_CODE2; 			-- code2: 7466
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
        -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST5_CODE1 =>
      next_state <= TEST5_CODE1;
      if (KEY(6) = '1') then				-- code1: 10666
        	next_state <= TEST6_CODE1;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
         -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST5_CODE2 =>
      next_state <= TEST5_CODE2;
	if (KEY(8) = '1') then
		next_state <= TEST6_CODE2;		-- code2: 74668
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST6_CODE1 =>
      next_state <= TEST6_CODE1;
      if (KEY(9) = '1') then				-- code1: 10666 9
        	next_state <= TEST7_CODE1; 		
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST6_CODE2 =>
      next_state <= TEST6_CODE2;
      if (KEY(9) = '1') then			
        	next_state <= TEST7_CODE2; 		-- code2: 74668 9
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST7_CODE1 =>
      next_state <= TEST7_CODE1;
      if (KEY(9) = '1') then				-- code1: 10666 99
        	next_state <= TEST8_CODE1;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST7_CODE2 =>
      next_state <= TEST7_CODE2;
	if (KEY(6) = '1')then				-- code2: 74668 96
		next_state <= TEST8_CODE2;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST8_CODE1 =>
      next_state <= TEST8_CODE1;
      if (KEY(5) = '1') then				-- code1: 10666 995
        	next_state <= TEST9_CODE1;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST8_CODE2 =>
      next_state <= TEST8_CODE2;
	if (KEY(8) = '1') then				-- code2: 74668 968
		next_state <= TEST9_CODE2;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST9_CODE1 =>
      next_state <= TEST9_CODE1;
      if (KEY(5) = '1') then				-- code1: 10666 9955
        	next_state <= TEST10_CODE1; 		
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST9_CODE2 =>
      next_state <= TEST9_CODE2;
      if (KEY(5) = '1') then
        	next_state <= TEST10_CODE2; 		-- code2: 74668 9685
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST10_CODE1 =>
      next_state <= TEST10_CODE1;
      if (KEY(0) = '1') then				-- code1: 10666 99550
        	next_state <= SUCCESS;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
       -- - - - - - - - - - - - - - - - - - - - - - -
      when TEST10_CODE2 =>
      next_state <= TEST10_CODE2;
	if (KEY(6) = '1') then				-- code2: 74668 96850
		next_state <= SUCCESS;
	elsif (KEY(15) = '1') then
		next_state <= PRINT_MESSAGE;
	elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;
      -- - - - - - - - - - - - - - - - - - - - - - -
      when SUCCESS =>
      next_state <= SUCCESS;
      if(KEY(15) = '1') then
	     	next_state <= PRINT_MESSAGE_SUCCESS;
      elsif (KEY(14 downto 0) /= "000000000000000") then
	 	next_state <= WRONG_STATE;
      end if;

   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE =>
      next_state <= PRINT_MESSAGE;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
    -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_SUCCESS =>
      next_state <= PRINT_MESSAGE_SUCCESS;
      if (CNT_OF = '1') then
         next_state <= FINISH;
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when WRONG_STATE =>
      next_state <= WRONG_STATE;
      if(KEY(15) = '1') then
	      next_state <= PRINT_MESSAGE;
	end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      next_state <= FINISH;
      if (KEY(15) = '1') then
         next_state <= TEST1; 
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
      next_state <= TEST1;
   end case;
end process next_state_logic;

-- -------------------------------------------------------
output_logic : process(present_state, KEY)
begin
   FSM_CNT_CE     <= '0';
   FSM_MX_MEM     <= '0';
   FSM_MX_LCD     <= '0';
   FSM_LCD_WR     <= '0';
   FSM_LCD_CLR    <= '0';

   case (present_state) is  
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when PRINT_MESSAGE_SUCCESS =>
      FSM_CNT_CE     <= '1';
      FSM_MX_LCD     <= '1';
      FSM_MX_MEM     <= '1';
      FSM_LCD_WR     <= '1';
   -- - - - - - - - - - - - - - - - - - - - - - -
   when FINISH =>
      if (KEY(15) = '1') then
      FSM_LCD_CLR    <= '1';
      end if;
   -- - - - - - - - - - - - - - - - - - - - - - -
   when others =>
	if (KEY(14 downto 0) /= "000000000000000") then
         FSM_LCD_WR     <= '1';
     	 end if;
     	 if (KEY(15) = '1') then
         FSM_LCD_CLR    <= '1';
      end if;
   end case;
end process output_logic;

end architecture behavioral;

