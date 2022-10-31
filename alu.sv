module alu(
    input [7:0] a,
    input [7:0] b,
    input [2:0] select_alu,
    output reg [7:0] result,
    output reg [3:0] psw                        /*{X S C Z}*/
);

    logic carry=0;
    logic sign=0;
always @(*)
begin
    case(select_alu)
    3'd0: {carry,result}=a+b;
    3'd1: 
    begin 
    {carry,result}=a-b; 
    psw[2]=carry|result[7];
    end
    3'd2: result=~a;
    3'd3: result=a<<b;
    3'd4: result=a>>b;
    3'd5: result=a&b;
    3'd6: result=a|b;
    3'd7: result=a^b;
    default: result=a+b;
    endcase
    psw[0]=(result==0)?1'b1:1'b0;
    psw[1]=carry;
    // psw[2]=(result>=0)?1'b0:1'b1;
    psw[3]=0;
end
endmodule

/*--------------------------testbench----------------------------------------------*/
// module tb;
    // logic [7:0] a,b,result;
    // logic [2:0] select_alu;
    // logic [3:0] psw;
    
    // alu a1(a,b,select_alu,result,psw);
    // initial
    // begin
        // a=127;b=128;
        // #5 
        // for(select_alu=0;select_alu<=7;select_alu++)
        // begin
            // #20;
            // if(select_alu==7)
            // break;
        // end
        // #5 a=128;b=128;
        // for(select_alu=0;select_alu<=7;select_alu++)
        // begin
            // #20;
            // if(select_alu==7)
            // break;
        // end
        
    // end
    
    // initial
        // $monitor("time =%0d  a=%0d      b=%0d     select_alu=%0d    result=%0d   psw=%b",$time,a,b,select_alu,result,psw);
    
// endmodule