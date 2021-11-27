!classDefinition: #TestISWSmartBuilding category: 'ISW1-2021-2C-2doParcial'!
TestCase subclass: #TestISWSmartBuilding
	instanceVariableNames: 'diasLluviosos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test01TiempoEnConstruirConCapacidadFijaEsAreaSobreCapacidad

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 250000 * centimeter * centimeter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 2 * day equals: (equipoDeTrabajo tiempoEnConstruir: 250000 * centimeter * centimeter * 2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test02TiempoEnConstruirEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 250000 * centimeter * centimeter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 1 * day equals: (equipoDeTrabajo tiempoEnConstruir: 25000 * centimeter * centimeter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test03CostoParaConstruirConPrecioFijoEsTiempoPorPrecio

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 250000 * centimeter * centimeter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 2000 * peso equals: (equipoDeTrabajo costoParaConstruir: 250000 * centimeter * centimeter * 2)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test04TiempoEnConstruirConCapacidadVariableEnTiempoInicialUsaAreaInicial

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadVariable de: 25 * meter * meter / day losPrimeros: 10 * day yElResto: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 10 * day equals: (equipoDeTrabajo tiempoEnConstruir: 25 * meter * meter * 10)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test05TiempoEnConstruirConCapacidadVariableEnTiempoRestanteSumaTiempoInicialMasTiempoPorCapacidadRestante

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadVariable de: 25 * meter * meter / day losPrimeros: 10 * day yElResto: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 11 * day equals: (equipoDeTrabajo tiempoEnConstruir: 25 * meter * meter * 10 + (20 * meter * meter))! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test06TiempoEnConstruirConCapacidadVariableParaAreaInicialEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadVariable de: 25 * meter * meter / day losPrimeros: 10 * day yElResto: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 1 * day equals: (equipoDeTrabajo tiempoEnConstruir: 20 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test07TiempoEnConstruirConCapacidadVariableParaAreaRestanteEstaExpresadoEnDiasEnteros

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadVariable de: 25 * meter * meter / day losPrimeros: 10 * day yElResto: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day).
		
	self assert: 11 * day equals: (equipoDeTrabajo tiempoEnConstruir: 25 * meter * meter * 10 + (1 * meter * meter))! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/25/2021 12:04:18'!
test08LaCapacidadParaDiasRestantesDebeSerMenosALaCapacidadInicial

	self
		should: [  CapacidadVariable de: 25 * meter * meter / day losPrimeros: 10 * day yElResto: 25 * meter * meter / day ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CapacidadVariable capacidadRestanteDebeSerMenorACapacidadInicialErrorDescription
	! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test09CostoParaConstruirConPrecioVariableUsaPrecioNoLluviosoParaDiasNoLluviosos

	| equipoDeTrabajo |
	
	diasLluviosos := 0 * day.
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / day)
		a: (PrecioDependienteDeClima enDiasNoLluviososDe: 1000 * peso / day yEnDiasLluviososDe: 1500 * peso / day usando: self).
		
	self assert: 1000 * peso equals: (equipoDeTrabajo costoParaConstruir: 25 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test10CostoParaConstruirConPrecioVariableUsaPrecioLluviosoParaDiasLluviosos

	| equipoDeTrabajo |
	
	diasLluviosos := 1 * day.
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / day)
		a: (PrecioDependienteDeClima enDiasNoLluviososDe: 1000 * peso / day yEnDiasLluviososDe: 1500 * peso / day usando: self).
		
	self assert: 1500 * peso equals: (equipoDeTrabajo costoParaConstruir: 25 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test11CostoParaConstruirConPrecioVariableUsaPrecioLluviosoYNoLluviosoComoCorresponde

	| equipoDeTrabajo |
	
	diasLluviosos := 2 * day.
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / day)
		a: (PrecioDependienteDeClima enDiasNoLluviososDe: 1000 * peso / day yEnDiasLluviososDe: 1500 * peso / day usando: self).
		
	self assert: 1000 * peso * 3 + (1500 * peso * 2) equals: (equipoDeTrabajo costoParaConstruir: 25 * meter * meter * 5)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/25/2021 12:02:44'!
test12PrecioEnDiasLluviososEsMayorAPrecioEnDiasNoLluviosos

	self 
		should: [ PrecioDependienteDeClima enDiasNoLluviososDe: 1500 * peso / day yEnDiasLluviososDe: 1500 * peso / day usando: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PrecioDependienteDeClima precioDeDiaLluviosoDebeSerMayorAPrecioDeDiaNoLluviosoErrorDescription
	! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/25/2021 13:51:19'!
test13NoSePuedeCrearEquipoCombinadoSinEquipos

	self
		should: [ EquipoCombinado de: {}]
		raise: Error - MessageNotUnderstood 
		withMessageText: EquipoCombinado debeHaberPorloMenosUnEquipoErrorDescription 
		! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test14NoSePuedeCrearEquipoCombinadoConEquiposDirectosCompartidos

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / hour)
		a: (PrecioFijo de: 1000 * peso / day).

	self
		should: [ EquipoCombinado de: {equipoDeTrabajo. equipoDeTrabajo }]
		raise: Error - MessageNotUnderstood 
		withMessageText: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription 
		! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test15NoSePuedeConstruirEquipoCombinadoConEquiposIndirectorRepetidos

	| equipoDeTrabajo |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	self
		should: [ EquipoCombinado de: {equipoDeTrabajo. (EquipoCombinado de: { equipoDeTrabajo}) } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: EquipoCombinado noPuedenHaberEquiposRepetidosErrorDescription 
! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test16CostoParaConstruirDeEquipoCombinadoParaUnEquipoEsElCostoDeEseEquipo

	| equipoDeTrabajo equipoCombinado |
	
	equipoDeTrabajo := EquipoSimple
		construyendoCon: (CapacidadFija de: 25 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoDeTrabajo }.
	
	self assert: 1000 * peso equals: (equipoCombinado costoParaConstruir: 25 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test17CostoParaConstruirEsLaSumaDeLosCostosDeLosEquipos

	| equipoAzul equipoCombinado equipoRojo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	self assert: 5000 * peso equals: (equipoCombinado costoParaConstruir: 40 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test18TiempoDeConstruccionEsElMaximo

	| equipoAzul equipoCombinado equipoRojo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	self assert: 2 * day equals: (equipoCombinado tiempoEnConstruir: 40 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test19SePuedeConsultarElTiempoPorEquipo

	| equipoAzul equipoCombinado equipoRojo tiempoPorEquipo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	tiempoPorEquipo := equipoCombinado tiempoEnConstruirPorEquipo: 40 * meter * meter.
	
	self assert: 2 equals: tiempoPorEquipo size.
	self assert: 1 * day equals: (tiempoPorEquipo at: equipoAzul).
	self assert: 2 * day equals: (tiempoPorEquipo at: equipoRojo )! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test20SePuedeConsultarElCostoPorEquipo

	| equipoAzul equipoCombinado equipoRojo costoPorEquipo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	costoPorEquipo := equipoCombinado costoParaConstruirPorEquipo: 40 * meter * meter.
	
	self assert: 2 equals: costoPorEquipo size.
	self assert: 1000 * peso equals: (costoPorEquipo at: equipoAzul).
	self assert: 4000 * peso equals: (costoPorEquipo at: equipoRojo )! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test21EquipoMasRapidoEsElQueMenosTarda

	| equipoAzul equipoCombinado equipoRojo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	self assert: equipoAzul equals: (equipoCombinado masRapidoParaConstruir: 40 * meter * meter)! !

!TestISWSmartBuilding methodsFor: 'tests' stamp: 'HAW 11/27/2021 15:38:04'!
test22EquipoMasBaratoEsElQueMenosCobra

	| equipoAzul equipoCombinado equipoRojo |
	
	equipoAzul := EquipoSimple
		construyendoCon: (CapacidadFija de: 20 * meter * meter / day)
		a: (PrecioFijo de: 1000 * peso / day ).

	equipoRojo := EquipoSimple
		construyendoCon: (CapacidadFija de: 10 * meter * meter / day)
		a: (PrecioFijo de: 2000 * peso / day ).

	equipoCombinado := EquipoCombinado de: {equipoAzul. equipoRojo }.
	
	self assert: equipoAzul equals: (equipoCombinado masBaratoParaConstruir: 40 * meter * meter)! !


!TestISWSmartBuilding methodsFor: 'pronostico' stamp: 'HAW 11/25/2021 11:57:33'!
diasLluviososEn: unTiempo

	^diasLluviosos ! !


!classDefinition: #CapacidadDeConstruccion category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #CapacidadDeConstruccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!CapacidadDeConstruccion methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 10:56:46'!
tiempoEnConstruir: unArea

	self subclassResponsibility ! !


!classDefinition: #CapacidadFija category: 'ISW1-2021-2C-2doParcial'!
CapacidadDeConstruccion subclass: #CapacidadFija
	instanceVariableNames: 'capacidadDeConstruccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!CapacidadFija methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:02:37'!
initializeDe: unaDimensionPorTiempo 
	
	capacidadDeConstruccion := unaDimensionPorTiempo.! !


!CapacidadFija methodsFor: 'tiempos' stamp: 'HAW 11/25/2021 11:02:37'!
tiempoEnConstruir: unArea

	^unArea / capacidadDeConstruccion ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapacidadFija class' category: 'ISW1-2021-2C-2doParcial'!
CapacidadFija class
	instanceVariableNames: ''!

!CapacidadFija class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:01:07'!
de: unAreaPorTiempo 
	
	^self new initializeDe: unAreaPorTiempo ! !


!classDefinition: #CapacidadVariable category: 'ISW1-2021-2C-2doParcial'!
CapacidadDeConstruccion subclass: #CapacidadVariable
	instanceVariableNames: 'capacidadDeConstruccionInicial tiempoInicial capacidadDeConstruccionRestante'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

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

!classDefinition: 'CapacidadVariable class' category: 'ISW1-2021-2C-2doParcial'!
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


!classDefinition: #EquipoDeTrabajo category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #EquipoDeTrabajo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!EquipoDeTrabajo methodsFor: 'equipos' stamp: 'HAW 11/23/2021 17:16:44'!
addEquiposTo: aCollector

	self subclassResponsibility ! !


!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:04:20'!
costoParaConstruir: unArea

	self subclassResponsibility ! !

!EquipoDeTrabajo methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:04:26'!
tiempoEnConstruir: unArea

	self subclassResponsibility ! !


!classDefinition: #EquipoCombinado category: 'ISW1-2021-2C-2doParcial'!
EquipoDeTrabajo subclass: #EquipoCombinado
	instanceVariableNames: 'equipos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

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

!classDefinition: 'EquipoCombinado class' category: 'ISW1-2021-2C-2doParcial'!
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


!classDefinition: #EquipoSimple category: 'ISW1-2021-2C-2doParcial'!
EquipoDeTrabajo subclass: #EquipoSimple
	instanceVariableNames: 'precio capacidadDeConstruccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!EquipoSimple methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:10:47'!
initializeConstruyendoCon: unCapacidadDeConstruccion a: unPrecio 
	
	capacidadDeConstruccion := unCapacidadDeConstruccion.
	precio := unPrecio.! !


!EquipoSimple methodsFor: 'equipos' stamp: 'HAW 11/23/2021 16:55:25'!
addEquiposTo: aCollector

	aCollector add: self
	
	! !


!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:10:47'!
costoParaConstruir: unArea

	^precio precioPara: (self tiempoEnConstruir: unArea) ! !

!EquipoSimple methodsFor: 'construccion' stamp: 'HAW 11/25/2021 11:10:05'!
tiempoEnConstruir: unArea

	^ (capacidadDeConstruccion tiempoEnConstruir: unArea) ceiling! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EquipoSimple class' category: 'ISW1-2021-2C-2doParcial'!
EquipoSimple class
	instanceVariableNames: ''!

!EquipoSimple class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:11:36'!
construyendoCon: unaCapacidadDeConstruccion a: unPrecio 
	
	^self new initializeConstruyendoCon: unaCapacidadDeConstruccion a: unPrecio ! !


!classDefinition: #PrecioDeConstruccion category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #PrecioDeConstruccion
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!PrecioDeConstruccion methodsFor: 'precios' stamp: 'HAW 11/23/2021 16:34:12'!
precioPara: unTiempo

	self subclassResponsibility ! !


!classDefinition: #PrecioDependienteDeClima category: 'ISW1-2021-2C-2doParcial'!
PrecioDeConstruccion subclass: #PrecioDependienteDeClima
	instanceVariableNames: 'precioParaDiasNoLluviosos precioParaDiasLluviosos servicioMeteorologico'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

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

!classDefinition: 'PrecioDependienteDeClima class' category: 'ISW1-2021-2C-2doParcial'!
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


!classDefinition: #PrecioFijo category: 'ISW1-2021-2C-2doParcial'!
PrecioDeConstruccion subclass: #PrecioFijo
	instanceVariableNames: 'precio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!PrecioFijo methodsFor: 'initialization' stamp: 'HAW 11/25/2021 11:13:44'!
initializeDe: unValorPorTiempo 
	
	precio := unValorPorTiempo.! !


!PrecioFijo methodsFor: 'precios' stamp: 'HAW 11/25/2021 11:13:44'!
precioPara: unTiempo

	^ precio * unTiempo ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioFijo class' category: 'ISW1-2021-2C-2doParcial'!
PrecioFijo class
	instanceVariableNames: ''!

!PrecioFijo class methodsFor: 'instance creation' stamp: 'HAW 11/25/2021 11:12:42'!
de: unValorPorTiempo 
	
	^self new initializeDe: unValorPorTiempo ! !


!classDefinition: #ServicioMeteorologico category: 'ISW1-2021-2C-2doParcial'!
Object subclass: #ServicioMeteorologico
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-2doParcial'!

!ServicioMeteorologico methodsFor: 'pronostico' stamp: 'HAW 11/25/2021 18:46:29'!
diasLluviososEn: unTiempo
! !
