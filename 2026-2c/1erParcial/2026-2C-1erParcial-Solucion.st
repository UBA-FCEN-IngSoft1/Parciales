!classDefinition: #Ataque category: #'2026-2C-1erParcial-Solucion'!
Object subclass: #Ataque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Ataque methodsFor: 'atacando' stamp: 'ARM 22/Sep/2026, 4:47:12 pm (UTC)'!
atacarA: unAutomovilista protegidoPor: unaCartaDeSeguridad

	self subclassResponsibility! !


!classDefinition: #Accidente category: #'2026-2C-1erParcial-Solucion'!
Ataque subclass: #Accidente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Accidente methodsFor: 'atacando' stamp: 'ARM 22/Sep/2026, 4:49:08 pm (UTC)'!
atacarA: unAutomovilista protegidoPor: unaCartaDeSeguridad

	unaCartaDeSeguridad defenderDeAccidenteA: unAutomovilista! !


!classDefinition: #LimiteDeVelocidad category: #'2026-2C-1erParcial-Solucion'!
Ataque subclass: #LimiteDeVelocidad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!LimiteDeVelocidad methodsFor: 'atacando' stamp: 'ARM 22/Sep/2026, 4:50:13 pm (UTC)'!
atacarA: unAutomovilista protegidoPor: unaCartaDeSeguridad

	unaCartaDeSeguridad defenderDeLimiteDeVelocidadA: unAutomovilista! !


!classDefinition: #Automovilista category: #'2026-2C-1erParcial-Solucion'!
Object subclass: #Automovilista
	instanceVariableNames: 'vehiculo cartaDeSeguridad estado millasRecorridas puntos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Automovilista methodsFor: 'initialization' stamp: 'NR 12/Oct/2026, 9:43:09 am (UTC)'!
initializeAlVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad

	vehiculo := unVehiculo.
	cartaDeSeguridad := unaCartaDeSeguridad.
	estado := EnCondicionesNormales de: self.
	millasRecorridas := 0 * milla.
	puntos := 0! !


!Automovilista methodsFor: 'consultas' stamp: 'ARM 22/Sep/2026, 2:37:39 pm (UTC)'!
estaAccidentado

	^ estado estaAccidentado! !

!Automovilista methodsFor: 'consultas' stamp: 'ARM 22/Sep/2026, 2:34:20 pm (UTC)'!
millasRecorridas

	^ millasRecorridas! !

!Automovilista methodsFor: 'consultas' stamp: 'ARM 22/Sep/2026, 2:36:24 pm (UTC)'!
puntos

	^ puntos! !


!Automovilista methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:32:02 am (UTC)'!
avanzarAccidentado: unasMillas

	self error: self class accidentadoNoPuedeAvanzarDescripcionDeError! !

!Automovilista methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:44:05 am (UTC)'!
avanzarBajoLimiteDeVelocidad: unasMillasBajoLimiteDeVelocidad

	self recorrer: unasMillasBajoLimiteDeVelocidad ! !

!Automovilista methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:46:18 am (UTC)'!
avanzarEnCondicionesNormales: unasMillasEfectivas

	self recorrer: unasMillasEfectivas

	! !


!Automovilista methodsFor: 'jugando' stamp: 'NR 12/Oct/2026, 9:27:12 am (UTC)'!
jugarCartaDe: unaCartaDeMillas

	self assertCartaValida: unaCartaDeMillas.
	estado avanzar: (vehiculo millasEfectivasPara: unaCartaDeMillas)! !

!Automovilista methodsFor: 'jugando' stamp: 'ARM 22/Sep/2026, 4:41:43 pm (UTC)'!
recibirAtaque: unAtaque

	unAtaque atacarA: self protegidoPor: cartaDeSeguridad! !

!Automovilista methodsFor: 'jugando' stamp: 'NR 12/Oct/2026, 9:16:52 am (UTC)'!
recorrer: unasMillas

	millasRecorridas := 0 max: millasRecorridas  + unasMillas 	! !


!Automovilista methodsFor: 'sufriendo ataques' stamp: 'NR 12/Oct/2026, 9:41:03 am (UTC)'!
accidentarse

	estado := Accidentado de: self! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'NR 12/Oct/2026, 9:57:31 am (UTC)'!
accidentarseRetrocediendo: unasMillas
	
	self retroceder: unasMillas.
	self accidentarse! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 2:50:32 pm (UTC)'!
anularLimiteDeVelocidad

	vehiculo anularLimiteDeVelocidadA: self! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 2:44:18 pm (UTC)'!
contraatacar

	puntos := puntos + 300! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'NR 12/Oct/2026, 9:41:17 am (UTC)'!
limitarVelocidadA: unTopeDeMillasARecorrerPorCartaDeDistancia

	estado := BajoLimiteDeVelocidad de: self conTope: unTopeDeMillasARecorrerPorCartaDeDistancia! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'NR 12/Oct/2026, 9:09:58 am (UTC)'!
retroceder: unasMillas

	^ self recorrer: unasMillas negated! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 2:46:35 pm (UTC)'!
sufrirAccidente

	vehiculo accidentarA: self! !

!Automovilista methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 2:48:39 pm (UTC)'!
sufrirLimiteDeVelocidad

	vehiculo limitarVelocidadA: self! !


!Automovilista methodsFor: 'assertions' stamp: 'NR 12/Oct/2026, 8:56:43 am (UTC)'!
assertCartaValida: unaCartaDeMillas

	(self class cartasDeDistancia includes: unaCartaDeMillas) 
		ifFalse: [ self error: self class cartaDeDistanciaInvalidaDescripcionDeError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Automovilista class' category: #'2026-2C-1erParcial-Solucion'!
Automovilista class
	instanceVariableNames: ''!

!Automovilista class methodsFor: 'instance creation' stamp: 'ARM 22/Sep/2026, 4:42:16 pm (UTC)'!
alVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad

	^ self new initializeAlVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad! !


!Automovilista class methodsFor: 'cartas' stamp: 'ARM 22/Sep/2026, 3:01:05 pm (UTC)'!
cartasDeDistancia

	^ { 25 * milla. 50 * milla. 75 * milla. 100 * milla. 200 * milla }! !


!Automovilista class methodsFor: 'descripciones de error' stamp: 'ARM 22/Sep/2026, 3:03:35 pm (UTC)'!
accidentadoNoPuedeAvanzarDescripcionDeError

	^ 'Un automovilista accidentado no puede avanzar'! !

!Automovilista class methodsFor: 'descripciones de error' stamp: 'ARM 22/Sep/2026, 3:04:36 pm (UTC)'!
cartaDeDistanciaInvalidaDescripcionDeError

	^ 'Las cartas de distancia son de 25, 50, 75, 100 o 200 millas'! !


!classDefinition: #CartaDeSeguridad category: #'2026-2C-1erParcial-Solucion'!
Object subclass: #CartaDeSeguridad
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!CartaDeSeguridad methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 4:43:17 pm (UTC)'!
defenderDeAccidenteA: unAutomovilista

	self subclassResponsibility! !

!CartaDeSeguridad methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 4:45:30 pm (UTC)'!
defenderDeLimiteDeVelocidadA: unAutomovilista

	self subclassResponsibility! !


!classDefinition: #AsDelVolante category: #'2026-2C-1erParcial-Solucion'!
CartaDeSeguridad subclass: #AsDelVolante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!AsDelVolante methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 3:37:24 pm (UTC)'!
defenderDeAccidenteA: unAutomovilista

	unAutomovilista contraatacar! !

!AsDelVolante methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 3:38:43 pm (UTC)'!
defenderDeLimiteDeVelocidadA: unAutomovilista

	unAutomovilista sufrirLimiteDeVelocidad! !


!classDefinition: #ViaLibre category: #'2026-2C-1erParcial-Solucion'!
CartaDeSeguridad subclass: #ViaLibre
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!ViaLibre methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 3:39:33 pm (UTC)'!
defenderDeAccidenteA: unAutomovilista

	unAutomovilista sufrirAccidente! !

!ViaLibre methodsFor: 'defendiendo' stamp: 'ARM 22/Sep/2026, 3:41:40 pm (UTC)'!
defenderDeLimiteDeVelocidadA: unAutomovilista

	unAutomovilista anularLimiteDeVelocidad! !


!classDefinition: #EstadoAutomovilista category: #'2026-2C-1erParcial-Solucion'!
Object subclass: #EstadoAutomovilista
	instanceVariableNames: 'automovilista'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!EstadoAutomovilista methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:26:06 am (UTC)'!
avanzar: unasMillas

	self subclassResponsibility! !


!EstadoAutomovilista methodsFor: 'consultas' stamp: 'ARM 22/Sep/2026, 3:07:05 pm (UTC)'!
estaAccidentado

	^ false! !


!EstadoAutomovilista methodsFor: 'initialization' stamp: 'NR 12/Oct/2026, 9:30:46 am (UTC)'!
initializeWith: unAutomovilista

	automovilista := unAutomovilista ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoAutomovilista class' category: #'2026-2C-1erParcial-Solucion'!
EstadoAutomovilista class
	instanceVariableNames: ''!

!EstadoAutomovilista class methodsFor: 'instance creation' stamp: 'NR 12/Oct/2026, 9:29:16 am (UTC)'!
de: unAutomovilista

	^ self new initializeWith: unAutomovilista! !


!classDefinition: #Accidentado category: #'2026-2C-1erParcial-Solucion'!
EstadoAutomovilista subclass: #Accidentado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Accidentado methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:31:14 am (UTC)'!
avanzar: unasMillas

	automovilista avanzarAccidentado: unasMillas! !


!Accidentado methodsFor: 'consultas' stamp: 'ARM 22/Sep/2026, 3:16:12 pm (UTC)'!
estaAccidentado

	^ true! !


!classDefinition: #BajoLimiteDeVelocidad category: #'2026-2C-1erParcial-Solucion'!
EstadoAutomovilista subclass: #BajoLimiteDeVelocidad
	instanceVariableNames: 'topeDeMillas'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!BajoLimiteDeVelocidad methodsFor: 'initialization' stamp: 'NR 12/Oct/2026, 9:37:35 am (UTC)'!
initializeWith: unAutomovilista conTope: unTopeDeMillas

	super initializeWith: unAutomovilista.
	topeDeMillas := unTopeDeMillas! !


!BajoLimiteDeVelocidad methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:35:17 am (UTC)'!
avanzar: unasMillas

	automovilista avanzarBajoLimiteDeVelocidad: (unasMillas min: topeDeMillas)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BajoLimiteDeVelocidad class' category: #'2026-2C-1erParcial-Solucion'!
BajoLimiteDeVelocidad class
	instanceVariableNames: ''!

!BajoLimiteDeVelocidad class methodsFor: 'instance creation' stamp: 'NR 12/Oct/2026, 9:48:38 am (UTC)'!
de: unAutomovilista conTope: unTopeDeMillas

	^ self new initializeWith: unAutomovilista conTope: unTopeDeMillas! !


!classDefinition: #EnCondicionesNormales category: #'2026-2C-1erParcial-Solucion'!
EstadoAutomovilista subclass: #EnCondicionesNormales
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!EnCondicionesNormales methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:43:19 am (UTC)'!
avanzar: unasMillas

	automovilista avanzarEnCondicionesNormales: unasMillas! !


!classDefinition: #Vehiculo category: #'2026-2C-1erParcial-Solucion'!
Object subclass: #Vehiculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Vehiculo methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:18:56 am (UTC)'!
millasEfectivasPara: unaCartaDeMillas

	self subclassResponsibility! !


!Vehiculo methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:18:31 pm (UTC)'!
accidentarA: unAutomovilista

	self subclassResponsibility! !

!Vehiculo methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:20:53 pm (UTC)'!
anularLimiteDeVelocidadA: unAutomovilista

	self subclassResponsibility! !

!Vehiculo methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:20:10 pm (UTC)'!
limitarVelocidadA: unAutomovilista

	self subclassResponsibility! !


!classDefinition: #Camion category: #'2026-2C-1erParcial-Solucion'!
Vehiculo subclass: #Camion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Camion methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:19:06 am (UTC)'!
millasEfectivasPara: unaCartaDeMillas

	^ unaCartaDeMillas min: 100 * milla! !


!Camion methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:28:30 pm (UTC)'!
accidentarA: unAutomovilista

	unAutomovilista accidentarse! !

!Camion methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:30:28 pm (UTC)'!
anularLimiteDeVelocidadA: unAutomovilista

! !

!Camion methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:29:35 pm (UTC)'!
limitarVelocidadA: unAutomovilista

! !


!classDefinition: #Deportivo category: #'2026-2C-1erParcial-Solucion'!
Vehiculo subclass: #Deportivo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!Deportivo methodsFor: 'avanzando' stamp: 'NR 12/Oct/2026, 9:19:24 am (UTC)'!
millasEfectivasPara: unaCartaDeMillas

	^ unaCartaDeMillas * 2! !


!Deportivo methodsFor: 'sufriendo ataques' stamp: 'NR 12/Oct/2026, 9:57:31 am (UTC)'!
accidentarA: unAutomovilista

	unAutomovilista accidentarseRetrocediendo: 100 * milla! !

!Deportivo methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:26:11 pm (UTC)'!
anularLimiteDeVelocidadA: unAutomovilista

	unAutomovilista contraatacar! !

!Deportivo methodsFor: 'sufriendo ataques' stamp: 'ARM 22/Sep/2026, 3:24:08 pm (UTC)'!
limitarVelocidadA: unAutomovilista

	unAutomovilista limitarVelocidadA: 25 * milla! !


!classDefinition: #MilMillasTest category: #'2026-2C-1erParcial-Solucion'!
TestCase subclass: #MilMillasTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-1erParcial-Solucion'!

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:10:41 pm (UTC)'!
test01ElDeportivoAvanzaElDobleDeLaCarta

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.

	self assert: 0 * milla equals: (self millasRecorridasPor: automovilista).
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:13:10 pm (UTC)'!
test02AlCamionNingunaCartaLeValeMasDe100

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.

	self jugarCartaDe: 200 * milla para: automovilista.

	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista).
	
	self jugarCartaDe: 50 * milla para: automovilista.
	self assert: 150 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:14:11 pm (UTC)'!
test03SoloExistenCartasDe25De50De75De100YDe200

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self 
		should: [ self jugarCartaDe: 30 * milla para: automovilista ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :error |
			self assert: Automovilista cartaDeDistanciaInvalidaDescripcionDeError equals: error messageText.
			self assert: 0 * milla equals: (self millasRecorridasPor: automovilista) ]! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:14:44 pm (UTC)'!
test04ElAsDelVolanteAnulaElAccidente

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self accidente a: automovilista.
	
	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:15:23 pm (UTC)'!
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

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:16:13 pm (UTC)'!
test06ElDeportivoAccidentadoNoQuedaConMillasNegativas

	| automovilista |

	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.

	self jugarCartaDe: 25 * milla para: automovilista.

	self atacarCon: self accidente a: automovilista.
	
	self assert: 0 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:18:39 pm (UTC)'!
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

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:20:56 pm (UTC)'!
test08ElAsDelVolanteTambienSirveEnElCamion

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self asDelVolante.

	self atacarCon: self accidente a: automovilista.

	self jugarCartaDe: 200 * milla para: automovilista.

	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:23:10 pm (UTC)'!
test09LaViaLibreAnulaElLimiteDeVelocidad

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self viaLibre.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	
	self jugarCartaDe: 100 * milla para: automovilista.
	
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:24:56 pm (UTC)'!
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

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:26:33 pm (UTC)'!
test11AlCamionElLimiteDeVelocidadNoLeCambiaNada

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self asDelVolante.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 200 * milla para: automovilista.
	self jugarCartaDe: 100 * milla para: automovilista.

	self assert: 200 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:29:00 pm (UTC)'!
test12EnElCamionLaViaLibreNoTieneNadaQueAnular

	| automovilista |
	
	"Como el límite no le cambia nada al camión, tampoco hay contraataque"
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self camion conCartaDeSeguridad: self viaLibre.

	self atacarCon: self limiteDeVelocidad a: automovilista.
	self assert: 0 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 200 * milla para: automovilista.
	self assert: 100 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:30:21 pm (UTC)'!
test13LimiteYDespuesAccidente

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self limiteDeVelocidad a: automovilista.
	self atacarCon: self accidente a: automovilista.
	
	self deny: (self estaAccidentado: automovilista).
	self assert: 300 equals: (self puntosAcumuladosPor: automovilista).
	
	self jugarCartaDe: 100 * milla para: automovilista.
	self assert: 25 * milla equals: (self millasRecorridasPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:32:37 pm (UTC)'!
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

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:34:30 pm (UTC)'!
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

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:35:44 pm (UTC)'!
test16LosContraataquesSeSuman

	| automovilista |
	
	automovilista := self nuevoAutomovilistaAlVolanteDe: self deportivo conCartaDeSeguridad: self asDelVolante.
	
	self atacarCon: self accidente a: automovilista.
	self atacarCon: self accidente a: automovilista.
	
	self assert: 600 equals: (self puntosAcumuladosPor: automovilista)! !

!MilMillasTest methodsFor: 'tests' stamp: 'ARM 22/Sep/2026, 4:37:22 pm (UTC)'!
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

	^ Camion new! !

!MilMillasTest methodsFor: 'vehiculos' stamp: 'ARM 21/Sep/2026, 7:39:21 pm (UTC)'!
deportivo

	^ Deportivo new! !


!MilMillasTest methodsFor: 'seguridades' stamp: 'ARM 21/Sep/2026, 7:40:33 pm (UTC)'!
asDelVolante

	^ AsDelVolante new! !

!MilMillasTest methodsFor: 'seguridades' stamp: 'ARM 21/Sep/2026, 7:42:12 pm (UTC)'!
viaLibre

	^ ViaLibre new! !


!MilMillasTest methodsFor: 'creacion' stamp: 'ARM 22/Sep/2026, 4:39:44 pm (UTC)'!
nuevoAutomovilistaAlVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad 

	^ Automovilista alVolanteDe: unVehiculo conCartaDeSeguridad: unaCartaDeSeguridad! !


!MilMillasTest methodsFor: 'ataques' stamp: 'ARM 21/Sep/2026, 7:44:04 pm (UTC)'!
accidente

	^ Accidente new! !

!MilMillasTest methodsFor: 'ataques' stamp: 'ARM 21/Sep/2026, 7:44:47 pm (UTC)'!
limiteDeVelocidad

	^ LimiteDeVelocidad new! !


!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:46:53 pm (UTC)'!
estaAccidentado: unAutomovilista

	^ unAutomovilista estaAccidentado! !

!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:48:54 pm (UTC)'!
millasRecorridasPor: unAutomovilista

	^ unAutomovilista millasRecorridas! !

!MilMillasTest methodsFor: 'consultas' stamp: 'ARM 21/Sep/2026, 7:49:48 pm (UTC)'!
puntosAcumuladosPor: unAutomovilista

	^ unAutomovilista puntos! !


!MilMillasTest methodsFor: 'acciones' stamp: 'ARM 21/Sep/2026, 7:50:42 pm (UTC)'!
atacarCon: unAtaque a: unAutomovilista

	unAutomovilista recibirAtaque: unAtaque! !

!MilMillasTest methodsFor: 'acciones' stamp: 'ARM 21/Sep/2026, 7:52:35 pm (UTC)'!
jugarCartaDe: unaCarta para: unAutomovilista

	unAutomovilista jugarCartaDe: unaCarta! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MilMillasTest class' category: #'2026-2C-1erParcial-Solucion'!
MilMillasTest class
	instanceVariableNames: ''!

!MilMillasTest class methodsFor: 'class initialization' stamp: 'ARM 22/Sep/2026, 2:07:26 pm (UTC)'!
initialize

	Smalltalk at: #milla put: (BaseUnit named: 'milla')! !

MilMillasTest initialize!(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 54 74 124 112 122 80 116 104 110 108 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 54 74 124 112 122 80 116 104 110 108 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 62 53 64 52 63 56 61 55 53 112 116 104 110 108 17 84 104 106 39 86 90 17 56 59 55 59 53 55 17 104 104 121 106 111 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 100 39 62 53 57 55 57 61 55 62 57 64 53 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 17 72 120 124 104 17 84 104 106 39 86 90 39 95 39 105 124 112 115 123 39 118 117 39 72 124 110 39 56 63 39 57 55 57 61 39 56 60 65 59 59 65 55 63 39 52 55 58 39 74 118 116 119 112 115 108 121 65 39 72 119 119 115 108 39 83 83 93 84 39 57 56 53 55 53 55 39 47 106 115 104 117 110 52 57 56 55 55 53 56 53 56 53 56 55 56 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 79 72 94 53 58 62 63 55 39 124 124 112 107 65 39 106 57 62 108 59 59 64 104 52 64 107 104 55 52 59 57 60 107 52 63 108 61 64 52 63 56 108 62 107 59 104 59 55 106 109 63 39 72 124 110 39 56 63 39 57 55 57 61 17 93 84 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 111 108 121 117 104 117 71 84 59 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 52 108 119 111 108 116 108 121 118 117 122 39 75 104 123 108 65 39 94 108 107 39 81 124 115 39 57 64 39 56 56 65 56 56 65 58 56 39 57 55 57 61 39 74 118 116 116 112 123 79 104 122 111 65 39 61 64 55 108 106 105 57 61 58 39 87 115 124 110 112 117 122 65 39 57 55 57 61 55 62 57 64 56 59 56 56 52 115 112 125 108 123 128 119 112 117 110 52 105 124 112 115 107 52 119 121 118 106 108 122 122 39 111 108 121 117 104 117 71 84 59 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 52 108 119 111 108 116 108 121 118 117 122 17 199 175 7 115 17 56 64 57 53 56 61 63 53 55 53 56 55 63 17 56 64 57 53 56 61 63 53 55 53 56 55 63 17 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 85 112 106 118 115 104 122 53 115 118 106 104 115 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 55 56 65 60 60 65 55 64 53 61 63 64 55 60 59 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 74 124 112 122 76 127 104 116 53 122 123 17 59 59 64 63 63 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 60 91 55 58 65 56 63 65 60 64 53 63 57 56 58 62 57 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 74 124 112 122 76 127 104 116 53 122 123 17 59 60 57 58 60 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 62 91 56 62 65 59 59 65 58 62 53 61 62 57 64 56 61 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 74 124 112 122 76 127 104 116 53 122 123 17 61 56 57 62 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 62 91 56 62 65 60 63 65 55 56 53 56 63 56 59 60 60 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 74 124 112 122 76 127 104 116 53 122 123 17 61 56 56 61 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 55 64 52 56 62 91 57 56 65 55 61 65 56 63 53 58 55 63 56 64 64 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 74 124 112 122 76 127 104 116 53 122 123 17 61 56 56 64 57 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 56 55 52 56 57 91 55 61 65 59 56 65 58 63 53 58 61 55 56 63 58 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 61 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 90 118 115 124 106 112 118 117 53 122 123 17 57 60 64 56 61 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 61 52 56 55 52 56 57 91 55 62 65 55 55 65 60 59 53 60 58 64 56 56 60 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 74 124 112 122 52 90 116 104 115 115 123 104 115 114 52 75 108 125 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 61 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 90 118 115 124 106 112 118 117 53 122 123 17 57 61 57 55 55 17 52 52 52 52 52 52 52 52 52 52 17 17))!