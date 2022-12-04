!classDefinition: #QatarOnlineTest category: 'ISW1-2022-2C-2doParcial'!
TestCase subclass: #QatarOnlineTest
	instanceVariableNames: 'dado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:03:41'!
test01UnJugadorSeMueveALaPosicionDestino

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: 12@12.
	
	self assert: 12@12 equals: (juego posicionDe: juego delanteroEquipo1).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:04:05'!
test02SePuedeConocerLaPosicionDeJugadoresDeLosDosEquipos

	| juego |
	
	juego := self crearJuego: #().
	
	self assert: 10@10 equals: (juego posicionDe: juego delanteroEquipo1).	
	self assert: 11@10 equals: (juego posicionDe: juego delanteroEquipo2).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 14:04:24'!
test03NoSePuedeConsultarPosicionDeAlgoQueNoEsJugador

	| juego |
	
	juego := self crearJuego: #().
	
	self 
		should: [ juego posicionDe: 'x' ]
		raise: Error - MessageNotUnderstood 
		withMessageText: juego jugadorInvalidErrorDescription! !

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

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 09:54:01'!
test06EmpiezaJugandoEquipo1

	| juego |
	
	juego := self crearJuego: #().
	
	self 
		should: [juego mover: juego delanteroEquipo2 a: 9@9 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: juego jugadorInvalidErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDeDelanteroEquipo2 equals: (juego posicionDe: juego delanteroEquipo2) ].
		! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:01:28'!
test07LosJugadoresMuevenAlternadamentePorEquipo

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10).
	
	juego mover: juego delanteroEquipo1 a: 12@12.
	juego mover: juego delanteroEquipo2 a: 9@9.
	juego mover: juego delanteroEquipo1 a: 14@14.
	
	self assert: 14@14 equals: (juego posicionDe: juego delanteroEquipo1).
	self assert: 9@9 equals: (juego posicionDe: juego delanteroEquipo2).! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:01:33'!
test08MovientoEnEjeXEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(5 10).
	
	juego mover: juego delanteroEquipo1 a: 20@20.
	
	self assert: 15@20 equals: (juego posicionDe: juego delanteroEquipo1).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:00:16'!
test09MovientoEnEjeYEsAfectadoPorDado

	| juego |
	
	juego := self crearJuego: #(10 5).
	
	juego mover: juego delanteroEquipo1 a: 20@20.
	
	self assert: 20@15 equals: (juego posicionDe: juego delanteroEquipo1).
	! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:09:31'!
test10PosicionDestinoDebeSerEntera

	| juego |
	
	juego := self crearJuego: #(1 1).
	
	juego mover: juego delanteroEquipo1 a: 15@15.
	
	self assert: 10@10 equals: (juego posicionDe: juego delanteroEquipo1).
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

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:16:24'!
test12LaPelotaSeMueveConElJugadorQueLaPosee

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: 15@15.
	
	self assert: (juego posicionDe: juego delanteroEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 12/4/2022 09:07:16'!
test13LaPelotaNoSeMueveConUnJugadorQueNoLaPosee

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego defensorEquipo1 a: 15@15.
	
	self assert: (juego posicionDe: juego delanteroEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:20:07'!
test14DelanteroVsDefensorGanaDefensro

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: (juego posicionDe: juego defensorEquipo2).
	
	self assert: (juego posicionDe: juego defensorEquipo2) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:42:40'!
test15DelanteroVsMediocampistaGanaDelanteroConDadoHasta5

	| juego |
	
	juego := self crearJuego: #(10 10 5).
	
	juego mover: juego delanteroEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego delanteroEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:43:06'!
test16DelanteroVsMediocampistaGanaMediocampistaConDadoDesde6

	| juego |
	
	juego := self crearJuego: #(10 10 6).
	
	juego mover: juego delanteroEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego mediocampistaEquipo2) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:45:35'!
test17DelanteroVsDelanteroGanaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego mover: juego delanteroEquipo1 a: (juego posicionDe: juego delanteroEquipo2).
	
	self assert: (juego posicionDe: juego delanteroEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego delanteroEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:53:38'!
test18DefensorVsDefensorGanaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10).
	
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego defensorEquipo2).
	
	self assert: (juego posicionDe: juego defensorEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 10:59:26'!
test19DefensorVsMediocampistaGanaDefensorConDadoHasta7

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 7).
	
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego defensorEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego defensorEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 11:00:54'!
test20DefensorVsMediocampistaGanaMediocampistaConDadoMayorA7

	| juego |
	
	juego := self crearJuego: #(10 10 10 10 10 10 8).
	
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego defensorEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego mediocampistaEquipo2) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 11:03:14'!
test21MediocampistaVsMediocampistaGanaPoseedorConDadoHasta6

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 6).
	
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego mediocampistaEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo1) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 11:05:35'!
test22MediocampistaVsMediocampistaGanaNoPoseedorConDadoDesde7

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 7).
	
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego mediocampistaEquipo2).
	
	self assert: (juego posicionDe: juego mediocampistaEquipo1) equals: juego posicionDePelota.
	self assert: (juego poseedorDePelotaEs: juego mediocampistaEquipo2) ! !

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 11:20:03'!
test23MediocampistaVsDefensorEsIgualADefensorVsMediocampista

	| juego |
	
	juego := self crearJuego: #(10 10 6 10 10 10 10 7).
	
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego delanteroEquipo1).
	juego mover: juego delanteroEquipo2 a: 1@1.
	juego mover: juego mediocampistaEquipo1 a: (juego posicionDe: juego defensorEquipo2).
	
	self assert: (juego posicionDe: juego defensorEquipo2 ) equals: juego posicionDePelota.
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

!QatarOnlineTest methodsFor: 'tests' stamp: 'HAW 11/30/2022 12:50:40'!
test27PasarLaPelotaAOtroJugadorCambiaPoseedorDePelota

	| juego |
	
	juego := self crearJuego: #(10 10).
	
	juego pasarPelotaA: (juego posicionDe: juego defensorEquipo1).
	
	self assert: (juego posicionDe: juego defensorEquipo1) equals: juego posicionDePelota.
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


!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 11/29/2022 17:22:40'!
assertMueveAPosicion: posicionDestino invalidaEn: juego

	^ self
		should: [ juego mover: juego delanteroEquipo1 a: posicionDestino ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: juego posicionInvalidaErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDeDelanteroEquipo1 equals: (juego posicionDe: juego delanteroEquipo1) ]! !

!QatarOnlineTest methodsFor: 'assertions' stamp: 'HAW 11/30/2022 12:40:03'!
assertPasarAPosicion: posicionDestino invalidaEn: juego

	^ self
		should: [ juego pasarPelotaA: posicionDestino ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: juego posicionInvalidaErrorDescription equals: anError messageText.
			self assert: juego posicionInicialDePelota equals: juego posicionDePelota ]! !


!QatarOnlineTest methodsFor: 'setup' stamp: 'HAW 11/30/2022 09:54:40'!
crearJuego: unosTirosDeDado

	dado := ReadStream on: unosTirosDeDado.
	
	^ QatarOnline conDado: self! !


!QatarOnlineTest methodsFor: 'dado' stamp: 'HAW 11/30/2022 09:59:04'!
tirar
	
	^dado next! !


!classDefinition: #Jugador category: 'ISW1-2022-2C-2doParcial'!
Object subclass: #Jugador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

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


!Jugador methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:34:39'!
esDefensor
	
	^false! !

!Jugador methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:33:04'!
esDelantero
	
	^false! !

!Jugador methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:35:16'!
esMediocampista
	
	^false! !


!classDefinition: #Defensor category: 'ISW1-2022-2C-2doParcial'!
Jugador subclass: #Defensor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Defensor methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:34:52'!
esDefensor

	^true! !


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


!classDefinition: #Delantero category: 'ISW1-2022-2C-2doParcial'!
Jugador subclass: #Delantero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Delantero methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:31:31'!
esDelantero
	
	^true! !


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


!classDefinition: #Mediocampista category: 'ISW1-2022-2C-2doParcial'!
Jugador subclass: #Mediocampista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

!Mediocampista methodsFor: 'testing' stamp: 'HAW 11/30/2022 10:35:02'!
esMediocampista

	^true! !


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


!classDefinition: #QatarOnline category: 'ISW1-2022-2C-2doParcial'!
Object subclass: #QatarOnline
	instanceVariableNames: 'equipo1 equipo2 equipos dado posicionDePelota poseedorDePelota'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-2doParcial'!

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


!QatarOnline methodsFor: 'initialization' stamp: 'HAW 11/30/2022 14:10:23'!
crearEquipo1

	^ Dictionary new
		at: self crearDefensor put: 2@10;
		at: self crearMediocampista put: 5@10;
		at: self crearDelantero put: self posicionInicialDeDelanteroEquipo1;
		yourself! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 11/30/2022 14:10:31'!
crearEquipo2

	^ Dictionary new
		at: self crearDefensor put: 19@10;
		at: self crearMediocampista put: 15@10;
		at: self crearDelantero put: self posicionInicialDeDelanteroEquipo2;
		yourself! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 11/30/2022 10:15:02'!
initializeConDado: unDado 
	
	self initializeEquipos.
	
	dado := unDado.
	posicionDePelota := self posicionInicialDePelota.
	poseedorDePelota := self delanteroEquipo1! !

!QatarOnline methodsFor: 'initialization' stamp: 'HAW 11/30/2022 14:10:36'!
initializeEquipos

	equipo1 := self crearEquipo1.
	equipo2 := self crearEquipo2.
	equipos := CircularReadStream on: { equipo1. equipo2 } moving: NullUnit new
	
		! !


!QatarOnline methodsFor: 'creacion de jugadores' stamp: 'HAW 11/30/2022 10:30:02'!
crearDefensor
	
	^Defensor new! !

!QatarOnline methodsFor: 'creacion de jugadores' stamp: 'HAW 11/30/2022 10:30:25'!
crearDelantero
	
	^Delantero new! !

!QatarOnline methodsFor: 'creacion de jugadores' stamp: 'HAW 11/30/2022 10:30:15'!
crearMediocampista
	
	^Mediocampista new! !


!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:11:41'!
defensorDe: unEquipo

	^ unEquipo keys detect: [:unJugador | unJugador esDefensor ]! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:11:38'!
defensorEquipo1
	
	^self defensorDe: equipo1! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:11:54'!
defensorEquipo2
	
	^self defensorDe: equipo2! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:12:28'!
delanteroDe: unEquipo

	^ unEquipo keys detect: [:unJugador | unJugador esDelantero ]! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:12:26'!
delanteroEquipo1
	
	^self delanteroDe: equipo1! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:12:40'!
delanteroEquipo2
	
	^self delanteroDe: equipo2
	! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:13:19'!
mediocampistaDe: unEquipo

	^ unEquipo keys detect: [:unJugador | unJugador esMediocampista ]! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:13:12'!
mediocampistaEquipo1
	
	^self mediocampistaDe: equipo1! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/30/2022 14:13:31'!
mediocampistaEquipo2

	^self mediocampistaDe: equipo2! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/29/2022 17:15:53'!
posicionDe: unJugador

	^equipo1 
		at: unJugador 
		ifAbsent: [ 
			equipo2 
				at: unJugador
				ifAbsent: [self error: self jugadorInvalidErrorDescription ]]! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/29/2022 17:20:44'!
posicionInicialDeDelanteroEquipo1
	
	^10@10! !

!QatarOnline methodsFor: 'jugadores' stamp: 'HAW 11/29/2022 17:32:17'!
posicionInicialDeDelanteroEquipo2
	
	^11@10! !


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

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:21:28'!
con: unJugador desde: posicionActual a: posicionDestino hacer: unBloque
	
	| posicionDestinoReal |
	
	self assertEstaEnTablero: posicionDestino.
	self assertEsPuntoEntero: posicionDestino.
	(self equipoActual includesKey: unJugador) ifFalse: [ self error: self jugadorInvalidErrorDescription ].
	
	posicionDestinoReal := self afectarPosicion: posicionActual llendoA: posicionDestino.
	
	unBloque value: posicionDestinoReal.
	
	self pasarAProximoEquipo
	! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:19:08'!
jugadoresConPelota

	| jugadoresConPelota |
	
	jugadoresConPelota := OrderedCollection withAll: (self jugadoresConPelotaDe: equipo1).
	jugadoresConPelota addAll: (self jugadoresConPelotaDe: equipo2).
	
	^jugadoresConPelota! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:18:36'!
jugadoresConPelotaDe: unEquipo

	^ (unEquipo select: [:unaPosicion | unaPosicion = posicionDePelota ]) keys! !

!QatarOnline methodsFor: 'mover' stamp: 'HAW 11/30/2022 14:23:16'!
mover: jugadorAMover a: posicionDestino 
	
	| jugadoresConPelota |
	
	self con: jugadorAMover desde: (self posicionDe: jugadorAMover) a: posicionDestino hacer: [ :posicionDestinoReal |
		self equipoActual at: jugadorAMover put: posicionDestinoReal.
		(self poseedorDePelotaEs: jugadorAMover) ifTrue: [ posicionDePelota := posicionDestinoReal ].
		posicionDePelota = posicionDestinoReal ifTrue: [
			jugadoresConPelota := self jugadoresConPelota.
			jugadoresConPelota size = 2 ifTrue: [ jugadoresConPelota first pelearPorPelotaCon: jugadoresConPelota second en: self ]]]! !


!QatarOnline methodsFor: 'equipo' stamp: 'HAW 11/29/2022 17:33:06'!
equipoActual

	^ equipos current! !

!QatarOnline methodsFor: 'equipo' stamp: 'HAW 11/29/2022 17:34:05'!
pasarAProximoEquipo
	
	equipos next! !


!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 12:50:54'!
estaLaPelotaLibre
	
	^poseedorDePelota isNil! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 14:24:16'!
pasarPelotaA: posicionDestino 
	
	| jugadoresConPelota |
	
	self con: poseedorDePelota desde: posicionDePelota a: posicionDestino hacer: [ :posicionDestinoReal |
		posicionDePelota := posicionDestinoReal.
		jugadoresConPelota := self jugadoresConPelota.
		jugadoresConPelota isEmpty 
			ifTrue: [ poseedorDePelota := nil ]
			ifFalse: [ poseedorDePelota := jugadoresConPelota first ]]! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:15:25'!
poseedorDePelotaEs: unJugador

	^poseedorDePelota = unJugador ! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:13:54'!
posicionDePelota
	
	^posicionDePelota! !

!QatarOnline methodsFor: 'pelota' stamp: 'HAW 11/30/2022 10:13:43'!
posicionInicialDePelota
	
	^10@10! !


!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 11/29/2022 17:15:31'!
jugadorInvalidErrorDescription
	
	^'Jugador inválido'! !

!QatarOnline methodsFor: 'descripciones de error' stamp: 'HAW 11/29/2022 17:20:35'!
posicionInvalidaErrorDescription
	
	^'Posición inválida'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'QatarOnline class' category: 'ISW1-2022-2C-2doParcial'!
QatarOnline class
	instanceVariableNames: ''!

!QatarOnline class methodsFor: 'instance creation' stamp: 'HAW 11/30/2022 09:54:56'!
conDado: unDado 
	
	^self new initializeConDado: unDado ! !
