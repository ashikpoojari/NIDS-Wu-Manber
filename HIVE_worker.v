

module WuManber_Worker
(
  input clk,
  input rst,
  input [160-1:0] din,
  output [1-1:0] rom_out,
  input [1-1:0] datInReady,
  output [8-1:0] shift_out
);

  reg [6-1:0] Pointer;
  reg [80-1:0] data_PatIn;

  always @(posedge clk) begin
    case(Pointer)
      6'h0: begin
        data_PatIn <= din[79:0];
      end
      6'h1: begin
        data_PatIn <= din[83:4];
      end
      6'h2: begin
        data_PatIn <= din[87:8];
      end
      6'h3: begin
        data_PatIn <= din[91:12];
      end
      6'h4: begin
        data_PatIn <= din[95:16];
      end
      6'h5: begin
        data_PatIn <= din[99:20];
      end
      6'h6: begin
        data_PatIn <= din[103:24];
      end
      6'h7: begin
        data_PatIn <= din[107:28];
      end
      6'h8: begin
        data_PatIn <= din[111:32];
      end
      6'h9: begin
        data_PatIn <= din[115:36];
      end
      6'ha: begin
        data_PatIn <= din[119:40];
      end
      6'hb: begin
        data_PatIn <= din[123:44];
      end
      6'hc: begin
        data_PatIn <= din[127:48];
      end
      6'hd: begin
        data_PatIn <= din[131:52];
      end
      6'he: begin
        data_PatIn <= din[135:56];
      end
      6'hf: begin
        data_PatIn <= din[139:60];
      end
      6'h10: begin
        data_PatIn <= din[143:64];
      end
      6'h11: begin
        data_PatIn <= din[147:68];
      end
      6'h12: begin
        data_PatIn <= din[151:72];
      end
      6'h13: begin
        data_PatIn <= din[155:76];
      end
      6'h14: begin
        data_PatIn <= din[159:80];
      end
    endcase
  end


  patterhash
  hash_rom
  (
    .clk(clk),
    .rst(rst),
    .pattern(data_PatIn),
    .rom_out(rom_out)
  );


  shifthash
  shift_rom
  (
    .clk(clk),
    .dataout(shift_out),
    .rom_addr(din[11:0])
  );

  reg [1-1:0] data_ld;
  wire [160-1:0] dataR_out;

  Data_Reg
  DatReg
  (
    .clk(clk),
    .rst(rst),
    .Data_in(din),
    .Data_ld(data_ld),
    .Data_out(dataR_out)
  );

  reg [32-1:0] fsm;
  localparam fsm_init = 0;
  localparam fsm_1 = 1;
  localparam fsm_2 = 2;
  localparam fsm_3 = 3;

  always @(posedge clk) begin
    if(rst) begin
      fsm <= fsm_init;
    end else begin
      case(fsm)
        fsm_init: begin
          if(datInReady) begin
            data_ld <= 1;
          end 
          if(datInReady) begin
            fsm <= fsm_1;
          end 
        end
        fsm_1: begin
          data_ld <= 0;
          Pointer <= 0;
          fsm <= fsm_2;
        end
        fsm_2: begin
          Pointer <= Pointer + shift_out;
          fsm <= fsm_3;
        end
        fsm_3: begin
          if(Pointer < 40) begin
            fsm <= fsm_2;
          end else begin
            fsm <= fsm_init;
          end
        end
      endcase
    end
  end


endmodule



module patterhash
(
  input clk,
  input rst,
  input [80-1:0] pattern,
  output reg [1-1:0] rom_out
);

  wire [5-1:0] dout_w;

  hash_rom0
  hash_rom0
  (
    .clk(clk),
    .rom_out(dout_w[0]),
    .rom_addr(pattern[79:64])
  );


  hash_rom1
  hash_rom1
  (
    .clk(clk),
    .rom_out(dout_w[1]),
    .rom_addr(pattern[63:48])
  );


  hash_rom2
  hash_rom2
  (
    .clk(clk),
    .rom_out(dout_w[2]),
    .rom_addr(pattern[47:32])
  );


  hash_rom3
  hash_rom3
  (
    .clk(clk),
    .rom_out(dout_w[3]),
    .rom_addr(pattern[31:16])
  );


  hash_rom4
  hash_rom4
  (
    .clk(clk),
    .rom_out(dout_w[4]),
    .rom_addr(pattern[15:0])
  );


  always @(posedge clk) begin
    if(rst) begin
      rom_out <= 0;
    end else begin
      rom_out <= &dout_w;
    end
  end


endmodule



module hash_rom0
(
  input clk,
  output reg [1-1:0] rom_out,
  input [16-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      16'h21b8: begin
        rom_out <= 1'h1;
      end
      16'h8bfd: begin
        rom_out <= 1'h1;
      end
      16'hb300: begin
        rom_out <= 1'h1;
      end
      16'hee50: begin
        rom_out <= 1'h1;
      end
      default: begin
        rom_out <= 1'h0;
      end
    endcase
  end


endmodule



module hash_rom1
(
  input clk,
  output reg [1-1:0] rom_out,
  input [16-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      16'h42: begin
        rom_out <= 1'h1;
      end
      16'h5a8b: begin
        rom_out <= 1'h1;
      end
      16'h83c7: begin
        rom_out <= 1'h1;
      end
      16'hf7d8: begin
        rom_out <= 1'h1;
      end
      default: begin
        rom_out <= 1'h0;
      end
    endcase
  end


endmodule



module hash_rom2
(
  input clk,
  output reg [1-1:0] rom_out,
  input [16-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      16'h250f: begin
        rom_out <= 1'h1;
      end
      16'h2d51: begin
        rom_out <= 1'h1;
      end
      16'h33c9: begin
        rom_out <= 1'h1;
      end
      16'h4e27: begin
        rom_out <= 1'h1;
      end
      default: begin
        rom_out <= 1'h0;
      end
    endcase
  end


endmodule



module hash_rom3
(
  input clk,
  output reg [1-1:0] rom_out,
  input [16-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      16'h8b: begin
        rom_out <= 1'h1;
      end
      16'h5757: begin
        rom_out <= 1'h1;
      end
      16'h99cd: begin
        rom_out <= 1'h1;
      end
      16'hb440: begin
        rom_out <= 1'h1;
      end
      default: begin
        rom_out <= 1'h0;
      end
    endcase
  end


endmodule



module hash_rom4
(
  input clk,
  output reg [1-1:0] rom_out,
  input [16-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      16'h218b: begin
        rom_out <= 1'h1;
      end
      16'hc858: begin
        rom_out <= 1'h1;
      end
      16'hcd21: begin
        rom_out <= 1'h1;
      end
      16'he8b3: begin
        rom_out <= 1'h1;
      end
      default: begin
        rom_out <= 1'h0;
      end
    endcase
  end


endmodule



module shifthash
(
  input clk,
  output reg [8-1:0] dataout,
  input [12-1:0] rom_addr
);


  always @(posedge clk) begin
    case(rom_addr)
      12'h4: begin
        dataout <= 8'hd;
      end
      12'h5: begin
        dataout <= 8'hf;
      end
      12'h8: begin
        dataout <= 8'h5;
      end
      12'h42: begin
        dataout <= 8'hc;
      end
      12'h5a: begin
        dataout <= 8'he;
      end
      12'h8b: begin
        dataout <= 8'h4;
      end
      12'hcd: begin
        dataout <= 8'h2;
      end
      12'hf0: begin
        dataout <= 8'h7;
      end
      12'hf7: begin
        dataout <= 8'he;
      end
      12'h157: begin
        dataout <= 8'h6;
      end
      12'h1b8: begin
        dataout <= 8'h10;
      end
      12'h218: begin
        dataout <= 8'h1;
      end
      12'h21b: begin
        dataout <= 8'h11;
      end
      12'h233: begin
        dataout <= 8'ha;
      end
      12'h250: begin
        dataout <= 8'h9;
      end
      12'h27b: begin
        dataout <= 8'h7;
      end
      12'h2d5: begin
        dataout <= 8'h9;
      end
      12'h300: begin
        dataout <= 8'h10;
      end
      12'h33c: begin
        dataout <= 8'h9;
      end
      12'h3c7: begin
        dataout <= 8'hc;
      end
      12'h3c9: begin
        dataout <= 8'h8;
      end
      12'h40c: begin
        dataout <= 8'h3;
      end
      12'h423: begin
        dataout <= 8'hb;
      end
      12'h440: begin
        dataout <= 8'h4;
      end
      12'h4e2: begin
        dataout <= 8'h9;
      end
      12'h50f: begin
        dataout <= 8'h8;
      end
      12'h515: begin
        dataout <= 8'h7;
      end
      12'h575: begin
        dataout <= 8'h5;
      end
      12'h57e: begin
        dataout <= 8'h3;
      end
      12'h5a8: begin
        dataout <= 8'hd;
      end
      12'h72d: begin
        dataout <= 8'ha;
      end
      12'h757: begin
        dataout <= 8'h4;
      end
      12'h7b4: begin
        dataout <= 8'h6;
      end
      12'h7d8: begin
        dataout <= 8'hc;
      end
      12'h7e8: begin
        dataout <= 8'h2;
      end
      12'h800: begin
        dataout <= 8'he;
      end
      12'h825: begin
        dataout <= 8'ha;
      end
      12'h83c: begin
        dataout <= 8'hd;
      end
      12'h8b4: begin
        dataout <= 8'hb;
      end
      12'h8bc: begin
        dataout <= 8'h3;
      end
      12'h8bf: begin
        dataout <= 8'h11;
      end
      12'h999: begin
        dataout <= 8'h6;
      end
      12'h99c: begin
        dataout <= 8'h5;
      end
      12'h9cd: begin
        dataout <= 8'h4;
      end
      12'ha8b: begin
        dataout <= 8'hc;
      end
      12'hb30: begin
        dataout <= 8'h11;
      end
      12'hb44: begin
        dataout <= 8'h5;
      end
      12'hb4e: begin
        dataout <= 8'ha;
      end
      12'hb80: begin
        dataout <= 8'hf;
      end
      12'hbc8: begin
        dataout <= 8'h2;
      end
      12'hbfd: begin
        dataout <= 8'h10;
      end
      12'hc72: begin
        dataout <= 8'hb;
      end
      12'hc85: begin
        dataout <= 8'h1;
      end
      12'hc99: begin
        dataout <= 8'h7;
      end
      12'hcd2: begin
        dataout <= 8'h1;
      end
      12'hd21: begin
        dataout <= 8'h2;
      end
      12'hd51: begin
        dataout <= 8'h8;
      end
      12'hd82: begin
        dataout <= 8'hb;
      end
      12'hd83: begin
        dataout <= 8'he;
      end
      12'he27: begin
        dataout <= 8'h8;
      end
      12'he50: begin
        dataout <= 8'h10;
      end
      12'he8b: begin
        dataout <= 8'h1;
      end
      12'hee5: begin
        dataout <= 8'h11;
      end
      12'hf00: begin
        dataout <= 8'h6;
      end
      12'hf7d: begin
        dataout <= 8'hd;
      end
      12'hfd8: begin
        dataout <= 8'hf;
      end
      default: begin
        dataout <= 8'h12;
      end
    endcase
  end


endmodule



module Data_Reg
(
  input clk,
  input rst,
  input [160-1:0] Data_in,
  input Data_ld,
  output reg [160-1:0] Data_out
);


  always @(posedge clk) begin
    if(rst) begin
      Data_out <= 0;
    end else begin
      if(Data_ld) begin
        Data_out <= Data_in;
      end 
    end
  end


endmodule

