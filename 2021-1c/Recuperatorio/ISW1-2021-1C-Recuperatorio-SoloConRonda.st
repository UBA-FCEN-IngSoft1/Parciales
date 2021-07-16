!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test01SonIgualesConMismoPaloYNumero

	self assert: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test02SonDistintasConDistintoPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco oroCon: 1) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test03SonDistintasConNumeroAunqueIgualPalo

	self deny: (CartaDeTruco bastoCon: 1) = (CartaDeTruco bastoCon: 2) 

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test04CartasIgualesTienenElMismoHash

	self assert: (CartaDeTruco bastoCon: 1) hash equals: (CartaDeTruco bastoCon: 1) hash

	! !

!CartaDeTrucoTest methodsFor: 'test - igualdad' stamp: 'HAW 7/4/2021 17:31:47'!
test05UnaCartaEsDistintaACualquierObjetoQueNoSeaCarta

	self deny: (CartaDeTruco bastoCon: 1) = 1! !


!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test07NoHayCartaDeTrucoConNumeroOcho

	self 
		should: [ CartaDeTruco oroCon: 8 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test08NoHayCartaDeTrucoConNumeroNueve

	self 
		should: [ CartaDeTruco oroCon: 9 ]
		raise: Error
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:12'!
test09LosPalosDeLaCartaDeTrucoSonBastoOroEspadaYCopa

	self 
		should: [ CartaDeTruco palo: #otro numero: 1 ]
		raise: Error
		withMessageText: CartaDeTruco paloInvalidoErrorDescription! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test10NoSePuedeCrearCartaConNumeroMenorAUno

	self 
		should: [ CartaDeTruco espadaCon: 0 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test11NoSePuedeCrearCartaConNumeroMayorADoce

	self 
		should: [ CartaDeTruco espadaCon: 13 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !

!CartaDeTrucoTest methodsFor: 'test - creacion' stamp: 'HAW 7/5/2021 11:58:02'!
test12ElNumeroDeLaCartaDebeSerEntero

	self 
		should: [ CartaDeTruco espadaCon: 1.1 ]
		raise: Error 
		withMessageText: CartaDeTruco numeroDeCartaInvalidoErrorDescription ! !


!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:55:30'!
test13LaTablaDeValoresEsCorrecta

	self assert: (CartaDeTruco anchoDeEspada mataA: CartaDeTruco anchoDeBasto).
	self assert: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco sieteDeEspada).
	self assert: (CartaDeTruco sieteDeEspada mataA: CartaDeTruco sieteDeOro).
	self assert: (CartaDeTruco sieteDeOro mataA: (CartaDeTruco espadaCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) empardaCon: (CartaDeTruco oroCon: 3)).
	self assert: ((CartaDeTruco espadaCon: 3) mataA: (CartaDeTruco espadaCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) empardaCon: (CartaDeTruco oroCon: 2)).
	self assert: ((CartaDeTruco espadaCon: 2) mataA: (CartaDeTruco oroCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) empardaCon: (CartaDeTruco copaCon: 1)).
	self assert: ((CartaDeTruco oroCon: 1) mataA: (CartaDeTruco espadaCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) empardaCon: (CartaDeTruco oroCon: 12)).
	self assert: ((CartaDeTruco espadaCon: 12) mataA: (CartaDeTruco espadaCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) empardaCon: (CartaDeTruco oroCon: 11)).
	self assert: ((CartaDeTruco espadaCon: 11) mataA: (CartaDeTruco espadaCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) empardaCon: (CartaDeTruco oroCon: 10)).
	self assert: ((CartaDeTruco espadaCon: 10) mataA: (CartaDeTruco copaCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) empardaCon: (CartaDeTruco bastoCon: 7)).
	self assert: ((CartaDeTruco copaCon: 7) mataA: (CartaDeTruco espadaCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) empardaCon: (CartaDeTruco oroCon: 6)).
	self assert: ((CartaDeTruco espadaCon: 6) mataA: (CartaDeTruco espadaCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) empardaCon: (CartaDeTruco oroCon: 5)).
	self assert: ((CartaDeTruco espadaCon: 5) mataA: (CartaDeTruco espadaCon: 4)).
	self assert: ((CartaDeTruco espadaCon: 4) empardaCon: (CartaDeTruco oroCon: 4)).

	{ 3. 2. 12. 11. 10. 6. 5. 4 } do: [ :unNumero |
		CartaDeTruco palos do: [ :unPalo | 
			self assert: ((CartaDeTruco espadaCon: unNumero) empardaCon: (CartaDeTruco palo: unPalo numero: unNumero)) ]]
	! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:51'!
test14HayCartasQueNoSonPardas

	self deny: (CartaDeTruco anchoDeEspada empardaCon: CartaDeTruco anchoDeBasto)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 10:49:59'!
test15HayCartasQuePierdenConOtras

	self deny: (CartaDeTruco anchoDeBasto mataA: CartaDeTruco anchoDeEspada)! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:53:21'!
test16SieteDeCopasYDeBastoEsSieteFalso

	self assert: (CartaDeTruco copaCon: 7) esSieteFalso.
	self assert: (CartaDeTruco bastoCon: 7) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:54:57'!
test17SieteDeOroYDeEspadaNoSonSieteFalso

	self deny: (CartaDeTruco sieteDeOro) esSieteFalso.
	self deny: (CartaDeTruco sieteDeEspada) esSieteFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:55:53'!
test18AnchoDeOroYDeCopaSonAnchoFalsos

	self assert: (CartaDeTruco oroCon: 1) esAnchoFalso.
	self assert: (CartaDeTruco copaCon: 1) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/4/2021 17:56:28'!
test19AnchoDeEspadaYDeBastosNoSonAnchoFalsos

	self deny: (CartaDeTruco anchoDeEspada) esAnchoFalso.
	self deny: (CartaDeTruco anchoDeBasto) esAnchoFalso ! !

!CartaDeTrucoTest methodsFor: 'test - valor y comparacion' stamp: 'HAW 7/5/2021 11:58:24'!
test20FallaBuscandoValorDeCartaInválida

	"Creo una carta de manera inválida para probar la correctitud del la tabla de valores - Hernan"
	self 
		should: [ CartaDeTruco new initializePalo: #invalido numero: 1; valor ]
		raise: Error 
		withMessageText: CartaDeTruco tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!classDefinition: #TrucoTest category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
TestCase subclass: #TrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:01:33'!
test01ManoNoPuedeTenerMenosDeTresCartasAlEmpezar

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto }
			yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:03:31'!
test02ManoNoPuedeTenerMasDeTresCartasAlEmpezar

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. 
				CartaDeTruco sieteDeEspada. CartaDeTruco sieteDeOro }
			yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:04:14'!
test03ManoNoPuedeTenerCartasRepetidas

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. 
				CartaDeTruco anchoDeBasto }
			yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:05:56'!
test04PieNoPuedeTenerMenosDeTresCartasAlEmpezar

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}
			yCartasDePie: { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:07:09'!
test05PieNoPuedeTenerMasDeTresCartasAlEmpezar

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}
			yCartasDePie: { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. 
				CartaDeTruco sieteDeEspada. CartaDeTruco sieteDeOro }  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:07:41'!
test06PieNoPuedeTenerCartasRepetidas

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}
			yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. 
				CartaDeTruco anchoDeBasto } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:10:39'!
test07NoPuedenHaberCartasRepetidasEntreLaManoYElPie

	self 
		should: [ RondaDeTruco 
			conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}
			yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 4} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RondaDeTruco cartasInvalidasErrorMessage
		
		! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 17:37:26'!
test08SeEmpiezaSinCartasJugadas

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	self assert: (ronda cartasJugadasPorManoSon: {}).
	self assert: (ronda cartasJugadasPorPieSon: {}).
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 17:37:34'!
test08_1_ManoPuedeJugarCartaDisponible

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	self assert: (ronda cartasJugadasPorManoSon: { CartaDeTruco anchoDeEspada })! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 17:53:23'!
test08_2_ManoNoPuedeJugarCuandoJuegaPie

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	self 
		should: [ ronda manoJuega: CartaDeTruco anchoDeBasto ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ronda noEsTurnoDelJugadorErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorManoSon: { CartaDeTruco anchoDeEspada }) ]! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:27:42'!
test09CartasJugadasPorManoNoContieneCartasNoJugadas

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	self deny: (ronda cartasJugadasPorManoSon: { CartaDeTruco anchoDeBasto })! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/10/2021 20:11:26'!
test10ManoNoPuedeJugarCartaNoDisponible

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	
	self 
		should: [ ronda manoJuega: CartaDeTruco anchoDeEspada ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ronda cartaNoDisponibleErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorManoSon: { CartaDeTruco anchoDeEspada }) ].! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:28:52'!
test11PiePuedeJugarCartaDisponible

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	
	self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco oroCon: 4 })! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:30:36'!
test12CartasJugadasPorPieNoContieneCartasNoJugadas

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	
	self deny: (ronda cartasJugadasPorPieSon: { CartaDeTruco anchoDeBasto })! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/10/2021 20:11:26'!
test13PieNoPuedeJugarCartaNoDisponible

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	 ronda manoJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda pieJuega: (CartaDeTruco oroCon: 4) ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ronda cartaNoDisponibleErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco oroCon: 4 }) ].! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/8/2021 10:43:08'!
test14PieNoPuedeEmpezarPrimerEnfrentamiento

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }
		yCartasDePie: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}.
		
	self 
		should: [ronda pieJuega: (CartaDeTruco oroCon: 4)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noEsTurnoDelJugadorErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: {}) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 17:43:05'!
test15PieEmpiezaSegundoEnfrentamientoCuandoGanaElPrimero

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco espadaCon: 4. CartaDeTruco bastoCon: 4}
		yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco anchoDeBasto. CartaDeTruco sieteDeEspada }.
		
	ronda manoJuega: (CartaDeTruco oroCon: 4).
	ronda pieJuega: CartaDeTruco anchoDeEspada.
	
	self 
		should: [ronda manoJuega: (CartaDeTruco espadaCon: 4)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noEsTurnoDelJugadorErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco oroCon: 4}).
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco anchoDeEspada }) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 15:28:11'!
test16ManoEmpiezaTercerEnfrentamientoCuandoGanaElSegundo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}
		yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }.
		
	ronda manoJuega: (CartaDeTruco oroCon: 4).
	ronda pieJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco espadaCon: 4).
	ronda manoJuega: CartaDeTruco anchoDeBasto.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto. CartaDeTruco bastoCon: 4}) ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 17:50:35'!
test16_1_PieNoPuedeJugarCuandoJuegaMano

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}
		yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }.
		
	ronda manoJuega: (CartaDeTruco oroCon: 4).
	ronda pieJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: (CartaDeTruco espadaCon: 4).
	
	self
		should: [ ronda pieJuega: CartaDeTruco sieteDeEspada ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: ronda noEsTurnoDelJugadorErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorManoSon: {CartaDeTruco oroCon: 4}).
			self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4}) ].! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 15:32:42'!
test17PieEmpiezaTercerEnfrentamientoCuandoGanaElSegundo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}
		yCartasDePie:  { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }.
		
	ronda manoJuega: CartaDeTruco anchoDeBasto.
	ronda pieJuega: (CartaDeTruco espadaCon: 4).
	ronda manoJuega: (CartaDeTruco oroCon: 4).
	ronda pieJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: CartaDeTruco sieteDeEspada.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: (ronda cartasJugadasPorPieSon: {CartaDeTruco espadaCon: 4. CartaDeTruco anchoDeEspada . CartaDeTruco sieteDeEspada}) ! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 15:57:35'!
test18GanaManoConDosEnfrentamientosGanados

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco sieteDeEspada.
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: ronda ganoMano.
	self deny: ronda ganoPie
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 15:57:49'!
test19GanaPieConDosEnfrentamientosGanados

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}
		yCartasDePie: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }.
		
	ronda manoJuega: (CartaDeTruco oroCon: 4).
	ronda pieJuega: CartaDeTruco anchoDeEspada .
	ronda pieJuega: CartaDeTruco sieteDeEspada.
	ronda manoJuega: (CartaDeTruco bastoCon: 4).
	
	self deny: ronda ganoMano.
	self assert: ronda ganoPie
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 15:58:50'!
test20GanaManoConPardaEnLaPrimeraYGanandoLaSegunda

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco sieteDeEspada.
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: ronda ganoMano.
	self deny: ronda ganoPie
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 16:06:17'!
test21GanaPieConPardaEnLaPrimeraYGanandoLaSegunda

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco oroCon: 3}
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: (CartaDeTruco oroCon: 3).
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self deny: ronda ganoMano.
	self assert: ronda ganoPie
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 16:13:38'!
test22NoHayGanadorCuandoNoSeTerminoLaRonda

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco oroCon: 3}
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
	
	self deny: ronda ganoMano.
	self deny: ronda ganoPie
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 16:23:03'!
test23ManoNoPuedeJugarCuandoLaRondaSeTermino

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco sieteDeEspada.
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self 
		should: [ ronda manoJuega: CartaDeTruco anchoDeEspada ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noSePuedeJugarConRondaTerminadaErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorManoSon: { CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/9/2021 16:25:27'!
test24PieNoPuedeJugarCuandoLaRondaSeTermino

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco sieteDeEspada.
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 4)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noSePuedeJugarConRondaTerminadaErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto }) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/10/2021 19:46:36'!
test25ManoNoPuedeJugarCuandoGanaPie

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco sieteDeEspada.
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda manoJuega: CartaDeTruco anchoDeEspada ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noSePuedeJugarConRondaTerminadaErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto }) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/10/2021 19:48:21'!
test26PieNoPuedeJugarCuandoGanaMano

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon:4) .
	ronda pieJuega: (CartaDeTruco oroCon: 4).
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 4)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noSePuedeJugarConRondaTerminadaErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto }) ]
	! !

!TrucoTest methodsFor: 'tests' stamp: 'HAW 7/10/2021 19:53:47'!
test27PieNoJuegaCuandoManoGanoEnfrentamientoAnterior

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda pieJuega: (CartaDeTruco bastoCon: 4)]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: ronda noEsTurnoDelJugadorErrorDescription equals: anError messageText.
			self assert: (ronda cartasJugadasPorPieSon: { CartaDeTruco anchoDeBasto }) ]
	! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!

!CartaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/3/2021 15:27:51'!
initializePalo: unPalo numero: unNumero 
	
	palo := unPalo.
	numero := unNumero.! !


!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:44:36'!
= unaCarta 
	
	^(unaCarta isKindOf: self class) and: [(unaCarta paloEs: palo) and: [ unaCarta numeroEs: numero ]]! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:51'!
empardaCon: cartaParda

	^self valor = cartaParda valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:43:24'!
hash
	
	^palo hash bitXor: numero hash ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/5/2021 10:49:59'!
mataA: cartaPerdedora

	^self valor < cartaPerdedora valor! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:53'!
numeroEs: unNumero

	^numero = unNumero ! !

!CartaDeTruco methodsFor: 'comparing' stamp: 'HAW 7/2/2021 11:41:39'!
paloEs: unPalo

	^palo = unPalo ! !


!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAncho

	^ self numeroEs: 1! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:31'!
esAnchoDeBasto
	
	^self esAncho and: [ self esDeBasto ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:41'!
esAnchoDeEspada
	
	^self esAncho and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/4/2021 17:50:20'!
esAnchoFalso
	
	^self esAncho and: [ self esDeOro or: [ self esDeCopa ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:32'!
esCaballo
	
	^self numeroEs: 11! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:25:29'!
esDeBasto
	
	^self paloEs: self basto! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esDeCopa
	
	^self paloEs: self copa! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:18'!
esDeEspada
	
	^self paloEs: self espada ! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:35'!
esDeOro
	
	^self paloEs: self oro! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:22'!
esRey
	
	^self numeroEs: 12! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:16:57'!
esSiete
	
	^self numeroEs: 7! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:00'!
esSieteDeEspadas
	
	^self esSiete and: [ self esDeEspada ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:27:15'!
esSieteDeOro
	
	^self esSiete and: [ self esDeOro ]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:26:09'!
esSieteFalso
	
	^self esSiete and: [ self esDeCopa or: [ self esDeBasto ]]! !

!CartaDeTruco methodsFor: 'testing' stamp: 'HAW 7/3/2021 15:19:43'!
esSota
	
	^self numeroEs: 10! !


!CartaDeTruco methodsFor: 'printing' stamp: 'HAW 7/3/2021 15:14:43'!
printOn: aStream

	aStream 
		print: numero;
		nextPutAll: ' de ';
		nextPutAll: 	palo ! !


!CartaDeTruco methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:51:09'!
valor
	
	^self class valorDe: self! !


!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:33'!
basto
	
	^self class basto! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:44'!
copa

	^ self class copa! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:24:08'!
espada
	
	^self class espada! !

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/3/2021 15:26:27'!
oro

	^ self class oro! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
CartaDeTruco class
	instanceVariableNames: 'ordenDePrioridad'!

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:37'!
anchoDeBasto
	
	^self bastoCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 17:49:57'!
anchoDeEspada
	
	^self espadaCon: 1! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:03'!
bastoCon: unNumero

	^self palo: self basto numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:08'!
copaCon: unNumero

	^self palo: self copa numero: unNumero! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:16'!
espadaCon: unNumero

	^self palo: self espada numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 14:57:34'!
oroCon: unNumero

	^self palo: self oro numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/4/2021 18:06:08'!
palo: unPalo numero: unNumero 
	
	self assertNúmeroEsVálido: unNumero.
	self assertPaloEsVálido: unPalo.
	
	^self new initializePalo: unPalo numero: unNumero ! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:12:50'!
sieteDeEspada
	
	^self espadaCon: 7! !

!CartaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/3/2021 15:17:44'!
sieteDeOro
	
	^self oroCon: 7! !


!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:56:25'!
basto
	
	^#basto! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:25'!
copa
	
	^#copa! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:55:44'!
espada
	
	^#espada! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/3/2021 14:57:43'!
oro
	
	^#oro! !

!CartaDeTruco class methodsFor: 'palos' stamp: 'HAW 7/4/2021 18:07:36'!
palos

	"No se puede acceder a self en backtick, por eso se usa CartaDeTruco como receiver - Hernan"
	^ `{CartaDeTruco espada. CartaDeTruco basto. CartaDeTruco oro. CartaDeTruco copa }`! !


!CartaDeTruco class methodsFor: 'initialization' stamp: 'HAW 7/5/2021 10:52:07'!
initializeOrdenDePrioridad
	
	"Cuanto más chico sea el índice de la carta en esta colección, más valor tiene - Hernan"
	ordenDePrioridad := OrderedCollection new.
	
	ordenDePrioridad 
		add: [ :carta | carta esAnchoDeEspada ];
		add: [ :carta | carta esAnchoDeBasto ];
		add: [ :carta | carta esSieteDeEspadas ];
		add: [ :carta | carta esSieteDeOro ];
		add: [ :carta | carta numeroEs: 3 ];
		add: [ :carta | carta numeroEs: 2 ];
		add: [ :carta | carta esAnchoFalso ];
		add: [ :carta | carta esRey ];
		add: [ :carta | carta esCaballo ];
		add: [ :carta | carta esSota ];
		add: [ :carta | carta esSieteFalso ];
		add: [ :carta | carta numeroEs: 6 ];
		add: [ :carta | carta numeroEs: 5 ];
		add: [ :carta | carta numeroEs: 4 ];
		yourself.
	
	! !


!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/3/2021 14:54:01'!
ordenDePrioridad
	
	^ordenDePrioridad ifNil: [ self initializeOrdenDePrioridad ] ! !

!CartaDeTruco class methodsFor: 'valor' stamp: 'HAW 7/5/2021 11:58:24'!
valorDe: unaCarta 
	
	self ordenDePrioridad withIndexDo: [ :bloqueDeVerificacion :index |
		(bloqueDeVerificacion value: unaCarta) ifTrue: [ ^index ]].
	
	self error: self tablaDeValoresIncorrectaOCartaInvalidaErrorDescription! !


!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:02'!
numeroDeCartaInvalidoErrorDescription
	
	^'El truco no se puede jugar con ochos ni con nueves'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:12'!
paloInvalidoErrorDescription
	
	^'Los palos de la carta solo pueden ser espada, basto, oro y copa'! !

!CartaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/5/2021 11:58:24'!
tablaDeValoresIncorrectaOCartaInvalidaErrorDescription
	
	^'Error de programación: Tabla de valores incorrecta o carta inválida'! !


!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:02'!
assertNúmeroEsVálido: unNumero

	unNumero < 1 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero > 12 ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	(unNumero between: 8 and: 9) ifTrue: [ self error: self numeroDeCartaInvalidoErrorDescription ].
	unNumero isInteger ifFalse: [ self error: self numeroDeCartaInvalidoErrorDescription ]! !

!CartaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/5/2021 11:58:12'!
assertPaloEsVálido: unPalo

	^ (self palos includes: unPalo) ifFalse: [ self error: self paloInvalidoErrorDescription ]! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'cartasDeManoDisponibles cartasDePieDisponibles cartasDeManoJugadas cartasDePieJugadas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/10/2021 20:01:20'!
cantidadDeCartasJugadasPorMano
	
	^cartasDeManoJugadas size! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/10/2021 20:01:26'!
cantidadDeCartasJugadasPorPie

	^cartasDePieJugadas size! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/10/2021 20:16:48'!
cartasJugadasPorManoSon: unasCartas

	^self cartasJugadas: cartasDeManoJugadas son: unasCartas ! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/10/2021 20:17:24'!
cartasJugadasPorPieSon: unasCartas

	^self cartasJugadas: cartasDePieJugadas son: unasCartas ! !


!RondaDeTruco methodsFor: 'cartas jugadas - private' stamp: 'HAW 7/10/2021 20:17:02'!
cartasJugadas: cartasJugadas son: unasCartas 

	^ cartasJugadas asArray = unasCartas asArray ! !


!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 20:11:26'!
cartaNoDisponibleErrorDescription
	
	^'Carta no disponible para jugar'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 19:12:39'!
noEsTurnoDelJugadorErrorDescription
	
	^'No es el turno para jugar'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 19:36:40'!
noSePuedeJugarConRondaTerminadaErrorDescription
	
	^'No se puede jugar cuando hay ganador'! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/7/2021 18:27:32'!
initilizeConCartasDeMano: unasCartasDeMano yDePie: unasCartasDePie

	cartasDeManoDisponibles := unasCartasDeMano.
	cartasDePieDisponibles := unasCartasDePie.
	
	cartasDeManoJugadas := OrderedCollection new.
	cartasDePieJugadas := OrderedCollection new.
	
	
	! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'HAW 7/10/2021 20:13:46'!
manoJuega: unaCartaDeTruco 
	
	self juagar: unaCartaDeTruco de: cartasDeManoDisponibles en: cartasDeManoJugadas si: [ self juegaMano ].
! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'HAW 7/10/2021 20:14:45'!
pieJuega: unaCartaDeTruco 
	
	self juagar: unaCartaDeTruco de: cartasDePieDisponibles en: cartasDePieJugadas si: [ self juegaPie ].
! !


!RondaDeTruco methodsFor: 'jugar - private' stamp: 'HAW 7/10/2021 20:14:21'!
juagar: unaCartaDeTruco de: cartasDisponibles en: cartasJugadas si: condicionDeTurno

	self hayGanador ifTrue: [ self error: self noSePuedeJugarConRondaTerminadaErrorDescription ].
	condicionDeTurno value ifFalse: [ self error: self noEsTurnoDelJugadorErrorDescription ].
	
	cartasDisponibles remove: unaCartaDeTruco ifAbsent: [self error: self cartaNoDisponibleErrorDescription ].
	cartasJugadas add: unaCartaDeTruco. 
! !


!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/10/2021 20:15:38'!
ganoMano
	
	^self ganoCuando: [ :cartaDeMano :cartaDePie | cartaDeMano mataA: cartaDePie ]
	! !

!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/10/2021 20:15:38'!
ganoPie
	
	^self ganoCuando: [ :cartaDeMano :cartaDePie | cartaDePie mataA: cartaDeMano ]
	! !

!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/10/2021 19:49:06'!
hayGanador

	^ self ganoMano or: [ self ganoPie ]! !


!RondaDeTruco methodsFor: 'quien gano - private' stamp: 'HAW 7/10/2021 20:11:04'!
conEnfrentamientosTerminadosHacer: accionDeCartas

	| lastIndex |
	
	lastIndex := cartasDeManoJugadas size min: cartasDePieJugadas size.
	
	1 to: lastIndex do: [ :index |
		accionDeCartas value: (cartasDeManoJugadas at: index) value: (cartasDePieJugadas at: index) value: index ].

	! !

!RondaDeTruco methodsFor: 'quien gano - private' stamp: 'HAW 7/10/2021 20:15:38'!
ganoCuando: condicionDeMatado

	| ganados |
	
	ganados := 0.
	self conEnfrentamientosTerminadosHacer: [ :cartaDeMano :cartaDePie :index |
		(condicionDeMatado value: cartaDeMano value: cartaDePie) ifTrue: [ 
			ganados := ganados + 1.
			(index = 2 and: [ self primerEnfrentamientoFueParda ]) ifTrue: [ ganados := ganados + 1 ]]].

	^ganados = 2
	! !

!RondaDeTruco methodsFor: 'quien gano - private' stamp: 'HAW 7/10/2021 20:08:46'!
primerEnfrentamientoFueParda

	^ cartasDeManoJugadas first empardaCon: cartasDePieJugadas first! !

!RondaDeTruco methodsFor: 'quien gano - private' stamp: 'HAW 7/10/2021 20:01:58'!
ultimoEnfrentamientoGanoMano
	
	^(cartasDePieJugadas last mataA: cartasDeManoJugadas last) not! !


!RondaDeTruco methodsFor: 'quien juega' stamp: 'HAW 7/10/2021 20:00:01'!
juegaMano
	
	self noJugoNadie ifTrue: [ ^true ].
	self cantidadDeCartasJugadasPorMano > self cantidadDeCartasJugadasPorPie ifTrue: [ ^false ].
	self cantidadDeCartasJugadasPorMano < self cantidadDeCartasJugadasPorPie ifTrue: [ ^true ].
	
	^self ultimoEnfrentamientoGanoMano  ! !

!RondaDeTruco methodsFor: 'quien juega' stamp: 'HAW 7/10/2021 19:59:49'!
juegaPie
	
	^self juegaMano not! !

!RondaDeTruco methodsFor: 'quien juega' stamp: 'HAW 7/10/2021 20:00:51'!
noJugoNadie
	
	^cartasDeManoJugadas isEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-Recuperatorio-SoloConRonda'!
RondaDeTruco class
	instanceVariableNames: ''!

!RondaDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/10/2021 19:06:34'!
conCartasDeMano: unasCartasDeMano yCartasDePie: unasCartasDePie

	| cartasDeManoAsSet cartasDePieAsSet |
	
	cartasDeManoAsSet := Set withAll: unasCartasDeMano.
	cartasDePieAsSet := Set withAll: unasCartasDePie.
	
	self 
		assert: unasCartasDeMano 
		sonTresCon: cartasDeManoAsSet 
		yNoReptidasCon: unasCartasDePie 
		queDebenSerTres: cartasDePieAsSet.
		
	^self new initilizeConCartasDeMano: cartasDeManoAsSet yDePie: cartasDePieAsSet ! !


!RondaDeTruco class methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 19:07:55'!
cartasInvalidasErrorMessage
	
	^'Las cartas de los jugadores deben ser 3 y no repetidas'! !


!RondaDeTruco class methodsFor: 'assertions' stamp: 'HAW 7/10/2021 19:07:55'!
assert: unasCartasDeMano sonTresCon: cartasDeManoAsSet yNoReptidasCon: unasCartasDePie queDebenSerTres: cartasDePieAsSet

	unasCartasDeMano size = 3 ifFalse: [ self error: self cartasInvalidasErrorMessage ].
	unasCartasDePie size = 3 ifFalse: [ self error: self cartasInvalidasErrorMessage ].
	
	cartasDeManoAsSet size = 3 ifFalse: [ self error: self cartasInvalidasErrorMessage ].
	cartasDePieAsSet size = 3 ifFalse: [ self error: self cartasInvalidasErrorMessage ].
	
	(cartasDeManoAsSet union: cartasDePieAsSet) size = 6 ifFalse: [ self error: self cartasInvalidasErrorMessage ].
! !
