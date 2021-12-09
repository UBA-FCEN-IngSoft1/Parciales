!classDefinition: #InmobiliariaTest category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
TestCase subclass: #InmobiliariaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:31:24'!
test01PrecioEstablecidoNoModificaPrecioBase

	| costoEnBelgrano propiedad |
	
	costoEnBelgrano := self precioDeAreaDeBelgranoEnDiciembre2021.
	propiedad := self propiedadEnBelgrano.
	
	self assert: 1000*peso equals: (propiedad costoUsando: costoEnBelgrano en: December/6/2021)
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/9/2021 17:26:52'!
test02PrecioDiferencialAplicaRatioAPrecioBase

	| costoEnBelgrano propiedad |
	
	costoEnBelgrano := self precioDeAreaDeBelgranoEnDiciembre2021.
	propiedad := Propiedad ubicadaEn: self belgrano calculandoPrecioCon: (PrecioDiferencial de: 0.15) de: 1 * meter * meter .
	
	self assert: 1000*peso*1.15 equals: (propiedad costoUsando: costoEnBelgrano en: December/6/2021)
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:53:07'!
test03PrecioDiferencialNoPuedeSerMayorA15Porciento

	self assertNoSePuedeCrearPrecioDiferencialDe: 0.151! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/9/2021 17:27:04'!
test04PrecioDiferenciaNoPuedeSerMenorA15Porciento

	self assertNoSePuedeCrearPrecioDiferencialDe: -0.151! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:34:05'!
test05PrecioPorDiaParaFinesDeSemanaModificaElPrecioLosSabadosYDomingos

	| costoEnBelgrano propiedad |
	
	costoEnBelgrano := self precioDeAreaDeBelgranoEnDiciembre2021.
	propiedad := Propiedad ubicadaEn: self belgrano calculandoPrecioCon: (PrecioPorDia paraFinesDeSemanaDe: 0.1) de: 1 * meter * meter .
	
	self assert: 1000*peso*1.1 equals: (propiedad costoUsando: costoEnBelgrano en: December/4/2021).
	self assert: 1000*peso*1.1 equals: (propiedad costoUsando: costoEnBelgrano en: December/5/2021)
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:35:01'!
test06PrecioPorDiaParaFinesDeSemanaNoModificaElPrecioParaDiasDeSemana

	| costoEnBelgrano propiedad |
	
	costoEnBelgrano := self precioDeAreaDeBelgranoEnDiciembre2021.
	propiedad := Propiedad ubicadaEn: self belgrano calculandoPrecioCon: (PrecioPorDia paraFinesDeSemanaDe: 0.1) de: 1 * meter * meter .
	
	self assert: 1000*peso equals: (propiedad costoUsando: costoEnBelgrano en: December/6/2021).
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:36:34'!
test07InmobiliariaPuedeTenerPropiedadesEnVenta

	| casaEnBelgrano inmobiliaria |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria agregarPropiedad: casaEnBelgrano.
	
	self assert: 1 equals: inmobiliaria propiedadesEnVenta size.
	self assert: (inmobiliaria propiedadesEnVenta includes: casaEnBelgrano)
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:36:55'!
test08SePuedeVenderUnaPropiedad

	| casaEnBelgrano inmobiliaria |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
	
	inmobiliaria en: December/6/2021 seVendio: casaEnBelgrano.
	
	self assert: inmobiliaria propiedadesEnVenta isEmpty.
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:37:15'!
test09NoSePuedeVenderPropiedadNoALaVenta

	| casaEnBelgrano inmobiliaria |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	self 
		should: [ inmobiliaria en: December/6/2021 seVendio: casaEnBelgrano ]
		raise: Error - MessageNotUnderstood 
		withMessageText: inmobiliaria propiedadNoALaVentaErrorDescription
		! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:54:02'!
test10CuandoSeVendeUnaPropiedadSeRegistraLaVenta

	| casaEnBelgrano inmobiliaria ventaCasaEnBelgrano fechaDeVenta |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeVenta := December/6/2021.
	inmobiliaria en: fechaDeVenta seVendio: casaEnBelgrano.
	
	self assert: inmobiliaria propiedadesEnVenta isEmpty.
	self assert: 1 equals: inmobiliaria ventas size.
	
	ventaCasaEnBelgrano := inmobiliaria ventas first.
	self assert: fechaDeVenta equals: ventaCasaEnBelgrano fecha.
	self assert: casaEnBelgrano equals: ventaCasaEnBelgrano propiedad.
	self assert: 1000 * peso equals: ventaCasaEnBelgrano precio.
	
	
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:56:43'!
test11NoSePuedeVenderSiNoHayPrecioDeAreaParaBarrio

	self assertNoSePuedeVenderConPrecioDe: self precioDeAreaDePalermoEnDiciembre2021
		! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:57:20'!
test12NoSePuedeVenderSiNoHayPrecioDeAreaParaElMesDeA�o

	self assertNoSePuedeVenderConPrecioDe: self precioDeAreaDeBelgranoEnNoviembre2021 .
! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/6/2021 18:17:36'!
test13SeRegistraUnaSe�aCuandoSeHaceUnaSe�aValida

	| casaEnBelgrano inmobiliaria se�aCasaEnBelgrano fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeSe�a := December/6/2021.
	inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next.
	
	self assert: inmobiliaria propiedadesEnVenta isEmpty.
	self assert: inmobiliaria ventas isEmpty.
	self assert: 1 equals: inmobiliaria se�as size.
	
	se�aCasaEnBelgrano := inmobiliaria se�as first.
	self assert: fechaDeSe�a equals: se�aCasaEnBelgrano fecha.
	self assert: casaEnBelgrano equals: se�aCasaEnBelgrano propiedad.
	self assert: 100 * peso equals: se�aCasaEnBelgrano valor.
	self assert: 900 * peso equals: se�aCasaEnBelgrano diferenciaAPagar
	
	
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:47:15'!
test14NoSePuedeSe�arUnaPropiedadNoALaVenta

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.
	fechaDeSe�a := December/6/2021.
	
	self 
		should: [ inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next ]
		raise: Error - MessageNotUnderstood 
		withMessageText: inmobiliaria propiedadNoALaVentaErrorDescription
		! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:47:35'!
test15NoSePuedeSe�arSinPrecioDeVenta

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.
	inmobiliaria agregarPropiedad: casaEnBelgrano.
	fechaDeSe�a := December/6/2021.
	
	self 
		should: [ inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: inmobiliaria noHayPrecioDeVentaErrorDescription equals: anError messageText.
			self assert: (inmobiliaria propiedadesEnVenta includes: casaEnBelgrano) ]
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:47:57'!
test16FechaLimiteDeSe�aDebeSerMayorAFechaDeSe�a

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.
	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
	fechaDeSe�a := December/6/2021.
	
	self  
		should: [inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a previous]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Se�a fechaLimiteSDeSe�aInvalidaErrorDescription equals: anError messageText.
			self assert: (inmobiliaria propiedadesEnVenta includes: casaEnBelgrano).
			self assert: inmobiliaria se�as isEmpty]
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:49:35'!
test17SePuedePagarRestoDeSe�aHastaFechaLimite

	| casaEnBelgrano inmobiliaria ventaCasaEnBelgrano fechaDeSe�a fechaDePago |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeSe�a := December/6/2021.
	fechaDePago := fechaDeSe�a next: 30*day.
	inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDePago .
	inmobiliaria en: fechaDePago sePagoRestoDeSe�a: casaEnBelgrano.
	
	self assert: inmobiliaria propiedadesEnVenta isEmpty.
	self assert: inmobiliaria se�as isEmpty.
	self assert: 1 equals: inmobiliaria ventas size.
	
	ventaCasaEnBelgrano := inmobiliaria ventas first.
	self assert: fechaDePago equals: ventaCasaEnBelgrano fecha.
	self assert: casaEnBelgrano equals: ventaCasaEnBelgrano propiedad.
	self assert: 1000 * peso equals: ventaCasaEnBelgrano precio
	
	! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:49:21'!
test18NoSePuedePagarRestoDeSe�aLuegoDeFechaLimite

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeSe�a := December/6/2021.
	inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next.
	self 
		should: [ inmobiliaria en: fechaDeSe�a next next sePagoRestoDeSe�a: casaEnBelgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: inmobiliaria se�aNoDisponibleErrorDescription equals: anError messageText.
			self assert: 1 equals: inmobiliaria propiedadesEnVenta size.
			self assert: (inmobiliaria propiedadesEnVenta includes: casaEnBelgrano).
			self assert: inmobiliaria ventas isEmpty.
			self assert: inmobiliaria se�as isEmpty ].! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/9/2021 17:41:03'!
test19NoSePuedePagarRestoDeSe�aParaPropiedadNoSe�ada

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeSe�a := December/6/2021.
	inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next.
	self 
		should: [ inmobiliaria en: fechaDeSe�a next sePagoRestoDeSe�a: self propiedadEnPalermo ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: inmobiliaria se�aNoDisponibleErrorDescription equals: anError messageText.
			self assert: inmobiliaria propiedadesEnVenta isEmpty.
			self assert: inmobiliaria ventas isEmpty.
			self assert: 1 equals: inmobiliaria se�as size.
			self assert: (inmobiliaria se�as first esDe: casaEnBelgrano) ].! !

!InmobiliariaTest methodsFor: 'tests' stamp: 'HAW 12/5/2021 19:51:24'!
test20NoSePuedePagarRestoDeSe�aParaFechaAnteriorASe�a

	| casaEnBelgrano inmobiliaria fechaDeSe�a |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.

	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: self precioDeAreaDeBelgranoEnDiciembre2021.
		
	fechaDeSe�a := December/6/2021.
	inmobiliaria en: fechaDeSe�a seSe�o: casaEnBelgrano hastaEl: fechaDeSe�a next.
	self 
		should: [ inmobiliaria en: fechaDeSe�a previous sePagoRestoDeSe�a: casaEnBelgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: inmobiliaria fechaDeVentaInvalidaErrorDescription equals: anError messageText.
			self assert: inmobiliaria propiedadesEnVenta isEmpty.
			self assert: inmobiliaria ventas isEmpty.
			self assert: 1 equals: inmobiliaria se�as size.
			self assert: (inmobiliaria se�as first esDe: casaEnBelgrano) ].! !


!InmobiliariaTest methodsFor: 'precios de area' stamp: 'HAW 12/6/2021 18:20:10'!
precioDeAreaDeBelgranoEnDiciembre2021

	^ PrecioDeArea en: self belgrano durante: (December of: 2021) es: 1000 * peso / (meter ^2) ! !

!InmobiliariaTest methodsFor: 'precios de area' stamp: 'HAW 12/6/2021 18:20:10'!
precioDeAreaDeBelgranoEnNoviembre2021
	
	^ PrecioDeArea en: self belgrano durante: (November of: 2021) es: 1000 * peso / (meter ^2) ! !

!InmobiliariaTest methodsFor: 'precios de area' stamp: 'HAW 12/6/2021 18:20:10'!
precioDeAreaDePalermoEnDiciembre2021
	
	^PrecioDeArea en: self palermo durante: (December of: 2021) es: 2000 * peso / (meter ^2) ! !


!InmobiliariaTest methodsFor: 'propiedades' stamp: 'HAW 12/5/2021 19:28:52'!
propiedadEnBelgrano

	^ Propiedad ubicadaEn: self belgrano calculandoPrecioCon: PrecioEstablecido new de: 1 * meter * meter ! !

!InmobiliariaTest methodsFor: 'propiedades' stamp: 'HAW 12/5/2021 19:29:00'!
propiedadEnPalermo
	
	^ Propiedad ubicadaEn: self palermo calculandoPrecioCon: #Casa de: 1 * meter * meter ! !


!InmobiliariaTest methodsFor: 'barrios' stamp: 'HAW 12/5/2021 17:26:58'!
belgrano

	^ 'Belgrano'! !

!InmobiliariaTest methodsFor: 'barrios' stamp: 'HAW 12/5/2021 17:27:17'!
palermo

	^ 'Palermo'! !


!InmobiliariaTest methodsFor: 'assertions' stamp: 'HAW 12/5/2021 19:53:07'!
assertNoSePuedeCrearPrecioDiferencialDe: unRatio

	^ self 
		should: [ PrecioDiferencial de: unRatio ]
		raise: Error - MessageNotUnderstood 
		withMessageText: PrecioDiferencial ratioInvalidoMessageText! !

!InmobiliariaTest methodsFor: 'assertions' stamp: 'HAW 12/5/2021 19:56:53'!
assertNoSePuedeVenderConPrecioDe: unPrecioDeArea

	| casaEnBelgrano inmobiliaria |

	casaEnBelgrano := self propiedadEnBelgrano.
	inmobiliaria := Inmobiliaria new.
	inmobiliaria 
		agregarPropiedad: casaEnBelgrano;
		agregarPrecioDeArea: unPrecioDeArea.

	self 
		should: [ inmobiliaria en: December/6/2021 seVendio: casaEnBelgrano ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: inmobiliaria noHayPrecioDeVentaErrorDescription equals: anError messageText.
			self assert: (inmobiliaria propiedadesEnVenta includes: casaEnBelgrano) ]! !


!classDefinition: #Inmobiliaria category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Object subclass: #Inmobiliaria
	instanceVariableNames: 'propiedadesEnVenta preciosDeArea ventas se�as'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!Inmobiliaria methodsFor: 'assertion de transacciones' stamp: 'HAW 12/5/2021 19:25:20'!
assertEsFechaPosterior: unaFechaDeVenta aFechaDe: se�a 

	^ unaFechaDeVenta < se�a fecha ifTrue: [ self error: self fechaDeVentaInvalidaErrorDescription ]! !

!Inmobiliaria methodsFor: 'assertion de transacciones' stamp: 'HAW 12/5/2021 18:18:24'!
assertEstaALaVenta: unaPropiedad

	^ (propiedadesEnVenta includes: unaPropiedad) ifFalse:  [ self error: self propiedadNoALaVentaErrorDescription ]! !

!Inmobiliaria methodsFor: 'assertion de transacciones' stamp: 'HAW 12/5/2021 19:28:20'!
assertSePuedeRealizarTransaccionEn: unaFechaDeTransaccion de: unaPropiedad 
	
	"Es bastante cuestionable que una assertion devuelva algo, pero lo hice as� para no tener que buscar 
	dos veces el precio del area, aca y luego en la transaccion - Hernan"
	self assertEstaALaVenta: unaPropiedad. 
	^self precioDeVentaDe: unaPropiedad en: unaFechaDeTransaccion ! !


!Inmobiliaria methodsFor: 'error description' stamp: 'HAW 12/5/2021 17:19:40'!
fechaDeVentaInvalidaErrorDescription
	
	^'Fecha de venta inv�lida'! !

!Inmobiliaria methodsFor: 'error description' stamp: 'HAW 12/5/2021 16:15:40'!
noHayPrecioDeVentaErrorDescription
	
	^'No hay precio de venta para esa propiedad'! !

!Inmobiliaria methodsFor: 'error description' stamp: 'HAW 12/5/2021 16:04:09'!
propiedadNoALaVentaErrorDescription
	
	^'Propiendad no a la venta'! !

!Inmobiliaria methodsFor: 'error description' stamp: 'HAW 12/5/2021 17:10:20'!
se�aNoDisponibleErrorDescription
	
	^'Se�a no disponible'! !


!Inmobiliaria methodsFor: 'initialization' stamp: 'HAW 12/5/2021 19:19:21'!
initialize

	super initialize.
	preciosDeArea := OrderedCollection new.
	propiedadesEnVenta := OrderedCollection new.
	ventas := OrderedCollection new.
	se�as := OrderedCollection new! !


!Inmobiliaria methodsFor: 'precio de propiedad' stamp: 'HAW 12/5/2021 19:19:17'!
precioDeAreaDe: unaPropiedad en: unaFechaDeTransaccion

	^ preciosDeArea 
		detect: [ :unPrecio | unPrecio correspondeA: unaPropiedad en: unaFechaDeTransaccion ]
		ifNone: [ self error: self noHayPrecioDeVentaErrorDescription ]! !

!Inmobiliaria methodsFor: 'precio de propiedad' stamp: 'HAW 12/5/2021 18:44:14'!
precioDeVentaDe: unaPropiedad en: unaFechaDeVenta 
	
	| precioDeArea |
	
	precioDeArea :=  self precioDeAreaDe: unaPropiedad en: unaFechaDeVenta.
	^unaPropiedad costoUsando: precioDeArea en: unaFechaDeVenta! !


!Inmobiliaria methodsFor: 'precios de area' stamp: 'HAW 12/5/2021 19:19:50'!
agregarPrecioDeArea: unPrecio 
	
	preciosDeArea add: unPrecio ! !


!Inmobiliaria methodsFor: 'propiedad' stamp: 'HAW 12/5/2021 18:08:13'!
agregarPropiedad: unaPropiedad 
	
	propiedadesEnVenta add: unaPropiedad ! !


!Inmobiliaria methodsFor: 'propiedades' stamp: 'HAW 12/5/2021 18:08:13'!
propiedadesEnVenta
	
	^propiedadesEnVenta copy! !

!Inmobiliaria methodsFor: 'propiedades' stamp: 'HAW 12/5/2021 16:40:40'!
se�as
	
	^se�as copy! !

!Inmobiliaria methodsFor: 'propiedades' stamp: 'HAW 12/5/2021 16:13:49'!
ventas
	
	^ventas copy! !


!Inmobiliaria methodsFor: 'transacciones' stamp: 'HAW 12/5/2021 19:26:01'!
en: unaFechaDeVenta sePagoRestoDeSe�a: unaPropiedad 
	
	| se�a |
	
	se�a := self se�aDe: unaPropiedad.
	self assertEsFechaPosterior: unaFechaDeVenta aFechaDe: se�a.
	
	(se�a estaVencidaEn: unaFechaDeVenta)
		ifTrue: [ self pagoVencidoDe: se�a ]
		ifFalse: [ self pagoATerminoDe: se�a en: unaFechaDeVenta]! !

!Inmobiliaria methodsFor: 'transacciones' stamp: 'HAW 12/5/2021 19:20:42'!
en: unaFechaDeSe�a seSe�o: unaPropiedad hastaEl: unFinDeSe�a  
	
	| precioDePropiedad |
	
	precioDePropiedad := self assertSePuedeRealizarTransaccionEn: unaFechaDeSe�a de: unaPropiedad.
	self registrarTransaccion: (Se�a de: unaPropiedad en: unaFechaDeSe�a hasta: unFinDeSe�a a: precioDePropiedad) en: se�as ! !

!Inmobiliaria methodsFor: 'transacciones' stamp: 'HAW 12/5/2021 18:53:27'!
en: unaFechaDeVenta seVendio: unaPropiedad 
	
	| precioDePropiedad |
	
	precioDePropiedad := self assertSePuedeRealizarTransaccionEn: unaFechaDeVenta de: unaPropiedad.
	self registrarTransaccion: (Venta de: unaPropiedad en: unaFechaDeVenta a: precioDePropiedad) en: ventas! !

!Inmobiliaria methodsFor: 'transacciones' stamp: 'HAW 12/5/2021 18:30:45'!
se�aDe: unaPropiedad

	^ se�as detect: [ :unaSe�a | unaSe�a esDe: unaPropiedad ] ifNone: [ self error: self se�aNoDisponibleErrorDescription ]! !


!Inmobiliaria methodsFor: 'transacciones - private' stamp: 'HAW 12/5/2021 19:26:10'!
pagoATerminoDe: se�a en: unaFechaDeVenta

	| venta |
	
	se�as remove: se�a.
	venta := Venta de: se�a propiedad en: unaFechaDeVenta a: se�a precio.
	
	ventas add: venta! !

!Inmobiliaria methodsFor: 'transacciones - private' stamp: 'HAW 12/5/2021 18:41:48'!
pagoVencidoDe: se�a

	se�as remove: se�a.
	propiedadesEnVenta add: se�a propiedad.
	
	self error: self se�aNoDisponibleErrorDescription! !

!Inmobiliaria methodsFor: 'transacciones - private' stamp: 'HAW 12/5/2021 18:29:29'!
registrarTransaccion: unaTransaccion en: transacciones

	propiedadesEnVenta remove: unaTransaccion propiedad.
	
	transacciones add: unaTransaccion ! !


!classDefinition: #ModificadorDePrecio category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Object subclass: #ModificadorDePrecio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!ModificadorDePrecio methodsFor: 'modificacion de precio' stamp: 'HAW 12/5/2021 17:55:31'!
precioFinalPara: unPrecioBase en: unaFecha 

	self subclassResponsibility ! !


!classDefinition: #PrecioDiferencial category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
ModificadorDePrecio subclass: #PrecioDiferencial
	instanceVariableNames: 'ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!PrecioDiferencial methodsFor: 'initialization' stamp: 'HAW 12/5/2021 17:57:35'!
initializeDe: unRatio 
	
	ratio := unRatio.! !


!PrecioDiferencial methodsFor: 'modificacion de precio' stamp: 'HAW 12/5/2021 17:45:01'!
precioFinalPara: unPrecioBase en: unaFecha 
	
	^unPrecioBase * (1 + ratio) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioDiferencial class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
PrecioDiferencial class
	instanceVariableNames: ''!

!PrecioDiferencial class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 17:58:07'!
de: unRatio 
	
	self assertEsRatioValido: unRatio.
	
	^self new initializeDe: unRatio ! !


!PrecioDiferencial class methodsFor: 'assertions' stamp: 'HAW 12/5/2021 17:58:07'!
assertEsRatioValido: unRatio

	^ unRatio abs > 0.15 ifTrue: [ self error: self ratioInvalidoMessageText ]! !

!PrecioDiferencial class methodsFor: 'assertions' stamp: 'HAW 12/5/2021 17:46:14'!
ratioInvalidoMessageText
	
	^'Ratio inv�lido'! !


!classDefinition: #PrecioEstablecido category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
ModificadorDePrecio subclass: #PrecioEstablecido
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!PrecioEstablecido methodsFor: 'modificacion de precio' stamp: 'HAW 12/5/2021 17:58:54'!
precioFinalPara: unPrecioBase en: unaFecha 

	^unPrecioBase ! !


!classDefinition: #PrecioPorDia category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
ModificadorDePrecio subclass: #PrecioPorDia
	instanceVariableNames: 'dias ratio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!PrecioPorDia methodsFor: 'initialization' stamp: 'HAW 12/5/2021 17:57:05'!
initializePara: unosDias de: unRatio 
	
	dias := unosDias.
	ratio := unRatio.! !


!PrecioPorDia methodsFor: 'modificacion de precio' stamp: 'HAW 12/5/2021 17:54:21'!
precioFinalPara: unPrecioBase en: unaFecha 
	
	^(dias includes: unaFecha day) 
		ifTrue: [ unPrecioBase * (1+ratio) ]
		ifFalse: [ unPrecioBase ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioPorDia class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
PrecioPorDia class
	instanceVariableNames: ''!

!PrecioPorDia class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 17:57:05'!
para: unosDias de: unRatio 
	
	^self new initializePara: unosDias de: unRatio ! !

!PrecioPorDia class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 17:56:58'!
paraFinesDeSemanaDe: unRatio 
	
	^self para: { Saturday. Sunday } de: unRatio ! !


!classDefinition: #PrecioDeArea category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Object subclass: #PrecioDeArea
	instanceVariableNames: 'barrio precio mesDeA�o'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!PrecioDeArea methodsFor: 'initialization' stamp: 'HAW 12/6/2021 18:20:46'!
initializeEn: unBarrio durante: unMesDeA�o es: unPrecio  
	
	barrio := unBarrio.
	mesDeA�o := unMesDeA�o.
	precio := unPrecio.
	
	! !


!PrecioDeArea methodsFor: 'total' stamp: 'HAW 12/6/2021 18:20:46'!
total: unAreaCubierta  
	
	^precio * unAreaCubierta ! !


!PrecioDeArea methodsFor: 'testing' stamp: 'HAW 12/5/2021 16:34:08'!
correspondeA: unaPropiedad en: unaFecha

	^(unaPropiedad estaUbicadaEn: barrio) and: [ mesDeA�o includes: unaFecha ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrecioDeArea class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
PrecioDeArea class
	instanceVariableNames: ''!

!PrecioDeArea class methodsFor: 'instance creation' stamp: 'HAW 12/6/2021 18:20:29'!
en: unBarrio durante: unMesDeA�o es: unPrecio  
	
	^self new initializeEn: unBarrio durante: unMesDeA�o es: unPrecio ! !


!classDefinition: #Propiedad category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Object subclass: #Propiedad
	instanceVariableNames: 'barrio modificadorDePrecio area'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!Propiedad methodsFor: 'initialization' stamp: 'HAW 12/5/2021 18:04:04'!
initializeUbicadaEn: unBarrio calculandoPrecioCon: unModificadorDePrecio de: unArea  
	
	barrio := unBarrio.
	modificadorDePrecio := unModificadorDePrecio.
	area := unArea.
	! !


!Propiedad methodsFor: 'costo' stamp: 'HAW 12/5/2021 18:04:04'!
costoUsando: unCostoDePropiedad en: unaFecha  
	
	^ modificadorDePrecio 
		precioFinalPara: (unCostoDePropiedad total: area ) 
		en: unaFecha! !


!Propiedad methodsFor: 'testing' stamp: 'HAW 12/5/2021 16:24:59'!
estaUbicadaEn: unBarrio

	^barrio = unBarrio ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Propiedad class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Propiedad class
	instanceVariableNames: ''!

!Propiedad class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 18:04:42'!
ubicadaEn: unBarrio calculandoPrecioCon: unModificadorDePrecio de: unArea  
	
	^self new initializeUbicadaEn: unBarrio calculandoPrecioCon: unModificadorDePrecio de: unArea ! !


!classDefinition: #TransaccionInmobiliaria category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Object subclass: #TransaccionInmobiliaria
	instanceVariableNames: 'fecha precio propiedad'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!TransaccionInmobiliaria methodsFor: 'accessing' stamp: 'HAW 12/5/2021 19:16:19'!
fecha
	
	^fecha ! !

!TransaccionInmobiliaria methodsFor: 'accessing' stamp: 'HAW 12/5/2021 19:16:23'!
precio
	
	^precio! !

!TransaccionInmobiliaria methodsFor: 'accessing' stamp: 'HAW 12/5/2021 19:16:27'!
propiedad
	
	^propiedad! !


!TransaccionInmobiliaria methodsFor: 'testing' stamp: 'HAW 12/5/2021 19:16:46'!
esDe: unaPropiedad 
	
	^propiedad = unaPropiedad ! !


!classDefinition: #Se�a category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
TransaccionInmobiliaria subclass: #Se�a
	instanceVariableNames: 'limite'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!Se�a methodsFor: 'initialization' stamp: 'HAW 12/5/2021 19:15:15'!
initializeDe: unaPropiedad en: unaFechaDeSe�a hasta: unaFechaLimite a: unPrecio 
	
	propiedad := unaPropiedad.
	fecha := unaFechaDeSe�a.
	limite := unaFechaLimite.
	precio := unPrecio.! !


!Se�a methodsFor: 'accessing' stamp: 'HAW 12/6/2021 18:17:36'!
diferenciaAPagar
	
	^precio - self valor! !

!Se�a methodsFor: 'accessing' stamp: 'HAW 12/6/2021 18:17:36'!
valor
	
	^precio / 10 ! !


!Se�a methodsFor: 'testing' stamp: 'HAW 12/5/2021 19:25:45'!
estaVencidaEn: unaFecha
 
	^unaFecha > limite ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Se�a class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Se�a class
	instanceVariableNames: ''!

!Se�a class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 19:23:28'!
de: unaPropiedad en: unaFechaDeSe�a hasta: unaFechaLimite a: unPrecio 
	
	self assert: unaFechaLimite esValidaPara: unaFechaDeSe�a.
	
	^self new initializeDe: unaPropiedad en: unaFechaDeSe�a hasta: unaFechaLimite a: unPrecio ! !


!Se�a class methodsFor: 'assertions' stamp: 'HAW 12/5/2021 19:23:47'!
assert: unaFechaLimite esValidaPara: unaFechaDeSe�a

	^ unaFechaLimite > unaFechaDeSe�a ifFalse: [ self error: self fechaLimiteSDeSe�aInvalidaErrorDescription ]! !

!Se�a class methodsFor: 'assertions' stamp: 'HAW 12/5/2021 19:21:11'!
fechaLimiteSDeSe�aInvalidaErrorDescription
	
	^'Fecha limite de se�a invalida'! !


!classDefinition: #Venta category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
TransaccionInmobiliaria subclass: #Venta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!

!Venta methodsFor: 'initialization' stamp: 'HAW 12/5/2021 16:14:33'!
initializeDe: unaPropiedad en: unaFechaDeVenta a: unPrecio 
	
	propiedad := unaPropiedad.
	fecha := unaFechaDeVenta.
	precio := unPrecio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Venta class' category: 'ISW1-2021-2C-Recuperatorio-2doParcial'!
Venta class
	instanceVariableNames: ''!

!Venta class methodsFor: 'instance creation' stamp: 'HAW 12/5/2021 16:13:34'!
de: unaPropiedad en: unaFechaDeVenta a: unPrecio 
	
	^self new initializeDe: unaPropiedad en: unaFechaDeVenta a: unPrecio ! !