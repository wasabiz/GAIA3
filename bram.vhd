library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

use work.types.all;

entity bram is

  port (
    clk      : in  std_logic;
    bram_in  : in  bram_in_type;
    bram_out : out bram_out_type);

end entity;

architecture behavioral of bram is

  type ram_t is
    array(0 to 8191) of std_logic_vector(31 downto 0);

  constant myram : ram_t := (
    0 => (others => '0'),
    1 => "0010" & "00001" & "00000" & "00" & x"FEDB",
    2 => (others => '0'),
    3 => (others => '0'),
    4 => (others => '0'),
    5 => (others => '0'),
    6 => (others => '0'),
    7 => (others => '0'),
    8 => "0011" & "00001" & "00001" & "00" & x"CA98",
    others => (others => '0'));

  constant myram2 : ram_t := (
    (others => '0'),
    "0010" & "00001" & "00000" & "00" & x"000A", -- 1
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    "1111" & "00001" & "00000" & "00" & x"0014", -- 8
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    "0000" & "00001" & "00001" & "00000" & x"01" & "00001", -- 15
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    "1011" & "11111" & "00000" & "00" & x"FFF1", -- 22
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    "1011" & "11111" & "00000" & "00" & x"FFFF", -- 29
    others => (others => '0'));

  constant myram3 : ram_t := (
    (others => '0'),
    "0000" & "00001" & "00000" & "00000" & x"01" & "00000",
    "0000" & "00010" & "00000" & "00000" & x"02" & "00000",
    "0000" & "00011" & "00000" & "00000" & x"03" & "00000",
    "0000" & "00100" & "00000" & "00000" & x"04" & "00000",
    "0000" & "00101" & "00000" & "00000" & x"05" & "00000",
    "0000" & "00110" & "00000" & "00000" & x"06" & "00000",
    "0000" & "00001" & "00001" & "00010" & x"00" & "00000",
    "0000" & "00001" & "00001" & "00011" & x"00" & "00000",
    "0000" & "00001" & "00001" & "00100" & x"00" & "00000",
    "0000" & "00001" & "00001" & "00101" & x"00" & "00000",
    "0000" & "00001" & "00001" & "00110" & x"00" & "00000",
    others => (others => '0'));

  -- mov r1, 1
  -- mov r2, 2
  -- st r1, r0, 108
  -- st r2, r0, 112
  -- ld r3, r0, 108
  -- ld r4, r0, 112
  -- add r5, r3, r4

  constant myram4 : ram_t := (
    (others => '0'),

    "0000" & "00001" & "00000" & "00000" & x"01" & "00000",
    "0000" & "00010" & "00000" & "00000" & x"02" & "00000",

    "0110" & "00001" & "00000" & "00" & x"006C",
    "0110" & "00010" & "00000" & "00" & x"0070",

    "1000" & "00011" & "00000" & "00" & x"006C",
    "1000" & "00100" & "00000" & "00" & x"0070",

    "0000" & "00101" & "00011" & "00100" & x"00" & "00000",

    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    (others => '0'),
    others => (others => '0'));

  -- mov r1, 0xA
  -- beq r1, r0, 8
  -- sub r1, r1, 1
  -- jl r31, -C
  -- jl r31, -4

  constant myram5 : ram_t := (
    (others => '0'),                    -- 0
    "0010" & "00001" & "00000" & "00" & x"000A", -- 4
    "1111" & "00001" & "00000" & "00" & x"0002", -- 8
    "0000" & "00001" & "00001" & "00000" & x"01" & "00001", -- C
    "1011" & "11111" & "00000" & "00" & x"FFFD",            -- 10
    "1011" & "11111" & "00000" & "00" & x"FFFF",            -- 14
    others => (others => '0'));

  -- mov r1, 10
  -- mov r2, 3
  -- bne r1, r2, [40]
  -- mov r3, 4

  constant myram6 : ram_t := (
    (others => '0'),
    "0010" & "00001" & "00000" & "00" & x"000A",
    "0010" & "00010" & "00000" & "00" & x"0003",
    "1101" & "00001" & "00010" & "00" & x"0040",
    "0010" & "00011" & "00000" & "00" & x"0004",
    others => (others => '0'));

  -- mov r1, 1
  -- add r2, r1, r0
  -- beq r1, r2, [40]
  -- mov r3, 3

  constant myram7 : ram_t := (
    (others => '0'),
    "0010" & "00001" & "00000" & "00" & x"0001",
    "0000" & "00010" & "00001" & "00000" & x"00" & "00000",
    "1111" & "00001" & "00010" & "00" & x"0040",
    "0010" & "00011" & "00000" & "00" & x"0003",
    others => (others => '0'));

  -- mov r1, 1
  -- cmpeq r2, r1, r0, 1

  constant myram8 : ram_t := (
    (others => '0'),
    "0010" & "00001" & "00000" & "00" & x"0001",
    "0000" & "00010" & "00001" & "00000" & x"01" & "11001",
    others => (others => '0'));

  constant myram9 : ram_t := (
x"2e80000c",
x"3ef40000",
x"ce830000",
x"00000000",
x"00000000",
x"00000000",
x"2180000a",
x"20800000",
x"21000001",
x"02040000",
x"00880000",
x"01088000",
x"018c0021",
x"d180fffb",
x"ffffffff",
others => (others => '0')
    );

  constant myram_fibrecur : ram_t := (
0 => x"2e800070",
1 => x"3ef40000",
2 => x"ce830000",
3 => x"0f780181",
4 => x"6e780000",
5 => x"0e84005a",
6 => x"de800014",
7 => x"60fcffff",
8 => x"00840021",
9 => x"6ff8ffff",
10 => x"0f780081",
11 => x"0ff80000",
12 => x"be03fff6",
13 => x"0f7c0080",
14 => x"8ff8ffff",
15 => x"60fcfffe",
16 => x"80fcffff",
17 => x"00840041",
18 => x"6ff8ffff",
19 => x"0f780081",
20 => x"0ff80000",
21 => x"be03ffed",
22 => x"0f7c0080",
23 => x"8ff8ffff",
24 => x"817cfffe",
25 => x"00844000",
26 => x"8e780000",
27 => x"ce030000",
28 => x"3f000040",
29 => x"3f800040",
30 => x"2080000a",
31 => x"6ff8ffff",
32 => x"0f780081",
33 => x"0ff80000",
34 => x"be03ffe0",
35 => x"0f7c0080",
36 => x"8ff8ffff",
37 => x"ffffffff",
others => (others => '0'));

  constant myram_loopback : ram_t := (
0 => x"2e80000c",
1 => x"3ef40000",
2 => x"ce830000",
3 => x"80800800",
4 => x"2100ffff",
5 => x"f088fffd",
6 => x"60800800",
7 => x"be83fffb",
others => (others => '0'));

  constant myram_ramtest : ram_t := (
0 => x"2e8000aa",
1 => x"6e801000",
2 => x"80801000",
3 => x"2e8000bb",
4 => x"6e801001",
5 => x"81001000",
6 => x"81801001",
7 => x"ffffffff",
others => (others => '0')
);

  constant myram_fib1 : ram_t := (
0 => x"2e800010",
1 => x"3ef40000",
2 => x"ce830000",
3 => x"ce030000",
4 => x"3f000040",
5 => x"3f800040",
6 => x"2080000a",
7 => x"6ff8ffff",
8 => x"0f780081",
9 => x"0ff80000",
10 => x"be03fff8",
11 => x"0f7c0080",
12 => x"8ff8ffff",
13 => x"ffffffff",
others => (others => '0')
    );

  constant myram_ramtest2 : ram_t := (
0 => x"2e8000aa",
1 => x"6e801000",
2 => x"80801000",
3 => x"00840020",
4 => x"ffffffff",
others => (others => '0')
);

  -- test cache (all hit)

  constant udon_ram_test : ram_t := (
0 => x"2e80000c",
1 => x"3ef40000",
2 => x"ce830000",
3 => x"3f000040",
4 => x"3f800040",
5 => x"20800000",
6 => x"21000000",
7 => x"0184021a",
8 => x"f180000f",
9 => x"21000000",
10 => x"0188021a",
11 => x"f180000a",
12 => x"2e800400",
13 => x"027fa001",
14 => x"018400c2",
15 => x"018c8000",
16 => x"02080042",
17 => x"018c8000",
18 => x"02044000",
19 => x"620c0000",
20 => x"01080020",
21 => x"be83fff4",
22 => x"00840020",
23 => x"be83ffef",
24 => x"20800000",
25 => x"21000000",
26 => x"0184021a",
27 => x"f180000f",
28 => x"21000000",
29 => x"0188021a",
30 => x"f1800009",
31 => x"2e800400",
32 => x"027fa001",
33 => x"018400c2",
34 => x"018c8000",
35 => x"02080042",
36 => x"018c8000",
37 => x"830c0000",
38 => x"01080020",
39 => x"be83fff5",
40 => x"2300ffff",
41 => x"00840020",
42 => x"be83ffef",
43 => x"ffffffff",
others => (others => '0')
);

  constant ramtest : ram_t := (
0 => x"2e80000c",
1 => x"3ef40000",
2 => x"ce830000",
3 => x"3f000040",
4 => x"3f800040",
5 => x"20800000",
6 => x"21000000",
7 => x"0188021a",
8 => x"f180000f",
9 => x"20800000",
10 => x"0184021a",
11 => x"f180000a",
12 => x"2e800400",
13 => x"027fa001",
14 => x"018400c2",
15 => x"018c8000",
16 => x"02080042",
17 => x"018c8000",
18 => x"02044000",
19 => x"620c0000",
20 => x"00840020",
21 => x"be83fff4",
22 => x"01080020",
23 => x"be83ffef",
24 => x"20800000",
25 => x"21000000",
26 => x"0188021a",
27 => x"f1800012",
28 => x"20800000",
29 => x"0184021a",
30 => x"f180000c",
31 => x"2e800400",
32 => x"027fa001",
33 => x"018400c2",
34 => x"018c8000",
35 => x"02080042",
36 => x"018c8000",
37 => x"830c0000",
38 => x"2e804000",
39 => x"018fa001",
40 => x"848c0000",
41 => x"00840020",
42 => x"be83fff2",
43 => x"2300ffff",
44 => x"01080020",
45 => x"be83ffec",
46 => x"ffffffff",
others => (others => '0')
);

  constant bootloader : ram_t := (
0 => x"2f000000",
1 => x"3f780040",
2 => x"2f800000",
3 => x"3ffc0040",
4 => x"80800800",
5 => x"0e84001a",
6 => x"de80fffd",
7 => x"81000800",
8 => x"0e88001a",
9 => x"de80fffd",
10 => x"81800800",
11 => x"0e8c001a",
12 => x"de80fffd",
13 => x"82000800",
14 => x"0e90001a",
15 => x"de80fffd",
16 => x"00840302",
17 => x"01080202",
18 => x"018c0102",
19 => x"00844000",
20 => x"018c8000",
21 => x"00846000",
22 => x"21000000",
23 => x"21803000",
24 => x"318c0000",
25 => x"f0880016",
26 => x"82800800",
27 => x"0e94001a",
28 => x"de80fffd",
29 => x"83000800",
30 => x"0e98001a",
31 => x"de80fffd",
32 => x"83800800",
33 => x"0e9c001a",
34 => x"de80fffd",
35 => x"84000800",
36 => x"0ea0001a",
37 => x"de80fffd",
38 => x"02940302",
39 => x"03180202",
40 => x"039c0102",
41 => x"0294c000",
42 => x"039d0000",
43 => x"0294e000",
44 => x"02086000",
45 => x"62900000",
46 => x"01080080",
47 => x"d08bffea",
48 => x"c1830000",
others => (others => '0')
);

  constant myram_bootloader_msg : ram_t := (
0 => x"20800062",
1 => x"2100006f",
2 => x"21800074",
3 => x"22000069",
4 => x"2280006e",
5 => x"23000067",
6 => x"2380002e",
7 => x"2400000d",
8 => x"2480000a",
9 => x"60800800",
10 => x"61000800",
11 => x"61000800",
12 => x"61800800",
13 => x"62000800",
14 => x"62800800",
15 => x"63000800",
16 => x"63800800",
17 => x"63800800",
18 => x"63800800",
19 => x"64000800",
20 => x"64800800",
21 => x"80800800",
22 => x"0e84001a",
23 => x"de80fffd",
24 => x"81000800",
25 => x"0e88001a",
26 => x"de80fffd",
27 => x"81800800",
28 => x"0e8c001a",
29 => x"de80fffd",
30 => x"82000800",
31 => x"0e90001a",
32 => x"de80fffd",
33 => x"00840302",
34 => x"01080202",
35 => x"018c0102",
36 => x"00844000",
37 => x"018c8000",
38 => x"00846000",
39 => x"21000000",
40 => x"21803000",
41 => x"318c0000",
42 => x"f0880016",
43 => x"82800800",
44 => x"0e94001a",
45 => x"de80fffd",
46 => x"83000800",
47 => x"0e98001a",
48 => x"de80fffd",
49 => x"83800800",
50 => x"0e9c001a",
51 => x"de80fffd",
52 => x"84000800",
53 => x"0ea0001a",
54 => x"de80fffd",
55 => x"02940302",
56 => x"03180202",
57 => x"039c0102",
58 => x"0294c000",
59 => x"039d0000",
60 => x"0294e000",
61 => x"02086000",
62 => x"62900000",
63 => x"01080080",
64 => x"d08bffea",
65 => x"2080006c",
66 => x"2100006f",
67 => x"21800061",
68 => x"22000064",
69 => x"22800065",
70 => x"23000021",
71 => x"2380000d",
72 => x"2400000a",
73 => x"60800800",
74 => x"61000800",
75 => x"61800800",
76 => x"62000800",
77 => x"62800800",
78 => x"62000800",
79 => x"63000800",
80 => x"63800800",
81 => x"64000800",
82 => x"2f000000",
83 => x"3f780040",
84 => x"2f800000",
85 => x"3ffc0040",
86 => x"c1830000",
others => (others => '0')
);

  signal ram : ram_t := myram_bootloader_msg;

  signal addr_reg : std_logic_vector(31 downto 0);
  signal addr_reg2 : std_logic_vector(31 downto 0);

begin

  process(clk)
  begin
    if rising_edge(clk) then
      if bram_in.we = '1' then
        ram(conv_integer(bram_in.addr(14 downto 2))) <= bram_in.val;
      end if;
      addr_reg  <= bram_in.addr;
      addr_reg2 <= bram_in.addr2;
    end if;
  end process;

  bram_out.rx  <= ram(conv_integer(addr_reg(14 downto 2)));
  bram_out.rx2 <= ram(conv_integer(addr_reg2(14 downto 2)));

end architecture;
