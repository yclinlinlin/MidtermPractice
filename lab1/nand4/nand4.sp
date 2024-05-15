4-input nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b c d out

mp0		out		a		vdd		vdd		P_18		l=0.18u 	w=k
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=k
mp2		out		c		vdd		vdd		P_18		l=0.18u	w=k
mp3		out		d		vdd		vdd		P_18		l=0.18u	w=k
mn0		out		 a		net0	0		N_18		l=0.18u  	w='2*k'
mn1		net0    b		net1	0		N_18		l=0.18u  	w='2*k'
mn2		net1	 c		net2	0		N_18		l=0.18u  	w='2*k'
mn3		net2	 d		0		0		N_18		l=0.18u  	w='2*k'
.ends

xnand4 a b c d out nand
c1 out gnd 0.01p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


vin		in		0		pulse(0	1.8 5n		0.01n	0.01n	2.49n	5n)
va		a		0		pulse(0	1.8 5n		0.01n	0.01n	4.99n	10n)
vb		b		0		pulse(0	1.8 5n		0.01n	0.01n	9.99n	20n)
vc		c		0		pulse(0	1.8 5n		0.01n	0.01n	19.99n	40n)
vd		d		0		pulse(0	1.8 5n		0.01n	0.01n	39.99n	80n)

.meas	tran	delayN	trig	v(d)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.6u  10u   0.2u)
.end

