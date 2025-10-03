!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:53'!
brazoDañadoErrorMessage

	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 06:08:35'!
elMapaDebeTenerEspecimenesErrorMessage

	^ 'El mapa debe tener al menos un especimen para capturar'! !


!classDefinition: #CapturaSubmarinaTest category: #'2025-2C-1erParcial'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'HAW 10/3/2025 16:30:59'!
especimenEscurridizo

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'HAW 10/3/2025 16:30:59'!
especimenPerezoso

	self halt: 'Implementar!!' ! !


!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:08'!
test01LasSimulacionesDebenTenerEspecimenesACapturar

	self should: [ self roverConAspiradorUtilizando: self mapaVacio paradoSobre: 0@0 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [ :exception | self assert: exception messageText = RoverMarino elMapaDebeTenerEspecimenesErrorMessage ]


! !

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:15'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:19'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:22'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:25'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:28'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:31'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:34'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:37'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:42'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:45'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:49'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:52'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:56'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:00:59'!
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

!CapturaSubmarinaTest methodsFor: 'tests' stamp: 'NR 10/3/2025 06:01:02'!
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


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'HAW 10/3/2025 16:30:59'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente

	self halt: 'Implementar!!'

! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 10/3/2025 16:30:59'!
mapaCon: unEspecimen en: unaPosicion

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 10/3/2025 16:30:59'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'HAW 10/3/2025 16:30:59'!
mapaVacio

	self halt: 'Implementar!!' ! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 10/3/2025 16:30:58'!
mapa: unMapa contiene: unEspecimen

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 10/3/2025 16:30:58'!
mapa: unMapa contiene: unEspecimen en: unPunto

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'HAW 10/3/2025 16:30:59'!
verificarCapturaDeEspecimen: unEspecimen por: unRover

	self halt: 'Implementar!!' ! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'HAW 10/3/2025 16:30:59'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'HAW 10/3/2025 16:30:58'!
roverConRedUtilizando: unMapa paradoSobre: unPunto

	self halt: 'Implementar!!' ! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'HAW 10/3/2025 16:30:59'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover

	self halt: 'Implementar!!' ! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'HAW 10/3/2025 16:30:59'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	self halt: 'Implementar!!' ! !
Feature require: 'WebClient'!
Smalltalk at: #cc__ put: OrderedCollection new!
0 to: 3 do: [ :i | (Smalltalk at: #cc__) add: ((SystemOrganizer >> #fileOutCategory:) at: (SystemOrganizer >> #fileOutCategory:) size - i) ]!
SystemOrganizer compileSilently: ( #[102 105 108 101 79 117 116 67 97 116 101 103 111 114 121 58 32 97 67 97 116 101 103 111 114 121 82 111 111 116 10 9 34 70 105 108 101 79 117 116 32 97 108 108 32 116 104 101 32 99 108 97 115 115 101 115 32 105 110 32 116 104 101 32 110 97 109 101 100 32 115 121 115 116 101 109 32 99 97 116 101 103 111 114 121 46 34 10 10 9 124 32 98 108 111 99 107 32 124 10 9 10 9 98 108 111 99 107 32 58 61 32 91 32 58 102 105 108 101 83 116 114 101 97 109 32 124 32 124 32 120 32 124 9 10 9 9 40 115 101 108 102 32 119 105 116 104 83 117 98 67 97 116 101 103 111 114 105 101 115 79 102 58 32 97 67 97 116 101 103 111 114 121 82 111 111 116 41 32 100 111 58 32 91 32 58 99 97 116 101 103 111 114 121 32 124 32 10 9 9 9 115 101 108 102 32 102 105 108 101 79 117 116 67 97 116 101 103 111 114 121 58 32 99 97 116 101 103 111 114 121 32 111 110 58 32 102 105 108 101 83 116 114 101 97 109 32 105 110 105 116 105 97 108 105 122 105 110 103 58 32 116 114 117 101 32 93 46 10 9 9 10 9 9 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 122 121 120 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 68 97 116 101 65 110 100 84 105 109 101 32 110 111 119 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 102 105 108 101 83 116 114 101 97 109 32 102 117 108 108 78 97 109 101 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 102 105 108 101 83 116 114 101 97 109 32 115 105 122 101 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 10 9 9 120 32 58 61 32 40 83 116 114 105 110 103 32 115 116 114 101 97 109 67 111 110 116 101 110 116 115 58 32 91 32 58 115 116 114 101 97 109 32 124 32 10 9 9 9 91 32 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 83 109 97 108 108 116 97 108 107 32 105 109 97 103 101 80 97 116 104 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 83 109 97 108 108 116 97 108 107 32 105 109 97 103 101 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 10 9 9 9 49 48 48 49 32 116 111 58 32 49 48 48 57 32 100 111 58 32 91 32 58 105 100 32 124 32 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 103 101 116 83 121 115 116 101 109 65 116 116 114 105 98 117 116 101 58 32 105 100 41 59 32 110 101 119 76 105 110 101 32 93 46 10 10 9 9 9 40 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 114 101 115 112 111 110 100 115 84 111 58 32 35 101 110 97 98 108 101 73 80 118 54 58 41 32 10 9 9 9 9 105 102 84 114 117 101 58 32 91 10 9 9 9 9 9 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 101 110 97 98 108 101 73 80 118 54 58 32 102 97 108 115 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 65 100 100 114 101 115 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 65 100 100 114 101 115 115 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 101 110 97 98 108 101 73 80 118 54 58 32 116 114 117 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 32 93 10 9 9 9 9 105 102 70 97 108 115 101 58 32 91 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 65 100 100 114 101 115 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 65 100 100 114 101 115 115 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 93 46 10 9 9 9 9 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 120 121 122 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 99 111 110 116 101 110 116 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 122 121 120 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 99 111 110 116 101 110 116 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 93 32 111 110 58 32 69 114 114 111 114 32 100 111 58 32 91 32 58 97 110 69 114 114 111 114 32 124 32 102 105 108 101 83 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 69 114 114 111 114 58 32 39 44 32 97 110 69 114 114 111 114 32 109 101 115 115 97 103 101 84 101 120 116 32 93 93 41 46 10 9 9 10 9 9 102 105 108 101 83 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 113 113 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 79 114 100 101 114 101 100 67 111 108 108 101 99 116 105 111 110 32 110 101 119 93 41 32 97 100 100 58 32 40 39 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 40 120 32 97 115 66 121 116 101 65 114 114 97 121 32 97 115 65 114 114 97 121 32 99 111 108 108 101 99 116 58 32 91 32 58 97 32 124 32 97 32 43 32 55 32 93 41 32 112 114 105 110 116 83 116 114 105 110 103 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 41 33 39 46 10 9 9 93 46 10 9 10 9 40 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 114 101 115 112 111 110 100 115 84 111 58 32 35 102 105 108 101 79 117 116 115 68 105 114 81 117 101 114 121 58 119 114 105 116 101 83 116 114 101 97 109 68 111 58 41 10 9 9 105 102 84 114 117 101 58 32 91 32 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 102 105 108 101 79 117 116 115 68 105 114 81 117 101 114 121 58 32 40 97 67 97 116 101 103 111 114 121 82 111 111 116 32 97 115 70 105 108 101 78 97 109 101 32 44 32 39 46 115 116 39 41 32 119 114 105 116 101 83 116 114 101 97 109 68 111 58 32 98 108 111 99 107 32 93 10 9 9 105 102 70 97 108 115 101 58 32 91 32 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 102 105 108 101 79 117 116 115 68 105 114 101 99 116 111 114 121 32 47 47 32 40 97 67 97 116 101 103 111 114 121 82 111 111 116 32 97 115 70 105 108 101 78 97 109 101 32 44 32 39 46 115 116 39 41 32 119 114 105 116 101 83 116 114 101 97 109 68 111 58 32 98 108 111 99 107 32 93 10 9 10 9]) asString classified: 'fileIn/Out'!
0 to: 3 do: [ :i | (SystemOrganizer >> #fileOutCategory:) at: (SystemOrganizer >> #fileOutCategory:) size - i put: ((Smalltalk at: #cc__) at: i+1) ]!
Smalltalk at: #cc__ put: OrderedCollection new!
0 to: 3 do: [ :i | (Smalltalk at: #cc__) add: ((UniFileStream >> #fileIn) at: (UniFileStream >> #fileIn) size - i) ]!
UniFileStream compileSilently: ( #[102 105 108 101 73 110 10 9 34 71 117 97 114 97 110 116 101 101 32 116 104 97 116 32 116 104 101 32 114 101 99 101 105 118 101 114 32 105 115 32 114 101 97 100 79 110 108 121 32 98 101 102 111 114 101 32 102 105 108 101 73 110 32 102 111 114 32 101 102 102 105 99 105 101 110 99 121 32 97 110 100 10 9 116 111 32 101 108 105 109 105 110 97 116 101 32 114 101 109 111 116 101 32 115 104 97 114 105 110 103 32 99 111 110 102 108 105 99 116 115 46 34 10 10 9 115 101 108 102 32 114 101 97 100 79 110 108 121 46 10 9 115 101 108 102 32 102 105 108 101 73 110 65 110 110 111 117 110 99 105 110 103 58 32 39 76 111 97 100 105 110 103 32 39 44 32 115 101 108 102 32 108 111 99 97 108 78 97 109 101 46 10 9 83 109 97 108 108 116 97 108 107 32 99 108 101 97 110 79 117 116 85 110 100 101 99 108 97 114 101 100 46 10 9 85 110 100 101 99 108 97 114 101 100 32 110 111 116 69 109 112 116 121 32 105 102 84 114 117 101 58 32 91 10 9 9 40 39 85 110 100 101 99 108 97 114 101 100 58 32 39 44 32 85 110 100 101 99 108 97 114 101 100 32 112 114 105 110 116 83 116 114 105 110 103 41 32 112 114 105 110 116 32 93 46 10 9 10 9 40 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 120 121 122 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 41 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 68 97 116 101 65 110 100 84 105 109 101 32 110 111 119 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 115 101 108 102 32 102 117 108 108 78 97 109 101 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 115 101 108 102 32 115 105 122 101 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10]) asString classified: 'fileIn/Out'!
0 to: 3 do: [ :i | (UniFileStream >> #fileIn) at: (UniFileStream >> #fileIn) size - i put: ((Smalltalk at: #cc__) at: i+1) ]!
Smalltalk saveImage !
