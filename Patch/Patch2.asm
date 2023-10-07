+000000D4:   04FF        SBRS      R16,4          SBRS      R16,7	07FF
+000000D5:   409A        SBI       0x08,0         SBI       0x08,0	409A
+000000D6:   04FD        SBRC      R16,4          SBRC      R16,7	07FD
+000000D7:   4098        CBI       0x08,0         CBI       0x08,0	4098
+000000E7:   9508        RET                      RJMP      PC+0x00AE   ADC0
+000000E9:   0F7E        ANDI      R16,0xEF       ANDI      R16,0x6F	0F76
+000000F3:   0061        ORI       R16,0x10       ORI       R16,0x80	0068
+000000FB:   C895        LPM                      RCALL     PC+0x0097	96D0 
+00000106:   0061        ORI       R16,0x10       ORI       R16,0x80	0068
+00000192:   FFFF        ???                      LPM			C895
+00000193:   FFFF        ???                      ANDI      R16,0x7F	0F77
+00000194:   FFFF        ???                      RET			0895
+00000195:   FFFF        ???                      SBRC      R16,4	04FD
+00000196:   FFFF        ???                      ORI       R16,0x80	0068
+00000197:   FFFF        ???                      SBRS      R16,4	04FF
+00000198:   FFFF        ???                      ANDI      R16,0x7F	0F77
+00000199:   FFFF        ???                      RET			0895

