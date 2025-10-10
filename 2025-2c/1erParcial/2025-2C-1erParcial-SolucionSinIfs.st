!classDefinition: #Ambiente category: #'2025-2C-1erParcial'!
Object subclass: #Ambiente
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Ambiente methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:52'!
intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRover reduciendoAreaEn: reduccion utilizando: formaDeCaptura
	
	| areaDeAgarreEfectiva especimenesEnElAreaDeAgarre |
	
	areaDeAgarreEfectiva := unRover reducir: unAreaDeAgarre en: reduccion.
	
	especimenesEnElAreaDeAgarre := unRover especimenesDentroDeArea: areaDeAgarreEfectiva.
	
	especimenesEnElAreaDeAgarre do: [ :unEspecimen | formaDeCaptura value: unEspecimen value: areaDeAgarreEfectiva ]
	
	
	! !

!Ambiente methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:56'!
siendoNavegadoPor: unRover conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre

	self subclassResponsibility! !

!Ambiente methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:59'!
siendoNavegadoPor: unRover conBrazoRedEn: unMapa conAreaDeAgarre: areaDeAgarre

	self subclassResponsibility! !


!classDefinition: #Fangoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Fangoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Fangoso methodsFor: 'captura' stamp: 'NR 10/9/2025 20:58:58'!
siendoNavegadoPor: unRover conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre 
	
	"El suelo fangoso no afecta el area de agarre del brazo aspirador"
	
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRover reduciendoAreaEn: 0@0 utilizando: [ :unEspecimen : areaDeAgarre | unEspecimen enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: areaDeAgarre ]! !

!Fangoso methodsFor: 'captura' stamp: 'NR 10/3/2025 05:58:11'!
siendoNavegadoPor: unRover conBrazoRedEn: unMapa conAreaDeAgarre: unAreaDeAgarre
	
	"El movimiento de la red levanta el fango del lecho marino, reduciendo el arrastre de la misma"
	
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRover reduciendoAreaEn: 2@0 utilizando: [ :unEspecimen :areaDeAgarre | unEspecimen enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoRedCon: areaDeAgarre ]! !


!classDefinition: #Rocoso category: #'2025-2C-1erParcial'!
Ambiente subclass: #Rocoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Rocoso methodsFor: 'captura' stamp: 'NR 10/3/2025 05:58:17'!
siendoNavegadoPor: unRover conBrazoAspiradorEn: unMapa conAreaDeAgarre: unAreaDeAgarre
	
	"Cuando estamos en rocoso, debido al ángulo que necesitamos en el aspirador, el area de agarre se reduce en una fila"
	
	self intentarCapturarTodoEspecimenDe: unAreaDeAgarre por: unRover  reduciendoAreaEn: 0@1 utilizando: [ :unEspecimen :areaDeAgarre |  unEspecimen enUnAmbienteRocosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: areaDeAgarre ]! !

!Rocoso methodsFor: 'captura' stamp: 'NR 10/3/2025 05:58:20'!
siendoNavegadoPor: unRover conBrazoRedEn: unMapa conAreaDeAgarre: areaDeAgarre
	
	"Al intentar capturar con Red en Rocoso, la red se engancha, y siempre se rompe"
	
	unRover brazoDañado! !


!classDefinition: #BrazoRover category: #'2025-2C-1erParcial'!
Object subclass: #BrazoRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRover methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:09'!
extension

	self subclassResponsibility! !

!BrazoRover methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:12'!
utilizadoPor: unRover sobre: unAmbiente intentandoCapturaEn: unMapa

	self subclassResponsibility! !


!classDefinition: #Aspirador category: #'2025-2C-1erParcial'!
BrazoRover subclass: #Aspirador
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Aspirador methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:21'!
extension

	^ 3@3! !

!Aspirador methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:17'!
utilizadoPor: unRover sobre: unAmbiente intentandoCapturaEn: unMapa

	unAmbiente siendoNavegadoPor: unRover conBrazoAspiradorEn: unMapa conAreaDeAgarre: (unRover areaDeAgarreConExtension: self extension)! !


!classDefinition: #BrazoRed category: #'2025-2C-1erParcial'!
BrazoRover subclass: #BrazoRed
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!BrazoRed methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:25'!
extension

	^ 6@1! !

!BrazoRed methodsFor: 'captura' stamp: 'NR 10/3/2025 05:57:29'!
utilizadoPor: unRover sobre: unAmbiente intentandoCapturaEn: unMapa

	unAmbiente siendoNavegadoPor: unRover conBrazoRedEn: unMapa conAreaDeAgarre: (unRover areaDeAgarreConExtension: self extension)
! !


!classDefinition: #Especimen category: #'2025-2C-1erParcial'!
Object subclass: #Especimen
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Especimen methodsFor: 'captura' stamp: 'NR 10/3/2025 05:56:06'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva

	self subclassResponsibility! !

!Especimen methodsFor: 'captura' stamp: 'NR 10/3/2025 05:56:09'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoRedCon: unAreaDeAgarreEfectiva

	self subclassResponsibility! !

!Especimen methodsFor: 'captura' stamp: 'NR 10/3/2025 05:56:16'!
enUnAmbienteRocosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva 
 
	self subclassResponsibility! !


!classDefinition: #Escurridizo category: #'2025-2C-1erParcial'!
Especimen subclass: #Escurridizo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Escurridizo methodsFor: 'captura' stamp: 'NR 10/9/2025 20:57:05'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva 
	
	"Intenta escaparse"
	
	self partiendoDe: (unMapa at: self) seDesplaza: 1@1 dentroDeAreaDeAgarre: unAreaDeAgarreEfectiva del: unRover en: unMapa
! !

!Escurridizo methodsFor: 'captura' stamp: 'NR 10/9/2025 20:53:48'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoRedCon: unAreaDeAgarreEfectiva

	"Intenta escaparse"
	
	self partiendoDe: (unMapa at: self) seDesplaza: -1@0 dentroDeAreaDeAgarre: unAreaDeAgarreEfectiva del: unRover en: unMapa! !

!Escurridizo methodsFor: 'captura' stamp: 'NR 10/9/2025 20:56:46'!
enUnAmbienteRocosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva

	"Intenta escaparse"
	
	self partiendoDe: (unMapa at: self) seDesplaza: 0@1 dentroDeAreaDeAgarre: unAreaDeAgarreEfectiva del: unRover en: unMapa 	
! !


!Escurridizo methodsFor: 'movimiento' stamp: 'NR 10/9/2025 20:45:35'!
moverseEn: unMapa A: nuevaPosicionDeEspecimen

	^ unMapa at: self put: nuevaPosicionDeEspecimen! !

!Escurridizo methodsFor: 'movimiento' stamp: 'NR 10/9/2025 20:45:35'!
partiendoDe: unPunto seDesplaza: unDelta dentroDeAreaDeAgarre: unRectangulo del: unRover en: unMapa

	| nuevaPosicionDeEspecimen |
					
	nuevaPosicionDeEspecimen := unPunto + unDelta. 

	(unRectangulo containsPoint: nuevaPosicionDeEspecimen) 
		ifTrue: [ unRover capturaEspecimen: self ]
		ifFalse: [ self moverseEn: unMapa A: nuevaPosicionDeEspecimen ]! !


!classDefinition: #Perezoso category: #'2025-2C-1erParcial'!
Especimen subclass: #Perezoso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!Perezoso methodsFor: 'captura' stamp: 'NR 10/9/2025 20:52:37'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva
	
	"No tiene maniobras de escape, es capturado"
	
	unRover capturaEspecimen: self
! !

!Perezoso methodsFor: 'captura' stamp: 'NR 10/9/2025 20:53:34'!
enUnAmbienteFangosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoRedCon: unAreaDeAgarreEfectiva

	"Se sumerge en el fango y evita ser atrapado"
	! !

!Perezoso methodsFor: 'captura' stamp: 'NR 10/9/2025 20:54:18'!
enUnAmbienteRocosoDe: unMapa unRover: unRover intentaCapturarloUtilizandoBrazoAspiradorCon: unAreaDeAgarreEfectiva

	"No tiene maniobras de escape, es capturado"
	
	unRover capturaEspecimen: self! !


!classDefinition: #EstadoRover category: #'2025-2C-1erParcial'!
Object subclass: #EstadoRover
	instanceVariableNames: 'rover'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!EstadoRover methodsFor: 'captura' stamp: 'NR 10/3/2025 05:54:50'!
capturarSobreAmbiente: unAmbiente
	
	self subclassResponsibility ! !


!EstadoRover methodsFor: 'initialization' stamp: 'NR 10/3/2025 05:54:54'!
initializePara: unRover
	
	rover := unRover ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoRover class' category: #'2025-2C-1erParcial'!
EstadoRover class
	instanceVariableNames: ''!

!EstadoRover class methodsFor: 'instance creation' stamp: 'NR 10/3/2025 05:55:44'!
para: unRover
	
	^ self new initializePara: unRover ! !


!classDefinition: #ModoContingencia category: #'2025-2C-1erParcial'!
EstadoRover subclass: #ModoContingencia
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!ModoContingencia methodsFor: 'captura' stamp: 'NR 10/3/2025 05:55:55'!
capturarSobreAmbiente: unAmbiente
	
	rover capturarEnModoContingenciaSobreAmbiente: unAmbiente! !


!classDefinition: #ModoNormal category: #'2025-2C-1erParcial'!
EstadoRover subclass: #ModoNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!ModoNormal methodsFor: 'captura' stamp: 'NR 10/3/2025 05:55:59'!
capturarSobreAmbiente: unAmbiente
	
	rover capturarEnModoNormalSobre: unAmbiente
! !


!classDefinition: #RoverMarino category: #'2025-2C-1erParcial'!
Object subclass: #RoverMarino
	instanceVariableNames: 'mapa posicion tanque brazo estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!RoverMarino methodsFor: 'capturar' stamp: 'NR 10/3/2025 05:53:54'!
capturaEspecimen: unEspecimen
	
	mapa removeKey: unEspecimen.
	tanque add: unEspecimen! !

!RoverMarino methodsFor: 'capturar' stamp: 'NR 10/3/2025 05:53:58'!
capturarEnModoContingenciaSobreAmbiente: unAmbiente
	
	| areaDeAgarre especimenesEnElAreaDeAgarre |
	
	areaDeAgarre := self areaDeAgarreConExtension: 1@1.
	especimenesEnElAreaDeAgarre := self especimenesDentroDeArea: areaDeAgarre .
	
	especimenesEnElAreaDeAgarre do: [ :unEspecimen | self capturaEspecimen: unEspecimen ]
	
	! !

!RoverMarino methodsFor: 'capturar' stamp: 'NR 10/3/2025 05:54:01'!
capturarEnModoNormalSobre: unAmbiente 
	
	brazo utilizadoPor: self sobre: unAmbiente intentandoCapturaEn: mapa! !

!RoverMarino methodsFor: 'capturar' stamp: 'NR 10/3/2025 05:54:04'!
capturarSobreAmbiente: unAmbiente

	estado capturarSobreAmbiente: unAmbiente
! !

!RoverMarino methodsFor: 'capturar' stamp: 'NR 10/3/2025 05:54:07'!
especimenesDentroDeArea: areaDeAgarre
	
	^ (mapa select: [ :unaPosicion | areaDeAgarre containsPoint: unaPosicion ]) collect: [ :unaPosicion | mapa keyAtValue: unaPosicion ]! !


!RoverMarino methodsFor: 'initialization' stamp: 'NR 10/3/2025 05:54:10'!
initializeEn: unMapa sobre: unaPosicion equipadoCon: unBrazo  
	
	mapa := unMapa.
	posicion := unaPosicion.
	tanque := OrderedCollection new.
	brazo := unBrazo.
	
	estado := ModoNormal para: self! !


!RoverMarino methodsFor: 'testing' stamp: 'NR 10/3/2025 05:54:17'!
tanqueContieneA: unEspecimen 
	
	^ tanque includes: unEspecimen ! !

!RoverMarino methodsFor: 'testing' stamp: 'NR 10/3/2025 01:33:51'!
tanqueVacio
	
	^ tanque isEmpty! !


!RoverMarino methodsFor: 'brazo' stamp: 'NR 10/9/2025 21:00:07'!
brazoDañado

	estado := ModoContingencia para: self.
	
	self error: self class brazoDañadoErrorMessage! !


!RoverMarino methodsFor: 'areaDeAgarre' stamp: 'NR 10/3/2025 05:53:41'!
areaDeAgarreConExtension: unaExtension 
	
	^  Rectangle origin: posicion corner: posicion + unaExtension ! !

!RoverMarino methodsFor: 'areaDeAgarre' stamp: 'NR 10/9/2025 21:00:00'!
reducir: areaDeAgarre en: unDelta 
	
	^ areaDeAgarre extendBy: 0@0 - unDelta! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMarino class' category: #'2025-2C-1erParcial'!
RoverMarino class
	instanceVariableNames: ''!

!RoverMarino class methodsFor: 'instance creation' stamp: 'NR 10/3/2025 05:55:05'!
assertTieneEspecimenes: unMapa
	
	unMapa isEmpty ifTrue: [ self error: self elMapaDebeTenerEspecimenesErrorMessage ]
	
	! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'NR 10/3/2025 05:55:10'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto 
	
	^ self utilizando: unMapa paradoSobre: unPunto equipadoCon: Aspirador new! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'NR 10/3/2025 05:55:14'!
roverConRedUtilizando: unMapa paradoSobre: unPunto 
	
	^ self utilizando: unMapa paradoSobre: unPunto  equipadoCon: BrazoRed new! !

!RoverMarino class methodsFor: 'instance creation' stamp: 'NR 10/3/2025 05:55:18'!
utilizando: unMapa paradoSobre: unaPosicion equipadoCon: unBrazo 

	   self assertTieneEspecimenes: unMapa.
	
	^ self new initializeEn: unMapa sobre: unaPosicion equipadoCon: unBrazo ! !


!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 05:55:27'!
brazoDañadoErrorMessage
	
	^ 'El brazo se ha dañado. Imposible capturar' ! !

!RoverMarino class methodsFor: 'error messages' stamp: 'NR 10/3/2025 05:55:30'!
elMapaDebeTenerEspecimenesErrorMessage
	
	^ 'El mapa debe tener al menos un especimen para capturar'! !


!classDefinition: #CapturaSubmarinaTest category: #'2025-2C-1erParcial'!
TestCase subclass: #CapturaSubmarinaTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-2C-1erParcial'!

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'NR 10/3/2025 05:59:05'!
especimenEscurridizo

	^ Escurridizo new! !

!CapturaSubmarinaTest methodsFor: 'especimenes' stamp: 'NR 10/3/2025 05:59:08'!
especimenPerezoso

	^ Perezoso new! !


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


!CapturaSubmarinaTest methodsFor: 'simulaciones' stamp: 'NR 10/3/2025 05:59:16'!
simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: unAmbiente
	
	unRover capturarSobreAmbiente: unAmbiente
	
! !


!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'NR 10/3/2025 05:59:20'!
mapaCon: unEspecimen en: unaPosicion
	
	^ Dictionary newFrom: {unEspecimen -> unaPosicion}! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'NR 10/3/2025 05:59:23'!
mapaCon: unEspecimen en: unaPosicion y: otroEspecimen en: otraPosicion
	
	^ Dictionary newFrom: {unEspecimen -> unaPosicion. otroEspecimen -> otraPosicion}! !

!CapturaSubmarinaTest methodsFor: 'mapas' stamp: 'NR 10/3/2025 05:59:27'!
mapaVacio
	
	^ Dictionary new! !


!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'NR 10/3/2025 05:59:31'!
mapa: unMapa contiene: unEspecimen
	
	^ unMapa keys includes: unEspecimen! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'NR 10/3/2025 05:59:35'!
mapa: unMapa contiene: unEspecimen en: unPunto
	
	^ (unMapa at: unEspecimen) = unPunto! !

!CapturaSubmarinaTest methodsFor: 'assertions' stamp: 'NR 10/3/2025 05:59:38'!
verificarCapturaDeEspecimen: unEspecimen por: unRover
	
	^ unRover tanqueContieneA: unEspecimen! !


!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'NR 10/3/2025 05:59:43'!
roverConAspiradorUtilizando: unMapa paradoSobre: unPunto
	
	^ RoverMarino roverConAspiradorUtilizando: unMapa paradoSobre: unPunto! !

!CapturaSubmarinaTest methodsFor: 'rover' stamp: 'NR 10/3/2025 05:59:45'!
roverConRedUtilizando: unMapa paradoSobre: unPunto
	
	^ RoverMarino roverConRedUtilizando: unMapa paradoSobre: unPunto! !


!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'NR 10/3/2025 05:59:49'!
simularCapturaEnAmbienteFangosoUtilizando: unMapa capturandoCon: unRover
	
	^ self simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: Fangoso new! !

!CapturaSubmarinaTest methodsFor: 'ambientes' stamp: 'NR 10/3/2025 05:59:55'!
simularCapturaEnAmbienteRocosoUtilizando: unMapa capturandoCon: unRover

	^ self simularCapturaUtilizando: unMapa capturandoCon: unRover enAmbiente: Rocoso new! !
(Smalltalk at: #qq__ ifAbsentPut: [OrderedCollection new]) add: (#(54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 116 104 106 118 122 61 59 39 62 61 59 56 39 57 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 116 104 106 118 122 61 59 39 62 61 59 56 39 57 54 74 124 112 122 92 117 112 125 108 121 122 112 123 128 52 62 61 59 56 53 112 116 104 110 108 17 84 104 106 39 86 90 17 56 59 55 59 53 55 17 104 104 121 106 111 61 59 17 86 119 108 117 39 90 116 104 115 115 123 104 115 114 39 74 118 110 98 90 119 124 121 100 39 93 84 39 98 74 118 80 117 123 108 121 119 121 108 123 108 121 87 121 112 116 112 123 112 125 108 122 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 62 62 100 39 60 53 57 55 57 60 55 63 55 56 53 55 55 55 58 17 72 120 124 104 17 84 104 106 39 86 90 39 95 39 105 124 112 115 123 39 118 117 39 72 124 110 39 39 56 39 57 55 57 60 39 55 55 65 55 59 65 56 60 39 92 91 74 39 74 118 116 119 112 115 108 121 65 39 72 119 119 115 108 39 83 83 93 84 39 56 60 53 55 53 55 39 47 106 115 104 117 110 52 56 60 55 55 53 58 53 64 53 59 48 17 74 118 80 117 123 108 121 119 121 108 123 108 121 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 62 62 39 124 124 112 107 65 39 59 57 64 106 107 108 61 62 52 62 55 61 105 52 59 58 61 104 52 63 62 64 106 52 106 61 58 104 59 106 59 58 59 61 64 62 39 72 124 110 39 39 56 39 57 55 57 60 17 90 123 104 106 114 91 118 89 108 110 112 122 123 108 121 84 104 119 119 112 117 110 74 118 110 112 123 39 93 84 84 104 114 108 121 53 118 122 106 118 110 52 108 108 116 53 58 60 62 63 39 124 124 112 107 65 39 64 105 55 57 105 57 64 107 52 56 60 109 63 52 59 60 107 108 52 105 106 58 58 52 106 64 56 104 108 109 60 58 62 64 61 104 39 72 124 110 39 39 56 39 57 55 57 60 17 93 84 65 39 57 55 57 60 55 63 55 56 55 55 55 58 39 111 123 123 119 122 65 54 54 110 112 123 111 124 105 53 106 118 116 54 86 119 108 117 90 116 104 115 115 123 104 115 114 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 39 75 104 123 108 65 39 77 121 112 39 72 124 110 39 56 39 55 55 65 55 58 65 56 62 39 57 55 57 60 39 74 118 116 116 112 123 79 104 122 111 65 39 60 106 58 55 106 107 62 39 87 115 124 110 112 117 122 65 39 57 55 57 60 55 63 55 56 55 55 55 58 39 111 123 123 119 122 65 54 54 110 112 123 111 124 105 53 106 118 116 54 86 119 108 117 90 116 104 115 115 123 104 115 114 54 118 119 108 117 122 116 104 115 115 123 104 115 114 52 125 116 17 199 175 7 114 17 56 64 57 53 56 61 63 53 55 53 56 55 62 17 56 64 57 53 56 61 63 53 55 53 56 55 62 17 84 104 106 73 118 118 114 52 87 121 118 52 107 108 52 85 112 106 118 115 104 122 53 115 118 106 104 115 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 64 91 57 55 65 57 55 65 55 55 53 63 58 56 58 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 39 90 118 115 124 106 112 118 117 39 122 112 117 39 112 109 122 39 47 56 48 53 122 123 17 58 55 64 62 56 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 64 91 57 55 65 57 56 65 56 58 53 64 62 59 55 61 64 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 39 90 118 115 124 106 112 118 117 39 122 112 117 39 112 109 122 39 47 56 48 53 122 123 17 58 55 64 62 56 17 52 52 52 52 52 52 52 52 52 52 17 17 52 52 52 52 52 52 52 52 52 52 17 52 52 52 52 52 52 52 52 52 52 17 57 55 57 60 52 56 55 52 55 64 91 57 56 65 55 55 65 58 57 53 60 56 60 60 61 64 52 55 58 65 55 55 17 54 92 122 108 121 122 54 117 112 106 118 115 104 122 121 112 117 104 115 107 112 54 75 118 126 117 115 118 104 107 122 54 116 104 106 118 122 61 59 39 62 61 59 56 39 57 52 92 122 108 121 77 112 115 108 122 54 77 112 115 108 86 124 123 122 54 57 55 57 60 52 57 74 52 56 108 121 87 104 121 106 112 104 115 53 122 123 17 58 56 58 61 58 17 52 52 52 52 52 52 52 52 52 52 17 17))!