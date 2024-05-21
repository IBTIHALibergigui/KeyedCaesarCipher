library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KeyedCaesarCipher is
    generic (
        N : integer := 8   -- Taille des mots-clés et des messages (en bits)
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        keyword : in std_logic_vector(N-1 downto 0);
        message : in std_logic_vector(N-1 downto 0);
        ciphered_message : out std_logic_vector(N-1 downto 0)
    );
end entity KeyedCaesarCipher;

architecture Behavioral of KeyedCaesarCipher is

    signal keyword_temp, message_temp, shifted_message : unsigned(N-1 downto 0);

begin

    process(clk, reset)
        variable sum_temp : unsigned(N downto 0);
    begin
        if reset = '1' then
            -- Initialisation
            shifted_message <= (others => '0');
        elsif rising_edge(clk) then
            -- Traitement du message
            keyword_temp <= unsigned(keyword);
            message_temp <= unsigned(message);

            -- Ajout du mot-clé au message bit à bit
            for i in 0 to N-1 loop
                sum_temp := ('0' & message_temp) + ('0' & keyword_temp);  -- Ajout du bit de retenu
                shifted_message(i) <= sum_temp(N-1);
                message_temp <= message_temp(N-2 downto 0) & '0';  -- Décalage du message à gauche
            end loop;
        end if;
    end process;

    -- Sortie du message chiffré
    ciphered_message <= std_logic_vector(shifted_message);

end architecture Behavioral;