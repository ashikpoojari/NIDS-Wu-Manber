// -----------------------------------------------------------------------------
// FILE NAME      :	Wu_Manber_selector.v
// DEPARTMENT     : Computer Engineering
// AUTHOR         : Ashik Poojari
// -----------------------------------------------------------------------------
// RELEASE HISTORY
// VERSION DATE        AUTHOR  DESCRIPTION
// 1.0     2016-09-18  Ashik Poojari       
// -----------------------------------------------------------------------------
// KEYWORDS    : General file searching keywords, leave blank if none.
// -----------------------------------------------------------------------------
// PURPOSE     : Short description of functionality
// -----------------------------------------------------------------------------
// PARAMETERS
//     PARAM NAME      RANGE    : DESCRIPTION       : DEFAULT : UNITS
// e.g.DATA_WIDTH     [32,16]   : width of the data : 32      :
//		WIDTH 		   Any    	: width of the data input 
// -----------------------------------------------------------------------------
// REUSE ISSUES
//   Reset Strategy        : synchronous
//   Clock Domains         :
//   Critical Timing       :
//   Test Features         :
//   Asynchronous I/F      :
//   Scan Methodology      :
//   Instantiations        :
//   Synthesizable (y/n)   : y
//   Other                 :
// -FHDR------------------------------------------------------------------------

module mux #(parameter WIDTH=8) (
								input clk,
								input rst,  
								input [WIDTH-1:0] a, 
								input [WIDTH-1:0] b, 
								output reg [WIDTH-1:0] c);


wire [WIDTH-1:0] c_wire;

always @(posedge clk) begin
	if (rst) begin
		c <= 0;
	end
	else begin
		c <= c_wire;
	end
end

assign c_wire = (a<b) ? a : b ;

endmodule