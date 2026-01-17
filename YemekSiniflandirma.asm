; NEW 4th Scenario: Color Based Sorting (Green/Red Apple) 
.MODEL SMALL
.STACK 100H

.DATA
    COLOR_DATA DB 120, 210, 50, 240, 15, 200, 90, 220 ; 8 simulated green channel intensities
    DATA_COUNT EQU ($ - COLOR_DATA) ; Number of items (8)
    GREEN_THRESHOLD DB 150           ; Threshold: >150 means Green (Actuate)
    ACTUATOR_COUNT DW 0              ; Counter for sorted items

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, DATA_COUNT   ; CX = 8 (Fixed loop count)
    MOV SI, OFFSET COLOR_DATA ; Pointer to the data array

SORT_LOOP:
    MOV AL, [SI]         ; Load current color intensity into AL
    
    CMP AL, GREEN_THRESHOLD ; Compare intensity with the threshold
    JLE RED_APPLE        ; Jump if Red/Below threshold (Continue on conveyor)

    ; --- GREEN APPLE DECISION ---
    INC WORD PTR ACTUATOR_COUNT ; Increment counter (Simulate actuator action)
    JMP NEXT_ITEM

RED_APPLE:
    ; --- RED APPLE DECISION ---
    ; No action required (Simulate letting it continue on the conveyor)
    
NEXT_ITEM:
    INC SI               ; Move to the next data point
    LOOP SORT_LOOP       ; Repeat loop

    ; Exit program
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
