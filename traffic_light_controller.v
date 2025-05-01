`timescale 1ns / 1ps

module traffic_light_controller (
    input clk,            
    input reset,         
    input car_detected,    
    output reg [1:0] main_light,  
    output reg [1:0] side_light   
);


reg [2:0] state;  

parameter s0 = 3'b000;  
parameter s1 = 3'b001;  
parameter s2 = 3'b010;  
parameter s3 = 3'b011;  
parameter s4 = 3'b100;  
parameter s5 = 3'b101;  


always @(posedge clk or negedge reset) begin
    if (reset) begin
        state = 3'b000;
        main_light = 2'b00;  // main green
        side_light = 2'b10;   // side red
    end
    else begin
            
        case (state)
            s0: begin
                if (car_detected == 1) begin
                    state = 3'b001;
                    #50
                    main_light = 2'b01;  // main yellow
                end
            end
                
            s1: begin
                state = 3'b010;
                #30
                main_light = 2'b10;  // main red
            end
             
            s2: begin
                state = 3'b011;
                #10
                side_light = 2'b00;  // side green
            end
                
            s3: begin
                state = 3'b100;
                #50
                side_light = 2'b01;  // side yellow
            end
                
            s4: begin
                state = 3'b101;
                #30
                side_light <= 2'b10;  // side red
            end
                
            s5: begin
                state = 3'b000;
                #10
                main_light = 2'b00;  // main green
            end
                
            default: begin
                state = 3'b000;  
                #50
                main_light = 2'b00;
                side_light = 2'b10;
            end
        endcase
    end
end

endmodule
