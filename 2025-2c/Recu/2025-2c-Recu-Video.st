!classDefinition: #BuscadorDeVuelos category: #'2025-2c-Recu'!
Object subclass: #BuscadorDeVuelos
	instanceVariableNames: 'definicionesDeVuelos contadorDePasajeros tiposDeDescuentos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!BuscadorDeVuelos methodsFor: 'initialization' stamp: 'HAW 12/11/2025 19:21:44'!
initializePara: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos verificandoDisponibilidadDeAsientosCon: unContadorDePasajeros  
	
	definicionesDeVuelos := unasDefinicionesDeVuelos.
	contadorDePasajeros := unContadorDePasajeros.
	tiposDeDescuentos := unosTiposDeDescuentos ! !


!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/11/2025 20:09:45'!
vuelosDe: unOrigen a: unDestino paritendoEl: unaFechaDePartida con: unaCantidadDePasajeros 
	
	^self 
		vuelosDe: (OpcionesDeBúsqueda partiendoDe: unOrigen a: unDestino el: unaFechaDePartida) 
		con: unaCantidadDePasajeros ! !

!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/11/2025 19:03:12'!
vuelosDe: unOrigen a: unDestino paritendoEl: unaFechaDePartida volviendoEl: unaFechaDeRegreso con: unaCantidadDePasajeros 
	
	^self 
		vuelosPara: { 
			OpcionesDeBúsqueda partiendoDe: unOrigen a: unDestino  el: unaFechaDePartida.
			OpcionesDeBúsqueda partiendoDe: unDestino a:  unOrigen el: unaFechaDeRegreso }
		con: unaCantidadDePasajeros ! !

!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/11/2025 19:47:43'!
vuelosDe: unaOpciónDeBusqueda con: unaCantidadDePasajeros 
	
	| vuelos |
	
	vuelos := definicionesDeVuelos 
		select: [ :unaDefiniciónDeVuelo | self satisface: unaOpciónDeBusqueda a: unaDefiniciónDeVuelo con: unaCantidadDePasajeros ]
		thenCollect: [ :unaDefiniciónDeVuelo | 
			VueloDeIda definidoPor: unaDefiniciónDeVuelo partiendoEl: unaOpciónDeBusqueda fechaDePartida con: unaCantidadDePasajeros ].
			
	 vuelos do: [ :unVuelo | self aplicarDescuentosA: unVuelo ].
	
	^vuelos ! !


!BuscadorDeVuelos methodsFor: 'descuentos' stamp: 'HAW 12/11/2025 19:25:41'!
aplicarDescuentosA: unVuelo 
	
	| descuentos |
	
	descuentos := tiposDeDescuentos 
		select: [ :unTipoDeDescuento | unTipoDeDescuento aplicaA: unVuelo ]
		thenCollect: [ :unTipoDeDescuento | Descuento de: unTipoDeDescuento para: unVuelo ].
		
	unVuelo agregarDescuentos: descuentos! !


!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/11/2025 18:03:41'!
hayAsientosEn: unaDefiniciónDeVuelo partiendoEn: unaFechaDePartida con: unaCantidadDePasajeros 
	
	^ (contadorDePasajeros disponibilidadPara: unaDefiniciónDeVuelo partiendoEn: unaFechaDePartida) >= unaCantidadDePasajeros ! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/11/2025 20:12:41'!
partenDespuésDeLlegada: unosTramos

	| llegadaVueloAnterior |
	
	llegadaVueloAnterior := GregorianDateTime theBeginningOfTime.
	unosTramos do: [ :unTramo |
		llegadaVueloAnterior >= unTramo partida ifTrue: [ ^false ].
		llegadaVueloAnterior := unTramo llegada ].
	
	^true! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/11/2025 20:09:27'!
satisface: unaOpciónDeBusqueda a: unaDefiniciónDeVuelo con: unaCantidadDePasajeros

	^ (unaOpciónDeBusqueda satisface: unaDefiniciónDeVuelo)	and: [ 
		self hayAsientosEn: unaDefiniciónDeVuelo partiendoEn: unaOpciónDeBusqueda fechaDePartida con: unaCantidadDePasajeros ]! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/11/2025 20:14:20'!
tramosVálidosDe: vuelosPorTramo
	
	| todosLosTramos |
	
	todosLosTramos := vuelosPorTramo todasLasCombinaciones.
	todosLosTramos := todosLosTramos select: [ :unosTramos | self partenDespuésDeLlegada: unosTramos ].
	
	^todosLosTramos
	! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/11/2025 20:13:53'!
vuelosPara: unasOpcionesDeBúsqueda con: unaCantidadDePasajeros 
	
	| vuelosPorTramo todosLosTramos |
	
	vuelosPorTramo := unasOpcionesDeBúsqueda collect: [ :unaOpciónDeBusqueda |
		self vuelosDe:  unaOpciónDeBusqueda con: unaCantidadDePasajeros ].
	
	todosLosTramos := self tramosVálidosDe: vuelosPorTramo.
	
	^todosLosTramos collect: [:tramos | VueloMultitramos con: tramos ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BuscadorDeVuelos class' category: #'2025-2c-Recu'!
BuscadorDeVuelos class
	instanceVariableNames: ''!

!BuscadorDeVuelos class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 19:21:22'!
para: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos verificandoDisponibilidadDeAsientosCon: unContadorDePasajeros  
	
	^self new initializePara: unasDefinicionesDeVuelos descontandoCon: unosTiposDeDescuentos verificandoDisponibilidadDeAsientosCon: unContadorDePasajeros ! !


!classDefinition: #DefiniciónDeVuelo category: #'2025-2c-Recu'!
Object subclass: #DefiniciónDeVuelo
	instanceVariableNames: 'origen destino diasDePartida horaDePartida duración costo código'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DefiniciónDeVuelo methodsFor: 'initialization' stamp: 'HAW 12/11/2025 17:51:53'!
initializeIdentificadoCon: unCódigo desde: unOrigen a: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida durante: unaDuración conUnCostoDe: unCosto 
	
	código := unCódigo. 
	origen := unOrigen.
	destino := unDestino.
	diasDePartida := unosDiasDePartida.
	horaDePartida := unaHoraDePartida.
	duración := unaDuración.
	costo := unCosto.! !


!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:40:10'!
costo
	
	^costo! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:51:11'!
código
	
	^código! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:39:02'!
destino
	
	^destino! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:39:53'!
duración
	
	^duración! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:39:31'!
horaDePartida
	
	^horaDePartida! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:38:44'!
origen
	
	^origen! !


!DefiniciónDeVuelo methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:35:33'!
parteDe: unOrigen a: unDestino 
	
	^origen = unOrigen and: [ destino = unDestino ]! !

!DefiniciónDeVuelo methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:35:53'!
parteDe: unOrigen a: unDestino en: unaFechaDePartida 
	
	^(self parteDe: unOrigen a: unDestino)
		and: [ (diasDePartida includes: unaFechaDePartida day)] ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DefiniciónDeVuelo class' category: #'2025-2c-Recu'!
DefiniciónDeVuelo class
	instanceVariableNames: ''!

!DefiniciónDeVuelo class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 17:51:33'!
identificadoCon: unCódigo desde: unOrigen a: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida durante: unaDuración conUnCostoDe: unCosto 
	
	^self new initializeIdentificadoCon: unCódigo desde: unOrigen a: unDestino partiendoLos: unosDiasDePartida aLas: unaHoraDePartida durante: unaDuración conUnCostoDe: unCosto ! !


!classDefinition: #Descuento category: #'2025-2c-Recu'!
Object subclass: #Descuento
	instanceVariableNames: 'tipo vuelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!Descuento methodsFor: 'initialization' stamp: 'HAW 12/11/2025 19:28:49'!
initializeDe: unTipoDeDescuento para: unVuelo 
	
	tipo := unTipoDeDescuento.
	vuelo := unVuelo.! !


!Descuento methodsFor: 'tipo' stamp: 'HAW 12/11/2025 19:28:52'!
tipo
	
	^tipo! !


!Descuento methodsFor: 'valor' stamp: 'HAW 12/11/2025 19:28:49'!
valor
	
	^tipo aplicarA: vuelo costoBruto ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Descuento class' category: #'2025-2c-Recu'!
Descuento class
	instanceVariableNames: ''!

!Descuento class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 19:26:03'!
de: unTipoDeDescuento para: unVuelo 
	
	^self new initializeDe: unTipoDeDescuento para: unVuelo ! !


!classDefinition: #OpcionesDeBúsqueda category: #'2025-2c-Recu'!
Object subclass: #OpcionesDeBúsqueda
	instanceVariableNames: 'origen destino fechaDePartida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!OpcionesDeBúsqueda methodsFor: 'initialization' stamp: 'HAW 12/11/2025 18:51:53'!
initializePartiendoDe: unOrigen a: unDestino el: unaFechaDePartida 
	
	origen := unOrigen.
	destino := unDestino.
	fechaDePartida := unaFechaDePartida.! !


!OpcionesDeBúsqueda methodsFor: 'accessing' stamp: 'HAW 12/11/2025 18:56:42'!
fechaDePartida
	
	^fechaDePartida! !


!OpcionesDeBúsqueda methodsFor: 'testing' stamp: 'HAW 12/11/2025 18:56:37'!
satisface: unaDefiniciónDeVuelo 
	
	^unaDefiniciónDeVuelo parteDe: origen a: destino en: fechaDePartida ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OpcionesDeBúsqueda class' category: #'2025-2c-Recu'!
OpcionesDeBúsqueda class
	instanceVariableNames: ''!

!OpcionesDeBúsqueda class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 18:51:48'!
partiendoDe: unOrigen a: unDestino el: unaFechaDePartida 
	
	^self new initializePartiendoDe: unOrigen a: unDestino el: unaFechaDePartida ! !


!classDefinition: #TipoDeDescuento category: #'2025-2c-Recu'!
Object subclass: #TipoDeDescuento
	instanceVariableNames: 'porcentaje'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!TipoDeDescuento methodsFor: 'aplicación' stamp: 'HAW 12/11/2025 19:49:47'!
aplicarA: unValor

	^porcentaje * unValor ! !


!TipoDeDescuento methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:49:58'!
aplicaA: unVuelo

	self subclassResponsibility! !


!classDefinition: #DescuentoPorFecha category: #'2025-2c-Recu'!
TipoDeDescuento subclass: #DescuentoPorFecha
	instanceVariableNames: 'fecha'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DescuentoPorFecha methodsFor: 'initialization' stamp: 'HAW 12/11/2025 19:17:37'!
initializeDe: unPorcentaje para: unaFecha 
	
	porcentaje := unPorcentaje.
	fecha := unaFecha.! !


!DescuentoPorFecha methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:31:02'!
aplicaA: unVuelo 
	
	^fecha = unVuelo fechaDePartida! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorFecha class' category: #'2025-2c-Recu'!
DescuentoPorFecha class
	instanceVariableNames: ''!

!DescuentoPorFecha class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 19:17:30'!
de: unPorcentaje para: unaFecha 
	
	^self new initializeDe: unPorcentaje para: unaFecha ! !


!classDefinition: #DescuentoPorTramo category: #'2025-2c-Recu'!
TipoDeDescuento subclass: #DescuentoPorTramo
	instanceVariableNames: 'origen destino'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DescuentoPorTramo methodsFor: 'initialization' stamp: 'HAW 12/11/2025 19:32:23'!
initializeDe: unPorcentaje desde: unOrigen a: unDestino 
	
	porcentaje := unPorcentaje.
	origen := unOrigen.
	destino := unDestino.! !


!DescuentoPorTramo methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:34:09'!
aplicaA: unVuelo 
	
	^unVuelo parteDe: origen a: destino ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorTramo class' category: #'2025-2c-Recu'!
DescuentoPorTramo class
	instanceVariableNames: ''!

!DescuentoPorTramo class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 19:32:18'!
de: unPorcentaje desde: unOrigen a: unDestino 
	
	^self new initializeDe: unPorcentaje desde: unOrigen a: unDestino ! !


!classDefinition: #Vuelo category: #'2025-2c-Recu'!
Object subclass: #Vuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!Vuelo methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:50:38'!
destino

	self subclassResponsibility! !

!Vuelo methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:51:15'!
llegada

	self subclassResponsibility! !

!Vuelo methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:51:19'!
origen

	self subclassResponsibility! !

!Vuelo methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:51:27'!
partida

	self subclassResponsibility! !


!Vuelo methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:50:24'!
costoBruto

	self subclassResponsibility! !

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:50:28'!
costoNeto

	self subclassResponsibility! !

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:50:34'!
descuentos

	self subclassResponsibility! !

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:51:37'!
totalDeDescuento

	self subclassResponsibility! !


!classDefinition: #VueloDeIda category: #'2025-2c-Recu'!
Vuelo subclass: #VueloDeIda
	instanceVariableNames: 'definiciónDeVuelo fechaDePartida cantidadDePasajeros descuentos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!VueloDeIda methodsFor: 'initialization' stamp: 'HAW 12/11/2025 19:49:06'!
initializeDefinidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros  
	
	definiciónDeVuelo := unaDefiniciónDeVuelo.
	fechaDePartida := unaFechaDePartida.
	cantidadDePasajeros := unaCantidadDePasajeros.
	descuentos := OrderedCollection new.! !


!VueloDeIda methodsFor: 'accessing' stamp: 'HAW 12/11/2025 17:51:03'!
código
	
	^definiciónDeVuelo código! !

!VueloDeIda methodsFor: 'accessing' stamp: 'HAW 12/11/2025 19:30:54'!
fechaDePartida
	
	^fechaDePartida! !


!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:49:15'!
agregarDescuentos: unosDescuentos 
	
	descuentos addAll: unosDescuentos ! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/11/2025 18:06:33'!
costoBruto
	
	^definiciónDeVuelo costo * cantidadDePasajeros ! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:27:14'!
costoNeto
	
	^self costoBruto - self totalDeDescuento! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:28:31'!
descuentos
	
	^descuentos copy! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:29:14'!
totalDeDescuento

	^ descuentos sum: [:unDescuento | unDescuento valor ] ifEmpty: [ 0 ]! !


!VueloDeIda methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 17:38:56'!
destino
	
	^definiciónDeVuelo destino ! !

!VueloDeIda methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 17:39:49'!
llegada
	
	^self partida next: definiciónDeVuelo duración! !

!VueloDeIda methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 17:38:07'!
origen
	
	^definiciónDeVuelo origen ! !

!VueloDeIda methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 17:39:25'!
partida
	
	^fechaDePartida at: definiciónDeVuelo horaDePartida! !


!VueloDeIda methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:34:56'!
parteDe: unOrigen a: unDestino 
	
	^definiciónDeVuelo parteDe: unOrigen a: unDestino 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloDeIda class' category: #'2025-2c-Recu'!
VueloDeIda class
	instanceVariableNames: ''!

!VueloDeIda class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 18:06:09'!
definidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros  
	
	^self new initializeDefinidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros ! !


!classDefinition: #VueloMultitramos category: #'2025-2c-Recu'!
Vuelo subclass: #VueloMultitramos
	instanceVariableNames: 'tramos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!VueloMultitramos methodsFor: 'initialization' stamp: 'HAW 12/11/2025 18:59:17'!
initializeCon: unosTramos 
	
	tramos := unosTramos.! !


!VueloMultitramos methodsFor: 'testing' stamp: 'HAW 12/11/2025 19:03:39'!
esCódigoDeIda: unCódigoDeIda yVuelta: unCódigoDeVuelta 

	^tramos first código = unCódigoDeIda and: [ tramos last código = unCódigoDeVuelta ]	
	! !


!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:01:07'!
costoBruto
	
	^tramos sum: [ :unTramo | unTramo costoBruto ]! !

!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:43:16'!
costoNeto
	
	^self costoBruto - self totalDeDescuento! !

!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:44:25'!
descuentos
	
	^(tramos collect: [ :unTramo | unTramo descuentos ]) flatten ! !

!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/11/2025 19:43:36'!
totalDeDescuento
	
	^tramos sum: [ :unTramo | unTramo totalDeDescuento ]! !


!VueloMultitramos methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 18:59:46'!
destino
	
	^tramos last destino! !

!VueloMultitramos methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:00:13'!
llegada
	
	^tramos last llegada! !

!VueloMultitramos methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 18:59:31'!
origen
	
	^tramos first origen! !

!VueloMultitramos methodsFor: 'origen/destino' stamp: 'HAW 12/11/2025 19:00:00'!
partida
	
	^tramos first partida ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloMultitramos class' category: #'2025-2c-Recu'!
VueloMultitramos class
	instanceVariableNames: ''!

!VueloMultitramos class methodsFor: 'instance creation' stamp: 'HAW 12/11/2025 18:59:10'!
con: unosTramos 
	
	^self new initializeCon: unosTramos ! !


!classDefinition: #AterrizarComTest category: #'2025-2c-Recu'!
TestCase subclass: #AterrizarComTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test01NoEncuentraVuelosCuandoNoHayDefinicionesDeVuelos

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: {} descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: December / 9 / 2025
		con: 1.
			
	self assert: vuelosEncontrados isEmpty.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test02EncuentraUnVueloParaLasOpcionesDeBúsqueda

	| buscador vuelosEncontrados vueloABarcelonaAR100 vueloEncontrado fechaDePartida cantidadDePasajeros |
	
	vueloABarcelonaAR100 := self vueloAR100.
		
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self barcelona.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: (vueloEncontrado partida next: self duraciónDeAR100).
	self assert: vueloEncontrado costoBruto equals: self costoDeAR100 * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto.
	self assert: vueloEncontrado descuentos isEmpty.
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test03EncuentraMásDeUnVueloParaLasOpcionesDeBúsqueda

	| buscador vuelosEncontrados vueloABarcelonaAR100 fechaDePartida vueloABarcelonaIB300 |
	
	vueloABarcelonaAR100 := self vueloAR100.
	vueloABarcelonaIB300 := self vueloIB300.
		
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100. vueloABarcelonaIB300 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: 1.
			
	self assert: vuelosEncontrados size equals: 2.
	self assert: (vuelosEncontrados anySatisfy: [:unVuelo | unVuelo código = self códigoAR100 ]).
	self assert: (vuelosEncontrados anySatisfy: [:unVuelo | unVuelo código = self códigoIB300 ]).
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test04NoEncuentraVuelosCuandoDifiereElOrigen

	| buscador vuelosEncontrados vueloABarcelonaAR100 fechaDePartida |
	
	vueloABarcelonaAR100 := self vueloAR100.
	
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: 'Aeroparque'
		a: self barcelona
		paritendoEl: fechaDePartida
		con: 1.
			
	self assert: vuelosEncontrados isEmpty
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test05NoEncuentraVueloCuandoDifiereElDestino

	| buscador vuelosEncontrados vueloABarcelonaAR100 fechaDePartida |
	
	vueloABarcelonaAR100 := self vueloAR100.
	
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: 'Aeroparque'
		paritendoEl: fechaDePartida
		con: 1.
			
	self assert: vuelosEncontrados isEmpty
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test06NoEncuentraCuandoNoHayVueloParaLaFechaDePartida

	| buscador vuelosEncontrados vueloABarcelonaIB300 fechaDePartida |
	
	vueloABarcelonaIB300 := self vueloIB300.
	
	buscador := BuscadorDeVuelos para: { vueloABarcelonaIB300 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 7 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		con: 1.
			
	self assert: vuelosEncontrados isEmpty
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test07NoEncuentraVuelosCuandoNoHayDisponibilidad

	| buscador vuelosEncontrados vueloABarcelonaAR100 fechaDePartida |
	
	vueloABarcelonaAR100 := self vueloAR100.
	
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		con: 3.
			
	self assert: vuelosEncontrados isEmpty
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test08EncuentraVuelosDeIdaYVuelta

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros vueloEncontrado |
	
	buscador := BuscadorDeVuelos para: { self vueloAR100. self vueloAR101 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self ezeiza.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: ((fechaDeRegreso at: self horaDePartidaDeAR101) next: self duraciónDeAR101).
	self assert: vueloEncontrado costoBruto equals: (self costoDeAR100 + self costoDeAR101) * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto.
	self assert: vueloEncontrado descuentos isEmpty.
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test09NoEncuentraVueldosDeIdaYVueltaSinIda

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros |
	
	buscador := BuscadorDeVuelos para: { self vueloAR100. self vueloAR101 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: 'Aeroparque'
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados isEmpty ! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test10NoEncuentraVuelodDeIdaYVueltaSinVuelta

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros |
	
	buscador := BuscadorDeVuelos para: { self vueloAR100 } descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados isEmpty ! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test11EncuentraVariosVuelosDeIdaYVuelta

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloAR100. self vueloAR101. self vueloIB300. self vueloIB301 } 
		descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 4.
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo esCódigoDeIda: self códigoAR100 yVuelta: self códigoAR101 ]).
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo esCódigoDeIda: self códigoAR100 yVuelta: self códigoIB301 ]).
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo esCódigoDeIda: self códigoIB300 yVuelta: self códigoAR101 ]).
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo esCódigoDeIda: self códigoIB300 yVuelta: self códigoIB301 ]).
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:14:06'!
test12CódigoDeIdaYVueltaDistintos

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloAR100. self vueloAR101. self vueloIB300. self vueloIB301 } 
		descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 4.
	self assert: (vuelosEncontrados noneSatisfy: [ :unVuelo | unVuelo esCódigoDeIda: '' yVuelta: self códigoAR101 ]).
	self assert: (vuelosEncontrados noneSatisfy: [ :unVuelo | unVuelo esCódigoDeIda: self códigoAR100 yVuelta: '' ]).
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:44:51'!
test13SePuedeBuscarVuelosMultitramos

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros vueloEncontrado |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloAR100. self vueloAR101 } 
		descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosPara: {
			OpcionesDeBúsqueda partiendoDe: self ezeiza a: self barcelona el: fechaDePartida.
			OpcionesDeBúsqueda partiendoDe: self barcelona a: self ezeiza el: fechaDeRegreso}
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self ezeiza.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: ((fechaDeRegreso at: self horaDePartidaDeAR101) next: self duraciónDeAR101).
	self assert: vueloEncontrado costoBruto equals: (self costoDeAR100 + self costoDeAR101) * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto.
	self assert: vueloEncontrado descuentos isEmpty.
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:45:17'!
test14LaPartidaDebeSerPosteriorALaLlegadDeVueloAnterior

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloAR100. self vueloAR101 } 
		descontandoCon: #() verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 9 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosPara: {
			OpcionesDeBúsqueda partiendoDe: self ezeiza a: self barcelona el: fechaDePartida.
			OpcionesDeBúsqueda partiendoDe: self barcelona a: self ezeiza el: fechaDeRegreso}
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados isEmpty
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:45:27'!
test15AplicaDescuentoPorFecha

	| buscador vuelosEncontrados vueloABarcelonaAR100 vueloEncontrado fechaDePartida cantidadDePasajeros porcentajeDeDescuento descuento descuentoPorFecha |
	
	vueloABarcelonaAR100 := self vueloAR100.
		
	fechaDePartida := December / 9 / 2025.
	porcentajeDeDescuento := 10/100.
	descuentoPorFecha := DescuentoPorFecha de: porcentajeDeDescuento para: fechaDePartida.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		descontandoCon: { descuentoPorFecha } 
		verificandoDisponibilidadDeAsientosCon: self.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self barcelona.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: (vueloEncontrado partida next: self duraciónDeAR100).
	self assert: vueloEncontrado costoBruto equals: self costoDeAR100 * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto * (1-porcentajeDeDescuento).
	self assert: vueloEncontrado descuentos size equals: 1.
	descuento := vueloEncontrado descuentos anyOne.
	self assert: descuento tipo equals: descuentoPorFecha.
	self assert: descuento valor equals: vueloEncontrado costoBruto * porcentajeDeDescuento
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:45:43'!
test16NoAplicaDescuentoPorFechaDistintaAFechaDePartida

	| buscador vuelosEncontrados vueloABarcelonaAR100 vueloEncontrado fechaDePartida cantidadDePasajeros porcentajeDeDescuento descuentoPorFecha |
	
	vueloABarcelonaAR100 := self vueloAR100.
		
	fechaDePartida := December / 9 / 2025.
	porcentajeDeDescuento := 10/100.
	descuentoPorFecha := DescuentoPorFecha de: porcentajeDeDescuento para: fechaDePartida next.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		descontandoCon: { descuentoPorFecha } 
		verificandoDisponibilidadDeAsientosCon: self.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self barcelona.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: (vueloEncontrado partida next: self duraciónDeAR100).
	self assert: vueloEncontrado costoBruto equals: self costoDeAR100 * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto.
	self assert: vueloEncontrado descuentos isEmpty
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:45:51'!
test17AplicaDescuentoPorTramos

	| buscador vuelosEncontrados vueloABarcelonaAR100 vueloEncontrado fechaDePartida cantidadDePasajeros porcentajeDeDescuento descuento descuentoPorFecha |
	
	vueloABarcelonaAR100 := self vueloAR100.
		
	fechaDePartida := December / 9 / 2025.
	porcentajeDeDescuento := 10/100.
	descuentoPorFecha := DescuentoPorTramo de: porcentajeDeDescuento desde: self ezeiza a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		descontandoCon: { descuentoPorFecha } 
		verificandoDisponibilidadDeAsientosCon: self.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self barcelona.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: (vueloEncontrado partida next: self duraciónDeAR100).
	self assert: vueloEncontrado costoBruto equals: self costoDeAR100 * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto * (1-porcentajeDeDescuento).
	self assert: vueloEncontrado descuentos size equals: 1.
	descuento := vueloEncontrado descuentos anyOne.
	self assert: descuento tipo equals: descuentoPorFecha.
	self assert: descuento valor equals: vueloEncontrado costoBruto * porcentajeDeDescuento
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:46:11'!
test18NoAplicaDescuentoPorTramosCuandoOrigenODestinoEsDistino

	| buscador vuelosEncontrados vueloABarcelonaAR100 vueloEncontrado fechaDePartida cantidadDePasajeros porcentajeDeDescuento descuentoPorFecha |
	
	vueloABarcelonaAR100 := self vueloAR100.
		
	fechaDePartida := December / 9 / 2025.
	porcentajeDeDescuento := 10/100.
	descuentoPorFecha := DescuentoPorTramo de: porcentajeDeDescuento desde: 'Aeroparque' a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		descontandoCon: { descuentoPorFecha } 
		verificandoDisponibilidadDeAsientosCon: self.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza
		a: self barcelona
		paritendoEl: fechaDePartida
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self assert: vueloEncontrado origen equals: self ezeiza.
	self assert: vueloEncontrado destino equals: self barcelona.
	self assert: vueloEncontrado partida equals: (fechaDePartida at: self horaDePartidaDeAR100).
	self assert: vueloEncontrado llegada equals: (vueloEncontrado partida next: self duraciónDeAR100).
	self assert: vueloEncontrado costoBruto equals: self costoDeAR100 * cantidadDePasajeros.
	self assert: vueloEncontrado costoNeto equals: vueloEncontrado costoBruto .
	self assert: vueloEncontrado descuentos isEmpty
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/11/2025 19:46:27'!
test19AplicaDescuentoAViajesMultitramos

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso cantidadDePasajeros vueloEncontrado porcentajeDeDescuentoPorFecha descuentoPorFecha descuentoPorTramo porcentajeDeDescuentoPorTramo |
	
	fechaDePartida := December / 9 / 2025.
	porcentajeDeDescuentoPorFecha := 10/100.
	porcentajeDeDescuentoPorTramo := 5/100.
	descuentoPorFecha := DescuentoPorFecha de: porcentajeDeDescuentoPorFecha para: fechaDePartida.
	descuentoPorTramo := DescuentoPorTramo de: porcentajeDeDescuentoPorTramo desde: self ezeiza a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { self vueloAR100. self vueloAR101 } 
		descontandoCon: { descuentoPorFecha. descuentoPorTramo }
		verificandoDisponibilidadDeAsientosCon: self.
	
	fechaDeRegreso := December / 10 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		paritendoEl: fechaDePartida
		volviendoEl: fechaDeRegreso
		con: cantidadDePasajeros.
			
	self assert: vuelosEncontrados size equals: 1.
	vueloEncontrado := vuelosEncontrados anyOne.
	self 
		assert: vueloEncontrado costoNeto 
		equals: vueloEncontrado costoBruto 
			- (self costoDeAR100 * cantidadDePasajeros * porcentajeDeDescuentoPorFecha) 
			- (self costoDeAR100 * cantidadDePasajeros * porcentajeDeDescuentoPorTramo).
			
	self assert: vueloEncontrado descuentos size equals: 2.
	self assert: (vueloEncontrado descuentos first) tipo equals: descuentoPorFecha.
	self assert: (vueloEncontrado descuentos second) tipo equals: descuentoPorTramo.
	
	
	! !


!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/11/2025 17:41:54'!
barcelona

	^ 'Barcelona'! !

!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/11/2025 17:41:48'!
ezeiza

	^ 'Ezeiza'! !


!AterrizarComTest methodsFor: 'costos' stamp: 'HAW 12/11/2025 17:43:14'!
costoDeAR100

	^ 1000*dollar! !

!AterrizarComTest methodsFor: 'costos' stamp: 'HAW 12/11/2025 18:13:46'!
costoDeAR101
	
	^900*dollar ! !

!AterrizarComTest methodsFor: 'costos' stamp: 'HAW 12/11/2025 17:49:04'!
costoDeIB300
	
	^1000*dollar! !

!AterrizarComTest methodsFor: 'costos' stamp: 'HAW 12/11/2025 18:24:59'!
costoDeIB301
	
	^900*dollar! !


!AterrizarComTest methodsFor: 'códigos' stamp: 'HAW 12/11/2025 17:53:23'!
códigoAR100

	^ 'AR100'! !

!AterrizarComTest methodsFor: 'códigos' stamp: 'HAW 12/11/2025 18:13:09'!
códigoAR101
	
	^'AR101'! !

!AterrizarComTest methodsFor: 'códigos' stamp: 'HAW 12/11/2025 17:53:32'!
códigoIB300

	^ 'IB300'! !

!AterrizarComTest methodsFor: 'códigos' stamp: 'HAW 12/11/2025 18:24:13'!
códigoIB301
	
	^'IB301'! !


!AterrizarComTest methodsFor: 'dias de semana' stamp: 'HAW 12/11/2025 17:48:29'!
deLunesAViernes
	
	^Monday to: Friday ! !

!AterrizarComTest methodsFor: 'dias de semana' stamp: 'HAW 12/11/2025 17:42:02'!
todosLosDíasDeSemana

	^ Monday to: Sunday! !


!AterrizarComTest methodsFor: 'contador de pasajeros' stamp: 'HAW 12/11/2025 18:03:53'!
disponibilidadPara: unaDefiniciónDeVuelo partiendoEn: unaFechaDePartida 
	
	^2! !


!AterrizarComTest methodsFor: 'duraciones' stamp: 'HAW 12/11/2025 17:43:02'!
duraciónDeAR100

	^ 12*hour! !

!AterrizarComTest methodsFor: 'duraciones' stamp: 'HAW 12/11/2025 18:13:36'!
duraciónDeAR101
	
	^12*hour ! !

!AterrizarComTest methodsFor: 'duraciones' stamp: 'HAW 12/11/2025 17:48:48'!
duraciónDeIB300
	
	^12*hour ! !

!AterrizarComTest methodsFor: 'duraciones' stamp: 'HAW 12/11/2025 18:24:41'!
duraciónDeIB301
	
	^12*hour ! !


!AterrizarComTest methodsFor: 'horas de partida' stamp: 'HAW 12/11/2025 17:42:52'!
horaDePartidaDeAR100

	^ 22:00! !

!AterrizarComTest methodsFor: 'horas de partida' stamp: 'HAW 12/11/2025 18:13:21'!
horaDePartidaDeAR101
	
	^14:00! !

!AterrizarComTest methodsFor: 'horas de partida' stamp: 'HAW 12/11/2025 17:48:38'!
horaDePartidaDeIB300
	
	^1:00! !

!AterrizarComTest methodsFor: 'horas de partida' stamp: 'HAW 12/11/2025 18:24:26'!
horaDePartidaDeIB301
	
	^14:00! !


!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/11/2025 17:53:44'!
vueloAR100

	^ DefiniciónDeVuelo 
		identificadoCon: self códigoAR100 
		desde: self ezeiza 
		a: self barcelona 
		partiendoLos: (self todosLosDíasDeSemana) 
		aLas: self horaDePartidaDeAR100 
		durante: self duraciónDeAR100
		conUnCostoDe: self costoDeAR100! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/11/2025 18:13:01'!
vueloAR101
	
	^ DefiniciónDeVuelo 
		identificadoCon: self códigoAR101
		desde: self barcelona 
		a: self ezeiza 
		partiendoLos: (self todosLosDíasDeSemana) 
		aLas: self horaDePartidaDeAR101 
		durante: self duraciónDeAR101
		conUnCostoDe: self costoDeAR101! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/11/2025 17:53:49'!
vueloIB300

	^ DefiniciónDeVuelo 
		identificadoCon: self códigoIB300 
		desde: self ezeiza 
		a: self barcelona 
		partiendoLos: self deLunesAViernes
		aLas: self horaDePartidaDeIB300 
		durante: self duraciónDeIB300
		conUnCostoDe: self costoDeIB300! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/11/2025 18:24:01'!
vueloIB301
	
	^ DefiniciónDeVuelo 
		identificadoCon: self códigoIB301
		desde: self barcelona 
		a: self ezeiza 
		partiendoLos: self deLunesAViernes 
		aLas: self horaDePartidaDeIB301
		durante: self duraciónDeIB301
		conUnCostoDe: self costoDeIB301! !
