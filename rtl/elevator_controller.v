`timescale 1ns/1ps

module elevator_controller (

    input  wire       clk,
    input  wire       rst,
    input  wire       emergency,
    input  wire [1:0] request_floor,

    output reg  [1:0] current_floor,
    output reg  [1:0] state

);

    //--------------------------------------------------
    // State Encoding
    //--------------------------------------------------

    parameter IDLE      = 2'b00;
    parameter MOVE_UP   = 2'b01;
    parameter MOVE_DOWN = 2'b10;
    parameter EMERGENCY = 2'b11;

    reg [1:0] next_state;

    //--------------------------------------------------
    // State Register
    //--------------------------------------------------

    always @(posedge clk or posedge rst)
    begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    //--------------------------------------------------
    // Next State Logic
    //--------------------------------------------------

    always @(*)
    begin

        next_state = state;

        case(state)

            //------------------------------------------
            // IDLE
            //------------------------------------------

            IDLE:
            begin
                if (emergency)
                    next_state = EMERGENCY;

                else if (request_floor > current_floor)
                    next_state = MOVE_UP;

                else if (request_floor < current_floor)
                    next_state = MOVE_DOWN;

                else
                    next_state = IDLE;
            end

            //------------------------------------------
            // MOVE UP
            //------------------------------------------

            MOVE_UP:
            begin
                if (emergency)
                    next_state = EMERGENCY;

                else if (current_floor == request_floor)
                    next_state = IDLE;

                else
                    next_state = MOVE_UP;
            end

            //------------------------------------------
            // MOVE DOWN
            //------------------------------------------

            MOVE_DOWN:
            begin
                if (emergency)
                    next_state = EMERGENCY;

                else if (current_floor == request_floor)
                    next_state = IDLE;

                else
                    next_state = MOVE_DOWN;
            end

            //------------------------------------------
            // EMERGENCY
            //------------------------------------------

            EMERGENCY:
            begin
                if (!emergency)
                    next_state = IDLE;
                else
                    next_state = EMERGENCY;
            end

            default:
                next_state = IDLE;

        endcase

    end

    //--------------------------------------------------
    // Floor Update Logic
    //--------------------------------------------------

    always @(posedge clk or posedge rst)
    begin

        if (rst)
        begin
            current_floor <= 2'd0;   // Ground Floor
        end

        else
        begin

            case(state)

                IDLE:
                    current_floor <= current_floor;

                MOVE_UP:
                begin
                    if (current_floor < request_floor)
                        current_floor <= current_floor + 1'b1;
                end

                MOVE_DOWN:
                begin
                    if (current_floor > request_floor)
                        current_floor <= current_floor - 1'b1;
                end

                EMERGENCY:
                    current_floor <= current_floor;

                default:
                    current_floor <= current_floor;

            endcase

        end

    end

endmodule
