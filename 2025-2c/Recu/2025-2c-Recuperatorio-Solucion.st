!SequenceableCollection methodsFor: '*2025-2C-Recuperatorio' stamp: 'HAW 12/8/2025 21:28:39'!
todasLasCombinaciones

	| combinaciones |
	
	combinaciones := OrderedCollection new.
	self recolectar: OrderedCollection new en: combinaciones conTramosRestantesDe: self.
	
	^combinaciones! !

!SequenceableCollection methodsFor: '*2025-2C-Recuperatorio' stamp: 'HAW 12/8/2025 21:29:56'!
recolectar: tramos en: todosLosTramos conTramosRestantesDe: vuelosPorTramosRestantes 
	
	| vuelosPorTramo |
	
	vuelosPorTramosRestantes ifEmpty: [ ^todosLosTramos add: tramos. ].
	
	vuelosPorTramo := vuelosPorTramosRestantes first.
	vuelosPorTramo do: [ :vueloDeUnTramo | | nuevosTramos | 
			nuevosTramos := tramos copy.
			nuevosTramos add: vueloDeUnTramo.
			self recolectar: nuevosTramos en: todosLosTramos conTramosRestantesDe: vuelosPorTramosRestantes allButFirst ]. ! !

!classDefinition: #BuscadorDeVuelos category: #'2025-2c-Recu'!
Object subclass: #BuscadorDeVuelos
	instanceVariableNames: 'definicionesDeVuelos contadorDeVuelos tiposDeDescuentos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!BuscadorDeVuelos methodsFor: 'initialization' stamp: 'HAW 12/9/2025 10:14:25'!
initializePara: unasDefinicionesDeVuelos obteniendoDisponibilidadDeAsientosCon: unContadorDeVuelos descuentos: unosTiposDeDescuentos
	
	definicionesDeVuelos := unasDefinicionesDeVuelos.
	contadorDeVuelos := unContadorDeVuelos.
	tiposDeDescuentos := unosTiposDeDescuentos ! !


!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/9/2025 17:54:39'!
vuelosDe: unOrigen a: unDestino partiendoEl: unaFechaDePartida conCantidadDePasajeros: unaCantidadDePasajeros 
	
	^self 
		vuelosPara: (OpcionesDeTramo de: unOrigen a: unDestino partiendoEl: unaFechaDePartida)
		conCantidadDePasajeros: unaCantidadDePasajeros 
	! !

!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/9/2025 17:54:39'!
vuelosDe: unOrigen a: unDestino partiendoEl: unaFechaDePartida regresandoEl: unaFechaDeRegreso conCantidadDePasajeros: unaCantidadDePasajeros 
	
	^self 
		vuelosMultitramoCon: {
			OpcionesDeTramo de: unOrigen a: unDestino partiendoEl: unaFechaDePartida.
			OpcionesDeTramo de: unDestino a: unOrigen partiendoEl: unaFechaDeRegreso }  
		conCantidadDePasajeros: unaCantidadDePasajeros ! !

!BuscadorDeVuelos methodsFor: 'búsqueda' stamp: 'HAW 12/9/2025 09:08:49'!
vuelosMultitramoCon: unasOpcionesDeBúsqueda conCantidadDePasajeros: unaCantidadDePasajeros  
	
	| todosLosVuelosPorTramos | 
	
	todosLosVuelosPorTramos := unasOpcionesDeBúsqueda collect: [ :unaOpciónDeBusqueda | 
		self vuelosPara: unaOpciónDeBusqueda conCantidadDePasajeros: unaCantidadDePasajeros ].
	
	^todosLosVuelosPorTramos todasLasCombinaciones 
		select: [ :tramos | self esPartidaPosteriorALlegadaEn: tramos ]
		thenCollect: [ :tramos | VueloMultitramos tramos: tramos ]! !


!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/9/2025 18:02:03'!
buscarVuelosPara: unaOpciónDeBusqueda con: unaCantidadDePasajeros 

	^ definicionesDeVuelos 
		select: [ :unaDefiniciónDeVuelo | unaOpciónDeBusqueda satisface: unaDefiniciónDeVuelo ]
		thenCollect: [ :unaDefiniciónDeVuelo | 
			VueloDeIda 
				definidoPor: unaDefiniciónDeVuelo 
				partiendoEl: unaOpciónDeBusqueda fechaDePartida 
				con: unaCantidadDePasajeros ]! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/9/2025 10:44:05'!
calcularDescuentosEn: vuelosEncontrados

	^ vuelosEncontrados do: [ :unVuelo | self calcularDescuentosPara: unVuelo ]! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/9/2025 10:40:34'!
esPartidaPosteriorALlegadaEn: tramos 
	
	tramos
		inject: GregorianDateTime theBeginningOfTime 
		into: [ :llegadaAnterior :vueloActual |
			llegadaAnterior >= vueloActual partida ifTrue: [ ^false ].
			vueloActual llegada ].
		
	^true! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/9/2025 18:19:26'!
filtrarPorDiponibilidadDeAsientos: vuelosEncontrados 

	^ vuelosEncontrados select: [ :unVuelo | self hayDisponibilidadDeAsientosEn: unVuelo ]! !

!BuscadorDeVuelos methodsFor: 'búsqueda - private' stamp: 'HAW 12/9/2025 18:19:34'!
vuelosPara: unaOpciónDeBusqueda conCantidadDePasajeros: unaCantidadDePasajeros

	| vuelosEncontrados |
	
	vuelosEncontrados  := self buscarVuelosPara: unaOpciónDeBusqueda con: unaCantidadDePasajeros.
	vuelosEncontrados := self filtrarPorDiponibilidadDeAsientos: vuelosEncontrados.
	self calcularDescuentosEn: vuelosEncontrados.
	
	^vuelosEncontrados  ! !


!BuscadorDeVuelos methodsFor: 'descuentos' stamp: 'HAW 12/9/2025 18:19:58'!
calcularDescuentosPara: unVuelo 
	
	| descuentos |
	
	descuentos := tiposDeDescuentos 
		select: [ :unTipoDeDescuento | unTipoDeDescuento aplicaA: unVuelo ]
		thenCollect: [ :unTipoDeDescuento | Descuento de: unTipoDeDescuento para: unVuelo ].
		
	unVuelo agregarDescuentos: descuentos
	! !


!BuscadorDeVuelos methodsFor: 'verificación de lugar' stamp: 'HAW 12/9/2025 18:18:27'!
hayDisponibilidadDeAsientosEn: unVueloEncontrado 
	
	^unVueloEncontrado estáDisponiblePara: (contadorDeVuelos asientosRemanentesPara: unVueloEncontrado) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BuscadorDeVuelos class' category: #'2025-2c-Recu'!
BuscadorDeVuelos class
	instanceVariableNames: ''!

!BuscadorDeVuelos class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 10:14:03'!
para: unasDefinicionesDeVuelos obteniendoDisponibilidadDeAsientosCon: unContadorDeVuelos  
	
	^self 
		para: unasDefinicionesDeVuelos 
		obteniendoDisponibilidadDeAsientosCon: unContadorDeVuelos 
		descuentos: #()! !

!BuscadorDeVuelos class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 10:13:44'!
para: unasDefinicionesDeVuelos obteniendoDisponibilidadDeAsientosCon: unContadorDeVuelos descuentos: unosTiposDeDescuentos
	
	^self new 
		initializePara: unasDefinicionesDeVuelos 
		obteniendoDisponibilidadDeAsientosCon: unContadorDeVuelos 
		descuentos: unosTiposDeDescuentos! !


!classDefinition: #DefiniciónDeVuelo category: #'2025-2c-Recu'!
Object subclass: #DefiniciónDeVuelo
	instanceVariableNames: 'código origen destino díasDeVuelo horaDePartida duración costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DefiniciónDeVuelo methodsFor: 'initialization' stamp: 'HAW 12/8/2025 18:05:43'!
initializeIdentificadoCon: unCódigo desde: unOrigen a: unDestino volandoLos: unosDíasDeVuelo aLas: unaHoraDePartida conDuraciónDe: unaDuración yCostoDe: unCosto 
	
	código := unCódigo.
	origen := unOrigen.
	destino := unDestino.
	díasDeVuelo := unosDíasDeVuelo.
	horaDePartida := unaHoraDePartida.
	duración := unaDuración.
	costo := unCosto.! !


!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:13:54'!
costo
	
	^costo! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:36:39'!
código
	
	^código! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:09:29'!
destino
	
	^destino! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:13:37'!
duración
	
	^duración! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:12:55'!
horaDePartida
	
	^horaDePartida! !

!DefiniciónDeVuelo methodsFor: 'accessing' stamp: 'HAW 12/8/2025 18:09:24'!
origen
	
	^origen! !


!DefiniciónDeVuelo methodsFor: 'búsqueda' stamp: 'HAW 12/8/2025 18:23:24'!
saleDesde: unOrigen a: unDestino partiendoEl: unaFechaDePartida 
	
	^origen = unOrigen 
		and: [ destino = unDestino
		and: [ díasDeVuelo includes: unaFechaDePartida day ] ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DefiniciónDeVuelo class' category: #'2025-2c-Recu'!
DefiniciónDeVuelo class
	instanceVariableNames: ''!

!DefiniciónDeVuelo class methodsFor: 'instance creation' stamp: 'HAW 12/8/2025 18:05:35'!
identificadoCon: unCódigo desde: unOrigen a: unDestino volandoLos: unosDíasDeVuelo aLas: unaHoraDePartida conDuraciónDe: unaDuración yCostoDe: unCosto 
	
	^self new initializeIdentificadoCon: unCódigo desde: unOrigen a: unDestino volandoLos: unosDíasDeVuelo aLas: unaHoraDePartida conDuraciónDe: unaDuración yCostoDe: unCosto ! !


!classDefinition: #Descuento category: #'2025-2c-Recu'!
Object subclass: #Descuento
	instanceVariableNames: 'tipo vuelo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!Descuento methodsFor: 'initialization' stamp: 'HAW 12/9/2025 10:21:31'!
initializeDe: unTipoDeDescuento para: unVuelo 
	
	tipo := unTipoDeDescuento.
	vuelo := unVuelo.! !


!Descuento methodsFor: 'tipo' stamp: 'HAW 12/9/2025 10:21:31'!
tipo
	
	^tipo ! !


!Descuento methodsFor: 'valor' stamp: 'HAW 12/9/2025 10:21:31'!
valor
	
	^tipo aplicarA: vuelo costoBruto ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Descuento class' category: #'2025-2c-Recu'!
Descuento class
	instanceVariableNames: ''!

!Descuento class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 10:18:19'!
de: unTipoDeDescuento para: unVuelo 
	
	^self new initializeDe: unTipoDeDescuento para: unVuelo ! !


!classDefinition: #OpcionesDeTramo category: #'2025-2c-Recu'!
Object subclass: #OpcionesDeTramo
	instanceVariableNames: 'origen destino fechaDePartida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!OpcionesDeTramo methodsFor: 'initialization' stamp: 'HAW 12/8/2025 19:46:33'!
initializeDesde: unOrigen a: unDestino partiendoEl: unaFechaDePartida 
	
	origen := unOrigen.
	destino := unDestino.
	fechaDePartida := unaFechaDePartida.! !


!OpcionesDeTramo methodsFor: 'fecha' stamp: 'HAW 12/8/2025 19:55:53'!
fechaDePartida
	
	^fechaDePartida! !


!OpcionesDeTramo methodsFor: 'búsqueda' stamp: 'HAW 12/8/2025 19:55:45'!
satisface: unaDefiniciónDeVuelo 
	
	^unaDefiniciónDeVuelo saleDesde: origen a: destino  partiendoEl: fechaDePartida ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OpcionesDeTramo class' category: #'2025-2c-Recu'!
OpcionesDeTramo class
	instanceVariableNames: ''!

!OpcionesDeTramo class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 17:54:39'!
de: unOrigen a: unDestino partiendoEl: unaFechaDePartida 
	
	^self new initializeDesde: unOrigen a: unDestino partiendoEl: unaFechaDePartida ! !


!classDefinition: #TipoDeDescuento category: #'2025-2c-Recu'!
Object subclass: #TipoDeDescuento
	instanceVariableNames: 'porcentaje'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!TipoDeDescuento methodsFor: 'aplicación' stamp: 'HAW 12/9/2025 10:34:14'!
aplicarA: unValor

	^unValor * porcentaje ! !


!TipoDeDescuento methodsFor: 'testing' stamp: 'HAW 12/9/2025 10:34:24'!
aplicaA: unVuelo

	self subclassResponsibility! !


!classDefinition: #DescuentoPorFecha category: #'2025-2c-Recu'!
TipoDeDescuento subclass: #DescuentoPorFecha
	instanceVariableNames: 'fechaDePartida'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DescuentoPorFecha methodsFor: 'initialization' stamp: 'HAW 12/9/2025 10:28:46'!
initializeDe: unPorcentaje para: unaFechaDePartida 
	
	porcentaje := unPorcentaje.
	fechaDePartida := unaFechaDePartida.! !


!DescuentoPorFecha methodsFor: 'testing' stamp: 'HAW 12/9/2025 10:30:46'!
aplicaA: unVuelo 
	
	^fechaDePartida = unVuelo partida date! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorFecha class' category: #'2025-2c-Recu'!
DescuentoPorFecha class
	instanceVariableNames: ''!

!DescuentoPorFecha class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 10:28:40'!
de: unPorcentaje para: unaFechaDePartida 
	
	^self new initializeDe: unPorcentaje para: unaFechaDePartida ! !


!classDefinition: #DescuentoPorTramo category: #'2025-2c-Recu'!
TipoDeDescuento subclass: #DescuentoPorTramo
	instanceVariableNames: 'origen destino'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!DescuentoPorTramo methodsFor: 'initialization' stamp: 'HAW 12/9/2025 10:13:04'!
initializeDe: unPorcentaje desde: unOrigen a: unDestino 
	
	porcentaje := unPorcentaje.
	origen := unOrigen.
	destino := unDestino.! !


!DescuentoPorTramo methodsFor: 'testing' stamp: 'HAW 12/9/2025 10:25:33'!
aplicaA: unVuelo 
	
	^origen = unVuelo origen and: [ destino = unVuelo destino ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DescuentoPorTramo class' category: #'2025-2c-Recu'!
DescuentoPorTramo class
	instanceVariableNames: ''!

!DescuentoPorTramo class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 10:12:58'!
de: unPorcentaje desde: unOrigen a: unDestino 
	
	^self new initializeDe: unPorcentaje desde: unOrigen a: unDestino ! !


!classDefinition: #Vuelo category: #'2025-2c-Recu'!
Object subclass: #Vuelo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:59:42'!
costoBruto

	self subclassResponsibility! !

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:59:47'!
costoNeto

	self subclassResponsibility! !

!Vuelo methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:59:54'!
descuentos

	self subclassResponsibility! !


!Vuelo methodsFor: 'destino' stamp: 'HAW 12/9/2025 10:59:59'!
destino

	self subclassResponsibility! !

!Vuelo methodsFor: 'destino' stamp: 'HAW 12/9/2025 11:00:03'!
duración

	self subclassResponsibility! !

!Vuelo methodsFor: 'destino' stamp: 'HAW 12/9/2025 11:00:15'!
llegada

	self subclassResponsibility! !


!Vuelo methodsFor: 'origen' stamp: 'HAW 12/9/2025 11:00:20'!
origen

	self subclassResponsibility! !

!Vuelo methodsFor: 'origen' stamp: 'HAW 12/9/2025 11:00:26'!
partida

	self subclassResponsibility! !


!classDefinition: #VueloDeIda category: #'2025-2c-Recu'!
Vuelo subclass: #VueloDeIda
	instanceVariableNames: 'definiciónDeVuelo fechaDePartida descuentos cantidadDePasajeros'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!VueloDeIda methodsFor: 'initialization' stamp: 'HAW 12/9/2025 18:02:36'!
initializeDefinidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros  
	
	definiciónDeVuelo := unaDefiniciónDeVuelo.
	fechaDePartida := unaFechaDePartida.
	cantidadDePasajeros := unaCantidadDePasajeros.
	descuentos := OrderedCollection new.! !


!VueloDeIda methodsFor: 'código' stamp: 'HAW 12/8/2025 18:36:33'!
código
	
	^definiciónDeVuelo código! !


!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:33:25'!
agregarDescuentos: unosDescuentos 
	
	descuentos addAll: unosDescuentos ! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/9/2025 18:03:02'!
costoBruto
	
	^definiciónDeVuelo costo * cantidadDePasajeros ! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:22:04'!
costoNeto
	
	^self costoBruto - (descuentos sum: [ :unDescuento | unDescuento valor ] ifEmpty: [0])! !

!VueloDeIda methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:21:07'!
descuentos
	
	^descuentos copy! !


!VueloDeIda methodsFor: 'origen' stamp: 'HAW 12/8/2025 18:11:55'!
origen
	
	^definiciónDeVuelo origen ! !

!VueloDeIda methodsFor: 'origen' stamp: 'HAW 12/8/2025 18:12:49'!
partida
	
	^fechaDePartida at: definiciónDeVuelo horaDePartida! !


!VueloDeIda methodsFor: 'destino' stamp: 'HAW 12/8/2025 18:12:08'!
destino
	
	^definiciónDeVuelo destino ! !

!VueloDeIda methodsFor: 'destino' stamp: 'HAW 12/8/2025 18:13:28'!
duración
	
	^definiciónDeVuelo duración ! !

!VueloDeIda methodsFor: 'destino' stamp: 'HAW 12/8/2025 18:13:18'!
llegada
	
	^self partida next: self duración! !


!VueloDeIda methodsFor: 'printing' stamp: 'HAW 12/9/2025 09:18:35'!
printOn: aStream

	aStream nextPutAll: self código! !


!VueloDeIda methodsFor: 'cantidad de pasajeros' stamp: 'HAW 12/9/2025 18:16:28'!
estáDisponiblePara: unaCantidadDeAsientosDisponibles

	^unaCantidadDeAsientosDisponibles >= cantidadDePasajeros ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloDeIda class' category: #'2025-2c-Recu'!
VueloDeIda class
	instanceVariableNames: ''!

!VueloDeIda class methodsFor: 'instance creation' stamp: 'HAW 12/9/2025 18:02:22'!
definidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros  
	
	^self new initializeDefinidoPor: unaDefiniciónDeVuelo partiendoEl: unaFechaDePartida con: unaCantidadDePasajeros ! !


!classDefinition: #VueloMultitramos category: #'2025-2c-Recu'!
Vuelo subclass: #VueloMultitramos
	instanceVariableNames: 'tramos'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!VueloMultitramos methodsFor: 'initialization' stamp: 'HAW 12/8/2025 19:59:38'!
initializeTramos: unoTramos 
	
	tramos := unoTramos.! !


!VueloMultitramos methodsFor: 'tramos' stamp: 'HAW 12/8/2025 19:59:47'!
cantidadDeTramos
	
	^tramos size! !

!VueloMultitramos methodsFor: 'tramos' stamp: 'HAW 12/9/2025 11:02:58'!
codigoDeVueloDeIda
	
	^self códigoDeTramo: 1! !

!VueloMultitramos methodsFor: 'tramos' stamp: 'HAW 12/9/2025 11:03:10'!
codigoDeVueloDeVuelta
	
	^self códigoDeTramo: tramos size! !

!VueloMultitramos methodsFor: 'tramos' stamp: 'HAW 12/9/2025 09:00:44'!
códigoDeTramo: unNúmeroDeTramo

	^(tramos at: unNúmeroDeTramo) código! !


!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/8/2025 20:01:13'!
costoBruto
	
	^tramos sum: [ :unTramo | unTramo costoBruto ]! !

!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/8/2025 20:01:28'!
costoNeto
	
	^tramos sum: [ :unTramo | unTramo costoNeto ]! !

!VueloMultitramos methodsFor: 'costo' stamp: 'HAW 12/9/2025 10:56:44'!
descuentos
	
	^(tramos collect: [ :unVuelo | unVuelo descuentos ]) flatten ! !


!VueloMultitramos methodsFor: 'destino' stamp: 'HAW 12/8/2025 20:00:35'!
destino
	
	^tramos last destino! !

!VueloMultitramos methodsFor: 'destino' stamp: 'HAW 12/8/2025 20:00:53'!
llegada
	
	^tramos last llegada! !


!VueloMultitramos methodsFor: 'origen' stamp: 'HAW 12/8/2025 20:00:25'!
origen
	
	^tramos first origen! !

!VueloMultitramos methodsFor: 'origen' stamp: 'HAW 12/8/2025 20:00:44'!
partida
	
	^tramos first partida ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'VueloMultitramos class' category: #'2025-2c-Recu'!
VueloMultitramos class
	instanceVariableNames: ''!

!VueloMultitramos class methodsFor: 'instance creation' stamp: 'HAW 12/8/2025 19:59:25'!
tramos: unoTramos 
	
	^self new initializeTramos: unoTramos ! !


!classDefinition: #AterrizarComTest category: #'2025-2c-Recu'!
TestCase subclass: #AterrizarComTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 08:27:31'!
test01NoSeEncuentranVuelosCuandoNoHayDefinicionesDeVuelos

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: {} obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: December / 9 / 2025 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty.! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 18:04:45'!
test02EncuentraUnVueloDeIdaCuandoCoincideLaBúsqueda

	| buscador vuelosEncontrados vuelo fechaDePartida vueloABarcelonaAR100 cantidadDePasajeros |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	buscador := BuscadorDeVuelos para: { vueloABarcelonaAR100 } obteniendoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: fechaDePartida 
		conCantidadDePasajeros: cantidadDePasajeros.

	self assert: vuelosEncontrados size equals: 1.
	
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo origen equals: self ezeiza.
	self assert: vuelo destino equals: self barcelona.
	self assert: vuelo partida equals: (fechaDePartida at: vueloABarcelonaAR100 horaDePartida).
	self assert: vuelo llegada equals: (vuelo partida next: vueloABarcelonaAR100 duración).
	self assert: vuelo costoBruto equals: vueloABarcelonaAR100 costo * cantidadDePasajeros.
	self assert: vuelo costoNeto equals: vuelo costoBruto.
	self assert: vuelo descuentos isEmpty.
	
	
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 08:28:59'!
test03NoEncuentraVueloCuandoElOrigenEsDistinto

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: { self vueloDeEzeizaABarcelonaAR100 } obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: 'Aeroparque' 
		a: self barcelona 
		partiendoEl: December / 9 / 2025 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 08:29:15'!
test04NoEncuentraVueloCuandoElDestinoEsDistinto

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: { self vueloDeEzeizaABarcelonaAR100 } obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: 'Aeroparque' 
		partiendoEl: December / 9 / 2025 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 08:29:49'!
test05NoEncuentraVueloCuandoNoVuelaEnLaFechaPedida

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: { self vueloDeMadridAParisIB503 } obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self madrid 
		a: self parís 
		partiendoEl: December / 7 / 2025 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 08:30:05'!
test06NoEncuentraVuelosCuandoNoHayLugar

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos para: { self vueloDeMadridAParisIB503 } obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self madrid 
		a: self parís 
		partiendoEl: December / 9 / 2025 
		conCantidadDePasajeros: 11.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:53:59'!
test07SeEncuentraVueloDeIdaYVuelta

	| buscador vuelosEncontrados vuelo fechaDePartida fechaDeRegreso vueloABarcelonaAR100 vueloAEzeizaAR101 |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	vueloAEzeizaAR101 := self vueloDeBarcelonaAEzeizaAR101.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100. vueloAEzeizaAR101 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 19 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: fechaDePartida 
		regresandoEl: fechaDeRegreso 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo origen equals: self ezeiza.
	self assert: vuelo destino equals: self ezeiza.
	self assert: vuelo partida equals: (fechaDePartida at: vueloABarcelonaAR100 horaDePartida).
	self assert: vuelo llegada equals: ((fechaDeRegreso at: vueloAEzeizaAR101 horaDePartida) next: vueloAEzeizaAR101 duración).
	self assert: vuelo costoBruto equals: vueloABarcelonaAR100 costo + vueloAEzeizaAR101 costo.
	self assert: vuelo costoNeto equals: vuelo costoBruto.
	self assert: vuelo descuentos isEmpty.
	
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:53:59'!
test08NoEncuentraVueloDeIdaYVueltaSiNoHayIda

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso vueloAEzeizaAR101 |
	
	vueloAEzeizaAR101 := self vueloDeBarcelonaAEzeizaAR101.
	buscador := BuscadorDeVuelos 
		para: { vueloAEzeizaAR101 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 19 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: fechaDePartida 
		regresandoEl: fechaDeRegreso 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:53:59'!
test09NoEncuentraVueloDeIdaYVueltaSiNoHayVuelta

	| buscador vuelosEncontrados fechaDePartida fechaDeRegreso vueloABarcelonaAR100 |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	fechaDePartida := December / 9 / 2025.
	fechaDeRegreso := December / 19 / 2025.
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: fechaDePartida 
		regresandoEl: fechaDeRegreso 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados isEmpty
	
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:53:59'!
test10SeEncuentraVuelosDeIdaYVueltaCombinandoVuelos

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloDeEzeizaABarcelonaAR100. self vueloDeBarcelonaAEzeizaAR101. self vueloDeBarcelonaAEzeizaIB301}
		obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosDe: self ezeiza 
		a: self barcelona 
		partiendoEl: December / 9 / 2025 
		regresandoEl: December / 19 / 2025 
		conCantidadDePasajeros: 1.

	self assert: vuelosEncontrados size equals: 2.
	self assert: (vuelosEncontrados allSatisfy: [ :unVuelo | unVuelo codigoDeVueloDeIda = self códigoAR100]).
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo codigoDeVueloDeVuelta = self códigoAR101]).
	self assert: (vuelosEncontrados anySatisfy: [ :unVuelo | unVuelo codigoDeVueloDeVuelta = self códigoIB301]).
	
	
	
	
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test11SePuedeBuscarMásDeDosTramos

	| buscador vuelosEncontrados vuelo |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloDeEzeizaABarcelonaAR100. 
			self vueloDeBarcelonaAEzeizaAR101. 
			self vueloDeMadridAParisIB503 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosMultitramoCon: {
			OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl:  December / 9 / 2025.
			OpcionesDeTramo de: self madrid a: self parís partiendoEl:  December / 11 / 2025.
			OpcionesDeTramo de: self barcelona a: self ezeiza partiendoEl: December / 12 / 2025.} 
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo cantidadDeTramos equals: 3.
	self assert: (vuelo códigoDeTramo: 1) equals: self códigoAR100.
	self assert: (vuelo códigoDeTramo: 2) equals: self códigoIB503.
	self assert: (vuelo códigoDeTramo: 3) equals: self códigoAR101.
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test12NoEncuentraVuelosSiNoHayAlgúnTramo

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloDeEzeizaABarcelonaAR100. 
			self vueloDeBarcelonaAEzeizaAR101 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosMultitramoCon: {
			OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl:  December / 9 / 2025.
			OpcionesDeTramo de: self madrid a: self parís partiendoEl:  December / 10 / 2025.
			OpcionesDeTramo de: self barcelona a: self ezeiza partiendoEl: December / 11 / 2025.} 
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados isEmpty
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test13PartidaDeUnTramosDebeSerPosteriorALlegadaDeTramoAnterior

	| buscador vuelosEncontrados |
	
	buscador := BuscadorDeVuelos 
		para: { self vueloDeEzeizaABarcelonaAR100. 
			self vueloDeBarcelonaAEzeizaAR101. 
			self vueloDeMadridAParisIB503 } 
		obteniendoDisponibilidadDeAsientosCon: self.
	
	vuelosEncontrados := buscador 
		vuelosMultitramoCon: {
			OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl:  December / 9 / 2025.
			OpcionesDeTramo de: self madrid a: self parís partiendoEl:  December / 9 / 2025.
			OpcionesDeTramo de: self barcelona a: self ezeiza partiendoEl: December / 11 / 2025.} 
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados isEmpty
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 18:05:43'!
test14AplicaDescuentoPorTramo

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuento descuentoEzeizaBarcelona porcentajeDeDescuento cantidadDePasajeros |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	porcentajeDeDescuento := 10/100.
	descuentoEzeizaBarcelona := DescuentoPorTramo de: porcentajeDeDescuento desde: self ezeiza a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona }.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosPara: (OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: December / 9 / 2025)
		conCantidadDePasajeros: cantidadDePasajeros.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo costoBruto equals: vueloABarcelonaAR100 costo * cantidadDePasajeros.
	self assert: vuelo costoNeto equals: vuelo costoBruto * (1-porcentajeDeDescuento).
	self assert: vuelo descuentos size equals: 1.
	descuento := vuelo descuentos anyOne.
	self assert: descuento tipo equals: descuentoEzeizaBarcelona.
	self assert: descuento valor equals: vuelo costoBruto * porcentajeDeDescuento 
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test15NoAplicaDescuentoPorTramoCuandoOrigenEsDistinto

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuentoEzeizaBarcelona porcentajeDeDescuento |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	porcentajeDeDescuento := 10/100.
	descuentoEzeizaBarcelona := DescuentoPorTramo de: porcentajeDeDescuento desde: 'Aeroparque' a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona }.
	
	vuelosEncontrados := buscador 
		vuelosPara: (OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: December / 9 / 2025)
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo descuentos isEmpty 
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test16NoAplicaDescuentoPorTramoCuandoElDestinoEsDistinto

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuentoEzeizaBarcelona porcentajeDeDescuento |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	porcentajeDeDescuento := 10/100.
	descuentoEzeizaBarcelona := DescuentoPorTramo de: porcentajeDeDescuento desde: self ezeiza a: 'Aeroparque'.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona }.
	
	vuelosEncontrados := buscador 
		vuelosPara: (OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: December / 9 / 2025)
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo descuentos isEmpty 
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 18:09:02'!
test17AplicaDescuentoPorFecha

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuento descuentoEzeizaBarcelona porcentajeDeDescuento fechaDeDescuento cantidadDePasajeros |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	porcentajeDeDescuento := 10/100.
	fechaDeDescuento := December / 9 / 2025.
	descuentoEzeizaBarcelona := DescuentoPorFecha de: porcentajeDeDescuento para: fechaDeDescuento.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona }.
	
	cantidadDePasajeros := 2.
	vuelosEncontrados := buscador 
		vuelosPara: (OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: fechaDeDescuento)
		conCantidadDePasajeros: cantidadDePasajeros.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo costoBruto equals: vueloABarcelonaAR100 costo * cantidadDePasajeros.
	self assert: vuelo costoNeto equals: vuelo costoBruto * (1-porcentajeDeDescuento).
	self assert: vuelo descuentos size equals: 1.
	descuento := vuelo descuentos anyOne.
	self assert: descuento tipo equals: descuentoEzeizaBarcelona.
	self assert: descuento valor equals: vuelo costoBruto * porcentajeDeDescuento 
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test18NoAplicaDescuentoPorFechaParaOtraFechaDePartida

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuentoEzeizaBarcelona porcentajeDeDescuento fechaDeDescuento |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	porcentajeDeDescuento := 10/100.
	fechaDeDescuento := December / 9 / 2025.
	descuentoEzeizaBarcelona := DescuentoPorFecha de: porcentajeDeDescuento para: fechaDeDescuento.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona }.
	
	vuelosEncontrados := buscador 
		vuelosPara: (OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: fechaDeDescuento next)
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo descuentos isEmpty
	! !

!AterrizarComTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 17:54:39'!
test19AplicaDescuentoAVulosMultitramos

	| buscador vuelosEncontrados vuelo vueloABarcelonaAR100 descuentoEzeizaBarcelona porcentajeDeDescuentoPorTramo fechaDeDescuento descuentoPorFecha porcentajeDeDescuentoPorFecha vueloAEzeizaAR101 |
	
	vueloABarcelonaAR100 := self vueloDeEzeizaABarcelonaAR100.
	vueloAEzeizaAR101 := self vueloDeBarcelonaAEzeizaAR101.
	porcentajeDeDescuentoPorTramo := 10/100.
	porcentajeDeDescuentoPorFecha := 5/100.
	fechaDeDescuento := December / 9 / 2025.
	descuentoPorFecha := DescuentoPorFecha de: porcentajeDeDescuentoPorFecha para: fechaDeDescuento.
	descuentoEzeizaBarcelona := DescuentoPorTramo de: porcentajeDeDescuentoPorTramo desde: self ezeiza a: self barcelona.
	buscador := BuscadorDeVuelos 
		para: { vueloABarcelonaAR100. vueloAEzeizaAR101 } 
		obteniendoDisponibilidadDeAsientosCon: self
		descuentos: { descuentoEzeizaBarcelona. descuentoPorFecha }.
	
	vuelosEncontrados := buscador    
		vuelosMultitramoCon: {
			OpcionesDeTramo de: self ezeiza a: self barcelona partiendoEl: fechaDeDescuento previous.
			OpcionesDeTramo de: self barcelona a: self ezeiza partiendoEl: fechaDeDescuento }
		conCantidadDePasajeros: 1.
		
	self assert: vuelosEncontrados size equals: 1.
	vuelo := vuelosEncontrados anyOne.
	self assert: vuelo descuentos size equals: 2.
	self assert: vuelo costoNeto equals: vuelo costoBruto 
		- (vueloABarcelonaAR100 costo * porcentajeDeDescuentoPorTramo) 
		- (vueloAEzeizaAR101 costo * porcentajeDeDescuentoPorFecha) 
		
	! !


!AterrizarComTest methodsFor: 'dias de semana' stamp: 'HAW 12/8/2025 18:22:33'!
lunesAViernes
	
	^Monday to: Friday ! !

!AterrizarComTest methodsFor: 'dias de semana' stamp: 'HAW 12/8/2025 18:16:18'!
todosLosDíasDeSemana

	^ Monday to: Sunday! !


!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 08:51:00'!
códigoAR100

	^ 'AR100'! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 08:51:10'!
códigoAR101

	^ 'AR101'! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 08:51:26'!
códigoIB301

	^ 'IB301'! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 08:59:56'!
códigoIB503

	^ 'IB503'! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 11:16:01'!
vueloDeBarcelonaAEzeizaAR101
	
	^ DefiniciónDeVuelo 
		identificadoCon: self códigoAR101 
		desde: self barcelona 
		a: self ezeiza 
		volandoLos: self todosLosDíasDeSemana 
		aLas: 14:00 
		conDuraciónDe: 12*hour 
		yCostoDe: 900*dollar! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 11:16:17'!
vueloDeBarcelonaAEzeizaIB301
	
	^ DefiniciónDeVuelo 
		identificadoCon: self códigoIB301 
		desde: self barcelona 
		a: self ezeiza 
		volandoLos: self todosLosDíasDeSemana 
		aLas: 14:00 
		conDuraciónDe: 12*hour 
		yCostoDe: 900*dollar! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 11:16:32'!
vueloDeEzeizaABarcelonaAR100

	^ DefiniciónDeVuelo 
		identificadoCon: self códigoAR100 
		desde: self ezeiza 
		a: self barcelona 
		volandoLos: self todosLosDíasDeSemana
		aLas: 22:00 
		conDuraciónDe: 12*hour 
		yCostoDe: 1000*dollar! !

!AterrizarComTest methodsFor: 'vuelos' stamp: 'HAW 12/9/2025 11:16:49'!
vueloDeMadridAParisIB503
	
	^ DefiniciónDeVuelo 
		identificadoCon: self códigoIB503 
		desde: self madrid 
		a: self parís 
		volandoLos: self lunesAViernes 
		aLas: 6:00 
		conDuraciónDe: 1.5*hour 
		yCostoDe: 300*dollar! !


!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/8/2025 18:16:08'!
barcelona

	^ 'Barcelona'! !

!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/8/2025 18:16:01'!
ezeiza

	^ 'Ezeiza'! !

!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/8/2025 18:22:09'!
madrid
	
	^'Madrid'! !

!AterrizarComTest methodsFor: 'aeropuertos' stamp: 'HAW 12/8/2025 18:22:19'!
parís
	
	^'París'! !


!AterrizarComTest methodsFor: 'asientos remanentes' stamp: 'HAW 12/8/2025 18:28:11'!
asientosRemanentesPara: unVueloEncontrado 
	
	^10! !


!classDefinition: #TodasLasCombinacionesTest category: #'2025-2c-Recu'!
TestCase subclass: #TodasLasCombinacionesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2c-Recu'!

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 11:30:10'!
test01ParaUnaColecciónDeUnElemento

	self 
		assert: (OrderedCollection with: #(1)) todasLasCombinaciones 
		equals: (OrderedCollection with: (OrderedCollection with: 1))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 11:30:14'!
test02ParaUnaColecciónDeMásDeUnElemento

	self 
		assert: (OrderedCollection with: #(1 2)) todasLasCombinaciones 
		equals: (OrderedCollection with: (OrderedCollection with: 1) with: (OrderedCollection with: 2))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 11:30:28'!
test03ParaDosColeccionesDeDosYUnElemento

	self 
		assert: (OrderedCollection with: #(1 2) with: #(3)) todasLasCombinaciones 
		equals: (OrderedCollection 
			with: (OrderedCollection with: 1 with: 3) 
			with: (OrderedCollection with: 2 with: 3))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 11:30:42'!
test04ParaDosColeccionesDeMásDeUnElemento

	self 
		assert: (OrderedCollection with: #(1 2) with: #(3 4)) todasLasCombinaciones 
		equals: (OrderedCollection 
			with: (OrderedCollection with: 1 with: 3) 
			with: (OrderedCollection with: 1 with: 4)
			with: (OrderedCollection with: 2 with: 3)
			with: (OrderedCollection with: 2 with: 4))! !

!TodasLasCombinacionesTest methodsFor: 'tests' stamp: 'HAW 12/9/2025 11:30:54'!
test05CuandoHayUnaColecciónVacía

	self assert: (OrderedCollection with: #(1 2) with: #() with: #(3 4)) todasLasCombinaciones isEmpty! !
