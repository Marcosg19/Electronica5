	AREA codigo,CODE, READONLY ;PROGRAMA PARA CALCULAR EL MCM DE TRES NÚMEROS
	ENTRY
	EXPORT Start
		
Start
	
Variables
	VLDR.F32 S0, = 5 ; INGRESE PRIMER NÚMERO
	VLDR.F32 S1, = 0; INGRESE SEGUNDO NÚMERO
	VLDR.F32 S2, = 87; INGRESE TERCER NÚMERO
	
	;Constantes para el calculo del MCM
	VLDR.F32 S30, = 1 
	VLDR.F32 S31, = 0
	
	
;Funciones para ordenar números de mayor a menor
Comparacion1
	VCMP.F32 S0, S1	
	VMRS APSR_nzcv, FPSCR
	BGE Comp12
	BLO Comp11
	
Comp11
	VCMP.F32 S2, S1	
	VMRS APSR_nzcv, FPSCR
	BGE MayorS2S1S0
	BLO Comp112
	
Comp112
	VCMP.F32 S2, S0	
	VMRS APSR_nzcv, FPSCR
	BGE MayorS1S2S0
	BLO MayorS1S0S2
	
Comp12
	VCMP.F32 S2, S0	
	VMRS APSR_nzcv, FPSCR
	BGE MayorS2S0S1
	BLO Comp122

Comp122
	VCMP.F32 S2, S1	
	VMRS APSR_nzcv, FPSCR
	BGE MayorS0S2S1
	BLO MayorS0S1S2
		
;En S5 se almacena el número mayor
;En S6 se almacena el segundo mayor
;En S7 se almacena el número menor
MayorS2S1S0
	VMOV.F32 S5, S2
	VMOV.F32 S6, S1
	VMOV.F32 S7, S0
	B MCM
	
MayorS1S2S0
	VMOV.F32 S5, S1
	VMOV.F32 S6, S2
	VMOV.F32 S7, S0
	B MCM
	
MayorS1S0S2
	VMOV.F32 S5, S1
	VMOV.F32 S6, S0
	VMOV.F32 S7, S2
	B MCM
	
MayorS2S0S1
	VMOV.F32 S5, S2
	VMOV.F32 S6, S0
	VMOV.F32 S7, S1
	B MCM
	
MayorS0S2S1
	VMOV.F32 S5, S0
	VMOV.F32 S6, S2
	VMOV.F32 S7, S1
	B MCM
	
MayorS0S1S2
	VMOV.F32 S5, S0
	VMOV.F32 S6, S1
	VMOV.F32 S7, S2
	B MCM

;Ya ordenados los números de mayor a menor se desarrolla el calculo del MCM

MCM
	VMOV.F32 S10, S30 						
	VCMP.F32 S10, S31 						
	VMRS APSR_nzcv, FPSCR
	BNE Calculo
	
Calculo
	VMUL.F32 S15, S5, S10 					
	VADD.F32 S10, S10, S30 					
	VMOV.F32 S16, S31 						
	VMOV.F32 S11, S30 						
	VCMP.F32 S16, S15 						
	VMRS APSR_nzcv, FPSCR
	BGE Calculo 							
	BLO Calculo2 							
	
Calculo2
	VMUL.F32 S16, S6, S11 					
	VADD.F32 S11, S11, S30 					
	VCMP.F32 S16, S15						
	VMRS APSR_nzcv, FPSCR
	BHI Calculo 							
	BLO Calculo2 							
	BEQ MCM2 						; Si es igual sigue a la siguiente función MCM2 --
									;-- Al ser iguales significa que en S15 se almacena 
									;el MCM de los dos números mayores.

MCM2
	VMOV.F32 S12, S30 						
	VCMP.F32 S12, S31 						
	VMRS APSR_nzcv, FPSCR
	BNE Calculo3 							
	
Calculo3
	VMUL.F32 S17, S15, S12 			;En el registro S17 se almacena la multiplicación del MCM hallado 
	VADD.F32 S12, S12, S30 			;de los dos números mayores y S12		
	VMOV.F32 S18, S31 						
	VMOV.F32 S13, S30 						
	VCMP.F32 S18, S17 						
	VMRS APSR_nzcv, FPSCR
	BGE Calculo3 							
	BLO Calculo4 							
	
Calculo4
	VMUL.F32 S18, S7, S13 					
	VADD.F32 S13, S13, S30 					
	VCMP.F32 S18, S17 						
	VMRS APSR_nzcv, FPSCR
	BHI Calculo3 							
	BLO Calculo4 							
	BEQ Stop 						;Si S18 y S17 son iguales se encuentra el valor del MCM de los
									;tres números y finaliza el programa
									
;Resultado total de MCM de los tres números se almacena en S18

Stop
	B Stop

	ALIGN
	END