TITLE KDRF
: Fast K-DR current for hippocampal interneurons from Lien et al (2002)
: M.Migliore Jan. 2003

NEURON {
	SUFFIX kdr
	USEION k READ ek WRITE ik
	RANGE  gbar
	GLOBAL minf, mtau, hinf, vhalfm, a0m, vh1, vh2, zetam, vshift, tshift
}

PARAMETER {
	gbar = 0.0002   	(mho/cm2)	
								
	celsius
	ek		(mV)            : must be explicitly def. in hoc
	v 		(mV)
	a0m=0.036
	vhalfm=-33
	vh1 = 1.4
	vh2 = -20
	zetam=0.1
	gmm=0.7
	htau=1000
	q10=3
	f=0.92
	vshift = 0
	tshift = 0
}


UNITS {
	(mA) = (milliamp)
	(mV) = (millivolt)
	(pS) = (picosiemens)
	(um) = (micron)
} 

ASSIGNED {
	ik 		(mA/cm2)
	minf 		mtau (ms)	 	
	hinf	 	
}
 

STATE { m h}

BREAKPOINT {
        SOLVE states METHOD cnexp
	ik = gbar*m*h*(v - ek)
} 

INITIAL {
	trates(v)
	m=minf  
	h=hinf  
}

DERIVATIVE states {   
        trates(v)      
        m' = (minf-m)/mtau
        h' = (hinf-h)/htau
}

PROCEDURE trates(v) {  
	LOCAL qt
        qt=q10^((celsius-23)/10)
        minf = -1/(1+exp((v+5+vshift)/12))+1
		mtau = tshift + 0.5+4*exp(-0.5*((v+25)/25)^2)

        hinf = 1/(1+exp((v+30+vshift)/10))
}

