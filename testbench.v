module testbench;

parameter NO_OF_MSGS=128, MSG_WIDTH=4, B=3, PATTERN_WIDTH=74, SIGN_DEPTH=128,
										SHIFT_WIDTH=$clog2(PATTERN_WIDTH-B+1),DATA_WIDTH=MSG_WIDTH*NO_OF_MSGS,
										NOS_SHIFTER=2*NO_OF_MSGS,	POINTER_WIDTH=$clog2(NOS_SHIFTER), NOS_KEY=4, NOS_CMPS=SIGN_DEPTH/NOS_KEY,NOS_STGS=$clog2(SIGN_DEPTH/NOS_KEY),SFT_DEL_WDH=$clog2(NOS_STGS+NOS_KEY+2),MAX_PAT_SZ=78;

localparam clk_prd = 2, nos_inputs=80;

reg clk;
reg reset;
reg datInReady;
reg [DATA_WIDTH-1:0] DataIn;
wire getDATA;
wire [NOS_STGS:1] fullCompare;
wire [POINTER_WIDTH-1:0] shift_pnt;
wire [6:0]dout;
reg [DATA_WIDTH-1:0] ram [nos_inputs-1:0];
integer i=0;

Wu_Manber_shiftPE #(NO_OF_MSGS,MSG_WIDTH,B,PATTERN_WIDTH, SIGN_DEPTH,SHIFT_WIDTH,DATA_WIDTH,NOS_SHIFTER,POINTER_WIDTH,NOS_KEY,NOS_CMPS,NOS_STGS,SFT_DEL_WDH,MAX_PAT_SZ)
		uut (.clk(clk), 
			.reset(reset),
			.datInReady(datInReady),
			.DataIn(DataIn),
			.getDATA(getDATA),
			.fullCompare(fullCompare),
			.shift_pnt(shift_pnt),
			.dout(dout)
		);

initial begin
  $readmemh("/home/ashikpoojari/Desktop/xilinx_codes/codes100/input.txt", ram); // memory_list is memory file
end

initial begin
	
	clk <= 1'b1;
	reset <= 1'b0;
	datInReady <=  1'b0;
	
	#(2*clk_prd) reset <= 1'b1; 
	#(4*clk_prd) reset <= 1'b0;
	#(5*clk_prd) datInReady <= 1'b1;
	#(1*clk_prd) datInReady <= 1'b0;
	
end

always 
	#(clk_prd/2) clk <= ~clk;

always@(getDATA)begin
	if(getDATA)begin
		DataIn=ram[i];
		i=i+1;
	end
end

endmodule