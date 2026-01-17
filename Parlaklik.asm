; Makine Gorusu (Parlaklik Ortalamasi) 
.MODEL SMALL
.STACK 100H

.DATA
    PIXEL_DATA DB 10, 20, 30, 40, 50, 60, 70, 80, 90, 100 ; 10 piksel (0-100 araligi)
    DATA_COUNT EQU ($ - PIXEL_DATA) ; Piksel sayisi (10)
    SUM_VAL DW 0                   ; Toplam deger (16-bit)
    AVERAGE_VAL DB 0               ; Ortalama deger (8-bit)

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV CX, DATA_COUNT   ; CX = 10 (Dongu sayisi)
    MOV SI, OFFSET PIXEL_DATA ; Veri dizisi baslangici
    
    XOR BX, BX           ; BX'i sifirla (Genel toplama icin kullanilacak, SUM_VAL'e aktarilacak)

SUM_LOOP:
    MOV AL, [SI]         ; AL = Mevcut piksel degeri
    ADD BL, AL           ; BL = Toplamin dusuk 8 biti
    ADC BH, 0            ; Yuksek 8 bite tasma (carry) ekle (Toplama 255'i asarsa)
    
    INC SI               ; Bir sonraki piksele gec
    LOOP SUM_LOOP        ; Donguyu tekrarla

    ; Toplami kaydet
    MOV SUM_VAL, BX      ; BX'teki toplami SUM_VAL'e tasi (Bu 16-bit'tir)

    ; Ortalama Hesaplama: AVERAGE_VAL = SUM_VAL / DATA_COUNT
    MOV AX, SUM_VAL      ; AX'e 16-bit toplami yukle
    XOR DX, DX           ; DX:AX bolunecek sayiyi tutar. DX=0 (16-bit bolme)
    MOV CL, DATA_COUNT   ; CL = 10 (Bolucu)
    DIV CL               ; AL = AX / CL (Bolum), AH = Kalan
    
    MOV AVERAGE_VAL, AL  ; Ortalama (Bolum) kaydet

    ; Programdan cikis
    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
