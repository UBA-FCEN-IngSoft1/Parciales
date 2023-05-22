!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:50:11'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso.
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self 
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaSoft; darGolpeDeTaladro ]
		seEspera: CapaDeTierra ! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:50:27'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self 
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaSoft; darGolpeDeTaladro ]
		seEspera: CapaDeTierra ! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:56:59'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	|  sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable concretoConResistencia: 5.
			CapaDeSueloPeforable tierra.} .
	
	self assertSeDebeRomperMechaParar: sueloAExcavar poniendoMecha: [ :excavadora | excavadora ponerMechaSoft ]
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:50:46'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso.
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self 
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaWidia ; darGolpeDeTaladro ]
		seEspera: CapaDeTierra 
		! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:51:17'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self 
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaWidia ; darGolpeDeTaladro; darGolpeDeTaladro ]
		seEspera: CapaArenosa 
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:29:47'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable concretoConResistencia: 5.	
			CapaDeSueloPeforable tierra }.
	
	self 
		assertSeDebeRomperMechaParar: sueloAExcavar 
		poniendoMecha: [ :excavadora | excavadora ponerMechaWidia; darGolpeDeTaladro; darGolpeDeTaladro ]
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:23:29'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso.
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self 
		assertSeDebeRomperMechaParar: sueloAExcavar 
		poniendoMecha: [ :excavadora | excavadora ponerMechaDiamante ]
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:26:10'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable concretoConResistencia: 5 } .
	
	self
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaDiamante ; darGolpeDeTaladro ]
		seEspera: CapaDeConcreto
		conResistencia: 5! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:29:59'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable concretoConResistencia: 5.
			CapaDeSueloPeforable tierra } .
	
	self 
		assertPara: sueloAExcavar 
		haciendo: [ :excavadora | excavadora ponerMechaDiamante; darGolpeDeTaladro; darGolpeDeTaladro ]
		seEspera: CapaDeConcreto 
		conResistencia: 4! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:31:40'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso.
			CapaConPiedras de: 'Mica'.
			CapaConPiedras de: 'Marmol' } .
	
	excavadora := self darGolpeConMechaSoftA: sueloAExcavar.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:31:57'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso} .
	
	excavadora := self darGolpeConMechaSoftA: sueloAExcavar.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:41:34'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: excavadora noSePuedePerforarErrorDescription equals: unError messageText.
			self assert: CapaArenosa equals: excavadora capaDeSueloInmediata class ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:02:55'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { self sueloArenosoDeAltura2. self sueloDeTierraDeAltura40. CapaDeSueloPeforable arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:32:41'!
test14PuedeContarLasCapasDeTipoArenoso

	self assertCantidadDeCapasDe: CapaArenosa son: 2 
! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:32:41'!
test15PuedeContarLasCapasDeTipoTierra

	self assertCantidadDeCapasDe: CapaDeTierra son: 1! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:32:41'!
test16PuedeContarLasCapasDeTipoConcreto

	self assertCantidadDeCapasDe: CapaDeConcreto son: 1! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:33:23'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	self assertProfundidadHasta: CapaArenosa es: 0.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:33:23'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	self assertProfundidadHasta: CapaDeTierra es: 2
! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:33:23'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	self assertProfundidadHasta: CapaDeConcreto es: 42
! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 16:24:15'!
test20NoSePuedeDarGolpeConMechaRota

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable concretoConResistencia: 5.
			CapaDeSueloPeforable tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	excavadora ponerMechaRota.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: excavadora noSePuedeGolpearConMechaRotaErrorDescription equals: unError messageText.
			self assert: CapaDeConcreto equals: excavadora capaDeSueloInmediata class ].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/22/2023 19:33:40'!
test21NoHabarCapasDelMismoTipoSeguidas

	| sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSueloPeforable tierra.
			CapaDeSueloPeforable tierra.} .
	
	self should: [Perforadora sobreSuelo: sueloAExcavar ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: Perforadora noPuedenHaberCapasDelMismoTipoSeguidas equals: unError messageText ].
	! !


!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 19:32:41'!
assertCantidadDeCapasDe: unTipoDeCapa son: unaCantidad

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { 
		self sueloArenosoDeAltura2. 
		self sueloDeTierraDeAltura40. 
		CapaDeSueloPeforable arenoso. 
		CapaDeSueloPeforable concretoConResistencia: 10 }.
		
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: unaCantidad equals: (excavadora contarCapas: unTipoDeCapa).

	! !

!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 16:53:15'!
assertPara: sueloAExcavar haciendo: unBloqueDeExcavadora seEspera: tipoDeCapa

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	unBloqueDeExcavadora value: excavadora.
	
	self assert: tipoDeCapa equals: excavadora capaDeSueloInmediata class.
	^excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 19:28:05'!
assertPara: sueloAExcavar haciendo: unBloqueDeExcavadora seEspera: tipoDeCapa conResistencia: unaResistencia

	| capaInmediata |
	
	capaInmediata := self 
		assertPara: sueloAExcavar 
		haciendo: unBloqueDeExcavadora 
		seEspera: tipoDeCapa.
		
	self assert: unaResistencia equals: capaInmediata resistencia ! !

!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 19:33:23'!
assertProfundidadHasta: tipoDeCapa es: profundidadEsperada 

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { 
	self sueloArenosoDeAltura2.
	self sueloDeTierraDeAltura40. 
	CapaDeSueloPeforable arenoso. 
	CapaDeSueloPeforable concretoConResistencia: 10 }.
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: profundidadEsperada equals: (excavadora calcularProfundidadDelSueloHasta: tipoDeCapa)! !

!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 16:55:15'!
assertSeDebeRomperMechaParar: sueloAExcavar poniendoMecha: unBloque 

	| excavadora  |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	unBloque value: excavadora.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:unError |
			self assert: excavadora seRompioMechaErrorDescription equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'assertions' stamp: 'HAW 5/22/2023 19:31:13'!
darGolpeConMechaSoftA: sueloAExcavar

	| excavadora |
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft; darGolpeDeTaladro.
	
	^excavadora ! !


!TestDePerforación methodsFor: 'suelo' stamp: 'HAW 5/22/2023 16:24:08'!
sueloArenosoDeAltura2

	^ CapaArenosa conAlturaDe: 2! !

!TestDePerforación methodsFor: 'suelo' stamp: 'HAW 5/22/2023 16:24:20'!
sueloDeTierraDeAltura40

	^ CapaDeTierra conAlturaDe: 40! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'perforar' stamp: 'HAW 5/22/2023 16:03:49'!
aSerPerforadoPor: unaPerforadora

	self subclassResponsibility ! !


!classDefinition: #CapaConPiedras category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaConPiedras
	instanceVariableNames: 'piedras'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaConPiedras methodsFor: 'initialization' stamp: 'HAW 5/22/2023 15:57:28'!
initializeDe: unaPiedras 
	
	piedras := unaPiedras.! !


!CapaConPiedras methodsFor: 'piedras' stamp: 'HAW 5/22/2023 16:02:18'!
piedras
	
	^piedras! !


!CapaConPiedras methodsFor: 'perforar' stamp: 'HAW 5/22/2023 16:01:41'!
aSerPerforadoPor: unaPerforadora

	^unaPerforadora porPeforarCapaConPiedras! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaConPiedras class' category: 'ISW1-2023-1C-Parcial-1'!
CapaConPiedras class
	instanceVariableNames: ''!

!CapaConPiedras class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 15:57:21'!
de: unaPiedras 
	
	^self new initializeDe: unaPiedras ! !


!classDefinition: #CapaDeSueloPeforable category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo subclass: #CapaDeSueloPeforable
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSueloPeforable methodsFor: 'initialization' stamp: 'HAW 5/22/2023 15:00:12'!
initializeConAlturaDe: unaAltura 
	
	altura := unaAltura.! !


!CapaDeSueloPeforable methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:48:43'!
esArenoso
	^false! !

!CapaDeSueloPeforable methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:48:58'!
esConcreto
	^false! !

!CapaDeSueloPeforable methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:49:14'!
esTierra
	^false! !


!CapaDeSueloPeforable methodsFor: 'altura' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !


!CapaDeSueloPeforable methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:06:43'!
scan

	^self class scan ! !


!CapaDeSueloPeforable methodsFor: 'perforar' stamp: 'HAW 5/22/2023 15:59:31'!
aSerPerforadoPor: unaPerforadora 
	
	^unaPerforadora porPeforarCapaDeSuelo! !

!CapaDeSueloPeforable methodsFor: 'perforar' stamp: 'HAW 5/22/2023 16:29:34'!
darGolpeDesde: unaPerforadora con: unaMechaPuesta 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSueloPeforable class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPeforable class
	instanceVariableNames: ''!

!CapaDeSueloPeforable class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 16:24:08'!
arenoso

	^CapaArenosa conAlturaDe: 0! !

!CapaDeSueloPeforable class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 15:00:03'!
conAlturaDe: unaAltura 
	
	^self new initializeConAlturaDe: unaAltura ! !

!CapaDeSueloPeforable class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 16:24:15'!
concretoConResistencia: resistencia 

	^CapaDeConcreto conResistencia: resistencia ! !

!CapaDeSueloPeforable class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 16:24:20'!
tierra

	^CapaDeTierra conAlturaDe: 0! !


!CapaDeSueloPeforable class methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:06:52'!
scan

	self subclassResponsibility ! !


!classDefinition: #CapaArenosa category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPeforable subclass: #CapaArenosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaArenosa methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:48:51'!
esArenoso
	^true! !


!CapaArenosa methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:47:01'!
darGolpeDesde: unaPerforadora con: unaMechaPuesta 
	
	^unaMechaPuesta golpearSueloArenosoCon: unaPerforadora ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaArenosa class' category: 'ISW1-2023-1C-Parcial-1'!
CapaArenosa class
	instanceVariableNames: ''!

!CapaArenosa class methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:06:10'!
scan

	^ 7 ! !


!classDefinition: #CapaDeConcreto category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPeforable subclass: #CapaDeConcreto
	instanceVariableNames: 'resistencia'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeConcreto methodsFor: 'initialization' stamp: 'HAW 5/22/2023 14:57:10'!
initializeConResistencia: unaResistencia 
	
	resistencia := unaResistencia.! !


!CapaDeConcreto methodsFor: 'resistencia' stamp: 'HAW 5/22/2023 14:52:24'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeConcreto methodsFor: 'resistencia' stamp: 'HAW 5/22/2023 14:52:04'!
resistencia

	^ resistencia.! !

!CapaDeConcreto methodsFor: 'resistencia' stamp: 'HAW 5/22/2023 14:52:10'!
sinResistencia
	^resistencia = 0! !


!CapaDeConcreto methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:47:50'!
darGolpeDesde: unaPerforadora con: unaMechaPuesta 
	
	^unaMechaPuesta golpearSueloDeConcretoCon: unaPerforadora ! !


!CapaDeConcreto methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:49:04'!
esConcreto
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeConcreto class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeConcreto class
	instanceVariableNames: ''!

!CapaDeConcreto class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 15:00:41'!
conResistencia: unaResistencia 
	
	^(self conAlturaDe: 0) initializeConResistencia: unaResistencia ! !


!CapaDeConcreto class methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:06:17'!
scan

	^ 50. ! !


!classDefinition: #CapaDeTierra category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSueloPeforable subclass: #CapaDeTierra
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeTierra methodsFor: 'tipo' stamp: 'HAW 5/22/2023 14:49:18'!
esTierra
	^true! !


!CapaDeTierra methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:47:27'!
darGolpeDesde: unaPerforadora con: unaMechaPuesta 
	
	^unaMechaPuesta golpearSueloDeTierraCon: unaPerforadora ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeTierra class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeTierra class
	instanceVariableNames: ''!

!CapaDeTierra class methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:06:23'!
scan

	^ 10! !


!classDefinition: #Mecha category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Mecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Mecha methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:42:00'!
darGolpeCon: aPerforadora 
	
	self subclassResponsibility ! !


!classDefinition: #MechaFuncional category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaFuncional
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaFuncional methodsFor: 'perforar' stamp: 'HAW 5/22/2023 19:42:54'!
darGolpeCon: unaPerforadora 
	
	^unaPerforadora darGolpeConMechaFuncional! !

!MechaFuncional methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:42:14'!
golpearSueloArenosoCon: unaPerforadora 

	self subclassResponsibility ! !

!MechaFuncional methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:42:36'!
golpearSueloDeConcretoCon: unaPerforadora 

	self subclassResponsibility ! !

!MechaFuncional methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:42:45'!
golpearSueloDeTierraCon: unaPerforadora 

	self subclassResponsibility ! !


!classDefinition: #MechaDeDiamante category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaDeDiamante
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaDeDiamante methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:30:52'!
golpearSueloArenosoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloArenosoConMechaDeDiamante! !

!MechaDeDiamante methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:37:14'!
golpearSueloDeConcretoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeConcretoConMechaDeDiamante.
		! !

!MechaDeDiamante methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:34:02'!
golpearSueloDeTierraCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeTierraConMechaDeDiamante ! !


!classDefinition: #MechaDeWidia category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaDeWidia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaDeWidia methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:30:11'!
golpearSueloArenosoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloArenosoConMechaDeWidia! !

!MechaDeWidia methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:36:51'!
golpearSueloDeConcretoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeConcretoConMechaDeWidia.
	! !

!MechaDeWidia methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:33:43'!
golpearSueloDeTierraCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeTierraConMechaDeWidia.
			! !


!classDefinition: #MechaSoft category: 'ISW1-2023-1C-Parcial-1'!
MechaFuncional subclass: #MechaSoft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaSoft methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:29:51'!
golpearSueloArenosoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloArenosoConMechaSoft! !

!MechaSoft methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:36:27'!
golpearSueloDeConcretoCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeConcretoConMechaSoft ! !

!MechaSoft methodsFor: 'perforar' stamp: 'HAW 5/22/2023 14:33:20'!
golpearSueloDeTierraCon: unaPerforadora 
	
	^unaPerforadora golpearSueloDeTierraConMechaSoft ! !


!classDefinition: #MechaRota category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #MechaRota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!MechaRota methodsFor: 'perforar' stamp: 'HAW 5/22/2023 16:18:52'!
darGolpeCon: unaPerforadora 
	
	^unaPerforadora darGolpeConMechaRota
	! !


!classDefinition: #SinMecha category: 'ISW1-2023-1C-Parcial-1'!
Mecha subclass: #SinMecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!SinMecha methodsFor: 'perforar' stamp: 'HAW 5/22/2023 16:18:36'!
darGolpeCon: unaPerforadora 
	
	^unaPerforadora darGolpeSinMecha! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'accessing' stamp: 'HAW 5/22/2023 16:14:30'!
capaDeSueloInmediata
	^ capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !


!Perforadora methodsFor: 'cambiar capa' stamp: 'HAW 5/22/2023 16:22:37'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	self capaDeSueloInmediata aSerPerforadoPor: self.! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'HAW 5/22/2023 16:02:55'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSueloPeforable arenoso;
			yourself! !


!Perforadora methodsFor: 'excavación' stamp: 'HAW 5/22/2023 14:38:23'!
darGolpeDeTaladro
		
	^mechaPuesta darGolpeCon: self! !


!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 19:42:54'!
darGolpeConMechaFuncional
	
	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	^self capaDeSueloInmediata darGolpeDesde: self con: mechaPuesta 
	! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:19:24'!
darGolpeConMechaRota
	
	self error: self noSePuedeGolpearConMechaRotaErrorDescription! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:20:46'!
darGolpeSinMecha
	
	self error: self noSePuedePerforarErrorDescription! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:15:36'!
golpearSueloArenosoConMechaDeDiamante

	self seRompioMecha! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 14:26:23'!
golpearSueloArenosoConMechaDeWidia

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 14:26:07'!
golpearSueloArenosoConMechaSoft

	^ self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:21:22'!
golpearSueloDeConcretoConMechaDeDiamante

	vecesQueGolpeoCapaActual even ifTrue: [ self capaDeSueloInmediata bajaUnDecimoDeResistencia].
	self capaDeSueloInmediata sinResistencia ifTrue: [ self transformarCapaEnArenoso]! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:21:31'!
golpearSueloDeConcretoConMechaDeWidia

	vecesQueGolpeoCapaActual = 3 ifTrue: [ self seRompioMecha ]! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:15:36'!
golpearSueloDeConcretoConMechaSoft

	self seRompioMecha! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:21:37'!
golpearSueloDeTierraConMechaDeDiamante

	self pasarAProximaCapa! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:21:41'!
golpearSueloDeTierraConMechaDeWidia

	vecesQueGolpeoCapaActual = 2 ifTrue: [ self transformarCapaEnArenoso ]! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:21:45'!
golpearSueloDeTierraConMechaSoft

	! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:19:39'!
noSePuedeGolpearConMechaRotaErrorDescription
	
	^'No se puede golpear con mecha rota'! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:20:46'!
noSePuedePerforarErrorDescription

	^ 'No puede perforar'! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:02:11'!
porPeforarCapaConPiedras
	
	container addAll: (capasDeSueloDebajo collect: [ :unaCapaConPiedras |unaCapaConPiedras piedras ])! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 15:59:42'!
porPeforarCapaDeSuelo
	
	! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:22:13'!
seRompioMecha

	self ponerMechaRota.
	self error: self seRompioMechaErrorDescription! !

!Perforadora methodsFor: 'excavación - private' stamp: 'HAW 5/22/2023 16:22:13'!
seRompioMechaErrorDescription

	^ 'Se rompió'! !


!Perforadora methodsFor: 'initialization' stamp: 'HAW 5/22/2023 14:40:22'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := SinMecha new! !


!Perforadora methodsFor: 'mecha' stamp: 'HAW 5/22/2023 16:11:28'!
conMechaRota

	^mechaPuesta class = MechaRota ! !

!Perforadora methodsFor: 'mecha' stamp: 'HAW 5/22/2023 16:23:36'!
ponerMechaDiamante
	mechaPuesta := MechaDeDiamante new! !

!Perforadora methodsFor: 'mecha' stamp: 'HAW 5/22/2023 16:21:50'!
ponerMechaRota

	mechaPuesta := MechaRota new! !

!Perforadora methodsFor: 'mecha' stamp: 'HAW 5/22/2023 16:23:44'!
ponerMechaSoft
	mechaPuesta := MechaSoft new! !

!Perforadora methodsFor: 'mecha' stamp: 'HAW 5/22/2023 16:23:50'!
ponerMechaWidia
	mechaPuesta := MechaDeWidia new! !


!Perforadora methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:04:55'!
calcularProfundidadDelSuelo
	
	^capasDeSueloDebajo sum: [ :unaCapaDeSuelo | unaCapaDeSuelo altura ]! !

!Perforadora methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:08:47'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| tipoDeCapaScan |
	
	tipoDeCapaScan := tipoDeCapa scan.
	
	^capasDeSueloDebajo 
		inject: 0 
		into: [ :profundidad :capa |
			tipoDeCapaScan = capa scan ifTrue: [ ^ profundidad ].
			profundidad + capa altura ]! !

!Perforadora methodsFor: 'scan' stamp: 'HAW 5/22/2023 16:10:00'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| tipoDeCapaScan |
	
	tipoDeCapaScan := tipoDeCapa scan.
	
	^capasDeSueloDebajo count: [:unaCapaDeSuelo | unaCapaDeSuelo scan = tipoDeCapaScan ]! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'HAW 5/22/2023 16:23:07'!
sobreSueloArenoso
	^self capaDeSueloInmediata esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'HAW 5/22/2023 16:23:12'!
sobreSueloConcreto
	^self capaDeSueloInmediata esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'HAW 5/22/2023 16:23:16'!
sobreSueloTierra
	^self capaDeSueloInmediata esTierra! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 16:39:07'!
puede: capaDeAbajo estarSobre: capaDeArriba

	^ ((capaDeArriba isKindOf: CapaDeSueloPeforable) and: [ capaDeArriba class = capaDeAbajo class ]) not! !

!Perforadora class methodsFor: 'instance creation' stamp: 'HAW 5/22/2023 16:38:21'!
sobreSuelo: capasDeSueloAExcavar 

	self assertNoHayCapasPerforablesDelMismoTipoConsecutivas: capasDeSueloAExcavar.
		
	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !


!Perforadora class methodsFor: 'assertions' stamp: 'HAW 5/22/2023 16:39:14'!
assertNoHayCapasPerforablesDelMismoTipoConsecutivas: capasDeSueloAExcavar

	^ capasDeSueloAExcavar withNextDo: [ :capaDeArriba :capaDeAbajo | 
		(self puede: capaDeAbajo estarSobre: capaDeArriba) ifFalse: [ 
			self error: self noPuedenHaberCapasDelMismoTipoSeguidas ]]! !

!Perforadora class methodsFor: 'assertions' stamp: 'HAW 5/22/2023 16:37:20'!
noPuedenHaberCapasDelMismoTipoSeguidas
	
	^'No pueden haber capas perforables del mismo tipo seguidas'! !
