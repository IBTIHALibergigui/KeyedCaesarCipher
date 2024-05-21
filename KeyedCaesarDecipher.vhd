library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity KeyedCaesarDecipher is
    generic (
        N : integer := 8   -- Taille des mots-clés et des messages (en bits)
    );
    port (
        clk : in std_logic;
        reset : in std_logic;
        keyword : in std_logic_vector(N-1 downto 0);
        ciphered_message : in std_logic_vector(N-1 downto 0);
        decrypted_message : out std_logic_vector(N-1 downto 0)
    );
end entity KeyedCaesarDecipher;

architecture Behavioral of KeyedCaesarDecipher is

    signal keyword_temp, ciphered_message_temp, shifted_message : unsigned(N-1 downto 0);

begin

    process(clk, reset)
    begin
        if reset = '1' then
            -- Initialisation
            shifted_message <= (others => '0');
        elsif rising_edge(clk) then
            -- Convertir les mots-clés et messages chiffrés en type unsigned
            keyword_temp <= unsigned(keyword);
            ciphered_message_temp <= unsigned(ciphered_message);

            -- Soustraction du mot-clé du message chiffré
            shifted_message <= ciphered_message_temp - keyword_temp;
        end if;
    end process;

    -- Sortie du message déchiffré
    decrypted_message <= std_logic_vector(shifted_message);

end architecture Behavioral;