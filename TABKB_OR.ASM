	ORG	400H
;--------------------------------------------------------
; В основной таблице каждому скан-коду IBM-клавиатуры
; соответствует один байт, который содержит информацию
; о номере колонки и номере строки, в которой будет
; имитироватся замыкание контакта клавиатуры Спектрума.
; d6 сигнализирует о дополнительном нажатии Symbol Shift.
; d7 о нажатии Caps Shift.
; Для клавиш IBM клавиатуры, которые в зависимости от
; нажатия Shift имеют разные коды, предусмотрено перек-
; лючение таблицы на дополнительную, признаком этого
; является d7,d6=1.
; Пропущенные скан-коды можно забить любым кодом.
; Незадействованные скан-коды заполняются кодом 0FFH.
; Поскольку таблица жестко связана со скан-кодами,
; нельзя ни пропускать, ни добавлять в нее строки.
; Дополнительную таблицу можно расширять в сторону
; увеличения практически до 63 строк. Но начало
; этой таблицы тоже жестко определено (адрес 480H).
; Для примера:
; Скан код клавиши TAB для IBM-клавиатуры равен 0DH
; в строке номер 13 от начала таблицы видим:
;	DB	Kl_TAB,Kl_TAB		;0Dh	 Tab
; Поскольку клавиша TAB судя по матрице клавиатуры
; располагается на пересечении строки A1 и колонки D0,
; то определяем Kl_TAB в виде константы:
;Kl_TAB	EQU	A1+D0	;TAB
; A1 и D0 это тоже константы:
;A1	EQU	008H	;1*8
;D0	EQU	000H	;0
; В принципе можно было бы записать и так:
;	DB	A1+D0,A1+D0		;0Dh	 Tab
; Или еще проще:
;	DB	8+0,8+0			;0Dh	 Tab
; но это не очень наглядно.
;--------------------------------------------------------
;   Матрица клавиатуры
; -----------------------------------
;    ? D7  D6  D5  D4  D3  D2  D1  D0
; ---+-------------------------------
; A7 ?SPC  ^   ]   \   [   Z   Y   X
; A6 ? W   V   U   T   S   R   Q   P
; A5 ? O   N   M   L   K   J   I   H
; A4 ? G   F   E   D   C   B   A   @
; A3 ? /   .   =   ,   ;   :   9   8
; A2 ? 7   6   5   4   3   2   1   0
; A1 ? v  ->   ^  <-  ЗАБ ВК  ПС  TAB
; A0 ?F5  F4  F3  F2  F1  AP2 CTP  \
; -----------------------------------
; биты данных сканирования (d2..d0) [номер колонки 0..7]
D0	EQU	000H
D1	EQU	001H
D2	EQU	002H
D3	EQU	003H
D4	EQU	004H
D5	EQU	005H
D6	EQU	006H
D7	EQU	007H
; биты адреса сканирования (d5..d3) [номер строки *8]
A0	EQU	000H
A1	EQU	008H
A2	EQU	010H
A3	EQU	018H
A4	EQU	020H
A5	EQU	028H
A6	EQU	030H
A7	EQU	038H
; Префиксные биты (d7..d6)
Ctrl	EQU	080H	;флаг Ctrl   Bit7=1
Shift	EQU	040H	;флаг Shift  Bit6=1
AltTb	EQU	0C0H	;флаг доп.таблицы
; скан-коды основных клавиш
Kl_SL	EQU	A0+D0	; Home
Kl_CTP	EQU	A0+D1	; Insert
Kl_AP2	EQU	A0+D2	; ESCAPE
Kl_F1	EQU	A0+D3
Kl_F2	EQU	A0+D4
Kl_F3	EQU	A0+D5
Kl_F4	EQU	A0+D6
Kl_F5	EQU	A0+D7
;
Kl_TAB	EQU	A1+D0	;TAB
Kl_LF	EQU	A1+D1	;
Kl_CR	EQU	A1+D2	;Enter
Kl_BS	EQU	A1+D3	;Back Space
Kl_LFT	EQU	A1+D4	;Влево
Kl_UP	EQU	A1+D5	;Вверх
Kl_RGT	EQU	A1+D6	;Вправо
Kl_DN	EQU	A1+D7	;Вниз
;
Kl_0	EQU	A2+D0
Kl_1	EQU	A2+D1
Kl_2	EQU	A2+D2
Kl_3	EQU	A2+D3
Kl_4	EQU	A2+D4
Kl_5	EQU	A2+D5
Kl_6	EQU	A2+D6
Kl_7	EQU	A2+D7
;
Kl_8	EQU	A3+D0
Kl_9	EQU	A3+D1
Kl_DVT	EQU	A3+D2	; : двоеточие
Kl_PLS	EQU	A3+D3	; =/+ PLUS
Kl_ZPT	EQU	A3+D4	; , запятая
Kl_MNS	EQU	A3+D5	; -/_ МИНУС
Kl_TCK	EQU	A3+D6	; . точка
Kl_DEV	EQU	A3+D7	; / деление
;
Kl_AMP	EQU	A4+D0	; @ амперсант
Kl_A	EQU	A4+D1
Kl_B	EQU	A4+D2
Kl_C	EQU	A4+D3
Kl_D	EQU	A4+D4
Kl_E	EQU	A4+D5
Kl_F	EQU	A4+D6
Kl_G	EQU	A4+D7
;
Kl_H	EQU	A5+D0
Kl_I	EQU	A5+D1
Kl_J	EQU	A5+D2
Kl_K	EQU	A5+D3
Kl_L	EQU	A5+D4
Kl_M	EQU	A5+D5
Kl_N	EQU	A5+D6
Kl_O	EQU	A5+D7
;
Kl_P	EQU	A6+D0
Kl_Q	EQU	A6+D1
Kl_R	EQU	A6+D2
Kl_S	EQU	A6+D3
Kl_T	EQU	A6+D4
Kl_U	EQU	A6+D5
Kl_V	EQU	A6+D6
Kl_W	EQU	A6+D7
;
Kl_X	EQU	A7+D0
Kl_Y	EQU	A7+D1
Kl_Z	EQU	A7+D2
Kl_BL	EQU	A7+D3	; [
Kl_OSL	EQU	A7+D4	; \
Kl_BR	EQU	A7+D5	; ]
Kl_KAV	EQU	A7+D6	; ^
Kl_SP	EQU	A7+D7	;Пробел
;----------------------------------------------------------------
; Таблица скан-кодов клавиш AT
; Четные байты для режима LAT - Scroll Lock не горит
; Нечетные байты для RUS - Scroll Lock горит.
;		это скан-код IBM vvv
tab_kbd:				;	 vvv - а это клавиша IBM
	DB	0FFH,0FFH		;00h
	DB	0FFH,0FFH		;01h
	DB	0FFH,0FFH		;02h
	DB	0FFH,0FFH		;03h
	DB	0FFH,0FFH		;04h
	DB	0FFH,0FFH		;05h
	DB	0FFH,0FFH		;06h
	DB	Kl_F1,Kl_F1		;07h 	 F1
	DB	Kl_AP2,Kl_AP2		;08h 	 ESC
;----- скан-коды следующих 4 клавиш в программе перемещены
; в это место таблицы (а эти скан-коды в IBM не задействованы).
	DB	AltTb+14,AltTb+14	;09h/84h [-]
	DB	0FFH,0FFH		;0Ah/81h Left Flying Windows
	DB	0FFH,0FFH		;0Bh/82h Right Flying Windows
	DB	0FFH,0FFH		;0Ch 83h Menu
	DB	Kl_TAB,Kl_TAB		;0Dh	 Tab
;-----
	DB	AltTb+7,AltTb+7		;0Eh	 `/~ 
	DB	Kl_F2,Kl_F2		;0Fh 	 F2
;
	DB	0FFH,0FFH		;10h
	DB	0FFH,0FFH		;11h	Left Ctrl
	DB	0FFH,0FFH		;12h	Left Shift
	DB	0FFH,0FFH		;13h
	DB	0FFH,0FFH		;14h	Caps Lock
	DB	Kl_Q,Kl_J		;15h	Q
	DB	Kl_1,Kl_1		;16h	1/!
	DB	Kl_F3,Kl_F3		;17h	F3
	DB	0FFH,0FFH		;18h
	DB	0FFH,0FFH		;19h	Left Alt
	DB	Kl_Z,Kl_Q		;1Ah	Z
	DB	Kl_S,Kl_Y		;1Bh	S
	DB	Kl_A,Kl_F		;1Ch	A
	DB	Kl_W,Kl_C		;1Dh	W
	DB	AltTb+6,AltTb+6		;1Eh	2/@
	DB	Kl_F4,Kl_F4		;1Fh	F4
;
	DB	0FFH,0FFH		;20h
	DB	Kl_C,Kl_S		;21h	C
	DB	Kl_X,Kl_KAV		;22h	X
	DB	Kl_D,Kl_W		;23h	D
	DB	Kl_E,Kl_U		;24h	E
	DB	Kl_4,Kl_4		;25h	4/$
	DB	Kl_3,Kl_3		;26h	3/#
	DB	Kl_F5,Kl_F5		;27h	F5
	DB	0FFH,0FFH		;28h
	DB	Kl_SP,Kl_SP		;29h	SPACE
	DB	Kl_V,KL_M		;2Ah	V
	DB	Kl_F,KL_A		;2Bh	F
	DB	Kl_T,Kl_E		;2Ch	T
	DB	Kl_R,Kl_K		;2Dh	R
	DB	Kl_5,KL_5		;2Eh	5/%
	DB	0FFH,0FFH		;2Fh	F6
;
	DB	0FFH,0FFH		;30h
	DB	Kl_N,Kl_T		;31h	N
	DB	Kl_B,Kl_I		;32h	B
	DB	Kl_H,Kl_R		;33h	H
	DB	Kl_G,Kl_P		;34h	G
	DB	Kl_Y,Kl_N		;35h	Y
	DB	AltTb+8,AltTb+8		;36h	6/^
	DB	0FFH,0FFH		;37h	F7
	DB	0FFH,0FFH		;38h
	DB	0FFH,0FFH		;39h	Right Alt
	DB	Kl_M,Kl_X		;3Ah	M
	DB	Kl_J,Kl_O		;3Bh	J
	DB	Kl_U,Kl_G		;3Ch	U
	DB	AltTb+9,AltTb+9		;3Dh	7/&
	DB	AltTb+1,AltTb+1		;3Eh	8/*
	DB	0FFH,0FFH		;3Fh	F8
;
	DB	0FFH,0FFH		;40h
	DB	Kl_ZPT,KL_B		;41h	,/<
	DB	Kl_K,Kl_L		;42h	K
	DB	Kl_I,KL_BL		;43h	I
	DB	Kl_O,KL_BR		;44h	O
	DB	AltTb+3,AltTb+3		;45h	0/)
	DB	AltTb+2,AltTb+2		;46h	9/(
	DB	0FFH,0FFH		;47h	F9
	DB	0FFH,0FFH		;48h
	DB	Kl_TCK,KL_AMP		;49h	./>
	DB	Kl_DEV,KL_DEV		;4Ah	//?
	DB	Kl_L,KL_D		;4Bh	L
	DB	AltTb,Kl_V		;4Ch	;/:
	DB	Kl_P,KL_Z		;4Dh	P
	DB	AltTb+4,AltTb+4		;4Eh	-/_
	DB	0FFH,0FFH		;4Fh	F10
;
	DB	0FFH,0FFH		;50h
	DB	0FFH,0FFH		;51h
	DB	AltTb+10,AltTb+10	;52h	'/"
	DB	0FFH,0FFH		;53h
	DB	Kl_BL,KL_H		;54h	[/{
	DB	AltTb+5,AltTb+5		;55h	=/+
	DB	0FFH,0FFH		;56h	F11
	DB	0FFH,0FFH		;57h	Print Screen -> RESET
; скан-коды правых клавиш Ctrl и Shift в программе
; заменяются скан-кодами их левых аналогов.
	DB	0FFH,0FFH		;58h	Right Ctrl  -> 11h
	DB	0FFH,0FFH		;59h 	Right Shift -> 12h
	DB	Kl_CR,Kl_CR		;5Ah	ENTER
	DB	Kl_BR,KL_BR		;5Bh	]/}
	DB	Kl_OSL,KL_OSL		;5Ch	\/|
	DB	0FFH,0FFH		;5Dh
	DB	0FFH,0FFH		;5Eh	F12
	DB	0FFH,0FFH		;5Fh	Scroll Lock
;
	DB	Kl_DN,KL_DN		;60h	[Down]
	DB	Kl_LFT,KL_LFT		;61h	[Left]
	DB	0FFH,0FFH		;62h	Pause/Break -> WAIT
	DB	Kl_UP,KL_UP		;63h	[Up]
;	DB	Ctrl+Kl_G,Ctrl+Kl_G	;64h	[Delete]
	DB	Kl_F4,Kl_F4		;64h	[Delete]
;	DB	A1+D1,A1+D1		;65h	[End]
	DB	Ctrl+Kl_RGT,Ctrl+Kl_RGT	;65h	[End]
	DB	Kl_BS,KL_BS		;66h	BackSpace
	DB	A0+D1,A0+D1		;67h	[Insert]
	DB	0FFH,0FFH		;68h
	DB	AltTb+23,AltTb+23	;69h	[1]
	DB	Kl_RGT,KL_RGT		;6Ah	[Right]
	DB	AltTb+24,AltTb+24	;6Bh	[4]
	DB	AltTb+25,AltTb+25	;6Ch	[7]
;	DB	A0+D6,A0+D6		;6Dh	[PageDown]
	DB	Ctrl+Kl_DN,Ctrl+Kl_DN,	;6Dh	[PageDown]
;	DB	A0+D0,A0+D0		;6Eh	[Home]
	DB	Ctrl+Kl_LFT,Ctrl+Kl_LFT	;6Eh	[Home]
;	DB	Ctrl+Kl_R,Ctrl+Kl_R	;6Fh	[PageUp]
	DB	Ctrl+Kl_UP,Ctrl+Kl_UP	;6Fh	[PageUp]
;
	DB	AltTb+15,AltTb+15	;70h	[0]
	DB	AltTb+16,AltTb+16	;71h	[.]
	DB	AltTb+17,AltTb+17	;72h	[2]
	DB	AltTb+18,AltTb+18	;73h	[5]
	DB	AltTb+19,AltTb+19	;74h	[6]
	DB	AltTb+20,AltTb+20	;75h	[8]
	DB	0FFH,0FFH		;76h	NumLock
	DB	AltTb+13,AltTb+13	;77h	[/]
	DB	0FFH,0FFH		;78h
	DB	Kl_CR,Kl_CR		;79h	[ENTER]
	DB	AltTb+21,AltTb+21	;7Ah	[3]
	DB	0FFH,0FFH		;7Bh
	DB	AltTb+11,AltTb+11	;7Ch	[+]
	DB	AltTb+22,AltTb+22	;7Dh	[9]
	DB	AltTb+12,AltTb+12	;7Eh	[*]
	DB	0FFH,0FFH		;7Fh
;--------------------------------------------
; Таблица клавиш с двумя кодами:
; 1код - без Shift
; 2код -  с  Shift
AltTab:
	DB	Kl_PLS,Kl_DVT			;4Ch	;/:
	DB	Kl_8,Kl_DVT+Shift		;3Eh	8/*
	DB	Kl_9,KL_8+Shift			;46h	9/(
	DB	Kl_0,KL_9+Shift			;45h	0/)
	DB	Kl_MNS,Kl_BS+Shift		;4Eh	-/_
	DB	Kl_MNS+Shift, Kl_PLS+Shift	;55h	=/+
	DB	Kl_2,Kl_AMP			;1Eh	2/@
	DB	Kl_AMP+Shift,Kl_KAV+Shift	;0Eh	 `/~ 
	DB	Kl_6,Kl_KAV			;36h	6/^
	DB	Kl_7,Kl_6+Shift			;3Dh	7/&
	DB	Kl_2+Shift,Kl_7+Shift		;52h	'/"
	DB	Kl_PLS+Shift,Kl_PLS+Shift	;7Ch	[+]
	DB	Kl_DVT+Shift,Kl_DVT+Shift	;7Eh	[*]
	DB	Kl_DEV,KL_DEV			;77h	[/]
	DB	Kl_MNS,Kl_MNS			;09h/84h [-]
	DB	Kl_0,KL_0			;70h	[0]
	DB	Kl_TCK,KL_TCK			;71h	[.]
	DB	Kl_2,Kl_2			;72h	[2]
	DB	Kl_5,Kl_5			;73h	[5]
	DB	Kl_6,Kl_6			;74h	[6]
	DB	Kl_8,Kl_8			;75h	[8]
	DB	Kl_3,Kl_3			;7Ah	[3]
	DB	Kl_9,Kl_9			;7Dh	[9]
	DB	Kl_1,Kl_1			;69h	[1]
	DB	Kl_4,KL_4			;6Bh	[4]
	DB	Kl_7,KL_7			;6Ch	[7]
;********************************************
	END