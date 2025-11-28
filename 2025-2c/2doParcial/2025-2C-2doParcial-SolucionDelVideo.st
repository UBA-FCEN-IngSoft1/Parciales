!classDefinition: #LectorDeTarjeta category: #'2doParcial'!
Object subclass: #LectorDeTarjeta
	instanceVariableNames: 'medioDeTransporte reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!LectorDeTarjeta methodsFor: 'initialization' stamp: 'HAW 11/27/2025 15:38:59'!
initializePara: unaLineaDeColectivo tomandoHoraDe: unReloj 
	
	medioDeTransporte := unaLineaDeColectivo.
	reloj := unReloj.! !


!LectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:29:32'!
ahora
	
	^reloj ahora! !

!LectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:19:23'!
assertDesde: unOrigen distintoDeHasta: unDestino 
	
	unOrigen = unDestino ifTrue: [ self error: self class paradaOrigenDebeSerDistantaADestinoDescripciónDeError ]! !

!LectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:38:59'!
assertEsCabecera: unaCabecera

	^ (medioDeTransporte esCabecera: unaCabecera) ifFalse: [ self error: self class direcciónDebeSerACabeceraDescripciónDeError ]! !

!LectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:23:15'!
cobrarCon: unaTarjeta desde: unOrigen hasta: unDestino 
	
	| costo |
	
	self assertDesde: unOrigen distintoDeHasta: unDestino.
	
	costo := self costoDesde: unOrigen hasta: unDestino.
	unaTarjeta en: self ahora cobrar: costo desde: unOrigen hasta: unDestino! !

!LectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:38:59'!
costoDesde: unOrigen hasta: unDestino 
	
	^medioDeTransporte costoDesde: unOrigen hasta: unDestino ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LectorDeTarjeta class' category: #'2doParcial'!
LectorDeTarjeta class
	instanceVariableNames: ''!

!LectorDeTarjeta class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 11:58:32'!
para: unaLineaDeColectivo tomandoHoraDe: unReloj 

	^self new initializePara: unaLineaDeColectivo tomandoHoraDe: unReloj ! !


!LectorDeTarjeta class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 14:54:03'!
direcciónDebeSerACabeceraDescripciónDeError
	
	^'La dirección debe ser una cabecera'! !

!LectorDeTarjeta class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:19:42'!
paradaOrigenDebeSerDistantaADestinoDescripciónDeError
	
	^'Parada origen debe ser distinta a parada destino'! !


!classDefinition: #MedioDeTransporte category: #'2doParcial'!
Object subclass: #MedioDeTransporte
	instanceVariableNames: 'nombre paradas tarifas'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!MedioDeTransporte methodsFor: 'initialization' stamp: 'HAW 11/27/2025 11:58:00'!
initializeLlamada: unNombre paradas: unasParadas tarifas: unasTarifas 
	
	nombre := unNombre.
	paradas := unasParadas.
	tarifas := unasTarifas.! !


!MedioDeTransporte methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:16:34'!
costoDesde: unOrigen hasta: unDestino 
	
	| costo distancia paradaDestino paradaOrigen |
	
	paradaOrigen := self paradaLlamada: unOrigen.
	paradaDestino := self paradaLlamada: unDestino.
	
	distancia := paradaOrigen distanciasA: paradaDestino.
	
	costo := tarifas 
		detect: [ :unaTarifa | unaTarifa esPara: distancia ]	
		ifFound: [ :unaTarifa | unaTarifa costo ]
		ifNone: [ self toDo: 'testear' ].
		
	^costo! !

!MedioDeTransporte methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 14:55:41'!
esCabecera: unaCabecera 
	
	^(paradas last esLlamada: unaCabecera) or: [ paradas first esLlamada: unaCabecera ]! !

!MedioDeTransporte methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:15:39'!
paradaLlamada: unNombre

	^ paradas 
		detect: [ :unaParada | unaParada esLlamada: unNombre ] 
		ifNone: [ self error: self class paradaInválidaDescripciónDeError]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MedioDeTransporte class' category: #'2doParcial'!
MedioDeTransporte class
	instanceVariableNames: ''!

!MedioDeTransporte class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 15:38:05'!
llamada: unNombre paradas: unasParadas tarifas: unasTarifas 
	
	self assertTieneDosParadasMínimo: unasParadas.
	
	^self new initializeLlamada: unNombre paradas: unasParadas tarifas: unasTarifas ! !


!MedioDeTransporte class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:38:24'!
assertTieneDosParadasMínimo: unasParadas 
	
	unasParadas size < 2 ifTrue: [ self error: self debeTenerDosParadasMínimoDescripciónDeError ]! !

!MedioDeTransporte class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:37:27'!
debeTenerDosParadasMínimoDescripciónDeError
	
	^'Debe tener 2 paradas mínimo'! !

!MedioDeTransporte class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:15:51'!
paradaInválidaDescripciónDeError
	
	^'Parada inválida'! !


!classDefinition: #Parada category: #'2doParcial'!
Object subclass: #Parada
	instanceVariableNames: 'nombre distanciaACabecera'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!Parada methodsFor: 'initialization' stamp: 'HAW 11/27/2025 11:56:46'!
initializeEn: unNombre distanteACaberaEn: unaDistanciaACabecera 
	
	nombre := unNombre.
	distanciaACabecera := unaDistanciaACabecera.! !


!Parada methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:11:45'!
calcularDistanciaCon: otraDistanciaACabecera 
	
	^(distanciaACabecera - otraDistanciaACabecera) abs! !

!Parada methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:11:15'!
distanciasA: otraParada

	^otraParada calcularDistanciaCon: distanciaACabecera ! !

!Parada methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:10:50'!
esLlamada: unNombre

	^nombre = unNombre ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Parada class' category: #'2doParcial'!
Parada class
	instanceVariableNames: ''!

!Parada class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 11:56:40'!
llamada: unNombre distanteACaberaEn: unaDistanciaACabecera 
	
	^self new initializeEn: unNombre distanteACaberaEn: unaDistanciaACabecera ! !


!classDefinition: #Tarifa category: #'2doParcial'!
Object subclass: #Tarifa
	instanceVariableNames: 'distancia costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!Tarifa methodsFor: 'initialization' stamp: 'HAW 11/27/2025 11:57:08'!
initializeHasta: unaDistancia esDe: unCosto 
	
	distancia := unaDistancia.
	costo := unCosto.! !


!Tarifa methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:12:20'!
costo
	
	^costo! !

!Tarifa methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:12:13'!
esPara: unaDistancia 
	
	^unaDistancia <= distancia ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tarifa class' category: #'2doParcial'!
Tarifa class
	instanceVariableNames: ''!

!Tarifa class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 11:57:03'!
hasta: unaDistancia esDe: unCosto 
	
	^self new initializeHasta: unaDistancia esDe: unCosto ! !


!classDefinition: #TarjetaBAJE category: #'2doParcial'!
Object subclass: #TarjetaBAJE
	instanceVariableNames: 'saldo tipoDeDescuento viajes'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!TarjetaBAJE methodsFor: 'initialization' stamp: 'HAW 11/27/2025 12:40:59'!
initializeCon: unTipoDeDescuento saldoInicialDe: unSaldoInicial 
	
	tipoDeDescuento := unTipoDeDescuento.
	saldo := unSaldoInicial.
	
	viajes := OrderedCollection new.! !


!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:04:20'!
assertHaySaldoParaCobrar: unMonto 
	
	saldo < unMonto ifTrue: [ self error: self class noHaySaldoSuficienteDescripciónDeError ]! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:22'!
cambiarCostoDeUltimoViajeCon: nuevoMonto destino: nuevoDestino

	self ultimoViaje costo: nuevoMonto.
	self ultimoViaje destino: nuevoDestino! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:43:34'!
cantidadDeViajesEn: unaFecha

	^viajes count: [ :unViaje | unViaje fueEn: unaFecha ]! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:06:47'!
cobrar: unMonto

	self assertHaySaldoParaCobrar: unMonto.
	
	saldo := saldo - unMonto! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:22'!
costoDeUltimoViaje
	
	^self ultimoViaje costo! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:22'!
destinoDeUltimoViaje
	
	^self ultimoViaje destino! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:07'!
en: unDiaYHora cambiarCostoDeUltimoViajeCon: unMonto hasta: unDestino 
	
	| ajuste montoDescontado |
	
	montoDescontado := tipoDeDescuento para: self en: unDiaYHora descontar: unMonto.
	ajuste := montoDescontado - self costoDeUltimoViaje.
	self cobrar: ajuste.
	
	self cambiarCostoDeUltimoViajeCon: montoDescontado destino: unDestino.
	! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:33:58'!
en: unDiaYHora cobrar: unMonto desde: unOrigen hasta: unDestino  

	| montoDescontado |
	
	montoDescontado := tipoDeDescuento para: self en: unDiaYHora descontar: unMonto.
	(self esTrasbordoALas: unDiaYHora)
		ifTrue: [ montoDescontado := montoDescontado / 2 ].
		
	self cobrar: montoDescontado.
	
	viajes add: (Viaje en: unDiaYHora desde: unOrigen hasta: unDestino costó: montoDescontado) ! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:34:28'!
esTrasbordoALas: unDiaYHora 
	
	^viajes notEmpty and: [(self horaDeUltimoViaje distanceTo: unDiaYHora) <= (2*hora)]! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:33:18'!
horaDeUltimoViaje
	
	^self ultimoViaje hora! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:22'!
origenDeUltimoViaje
	
	^self ultimoViaje origen! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:00:19'!
saldo
	
	^saldo! !

!TarjetaBAJE methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:16:22'!
ultimoViaje

	^ viajes last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TarjetaBAJE class' category: #'2doParcial'!
TarjetaBAJE class
	instanceVariableNames: ''!

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 12:23:18'!
con: unTipoDeDescuento saldoInicialDe: unSaldoInicial 
	
	^self new initializeCon: unTipoDeDescuento saldoInicialDe: unSaldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 12:22:53'!
estudiantilSaldoInicialDe: saldoInicial 
	
	^self con: DescuentoEstudiantil new saldoInicialDe: saldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 12:35:07'!
paraJubiladoConSaldoInicialDe: unSaldoInicial 
	
	^self con: DescuentoParaJubilado new saldoInicialDe: unSaldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 12:26:02'!
sinDescuentoConSaldoInicialDe: unSaldoInicial 
	
	^self con: SinDescuento new saldoInicialDe: unSaldoInicial ! !


!TarjetaBAJE class methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:04:33'!
noHaySaldoSuficienteDescripciónDeError
	
	^'No hay saldo suficiente'! !


!classDefinition: #TipoDeDescuento category: #'2doParcial'!
Object subclass: #TipoDeDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!TipoDeDescuento methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:43:19'!
para: unaTarjeta en: unDiaYHora descontar: unMonto

	self subclassResponsibility! !


!classDefinition: #DescuentoEstudiantil category: #'2doParcial'!
TipoDeDescuento subclass: #DescuentoEstudiantil
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!DescuentoEstudiantil methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:41:56'!
para: unaTarjeta en: unDiaYHora descontar: unMonto 
	
	^((unDiaYHora date day isSaturday) or: [ unDiaYHora date day isSunday ]) 
		ifTrue: [ unMonto ]
		ifFalse: [ unMonto / 2 ]
	
! !


!classDefinition: #DescuentoParaJubilado category: #'2doParcial'!
TipoDeDescuento subclass: #DescuentoParaJubilado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!DescuentoParaJubilado methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:42:57'!
para: unaTarjeta en: unDiaYHora descontar: unMonto 
	
	^(unaTarjeta cantidadDeViajesEn: unDiaYHora date) < 2 
		ifTrue: [ unMonto - unMonto ]
		ifFalse: [ unMonto ]! !


!classDefinition: #SinDescuento category: #'2doParcial'!
TipoDeDescuento subclass: #SinDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!SinDescuento methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:41:56'!
para: unaTarjeta en: unDiaYHora descontar: unMonto 
	
	^unMonto ! !


!classDefinition: #Viaje category: #'2doParcial'!
Object subclass: #Viaje
	instanceVariableNames: 'diaYHora origen destino costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!Viaje methodsFor: 'initialization' stamp: 'HAW 11/27/2025 12:44:08'!
initializeEn: unDiaYHora desde: unOrigen hasta: unDestino costó: unMonto 
	
	diaYHora := unDiaYHora.
	origen := unOrigen.
	destino := unDestino.
	costo := unMonto.! !


!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:08:05'!
costo
	
	^costo! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:08:26'!
costo: unCosto 
	
	costo := unCosto! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:08:54'!
destino
	
	^destino! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:08:35'!
destino: unDestino 
	
	destino := unDestino! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:45:53'!
fueEn: unaFecha 
	
	^diaYHora date = unaFecha  ! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:33:26'!
hora
	
	^diaYHora ! !

!Viaje methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:04:12'!
origen
	
	^origen! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Viaje class' category: #'2doParcial'!
Viaje class
	instanceVariableNames: ''!

!Viaje class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 12:43:59'!
en: unDiaYHora desde: unOrigen hasta: unDestino costó: unMonto 
	
	^self new initializeEn: unDiaYHora desde: unOrigen hasta: unDestino costó: unMonto ! !


!classDefinition: #WrapperDeLectorDeTarjeta category: #'2doParcial'!
Object subclass: #WrapperDeLectorDeTarjeta
	instanceVariableNames: 'lectorDeTarjeta'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!WrapperDeLectorDeTarjeta methodsFor: 'initialization' stamp: 'HAW 11/27/2025 15:26:04'!
initializeCon: unLectorDeTarjeta 
	
	lectorDeTarjeta := unLectorDeTarjeta.! !


!WrapperDeLectorDeTarjeta methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:42:47'!
assertEsCabecera: unaCabecera

	^ lectorDeTarjeta assertEsCabecera: unaCabecera! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WrapperDeLectorDeTarjeta class' category: #'2doParcial'!
WrapperDeLectorDeTarjeta class
	instanceVariableNames: ''!

!WrapperDeLectorDeTarjeta class methodsFor: 'instance creation' stamp: 'HAW 11/27/2025 15:26:09'!
con: unLectorDeTarjeta 
	
	^self new initializeCon: unLectorDeTarjeta ! !


!classDefinition: #LectorDeSubte category: #'2doParcial'!
WrapperDeLectorDeTarjeta subclass: #LectorDeSubte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!


!LectorDeSubte methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:42:42'!
cobrarCon: tarjeta desde: unOrigen conDirecciónA: unaCabecera 
	
	self assertEsCabecera: unaCabecera.
	 
	lectorDeTarjeta cobrarCon: tarjeta desde: unOrigen hasta: unaCabecera ! !


!classDefinition: #LectorDeTren category: #'2doParcial'!
WrapperDeLectorDeTarjeta subclass: #LectorDeTren
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!LectorDeTren methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:42:53'!
cobrarEntradaCon: tarjeta desde: unOrigen conDirecciónA: unaCabecera 
	
	self assertEsCabecera: unaCabecera.
	 
	lectorDeTarjeta cobrarCon: tarjeta desde: unOrigen hasta: unaCabecera ! !

!LectorDeTren methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:22:39'!
cobrarSalidaCon: unaTarjeta en: unDestino

	| costo origen |
	
	origen := unaTarjeta origenDeUltimoViaje.
	costo := lectorDeTarjeta costoDesde: origen hasta: unDestino.
	unaTarjeta en: lectorDeTarjeta ahora cambiarCostoDeUltimoViajeCon: costo hasta: unDestino! !


!classDefinition: #ISWMetropolitanoTest category: #'2doParcial'!
TestCase subclass: #ISWMetropolitanoTest
	instanceVariableNames: 'ahora'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2doParcial'!

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:29:39'!
ahora
	
	^ahora! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:16:00'!
belgrano

	^ 'Belgrano'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:50'!
callao

	^ 'Callo'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 14:49:40'!
congresoDeTucumán

	^ 'Congreso de Tucumán'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:05:23'!
constitución

	^ 'Constitución'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:02'!
linea60

	^ MedioDeTransporte 
		llamada: 'linea 60' 
		paradas: { 
			Parada llamada: self constitución distanteACaberaEn: 0*kilometer.
		       Parada llamada: self plazaDeMayo distanteACaberaEn: 5*kilometer.
		       Parada llamada: self retiro distanteACaberaEn: 8*kilometer.
		       Parada llamada: self belgrano distanteACaberaEn: 12*kilometer}
		tarifas: {
			Tarifa hasta: 5*kilometer  esDe: 600 * peso.
			Tarifa hasta: 10*kilometer esDe: 1000 * peso.
			Tarifa hasta: PlusInfinity new esDe: 1300 * peso }! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 14:49:31'!
palermo

	^ 'Palermo'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:05:30'!
plazaDeMayo

	^ 'Plaza de Mayo'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:02'!
retiro

	^ 'Retiro'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:22'!
sanIsidro

	^ 'San Isidro'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 12:32:15'!
setUp

	super setUp.
	ahora := November / 24/2025 at: 10:00! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:50'!
subteD

	^ MedioDeTransporte 
		llamada: 'Subte D' 
		paradas: { 
			Parada llamada: self congresoDeTucumán distanteACaberaEn: 0*kilometer.
		       Parada llamada: self tribunales distanteACaberaEn: 1.2*kilometer.
		       Parada llamada: self callao distanteACaberaEn: 2.5*kilometer.
		       Parada llamada: self palermo distanteACaberaEn: 6*kilometer}
		tarifas: {
			Tarifa hasta: PlusInfinity new esDe: 1000 * peso }! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test01ViajeEnColectivo_ConTarjetaSinDescuento_ConSaldo_CobraPrimerTarifa

"En línea 60, el martes 25/11/25 10:00 AM, de Constitución a Plaza de Mayo con
tarjeta sin descuento: Se cobra 600*peso"

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo.
	
	self assert: tarjeta saldo equals: saldoInicial - (600*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test02NoSePuedeCobrarSinSaldo

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.	
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 599*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	self 
		should: [lector cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TarjetaBAJE noHaySaldoSuficienteDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test03ViajeEnColectivo_UsaTarifaDeAcuerdoADistanciaARecorrer

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial - (1300*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test04ParadasDebenSerVálidas

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	self 
		should: [ lector cobrarCon: tarjeta desde: 'inválida' hasta: self belgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: MedioDeTransporte paradaInválidaDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test05ParaOrigenYDestinoDebenSerDistintas

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	self 
		should: [ lector cobrarCon: tarjeta desde: self belgrano hasta: self belgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: LectorDeTarjeta paradaOrigenDebeSerDistantaADestinoDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test06TarjetaEstudiantil_Recibe50PorcientoDeDescuentoEnDiasDeSemana

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE estudiantilSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial - (1300*peso / 2)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test07TarjetaEstudiantil_NoRecibeDescuentoLosSabados

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	ahora := November /22/2025 at: 10:00.
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE estudiantilSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial - (1300*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test08TarjetaEstudiantil_NoRecibeDescuentoLosDomingo

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	ahora := November /23/2025 at: 10:00.
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE estudiantilSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial - (1300*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test09TarjetaParaJubilado_TieneLosDosPrimerosViajesGratis

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE paraJubiladoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial 
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:35:11'!
test10TarjetaParaJubilado_PagaElTotalAPartirDelTercerViajeEnElMismoDia

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE paraJubiladoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	ahora := ahora next: 121*minute.
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial - (1300*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:17:54'!
test11TarjetaParaJubilado_CuentaLosViajesPorDia

	| linea60 lector tarjeta saldoInicial |
	
	linea60 := self linea60.		
	lector := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE paraJubiladoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	ahora := ahora next: 1*day.
	lector cobrarCon: tarjeta desde: self constitución hasta: self belgrano.
	
	self assert: tarjeta saldo equals: saldoInicial 
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:18:53'!
test12SubteSimpreCobraValorFijo

	| subteD lector tarjeta saldoInicial |
	
	subteD := self subteD.		
	lector := LectorDeSubte con: (LectorDeTarjeta para: subteD tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self congresoDeTucumán conDirecciónA: self palermo.
	
	self assert: tarjeta saldo equals: saldoInicial - (1000*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:50'!
test13LaDirecciónEnSubteDebeSerCabecera

	| subteD lector tarjeta saldoInicial |
	
	subteD := self subteD.		
	lector := LectorDeSubte con: (LectorDeTarjeta para: subteD tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	self 
		should: [ lector cobrarCon: tarjeta desde: self congresoDeTucumán conDirecciónA: self callao ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: LectorDeTarjeta direcciónDebeSerACabeceraDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial  ]
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:19:09'!
test14LaDirecciónEnSubtePuedeSerCabeceraInicial

	| subteD lector tarjeta saldoInicial |
	
	subteD := self subteD.		
	lector := LectorDeSubte con: (LectorDeTarjeta para: subteD tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarCon: tarjeta desde: self palermo conDirecciónA: self congresoDeTucumán.
	
	self assert: tarjeta saldo equals: saldoInicial - (1000*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
test15TrenCobraEntradaComoViajeACabecera

	| trenMitre lector tarjeta saldoInicial |
	
	trenMitre := self trenMitre.		
	lector := LectorDeTren con: (LectorDeTarjeta para: trenMitre tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarEntradaCon: tarjeta desde: self retiro conDirecciónA: self tigre.
	
	self assert: tarjeta saldo equals: saldoInicial - (600*peso)
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
test16TrenCobraSalidaSinCambiarElCosto

	| trenMitre lector tarjeta saldoInicial |
	
	trenMitre := self trenMitre.		
	lector := LectorDeTren con: (LectorDeTarjeta para: trenMitre tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarEntradaCon: tarjeta desde: self retiro conDirecciónA: self tigre.
	lector cobrarSalidaCon: tarjeta en: self sanIsidro.
	
	self assert: tarjeta saldo equals: saldoInicial - (600*peso).
	self assert: tarjeta destinoDeUltimoViaje equals: self sanIsidro.
	self assert: tarjeta costoDeUltimoViaje equals: 600*peso
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
test17TrenCobraSalidaCambiandoElCosto

	| trenMitre lector tarjeta saldoInicial |
	
	trenMitre := self trenMitre.		
	lector := LectorDeTren con: (LectorDeTarjeta para: trenMitre tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lector cobrarEntradaCon: tarjeta desde: self retiro conDirecciónA: self tigre.
	lector cobrarSalidaCon: tarjeta en: 'Belgrano'.
	
	self assert: tarjeta saldo equals: saldoInicial - (400*peso).
	self assert: tarjeta destinoDeUltimoViaje equals: 'Belgrano'.
	self assert: tarjeta costoDeUltimoViaje equals: 400*peso
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
test18TrenCobraSalidaTeniendoEnCuentaElDescuento

	| trenMitre lector tarjeta saldoInicial |
	
	trenMitre := self trenMitre.		
	lector := LectorDeTren con: (LectorDeTarjeta para: trenMitre tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE paraJubiladoConSaldoInicialDe: saldoInicial.
	
	lector cobrarEntradaCon: tarjeta desde: self retiro conDirecciónA: self tigre.
	lector cobrarSalidaCon: tarjeta en: 'Belgrano'.
	
	self assert: tarjeta saldo equals: saldoInicial.
	self assert: tarjeta destinoDeUltimoViaje equals: 'Belgrano'.
	self assert: tarjeta costoDeUltimoViaje equals: 0*peso
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:30:55'!
test19TransbordoDescuenta50Porciento

	| linea60 lectorLinea60 tarjeta saldoInicial lectorSubteD |
	
	linea60 := self linea60 .		
	lectorLinea60 := LectorDeTarjeta para: linea60 tomandoHoraDe: self. 
	lectorSubteD := LectorDeSubte con: (LectorDeTarjeta para: self subteD tomandoHoraDe: self). 
	saldoInicial := 2000*peso.
	tarjeta := TarjetaBAJE sinDescuentoConSaldoInicialDe: saldoInicial.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo .
	ahora := ahora next: 119*minute.
	lectorSubteD cobrarCon: tarjeta desde: self congresoDeTucumán conDirecciónA: self palermo.
	
	self assert: tarjeta saldo equals: saldoInicial - (600*peso) - (500*peso).
	
			
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:37:13'!
test20MedioDeTransporteDebeTener2ParadasMinimo

	self 
		should: [ 
			MedioDeTransporte 
				llamada: 'linea 60' 
				paradas: { 
					Parada llamada: self constitución distanteACaberaEn: 0*kilometer}
		tarifas: {
			Tarifa hasta: 5*kilometer  esDe: 600 * peso.
			Tarifa hasta: 10*kilometer esDe: 1000 * peso.
			Tarifa hasta: PlusInfinity new esDe: 1300 * peso }] 
		raise: Error - MessageNotUnderstood 
		withMessageText: MedioDeTransporte debeTenerDosParadasMínimoDescripciónDeError
		! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
tigre

	^ 'Tigre'! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:30'!
trenMitre

	^ MedioDeTransporte 
		llamada: 'Tren Mitre' 
		paradas: { 
			Parada llamada: self retiro distanteACaberaEn: 0*kilometer.
		       Parada llamada: self belgrano distanteACaberaEn: 8*kilometer.
		       Parada llamada: self sanIsidro distanteACaberaEn: 18*kilometer.
		       Parada llamada: self tigre distanteACaberaEn: 28*kilometer}
		tarifas: {
			Tarifa hasta: 15*kilometer esDe: 400 * peso.
			Tarifa hasta: PlusInfinity new esDe: 600 * peso }! !

!ISWMetropolitanoTest methodsFor: 'as yet unclassified' stamp: 'HAW 11/27/2025 15:51:44'!
tribunales

	^ 'Tribunales'! !
