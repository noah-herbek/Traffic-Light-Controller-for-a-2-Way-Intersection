`timescale 1ns / 1ps

module traffic_light_controller_sim();
    reg clk;
    reg reset;
    reg car_detected;
    wire [1:0] main_light;
    wire [1:0] side_light;
    
    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .car_detected(car_detected),
        .main_light(main_light),
        .side_light(side_light)
    );
    
    always #5 clk = ~clk;
    
    initial begin
    
        // Initialize Inputs
        clk = 0;
        reset = 1;
        car_detected = 0;
        
        #100 
        reset = 0; // Release reset after 100ns
        
        #100;// Wait for initial state to stabilize
        
        car_detected = 1; // Test case: pulse car_detected
        #125 
        car_detected = 0;
        
        #200; // Run simulation for enough time to observe behavior
        
        car_detected = 1; // Test case: pulse car_detected
        #125 
        car_detected = 0;
        
        #750;// Run simulation for enough time to observe behavior
        
        $finish;
    end
endmodule
