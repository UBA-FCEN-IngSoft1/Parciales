!classDefinition: #TestISWSmartBuilding category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
TestCase subclass: #TestISWSmartBuilding
	instanceVariableNames: 'diasLluviosos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:31:29'!
test01TiempoEnConstruirConCapacidadFijaEsAreaSobreCapacidad

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.
		
	self assert: 2 * day equals: (equipoDeTrabajo tiempoEnConstruir: self cincuentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 11:19:35'!
test02TiempoEnConstruirEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.
		
	self assert: 1 * day equals: (equipoDeTrabajo tiempoEnConstruir: 25000 * centimeter * centimeter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:31:29'!
test03CostoParaConstruirConPrecioFijoEsTiempoPorPrecio

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.
		
	self assert: 2000 * peso equals: (equipoDeTrabajo costoParaConstruir: self cincuentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test04TiempoEnConstruirConCapacidadVariableEnTiempoInicialUsaAreaInicial

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equipoSimpleDeCapacidadVariableYPrecioFijo.
		
	self assert: 10 * day equals: (equipoDeTrabajo tiempoEnConstruir: self venticincoM2 * 10)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:33:17'!
test05TiempoEnConstruirConCapacidadVariableEnTiempoRestanteSumaTiempoInicialMasTiempoPorCapacidadRestante

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equipoSimpleDeCapacidadVariableYPrecioFijo.
		
	self assert: 11 * day equals: (equipoDeTrabajo tiempoEnConstruir: self venticincoM2 * 10 + self veinteM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:33:02'!
test06TiempoEnConstruirConCapacidadVariableParaAreaInicialEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equipoSimpleDeCapacidadVariableYPrecioFijo.
		
	self assert: 1 * day equals: (equipoDeTrabajo tiempoEnConstruir: self veinteM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test07TiempoEnConstruirConCapacidadVariableParaAreaRestanteEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equipoSimpleDeCapacidadVariableYPrecioFijo.
		
	self assert: 11 * day equals: (equipoDeTrabajo tiempoEnConstruir: self venticincoM2 * 10 + (1 * meter * meter))! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test08LaCapacidadParaDiasRestantesDebeSerMenosALaCapacidadInicial

	self
		should: [  CapacidadVariable de: self venticincoM2 / day losPrimeros: 10 * day yElResto: self venticincoM2 / day ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CapacidadVariable capacidadRestanteDebeSerMenorACapacidadInicialErrorDescription
	! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test09CostoParaConstruirConPrecioVariableUsaPrecioNoLluviosoParaDiasNoLluviosos

	| equipoDeTrabajo |
	
	diasLluviosos := 0 * day.
	
	equipoDeTrabajo := self equipoSimpleConPrecioDependienteDeClima.
		
	self assert: 1000 * peso equals: (equipoDeTrabajo costoParaConstruir: self venticincoM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test10CostoParaConstruirConPrecioVariableUsaPrecioLluviosoParaDiasLluviosos

	| equipoDeTrabajo |
	
	diasLluviosos := 1 * day.
	
	equipoDeTrabajo := self equipoSimpleConPrecioDependienteDeClima.
		
	self assert: 1500 * peso equals: (equipoDeTrabajo costoParaConstruir: self venticincoM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test11CostoParaConstruirConPrecioVariableUsaPrecioLluviosoYNoLluviosoComoCorresponde

	| equipoDeTrabajo |
	
	diasLluviosos := 2 * day.
	
	equipoDeTrabajo := self equipoSimpleConPrecioDependienteDeClima.
		
	self assert: 1000 * peso * 3 + (1500 * peso * 2) equals: (equipoDeTrabajo costoParaConstruir: self venticincoM2 * 5)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:26'!
test12PrecioEnDiasLluviososEsMayorAPrecioEnDiasNoLluviosos

	 | precioUnico |
	
	precioUnico := 1500 * peso / day.
	
	self 
		should: [ PrecioDependienteDeClima enDiasNoLluviososDe: precioUnico yEnDiasLluviososDe: precioUnico usando: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PrecioDependienteDeClima precioDeDiaLluviosoDebeSerMayorAPrecioDeDiaNoLluviosoErrorDescription
	! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 12:20:39'!
test13NoSePuedeCrearEquipoCombinadoSinEquipos

	self 
		assertNoSePuedeCrearEquipoCombinado: [ EquipoCombinado de: {}] 
		con: EquipoCombinado debeHaberPorloMenosUnEquipoErrorDescription 
		! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 12:21:11'!
test14NoSePuedeCrearEquipoCombinadoConEquiposDirectosCompartidos

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.

	self 
		assertNoSePuedeCrearEquipoCombinado: [ EquipoCombinado de: {equipoDeTrabajo. equipoDeTrabajo }] 
		con: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 12:21:24'!
test15NoSePuedeConstruirEquipoCombinadoConEquiposIndirectorRepetidos

	| equipoDeTrabajo |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.

	self 
		assertNoSePuedeCrearEquipoCombinado: [ EquipoCombinado de: {equipoDeTrabajo. (EquipoCombinado de: { equipoDeTrabajo}) } ]
		con: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription 
! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:32:30'!
test16CostoParaConstruirDeEquipoCombinadoParaUnEquipoEsElCostoDeEseEquipo

	| equipoDeTrabajo equipoCombinado |
	
	equipoDeTrabajo := self equiposSimpleDeCapacidadYPrecioFijo.

	equipoCombinado := EquipoCombinado de: {equipoDeTrabajo }.
	
	self assert: 1000 * peso equals: (equipoCombinado costoParaConstruir: self venticincoM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test17CostoParaConstruirEsLaSumaDeLosCostosDeLosEquipos

	| equipoCombinado |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.
	
	self assert: 5000 * peso equals: (equipoCombinado costoParaConstruir: self cuarentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test18TiempoDeConstruccionEsElMaximo

	| equipoCombinado |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.
	
	self assert: 2 * day equals: (equipoCombinado tiempoEnConstruir: self cuarentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test19SePuedeConsultarElTiempoPorEquipo

	| equipoCombinado tiempoPorEquipo |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.
	
	tiempoPorEquipo := equipoCombinado tiempoEnConstruirPorEquipo: self cuarentaM2.
	
	self assert: 2 equals: tiempoPorEquipo size.
	self assert: 1 * day equals: (tiempoPorEquipo at: equipoCombinado primerEquipo).
	self assert: 2 * day equals: (tiempoPorEquipo at: equipoCombinado segundoEquipo)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test20SePuedeConsultarElCostoPorEquipo

	| equipoCombinado costoPorEquipo |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.

	costoPorEquipo := equipoCombinado costoParaConstruirPorEquipo: self cuarentaM2.
	
	self assert: 2 equals: costoPorEquipo size.
	self assert: 1000 * peso equals: (costoPorEquipo at: equipoCombinado primerEquipo).
	self assert: 4000 * peso equals: (costoPorEquipo at: equipoCombinado segundoEquipo)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test21EquipoMasRapidoEsElQueMenosTarda

	| equipoCombinado |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.
	
	self assert: equipoCombinado primerEquipo equals: (equipoCombinado masRapidoParaConstruir: self cuarentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:34:43'!
test22EquipoMasBaratoEsElQueMenosCobra

	| equipoCombinado |
	
	equipoCombinado := self equipoCombinadoDeEquipoAzulyRojo.
	
	self assert: equipoCombinado primerEquipo equals: (equipoCombinado masBaratoParaConstruir: self cuarentaM2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:31:29'!
test23ConEstadoDeAnimoMaloTardaElDoble

	| equiposSimple |
	
	equiposSimple := EquipoSimple
		construyendoCon: self capacidadFijaDe25m2PorDia
		a: self precioFijoDe1000PesosPorDia
		conEstadoDeAnimo: #Malo.
	
	self assert: 4 * day equals: (equiposSimple tiempoEnConstruir: self cincuentaM2) ! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:31:29'!
test24ConEstadoDeAnimoMuyBuenoTardaLaMitad

	| equiposSimple |
	
	equiposSimple := EquipoSimple
		construyendoCon: self capacidadFijaDe25m2PorDia
		a: self precioFijoDe1000PesosPorDia
		conEstadoDeAnimo: #MuyBueno.
	
	self assert: 1 * day equals: (equiposSimple tiempoEnConstruir: self cincuentaM2) ! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 12/6/2021 14:28:48'!
test25NoSePuedeCrearEquipoConEstadoDeAnimoInvalido

	self
		should: [ EquipoSimple
			construyendoCon: self capacidadFijaDe25m2PorDia
			a: self precioFijoDe1000PesosPorDia
			conEstadoDeAnimo: #MasOMenos ]
		raise: Error - MessageNotUnderstood 
		withMessageText: EquipoSimple estadoDeAnimoInvalidoErrorDescription
	! !


!TestISWSmartBuilding methodsFor: 'pronostico' stamp: 'HAW 11/25/2021 11:57:33'!
diasLluviososEn: unTiempo

	^diasLluviosos ! !


!TestISWSmartBuilding methodsFor: 'assertions' stamp: 'HAW 12/6/2021 12:20:31'!
assertNoSePuedeCrearEquipoCombinado: aCreationBlock con: unaDescripcionDeError 

	^ self
		should: aCreationBlock
		raise: Error - MessageNotUnderstood 
		withMessageText: unaDescripcionDeError! !


!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 14:30:09'!
capacidadFijaDe25m2PorDia

	^ CapacidadFija de: 250000 * centimeter * centimeter / day! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 11:27:15'!
equipoCombinadoDeEquipoAzulyRojo

	| equipoAzul equipoRojo |
	
	equipoAzul := self equiposSimpleDeCapacidadYPrecioFijo.
	equipoRojo := self equipoRojo.

	^EquipoCombinado de: {equipoAzul. equipoRojo }.
	! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 11:25:56'!
equipoRojo

	^ EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day )! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 14:32:30'!
equipoSimpleConPrecioDependienteDeClima

	^ EquipoSimple
		construyendoCon: (CapacidadFija de: self venticincoM2 / day)
		a: (PrecioDependienteDeClima enDiasNoLluviososDe: 1000 * peso / day yEnDiasLluviososDe: 1500 * peso / day usando: self)! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 14:33:02'!
equipoSimpleDeCapacidadVariableYPrecioFijo

	^ EquipoSimple
		construyendoCon: (CapacidadVariable de: self venticincoM2 / day losPrimeros: 10 * day yElResto: self veinteM2 / day)
		a: self precioFijoDe1000PesosPorDia! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 14:28:33'!
equiposSimpleDeCapacidadYPrecioFijo

	^ EquipoSimple
		construyendoCon: self capacidadFijaDe25m2PorDia
		a: self precioFijoDe1000PesosPorDia! !

!TestISWSmartBuilding methodsFor: 'equipos' stamp: 'HAW 12/6/2021 14:28:22'!
precioFijoDe1000PesosPorDia

	^ PrecioFijo de: 1000 * peso / day! !


!TestISWSmartBuilding methodsFor: 'areas' stamp: 'HAW 12/6/2021 14:31:29'!
cincuentaM2

	^ 250000 * centimeter * centimeter * 2! !

!TestISWSmartBuilding methodsFor: 'areas' stamp: 'HAW 12/6/2021 14:34:43'!
cuarentaM2

	^ 40 * meter * meter! !

!TestISWSmartBuilding methodsFor: 'areas' stamp: 'HAW 12/6/2021 14:33:02'!
veinteM2

	^ 20 * meter * meter! !

!TestISWSmartBuilding methodsFor: 'areas' stamp: 'HAW 12/6/2021 14:32:30'!
venticincoM2

	^ 25 * meter * meter! !


!classDefinition: #CapacidadDeConstruccion category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
Object subclass: #CapacidadDeConstruccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!CapacidadDeConstruccion methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 10:56:46'!
tiempoEnConstruir: unArea

	self subclassResponsibility ! !


!classDefinition: #CapacidadFija category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
CapacidadDeConstruccion subclass: #CapacidadFija
	instanceVariableNames: 'capacidadDeConstruccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!CapacidadFija methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:02:37'!
initializeDe: unaDimensionPorTiempo 
	
	capacidadDeConstruccion := unaDimensionPorTiempo.! !


!CapacidadFija methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 11:02:37'!
tiempoEnConstruir: unArea

	^unArea / capacidadDeConstruccion ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapacidadFija class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
CapacidadFija class
	instanceVariableNames: ''!

!CapacidadFija class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:01:07'!
de: unAreaPorTiempo 
	
	^self new initializeDe: unAreaPorTiempo ! !


!classDefinition: #CapacidadVariable category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
CapacidadDeConstruccion subclass: #CapacidadVariable
	instanceVariableNames: 'capacidadDeConstruccionInicial tiempoInicial capacidadDeConstruccionRestante'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!CapacidadVariable methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:03:28'!
initializeDe: unAreaPorTiempoInicial losPrimeros: unosDiasIniciales yElResto: unAreaPorTiempoRestante 
	
	capacidadDeConstruccionInicial := unAreaPorTiempoInicial.
	tiempoInicial := unosDiasIniciales.
	capacidadDeConstruccionRestante := unAreaPorTiempoRestante.! !


!CapacidadVariable methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 11:03:17'!
seConstruyeEnTiempoInicial: unArea

	^ unArea <= (capacidadDeConstruccionInicial * tiempoInicial)! !

!CapacidadVariable methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 11:03:28'!
tiempoDeConstruccionRestante: unArea

	^ (unArea - (capacidadDeConstruccionInicial * tiempoInicial ) / capacidadDeConstruccionRestante) ! !

!CapacidadVariable methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 11:03:17'!
tiempoEnConstruir: unArea

	^(self seConstruyeEnTiempoInicial: unArea) 
		ifTrue: [ unArea / capacidadDeConstruccionInicial ] 
		ifFalse: [ tiempoInicial + (self tiempoDeConstruccionRestante: unArea) ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapacidadVariable class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
CapacidadVariable class
	instanceVariableNames: ''!

!CapacidadVariable class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:50:05'!
de: unAreaPorTiempoInicial losPrimeros: unosDiasIniciales yElResto: unAreaPorTiempoRestante
	
	self assert: unAreaPorTiempoRestante esMenorA: unAreaPorTiempoInicial.
	
	^self new initializeDe: unAreaPorTiempoInicial losPrimeros: unosDiasIniciales yElResto: unAreaPorTiempoRestante! !


!CapacidadVariable class methodsFor: 'error description' stamp: 'HAW 11/25/2021 11:45:23'!
capacidadRestanteDebeSerMenorACapacidadInicialErrorDescription
	
	^'La capacidad restante debe ser menor a la capacidad inicial'! !


!CapacidadVariable class methodsFor: 'assertions' stamp: 'HAW 11/25/2021 11:49:48'!
assert: unAreaPorTiempoRestante esMenorA: unAreaPorTiempoInicial

	unAreaPorTiempoRestante < unAreaPorTiempoInicial ifFalse: [ self error: self capacidadRestanteDebeSerMenorACapacidadInicialErrorDescription ].
	! !


!classDefinition: #EquipoDeTrabajo category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
Object subclass: #EquipoDeTrabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!EquipoDeTrabajo methodsFor: 'equipos' stamp: 'HAW 11/23/2021 17:16:44'!
addEquiposTo: aCollector

	self subclassResponsibility ! !


!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:04:20'!
costoParaConstruir: unArea

	self subclassResponsibility ! !

!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:04:26'!
tiempoEnConstruir: unArea

	self subclassResponsibility ! !


!classDefinition: #EquipoCombinado category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
EquipoDeTrabajo subclass: #EquipoCombinado
	instanceVariableNames: 'equipos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!EquipoCombinado methodsFor: 'initialization' stamp: 'HAW 11/23/2021 16:50:55'!
initializeDe: unaColeccionDeEquipos 
	
	equipos := unaColeccionDeEquipos.! !


!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 11/23/2021 16:55:50'!
addEquiposTo: aCollector

	equipos do: [ :equipo | equipo addEquiposTo: aCollector ]! !

!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 11/25/2021 11:07:08'!
areaPorEquipoDe: unArea

	^ unArea / equipos size! !

!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 11/27/2021 15:39:32'!
masBaratoParaConstruir: unArea

	| areaPorEquipo |
	
	areaPorEquipo _ self areaPorEquipoDe: unArea.
	^equipos detectMin: [ :equipo | equipo costoParaConstruir: areaPorEquipo] ! !

!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 11/27/2021 15:39:47'!
masRapidoParaConstruir: unArea

	| areaPorEquipo |
	
	areaPorEquipo _ self areaPorEquipoDe: unArea.
	^equipos detectMin: [ :equipo | equipo tiempoEnConstruir: areaPorEquipo] ! !

!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 12/6/2021 11:30:10'!
primerEquipo
	
	^equipos first! !

!EquipoCombinado methodsFor: 'equipos' stamp: 'HAW 12/6/2021 11:30:32'!
segundoEquipo
	
	^equipos second! !


!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:05:05'!
caracteristica: aBlock paraConstruirPorEquipo: unArea

	| areaPorEquipo |
	
	areaPorEquipo := self areaPorEquipoDe: unArea.

	^equipos 
		inject: Dictionary new
		into: [ :tiempoPorEquipo :equipo |
			tiempoPorEquipo 
				at: equipo put: (aBlock value: equipo value: areaPorEquipo);
				yourself ].! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:05:24'!
costoParaConstruir: unArea

	| areaPorEquipo |
	
	areaPorEquipo := self areaPorEquipoDe: unArea.
	
	^equipos sum: [ :equipo | equipo costoParaConstruir: areaPorEquipo ]! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:05:43'!
costoParaConstruirPorEquipo: unArea

	^self caracteristica: [:equipo :areaPorEquipo | equipo costoParaConstruir: areaPorEquipo ] paraConstruirPorEquipo: unArea 
	! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:06:11'!
tiempoEnConstruir: unArea

	| areaPorEquipo |
	
	areaPorEquipo := self areaPorEquipoDe: unArea.
	
	^equipos max: [ :equipo | equipo tiempoEnConstruir: areaPorEquipo ]
! !

!EquipoCombinado methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:06:57'!
tiempoEnConstruirPorEquipo: unArea

	^self caracteristica: [:equipo :areaPorEquipo | equipo tiempoEnConstruir: areaPorEquipo ] paraConstruirPorEquipo: unArea 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EquipoCombinado class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
EquipoCombinado class
	instanceVariableNames: ''!

!EquipoCombinado class methodsFor: 'assertions' stamp: 'HAW 11/23/2021 16:53:16'!
assertIsNotEmpty: unaColeccionDeEquipos

	^ unaColeccionDeEquipos isEmpty ifTrue: [ self error: self debeHaberPorloMenosUnEquipoErrorDescription ]! !

!EquipoCombinado class methodsFor: 'assertions' stamp: 'HAW 11/23/2021 16:55:09'!
assertNoHayRepetidos: unaColeccionDeEquipos

	| equiposHoja |
	
	equiposHoja := unaColeccionDeEquipos 
		inject: OrderedCollection new
		into: [ :equipos :equipo | equipo addEquiposTo: equipos. equipos ].
		
	^ equiposHoja asSet size = equiposHoja size ifFalse: [ self error: self noPuedenHaberEquiposRepetidosErrorDescription ]! !


!EquipoCombinado class methodsFor: 'instance creation' stamp: 'HAW 11/23/2021 16:53:31'!
de: unaColeccionDeEquipos

	self assertIsNotEmpty: unaColeccionDeEquipos.
	self assertNoHayRepetidos: unaColeccionDeEquipos.
	
	^self new initializeDe: unaColeccionDeEquipos ! !


!EquipoCombinado class methodsFor: 'error descriptions' stamp: 'HAW 11/23/2021 16:45:57'!
debeHaberPorloMenosUnEquipoErrorDescription
	
	^'Debe haber por lo menos un equipo'! !

!EquipoCombinado class methodsFor: 'error descriptions' stamp: 'HAW 11/23/2021 16:47:49'!
noPuedenHaberEquiposRepetidosErrorDescription
	
	^'No pueden haber equipos repetidos'! !


!classDefinition: #EquipoSimple category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
EquipoDeTrabajo subclass: #EquipoSimple
	instanceVariableNames: 'precio capacidadDeConstruccion estadoDeAnimo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!EquipoSimple methodsFor: 'initialization' stamp: 'HAW 12/6/2021 12:29:33'!
initializeConstruyendoCon: unaCapacidadDeConstruccion a: unPrecio conEstadoDeAnimo: unEstadoDeAnimo 
	
	capacidadDeConstruccion := unaCapacidadDeConstruccion.
	precio := unPrecio.
	estadoDeAnimo := unEstadoDeAnimo.! !


!EquipoSimple methodsFor: 'equipos' stamp: 'HAW 11/23/2021 16:55:25'!
addEquiposTo: aCollector

	aCollector add: self
	
	! !


!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:10:47'!
costoParaConstruir: unArea

	^precio precioPara: (self tiempoEnConstruir: unArea) ! !

!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 12/6/2021 12:32:18'!
tiempoEnConstruir: unArea

	| tiempoOriginal |
	
	tiempoOriginal := (capacidadDeConstruccion tiempoEnConstruir: unArea) ceiling.
	
	estadoDeAnimo = #Malo ifTrue: [ ^tiempoOriginal * 2 ].
	estadoDeAnimo = #MuyBueno ifTrue: [ ^tiempoOriginal / 2 ].
	
	^tiempoOriginal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EquipoSimple class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
EquipoSimple class
	instanceVariableNames: ''!

!EquipoSimple class methodsFor: 'instance creation' stamp: 'HAW 12/6/2021 12:28:52'!
construyendoCon: unaCapacidadDeConstruccion a: unPrecio 
	
	^self construyendoCon: unaCapacidadDeConstruccion a: unPrecio conEstadoDeAnimo: #Normal! !

!EquipoSimple class methodsFor: 'instance creation' stamp: 'HAW 12/6/2021 12:38:10'!
construyendoCon: unaCapacidadDeConstruccion a: unPrecio conEstadoDeAnimo: unEstadoDeAnimo 
	
	self asssertEsEstadoDeAnimoValido: unEstadoDeAnimo.
	
	^self new initializeConstruyendoCon: unaCapacidadDeConstruccion a: unPrecio conEstadoDeAnimo: unEstadoDeAnimo ! !


!EquipoSimple class methodsFor: 'assertions' stamp: 'HAW 12/6/2021 12:38:10'!
asssertEsEstadoDeAnimoValido: unEstadoDeAnimo

	^ ({ #Normal. #MuyBueno. #Malo } includes: unEstadoDeAnimo) ifFalse: [ self error: self estadoDeAnimoInvalidoErrorDescription ]! !

!EquipoSimple class methodsFor: 'assertions' stamp: 'HAW 12/6/2021 12:36:18'!
estadoDeAnimoInvalidoErrorDescription
	
	^'Estado de ánimo inválido'! !


!classDefinition: #PrecioDeConstruccion category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
Object subclass: #PrecioDeConstruccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!PrecioDeConstruccion methodsFor: 'precios' stamp: 'HAW 11/23/2021 16:34:12'!
precioPara: unTiempo

	self subclassResponsibility ! !


!classDefinition: #PrecioDependienteDeClima category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
PrecioDeConstruccion subclass: #PrecioDependienteDeClima
	instanceVariableNames: 'precioParaDiasNoLluviosos precioParaDiasLluviosos servicioMeteorologico'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!PrecioDependienteDeClima methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:54:39'!
initializeEnDiasNoLluviososDe: unPrecioParaDiasNoLluviosos yEnDiasLluviososDe: unPrecioParaDiasLluviosos usando: unServicioMeteorologico 
	
	precioParaDiasNoLluviosos := unPrecioParaDiasNoLluviosos.
	precioParaDiasLluviosos := unPrecioParaDiasLluviosos.
	servicioMeteorologico := unServicioMeteorologico.! !


!PrecioDependienteDeClima methodsFor: 'precios' stamp: 'HAW 11/25/2021 11:59:42'!
precioPara: unTiempo 
	
	| diasLluviosos diasNoLluviosos |
	
	diasLluviosos := servicioMeteorologico diasLluviososEn: unTiempo.
	diasNoLluviosos := unTiempo - diasLluviosos.
	
	^precioParaDiasNoLluviosos * diasNoLluviosos + (precioParaDiasLluviosos * diasLluviosos)
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioDependienteDeClima class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
PrecioDependienteDeClima class
	instanceVariableNames: ''!

!PrecioDependienteDeClima class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 12:03:35'!
enDiasNoLluviososDe: unPrecioParaDiasNoLluviosos yEnDiasLluviososDe: unPrecioParaDiasLluviosos usando: unServicioMeteorologico 
	
	self assert: unPrecioParaDiasLluviosos esMayorA: unPrecioParaDiasNoLluviosos.
	
	^self new initializeEnDiasNoLluviososDe: unPrecioParaDiasNoLluviosos yEnDiasLluviososDe: unPrecioParaDiasLluviosos usando: unServicioMeteorologico ! !


!PrecioDependienteDeClima class methodsFor: 'error description' stamp: 'HAW 11/25/2021 12:03:08'!
precioDeDiaLluviosoDebeSerMayorAPrecioDeDiaNoLluviosoErrorDescription
	
	^'El precio de dia lluvioso debe ser mayor al del dia no lluvioso'! !


!PrecioDependienteDeClima class methodsFor: 'assertions' stamp: 'HAW 11/25/2021 12:04:05'!
assert: unPrecioParaDiasLluviosos esMayorA: unPrecioParaDiasNoLluviosos

	unPrecioParaDiasLluviosos > unPrecioParaDiasNoLluviosos ifFalse: [ self error: self precioDeDiaLluviosoDebeSerMayorAPrecioDeDiaNoLluviosoErrorDescription ]! !


!classDefinition: #PrecioFijo category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
PrecioDeConstruccion subclass: #PrecioFijo
	instanceVariableNames: 'precio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!PrecioFijo methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:13:44'!
initializeDe: unValorPorTiempo 
	
	precio := unValorPorTiempo.! !


!PrecioFijo methodsFor: 'precios' stamp: 'HAW 11/25/2021 11:13:44'!
precioPara: unTiempo

	^ precio * unTiempo ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioFijo class' category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
PrecioFijo class
	instanceVariableNames: ''!

!PrecioFijo class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:12:42'!
de: unValorPorTiempo 
	
	^self new initializeDe: unValorPorTiempo ! !


!classDefinition: #ServicioMeteorologico category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!
Object subclass: #ServicioMeteorologico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-1erParcial'!

!ServicioMeteorologico methodsFor: 'pronostico' stamp: 'HAW 11/25/2021 18:46:29'!
diasLluviososEn: unTiempo
! !
