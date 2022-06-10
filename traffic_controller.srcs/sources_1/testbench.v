`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.05.2022 18:26:22
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench();


reg s1,s2,s3,s4;                         
reg clk;                                    
wire r1,r2,r3,r4;                         
wire g1,g2,g3,g4;  


 traffic_controller uut(s1,s2,s3,s4,r1,r2,r3,r4,g1,g2,g3,g4,clk); 

initial begin
clk = 0;
end

always #10 clk=~clk;

initial begin
    s1=1;s2=1;s3=0;s4=0;
#40 s1=1;s2=1;s3=1;s4=1;
#40 s1=0;s2=0;s3=0;s4=0;
#40 s1=1;s2=0;s3=1;s4=1;
#40 s1=0;s2=1;s3=1;s4=1;

#40 $stop;
end
endmodule
