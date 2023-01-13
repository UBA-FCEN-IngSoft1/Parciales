!classDefinition: #QatarOnlineTest category: 'ISW1-2022-2C-Recuperatorio'!
TestCase subclass: #QatarOnlineTest
	instanceVariableNames: 'dado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:33:36'!
estaEnOffsideTomandoJugadorCon: unBloque

	| juego jugadorEnOffside |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10 10 2).
	jugadorEnOffside := unBloque value: juego.
	
	juego pasarPelotaA: juego mediocampistaEquipo1 posicion.
	juego mover: juego defensorEquipo2 a: juego posicionInicialDeMediocampistaEquipo2.
	juego mover: jugadorEnOffside a: juego posicionInicialDeDefensorEquipo2.
	juego mover:  juego defensorEquipo2 a: juego posicionInicialDeMediocampistaEquipo2.
	
	self 
		should: [ juego pasarPelotaA: jugadorEnOffside posicion ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego offsideErrorDescription equals: anError messageText.
			
			self assert: jugadorEnOffside posicion equals: juego defensorEquipo2 posicion.
			self assert: juego defensorEquipo2 posicion equals: juego posicionDePelota.
			self assert: (juego poseedorDePelotaEs: juego defensorEquipo2) ]! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test01UnJugadorSeMueveALaPosicionDestino

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: 12@12.
	
	self assert: 12@12 equals: (juego delanteroEquipo1 posicion).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test02SePuedeConocerLaPosicionDeJugadoresDeLosDosEquipos

	| juego |
	
	juego := self crearJuego: #().
	
	self assert: 10@10 equals: (juego delanteroEquipo1 posicion).	
	self assert: 11@10 equals: (juego delanteroEquipo2 posicion).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 09:54:01'!
test04NoSePuedeMoverFueraDelTablero

	| juego |
	
	juego := self crearJuego: #().
	
	self assertMueveAPosicion: 0@1 invalidaEn: juego.
	self assertMueveAPosicion: 1@0 invalidaEn: juego.
	self assertMueveAPosicion: 21@1 invalidaEn: juego.
	self assertMueveAPosicion: 20@21 invalidaEn: juego.
	
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 09:54:01'!
test05PosicionDestinoDeMovimientoDebeSerUnPuntoEntero

	| juego |
	
	juego := self crearJuego: #().
	
	self assertMueveAPosicion: 1.1@1 invalidaEn: juego.
	self assertMueveAPosicion: 1@2.1 invalidaEn: juego.
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test06EmpiezaJugandoEquipo1

	| juego |
	
	juego := self crearJuego: #().
	
	self 
		should: [juego mover: juego delanteroEquipo2 a: 9@9 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego jugadorInvalidErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDeDelanteroEquipo2 equals: (juego delanteroEquipo2 posicion) ].
		! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test07LosJugadoresMuevenAlternadamentePorEquipo

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10).
	
	juego mover: juego delanteroEquipo1 a: 12@12.
	juego mover: juego delanteroEquipo2 a: 9@9.
	juego mover: juego delanteroEquipo1 a: 14@14.
	
	self assert: 14@14 equals: (juego delanteroEquipo1 posicion).
	self assert: 9@9 equals: (juego delanteroEquipo2 posicion).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test08MovientoEnEjeXEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(5 10).
	
	juego mover: juego delanteroEquipo1 a: 20@20.
	
	self assert: 15@20 equals: (juego delanteroEquipo1 posicion).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test09MovientoEnEjeYEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(10 5).
	
	juego mover: juego delanteroEquipo1 a: 20@20.
	
	self assert: 20@15 equals: (juego delanteroEquipo1 posicion).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test10PosicionDestinoDebeSerEntera

	| juego |
	
	juego := self crearJuego: #(1 1).
	
	juego mover: juego delanteroEquipo1 a: 15@15.
	
	self assert: 10@10 equals: (juego delanteroEquipo1 posicion).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:13:32'!
test11LaPelotaEmpiezaEn10_10YPoseidaPorDelanteroEquipo1

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	self assert: juego posicionInicialDePelota equals: juego posicionDePelota.
	self deny: 0@0 = juego posicionDePelota.
	
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1).
	self deny: (juego poseedorDePelotaEs: juego delanteroEquipo2).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test12LaPelotaSeMueveConElJugadorQueLaPosee

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: 15@15.
	
	self assert: (juego delanteroEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test13LaPelotaNoSeMueveConUnJugadorQueNoLaPosee

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego defensorEquipo1 a: 15@15.
	
	self assert: (juego delanteroEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test14DelanteroVsDefensorGanaDefensro

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: (juego defensorEquipo2 posicion).
	
	self assert: (juego defensorEquipo2 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test15DelanteroVsMediocampistaGanaDelanteroConDadoHasta5

	| juego |
	
	juego := self crearJuego: #(10 10 5).
	
	juego mover: juego delanteroEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego delanteroEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test16DelanteroVsMediocampistaGanaMediocampistaConDadoDesde6

	| juego |
	
	juego := self crearJuego: #(10 10 6).
	
	juego mover: juego delanteroEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego mediocampistaEquipo2 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test17DelanteroVsDelanteroGanaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: (juego delanteroEquipo2 posicion).
	
	self assert: (juego delanteroEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test18DefensorVsDefensorGanaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10).
	
	juego mover: juego defensorEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego defensorEquipo2 posicion).
	
	self assert: (juego defensorEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test19DefensorVsMediocampistaGanaDefensorConDadoHasta7

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 7).
	
	juego mover: juego defensorEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego defensorEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test20DefensorVsMediocampistaGanaMediocampistaConDadoMayorA7

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 8).
	
	juego mover: juego defensorEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego mediocampistaEquipo2 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test21MediocampistaVsMediocampistaGanaPoseedorConDadoHasta6

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 6).
	
	juego mover: juego mediocampistaEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego mediocampistaEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test22MediocampistaVsMediocampistaGanaNoPoseedorConDadoDesde7

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 7).
	
	juego mover: juego mediocampistaEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego mediocampistaEquipo2 posicion).
	
	self assert: (juego mediocampistaEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test23MediocampistaVsDefensorEsIgualADefensorVsMediocampista

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 7).
	
	juego mover: juego mediocampistaEquipo1 a: (juego delanteroEquipo1 posicion).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego defensorEquipo2 posicion).
	
	self assert: ((juego defensorEquipo2 posicion) ) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo2 ) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 12:39:15'!
test24NoSePuedePasarLaPelotaFueraDelTablero

	| juego |
	
	juego := self crearJuego: #().
	
	self assertPasarAPosicion: 0@1 invalidaEn: juego.
	self assertPasarAPosicion: 1@0 invalidaEn: juego.
	self assertPasarAPosicion: 21@1 invalidaEn: juego.
	self assertPasarAPosicion: 20@21 invalidaEn: juego.
	
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 12:41:00'!
test25PosicionDestinoDePelotaDebeSerUnPuntoEntero

	| juego |
	
	juego := self crearJuego: #().
	
	self assertPasarAPosicion: 1.1@1 invalidaEn: juego.
	self assertPasarAPosicion: 1@2.1 invalidaEn: juego.
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 12:42:58'!
test26SoloPuedePasarJugadorDelEquipoActual

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego defensorEquipo1 a: 2@2.
	
	self 
		should: [juego pasarPelotaA: 9@9 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego jugadorInvalidErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDePelota equals: juego posicionDePelota ].
		! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 11:08:14'!
test27PasarLaPelotaAOtroJugadorCambiaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego pasarPelotaA: (juego defensorEquipo1 posicion).
	
	self assert: (juego defensorEquipo1 posicion) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo1).
	self deny: juego estaLaPelotaLibre ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 12:49:34'!
test28PasarLaPelotaALugarSinJugadorHaceQueNoHayaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego pasarPelotaA: 2@2.
	
	self assert: 2@2 equals: juego posicionDePelota.
	self assert: juego estaLaPelotaLibre! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:00:28'!
test29PasarLaPelotaEnEjeXEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(5 10).
	
	juego pasarPelotaA: 20@20.
	
	self assert: 15@20 equals: juego posicionDePelota 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:02:26'!
test30PasarLaPelotaEnEjeYEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(10 5).
	
	juego pasarPelotaA: 20@20.
	
	self assert: 20@15 equals: juego posicionDePelota 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:02:56'!
test31PosicionDestinoDePelotaDebeSerEntera

	| juego |
	
	juego := self crearJuego: #(1 1).
	
	juego pasarPelotaA: 15@15.
	
	self assert: 10@10 equals: juego posicionDePelota ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:23:47'!
test32ElJuegoEmpiezaConCeroGolesParaLosEquipos

	| juego |
	
	juego := self crearJuego: #().
	
	self assertEmpatanEnCero: juego. ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:25:25'!
test33DelanteroDeEquipo1HaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10).
	
	juego mover:  juego delanteroEquipo1 a: 11@10.
	juego mover: juego delanteroEquipo2 a: 9@10.
	
	juego patearAlArco.
	
	self assertMetioGolEquipo1: juego 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:37:42'!
test34DelanteroDeEquipo1NoHaceGol

	| juego |
	
	juego := self crearJuego: #(9).
	
	juego patearAlArco.
	
	self assertNoMetioGol: juego yQuedoPelotaEn: juego defensorEquipo2 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:27:06'!
test35DelanteroDeEquipo2HaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10).
	
	juego pasarPelotaA: juego posicionInicialDeDelanteroEquipo2.
	juego mover: juego delanteroEquipo2 a: 10@10.
	juego mover: juego delanteroEquipo1 a: 11@10.
	 
	juego patearAlArco.
	
	self assertMetioGolEquipo2: juego 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:38:30'!
test36DelanteroDeEquipo2NoHaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 9).
	
	juego pasarPelotaA: juego posicionInicialDeDelanteroEquipo2.
	juego patearAlArco.
	
	self assertNoMetioGol: juego yQuedoPelotaEn: juego defensorEquipo1! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:38:57'!
test37NoPuedePatearPelotaEquipoQueNoLaPosee

	| juego |
	
	juego := self crearJuego: #(10 10 10).
	
	juego mover: juego defensorEquipo1 a: 3@10.
	 
	self 
		should: [ juego patearAlArco ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego equipoSinPelotaErrorDescription equals: anError messageText.
			self assertNoMetioGol: juego yQuedoPelotaEn: juego delanteroEquipo1 ]
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:39:11'!
test38MediocampistaQueNoPasoMitadDeLaCanchaNoHaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10).
	
	juego pasarPelotaA: juego mediocampistaEquipo1 posicion.
	juego mover: juego defensorEquipo2 a: 18@10.
	 
	self 
		should: [ juego patearAlArco ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego noPuedePatearLaPelotaErrorDescription equals: anError messageText.
			self assertNoMetioGol: juego yQuedoPelotaEn: juego mediocampistaEquipo1 ]
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:25:25'!
test39MediocampistaDeEquipo1QuePasoMitadDeLaCanchaHaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10 10).

	juego pasarPelotaA: juego mediocampistaEquipo1 posicion.	
	juego mover: juego defensorEquipo2 a: 18@10.
	juego mover: juego mediocampistaEquipo1 a: 16@10.
	juego mover: juego defensorEquipo2 a: 17@10.
	 
	juego patearAlArco.
	
	self assertMetioGolEquipo1: juego 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:28:07'!
test40MediocampistaDeEquipo2QuePasoMitadDeLaCanchaHaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10 10).

	juego pasarPelotaA: juego mediocampistaEquipo2 posicion.	
	juego mover: juego mediocampistaEquipo2 a: 4@10.
	juego mover: juego mediocampistaEquipo1 a: 18@10.
	
	juego patearAlArco.
	
	self assertMetioGolEquipo2: juego 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:37:42'!
test41MediocampistaQuePasoMitadDeLaCanchaNoHaceGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10 10).

	juego pasarPelotaA: juego mediocampistaEquipo1 posicion.	
	juego mover: juego mediocampistaEquipo2 a: 18@10.
	juego mover: juego mediocampistaEquipo1 a: 15@10.
	juego mover: juego defensorEquipo2 a: 17@10.
	 
	juego patearAlArco.
	
	self assertNoMetioGol: juego yQuedoPelotaEn: juego defensorEquipo2 
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:39:27'!
test42DefensorNoPuedeHacerGol

	| juego |
	
	juego := self crearJuego: #(10 10 10 10).
	
	juego pasarPelotaA: juego defensorEquipo2 posicion.
	 
	self 
		should: [ juego patearAlArco ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego noPuedePatearLaPelotaErrorDescription equals: anError messageText.
			self assertNoMetioGol: juego yQuedoPelotaEn: juego defensorEquipo2 ]
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 14:51:59'!
test43NoSePuedeCrearJuegoSinArbitros

	self 
		should: [ QatarOnline conDado: self arbitros: {} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: QatarOnline cantidadInvalidaDeArbitrosErrorDescription! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 14:51:59'!
test44NoSePuedeCrearJuegoConMasDeTresArbitros

	self 
		should: [ QatarOnline conDado: self arbitros: {
			Arbitro favoritismoEquipo1: 1 equipo2: 1.
			Arbitro favoritismoEquipo1: 1 equipo2: 1.
			Arbitro favoritismoEquipo1: 1 equipo2: 1.
			Arbitro favoritismoEquipo1: 1 equipo2: 1.
			} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: QatarOnline cantidadInvalidaDeArbitrosErrorDescription! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:30:43'!
test45MediocampistaEquipo1AdelantadoYPosibilidadValidaDaOffside

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 4).
	
	juego mover: juego mediocampistaEquipo1 a: juego defensorEquipo2 posicion.
	juego mover: juego defensorEquipo2 a: juego posicionInicialDeMediocampistaEquipo2 .
	
	self 
		should: [ juego pasarPelotaA: juego mediocampistaEquipo1 posicion ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego offsideErrorDescription equals: anError messageText.
			
			self assert: juego mediocampistaEquipo1 posicion equals: juego defensorEquipo2 posicion.
			self assert: juego defensorEquipo2 posicion equals: juego posicionDePelota.
			self assert: (juego poseedorDePelotaEs: juego defensorEquipo2) ]! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:30:50'!
test46MediocampistaEquipo1AdelantadoYPosibilidadInvalidaNoDaOffside

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 6).
	
	juego mover: juego mediocampistaEquipo1 a: juego defensorEquipo2 posicion.
	juego mover: juego defensorEquipo2 a: juego posicionInicialDeMediocampistaEquipo2 .
	
	juego pasarPelotaA: juego mediocampistaEquipo1 posicion.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo1)! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:30:20'!
test47MediocampistaEquipo2AdelantadoYPosibilidadValidaDaOffside

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10) favoritismoEquipo1: 0.6 favoritismoEquipo2: 0.4.
	
	juego mover: juego defensorEquipo1 a: juego mediocampistaEquipo1 posicion.
	juego mover: juego mediocampistaEquipo2 a: juego posicionInicialDeDefensorEquipo1.
	juego pasarPelotaA: juego delanteroEquipo2 posicion.
	
	self 
		should: [ juego pasarPelotaA: juego mediocampistaEquipo2 posicion ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego offsideErrorDescription equals: anError messageText.
			
			self assert: juego mediocampistaEquipo2 posicion equals: juego defensorEquipo1 posicion.
			self assert: juego defensorEquipo1 posicion equals: juego posicionDePelota.
			self assert: (juego poseedorDePelotaEs: juego defensorEquipo1) ]! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:32:04'!
test48MediocampistaEquipo2AdelantadoYPosibilidadInvalidaNoDaOffside

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 10 10 10) favoritismoEquipo1: 0.6 favoritismoEquipo2: 0.6.
	
	juego mover: juego defensorEquipo1 a: juego mediocampistaEquipo1 posicion.
	juego mover: juego mediocampistaEquipo2 a: juego posicionInicialDeDefensorEquipo1.
	juego pasarPelotaA: juego delanteroEquipo2 posicion.
	
	juego pasarPelotaA: juego mediocampistaEquipo2 posicion.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2)! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:32:23'!
test49DelanteroAdelantadoYPosibilidadValidaDaOffside

	self estaEnOffsideTomandoJugadorCon: [ :juego | juego delanteroEquipo1]! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 17:34:08'!
test50DefensorAdelantadoYPosibilidadValidaDaOffside

	self estaEnOffsideTomandoJugadorCon: [ :juego | juego defensorEquipo1 ]! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:46:31'!
test51FavoritismoEquipo1DebeSerPositivo

	self 
		should: [ Arbitro favoritismoEquipo1: -0.1 equipo2: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Arbitro favoritismoEquipo1InvalidErrorDescription! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:47:33'!
test52FavoritismoEquipo1DebeSerMenorA1

	self 
		should: [ Arbitro favoritismoEquipo1: 1.1 equipo2: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Arbitro favoritismoEquipo1InvalidErrorDescription! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:48:27'!
test53FavoritismoEquipo2DebeSerPositivo

	self 
		should: [ Arbitro favoritismoEquipo1: 1 equipo2: -0.1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Arbitro favoritismoEquipo2InvalidErrorDescription! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 1/13/2023 16:49:37'!
test54FavoritismoEquipo2DebeSerMenorA1

	self 
		should: [ Arbitro favoritismoEquipo1: 1 equipo2: 1.1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Arbitro favoritismoEquipo2InvalidErrorDescription! !


!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:23:47'!
assertEmpatanEnCero: juego

	self assert: 0 equals: juego golesEquipo1.
	self assert: 0 equals: juego golesEquipo2! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:24:13'!
assertEquipo1Gana1A0: juego

	self assert: 1 equals: juego golesEquipo1.
	self assert: 0 equals: juego golesEquipo2! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:26:14'!
assertEquipo2Gana1A0: juego

	self assert: 0 equals: juego golesEquipo1.
	self assert: 1 equals: juego golesEquipo2! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:24:30'!
assertJugadoresEstanEnPosicionInicial: juego

	self assert: juego posicionInicialDeDefensorEquipo1 equals: (juego defensorEquipo1 posicion).
	self assert: juego posicionInicialDeMediocampistaEquipo1 equals: (juego mediocampistaEquipo1 posicion).
	self assert: juego posicionInicialDeDelanteroEquipo1 equals: (juego delanteroEquipo1 posicion).
	
	self assert: juego posicionInicialDeDefensorEquipo2 equals: (juego defensorEquipo2 posicion).
	self assert: juego posicionInicialDeMediocampistaEquipo2 equals: (juego mediocampistaEquipo2 posicion).
	self assert: juego posicionInicialDeDelanteroEquipo2 equals: (juego delanteroEquipo2 posicion)! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:42:02'!
assertMetioGolEquipo1: juego

	self assertEquipo1Gana1A0: juego. 
	self assertJugadoresEstanEnPosicionInicial: juego.
	self assertSacaEquipo2: juego! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:41:51'!
assertMetioGolEquipo2: juego

	self assertEquipo2Gana1A0: juego. 
	self assertJugadoresEstanEnPosicionInicial: juego.
	self assertSacaEquipo1: juego! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 11:08:14'!
assertMueveAPosicion: posicionDestino invalidaEn: juego

	^ self
		should: [ juego mover: juego delanteroEquipo1 a: posicionDestino ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: juego posicionInvalidaErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDeDelanteroEquipo1 equals: (juego delanteroEquipo1 posicion) ]! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:38:06'!
assertNoMetioGol: juego yQuedoPelotaEn: jugadorConPelota 

	self assertEmpatanEnCero: juego. 
	
	self assert: (juego poseedorDePelotaEs: jugadorConPelota).
	self assert: (jugadorConPelota posicion) equals: juego posicionDePelota! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 11/30/2022 12:40:03'!
assertPasarAPosicion: posicionDestino invalidaEn: juego

	^ self
		should: [ juego pasarPelotaA: posicionDestino ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: juego posicionInvalidaErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDePelota equals: juego posicionDePelota ]! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:41:51'!
assertSacaEquipo1: juego

	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1).
	self assert: (juego delanteroEquipo1 posicion) equals: juego posicionDePelota! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 1/13/2023 17:42:02'!
assertSacaEquipo2: juego

	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo2).
	self assert: (juego delanteroEquipo2 posicion) equals: juego posicionDePelota! !


!QatarOnlineTest methodsFor: 'setup' stamp: 'HAW 1/13/2023 16:17:22'!
crearJuego: unosTirosDeDado

	^self crearJuego: unosTirosDeDado favoritismoEquipo1: 1 favoritismoEquipo2: 1! !

!QatarOnlineTest methodsFor: 'setup' stamp: 'HAW 1/13/2023 16:17:08'!
crearJuego: unosTirosDeDado favoritismoEquipo1: unFavoritimosEquipo1 favoritismoEquipo2: unFavoritismoEquipo2

	dado := ReadStream on: unosTirosDeDado.
	
	^ QatarOnline conDado: self arbitros: { Arbitro favoritismoEquipo1: unFavoritimosEquipo1 equipo2: unFavoritismoEquipo2 } ! !


!QatarOnlineTest methodsFor: 'dado' stamp: 'HAW 1/13/2023 12:32:13'!
tirar
	
	^dado next! !


!classDefinition: #Arbitro category: 'ISW1-2022-2C-Recuperatorio'!
Object subclass: #Arbitro
	instanceVariableNames: 'favoritismoEquipo1 favoritismoEquipo2'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Arbitro methodsFor: 'initialization' stamp: 'HAW 1/13/2023 14:48:21'!
initializeFavoritismoEquipo1: unFavoritismoEquipo1 equipo2: unFavoritismoEquipo2 
	
	favoritismoEquipo1 := unFavoritismoEquipo1.
	favoritismoEquipo2 := unFavoritismoEquipo2.! !


!Arbitro methodsFor: 'favoritismos' stamp: 'HAW 1/13/2023 16:03:49'!
favoritismoEquipo1
	
	^favoritismoEquipo1! !

!Arbitro methodsFor: 'favoritismos' stamp: 'HAW 1/13/2023 16:28:26'!
favoritismoEquipo2
	
	^favoritismoEquipo2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arbitro class' category: 'ISW1-2022-2C-Recuperatorio'!
Arbitro class
	instanceVariableNames: ''!

!Arbitro class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 16:51:18'!
assertEsValidoFavoritismoEquipo1: unFavoritismoEquipo1

	^ (unFavoritismoEquipo1 between: 0 and: 1) ifFalse: [ self error: self favoritismoEquipo1InvalidErrorDescription ]! !

!Arbitro class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 16:51:28'!
assertEsValidoFavoritismoEquipo2: unFavoritismoEquipo2

	^ (unFavoritismoEquipo2 between: 0 and: 1) ifFalse: [ self error: self favoritismoEquipo2InvalidErrorDescription ]! !

!Arbitro class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 16:51:28'!
favoritismoEquipo1: unFavoritismoEquipo1 equipo2: unFavoritismoEquipo2 
	
	self assertEsValidoFavoritismoEquipo1: unFavoritismoEquipo1.
	self assertEsValidoFavoritismoEquipo2: unFavoritismoEquipo2.
	
	^self new initializeFavoritismoEquipo1: unFavoritismoEquipo1 equipo2: unFavoritismoEquipo2 ! !


!Arbitro class methodsFor: 'error description' stamp: 'HAW 1/13/2023 16:46:50'!
favoritismoEquipo1InvalidErrorDescription
	
	^'El favoritismo del equipo 1 debe estar entre 0 y 1'! !

!Arbitro class methodsFor: 'error description' stamp: 'HAW 1/13/2023 16:48:43'!
favoritismoEquipo2InvalidErrorDescription
	
	^'El favoritismo del equipo 2 debe estar entre 0 y 1'! !


!classDefinition: #Equipo category: 'ISW1-2022-2C-Recuperatorio'!
Object subclass: #Equipo
	instanceVariableNames: 'nombre defensor mediocampista delantero goles contrario posicionDeArco'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Equipo methodsFor: 'initialization' stamp: 'HAW 1/13/2023 16:56:47'!
initializeLlamado: unNombre defensorEn: unaPosicionInicialDelDefensor medioCampistaEn: unaPosicionInicialDeMediocampista delanteroEn: unaPosicionInicialDeDelantero arcoEn: unaPosicionDeArco  
	
	"Otra manera de solucionarlo sería tener un dicionario de jugadores y posiciones, como lo hacia QatarOnline.
	Habría que probar que implicaría hacerlo así - Hernan"
	
	nombre := unNombre.
	defensor := Defensor de: self en: unaPosicionInicialDelDefensor.
	mediocampista := Mediocampista de: self en: unaPosicionInicialDeMediocampista.
	delantero := Delantero de: self en: unaPosicionInicialDeDelantero.
	goles := 0.
	posicionDeArco := unaPosicionDeArco ! !


!Equipo methodsFor: 'printing' stamp: 'HAW 1/13/2023 11:05:25'!
printOn: aStream

	aStream nextPutAll: nombre ! !


!Equipo methodsFor: 'contrario' stamp: 'HAW 1/13/2023 11:02:25'!
contrario
	
	^contrario! !

!Equipo methodsFor: 'contrario' stamp: 'HAW 1/13/2023 16:57:41'!
contrario: unEquipoContrario

	"Este mensaje está pensado solo para ser usado al momento de construcción de los equipos - Hernan"
	
	contrario := unEquipoContrario ! !


!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 10:26:39'!
defensor
	
	^defensor! !

!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 10:27:48'!
delantero
	
	^delantero! !

!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 16:59:05'!
esPropio: unJugador 
	
	^self jugadores includes: unJugador ! !

!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 15:32:15'!
jugadores

	^ { defensor. mediocampista. delantero }! !

!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 15:32:15'!
jugadoresEn: unaPosicion

	^self jugadores select: [:jugador | jugador estaEn: unaPosicion ]! !

!Equipo methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 10:27:30'!
mediocampista
	
	^mediocampista! !


!Equipo methodsFor: 'offside' stamp: 'HAW 1/13/2023 17:01:32'!
distanciaAlArcoDe: unJugador

	^ (unJugador posicion x - posicionDeArco x) abs! !

!Equipo methodsFor: 'offside' stamp: 'HAW 1/13/2023 17:01:50'!
estaAdelantado: unContrario

	| distanciaAlArcoDelContrario |
	
	distanciaAlArcoDelContrario := self distanciaAlArcoDe: unContrario.
	^self jugadores allSatisfy: [ :jugadorPropio | (self distanciaAlArcoDe: jugadorPropio) > distanciaAlArcoDelContrario ]! !


!Equipo methodsFor: 'goles' stamp: 'HAW 1/13/2023 10:37:24'!
goles
	
	^goles! !

!Equipo methodsFor: 'goles' stamp: 'HAW 1/13/2023 10:38:33'!
incrementarGoles

	goles := goles + 1! !


!Equipo methodsFor: 'arco' stamp: 'HAW 1/13/2023 11:14:03'!
posicionDeArco
	
	^posicionDeArco! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Equipo class' category: 'ISW1-2022-2C-Recuperatorio'!
Equipo class
	instanceVariableNames: ''!

!Equipo class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 16:55:45'!
llamado: unNombre defensorEn: unaPosicionInicialDelDefensor medioCampistaEn: unaPosicionInicialDeMediocampista delanteroEn: unaPosicionInicialDeDelantero arcoEn: unaPosicionDeArco  
	
	"No valido que las posiciones sean válidas porque son posiciones fijas... pero no estaría de más asegurarse que esten dentro del tablero - Hernan"
	
	^self new 
		initializeLlamado: unNombre 
		defensorEn: unaPosicionInicialDelDefensor 
		medioCampistaEn: unaPosicionInicialDeMediocampista 
		delanteroEn: unaPosicionInicialDeDelantero 
		arcoEn: unaPosicionDeArco ! !


!classDefinition: #Jugador category: 'ISW1-2022-2C-Recuperatorio'!
Object subclass: #Jugador
	instanceVariableNames: 'equipo posicion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Jugador methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:36:30'!
pelearPorPelotaCon: otraJugador en: unJuego

	self subclassResponsibility ! !

!Jugador methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 14:05:24'!
pelearPorPelotaConDefensor: unDefensor en: unJuego 

	self subclassResponsibility ! !

!Jugador methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 14:05:36'!
pelearPorPelotaConDelantero: unDelantero en: unJuego
	
	self subclassResponsibility ! !

!Jugador methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 14:05:49'!
pelearPorPelotaConMediocampista: unMediocampista en: unJuego

	self subclassResponsibility ! !


!Jugador methodsFor: 'initialization' stamp: 'HAW 1/13/2023 10:36:05'!
initializeDe: unEquipo en: unaPosicionInicial  
	
	equipo := unEquipo.
	posicion := unaPosicionInicial ! !


!Jugador methodsFor: 'printing' stamp: 'HAW 1/13/2023 11:06:06'!
printOn: aStream

	aStream 
		nextPutAll: self class name;
		nextPutAll: ' en ';
		print: equipo ! !


!Jugador methodsFor: 'posicion' stamp: 'HAW 1/13/2023 10:53:48'!
estaEn: unaPosicion 
	
	^posicion = unaPosicion ! !

!Jugador methodsFor: 'posicion' stamp: 'HAW 1/13/2023 12:44:10'!
pasoMitadDeCancha
	
	| posicionXArcoContrario |
	
	posicionXArcoContrario := equipo contrario posicionDeArco x.
	
	^posicion x between: (10 min: posicionXArcoContrario) and: (10 max: posicionXArcoContrario)! !

!Jugador methodsFor: 'posicion' stamp: 'HAW 1/13/2023 10:55:47'!
posicion
	
	^posicion! !

!Jugador methodsFor: 'posicion' stamp: 'HAW 1/13/2023 10:45:02'!
posicion: unaPosicion

	posicion := unaPosicion ! !


!Jugador methodsFor: 'offside' stamp: 'HAW 1/13/2023 17:03:57'!
limiteDeOffside

	self subclassResponsibility ! !


!Jugador methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:04:11'!
patearAlArcoEn: unJuego

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Jugador class' category: 'ISW1-2022-2C-Recuperatorio'!
Jugador class
	instanceVariableNames: ''!

!Jugador class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 10:35:55'!
de: unEquipo en: unaPosicionInicial  
	
	^self new initializeDe: unEquipo en: unaPosicionInicial ! !


!classDefinition: #Defensor category: 'ISW1-2022-2C-Recuperatorio'!
Jugador subclass: #Defensor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Defensor methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:54:48'!
pelearPorPelotaCon: unJugador en: unJuego

	unJugador pelearPorPelotaConDefensor: self en: unJuego ! !

!Defensor methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:57:53'!
pelearPorPelotaConDefensor: unDefensor en: unJuego 

	unJuego pelearPorPelotaConDefensor: unDefensor yDefensor: self
! !

!Defensor methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:38:53'!
pelearPorPelotaConDelantero: unDelantero en: unJuego

	^unJuego pelearPorPelotaConDelantero: unDelantero yDefensor: self! !

!Defensor methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 11:20:41'!
pelearPorPelotaConMediocampista: unMediocampista en: unJuego

	unJuego pelearPorPelotaConDefensor: self yMediocampista: unMediocampista ! !


!Defensor methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:44:27'!
limiteDeOffside
	
	^0.2! !


!Defensor methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 14:00:42'!
patearAlArcoEn: unJuego

	^unJuego defensorPateaAlArco! !


!classDefinition: #Delantero category: 'ISW1-2022-2C-Recuperatorio'!
Jugador subclass: #Delantero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Delantero methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:37:16'!
pelearPorPelotaCon: otroJugador en: unJuego

	^otroJugador pelearPorPelotaConDelantero: self en: unJuego! !

!Delantero methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:56:47'!
pelearPorPelotaConDefensor: unDefensor en: unJuego 

	unJuego pelearPorPelotaConDelantero: self yDefensor: unDefensor ! !

!Delantero methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:47:35'!
pelearPorPelotaConDelantero: unDelantero en: unJuego

	unJuego pelearPorPelotaConDelantero: unDelantero yDelantero: self! !

!Delantero methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 11:08:24'!
pelearPorPelotaConMediocampista: unMediocampista en: unJuego

	unJuego pelearPorPelotaConDelantero: self yMediocampista: unMediocampista ! !


!Delantero methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:41:11'!
limiteDeOffside
	
	^0.7! !


!Delantero methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 12:26:49'!
patearAlArcoEn: unJuego

	^unJuego delanteroPateaAlArco ! !


!classDefinition: #Mediocampista category: 'ISW1-2022-2C-Recuperatorio'!
Jugador subclass: #Mediocampista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!Mediocampista methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 11:04:14'!
pelearPorPelotaCon: unJugador en: unJuego

	unJugador pelearPorPelotaConMediocampista: self en: unJuego ! !

!Mediocampista methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 11:00:00'!
pelearPorPelotaConDefensor: unDefensor en: unJuego

	unJuego pelearPorPelotaConDefensor: unDefensor yMediocampista: self! !

!Mediocampista methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:42:05'!
pelearPorPelotaConDelantero: unDelantero en: unJuego

	unJuego pelearPorPelotaConDelantero: unDelantero yMediocampista: self! !

!Mediocampista methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 11:04:41'!
pelearPorPelotaConMediocampista: unMedioCampista en: unJuego 

	unJuego pelearPorPelotaConMediocampista: unMedioCampista yMediocampista: self
! !


!Mediocampista methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:35:09'!
limiteDeOffside
	
	^0.5! !


!Mediocampista methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 12:24:52'!
patearAlArcoEn: unJuego

	^unJuego mediocampistaPateaAlArco! !


!classDefinition: #QatarOnline category: 'ISW1-2022-2C-Recuperatorio'!
Object subclass: #QatarOnline
	instanceVariableNames: 'dado posicionDePelota poseedorDePelota equipo1 equipo2 equipoActual arbitros'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-Recuperatorio'!

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:58:20'!
pelearPorPelotaConDefensor: unDefensor yDefensor: otroDefensor

	! !

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 14:09:28'!
pelearPorPelotaConDefensor: unDefensor yMediocampista: unMediocampista

	poseedorDePelota := dado tirar >= 8 
		ifTrue: [ unMediocampista ]
		ifFalse: [ unDefensor ]! !

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:39:50'!
pelearPorPelotaConDelantero: unDelantero yDefensor: unDefensor

	poseedorDePelota := unDefensor ! !

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:47:27'!
pelearPorPelotaConDelantero: unDelantero yDelantero: otroDelantero

! !

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 10:44:37'!
pelearPorPelotaConDelantero: unDelantero yMediocampista: unMediocampista

	dado tirar >= 6 ifTrue: [ poseedorDePelota := unMediocampista ]! !

!QatarOnline methodsFor: 'posesion de pelota' stamp: 'HAW 11/30/2022 14:10:08'!
pelearPorPelotaConMediocampista: unMedioCampista yMediocampista: otroMediocampista

	dado tirar >= 7 ifTrue: [
		poseedorDePelota :=  poseedorDePelota = unMedioCampista 
			ifTrue: [ otroMediocampista ]
			ifFalse: [ unMedioCampista ]]! !


!QatarOnline methodsFor: 'initialization' stamp: 'HAW 1/13/2023 11:12:39'!
crearEquipo1

	equipo1 := Equipo 
		llamado: 'Equipo 1' 
		defensorEn: self posicionInicialDeDefensorEquipo1
		medioCampistaEn: self posicionInicialDeMediocampistaEquipo1
		delanteroEn: self posicionInicialDeDelanteroEquipo1 
		arcoEn: 1@10.
	! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 1/13/2023 11:12:50'!
crearEquipo2

	equipo2 := Equipo 
		llamado: 'Equipo 2' 
		defensorEn: self posicionInicialDeDefensorEquipo2
		medioCampistaEn: self posicionInicialDeMediocampistaEquipo2
		delanteroEn: self posicionInicialDeDelanteroEquipo2 
		arcoEn: 20@10.

	! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 1/13/2023 16:03:20'!
initializeConDado: unDado arbitros: unosArbitros  
	
	self initializeEquipos.
	
	dado := unDado.
	arbitros := unosArbitros.
	
	posicionDePelota := self posicionInicialDePelota.
	poseedorDePelota := self delanteroEquipo1.! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 1/13/2023 11:04:58'!
initializeEquipos

	self crearEquipo1.
	self crearEquipo2.
	
	equipo1 contrario: equipo2.
	equipo2 contrario: equipo1.
	equipoActual := equipo1.
	
		! !


!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:33'!
defensorEquipo1
	
	^equipo1 defensor! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:39'!
defensorEquipo2
	
	^equipo2 defensor ! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:33'!
delanteroEquipo1
	
	^equipo1 delantero ! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:39'!
delanteroEquipo2
	
	^equipo2 delantero 
	! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:33'!
mediocampistaEquipo1
	
	^equipo1 mediocampista ! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:39'!
mediocampistaEquipo2

	^equipo2 mediocampista ! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/13/2023 11:04:39'!
ponerJugadoresEnPosicionInicial
	
	equipo1 defensor posicion: self posicionInicialDeDefensorEquipo1.
	equipo1 mediocampista posicion: self posicionInicialDeMediocampistaEquipo1.
	equipo1 delantero posicion: self posicionInicialDeDelanteroEquipo1.
		
	equipo2 defensor posicion: self posicionInicialDeDefensorEquipo2.
	equipo2 mediocampista posicion: self posicionInicialDeMediocampistaEquipo2.
	equipo2 delantero posicion: self posicionInicialDeDelanteroEquipo2.
		
		
! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/12/2023 18:56:21'!
posicionInicialDeDefensorEquipo1

	^ 2@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/12/2023 18:58:17'!
posicionInicialDeDefensorEquipo2

	^ 19@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/29/2022 17:20:44'!
posicionInicialDeDelanteroEquipo1
	
	^10@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/29/2022 17:32:17'!
posicionInicialDeDelanteroEquipo2
	
	^11@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/12/2023 18:57:42'!
posicionInicialDeMediocampistaEquipo1

	^ 5@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 1/12/2023 18:58:35'!
posicionInicialDeMediocampistaEquipo2

	^ 15@10! !


!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 11:12:38'!
afectar: unEjeDePosicionOrigen llendoA: unEjeDePosicionDestino 
	
	| delta nuevoEje tiro |
	
	tiro := dado tirar.
	delta := (unEjeDePosicionDestino - unEjeDePosicionOrigen) * tiro / 10.
	nuevoEje := unEjeDePosicionOrigen + delta asInteger.
	
	^nuevoEje! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 10:24:55'!
afectarPosicion: posicionActual llendoA: posicionDestino
	
	| nuevoX nuevoY |
	
	nuevoX := self afectar: posicionActual x llendoA: posicionDestino x.
	nuevoY := self afectar: posicionActual y llendoA: posicionDestino y.
	
	^nuevoX @ nuevoY.
	! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:14:50'!
assertEsPuntoEntero: posicionDestino

	^ posicionDestino isIntegerPoint ifFalse: [ self error: self posicionInvalidaErrorDescription ]! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:14:37'!
assertEstaEnTablero: posicionDestino

	^ (posicionDestino between: 1@1 and: 20@20) ifFalse: [ self error: self posicionInvalidaErrorDescription ]! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 1/13/2023 16:59:05'!
con: unJugador a: posicionDestino hacer: unBloque
	
	| posicionDestinoReal |
	
	self assertEstaEnTablero: posicionDestino.
	self assertEsPuntoEntero: posicionDestino.
	(self equipoActual esPropio: unJugador) ifFalse: [ self error: self jugadorInvalidErrorDescription ].
	
	posicionDestinoReal := self afectarPosicion: unJugador posicion llendoA: posicionDestino.
	
	unBloque value: posicionDestinoReal.
	
	self pasarAProximoEquipo
	! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 1/13/2023 11:04:39'!
jugadoresConPelota

	| jugadoresConPelota |
	
	jugadoresConPelota := OrderedCollection withAll: ( equipo1 jugadoresEn: posicionDePelota ).
	jugadoresConPelota addAll: ( equipo2 jugadoresEn: posicionDePelota ).
	
	^jugadoresConPelota! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 1/13/2023 11:10:31'!
mover: jugadorAMover a: posicionDestino 
	
	| jugadoresConPelota |
	
	self con: jugadorAMover a: posicionDestino hacer: [ :posicionDestinoReal |
		jugadorAMover posicion: posicionDestinoReal.
		(self poseedorDePelotaEs: jugadorAMover) ifTrue: [ posicionDePelota := posicionDestinoReal ].
		posicionDePelota = posicionDestinoReal ifTrue: [
			jugadoresConPelota := self jugadoresConPelota.
			jugadoresConPelota size = 2 ifTrue: [ jugadoresConPelota first pelearPorPelotaCon: jugadoresConPelota second en: self ]]]! !


!QatarOnline methodsFor: 'equipo' stamp: 'HAW 1/13/2023 10:59:44'!
equipoActual

	^ equipoActual! !

!QatarOnline methodsFor: 'equipo' stamp: 'HAW 1/13/2023 11:15:35'!
equipoContrario

	^ self equipoActual contrario! !

!QatarOnline methodsFor: 'equipo' stamp: 'HAW 1/13/2023 11:02:18'!
pasarAProximoEquipo
	
	equipoActual := equipoActual contrario.! !


!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 12:50:54'!
estaLaPelotaLibre
	
	^poseedorDePelota isNil! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 1/13/2023 15:23:25'!
pasarPelotaA: posicionDestino 
	
	| jugadoresConPelota |
	
	self con: poseedorDePelota a: posicionDestino hacer: [ :posicionDestinoReal |
		posicionDePelota := posicionDestinoReal.
		jugadoresConPelota := self jugadoresConPelota.
		jugadoresConPelota isEmpty 
			ifTrue: [ poseedorDePelota := nil ]
			ifFalse: [ 
				poseedorDePelota := jugadoresConPelota first.
				self checkOffside ]]! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 1/13/2023 11:08:14'!
pelotaPoseidaPor: furturoPoseedorDePelota

	poseedorDePelota := furturoPoseedorDePelota.
	posicionDePelota := furturoPoseedorDePelota posicion ! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:15:25'!
poseedorDePelotaEs: unJugador

	^poseedorDePelota = unJugador ! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:13:54'!
posicionDePelota
	
	^posicionDePelota! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:13:43'!
posicionInicialDePelota
	
	^10@10! !


!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 1/13/2023 11:23:34'!
equipoSinPelotaErrorDescription
	
	^'El equipo no posee la pelota'! !

!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 11/29/2022 17:15:31'!
jugadorInvalidErrorDescription
	
	^'Jugador inválido'! !

!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 1/13/2023 12:25:45'!
noPuedePatearLaPelotaErrorDescription
	
	^'No puede patear la pelota'! !

!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 1/13/2023 15:37:27'!
offsideErrorDescription
	
	^'Offside'! !

!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 11/29/2022 17:20:35'!
posicionInvalidaErrorDescription
	
	^'Posición inválida'! !


!QatarOnline methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:37:06'!
arbitrosCantanOffisde

	^ self posibilidadDeOffside > poseedorDePelota limiteDeOffside! !

!QatarOnline methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:36:05'!
checkOffside
	
	self esOffside ifTrue: [
		self equipoContrario defensor posicion: poseedorDePelota posicion.
		self pelotaPoseidaPor: self equipoContrario defensor.
		self error: self offsideErrorDescription ]! !

!QatarOnline methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:37:11'!
esOffside

	^ self poseedorDePelotaAdelantado and: [ self arbitrosCantanOffisde ]! !

!QatarOnline methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:36:44'!
poseedorDePelotaAdelantado

	^ self equipoContrario estaAdelantado: poseedorDePelota! !

!QatarOnline methodsFor: 'offside' stamp: 'HAW 1/13/2023 16:34:30'!
posibilidadDeOffside

	^ 1 - (arbitros sum: [ :unArbitro | | tiroDeDado favoritismo |
			tiroDeDado := dado tirar.
			favoritismo := equipoActual = equipo1 ifTrue: [ unArbitro favoritismoEquipo1 ] ifFalse: [ unArbitro favoritismoEquipo2 ].
			favoritismo * (tiroDeDado / 10) ])! !


!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:12:35'!
assertPuedePatearAlArco

	(self equipoActual esPropio: poseedorDePelota) ifFalse: [ self error: self equipoSinPelotaErrorDescription ]! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 14:00:54'!
defensorPateaAlArco
	
	self error: self noPuedePatearLaPelotaErrorDescription ! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 12:55:08'!
delanteroPateaAlArco
	
	self patearAlArcoEnCondicionesPermitidas: 10
		
			! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:12:42'!
golErrado

	self pelotaPoseidaPor: self equipoContrario defensor! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:11:26'!
golMarcado

	self ponerJugadoresEnPosicionInicial.
	self equipoActual incrementarGoles.
	self pelotaPoseidaPor: self equipoContrario delantero! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 12:55:35'!
mediocampistaPateaAlArco
	
	poseedorDePelota pasoMitadDeCancha 
		ifTrue: [ self patearAlArcoEnCondicionesPermitidas: 15 ]
		ifFalse: [ self error: self noPuedePatearLaPelotaErrorDescription ]! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:12:16'!
patearAlArco
	
	self assertPuedePatearAlArco.
	
	poseedorDePelota patearAlArcoEn: self.
	! !

!QatarOnline methodsFor: 'patear al arco' stamp: 'HAW 1/13/2023 17:11:37'!
patearAlArcoEnCondicionesPermitidas: limiteDePosibilidadDeGol

	| distancia posibilidadDeGol posicionDeArco |
	
	posicionDeArco := self equipoContrario posicionDeArco.	
	distancia := posicionDePelota dist: posicionDeArco.
	posibilidadDeGol := dado tirar / 10 * (20 - distancia).
	
	posibilidadDeGol > limiteDePosibilidadDeGol 
		ifTrue: [ self golMarcado]
		ifFalse: [ self golErrado]! !


!QatarOnline methodsFor: 'goles' stamp: 'HAW 1/13/2023 11:04:33'!
golesEquipo1
	
	^equipo1 goles ! !

!QatarOnline methodsFor: 'goles' stamp: 'HAW 1/13/2023 11:04:39'!
golesEquipo2
	
	^equipo2 goles ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QatarOnline class' category: 'ISW1-2022-2C-Recuperatorio'!
QatarOnline class
	instanceVariableNames: ''!

!QatarOnline class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 15:02:08'!
assertCantidadValidaDeArbitros: unosArbitros

	^ (unosArbitros size between: 1 and: 3) ifFalse: [ self error: self cantidadInvalidaDeArbitrosErrorDescription ]! !

!QatarOnline class methodsFor: 'instance creation' stamp: 'HAW 1/13/2023 16:02:57'!
conDado: unDado arbitros: unosArbitros  
	
	 self assertCantidadValidaDeArbitros: unosArbitros.
	
	^self new initializeConDado: unDado arbitros: unosArbitros ! !


!QatarOnline class methodsFor: 'error description' stamp: 'HAW 1/13/2023 14:51:59'!
cantidadInvalidaDeArbitrosErrorDescription
	
	^'Deben haber de 1 a 3 arbitros'! !
