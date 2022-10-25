                .data
A:              .word   1, 3, 1, 6, 4
                .word   2, 4, 3, 9, 5
mult:   .word   0

        .code
        daddi   $1, $0, A      ; *A[0]
        daddi   $5, $0, 1      ; $5 = 1 ;; index
        daddi   $6, $0, 7      ; $6 = N ;; N = 7

        lw      $9, 0($1)      ; $9 = A[0]  ;; mult
        lw      $12, 8($1)     ; $12 = A[1]
        lw      $13, 16($1)    ; $13 = A[2]
        
        daddi   $1, $1, 8      ; Advance pointer to align with the loop

loop:   
        dmul    $16, $12, $9   ; $16 = $12*$9 ;; $16 = A[i]*mult
        daddi   $1, $1, 16     ; *$1 +=2 
        lw      $12, 0($1)     ; $12 = A[i]
        dadd    $9, $9, $16    ; $9 = $9 + $16 ;; mult = mult + A[i]*mult

        dmul    $17, $13, $9   ; $17 = $9*$17 ;; $17 = A[i]*mult
        daddi   $5, $5, 2      ; index++
        lw      $13, 8($1)     ; $13 = A[i+1]
        dadd    $9, $9, $17    ; $9 = $9 + $17 ;; mult = mult + A[i]*mult

        bne     $6, $5, loop   ; Exit loop if index == N

        dmul    $16, $12, $9   ; $16 = $12*$9 ;; $16 = A[i]*mult
        daddi   $1, $1, 16     ; *$1 +=2 
        dadd    $9, $9, $16    ; $9 = $9 + $16 ;; mult = mult + A[i]*mult

        dmul    $17, $13, $9   ; $17 = $9*$17 ;; $17 = A[i]*mult
        lw      $12, 0($1)     ; $12 = A[i]
        dadd    $9, $9, $17    ; $9 = $9 + $17 ;; mult = mult + A[i]*mult

        dmul    $16, $12, $9   ; $16 = $12*$9 ;; $16 = A[i]*mult
        dadd    $9, $9, $16    ; $9 = $9 + $16 ;; mult = mult + A[i]*mult
        
        sw      $9, mult($0)   ; Store result
        halt

;; Expected result: mult = f6180 (hex), 1008000 (dec)
