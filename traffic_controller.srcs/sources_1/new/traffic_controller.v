`timescale 1ns / 1ps

//Member 1
//Name: Sarthak Ratnakar Deore 
//Roll_no: B20EE058

//Member 2 
//Name: Uday Bhanu
//Roll_no: B20EE075

module traffic_controller(s1,s2,s3,s4,r1,r2,r3,r4,g1,g2,g3,g4,clk,new_clk); 

input s1,s2,s3,s4;                              //Sensors to detect if road is empty 
input clk;                                      //Input clock 
output reg r1,r2,r3,r4;                         //Red lights for entry roads at the junction
output reg g1,g2,g3,g4;                         //Green lights for exit roads at the junction 
output new_clk;                                   //Clock with frequency 1Hz
parameter S1=0,S2=1,S3=2,S4=3;                  //The states of the FSM
reg [2:0]ps;                                    //Register to store the current state
reg [6:0]timer=0;                             //Register to store timer for next state to come                    


// Frequency divider to bring down clock rate
reg [26:0]count = 0;
assign new_clk = count[26];
always@(posedge clk)
count <= count + 1;

// Updating the states
always@(posedge new_clk)
begin
case(ps)
                S1: if(timer<2 && (s1!=1 && s2!=1))
                        begin 
                            ps<=S1;
                            timer<=timer+1;
                        end
                    else
                        begin
                        ps<=S2;
                        timer<=0;
                        end
                        
                S2: if(timer<2 && (s3!=1 && s4!=1))
                        begin 
                            ps<=S2;
                            timer<=timer+1;
                        end
                    else
                        begin
                        ps<=S3;
                        timer<=0;
                        end
                        
                S3: if(timer<2 && (s1!=1 && s4!=1))
                        begin 
                            ps<=S3;
                            timer<=timer+1;
                        end
                    else
                        begin
                        ps<=S4;
                        timer<=0;
                        end
                        
                 S4: if(timer<2 && (s2!=1 && s3!=1))
                        begin 
                            ps<=S4;
                            timer<=timer+1;
                        end
                    else
                        begin
                        ps<=S1;
                        timer<=0;
                        end
                 
                 default: ps<=S1;
                endcase
            end 

// Describing the states
always@(ps)    
          begin
                
                case(ps)
                     
                    S1:
                    begin
                       r1<=0;g1<=1;
                       r2<=0;g2<=1;
                       r3<=1;g3<=0;
                       r4<=1;g4<=0;
                    end
                    S2:
                    begin 
                       r1<=1;g1<=0;
                       r2<=1;g2<=0;
                       r3<=0;g3<=1;
                       r4<=0;g4<=1;
                    end
                    S3:
                    begin
                       r1<=0;g1<=1;
                       r2<=1;g2<=0;
                       r3<=1;g3<=0;
                       r4<=0;g4<=1;
                    end
                    S4:
                    begin
                       r1<=1;g1<=0;
                       r2<=0;g2<=1;
                       r3<=0;g3<=1;
                       r4<=1;g4<=0;
                    end
            endcase
      end
endmodule

