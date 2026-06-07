`timescale 1ns/1ps

module elevator_controller_tb;

    logic clk;
    logic rst;
    logic emergency;
    logic [1:0] request_floor;

    wire [1:0] current_floor;
    wire [1:0] state;

    //--------------------------------------------------
    // DUT
    //--------------------------------------------------

    elevator_controller dut (
        .clk(clk),
        .rst(rst),
        .emergency(emergency),
        .request_floor(request_floor),
        .current_floor(current_floor),
        .state(state)
    );

    //--------------------------------------------------
    // Clock Generation
    //--------------------------------------------------

    always #5 clk = ~clk;

    //--------------------------------------------------
    // Task
    //--------------------------------------------------

    task display_status;
        begin
            $display(
            "TIME=%0t STATE=%0d CURRENT=%0d REQUEST=%0d EMERGENCY=%0d",
            $time,state,current_floor,request_floor,emergency);
        end
    endtask

    //--------------------------------------------------
    // Test Sequence
    //--------------------------------------------------

    initial begin

        clk = 0;
        rst = 1;
        emergency = 0;
        request_floor = 0;

        //----------------------------------------------
        // Reset
        //----------------------------------------------

        #20;
        rst = 0;

        $display("\nTEST-1 : Ground -> Third Floor");

        request_floor = 2'd3;

        repeat(5)
        begin
            @(posedge clk);
            display_status();
        end

        //----------------------------------------------
        // Third -> First Floor
        //----------------------------------------------

        $display("\nTEST-2 : Third Floor -> First Floor");

        request_floor = 2'd1;

        repeat(5)
        begin
            @(posedge clk);
            display_status();
        end

        //----------------------------------------------
        // Emergency
        //----------------------------------------------

        $display("\nTEST-3 : Emergency Condition");

        emergency = 1;

        repeat(3)
        begin
            @(posedge clk);
            display_status();
        end

        emergency = 0;

        repeat(2)
        begin
            @(posedge clk);
            display_status();
        end

        //----------------------------------------------
        // First -> Ground
        //----------------------------------------------

        $display("\nTEST-4 : First Floor -> Ground");

        request_floor = 2'd0;

        repeat(5)
        begin
            @(posedge clk);
            display_status();
        end

        //----------------------------------------------
        // Same Floor Request
        //----------------------------------------------

        $display("\nTEST-5 : Same Floor Request");

        request_floor = current_floor;

        repeat(3)
        begin
            @(posedge clk);
            display_status();
        end

        $display("\nALL TESTS COMPLETED");

        #20;
        $finish;

    end

  //--------------------------------------------------
// Dump File for EPWave
//--------------------------------------------------

initial begin
    $dumpfile("elevator_controller.vcd");
    $dumpvars(0, elevator_controller_tb);
end

endmodule
