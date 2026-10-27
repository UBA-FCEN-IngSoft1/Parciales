!classDefinition: #Automovilista category: #'2026-2C-1erParcial'!
Object subclass: #Automovilista
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Automovilista class' category: #'2026-2C-1erParcial'!
Automovilista class
	instanceVariableNames: ''!

!Automovilista class methodsFor: 'descripciones de error' stamp: 'ARM 21/Sep/2026, 7:12:46 pm (UTC)'!
accidentadoNoPuedeAvanzarDescripcionDeError

	^ 'Un automovilista accidentado no puede avanzar'! !

!Automovilista class methodsFor: 'descripciones de error' stamp: 'ARM 21/Sep/2026, 7:14:04 pm (UTC)'!
cartaDeDistanciaInvalidaDescripcionDeError

	^ 'Las cartas de distancia son de 25, 50, 75, 100 o 200 millas'! !


!classDefinition: #MilMillasTest category: #'2026-2C-1erParcial'!
TestCase subclass: #MilMillasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MilMillasTest class' category: #'2026-2C-1erParcial'!
MilMillasTest class
	instanceVariableNames: ''!

!MilMillasTest class methodsFor: 'class initialization' stamp: 'ARM 22/Sep/2026, 2:07:26 pm (UTC)'!
initialize

	Smalltalk at: #milla put: (BaseUnit named: 'milla')! !

MilMillasTest initialize!

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:46:57 pm (UTC)'!
test01ElDeportivoAvanzaElDobleDeLaCarta

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.

	self assert: 0 * milla equals: (self millasRecorridasPor: automovilista).
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:49:10 pm (UTC)'!
test02AlCamionNingunaCartaLeValeMasDe100

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.

	self jugarCartaDe: 200 * milla para: automovilista.

	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista).
	
	self jugarCartaDe: 50 * milla para: automovilista.
	self assert: 150 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:50:17 pm (UTC)'!
test03SoloExistenCartasDe25De50De75De100YDe200

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self 
		should: [ self jugarCartaDe: 30 * milla para: automovilista ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Automovilista cartaDeDistanciaInvalidaDescripcionDeError equals: error messageText.
			self assert: 0 * milla equals: (self millasRecorridasPor: automovilista) ]! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:52:05 pm (UTC)'!
test04ElAsDelVolanteAnulaElAccidente

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self accidente a: automovilista.
	
	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:52:38 pm (UTC)'!
test05ElAccidenteRompeAlDeportivo

	| automovilista |
	
	"La vía libre no sirve contra el accidente. El deportivo queda accidentado y pierde 100 millas."
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.
	
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self atacarCon: self accidente a: automovilista.
	
	self assert: (self estaAccidentado: automovilista).
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista).
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self 
		should: [ self jugarCartaDe: 25 * milla para: automovilista. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Automovilista accidentadoNoPuedeAvanzarDescripcionDeError equals: error messageText.
			self assert: 100 * milla equals: (self millasRecorridasPor: automovilista) ]! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:54:27 pm (UTC)'!
test06ElDeportivoAccidentadoNoQuedaConMillasNegativas

	| automovilista |

	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.

	self jugarCartaDe: 25 * milla para: automovilista.

	self atacarCon: self accidente a: automovilista.
	
	self assert: 0 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:56:20 pm (UTC)'!
test07ElCamionAguantaElAccidente

	| automovilista |
	
	"Queda accidentado pero no pierde millas"
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self atacarCon: self accidente a: automovilista.
	
	self assert: (self estaAccidentado: automovilista).
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista).
	self 
		should: [ self jugarCartaDe: 100 * milla para: automovilista ]
		raise: Error - MessageNotUnderstood
		withMessageText: Automovilista accidentadoNoPuedeAvanzarDescripcionDeError! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:58:35 pm (UTC)'!
test08ElAsDelVolanteTambienSirveEnElCamion

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self asDelVolante.

	self atacarCon: self accidente a: automovilista.

	self jugarCartaDe: 200 * milla para: automovilista.

	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 3:59:31 pm (UTC)'!
test09LaViaLibreAnulaElLimiteDeVelocidad

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:00:33 pm (UTC)'!
test10ElDeportivoBajoLimiteDeVelocidadAvanzaDeA25

	| automovilista |
	
	"El as del volante no sirve contra el límite"
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self limiteDeVelocidad a: automovilista.
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	self assert: 25 * milla equals: (self millasRecorridasPor: automovilista).
	
	self jugarCartaDe: 25 * milla para: automovilista.
	self assert: 50 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:01:09 pm (UTC)'!
test11AlCamionElLimiteDeVelocidadNoLeCambiaNada

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self asDelVolante.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 200 * milla para: automovilista.
	self jugarCartaDe: 100 * milla para: automovilista.

	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:02:29 pm (UTC)'!
test12EnElCamionLaViaLibreNoTieneNadaQueAnular

	| automovilista |
	
	"Como el límite no le cambia nada al camión, tampoco hay contraataque"
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 200 * milla para: automovilista.
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:03:47 pm (UTC)'!
test13LimiteYDespuesAccidente

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self limiteDeVelocidad a: automovilista.
	self atacarCon: self accidente a: automovilista.
	
	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	self assert: 25 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:05:39 pm (UTC)'!
test14AccidenteYDespuesLimite

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.

	self atacarCon: self accidente a: automovilista.
	self atacarCon: self limiteDeVelocidad a: automovilista.

	self assert: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	self 
		should: [ self jugarCartaDe: 25 * milla para: automovilista ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Automovilista accidentadoNoPuedeAvanzarDescripcionDeError equals: error messageText.
			self assert: 0 * milla equals: (self millasRecorridasPor: automovilista) ]! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:06:26 pm (UTC)'!
test15AlCamionAccidentadoElLimiteDeVelocidadTampocoLeProduceNada

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self atacarCon: self accidente a: automovilista.
	self atacarCon: self limiteDeVelocidad a: automovilista.
	
	self assert: (self estaAccidentado: automovilista).
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista).
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self 
		should: [ self jugarCartaDe: 25 * milla para: automovilista ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Automovilista accidentadoNoPuedeAvanzarDescripcionDeError equals: error messageText.
			self assert: 100 * milla equals: (self millasRecorridasPor: automovilista) ]! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:07:06 pm (UTC)'!
test16LosContraataquesSeSuman

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self accidente a: automovilista.
	self atacarCon: self accidente a: automovilista.
	
	self assert: 600 equals: (self puntosAcumuladosPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:08:35 pm (UTC)'!
test17DosAccidentesSeguidosLeHacenPerder200MillasAlDeportivo

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.
	self jugarCartaDe: 200 * milla para: automovilista.
	
	self atacarCon: self accidente a: automovilista.
	self atacarCon: self accidente a: automovilista.
	
	self assert: (self estaAccidentado: automovilista).
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista).
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista)! !


!MilMillasTest methodsFor: 'vehiculos' stamp: 'ARM 21/Sep/2026, 7:38:55 pm (UTC)'!
camion

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'vehiculos' stamp: 'ARM 21/Sep/2026, 7:39:21 pm (UTC)'!
deportivo

	self shouldBeImplemented! !


!MilMillasTest methodsFor: 'seguridades' stamp: 'ARM 21/Sep/2026, 7:40:33 pm (UTC)'!
asDelVolante

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'seguridades' stamp: 'ARM 21/Sep/2026, 7:42:12 pm (UTC)'!
viaLibre

	self shouldBeImplemented! !


!MilMillasTest methodsFor: 'creacion' stamp: 'ARM 22/Sep/2026, 4:09:05 pm (UTC)'!
nuevoAutomovilistaAlVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad 

	self shouldBeImplemented! !


!MilMillasTest methodsFor: 'ataques' stamp: 'ARM 21/Sep/2026, 7:44:04 pm (UTC)'!
accidente

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'ataques' stamp: 'ARM 21/Sep/2026, 7:44:47 pm (UTC)'!
limiteDeVelocidad

	self shouldBeImplemented! !


!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:46:53 pm (UTC)'!
estaAccidentado: unAutomovilista

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:48:54 pm (UTC)'!
millasRecorridasPor: unAutomovilista

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:49:48 pm (UTC)'!
puntosAcumuladosPor: unAutomovilista

	self shouldBeImplemented! !


!MilMillasTest methodsFor: 'acciones' stamp: 'ARM 21/Sep/2026, 7:50:42 pm (UTC)'!
atacarCon: unAtaque a: unAutomovilista

	self shouldBeImplemented! !

!MilMillasTest methodsFor: 'acciones' stamp: 'ARM 21/Sep/2026, 7:52:35 pm (UTC)'!
jugarCartaDe: unaCarta para: unAutomovilista

	self shouldBeImplemented! !
