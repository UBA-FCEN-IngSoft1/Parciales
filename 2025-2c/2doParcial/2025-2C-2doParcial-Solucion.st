!classDefinition: #LectorDeTarjeta category: #'2025-2C-2doParcial'!
Object subclass: #LectorDeTarjeta
	instanceVariableNames: 'medioDeTransporte reloj'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!LectorDeTarjeta methodsFor: 'paradas' stamp: 'HAW 11/24/2025 16:11:51'!
esCabecera: unaCabecera 
	
	^medioDeTransporte esCabecera: unaCabecera ! !


!LectorDeTarjeta methodsFor: 'initialization' stamp: 'HAW 11/24/2025 16:01:41'!
initializeDe: unMedioDeTransporte mirandoLaHoraEn: unReloj 
	
	medioDeTransporte := unMedioDeTransporte.
	reloj := unReloj.! !


!LectorDeTarjeta methodsFor: 'hora' stamp: 'HAW 11/24/2025 16:00:52'!
ahora
	
	^reloj ahora! !


!LectorDeTarjeta methodsFor: 'cobrar' stamp: 'HAW 11/24/2025 16:01:11'!
cobrarCon: unaTarjeta desde: unOrigen hasta: unDestino 
	
	| costo |
	
	self assertDesde: unOrigen distintoAHasta: unDestino.
	
	costo := medioDeTransporte costoDeste: unOrigen hasta: unDestino.
	unaTarjeta en: self ahora cobrar: costo desde: unOrigen hasta: unDestino.! !


!LectorDeTarjeta methodsFor: 'cobrar - private' stamp: 'HAW 11/24/2025 13:11:02'!
assertDesde: unOrigen distintoAHasta: unDestino 
	
	unOrigen = unDestino ifTrue: [ self error: self class paradaOrigenYDestinoIgualesDescripciónDeError ]! !

!LectorDeTarjeta methodsFor: 'cobrar - private' stamp: 'HAW 11/24/2025 16:00:42'!
costoDeste: unOrigen hasta: unDestino 
	
	^medioDeTransporte costoDeste: unOrigen hasta: unDestino ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LectorDeTarjeta class' category: #'2025-2C-2doParcial'!
LectorDeTarjeta class
	instanceVariableNames: ''!

!LectorDeTarjeta class methodsFor: 'descripción de error' stamp: 'HAW 11/24/2025 13:11:13'!
paradaOrigenYDestinoIgualesDescripciónDeError
	
	^'Parada origen y destino deben ser distintas'! !


!LectorDeTarjeta class methodsFor: 'instance creation' stamp: 'HAW 11/24/2025 16:02:05'!
de: unMedioDeTransporte mirandoLaHoraEn: unReloj 
	
	^self new initializeDe: unMedioDeTransporte mirandoLaHoraEn: unReloj ! !


!classDefinition: #MedioDeTransporte category: #'2025-2C-2doParcial'!
Object subclass: #MedioDeTransporte
	instanceVariableNames: 'paradas cuadroTarifario'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!MedioDeTransporte methodsFor: 'initialization' stamp: 'HAW 11/24/2025 12:57:27'!
initializeCon: unasParadas tarifas: unCuadroTarifario 
	
	paradas := unasParadas.
	cuadroTarifario := unCuadroTarifario.! !


!MedioDeTransporte methodsFor: 'costo' stamp: 'HAW 11/24/2025 17:24:40'!
costoDeste: unOrigen hasta: unDestino  
	
	| distanciaACobrar |
	
	distanciaACobrar := self distanciaDesde: unOrigen hasta: unDestino.
	
	^ cuadroTarifario 
		detect: [ :unaTarifa | unaTarifa esPara: distanciaACobrar ]
		ifFound: [ :unaTarifa | unaTarifa costo ]
		ifNone: [ self shouldNotHappenBecause: 'Se asume que siempre hay una tarifa x enunciado' ]! !


!MedioDeTransporte methodsFor: 'distancia' stamp: 'HAW 11/24/2025 15:56:10'!
distanciaDesde: unNombreDeOrigen hasta: unNombreDeDestino 
	
	| destino origen |
	
	origen := self paradaLlamada: unNombreDeOrigen.
	destino := self paradaLlamada: unNombreDeDestino.
	
	^ origen distanciaA: destino ! !


!MedioDeTransporte methodsFor: 'paradas' stamp: 'HAW 11/24/2025 16:15:22'!
esCabecera: unaCabecera 
	
	^(paradas first esLlamada: unaCabecera) or: [ paradas last esLlamada: unaCabecera]! !

!MedioDeTransporte methodsFor: 'paradas' stamp: 'HAW 11/24/2025 15:56:20'!
paradaLlamada: unNombre

	^ paradas 
		detect: [ :unaParada | unaParada esLlamada: unNombre ]
		ifNone: [ self error: self class paradaInexistenteDescripciónDeError  ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MedioDeTransporte class' category: #'2025-2C-2doParcial'!
MedioDeTransporte class
	instanceVariableNames: ''!

!MedioDeTransporte class methodsFor: 'instance creation' stamp: 'HAW 11/24/2025 17:18:38'!
con: unasParadas tarifas: unCuadroTarifario 
	
	self assertParadasVálidas: unasParadas.
	
	^self new initializeCon: unasParadas tarifas: unCuadroTarifario ! !


!MedioDeTransporte class methodsFor: 'aserciones' stamp: 'HAW 11/24/2025 15:56:27'!
assertParadasVálidas: unasParadas 
	
	unasParadas size < 2 ifTrue: [ self error: self debenHaberDosParadasMínimoDescripciónDeError ]! !


!MedioDeTransporte class methodsFor: 'descripciones de error' stamp: 'HAW 11/24/2025 15:56:31'!
debenHaberDosParadasMínimoDescripciónDeError
	
	^'Deben haber dos paradas mínimo'! !

!MedioDeTransporte class methodsFor: 'descripciones de error' stamp: 'HAW 11/24/2025 15:56:37'!
paradaInexistenteDescripciónDeError
	
	^'Parada inexistente'! !


!classDefinition: #Parada category: #'2025-2C-2doParcial'!
Object subclass: #Parada
	instanceVariableNames: 'nombre distanciaACabecera'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Parada methodsFor: 'initialization' stamp: 'HAW 11/23/2025 18:45:27'!
initializeEn: unNombre distanteA: unaDistanciaACabecera 
	
	nombre := unNombre.
	distanciaACabecera := unaDistanciaACabecera.! !


!Parada methodsFor: 'distancia' stamp: 'HAW 11/23/2025 19:07:05'!
diferenciaEnDistanciaCon: unaDistanciaACabecera 
	
	^ (distanciaACabecera - unaDistanciaACabecera) abs! !

!Parada methodsFor: 'distancia' stamp: 'HAW 11/23/2025 19:05:55'!
distanciaA: unDestino 
	
	^ unDestino diferenciaEnDistanciaCon: distanciaACabecera ! !


!Parada methodsFor: 'nombre' stamp: 'HAW 11/23/2025 19:04:49'!
esLlamada: unNombre 
	
	^ nombre = unNombre ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Parada class' category: #'2025-2C-2doParcial'!
Parada class
	instanceVariableNames: ''!

!Parada class methodsFor: 'instance creation' stamp: 'HAW 11/24/2025 17:17:33'!
en: unNombre distanteA: unaDistanciaACabecera 
	
	^self new initializeEn: unNombre distanteA: unaDistanciaACabecera ! !


!classDefinition: #Tarifa category: #'2025-2C-2doParcial'!
Object subclass: #Tarifa
	instanceVariableNames: 'distancia costo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Tarifa methodsFor: 'initialization' stamp: 'HAW 11/23/2025 18:46:23'!
initializeHasta: unaDistancia es: unCosto 
	
	distancia := unaDistancia.
	costo := unCosto.! !


!Tarifa methodsFor: 'costo' stamp: 'HAW 11/23/2025 19:08:21'!
costo
	
	^costo! !

!Tarifa methodsFor: 'costo' stamp: 'HAW 11/23/2025 19:07:34'!
esPara: distanciaACobrar 
	
	^ distanciaACobrar <= distancia! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tarifa class' category: #'2025-2C-2doParcial'!
Tarifa class
	instanceVariableNames: ''!

!Tarifa class methodsFor: 'instance creation' stamp: 'HAW 11/24/2025 17:16:37'!
hasta: unaDistancia es: unCosto 

	^self new initializeHasta: unaDistancia es: unCosto ! !


!classDefinition: #TarjetaBAJE category: #'2025-2C-2doParcial'!
Object subclass: #TarjetaBAJE
	instanceVariableNames: 'saldo tipoDeDescuento viajes'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!TarjetaBAJE methodsFor: 'initialization' stamp: 'HAW 11/23/2025 19:39:49'!
initializeConTipoDeDescuento: unTipoDeDescuento saldo: unSaldoInicial 
	
	tipoDeDescuento := unTipoDeDescuento.
	saldo := unSaldoInicial.
	viajes := OrderedCollection new.! !


!TarjetaBAJE methodsFor: 'cobrar' stamp: 'HAW 11/23/2025 19:31:47'!
cobrar: unCosto

	(saldo - unCosto) negative ifTrue: [ self error: self class sinSaldoSuficienteDescripciónDeError ].
	
	saldo := saldo - unCosto ! !

!TarjetaBAJE methodsFor: 'cobrar' stamp: 'HAW 11/23/2025 21:51:50'!
en: unDiaYHora cobrar: unCosto desde: unOrigen hasta: unDestino   
	
	| costoConDescuento |
	
	costoConDescuento := tipoDeDescuento en: unDiaYHora descontar: unCosto para: self.
	
	unCosto = costoConDescuento 
		ifTrue: [ costoConDescuento := self descontar: unCosto siEsTransbordoAEn: unDiaYHora ].
		
	self cobrar: costoConDescuento.
	viajes add: (Viaje en: unDiaYHora costo: costoConDescuento desde: unOrigen hasta: unDestino).
	! !


!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/23/2025 19:39:28'!
cantidadDeViajesEn: unaFecha
	
	^ viajes count: [ : unViaje | unViaje fueRealizadoEn: unaFecha ]! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/23/2025 20:15:58'!
costoDeUltimoViaje
	
	^ viajes last costo! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/24/2025 16:28:05'!
en: unDiaYHora ajustarUltimoViajeHasta: unDestino con: unNuevoCosto

	| nuevoCostoDescontado ajuste |
	
	nuevoCostoDescontado := tipoDeDescuento en: unDiaYHora descontar: unNuevoCosto para: self.
	ajuste := nuevoCostoDescontado - self costoDeUltimoViaje.
	self cobrar: ajuste.
	viajes last ajustarHasta: unDestino con: ajuste.
	! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/23/2025 21:56:02'!
esTransbordoEn: unDiaYHora 
	
	^ (viajes lastIfEmpty: [ ^ false ]) fueHaceMenosDeDosHorasDe: unDiaYHora ! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/23/2025 20:22:13'!
ultimaParadaOrigen
	
	^ viajes last origen! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/24/2025 16:23:04'!
ultimoDestino
	
	^viajes last destino! !

!TarjetaBAJE methodsFor: 'viajes' stamp: 'HAW 11/24/2025 16:29:34'!
ultimoPago
	
	^viajes last costo! !


!TarjetaBAJE methodsFor: 'descuento' stamp: 'HAW 11/23/2025 21:52:56'!
descontar: unCosto siEsTransbordoAEn: unDiaYHora 
	
	^ (self esTransbordoEn: unDiaYHora) 
		ifTrue: [ unCosto / 2 ]
		ifFalse:[ unCosto ] ! !


!TarjetaBAJE methodsFor: 'saldo' stamp: 'HAW 11/23/2025 18:53:15'!
saldo
	
	^saldo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TarjetaBAJE class' category: #'2025-2C-2doParcial'!
TarjetaBAJE class
	instanceVariableNames: ''!

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/23/2025 19:16:23'!
cobroComúnConSaldo: unSaldoInicial 
	
	^self 
		conTipoDeDescuento: SinDescuento new
		saldo: unSaldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/23/2025 19:12:38'!
conTipoDeDescuento: unTipoDeDescuento saldo: unSaldoInicial 
	
	^self new initializeConTipoDeDescuento: unTipoDeDescuento saldo: unSaldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/23/2025 19:12:17'!
estudiantilConSaldo: unSaldoInicial 
	
	^self 
		conTipoDeDescuento: DescuentoEstudiantil new
		saldo: unSaldoInicial ! !

!TarjetaBAJE class methodsFor: 'instance creation' stamp: 'HAW 11/23/2025 19:23:21'!
paraJubiladoConSaldo: unSaldoInicial 
	
	^self 
		conTipoDeDescuento: DescuentoParaJubilado new
		saldo: unSaldoInicial ! !


!TarjetaBAJE class methodsFor: 'descripciones de error' stamp: 'HAW 11/23/2025 18:58:42'!
sinSaldoSuficienteDescripciónDeError
	
	^ 'No hay saldo suficiente para cobrar'! !


!classDefinition: #TipoDeDescuento category: #'2025-2C-2doParcial'!
Object subclass: #TipoDeDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!TipoDeDescuento methodsFor: 'calcular descuento' stamp: 'HAW 11/24/2025 12:33:35'!
en: unDiaYHora descontar: unCosto para: unTarjeta

	self subclassResponsibility! !


!classDefinition: #DescuentoEstudiantil category: #'2025-2C-2doParcial'!
TipoDeDescuento subclass: #DescuentoEstudiantil
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!DescuentoEstudiantil methodsFor: 'calcular descuento' stamp: 'HAW 11/23/2025 19:27:53'!
en: unDiaYHora descontar: unCosto para: unTarjeta  
	
	^ (unDiaYHora date isSunday or: [ unDiaYHora date isSaturday ])
		ifTrue: [ unCosto ]
		ifFalse: [ unCosto / 2 ]! !


!classDefinition: #DescuentoParaJubilado category: #'2025-2C-2doParcial'!
TipoDeDescuento subclass: #DescuentoParaJubilado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!DescuentoParaJubilado methodsFor: 'calcular descuento' stamp: 'HAW 11/23/2025 19:31:30'!
en: unDiaYHora descontar: unCosto para: unaTarjeta  
	
	^(unaTarjeta cantidadDeViajesEn: unDiaYHora date) < 2
		ifTrue: [ 0 ]
		ifFalse: [ unCosto ]
	  ! !


!classDefinition: #SinDescuento category: #'2025-2C-2doParcial'!
TipoDeDescuento subclass: #SinDescuento
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!SinDescuento methodsFor: 'calcular descuento' stamp: 'HAW 11/23/2025 19:27:53'!
en: unDiaYHora descontar: unCosto para: unTarjeta  
	
	^ unCosto ! !


!classDefinition: #Viaje category: #'2025-2C-2doParcial'!
Object subclass: #Viaje
	instanceVariableNames: 'diaYHora costo origen destino'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!Viaje methodsFor: 'initialization' stamp: 'HAW 11/23/2025 20:19:42'!
initializeEn: unDiaYHora costo: aCobrar desde: unOrigen hasta: unDestino   
	
	diaYHora := unDiaYHora.
	costo := aCobrar.
	origen := unOrigen.
	destino := unDestino ! !


!Viaje methodsFor: 'paradas' stamp: 'HAW 11/24/2025 16:23:10'!
destino
	
	^destino! !

!Viaje methodsFor: 'paradas' stamp: 'HAW 11/23/2025 20:22:20'!
origen
	
	^origen! !


!Viaje methodsFor: 'hora' stamp: 'HAW 11/23/2025 21:55:24'!
fueHaceMenosDeDosHorasDe: unDiaYHora 
	
	^ (diaYHora distanceTo: unDiaYHora) <= (2*hora)! !

!Viaje methodsFor: 'hora' stamp: 'HAW 11/23/2025 19:40:55'!
fueRealizadoEn: unaFecha 
	
	^ diaYHora date = unaFecha ! !


!Viaje methodsFor: 'costo' stamp: 'HAW 11/24/2025 16:30:42'!
ajustarHasta: unDestino con: ajuste 
	
	destino := unDestino.
	costo := costo + ajuste ! !

!Viaje methodsFor: 'costo' stamp: 'HAW 11/23/2025 20:16:04'!
costo
	
	^costo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Viaje class' category: #'2025-2C-2doParcial'!
Viaje class
	instanceVariableNames: ''!

!Viaje class methodsFor: 'instance creation' stamp: 'HAW 11/23/2025 20:19:20'!
en: unDiaYHora costo: aCobrar desde: unOrigen hasta: unDestino   
	
	^self new initializeEn: unDiaYHora costo: aCobrar desde: unOrigen hasta: unDestino   
	! !


!classDefinition: #WrapperDeLectorDeTarjeta category: #'2025-2C-2doParcial'!
Object subclass: #WrapperDeLectorDeTarjeta
	instanceVariableNames: 'lectorDeTarjeta'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!WrapperDeLectorDeTarjeta methodsFor: 'cabecera' stamp: 'HAW 11/24/2025 16:15:36'!
assertEsCabecera: unaCabecera 
	
	(lectorDeTarjeta esCabecera: unaCabecera) 
		ifFalse: [ self error: self direcciónNoEsCabeceraDescripciónDeError ]! !

!WrapperDeLectorDeTarjeta methodsFor: 'cabecera' stamp: 'HAW 11/24/2025 16:13:38'!
direcciónNoEsCabeceraDescripciónDeError
	
	^'Dirección no es hacia cabecera'! !


!WrapperDeLectorDeTarjeta methodsFor: 'initialization' stamp: 'HAW 11/24/2025 16:06:00'!
initializeConLectorDeTarjeta: unLectorDeTarjeta

	lectorDeTarjeta := unLectorDeTarjeta ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WrapperDeLectorDeTarjeta class' category: #'2025-2C-2doParcial'!
WrapperDeLectorDeTarjeta class
	instanceVariableNames: ''!

!WrapperDeLectorDeTarjeta class methodsFor: 'instance creation' stamp: 'HAW 11/24/2025 16:06:15'!
de: unMedioDeTransporte mirandoLaHoraEn: unReloj 
	
	^self new initializeConLectorDeTarjeta: (LectorDeTarjeta de: unMedioDeTransporte mirandoLaHoraEn: unReloj)! !


!classDefinition: #LectorDeSubte category: #'2025-2C-2doParcial'!
WrapperDeLectorDeTarjeta subclass: #LectorDeSubte
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!LectorDeSubte methodsFor: 'cobrar' stamp: 'HAW 11/24/2025 16:10:47'!
cobrarCon: unaTarjeta desde: unOrigen direcciónA: unaCabecera

	self assertEsCabecera: unaCabecera.
	
	lectorDeTarjeta cobrarCon: unaTarjeta desde: unOrigen hasta: unaCabecera! !


!classDefinition: #LectorDeTren category: #'2025-2C-2doParcial'!
WrapperDeLectorDeTarjeta subclass: #LectorDeTren
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!LectorDeTren methodsFor: 'cobrar' stamp: 'HAW 11/24/2025 16:17:56'!
cobrarEntradaCon: unaTarjeta desde: unOrigen direcciónA: unaCabecera
	
	self assertEsCabecera: unaCabecera.
	
	lectorDeTarjeta cobrarCon: unaTarjeta desde: unOrigen hasta: unaCabecera! !

!LectorDeTren methodsFor: 'cobrar' stamp: 'HAW 11/24/2025 16:24:44'!
cobrarSalidaCon: unaTarjeta en: unDestino

	| costo ultimaParadaOrigen |
	
	ultimaParadaOrigen := unaTarjeta ultimaParadaOrigen.
	costo := lectorDeTarjeta costoDeste: ultimaParadaOrigen hasta: unDestino.
	unaTarjeta en: lectorDeTarjeta ahora ajustarUltimoViajeHasta: unDestino con: costo ! !


!classDefinition: #ISWMetropolitanoTest category: #'2025-2C-2doParcial'!
TestCase subclass: #ISWMetropolitanoTest
	instanceVariableNames: 'ahora'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-2doParcial'!

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test01ConTarjetaComun_CobraPrimerTramo

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo.
	
	self assert: tarjeta saldo equals: 400*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test02NoSePuedeCobrarCuandoNoHaySaldo

	| lectorLinea60 linea60 tarjeta saldoInicial |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	saldoInicial := 599*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	self 
		should: [ lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: TarjetaBAJE sinSaldoSuficienteDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:06'!
test03ConTarjetaComun_CobraOtroTramo

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test04ConTarjetaEstudiantil_Cobra50PorcientoDiaDeSemana

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE estudiantilConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 500*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test05ConTarjetaEstudiantil_Cobra100PorcientoLosDomingos

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE estudiantilConSaldo: 1000*peso.
	
	ahora := November / 23 /2025 at: 10:00.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test06ConTarjetaEstudiantil_Cobra100PorcientoLosSabados

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE estudiantilConSaldo: 1000*peso.
	
	ahora := November / 22 /2025 at: 10:00.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test07ConTarjetaJubilado_PrimerViajeEsGratis

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE paraJubiladoConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 1000*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test08ConTarjetaJubilado_TercerOMasViajesPagaNormalmente

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE paraJubiladoConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	ahora := ahora next: 3*hora.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:02:05'!
test09ConTarjetaJubilado_SeCuentanViajesPorDia

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE paraJubiladoConSaldo: 1000*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	ahora := ahora next: 1* day.
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self retiro.
	
	self assert: tarjeta saldo equals: 1000*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/26/2025 12:04:17'!
test10Subte_SiempreCobraValorFijo

	| lectorDeSubte subteD tarjeta |
	
	subteD := self subteD.	
	lectorDeSubte := LectorDeSubte de: subteD mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lectorDeSubte cobrarCon: tarjeta desde: self tribunales direcciónA: self congresoDeTucumán.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:41:27'!
test11Tren_CobraEntradaComoViajeACabecera

	| lector lineaMitre tarjeta |
	
	lineaMitre := self lineaMitre.	
	lector := LectorDeTren de: lineaMitre mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lector cobrarEntradaCon: tarjeta desde: self sanIsidro direcciónA: self retiro.
	
	self assert: tarjeta saldo equals: 400*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:29:13'!
test12Tren_CobrarSalidaCambiandoCosto

	| lector lineaMitre tarjeta |
	
	lineaMitre := self lineaMitre.	
	lector := LectorDeTren de: lineaMitre mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lector cobrarEntradaCon: tarjeta desde: self sanIsidro direcciónA: self retiro.
	lector cobrarSalidaCon: tarjeta en: self belgrano.
	
	self assert: tarjeta saldo equals: 600*peso.
	self assert: tarjeta ultimoDestino equals: self belgrano.
	self assert: tarjeta ultimoPago equals: 400*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:42:02'!
test13Tren_CobrarSalidaSinCambiarCosto

	| lector lineaMitre tarjeta |
	
	lineaMitre := self lineaMitre.	
	lector := LectorDeTren de: lineaMitre mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1000*peso.
	
	lector cobrarEntradaCon: tarjeta desde: self belgrano direcciónA: self tigre.
	lector cobrarSalidaCon: tarjeta en: self tigre.
	
	self assert: tarjeta saldo equals: 400*peso.
	self assert: tarjeta ultimoDestino equals: self tigre.
	self assert: tarjeta ultimoPago equals: 600*peso

		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:42:47'!
test14Tren_CobrarSalida_UtilizaCostoDescontado

	| lector lineaMitre tarjeta |
	
	lineaMitre := self lineaMitre.	
	lector := LectorDeTren de: lineaMitre mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE paraJubiladoConSaldo: 1000*peso.
	
	lector cobrarEntradaCon: tarjeta desde: self sanIsidro direcciónA: self retiro.
	lector cobrarSalidaCon: tarjeta en: self belgrano.
	
	self assert: tarjeta saldo equals: 1000*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 16:43:13'!
test15TrasbordoCobra50Porciento

	| lectorLinea60 linea60 tarjeta |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: 1100*peso.
	
	lectorLinea60 cobrarCon: tarjeta desde: self constitución hasta: self plazaDeMayo.
	ahora := ahora next: 30*minute.
	lectorLinea60 cobrarCon: tarjeta desde: self plazaDeMayo hasta: self belgrano.
	
	self assert: tarjeta saldo equals: 0*peso
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:19:20'!
test16ParadaDeViajeDebeExistir

	| lectorLinea60 linea60 tarjeta saldoInicial |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	saldoInicial := 1000*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	self 
		should: [lectorLinea60 cobrarCon: tarjeta desde: 'inválida' hasta: self plazaDeMayo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ : anException |
			self assert: anException messageText equals: MedioDeTransporte paradaInexistenteDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:19:25'!
test17ParadaOrigenYDestinoDebenSerDistintas

	| lectorLinea60 linea60 tarjeta saldoInicial |
	
	linea60 := self linea60.	
	lectorLinea60 := LectorDeTarjeta de: linea60 mirandoLaHoraEn: self.
	saldoInicial := 1000*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	self 
		should: [lectorLinea60 cobrarCon: tarjeta desde: self plazaDeMayo hasta: self plazaDeMayo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ : anException |
			self assert: anException messageText equals: LectorDeTarjeta paradaOrigenYDestinoIgualesDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ]
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:22:28'!
test18MedioDeTransporteDebeTenerDosParadasMínimo

	self
		should: [ MedioDeTransporte 
			con: { Parada en: self belgrano distanteA:  1*kilometer } 
			tarifas: self cuadroTarifarioDeLinea60 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MedioDeTransporte debenHaberDosParadasMínimoDescripciónDeError
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:19:35'!
test19EnSubteLaDirecciónDebeSerUnaCabecera

	| lectorDeSubte subteD tarjeta saldoInicial |
	
	subteD := self subteD.	
	lectorDeSubte := LectorDeSubte de: subteD mirandoLaHoraEn: self.
	saldoInicial := 1000*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	self 
		should: [ lectorDeSubte cobrarCon: tarjeta desde: self congresoDeTucumán direcciónA: self tribunales ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: lectorDeSubte direcciónNoEsCabeceraDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ].
		! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:19:40'!
test20EnSubteLaDirecciónPuedeSerUltimaEstación

	| lectorDeSubte subteD tarjeta saldoInicial |
	
	subteD := self subteD.	
	lectorDeSubte := LectorDeSubte de: subteD mirandoLaHoraEn: self.
	saldoInicial := 1000*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	lectorDeSubte cobrarCon: tarjeta desde: self congresoDeTucumán direcciónA: self palermo.
	
	self assert: tarjeta saldo equals: 0*peso! !

!ISWMetropolitanoTest methodsFor: 'tests' stamp: 'HAW 11/24/2025 17:19:45'!
test21EnTrenLaDirecciónDebeSerUnaCabecera

	| lectorDeTren tarjeta saldoInicial lineaMitre |
	
	lineaMitre := self lineaMitre.	
	lectorDeTren := LectorDeTren de: lineaMitre mirandoLaHoraEn: self.
	saldoInicial := 1000*peso.
	tarjeta := TarjetaBAJE cobroComúnConSaldo: saldoInicial.
	
	self 
		should: [ lectorDeTren cobrarEntradaCon: tarjeta desde: self retiro direcciónA: self belgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: lectorDeTren direcciónNoEsCabeceraDescripciónDeError.
			self assert: tarjeta saldo equals: saldoInicial ].
		! !


!ISWMetropolitanoTest methodsFor: 'hora' stamp: 'HAW 11/24/2025 12:34:38'!
ahora
	
	^ahora! !


!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 20:22:46'!
belgrano

	^ 'Belgrano'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/24/2025 12:42:18'!
congresoDeTucumán

	^ 'Congreso de Tucumán'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 18:54:53'!
constitución

	^ 'Constitución'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/24/2025 16:07:54'!
palermo

	^ 'Palermo'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 18:55:04'!
plazaDeMayo

	^ 'Plaza de Mayo'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 18:59:18'!
retiro

	^ 'Retiro'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 19:57:43'!
sanIsidro
	
	^ 'San Isidro'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 20:22:54'!
tigre

	^ 'Tigre'! !

!ISWMetropolitanoTest methodsFor: 'paradas' stamp: 'HAW 11/23/2025 19:47:08'!
tribunales
	
	^ 'Tribunales'! !


!ISWMetropolitanoTest methodsFor: 'linea 60' stamp: 'HAW 11/26/2025 12:06:01'!
cuadroTarifarioDeLinea60

	^ {Tarifa hasta: 5*kilometer es: 600*peso.
		Tarifa hasta: 10*kilometer es: 1000*peso.
		Tarifa hasta: PlusInfinity new es: 1300*peso }! !

!ISWMetropolitanoTest methodsFor: 'linea 60' stamp: 'HAW 11/24/2025 15:57:45'!
linea60

	^ MedioDeTransporte 
		con: self paradasDeLinea60
		tarifas: self cuadroTarifarioDeLinea60! !

!ISWMetropolitanoTest methodsFor: 'linea 60' stamp: 'HAW 11/26/2025 12:06:21'!
paradasDeLinea60

	^ {Parada en: self constitución distanteA: 0*kilometer.
		Parada en: self plazaDeMayo distanteA: 5*kilometer.
		Parada en: self retiro distanteA: 8*kilometer.
		Parada en: self belgrano distanteA: 12*kilometer}! !


!ISWMetropolitanoTest methodsFor: 'linea mitre' stamp: 'HAW 11/26/2025 12:05:42'!
lineaMitre

	^ MedioDeTransporte 
		con: {
			Parada en: self retiro distanteA: 0*kilometer.
			Parada en: self belgrano distanteA: 8*kilometer.
			Parada en: self sanIsidro distanteA: 18*kilometer.
			Parada en: self tigre distanteA: 28*kilometer}
		tarifas: {
			Tarifa hasta: 15*kilometer es: 400*peso.
			Tarifa hasta: PlusInfinity new es: 600*peso}! !


!ISWMetropolitanoTest methodsFor: 'subte D' stamp: 'HAW 11/26/2025 12:04:59'!
subteD

	^ MedioDeTransporte 
		con: {
			Parada en: self congresoDeTucumán distanteA: 0*kilometer.
			Parada en: self tribunales distanteA: 1.2*kilometer.
			Parada en: 'Callao' distanteA: 2.5*kilometer.
			Parada en: self palermo distanteA: 6*kilometer }
		tarifas: { Tarifa hasta: PlusInfinity new es: 1000*peso }! !


!ISWMetropolitanoTest methodsFor: 'setUp' stamp: 'HAW 11/24/2025 12:34:38'!
setUp
	
	super setUp.
	
	ahora := November / 25 / 2025 at: 10:00! !
