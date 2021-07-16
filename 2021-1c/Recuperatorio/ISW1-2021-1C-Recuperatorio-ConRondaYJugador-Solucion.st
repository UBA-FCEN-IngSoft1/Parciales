!classDefinition: #CartaDeTrucoTest category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
TestCase subclass: #CartaDeTrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

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


!CartaDeTrucoTest methodsFor: 'test - envido' stamp: 'HAW 7/14/2021 17:08:43'!
test21FigurasNoSumanEnEnvido

	self assert: 0 equals: (CartaDeTruco espadaCon: 10) valorDeEnvido.
	self assert: 0 equals: (CartaDeTruco espadaCon: 11) valorDeEnvido.
	self assert: 0 equals: (CartaDeTruco espadaCon: 12) valorDeEnvido.
! !


!classDefinition: #TrucoTest category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
TestCase subclass: #TrucoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

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


!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:25:35'!
test28ManoNoPuedeCantarEnvidoCuandoJugo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	
	self 
		should: [ ronda manoCantaEnvido ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ronda noSePuedeCantarEnvidoErrorMessage! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:33:45'!
test29ManoPuedeCantarEnvidoSiNoJugo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	self 
		shouldnt: [ ronda manoCantaEnvido ]
		raise: Error - MessageNotUnderstood ! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:28:36'!
test30PieNoPuedeCantarEnvidoCuandoJugo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	
	self 
		should: [ ronda pieCantaEnvido ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ronda noSePuedeCantarEnvidoErrorMessage! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:32:28'!
test31PiePuedeCantarEnvidoCuandoNoJugo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	self 
		shouldnt: [ ronda pieCantaEnvido ]
		raise: Error - MessageNotUnderstood 
		! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:35:14'!
test32PieNoPuedeCantarEnvidoCuandoManoNoJugo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	self 
		should: [ ronda pieCantaEnvido ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ronda noSePuedeCantarEnvidoErrorMessage 
		! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:37:28'!
test33ManoGanaPuntoPorEnvidoNoQuerido

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoCantaEnvido.
	ronda pieNoQuiereEnvido.
	
	self assert: 1 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido.! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 16:40:17'!
test34PieGanaPuntoPorEnvidoNoQuerido

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeEspada }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoJuega: CartaDeTruco anchoDeEspada.
	
	ronda pieCantaEnvido.
	ronda manoNoQuiereEnvido.
	
	self assert: 0 equals: ronda puntosDeManoPorEnvido.
	self assert: 1 equals: ronda puntosDePiePorEnvido.! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 19:41:30'!
test35ManoGanaDosPuntoPorEnvidoQueridoGanado

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 3}.
		
	ronda manoCantaEnvido.
	ronda pieQuiereEnvido.
	
	ronda manoSuma: 25.
	ronda pieSuma: 24.
	
	self assert: 2 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido.! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 17:00:01'!
test36ManoNoPuedeCantarCantidadQueNoTiene

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
		
	ronda manoCantaEnvido.
	ronda pieQuiereEnvido.
	
	self 
		should: [ ronda manoSuma: 26 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ronda sumaDeEnvidoInvalidaErrorDescription
	! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 19:43:22'!
test37FigurasNoSumanEnEnvido

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco espadaCon: 12. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 2}.
		
	ronda manoCantaEnvido.
	ronda pieQuiereEnvido.
	
	ronda manoSuma: 24.
	ronda pieSuma: 23.
	
	self assert: 2 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido ! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 19:42:13'!
test38CartasJugadasSeSumanParaEnvido

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco espadaCon: 12. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 2}.
		
	ronda manoJuega: (CartaDeTruco espadaCon: 12).
	ronda pieCantaEnvido.
	ronda manoQuiereEnvido.
	
	ronda manoSuma: 24.
	ronda pieSuma: 23.
	
	self assert: 2 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido ! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 19:42:30'!
test39SeUsaCartaMasAltaCuandoNoHayDosDelMismoPalo

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco espadaCon: 12. CartaDeTruco copaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco espadaCon: 4}.
		
	ronda manoJuega: (CartaDeTruco espadaCon: 12).
	ronda pieCantaEnvido.
	ronda manoQuiereEnvido.
	
	ronda manoSuma: 7.
	ronda pieSuma: 4.
	
	self assert: 2 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido ! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/14/2021 19:29:10'!
test40PieGanaDosPuntoPorEnvidoQueridoGanado

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 3. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
	
	ronda manoJuega: CartaDeTruco anchoDeEspada.	
	ronda pieCantaEnvido.
	ronda manoQuiereEnvido.
	
	ronda manoSuma: 24.
	ronda pieSuma: 25.
	
	self assert: 0 equals: ronda puntosDeManoPorEnvido.
	self assert: 2 equals: ronda puntosDePiePorEnvido.! !

!TrucoTest methodsFor: 'tests - envido' stamp: 'HAW 7/15/2021 15:06:48'!
test41ManoGanaDosPuntoPorEnvidoQueridoGanadoConMismoEnvidoQuePie

	| ronda |
	
	ronda := RondaDeTruco 
		conCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}.
	
	ronda manoJuega: CartaDeTruco anchoDeEspada.	
	ronda pieCantaEnvido.
	ronda manoQuiereEnvido.
	
	ronda manoSuma: 25.
	ronda pieSuma: 25.
	
	self assert: 2 equals: ronda puntosDeManoPorEnvido.
	self assert: 0 equals: ronda puntosDePiePorEnvido.! !


!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:13:25'!
hacerGanarAManoEn: truco

	^ self hacerGanarCon: [ self jugarRondaConManoGanador: truco ]! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:13:16'!
hacerGanarAPieEn: truco

	^ self hacerGanarCon: [ self jugarRondaConPieGanador: truco ]! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:13:06'!
hacerGanarCon: juegoDeRonda 

	^ 30 timesRepeat: juegoDeRonda ! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:18:39'!
iniciarRondaConManoComoGanadorEn: truco

	^ truco  
		iniciarRondaConCartasDeMano: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }
		yCartasDePie:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:18:39'!
iniciarRondaConPieComoGanadorEn: truco

	^ truco  
		iniciarRondaConCartasDeMano:  { CartaDeTruco oroCon: 4. CartaDeTruco anchoDeBasto . CartaDeTruco bastoCon: 4}
		yCartasDePie: { CartaDeTruco anchoDeEspada. CartaDeTruco espadaCon: 4. CartaDeTruco sieteDeOro }! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:17:09'!
jugarRondaConManoGanador: truco

	| ronda |
	
	ronda := self iniciarRondaConManoComoGanadorEn: truco.
	
	ronda manoJuega: CartaDeTruco anchoDeEspada.	
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	ronda manoJuega: CartaDeTruco sieteDeOro.
	ronda pieJuega: (CartaDeTruco bastoCon: 4)! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:17:25'!
jugarRondaConPieGanador: truco

	| ronda |
	
	ronda := self iniciarRondaConPieComoGanadorEn: truco.
	
	ronda manoJuega: CartaDeTruco anchoDeBasto.	
	ronda pieJuega: CartaDeTruco anchoDeEspada.
	ronda pieJuega: CartaDeTruco sieteDeOro.
	ronda manoJuega: (CartaDeTruco bastoCon: 4)! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:17:09'!
test42SeCuentanLosPuntosDelTrucoDeLaRonda

	| truco ronda |
	
	truco := Truco new.
	ronda := self iniciarRondaConManoComoGanadorEn: truco.
	
	ronda manoJuega: CartaDeTruco anchoDeEspada.	
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	ronda manoJuega: CartaDeTruco sieteDeOro.
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: 1 equals: truco puntosDeMano.
	self assert: 0 equals: truco puntosDePie.
	! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:19:23'!
test44NoSePuedeEmpezarUnaRondaSiNoSeTerminoLaAnterior

	| truco |
	
	truco := Truco new.
	self iniciarRondaConManoComoGanadorEn: truco.
	
	self
		should: [ self iniciarRondaConManoComoGanadorEn: truco ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: truco rondaActualNoTerminadaErrorDescription equals: anError messageText.
			self assert: 1 equals: truco cantidadDeRondas ] ! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:17:09'!
test45EnvidoSeTieneEnCuentaEnLosPuntos

	| truco ronda |
	
	truco := Truco new.
	ronda :=self iniciarRondaConManoComoGanadorEn: truco.
	
	ronda manoCantaEnvido.
	ronda pieQuiereEnvido.
	ronda manoSuma: 25.
	ronda pieSuma: 25.
	
	ronda manoJuega: CartaDeTruco anchoDeEspada.	
	ronda pieJuega: CartaDeTruco anchoDeBasto.
	ronda manoJuega: CartaDeTruco sieteDeOro.
	ronda pieJuega: (CartaDeTruco bastoCon: 4).
	
	self assert: 3 equals: truco puntosDeMano.
	self assert: 0 equals: truco puntosDePie.
	! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:10:46'!
test46ManoGanaCuandoHace30PuntosOMas

	| truco |
	
	truco := Truco new.
	30 timesRepeat: [ self jugarRondaConManoGanador: truco ].
		
	self assert: truco ganoMano.
	self deny: truco ganoPie
	! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:12:14'!
test47PieGanaCuandoHace30PuntosOMas

	| truco |
	
	truco := Truco new.
	self hacerGanarAPieEn: truco.
		
	self deny: truco ganoMano.
	self assert: truco ganoPie
	! !

!TrucoTest methodsFor: 'tests - truco' stamp: 'HAW 7/15/2021 15:17:09'!
test48NoSePuedeSeguirJugandoSiHayGanador

	| truco |
	
	truco := Truco new.
	self hacerGanarAManoEn: truco.
		
	self 
		should: [ self iniciarRondaConManoComoGanadorEn: truco ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: truco juegoTerminadoErrorDescription equals: anError messageText.
			self assert: 30 equals: truco cantidadDeRondas ]! !


!classDefinition: #CartaDeTruco category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
Object subclass: #CartaDeTruco
	instanceVariableNames: 'palo numero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

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

!CartaDeTruco methodsFor: 'palos' stamp: 'HAW 7/14/2021 16:56:37'!
palo
	
	^palo! !


!CartaDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:35:11'!
esFigura

	^ numero >=10! !

!CartaDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:35:11'!
valorDeEnvido
	
	^self esFigura ifTrue: [ 0 ] ifFalse: [ numero ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartaDeTruco class' category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
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


!classDefinition: #JugadorDeTruco category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
Object subclass: #JugadorDeTruco
	instanceVariableNames: 'cartasDisponibles cartasJugadas contrincante ronda puntosDeEnvido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

!JugadorDeTruco methodsFor: 'cartas' stamp: 'HAW 7/11/2021 23:52:33'!
cantidadDeCartasJugadas
	
	^cartasJugadas size! !

!JugadorDeTruco methodsFor: 'cartas' stamp: 'HAW 7/11/2021 23:52:39'!
cartaJuagadaAt: unNumeroDeEnfrentamiento

	^cartasJugadas at: unNumeroDeEnfrentamiento ! !

!JugadorDeTruco methodsFor: 'cartas' stamp: 'HAW 7/11/2021 23:52:53'!
conEnfrentamientosHacer: accionDeCartas

	| lastIndex |
	
	lastIndex := self cantidadDeCartasJugadas min: contrincante cantidadDeCartasJugadas.
	
	1 to: lastIndex do: [ :index |
		accionDeCartas value: (self cartaJuagadaAt: index) value: (contrincante cartaJuagadaAt: index) value: index ].

	! !

!JugadorDeTruco methodsFor: 'cartas' stamp: 'HAW 7/11/2021 23:53:56'!
ultimaCartaJugada
	
	^cartasJugadas last! !


!JugadorDeTruco methodsFor: 'initialization' stamp: 'HAW 7/11/2021 23:54:12'!
contrincante: unPie

	contrincante := unPie ! !

!JugadorDeTruco methodsFor: 'initialization' stamp: 'HAW 7/14/2021 16:39:27'!
initializeCon: unasCartasDisponibles en: unaRondaDeTruco 
	
	cartasDisponibles := unasCartasDisponibles.
	ronda := unaRondaDeTruco.
	cartasJugadas := OrderedCollection new.
	puntosDeEnvido := 0.! !


!JugadorDeTruco methodsFor: 'jugar' stamp: 'HAW 7/12/2021 00:08:21'!
jugar: unaCartaDeTruco 

	cartasDisponibles remove: unaCartaDeTruco ifAbsent: [self error: ronda cartaNoDisponibleErrorDescription ].
	cartasJugadas add: unaCartaDeTruco. 
! !


!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/11/2021 23:52:44'!
cartasJugadasSon: unasCartas 

	^ cartasJugadas asArray = unasCartas asArray ! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/12/2021 00:09:44'!
fuePardaPrimerEnfrentamiento

	^(self cartaJuagadaAt: 1) empardaCon: (contrincante cartaJuagadaAt: 1)! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/11/2021 23:53:10'!
gano

	| ganados |
	
	ganados := 0.
	self conEnfrentamientosHacer: [ :cartaPropia :cartaDeContrincante :index |
		(cartaPropia mataA: cartaDeContrincante) ifTrue: [ 
			ganados := ganados + 1.
			(index = 2 and: [ self fuePardaPrimerEnfrentamiento ]) ifTrue: [ ganados := ganados + 1 ]]].

	^ganados = 2
	! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/11/2021 23:53:17'!
ganoUltimoEnfrentamiento
	
	^self ultimaCartaJugada mataA: contrincante ultimaCartaJugada! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/14/2021 16:31:50'!
jugo
	
	^cartasJugadas notEmpty ! !

!JugadorDeTruco methodsFor: 'testing' stamp: 'HAW 7/15/2021 15:33:55'!
noJugo
	
	^self jugo not! !


!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:33:37'!
cantaEnvido
	
	self jugo ifTrue: [ ronda signalNoSePuedeCantarEnvido ]! !

!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:01:37'!
envidoNoQuerido
	
	contrincante envidoNoQueridoGanado! !

!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:01:37'!
envidoNoQueridoGanado
	
	puntosDeEnvido := 1! !

!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:47:58'!
envidoQueridoGanado
	
	puntosDeEnvido := 2! !

!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:05:01'!
sumaDeEnvido
	
	| cartasPorPalo cartasDeEnvido todasLasCartas |
	
	todasLasCartas := cartasDisponibles, cartasJugadas.
	cartasPorPalo := todasLasCartas groupBy: [ :unaCarta | unaCarta palo ].
	
	cartasDeEnvido := cartasPorPalo values 
		detect: [ :cartasDeMismoPalo | cartasDeMismoPalo size = 2 ]
		ifNone: [ ^todasLasCartas max: [ :unaCarta | unaCarta valorDeEnvido ] ].
	
	^20 + (cartasDeEnvido sum: [ :unaCarta | unaCarta valorDeEnvido ])
	
	! !

!JugadorDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:59:16'!
sumaEnEnvido: sumaDeEnvido

	self sumaDeEnvido = sumaDeEnvido ifFalse: [ ronda signalSumaDeEnvidoInvalida ]! !


!JugadorDeTruco methodsFor: 'puntos' stamp: 'HAW 7/14/2021 16:38:50'!
puntosDeEnvido
	
	^puntosDeEnvido! !

!JugadorDeTruco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:28:53'!
puntosPorJugarCartas
	
	^self gano ifTrue: [ 1 ] ifFalse: [ 0 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'JugadorDeTruco class' category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
JugadorDeTruco class
	instanceVariableNames: ''!

!JugadorDeTruco class methodsFor: 'instance creation' stamp: 'HAW 7/11/2021 23:55:03'!
con: unasCartasDisponibles en: unaRondaDeTruco 
	
	^self new initializeCon: unasCartasDisponibles en: unaRondaDeTruco ! !


!classDefinition: #RondaDeTruco category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
Object subclass: #RondaDeTruco
	instanceVariableNames: 'mano pie'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/11/2021 23:14:51'!
cartasJugadasPorManoSon: unasCartas

	^mano cartasJugadasSon: unasCartas ! !

!RondaDeTruco methodsFor: 'cartas jugadas' stamp: 'HAW 7/11/2021 23:15:03'!
cartasJugadasPorPieSon: unasCartas

	^pie cartasJugadasSon: unasCartas ! !


!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 20:11:26'!
cartaNoDisponibleErrorDescription
	
	^'Carta no disponible para jugar'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 19:12:39'!
noEsTurnoDelJugadorErrorDescription
	
	^'No es el turno para jugar'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/14/2021 16:25:53'!
noSePuedeCantarEnvidoErrorMessage
	
	^'No se puede cantar envido'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/10/2021 19:36:40'!
noSePuedeJugarConRondaTerminadaErrorDescription
	
	^'No se puede jugar cuando hay ganador'! !

!RondaDeTruco methodsFor: 'error descriptions' stamp: 'HAW 7/14/2021 16:49:36'!
sumaDeEnvidoInvalidaErrorDescription
	
	^'Suma de envido invalida'! !


!RondaDeTruco methodsFor: 'initialization' stamp: 'HAW 7/14/2021 19:57:03'!
initilizeConCartasDeMano: unasCartasDeMano yDePie: unasCartasDePie

	mano := JugadorDeTruco con: unasCartasDeMano en: self.
	pie := JugadorDeTruco con: unasCartasDePie en: self.
	mano contrincante: pie.
	pie contrincante: mano.
	
	
	
	
	! !


!RondaDeTruco methodsFor: 'jugar' stamp: 'HAW 7/12/2021 00:13:05'!
manoJuega: unaCartaDeTruco 
	
	self juega: mano con: unaCartaDeTruco si: self juegaMano ! !

!RondaDeTruco methodsFor: 'jugar' stamp: 'HAW 7/12/2021 00:13:20'!
pieJuega: unaCartaDeTruco 
	
	self juega: pie con: unaCartaDeTruco si: self juegaPie ! !


!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/11/2021 23:38:22'!
ganoMano
	
	^mano gano! !

!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/11/2021 23:39:19'!
ganoPie
	
	^pie gano! !

!RondaDeTruco methodsFor: 'quien gano' stamp: 'HAW 7/10/2021 19:49:06'!
hayGanador

	^ self ganoMano or: [ self ganoPie ]! !


!RondaDeTruco methodsFor: 'quien juega' stamp: 'HAW 7/12/2021 00:09:30'!
juegaMano
	
	mano noJugo ifTrue: [ ^true ].
	mano cantidadDeCartasJugadas > pie cantidadDeCartasJugadas ifTrue: [ ^false ].
	mano cantidadDeCartasJugadas < pie cantidadDeCartasJugadas ifTrue: [ ^true ].
	
	^mano ganoUltimoEnfrentamiento or: [ mano fuePardaPrimerEnfrentamiento ]! !

!RondaDeTruco methodsFor: 'quien juega' stamp: 'HAW 7/10/2021 19:59:49'!
juegaPie
	
	^self juegaMano not! !


!RondaDeTruco methodsFor: 'jugar - private' stamp: 'HAW 7/12/2021 00:12:48'!
juega: unJugador con: unaCartaDeTruco si: esTurno
	
	self hayGanador ifTrue: [ self error: self noSePuedeJugarConRondaTerminadaErrorDescription ].
	esTurno ifFalse: [ self error: self noEsTurnoDelJugadorErrorDescription ].

	unJugador jugar: unaCartaDeTruco ! !


!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:31:20'!
puntosDeMano
	
	^self puntosDeManoPorJugarCartas + self puntosDeManoPorEnvido ! !

!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/14/2021 16:38:42'!
puntosDeManoPorEnvido
	
	^mano puntosDeEnvido! !

!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:31:20'!
puntosDeManoPorJugarCartas

	^ mano puntosPorJugarCartas ! !

!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:31:32'!
puntosDePie
	
	^self puntosDePiePorJugarCartas + self puntosDePiePorEnvido ! !

!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/14/2021 16:39:04'!
puntosDePiePorEnvido
	
	^pie puntosDeEnvido ! !

!RondaDeTruco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:31:32'!
puntosDePiePorJugarCartas

	^ pie puntosPorJugarCartas ! !


!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:34:05'!
manoCantaEnvido
	
	mano cantaEnvido ! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:42:28'!
manoNoQuiereEnvido
	
	mano envidoNoQuerido ! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:32:48'!
manoQuiereEnvido
	
	"Esta solo para seguir el proceso de envido pero como no se pidio validarlo no hace nada - Hernan"! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:50:11'!
manoSuma: sumaDeEnvido

	mano sumaEnEnvido: sumaDeEnvido ! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 19:57:08'!
pieCantaEnvido
	
	mano noJugo ifTrue: [ self error: self noSePuedeCantarEnvidoErrorMessage ].
	
	pie cantaEnvido.
	! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:44:22'!
pieNoQuiereEnvido
	
	pie envidoNoQuerido! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:32:40'!
pieQuiereEnvido
	
	"Esta solo para seguir el proceso de envido pero como no se pidio validarlo no hace nada - Hernan"! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/15/2021 15:08:52'!
pieSuma: sumaDeEnvido

	| ganadorDeEnvido |
	
	pie sumaEnEnvido: sumaDeEnvido.
	ganadorDeEnvido := sumaDeEnvido > mano sumaDeEnvido ifTrue: [ pie ] ifFalse: [ mano ].
	ganadorDeEnvido envidoQueridoGanado! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:26:27'!
signalNoSePuedeCantarEnvido
	
	self error: self noSePuedeCantarEnvidoErrorMessage ! !

!RondaDeTruco methodsFor: 'envido' stamp: 'HAW 7/14/2021 16:53:24'!
signalSumaDeEnvidoInvalida
	
	self error: self sumaDeEnvidoInvalidaErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RondaDeTruco class' category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
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


!classDefinition: #Truco category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!
Object subclass: #Truco
	instanceVariableNames: 'rondas'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-Recuperatorio-ConRondaYJugador-Solucion'!

!Truco methodsFor: 'rondas' stamp: 'HAW 7/14/2021 20:18:27'!
cantidadDeRondas
	
	^rondas size! !

!Truco methodsFor: 'rondas' stamp: 'HAW 7/15/2021 15:20:12'!
iniciarRondaConCartasDeMano: cartasDeMano yCartasDePie: cartasDePie

	self assertRondaActualTerminada.
	self assertJuegoNoTermiando.
	
	^rondas add: (RondaDeTruco conCartasDeMano: cartasDeMano yCartasDePie: cartasDePie)! !

!Truco methodsFor: 'rondas' stamp: 'HAW 7/14/2021 20:13:53'!
rondaActual
	
	^rondas lastIfEmpty: [ self error: self noSeEmpezoElJuegoErrorDescription ]! !

!Truco methodsFor: 'rondas' stamp: 'HAW 7/15/2021 15:19:07'!
rondaActualNoTerminada

	^ rondas notEmpty and: [ self rondaActual hayGanador not ]! !


!Truco methodsFor: 'quien gano' stamp: 'HAW 7/15/2021 15:23:19'!
ganoMano
	
	^self puntosDeMano >= self puntosParaGanar! !

!Truco methodsFor: 'quien gano' stamp: 'HAW 7/15/2021 15:23:29'!
ganoPie
	
	^self puntosDePie >= self puntosParaGanar ! !

!Truco methodsFor: 'quien gano' stamp: 'HAW 7/15/2021 15:19:38'!
hayGanador

	^ self ganoMano or: [ self ganoPie ]! !


!Truco methodsFor: 'error descriptions' stamp: 'HAW 7/14/2021 20:34:24'!
juegoTerminadoErrorDescription
	
	^'No se puede jugar porque el juego esta terminado'! !

!Truco methodsFor: 'error descriptions' stamp: 'HAW 7/14/2021 20:28:04'!
noSeEmpezoElJuegoErrorDescription

	^'No se empezo a jugar'! !

!Truco methodsFor: 'error descriptions' stamp: 'HAW 7/15/2021 15:19:23'!
rondaActualNoTerminadaErrorDescription
	
	^'La ronda actual no esta terminada'! !


!Truco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:24:42'!
puntosDe: calculadorDePunto
	
	^rondas sum:calculadorDePunto ifEmpty: [ 0 ]! !

!Truco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:24:51'!
puntosDeMano
	
	^self puntosDe: [ :ronda | ronda puntosDeMano ]
	! !

!Truco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:25:00'!
puntosDePie
	
	^self puntosDe: [ :ronda | ronda puntosDePie ]
	! !

!Truco methodsFor: 'puntos' stamp: 'HAW 7/15/2021 15:23:19'!
puntosParaGanar

	^ 30! !


!Truco methodsFor: 'aserciones' stamp: 'HAW 7/15/2021 15:20:12'!
assertJuegoNoTermiando

	^ self hayGanador ifTrue: [ self error: self juegoTerminadoErrorDescription ]! !

!Truco methodsFor: 'aserciones' stamp: 'HAW 7/15/2021 15:20:03'!
assertRondaActualTerminada

	^ self rondaActualNoTerminada ifTrue: [ self error: self rondaActualNoTerminadaErrorDescription ]! !


!Truco methodsFor: 'initialization' stamp: 'HAW 7/14/2021 20:08:01'!
initialize

	rondas := OrderedCollection new.! !
