!classDefinition: #AcciónDePintor category: '2025-1C-Parcial-2'!
Object subclass: #AcciónDePintor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!AcciónDePintor methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:58:18'!
deshacer

	self subclassResponsibility! !

!AcciónDePintor methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:58:12'!
hacer

	self subclassResponsibility! !


!classDefinition: #PintorAgregar category: '2025-1C-Parcial-2'!
AcciónDePintor subclass: #PintorAgregar
	instanceVariableNames: 'pintura pared'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAgregar methodsFor: 'initialization' stamp: 'HAW 7/2/2025 11:40:55'!
initializePintura: unaPintura en: unaPared 
	
	pintura := unaPintura.
	pared := unaPared.! !


!PintorAgregar methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:42:41'!
deshacer
	
	pared sacarPintura: pintura ! !

!PintorAgregar methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:41:25'!
hacer
	
	pared agregarPintura: pintura ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAgregar class' category: '2025-1C-Parcial-2'!
PintorAgregar class
	instanceVariableNames: ''!

!PintorAgregar class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 11:40:49'!
pintura: unaPintura en: unaPared 
	
	^self new initializePintura: unaPintura en: unaPared ! !


!classDefinition: #PintorAlinear category: '2025-1C-Parcial-2'!
AcciónDePintor subclass: #PintorAlinear
	instanceVariableNames: 'selección originales x'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAlinear methodsFor: 'initialization' stamp: 'HAW 7/2/2025 12:19:33'!
initializeSelección: unaSelección con: unX 
	
	originales := unaSelección collect: [ :unaPintura | unaPintura copy ].
	selección := unaSelección.
	x := unX.! !


!PintorAlinear methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 12:19:42'!
deshacer
	
	selección with: originales do: [ :unaPintura :unOriginal |
		unaPintura setOrigin: unOriginal origin corner: unOriginal corner ]! !

!PintorAlinear methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 18:45:51'!
hacer

	selección do: [ :unaPintura | | nuevoOrigen |
		nuevoOrigen := self nuevoOrigenPara: unaPintura.
		unaPintura setOrigin: nuevoOrigen corner: nuevoOrigen + unaPintura extent ]! !

!PintorAlinear methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 18:45:21'!
nuevoOrigenPara: unaPintura

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorAlinear class' category: '2025-1C-Parcial-2'!
PintorAlinear class
	instanceVariableNames: ''!

!PintorAlinear class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 12:20:52'!
selección: unaSelección con: unX 
	
	^self new initializeSelección: unaSelección con: unX ! !


!classDefinition: #PintorAlinearADerecha category: '2025-1C-Parcial-2'!
PintorAlinear subclass: #PintorAlinearADerecha
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAlinearADerecha methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 18:45:08'!
nuevoOrigenPara: unaPintura

	^ x - unaPintura width @ unaPintura top! !


!classDefinition: #PintorAlinearAIzquierda category: '2025-1C-Parcial-2'!
PintorAlinear subclass: #PintorAlinearAIzquierda
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorAlinearAIzquierda methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 18:45:41'!
nuevoOrigenPara: unaPintura

	^ x@unaPintura origin y! !


!classDefinition: #PintorSeleccionar category: '2025-1C-Parcial-2'!
AcciónDePintor subclass: #PintorSeleccionar
	instanceVariableNames: 'pintura selección'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorSeleccionar methodsFor: 'initialization' stamp: 'HAW 7/2/2025 11:55:04'!
initializePintura: unaPintura en: unaSelección 
	
	pintura := unaPintura.
	selección := unaSelección.! !


!PintorSeleccionar methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:55:32'!
deshacer
	
	selección remove: pintura ! !

!PintorSeleccionar methodsFor: 'hacer/deshacer' stamp: 'HAW 7/2/2025 11:55:19'!
hacer
	
	selección add: pintura ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PintorSeleccionar class' category: '2025-1C-Parcial-2'!
PintorSeleccionar class
	instanceVariableNames: ''!

!PintorSeleccionar class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 11:54:59'!
pintura: unaPintura en: unaSelección 
	
	^self new initializePintura: unaPintura en: unaSelección ! !


!classDefinition: #HistorialDeAcciones category: '2025-1C-Parcial-2'!
Object subclass: #HistorialDeAcciones
	instanceVariableNames: 'accionesADeshacer accionesARehacer'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!HistorialDeAcciones methodsFor: 'deshacer/rehacer' stamp: 'HAW 7/2/2025 12:22:26'!
deshacer
	
	| acciónADeshacer |
	
	self assertHayAccionesADeshacer.
	
	acciónADeshacer := accionesADeshacer removeLast.
	acciónADeshacer deshacer.
	accionesARehacer add: acciónADeshacer .
	! !

!HistorialDeAcciones methodsFor: 'deshacer/rehacer' stamp: 'HAW 7/2/2025 12:22:43'!
rehacer
	
	| acciónARehacer |
	
	self assertHayAccionesARehacer.
	
	acciónARehacer := accionesARehacer removeLast.
	acciónARehacer hacer.
	accionesADeshacer add: acciónARehacer .
	! !


!HistorialDeAcciones methodsFor: 'initialization' stamp: 'HAW 7/2/2025 12:04:59'!
initialize

	accionesADeshacer := OrderedCollection new.
	accionesARehacer := OrderedCollection new.! !


!HistorialDeAcciones methodsFor: 'hacer' stamp: 'HAW 7/2/2025 12:04:51'!
hacer: acción 

	acción hacer.
	
	accionesADeshacer add: acción.
	accionesARehacer removeAll.
	! !


!HistorialDeAcciones methodsFor: 'asssertions' stamp: 'HAW 7/2/2025 12:23:27'!
assertHayAccionesADeshacer

	accionesADeshacer ifEmpty: [ self error: self class descripciónDeErrorNoHayAcciónADeshacer. ]! !

!HistorialDeAcciones methodsFor: 'asssertions' stamp: 'HAW 7/2/2025 12:23:23'!
assertHayAccionesARehacer

	accionesARehacer ifEmpty: [ self error: self class descripciónDeErrorNoHayAcciónARehacer ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'HistorialDeAcciones class' category: '2025-1C-Parcial-2'!
HistorialDeAcciones class
	instanceVariableNames: ''!

!HistorialDeAcciones class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 12:02:24'!
descripciónDeErrorNoHayAcciónADeshacer
	
	^'No hay acción a deshacer'! !

!HistorialDeAcciones class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 12:03:44'!
descripciónDeErrorNoHayAcciónARehacer
	
	^'No hay acción para rehacer'! !


!classDefinition: #Pared category: '2025-1C-Parcial-2'!
Object subclass: #Pared
	instanceVariableNames: 'pinturas lienzo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!Pared methodsFor: 'initialization' stamp: 'HAW 7/2/2025 10:33:46'!
initializeDe: unaDimensiónDePared 
	
	lienzo := 0@0 extent: unaDimensiónDePared.
	pinturas := OrderedCollection new.! !


!Pared methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 12:24:31'!
agregarPintura: unaPintura  
	
	self assertEntra: unaPintura.
	
	pinturas add: unaPintura .
	! !

!Pared methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 10:48:13'!
cantidadDePinturas
	
	^pinturas size! !

!Pared methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 11:42:58'!
sacarPintura: unaPintura

	pinturas remove: unaPintura ! !


!Pared methodsFor: 'testing' stamp: 'HAW 7/2/2025 11:00:27'!
entra: unaPintura

	^ lienzo containsRect: unaPintura! !

!Pared methodsFor: 'testing' stamp: 'HAW 7/2/2025 10:36:56'!
hayPintura: unaPintura

	^ pinturas includes: unaPintura ! !


!Pared methodsFor: 'assertions' stamp: 'HAW 7/2/2025 12:24:57'!
assertEntra: unaPintura

	(self entra: unaPintura) ifFalse: [ self error: self class descripciónDeErrorDePinturaFueraDePared ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pared class' category: '2025-1C-Parcial-2'!
Pared class
	instanceVariableNames: ''!

!Pared class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 10:36:17'!
descripciónDeErrorDeDimensiónInválida
	
	^'La extensión de la pared debe ser estrictamente positiva'! !

!Pared class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 10:31:54'!
descripciónDeErrorDePinturaFueraDePared
	
	^'Las pinturas deben estar dentro de la pared'! !


!Pared class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 10:36:17'!
de: unaDimensiónDePared 
	
	unaDimensiónDePared x strictlyPositive ifFalse: [self error: self descripciónDeErrorDeDimensiónInválida ].
	unaDimensiónDePared y strictlyPositive ifFalse: [self error: self descripciónDeErrorDeDimensiónInválida ].
	
	^self new initializeDe: unaDimensiónDePared ! !


!classDefinition: #Pintor category: '2025-1C-Parcial-2'!
Object subclass: #Pintor
	instanceVariableNames: 'pared selección historial'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!Pintor methodsFor: 'initialization' stamp: 'HAW 7/2/2025 12:28:53'!
initializePintandoEn: unaPared 
	
	pared := unaPared.
	selección := OrderedCollection new.	
	historial := HistorialDeAcciones new.
	
	! !


!Pintor methodsFor: 'acciones sobre selección' stamp: 'HAW 7/2/2025 12:28:10'!
alinearSelecciónADerecha
	
	| máximoX |
	
	self assertSePuedeAlinearSelección.
	
	máximoX := selección max: [ :unaPintura | unaPintura right ].
	self hacer: (PintorAlinearADerecha selección: selección con: máximoX)
	! !

!Pintor methodsFor: 'acciones sobre selección' stamp: 'HAW 7/2/2025 18:49:48'!
alinearSelecciónAIzquierda
	
	| mínimoX |
	
	self assertSePuedeAlinearSelección.
	
	mínimoX := selección min: [ :unaPintura | unaPintura left ].
	self hacer: (PintorAlinearAIzquierda selección: selección con: mínimoX)
	! !


!Pintor methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 12:27:28'!
agregarPintura: unaPintura

	self assertSePuedeAgregar: unaPintura.
	
	self hacer: (PintorAgregar pintura: unaPintura en: pared).
	! !

!Pintor methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 10:48:05'!
cantidadDePinturas
	
	^pared cantidadDePinturas ! !

!Pintor methodsFor: 'pinturas' stamp: 'HAW 7/2/2025 10:35:07'!
hayPintura: unaPintura

	^pared hayPintura: unaPintura.! !


!Pintor methodsFor: 'selección' stamp: 'HAW 7/2/2025 10:51:43'!
cantidadDePinturasSeleccionadas
	
	^selección size! !

!Pintor methodsFor: 'selección' stamp: 'HAW 7/2/2025 10:40:01'!
estáSeleccionada: unaPintura

	^ selección includes: unaPintura ! !

!Pintor methodsFor: 'selección' stamp: 'HAW 7/2/2025 12:30:07'!
seleccionar: unaPintura

	self assertHayPintura: unaPintura.
	self assertNoEstáSeleccionada: unaPintura.
	 
	self hacer: (PintorSeleccionar pintura: unaPintura en: selección).
	! !


!Pintor methodsFor: 'private' stamp: 'HAW 7/2/2025 12:31:47'!
hacer: acción

	historial hacer: acción .! !


!Pintor methodsFor: 'deshacer/rehacer' stamp: 'HAW 7/2/2025 12:31:39'!
deshacer

	historial deshacer.! !

!Pintor methodsFor: 'deshacer/rehacer' stamp: 'HAW 7/2/2025 12:31:42'!
rehacer

	historial rehacer.! !


!Pintor methodsFor: 'assertions' stamp: 'HAW 7/2/2025 12:30:30'!
assertHayPintura: unaPintura

	(self hayPintura: unaPintura) ifFalse: [ self error: self class descripciónDeErrorNoSePuedeSeleccionarPinturaNoAgregada ]! !

!Pintor methodsFor: 'assertions' stamp: 'HAW 7/2/2025 12:30:36'!
assertNoEstáSeleccionada: unaPintura

	(self estáSeleccionada: unaPintura) ifTrue: [ self error: self class descripciónDeErrorNoSePuedeSeleccionarPinturaYaSeleccionada ]! !

!Pintor methodsFor: 'assertions' stamp: 'HAW 7/2/2025 12:28:34'!
assertSePuedeAgregar: unaPintura

	(self hayPintura: unaPintura) ifTrue: [ self error: self class descripciónDeErrorNoSePuedeAgregarPinturaExistente ]! !

!Pintor methodsFor: 'assertions' stamp: 'HAW 7/2/2025 12:28:38'!
assertSePuedeAlinearSelección

	selección size < 2 ifTrue: [ self error: self class descripciónDeErrorDeNoSePuedeAlinearSinSelección ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pintor class' category: '2025-1C-Parcial-2'!
Pintor class
	instanceVariableNames: ''!

!Pintor class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 10:34:03'!
pintandoEn: unaPared 
	
	^self new initializePintandoEn: unaPared ! !

!Pintor class methodsFor: 'instance creation' stamp: 'HAW 7/2/2025 10:32:42'!
sobreParedDe: unaDimensiónDePared 
	
	^self pintandoEn: (Pared de: unaDimensiónDePared)! !


!Pintor class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 11:19:46'!
descripciónDeErrorDeNoSePuedeAlinearSinSelección
	
	^'Debe haber más de una pintura seleccionada para alinear'! !

!Pintor class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 10:47:37'!
descripciónDeErrorNoSePuedeAgregarPinturaExistente
	
	^'No se puede agregar una pintura ya agregada'! !

!Pintor class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 10:42:58'!
descripciónDeErrorNoSePuedeSeleccionarPinturaNoAgregada
	
	^'No se puede seleccionar una pintura no agregada'! !

!Pintor class methodsFor: 'descripción de errores' stamp: 'HAW 7/2/2025 10:51:32'!
descripciónDeErrorNoSePuedeSeleccionarPinturaYaSeleccionada
	
	^'No se puede seleccionar pintura ya seleccionada'! !


!classDefinition: #PintorTest category: '2025-1C-Parcial-2'!
TestCase subclass: #PintorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Parcial-2'!

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:32:14'!
test01_ExtensiónXEnParedDebeSeEstrictamentePositivo

	self 
		should: [ Pintor sobreParedDe: 0@1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Pared descripciónDeErrorDeDimensiónInválida! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:32:24'!
test01_ExtensiónYEnParedDebeSeEstrictamentePositivo

	self 
		should: [ Pintor sobreParedDe: 1@0 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Pared descripciónDeErrorDeDimensiónInválida! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:32:40'!
test02_EstánLasPinturasAgregadas

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	pintor agregarPintura: pintura.
	
	self assert: (pintor hayPintura: pintura)! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:32:59'!
test03_NoEstánLasPinturasNoAgregadas

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	self deny: (pintor hayPintura: pintura)! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:33:16'!
test04_NoSePuedeAgregarPinturaFueraDeLaPared

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := -1@0 extent: 10@10.
	
	self 
		should: [ pintor agregarPintura: pintura ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (Pared descripciónDeErrorDePinturaFueraDePared).
			self deny: (pintor hayPintura: pintura) ]
	
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:33:35'!
test05_EstáSeleccionadaUnaPinturaSeleccionada

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pintor agregarPintura: pintura.
	
	pintor seleccionar: pintura.
	
	self assert: (pintor estáSeleccionada: pintura)! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:33:50'!
test06_NoEstáSeleccionadaPinturaNoSeleccionada

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pintor agregarPintura: pintura.
	
	self deny: (pintor estáSeleccionada: pintura)! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:34:10'!
test07_NoSePuedeSeleccionarPinturaNoAgregada

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	
	self 
		should: [ pintor seleccionar: pintura ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Pintor descripciónDeErrorNoSePuedeSeleccionarPinturaNoAgregada.
			self deny: (pintor estáSeleccionada: pintura) ]! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:34:22'!
test08_NoSePuedeAgregarLaMismaPintura

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pintor agregarPintura: pintura.
	
	self
		should: [ pintor agregarPintura: pintura ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Pintor descripciónDeErrorNoSePuedeAgregarPinturaExistente.
			self assert: pintor cantidadDePinturas equals: 1 ]! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:34:42'!
test09_NoSePuedeSeleccionarPinturaYaSeleccionada

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 10@10.
	pintor agregarPintura: pintura.
	pintor seleccionar: pintura.
	
	self
		should: [ pintor seleccionar: pintura ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Pintor descripciónDeErrorNoSePuedeSeleccionarPinturaYaSeleccionada.
			self assert: (pintor estáSeleccionada: pintura).
			self assert: pintor cantidadDePinturasSeleccionadas equals: 1 ]! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 18:49:48'!
test12_AlineaAIzquierdaSelecciónConElXMínimoSeleccionado

	| pintor pintura pinturaAAlinear |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pinturaAAlinear := 5@3 extent: 10@10.
	pintor agregarPintura: pintura.
	pintor agregarPintura: pinturaAAlinear.
	pintor seleccionar: pintura.
	pintor seleccionar: pinturaAAlinear.
	
	pintor alinearSelecciónAIzquierda.
	
	self assert: (pintor hayPintura: (0@0 extent: 5@5)).
	self assert: (pintor hayPintura: (0@3 extent: 10@10))
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:40:47'!
test13_AlineaADerechSelecciónConElXMáximoSeleccionado

	| pintor pinturaAAlinear pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pinturaAAlinear := 0@0 extent: 5@5. 
	pintura := 5@3 extent: 10@10.
	pintor agregarPintura: pinturaAAlinear.
	pintor agregarPintura: pintura.
	pintor seleccionar: pinturaAAlinear.
	pintor seleccionar: pintura.
	
	pintor alinearSelecciónADerecha.
	
	self assert: (pintor hayPintura: (10@0 extent: 5@5)).
	self assert: (pintor hayPintura: (5@3 extent: 10@10))
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 18:49:48'!
test14_NoSePuedeAlinearAIzquierdaConMenosDeDosPinturas

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	pintor seleccionar: pintura.
	
	self 
		should: [ pintor alinearSelecciónAIzquierda ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Pintor descripciónDeErrorDeNoSePuedeAlinearSinSelección
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:36:55'!
test15_NoSePuedeAlinearADerechaConMenosDeDosPinturas

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	pintor seleccionar: pintura.
	
	self 
		should: [ pintor alinearSelecciónADerecha ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Pintor descripciónDeErrorDeNoSePuedeAlinearSinSelección
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:37:10'!
test16_NoSePuedeDeshacerAcciónNoHecha

	| pintor |
	
	pintor := Pintor sobreParedDe: 100@100.
	
	self 
		should: [ pintor deshacer ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (HistorialDeAcciones descripciónDeErrorNoHayAcciónADeshacer).
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:37:24'!
test17_SePudeDehacerElAgregarPintura

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	
	pintor deshacer.
	
	self deny: (pintor hayPintura: pintura).
	self assert: pintor cantidadDePinturas equals: 0! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:37:35'!
test18_SePuedeRehacerUnaAcción

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	
	pintor deshacer; rehacer.
	
	self assert: (pintor hayPintura: pintura).
	self assert: pintor cantidadDePinturas equals: 1! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:37:51'!
test19_NoSePuedeRehacerSiNoSeDeshizo

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	
	self 
		should: [ pintor rehacer ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (HistorialDeAcciones descripciónDeErrorNoHayAcciónARehacer).
			self assert: (pintor hayPintura: pintura).
			self assert: pintor cantidadDePinturas equals: 1 ]! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:41:04'!
test20_NoHayNadaParaRehacerLuegoDeHacerUnaAcción

	| pintor pintura segundaPinturaAAgregar |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	segundaPinturaAAgregar := 1@1 extent: 5@5. 
	pintor agregarPintura: pintura.
	pintor deshacer.
	pintor agregarPintura: segundaPinturaAAgregar.
	
	self 
		should: [ pintor rehacer ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: (HistorialDeAcciones descripciónDeErrorNoHayAcciónARehacer).
			self assert: (pintor hayPintura: segundaPinturaAAgregar).
			self assert: pintor cantidadDePinturas equals: 1 ]! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:38:26'!
test21_SePuedeDeshacerAcciónRehecha

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	
	pintor deshacer; rehacer; deshacer.
	
	self deny: (pintor hayPintura: pintura).
	self assert: pintor cantidadDePinturas equals: 0! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:38:37'!
test22_SePuedeDeshacerUnaSelección

	| pintor pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pintor agregarPintura: pintura.
	pintor seleccionar: pintura.
	
	pintor deshacer.
	
	self deny: (pintor estáSeleccionada: pintura).
	self assert: pintor cantidadDePinturasSeleccionadas equals: 0! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 18:49:48'!
test24_SePuedeDeshacerLaAlineaciónAIzquierda

	| pintor pintura pinturaAAlinear |
	
	pintor := Pintor sobreParedDe: 100@100.
	pintura := 0@0 extent: 5@5. 
	pinturaAAlinear := 5@3 extent: 10@10.
	pintor agregarPintura: pintura.
	pintor agregarPintura: pinturaAAlinear.
	pintor seleccionar: pintura.
	pintor seleccionar: pinturaAAlinear.
	pintor alinearSelecciónAIzquierda.
	
	pintor deshacer.
	
	self assert: (pintor hayPintura: (0@0 extent: 5@5)).
	self assert: (pintor hayPintura: (5@3 extent: 10@10))
	! !

!PintorTest methodsFor: 'tests' stamp: 'HAW 7/2/2025 12:41:40'!
test25_SePuedeDeshacerLaAlineaciónADerecha

	| pintor pinturaAAlinear pintura |
	
	pintor := Pintor sobreParedDe: 100@100.
	pinturaAAlinear := 0@0 extent: 5@5. 
	pintura := 5@3 extent: 10@10.
	pintor agregarPintura: pinturaAAlinear.
	pintor agregarPintura: pintura.
	pintor seleccionar: pinturaAAlinear.
	pintor seleccionar: pintura.
	pintor alinearSelecciónADerecha.
	
	pintor deshacer.
	
	self assert: (pintor hayPintura: (0@0 extent: 5@5)).
	self assert: (pintor hayPintura: (5@3 extent: 10@10))
	! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 92 122 108 121 122 54 111 108 121 117 104 117 54 75 118 106 124 116 108 117 123 122 54 74 124 112 122 54 60 53 55 52 61 59 73 112 123 122 54 94 118 121 114 112 117 110 17 54 92 122 108 121 122 54 111 108 121 117 104 117 54 75 118 106 124 116 108 117 123 122 54 74 124 112 122 54 60 53 55 52 61 59 73 112 123 122 54 94 118 121 114 112 117 110 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 58 55 56 53 112 116 104 110 108 17 84 104 106 39 86 90 17 56 60 55 60 53 55 17 127 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 100 39 60 53 57 55 57 60 55 57 56 55 53 57 58 59 63 17 72 120 124 104 17 84 104 106 39 86 90 39 95 39 105 124 112 115 123 39 118 117 39 72 119 121 39 39 58 39 57 55 57 60 39 56 64 65 59 60 65 59 55 39 52 55 58 39 74 118 116 119 112 115 108 121 65 39 72 119 119 115 108 39 83 83 93 84 39 56 61 53 55 53 55 39 47 106 115 104 117 110 52 56 61 55 55 53 55 53 57 61 53 61 48 17 83 112 125 108 91 128 119 112 117 110 74 118 80 117 123 108 121 119 121 108 123 108 121 39 49 39 39 124 124 112 107 65 39 117 112 115 39 72 119 121 39 39 58 39 57 55 57 60 17 83 112 125 108 91 128 119 112 117 110 74 118 110 112 123 39 49 39 39 124 124 112 107 65 39 117 112 115 17 74 118 110 80 117 83 112 117 108 83 112 123 108 121 104 115 122 95 61 59 74 118 116 119 112 115 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 56 57 39 124 124 112 107 65 39 108 57 108 64 104 55 64 108 52 64 109 56 109 52 59 104 106 105 52 63 58 57 57 52 62 106 58 58 105 58 56 107 107 107 109 105 39 72 119 121 39 39 58 39 57 55 57 60 17 93 84 65 39 57 55 57 60 55 57 56 55 57 58 59 63 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 84 118 117 39 77 108 105 39 56 55 39 56 60 65 59 63 65 60 62 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 108 55 56 55 60 107 105 39 87 115 124 110 112 117 122 65 39 57 55 57 60 55 57 56 55 57 58 59 63 39 111 108 121 117 104 117 71 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 65 75 118 106 124 116 108 117 123 122 54 93 84 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 17 53 34 124 17 56 55 53 59 61 53 57 62 53 56 56 62 17 56 55 53 59 61 53 57 62 53 56 56 62 17 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 79 108 121 117 104 117 52 57 53 115 118 106 104 115 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 56 63 65 60 59 65 56 57 53 55 58 59 62 60 52 55 58 65 55 55 17 54 92 122 108 121 122 54 111 108 121 117 104 117 54 75 118 106 124 116 108 117 123 122 54 74 124 112 122 54 60 53 55 52 61 59 73 112 123 122 54 94 118 121 114 112 117 110 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 128 128 53 122 123 17 57 62 55 62 57 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 56 63 65 60 58 65 58 61 53 61 64 55 64 63 52 55 58 65 55 55 17 54 92 122 108 121 122 54 111 108 121 117 104 117 54 75 118 106 124 116 108 117 123 122 54 74 124 112 122 54 60 53 55 52 61 59 73 112 123 122 54 94 118 121 114 112 117 110 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 128 128 53 122 123 17 57 58 62 55 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 55 62 52 55 59 91 56 64 65 59 64 65 60 60 53 64 59 56 57 61 59 52 55 58 65 55 55 17 54 92 122 108 121 122 54 111 108 121 117 104 117 54 75 118 106 124 116 108 117 123 122 54 74 124 112 122 54 60 53 55 52 61 59 73 112 123 122 54 94 118 121 114 112 117 110 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 56 74 52 87 104 121 106 112 104 115 52 57 52 90 118 115 53 122 123 17 57 58 62 55 58 17 52 52 52 52 52 52 52 52 52 52 17 17))!