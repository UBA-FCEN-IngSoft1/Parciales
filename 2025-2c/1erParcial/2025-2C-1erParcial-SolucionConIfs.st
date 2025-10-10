!classDefinition: #CapturaSubmarinaTest category: '2025-2C-1erParcial-conIfs'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial-conIfs'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'JFGO 10/6/2025 18:02:49'!
especimenEscurridizo

	^#Escurridizo.! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'JFGO 10/6/2025 18:01:38'!
especimenPerezoso

	^#Perezoso.! !


!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test01LasSimulacionesDebenTenerEspecimenesACapturar

	self should: [ self roverConAspiradorUtilizando: self mapaVacio paradoSobre: 0@0 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception | self assert: exception messageText = RoverMarino elMapaDebeTenerEspecimenesErrorMessage ]


! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test02ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenPerezosoEnSuAreaDeAgarre

	|unRoverMaritimo unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMaritimo := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMaritimo.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMaritimo).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

	"   0 1 2 3 4
	0  x x x o o
	1  P x x o o
	2  x x x o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test03ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenPerezosoFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o x x x o
	3  o x x x o
	4  o o o o o

	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test04ElRoverUtilizandoBrazoAspiradorEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@0.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@3)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o x x x o o           0  o x x x o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o o o o o o          3  o o E o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test05ElRoverUtilizandoBrazoAspiradorEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x x x o o          3  o x E x o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test06ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 2@2)

	"   0 1 2 3 4 5
	0  x x x o o o
	1  x x x o o o
	2  o o P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test07ElRoverUtilizandoBrazoAspiradorEnSueloRocosoCapturaUnEspecimenPerezosoEnAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 2@2.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenPerezoso)

      "   0 1 2 3 4 5
	0  o o o o o o
	1  x x x o o o
	2  x x P o o o
	3  o o o o o o
	4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test08ElRoverUtilizandoBrazoAspiradorEnSueloRocosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@0.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 2@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  x x x o o o           0  x x x o o o
	1  x x E o o o           1  x x x o o o
	2  o o o o o o   ->  2  o o E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test09ElRoverUtilizandoBrazoApiradorEnSueloRocosoCapturaUnEspecimenEscurridizoQueSeMueveFueraDeAreaDeAgarreReducida

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 2@1.
	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

     "     0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  x x E o o o           1  x x x o o o
	2  x x x o o o   ->  2  x x E o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test10ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenPerezoso

	|unRoverMarino unMapa unEspecimenPerezoso |

	unEspecimenPerezoso:= self especimenPerezoso.
	unMapa := self mapaCon: unEspecimenPerezoso en: 0@1.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 0@1)

	"   0 1 2 3 4
	0  o o o o o
	1  P x x x o
	2  o o o o o
	3  o o o o o
	4  o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test11ElRoverUtilizandoBrazoRedEnSueloFangosoNoCapturaUnEspecimenEscurridizoQueSeMueveFueraDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 1@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  o E x x x o   ->  2  E x x x x o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test12ElRoverUtilizandoBrazoRedEnSueloFangosoCapturaUnEspecimenEscurridizoQueSeMueveDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unMapa := self mapaCon: unEspecimenEscurridizo en: (1@2).
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1  o o o o o o
	2  x E x x o o   ->  2  E x x x o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test13ElRoverUtilizandoBrazoRedEnSueloRocosoNoCapturaNingunEspecimenYRompeLaRed

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage
	]

	"   0 1 2 3 4 5 6
	0  o o o o o o o
	1  o o o o o o o
	2  E P x x x x o
	3  o o o o o o o
	4  o o o o o	 o o
	"
! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test14ElRoverCapturaTodosLosEspecimenesDentroDelAreaDeAgarre

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenEscurridizo |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenEscurridizo:= self especimenEscurridizo.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 1@2 y: otroEspecimenEscurridizo en: 2@2.

	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenEscurridizo por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenEscurridizo)

      "   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o          1   o o o o o o
	2  x E E x x x   ->  2  x x x o o o
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/6/2025 17:53:29'!
test15ElRoverCapturaTodosLosEspecimenesAunSiEstanEnLaMismaPosicion

	|unRoverMarino unMapa unEspecimenEscurridizo otroEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	otroEspecimenPerezoso:= self especimenPerezoso.

	unMapa := self mapaCon:  unEspecimenEscurridizo en: 1@2 y: otroEspecimenPerezoso en: 2@3.

	unRoverMarino := self roverConAspiradorUtilizando: unMapa paradoSobre: 1@1.

	self simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self assert: (self verificarCapturaDeEspecimen: otroEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self deny: (self mapa: unMapa contiene: otroEspecimenPerezoso)

	"   0 1 2 3 4 5               0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o x x x o o           1  o x x x o o
	2  o E x x o o   ->  2  o x x x o o
	3  o x P x o o          3  o x x x o o
	4  o o o o o o          4  o o o o o o
	"

	! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'JFGO 10/7/2025 19:47:34'!
test16ElRoverUtilizandoBrazoRedEnSueloRocosoSeRompeYCambiaAModoContingencia

	|unRoverMarino unMapa unEspecimenEscurridizo unEspecimenPerezoso |

	unEspecimenEscurridizo:= self especimenEscurridizo.
	unEspecimenPerezoso := self especimenPerezoso.

	unMapa := self mapaCon: unEspecimenEscurridizo en: 0@2 y: unEspecimenPerezoso en: 1@2.
	unRoverMarino := self roverConRedUtilizando: unMapa paradoSobre: 0@2.

	self should: [self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:exception |
		self deny: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
		self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
		self assert: (self mapa: unMapa contiene: unEspecimenEscurridizo en: 0@2).
		self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2).

		self assert: exception messageText = RoverMarino brazoDañadoErrorMessage .
	].

	 "  0 1 2 3 4 5              0 1 2 3 4 5
	0  o o o o o o           0  o o o o o o
	1  o o o o o o           1  o o o o o o
	2  E P x x x x   ->  2  x P x x x x
	3  o o o o o o          3  o o o o o o
	4  o o o o o o          4  o o o o o o
	"

	"Se hacen las capturas en modo contingencia"

	self simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRoverMarino.

	self assert: (self verificarCapturaDeEspecimen: unEspecimenEscurridizo por: unRoverMarino).
	self deny: (self verificarCapturaDeEspecimen: unEspecimenPerezoso por: unRoverMarino).
	self deny: (self mapa: unMapa contiene: unEspecimenEscurridizo).
	self assert: (self mapa: unMapa contiene: unEspecimenPerezoso en: 1@2)
! !


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'JFGO 10/7/2025 18:03:13'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente

	unRover capturarSobreAmbiente: unAmbiente.

! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'JFGO 10/6/2025 18:04:40'!
mapaCon: unEspecimen en: unaPosicion

	| mapa |
	mapa:= self mapaVacio .
	mapa at: unEspecimen put: unaPosicion.
	^mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'JFGO 10/6/2025 18:04:34'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion

	| mapa |
	mapa:= self mapaVacio .
	mapa at: unEspecimen put: unaPosicion.
	mapa at: otroEspecimen put: otraPosicion.
	^mapa.! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'JFGO 10/6/2025 17:54:37'!
mapaVacio

	^ Dictionary new.! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'JFGO 10/7/2025 18:34:11'!
mapa: unMapa contiene: unEspecimen
	
	^ unMapa keys includes: unEspecimen! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'JFGO 10/7/2025 18:34:05'!
mapa: unMapa contiene: unEspecimen en: unPunto
	
	^ (unMapa at: unEspecimen) = unPunto! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'JFGO 10/7/2025 18:33:39'!
verificarCapturaDeEspecimen: unEspecimen por: unRover
	
	^ unRover tanqueContieneA: unEspecimen! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'JFGO 10/6/2025 17:55:55'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto
	
	^ RoverMarino roverConAspiradorUtilizando: unMapa paradoSobre: unPunto! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'JFGO 10/6/2025 17:56:14'!
roverConRedUtilizando: unMapa paradoSobre: unPunto
	
	^ RoverMarino roverConRedUtilizando: unMapa paradoSobre: unPunto! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'JFGO 10/7/2025 18:04:06'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: #Fangoso.! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'JFGO 10/7/2025 18:03:53'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	self simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: #Rocoso.! !


!classDefinition: #RoverMarino category: '2025-2C-1erParcial-conIfs'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa posicion tanque brazo modo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial-conIfs'!

!RoverMarino methodsFor: 'initialization' stamp: 'JFGO 10/7/2025 19:48:57'!
initializeEn: unMapa sobre: unaPosicion equipadoCon: unBrazo  
	
	mapa := unMapa.
	posicion := unaPosicion.
	tanque := OrderedCollection new.
	brazo := unBrazo.
	modo:=#Normal.
	! !


!RoverMarino methodsFor: 'brazo' stamp: 'JFGO 10/7/2025 19:49:18'!
brazoDañado
	modo:= #Contingencia.
	self error: self class brazoDañadoErrorMessage.! !


!RoverMarino methodsFor: 'capturar' stamp: 'JFGO 10/7/2025 18:11:33'!
capturaEspecimen: unEspecimen
	
	mapa removeKey: unEspecimen.
	tanque add: unEspecimen! !

!RoverMarino methodsFor: 'capturar' stamp: 'JFGO 10/7/2025 19:55:03'!
capturarSobreAmbiente: unAmbiente
	| areaDeAgarre especimenesEnElAreaDeAgarre |
	(modo = #Contingencia) ifTrue:[
		areaDeAgarre := self areaDeAgarreConExtension: 1@1.
		especimenesEnElAreaDeAgarre := self especimenesDentroDeArea: areaDeAgarre .
		especimenesEnElAreaDeAgarre do: [ :unEspecimen | self capturaEspecimen: unEspecimen ].
	].
	
	(modo = #Normal) ifTrue:[
		brazo = #BrazoAspirador ifTrue:[ 
			areaDeAgarre := self areaDeAgarreConExtension: 3@3.
			
			(unAmbiente = #Fangoso) ifTrue: [
				"El suelo fangoso no afecta el area de agarre del brazo aspirador."
				especimenesEnElAreaDeAgarre := self especimenesDentroDeArea: areaDeAgarre.	
				especimenesEnElAreaDeAgarre do: [:unEspecimen | 
					(unEspecimen = #Perezoso) ifTrue:[
						"No tiene maniobras de escape, es capturado"
						self capturaEspecimen: unEspecimen.
					].
				
					(unEspecimen = #Escurridizo) ifTrue:[ | nuevaPosicionDeEspecimen  |
						"Intenta escaparse"
						nuevaPosicionDeEspecimen := (self posicionDe: unEspecimen) + (1@1). 
						
						(areaDeAgarre containsPoint: nuevaPosicionDeEspecimen) ifTrue: [
							"No pudo :("
							self capturaEspecimen: unEspecimen.	
						] ifFalse:[
							"Se escapa, el mapa debe conocer su nueva posicion"
							self nuevaPosicionDe: unEspecimen es: nuevaPosicionDeEspecimen.
						].
						
					]
				].
			].
		
			(unAmbiente = #Rocoso) ifTrue:[
				areaDeAgarre := self reducir: areaDeAgarre en: 0@1.
				especimenesEnElAreaDeAgarre := self especimenesDentroDeArea: areaDeAgarre.	
				especimenesEnElAreaDeAgarre do: [ :unEspecimen | 
					(unEspecimen = #Perezoso) ifTrue:[
						"No tiene maniobras de escape, es capturado"
						self capturaEspecimen: unEspecimen.
					].
					
					(unEspecimen = #Escurridizo) ifTrue:[ | nuevaPosicionDeEspecimen  |
						"Intenta escaparse"
						nuevaPosicionDeEspecimen := (self posicionDe: unEspecimen) + (0@1). 
						
						(areaDeAgarre containsPoint: nuevaPosicionDeEspecimen) ifTrue: [
							"No pudo :("
							self capturaEspecimen: unEspecimen.	
						] ifFalse:[
							"Se escapa, el mapa debe conocer su nueva posicion"
							self nuevaPosicionDe: unEspecimen es: nuevaPosicionDeEspecimen.
						].
						
					]
				].
			].
		].

		brazo = #BrazoRed ifTrue:[ 
			areaDeAgarre := self areaDeAgarreConExtension: 6@1.
			
			(unAmbiente = #Fangoso) ifTrue: [
				"El movimiento de la red levanta el fango del lecho marino, reduciendo el arrastre de la misma"
				areaDeAgarre := self reducir:  areaDeAgarre en: 2@0.
				especimenesEnElAreaDeAgarre := self especimenesDentroDeArea: areaDeAgarre.	
				
				especimenesEnElAreaDeAgarre do: [ :unEspecimen | 
					(unEspecimen = #Perezoso) ifTrue:[
						"Se sumerge en el fango y evita ser atrapado"
						
					].
					
					(unEspecimen = #Escurridizo) ifTrue:[ | nuevaPosicionDeEspecimen  |
						"Intenta escaparse"
						nuevaPosicionDeEspecimen := (self posicionDe: unEspecimen) + (-1@0). 
						
						(areaDeAgarre containsPoint: nuevaPosicionDeEspecimen) ifTrue: [
							"No pudo :("
							self capturaEspecimen: unEspecimen.	
						] ifFalse:[
							"Se escapa, el mapa debe conocer su nueva posicion"
							self nuevaPosicionDe: unEspecimen es: nuevaPosicionDeEspecimen.
						].
						
					]
				].
			].
			
			(unAmbiente = #Rocoso) ifTrue:[
				"Al intentar capturar con Red en Rocoso, la red se engancha, y siempre se rompe"
				self brazoDañado .
			].
		]
	].! !


!RoverMarino methodsFor: 'areaDeAgarre' stamp: 'JFGO 10/7/2025 18:16:08'!
areaDeAgarreConExtension: unaExtension 
	
	^  Rectangle origin: posicion corner: posicion + unaExtension ! !

!RoverMarino methodsFor: 'areaDeAgarre' stamp: 'JFGO 10/7/2025 19:18:09'!
reducir: areaDeAgarre en: unDelta 
	
	^ areaDeAgarre extendBy: 0@0 - unDelta.! !


!RoverMarino methodsFor: 'testing' stamp: 'JFGO 10/7/2025 18:34:46'!
tanqueContieneA: unEspecimen 
	
	^ tanque includes: unEspecimen ! !

!RoverMarino methodsFor: 'testing' stamp: 'JFGO 10/7/2025 18:34:41'!
tanqueVacio
	
	^ tanque isEmpty! !


!RoverMarino methodsFor: 'mapa' stamp: 'JFGO 10/7/2025 18:24:00'!
especimenesDentroDeArea: areaDeAgarre
	
	^ (mapa select: [ :unaPosicion | areaDeAgarre containsPoint: unaPosicion ]) collect: [ :unaPosicion | mapa keyAtValue: unaPosicion ]! !

!RoverMarino methodsFor: 'mapa' stamp: 'JFGO 10/7/2025 19:01:34'!
nuevaPosicionDe: unEspecimen es: nuevoPuntoDePosicion

	mapa at: unEspecimen put: nuevoPuntoDePosicion .! !

!RoverMarino methodsFor: 'mapa' stamp: 'JFGO 10/7/2025 18:52:24'!
posicionDe: unEspecimen

	^ mapa at: unEspecimen! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: '2025-2C-1erParcial-conIfs'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'instance creation' stamp: 'JFGO 10/6/2025 18:00:00'!
assertTieneEspecimenes: unMapa
	
	unMapa isEmpty ifTrue: [ self error: self elMapaDebeTenerEspecimenesErrorMessage ]
	
	! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'JFGO 10/6/2025 17:57:26'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto 
	
	^ self utilizando: unMapa paradoSobre: unPunto equipadoCon: #BrazoAspirador! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'JFGO 10/6/2025 17:57:57'!
roverConRedUtilizando: unMapa paradoSobre: unPunto 
	
	^ self utilizando: unMapa paradoSobre: unPunto equipadoCon: #BrazoRed! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'JFGO 10/6/2025 18:00:46'!
utilizando: unMapa paradoSobre: unaPosicion equipadoCon: unBrazo 

	self assertTieneEspecimenes: unMapa.
	
	^ self new initializeEn: unMapa sobre: unaPosicion equipadoCon: unBrazo ! !


!RoverMarino class methodsFor: 'error messages' stamp: 'JFGO 10/6/2025 17:53:29'!
brazoDañadoErrorMessage

	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'JFGO 10/6/2025 17:53:29'!
elMapaDebeTenerEspecimenesErrorMessage

	^ 'El mapa debe tener al menos un especimen para capturar'! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 99 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 61 58 60 55 53 112 116 104 110 108 17 94 112 117 58 57 17 56 55 53 55 17 95 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 39 56 64 39 84 104 121 106 111 39 57 55 57 58 100 17 94 112 117 107 118 126 122 17 94 112 117 58 57 39 105 124 112 115 123 39 118 117 39 84 104 121 39 56 64 39 57 55 57 58 39 57 56 65 55 60 65 55 60 39 74 118 116 119 112 115 108 121 65 39 74 115 104 117 110 39 56 60 53 55 53 62 17 78 108 117 108 121 104 123 108 107 39 118 117 39 130 56 64 39 84 104 121 106 111 39 57 55 57 58 39 53 39 61 65 55 55 65 56 61 39 119 116 132 53 39 74 118 116 119 112 115 108 107 39 118 117 39 84 104 121 39 56 64 39 57 55 57 58 17 78 108 117 108 121 104 123 108 107 39 118 117 39 130 56 64 39 84 104 121 106 111 39 57 55 57 58 39 53 39 61 65 55 55 65 57 63 39 119 116 132 53 39 74 118 116 119 112 115 108 107 39 118 117 39 84 104 121 39 56 64 39 57 55 57 58 17 93 84 65 39 57 55 57 58 55 58 56 64 57 56 55 55 52 118 122 106 118 110 52 108 108 116 52 58 58 55 60 39 111 123 123 119 122 65 54 54 110 112 123 111 124 105 53 106 118 116 54 104 117 110 108 115 128 104 117 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 90 124 117 39 84 104 121 39 56 64 39 56 63 65 55 55 65 60 63 39 57 55 57 58 39 74 118 116 116 112 123 79 104 122 111 65 39 108 55 104 61 107 106 56 39 87 115 124 110 112 117 122 65 39 57 55 57 58 55 58 56 64 57 56 55 55 52 118 122 106 118 110 52 108 108 116 52 58 58 55 60 39 111 123 123 119 122 65 54 54 110 112 123 111 124 105 53 106 118 116 54 104 117 110 108 115 128 104 117 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 179 25 135 8 17 56 62 57 53 56 63 53 56 57 63 53 56 17 81 92 83 80 78 86 90 91 53 116 122 111 118 116 108 53 117 108 123 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 61 91 56 63 65 55 60 65 56 58 53 58 62 62 60 63 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 56 64 58 55 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 61 91 56 63 65 55 60 65 58 63 53 61 55 57 60 63 63 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 106 118 117 80 109 122 53 122 123 17 56 64 58 58 64 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 62 91 56 64 65 59 62 65 58 55 53 57 55 56 61 55 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 106 118 117 80 109 122 53 122 123 17 57 57 57 63 62 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 62 91 56 64 65 60 60 65 56 59 53 64 60 55 61 55 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 106 118 117 80 109 122 53 122 123 17 57 59 59 62 58 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 62 91 56 64 65 60 60 65 58 63 53 62 60 64 61 55 64 52 55 58 65 55 55 17 74 65 99 92 122 108 121 122 99 113 124 115 112 102 99 106 118 122 104 122 99 92 73 72 99 112 122 126 56 99 107 118 106 108 117 106 112 104 99 106 124 112 122 58 99 126 112 117 107 118 126 122 61 59 52 92 122 108 121 77 112 115 108 122 99 77 112 115 108 86 124 123 122 99 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 52 106 118 117 80 109 122 53 122 123 17 57 59 59 62 58 17 52 52 52 52 52 52 52 52 52 52 17 17))!