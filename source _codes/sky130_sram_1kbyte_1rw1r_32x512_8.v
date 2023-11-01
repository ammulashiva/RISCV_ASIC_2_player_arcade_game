// OpenRAM SRAM model
// Words: 512
// Word size: 32
// Write size: 8

module sky130_sram_2kbyte_1rw1r_32x512_8_inst(
`ifdef USE_POWER_PINS
    vccd1,
    vssd1,
`endif
// Port 0: RW
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
// Port 1: R
    clk1,csb1,addr1,dout1
  );

  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 32 ;
  parameter ADDR_WIDTH = 9 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  // FIXME: This delay is arbitrary.
  parameter DELAY = 0 ;
  parameter VERBOSE = 0 ; //Set to 0 to only display warnings
  parameter T_HOLD = 0 ; //Delay to hold dout value after posedge. Value is arbitrary

`ifdef USE_POWER_PINS
    inout vccd1;
    inout vssd1;
`endif
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [NUM_WMASKS-1:0]   wmask0; // write mask
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;
  input  clk1; // clock
  input   csb1; // active low chip select
  input [ADDR_WIDTH-1:0]  addr1;
  output [DATA_WIDTH-1:0] dout1;

  reg  csb0_reg;
  reg  web0_reg;
  reg [NUM_WMASKS-1:0]   wmask0_reg;
  reg [ADDR_WIDTH-1:0]  addr0_reg;
  reg [DATA_WIDTH-1:0]  din0_reg;
  reg [DATA_WIDTH-1:0]  dout0;

  // All inputs are registers
  always @(posedge clk0)
  begin
    csb0_reg = csb0;
    web0_reg = web0;
    wmask0_reg = wmask0;
    addr0_reg = addr0;
    din0_reg = din0;
    #(T_HOLD) dout0 = 32'bx;
    if ( !csb0_reg && web0_reg && VERBOSE ) 
      $display($time," Reading %m addr0=%b dout0=%b",addr0_reg,mem[addr0_reg]);
    if ( !csb0_reg && !web0_reg && VERBOSE )
      $display($time," Writing %m addr0=%b din0=%b wmask0=%b",addr0_reg,din0_reg,wmask0_reg);
  end

  reg  csb1_reg;
  reg [ADDR_WIDTH-1:0]  addr1_reg;
  reg [DATA_WIDTH-1:0]  dout1;

  // All inputs are registers
  always @(posedge clk1)
  begin
    csb1_reg = csb1;
    addr1_reg = addr1;
    if (!csb0 && !web0 && !csb1 && (addr0 == addr1))
         $display($time," WARNING: Writing and reading addr0=%b and addr1=%b simultaneously!",addr0,addr1);
    #(T_HOLD) dout1 = 32'bx;
    if ( !csb1_reg && VERBOSE ) 
      $display($time," Reading %m addr1=%b dout1=%b",addr1_reg,mem[addr1_reg]);
  end

reg [DATA_WIDTH-1:0]    mem [0:RAM_DEPTH-1];

initial
begin

    	mem[0] = 32'h00000000;
	mem[1] = 32'h00000000;
	mem[2] = 32'hfd010113;
	mem[3] = 32'h02112623;
	mem[4] = 32'h02812423;
	mem[5] = 32'h03010413;
	mem[6] = 32'h00100793;
	mem[7] = 32'hfef42623;
	mem[8] = 32'h00100793;
	mem[9] = 32'hfef42423;
	mem[10] = 32'hfe042223;
	mem[11] = 32'h03300793;
	mem[12] = 32'hfef42023;
	mem[13] = 32'h00100513;
	mem[14] = 32'h2e8000ef;
	mem[15] = 32'hfca42e23;
	mem[16] = 32'h00200513;
	mem[17] = 32'h2dc000ef;
	mem[18] = 32'hfca42c23;
	mem[19] = 32'hfdc42783;
	mem[20] = 32'h12078263;
	mem[21] = 32'hfd842783;
	mem[22] = 32'h10078e63;
	mem[23] = 32'hfec42703;
	mem[24] = 32'h00100793;
	mem[25] = 32'h04f71a63;
	mem[26] = 32'hfe842703;
	mem[27] = 32'h00100793;
	mem[28] = 32'h04f71463;
	mem[29] = 32'hfe042703;
	mem[30] = 32'hfe442783;
	mem[31] = 32'h40f70733;
	mem[32] = 32'h00100793;
	mem[33] = 32'h02e7f463;
	mem[34] = 32'hfe042783;
	mem[35] = 32'hfff78793;
	mem[36] = 32'hfef42023;
	mem[37] = 32'hfe042423;
	mem[38] = 32'hfe442783;
	mem[39] = 32'h00178793;
	mem[40] = 32'hfef42223;
	mem[41] = 32'hfe042623;
	mem[42] = 32'h0c80006f;
	mem[43] = 32'hfe042623;
	mem[44] = 32'hfe042423;
	mem[45] = 32'h0bc0006f;
	mem[46] = 32'hfec42783;
	mem[47] = 32'h04079c63;
	mem[48] = 32'hfe842703;
	mem[49] = 32'h00100793;
	mem[50] = 32'h04f71663;
	mem[51] = 32'hfe042703;
	mem[52] = 32'hfe442783;
	mem[53] = 32'h40f70733;
	mem[54] = 32'h00100793;
	mem[55] = 32'h00e7fc63;
	mem[56] = 32'hfe042783;
	mem[57] = 32'hfff78793;
	mem[58] = 32'hfef42023;
	mem[59] = 32'hfe042423;
	mem[60] = 32'h0800006f;
	mem[61] = 32'hfe042783;
	mem[62] = 32'hfff78793;
	mem[63] = 32'hfef42023;
	mem[64] = 32'hfe042423;
	mem[65] = 32'hfe442783;
	mem[66] = 32'hfff78793;
	mem[67] = 32'hfef42223;
	mem[68] = 32'h0600006f;
	mem[69] = 32'hfec42703;
	mem[70] = 32'h00100793;
	mem[71] = 32'h12f71e63;
	mem[72] = 32'hfe842783;
	mem[73] = 32'h12079a63;
	mem[74] = 32'hfe042703;
	mem[75] = 32'hfe442783;
	mem[76] = 32'h40f70733;
	mem[77] = 32'h00100793;
	mem[78] = 32'h00e7fc63;
	mem[79] = 32'hfe442783;
	mem[80] = 32'h00178793;
	mem[81] = 32'hfef42223;
	mem[82] = 32'hfe042623;
	mem[83] = 32'h10c0006f;
	mem[84] = 32'hfe442783;
	mem[85] = 32'h00178793;
	mem[86] = 32'hfef42223;
	mem[87] = 32'hfe042623;
	mem[88] = 32'hfe042783;
	mem[89] = 32'h00178793;
	mem[90] = 32'hfef42023;
	mem[91] = 32'h0ec0006f;
	mem[92] = 32'h0e80006f;
	mem[93] = 32'hfdc42783;
	mem[94] = 32'h06078263;
	mem[95] = 32'hfd842783;
	mem[96] = 32'h04079e63;
	mem[97] = 32'h00100793;
	mem[98] = 32'hfef42423;
	mem[99] = 32'hfec42783;
	mem[100] = 32'h0c078663;
	mem[101] = 32'hfe042703;
	mem[102] = 32'hfe442783;
	mem[103] = 32'h40f70733;
	mem[104] = 32'h00100793;
	mem[105] = 32'h00e7fc63;
	mem[106] = 32'hfe442783;
	mem[107] = 32'h00178793;
	mem[108] = 32'hfef42223;
	mem[109] = 32'hfe042623;
	mem[110] = 32'h0a40006f;
	mem[111] = 32'hfe442783;
	mem[112] = 32'h00178793;
	mem[113] = 32'hfef42223;
	mem[114] = 32'hfe042623;
	mem[115] = 32'hfe042783;
	mem[116] = 32'h00178793;
	mem[117] = 32'hfef42023;
	mem[118] = 32'h0840006f;
	mem[119] = 32'hfdc42783;
	mem[120] = 32'h06079263;
	mem[121] = 32'hfd842783;
	mem[122] = 32'h04078e63;
	mem[123] = 32'h00100793;
	mem[124] = 32'hfef42623;
	mem[125] = 32'hfe842783;
	mem[126] = 32'h06078263;
	mem[127] = 32'hfe042703;
	mem[128] = 32'hfe442783;
	mem[129] = 32'h40f70733;
	mem[130] = 32'h00100793;
	mem[131] = 32'h00e7fc63;
	mem[132] = 32'hfe042783;
	mem[133] = 32'hfff78793;
	mem[134] = 32'hfef42023;
	mem[135] = 32'hfe042423;
	mem[136] = 32'h03c0006f;
	mem[137] = 32'hfe042783;
	mem[138] = 32'hfff78793;
	mem[139] = 32'hfef42023;
	mem[140] = 32'hfe042423;
	mem[141] = 32'hfe442783;
	mem[142] = 32'hfff78793;
	mem[143] = 32'hfef42223;
	mem[144] = 32'h01c0006f;
	mem[145] = 32'h00100793;
	mem[146] = 32'hfef42623;
	mem[147] = 32'h00100793;
	mem[148] = 32'hfef42423;
	mem[149] = 32'h0080006f;
	mem[150] = 32'h00000013;
	mem[151] = 32'hfe442703;
	mem[152] = 32'h03200793;
	mem[153] = 32'h00e7e663;
	mem[154] = 32'hfe042783;
	mem[155] = 32'h0a079063;
	mem[156] = 32'h00100513;
	mem[157] = 32'h0ec000ef;
	mem[158] = 32'h1f400513;
	mem[159] = 32'h118000ef;
	mem[160] = 32'h00000513;
	mem[161] = 32'h0dc000ef;
	mem[162] = 32'h3e800513;
	mem[163] = 32'h108000ef;
	mem[164] = 32'hfe042223;
	mem[165] = 32'h03300793;
	mem[166] = 32'hfef42023;
	mem[167] = 32'hfe442503;
	mem[168] = 32'h15c000ef;
	mem[169] = 32'hfe042503;
	mem[170] = 32'h180000ef;
	mem[171] = 32'h00100513;
	mem[172] = 32'h0b0000ef;
	mem[173] = 32'h19000513;
	mem[174] = 32'h0dc000ef;
	mem[175] = 32'h00000513;
	mem[176] = 32'h0a0000ef;
	mem[177] = 32'h25800513;
	mem[178] = 32'h0cc000ef;
	mem[179] = 32'h00100513;
	mem[180] = 32'h090000ef;
	mem[181] = 32'h19000513;
	mem[182] = 32'h0bc000ef;
	mem[183] = 32'h00000513;
	mem[184] = 32'h080000ef;
	mem[185] = 32'h25800513;
	mem[186] = 32'h0ac000ef;
	mem[187] = 32'h00100513;
	mem[188] = 32'h070000ef;
	mem[189] = 32'h19000513;
	mem[190] = 32'h09c000ef;
	mem[191] = 32'h00000513;
	mem[192] = 32'h060000ef;
	mem[193] = 32'h25800513;
	mem[194] = 32'h08c000ef;
	mem[195] = 32'hfe442503;
	mem[196] = 32'h0ec000ef;
	mem[197] = 32'hfe042503;
	mem[198] = 32'h110000ef;
	mem[199] = 32'hd19ff06f;
	mem[200] = 32'hfd010113;
	mem[201] = 32'h02812623;
	mem[202] = 32'h03010413;
	mem[203] = 32'hfca42e23;
	mem[204] = 32'hfdc42783;
	mem[205] = 32'h00479793;
	mem[206] = 32'hfef42623;
	mem[207] = 32'hfec42783;
	mem[208] = 32'h000f0e93;
	mem[209] = 32'h00fef7b3;
	mem[210] = 32'hfef42423;
	mem[211] = 32'hfe842783;
	mem[212] = 32'h00078513;
	mem[213] = 32'h02c12403;
	mem[214] = 32'h03010113;
	mem[215] = 32'h00008067;
	mem[216] = 32'hfd010113;
	mem[217] = 32'h02812623;
	mem[218] = 32'h03010413;
	mem[219] = 32'hfca42e23;
	mem[220] = 32'hfdc42783;
	mem[221] = 32'h00279793;
	mem[222] = 32'hfef42623;
	mem[223] = 32'hfec42783;
	mem[224] = 32'h00ff6f33;
	mem[225] = 32'h00000013;
	mem[226] = 32'h02c12403;
	mem[227] = 32'h03010113;
	mem[228] = 32'h00008067;
	mem[229] = 32'hfd010113;
	mem[230] = 32'h02812623;
	mem[231] = 32'h03010413;
	mem[232] = 32'hfca42e23;
	mem[233] = 32'hfe042623;
	mem[234] = 32'hfe042423;
	mem[235] = 32'h000f0e93;
	mem[236] = 32'h040ef793;
	mem[237] = 32'hfef42223;
	mem[238] = 32'hfe842703;
	mem[239] = 32'hfe442783;
	mem[240] = 32'h00f70c63;
	mem[241] = 32'hfe442783;
	mem[242] = 32'hfef42423;
	mem[243] = 32'hfec42783;
	mem[244] = 32'h00178793;
	mem[245] = 32'hfef42623;
	mem[246] = 32'hfec42783;
	mem[247] = 32'hfdc42703;
	mem[248] = 32'h00f70463;
	mem[249] = 32'hfc9ff06f;
	mem[250] = 32'h00000013;
	mem[251] = 32'h00000013;
	mem[252] = 32'h02c12403;
	mem[253] = 32'h03010113;
	mem[254] = 32'h00008067;
	mem[255] = 32'hfe010113;
	mem[256] = 32'h00812e23;
	mem[257] = 32'h02010413;
	mem[258] = 32'hfea42623;
	mem[259] = 32'hfec42783;
	mem[260] = 32'h01479513;
	mem[261] = 32'h00af6f33;
	mem[262] = 32'h00000013;
	mem[263] = 32'h01c12403;
	mem[264] = 32'h02010113;
	mem[265] = 32'h00008067;
	mem[266] = 32'hfe010113;
	mem[267] = 32'h00812e23;
	mem[268] = 32'h02010413;
	mem[269] = 32'hfea42623;
	mem[270] = 32'hfec42783;
	mem[271] = 32'h01a79593;
	mem[272] = 32'h00bf6f33;
	mem[273] = 32'h00000013;
	mem[274] = 32'h01c12403;
	mem[275] = 32'h02010113;
	mem[276] = 32'h00008067;
	mem[277] = 32'hffffffff;
	mem[278] = 32'hffffffff;

  end

  // Memory Write Block Port 0
  // Write Operation : When web0 = 0, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_WRITE0
    if ( !csb0_reg && !web0_reg ) begin
        if (wmask0_reg[0])
                mem[addr0_reg][7:0] = din0_reg[7:0];
        if (wmask0_reg[1])
                mem[addr0_reg][15:8] = din0_reg[15:8];
        if (wmask0_reg[2])
                mem[addr0_reg][23:16] = din0_reg[23:16];
        if (wmask0_reg[3])
                mem[addr0_reg][31:24] = din0_reg[31:24];
    end
  end

  // Memory Read Block Port 0
  // Read Operation : When web0 = 1, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_READ0
    if (!csb0_reg && web0_reg)
       dout0 <= #(DELAY) mem[addr0_reg];
  end

  // Memory Read Block Port 1
  // Read Operation : When web1 = 1, csb1 = 0
  always @ (negedge clk1)
  begin : MEM_READ1
    if (!csb1_reg)
       dout1 <= #(DELAY) mem[addr1_reg];
  end

endmodule


// OpenRAM SRAM model
// Words: 512
// Word size: 32
// Write size: 8

module sky130_sram_2kbyte_1rw1r_32x512_8_data(
`ifdef USE_POWER_PINS
    vccd1,
    vssd1,
`endif
// Port 0: RW
    clk0,csb0,web0,wmask0,addr0,din0,dout0,
// Port 1: R
    clk1,csb1,addr1,dout1
  );

  parameter NUM_WMASKS = 4 ;
  parameter DATA_WIDTH = 32 ;
  parameter ADDR_WIDTH = 9 ;
  parameter RAM_DEPTH = 1 << ADDR_WIDTH;
  // FIXME: This delay is arbitrary.
  parameter DELAY = 0 ;
  parameter VERBOSE = 0 ; //Set to 0 to only display warnings
  parameter T_HOLD = 0 ; //Delay to hold dout value after posedge. Value is arbitrary

`ifdef USE_POWER_PINS
    inout vccd1;
    inout vssd1;
`endif
  input  clk0; // clock
  input   csb0; // active low chip select
  input  web0; // active low write control
  input [NUM_WMASKS-1:0]   wmask0; // write mask
  input [ADDR_WIDTH-1:0]  addr0;
  input [DATA_WIDTH-1:0]  din0;
  output [DATA_WIDTH-1:0] dout0;
  input  clk1; // clock
  input   csb1; // active low chip select
  input [ADDR_WIDTH-1:0]  addr1;
  output [DATA_WIDTH-1:0] dout1;

  reg  csb0_reg;
  reg  web0_reg;
  reg [NUM_WMASKS-1:0]   wmask0_reg;
  reg [ADDR_WIDTH-1:0]  addr0_reg;
  reg [DATA_WIDTH-1:0]  din0_reg;
  reg [DATA_WIDTH-1:0]  dout0;

  // All inputs are registers
  always @(posedge clk0)
  begin
    csb0_reg = csb0;
    web0_reg = web0;
    wmask0_reg = wmask0;
    addr0_reg = addr0;
    din0_reg = din0;
    #(T_HOLD) dout0 = 32'bx;
    if ( !csb0_reg && web0_reg && VERBOSE ) 
      $display($time," Reading %m addr0=%b dout0=%b",addr0_reg,mem[addr0_reg]);
    if ( !csb0_reg && !web0_reg && VERBOSE )
      $display($time," Writing %m addr0=%b din0=%b wmask0=%b",addr0_reg,din0_reg,wmask0_reg);
  end

  reg  csb1_reg;
  reg [ADDR_WIDTH-1:0]  addr1_reg;
  reg [DATA_WIDTH-1:0]  dout1;

  // All inputs are registers
  always @(posedge clk1)
  begin
    csb1_reg = csb1;
    addr1_reg = addr1;
    if (!csb0 && !web0 && !csb1 && (addr0 == addr1))
         $display($time," WARNING: Writing and reading addr0=%b and addr1=%b simultaneously!",addr0,addr1);
    #(T_HOLD) dout1 = 32'bx;
    if ( !csb1_reg && VERBOSE ) 
      $display($time," Reading %m addr1=%b dout1=%b",addr1_reg,mem[addr1_reg]);
  end

reg [DATA_WIDTH-1:0]    mem [0:RAM_DEPTH-1];

  // Memory Write Block Port 0
  // Write Operation : When web0 = 0, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_WRITE0
    if ( !csb0_reg && !web0_reg ) begin
        if (wmask0_reg[0])
                mem[addr0_reg][7:0] = din0_reg[7:0];
        if (wmask0_reg[1])
                mem[addr0_reg][15:8] = din0_reg[15:8];
        if (wmask0_reg[2])
                mem[addr0_reg][23:16] = din0_reg[23:16];
        if (wmask0_reg[3])
                mem[addr0_reg][31:24] = din0_reg[31:24];
    end
  end

  // Memory Read Block Port 0
  // Read Operation : When web0 = 1, csb0 = 0
  always @ (negedge clk0)
  begin : MEM_READ0
    if (!csb0_reg && web0_reg)
       dout0 <= #(DELAY) mem[addr0_reg];
  end

  // Memory Read Block Port 1
  // Read Operation : When web1 = 1, csb1 = 0
  always @ (negedge clk1)
  begin : MEM_READ1
    if (!csb1_reg)
       dout1 <= #(DELAY) mem[addr1_reg];
  end

endmodule
