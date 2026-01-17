; Sensor Esik Kontrolu 
.MODEL SMALL
.STACK 100H

.DATA
    SENSOR_DATA DB 20H, 15H, 30H, 12H, 40H, 0AH, 25H, 1AH, 50H, 05H ; 10 adet simulasyon sensor verisi (byte)
    DATA_COUNT EQU ($ - SENSOR_DATA) ; Veri sayisi (10)
    THRESHOLD DB 30H                 ; Esik degeri (48 onluk)
    COUNT_HIGH DW 0                  ; Esigi asanlarin sayaci

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, DATA_COUNT   ; CX = 10 (Dongu sayisi)
    MOV SI, OFFSET SENSOR_DATA ; SI, veri dizisinin baslangicini isaret eder

CHECK_LOOP:
    MOV AL, [SI]         ; AL = Dizideki mevcut sensor degeri
    
    CMP AL, THRESHOLD    ; Degeri esikle karsilastir
    JLE NEXT_ELEMENT     ; Esit veya kucukse atla
    
    ; Esigi astiysa sayaci artir
    INC WORD PTR COUNT_HIGH 
    
NEXT_ELEMENT:
    INC SI               ; Bir sonraki veriye gec
    LOOP CHECK_LOOP      ; CX bitene kadar tekrarla

    ; Programdan cikis
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
