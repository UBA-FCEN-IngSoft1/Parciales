!classDefinition: #TestDePerforación category: 'ISW1-2023-1C-Parcial-1'!
TestCase subclass: #TestDePerforación
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:53'!
test01CuandoExcavaSueloArenosoConMechaSoftRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:58:58'!
test02CuandoExcavaSueloTierraConMechaSoftNoModificaElSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:52'!
test03CuandoExcavaConcretoConMechaSoftSeRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:05'!
test04CuandoExcavaSueloArenosoConMechaWidiaRemueveCapaArenosa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	
	self assert: CapaDeSuelo tierra equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 17:59:09'!
test05CuandoExcavaSueloTierraConMechaWidiaEnDosImpactosTransformaLaCapaEnArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: CapaDeSuelo arenoso equals: excavadora capaDeSueloInmediata
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:02:45'!
test06CuandoExcavaSueloConcretoConMechaWidiaEnTresImpactosRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.	
			CapaDeSuelo tierra.
} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaWidia.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota.].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:00'!
test07CuandoExcavaSueloArenosoConMechaDiamanteRompeLaMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'Se rompió' equals: unError messageText.
			self assert: excavadora conMechaRota ].
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:43'!
test08CuandoExcavaSueloTierraConMechaDiamanteRemueveCapa

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo tierra.
			CapaDeSuelo concretoConResistencia: 5 } .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	
	self assert: (CapaDeSuelo concretoConResistencia: 5) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/8/2023 13:10:48'!
test09CuandoExcavaSueloConcretoConMechaDiamanteBajaUnDecimoDeResistencia

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo concretoConResistencia: 5.
			CapaDeSuelo tierra.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaDiamante.
	
	excavadora darGolpeDeTaladro.
	excavadora darGolpeDeTaladro.	
	
	self assert: (CapaDeSuelo concretoConResistencia: 4) equals: excavadora capaDeSueloInmediata

	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 4/27/2023 21:54:59'!
test10CuandoRemueveLaCapaYHayPiedrasLasRecolectaEnSuContainer

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			'Mica'.
			'Marmol'
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: {	'Mica'. 'Marmol'} equals: excavadora elementsInContainer
	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'HAW 5/3/2023 22:34:18'!
test11CuandoRemueveLaCapaYNoHayNadaNoRecogeNada

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	excavadora ponerMechaSoft.
	
	excavadora darGolpeDeTaladro.
	
	self assert: excavadora elementsInContainer isEmpty
	! !

!TestDePerforación methodsFor: 'test' stamp: 'ARM 5/5/2023 18:03:09'!
test12NoPuedePerforarSinMecha

	| excavadora sueloAExcavar |
	
	sueloAExcavar := {
			CapaDeSuelo arenoso.
			} .
	
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
		
	self should: [excavadora darGolpeDeTaladro]
		raise: Error
		withExceptionDo: [:unError |
			self assert: 'No puede perforar' equals: unError messageText.
			self assert: (CapaDeSuelo arenoso) equals: excavadora capaDeSueloInmediata ].	
	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 16:46:32'!
test13PuedeCalcularProfundidadDelSuelo

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso} .
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: excavadora calcularProfundidadDelSuelo.

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:08:24'!
test14PuedeContarLasCapasDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora contarCapas: #Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:08:37'!
test15PuedeContarLasCapasDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: #Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:08:48'!
test16PuedeContarLasCapasDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 1 equals: (excavadora contarCapas: #Concreto).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:10:17'!
test17PuedeCalcularProfundidadHastaPrimerCapaDeTipoArenoso

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 0 equals: (excavadora calcularProfundidadDelSueloHasta: #Arenoso).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:10:45'!
test18PuedeCalcularProfundidadHastaPrimerCapaDeTipoTierra

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 2 equals: (excavadora calcularProfundidadDelSueloHasta: #Tierra).

	! !

!TestDePerforación methodsFor: 'test' stamp: 'FRT 5/5/2023 17:11:10'!
test19PuedeCalcularProfundidadHastaPrimerCapaDeTipoConcreto

	| excavadora sueloAExcavar |
	
	sueloAExcavar := { CapaDeSuelo arenoso setAltura: 2. CapaDeSuelo tierra setAltura: 40. CapaDeSuelo arenoso. CapaDeSuelo concretoConResistencia: 10 }.
	excavadora := Perforadora sobreSuelo: sueloAExcavar.
	
	self assert: 42 equals: (excavadora calcularProfundidadDelSueloHasta: #Concreto).

	! !


!classDefinition: #CapaDeSuelo category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #CapaDeSuelo
	instanceVariableNames: 'tipo resistencia altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:54'!
initializeArenoso
	
	tipo := #Arenoso.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'ARM 5/8/2023 13:10:22'!
initializeConcretoConResistencia: resistenciaInicial 

	resistencia := resistenciaInicial.
	tipo := #Concreto.
	altura := nil.! !

!CapaDeSuelo methodsFor: 'initialization' stamp: 'FRT 5/5/2023 16:08:42'!
initializeTierra
	
	tipo := #Tierra.
	altura := nil.! !


!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:13:01'!
esArenoso
	^tipo = #Arenoso! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:15:50'!
esConcreto
	^tipo = #Concreto! !

!CapaDeSuelo methodsFor: 'tipo' stamp: 'ARM 4/27/2023 20:14:55'!
esTierra
	^tipo = #Tierra! !


!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
= unaCapaDeSuelo

	^(unaCapaDeSuelo isKindOf: self class) and: [ tipo = unaCapaDeSuelo tipo and: [resistencia = unaCapaDeSuelo resistencia]]! !

!CapaDeSuelo methodsFor: 'comparing' stamp: 'ARM 5/8/2023 13:10:22'!
hash

	^tipo hash + resistencia hash! !


!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
bajaUnDecimoDeResistencia
	resistencia := resistencia - 1! !

!CapaDeSuelo methodsFor: 'bajar resistencia' stamp: 'ARM 5/8/2023 13:10:22'!
sinResistencia
	^resistencia = 0! !


!CapaDeSuelo methodsFor: 'accessing' stamp: 'FRT 5/5/2023 16:48:52'!
altura

	^ altura.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 5/8/2023 13:10:35'!
resistencia

	^ resistencia.! !

!CapaDeSuelo methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:18:41'!
tipo

	^tipo! !


!CapaDeSuelo methodsFor: 'scan' stamp: 'FRT 5/5/2023 16:31:36'!
scan

	self esArenoso ifTrue: [ ^ 7 ].
	self esTierra ifTrue: [ ^ 10 ].
	^ 50. ! !


!CapaDeSuelo methodsFor: 'setters' stamp: 'FRT 5/5/2023 16:07:55'!
setAltura: unaAltura

	altura := unaAltura! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CapaDeSuelo class' category: 'ISW1-2023-1C-Parcial-1'!
CapaDeSuelo class
	instanceVariableNames: ''!

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:02:32'!
arenoso

	^self new initializeArenoso! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 5/5/2023 18:01:35'!
concretoConResistencia: resistencia 

	^self new initializeConcretoConResistencia: resistencia ! !

!CapaDeSuelo class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:03:15'!
tierra

	^self new initializeTierra! !


!classDefinition: #Perforadora category: 'ISW1-2023-1C-Parcial-1'!
Object subclass: #Perforadora
	instanceVariableNames: 'tipoDeSuelo mechaPuesta vecesQueGolpeoCapaActual capasDeSueloDebajo container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Parcial-1'!

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 5/1/2023 20:07:29'!
pasarAProximaCapa
	vecesQueGolpeoCapaActual := 0.
	capasDeSueloDebajo := capasDeSueloDebajo allButFirst.
	capasDeSueloDebajo ifEmpty: [^self]. 
	(capasDeSueloDebajo first isKindOf: CapaDeSuelo) ifFalse:[
			container addAll: capasDeSueloDebajo.
		]! !

!Perforadora methodsFor: 'cambiar capa' stamp: 'ARM 4/27/2023 20:46:30'!
transformarCapaEnArenoso
	capasDeSueloDebajo :=
			capasDeSueloDebajo allButFirst asOrderedCollection
			addFirst: CapaDeSuelo arenoso;
			yourself! !


!Perforadora methodsFor: 'excavation' stamp: 'ARM 5/5/2023 18:00:48'!
darGolpeDeTaladro
		
	self sinMecha ifTrue: [self error: 'No puede perforar'].

	vecesQueGolpeoCapaActual := vecesQueGolpeoCapaActual + 1.

	
	self sobreSueloArenoso ifTrue: [
		mechaPuesta = #Soft ifTrue: [ ^self pasarAProximaCapa ].
		mechaPuesta = #Widia ifTrue: [ ^self pasarAProximaCapa ].
		mechaPuesta = #Diamante ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió' ].
		^self].
	
	self sobreSueloTierra ifTrue: [
		mechaPuesta = #Soft ifTrue: [ ^self ].
		mechaPuesta = #Widia ifTrue: [ 
			vecesQueGolpeoCapaActual = 2 ifTrue: [ ^self transformarCapaEnArenoso ].
			^self ].
		mechaPuesta = #Diamante ifTrue: [ ^self pasarAProximaCapa ]].
	
	self sobreSueloConcreto ifTrue: [
		mechaPuesta = #Soft ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió'  ].
		mechaPuesta = #Widia ifTrue: [ 
			vecesQueGolpeoCapaActual = 3 ifTrue: [ mechaPuesta := #Rota. self error: 'Se rompió' ].
			^self ].
		mechaPuesta = #Diamante ifTrue: [ 
			vecesQueGolpeoCapaActual even ifTrue: [ capasDeSueloDebajo first bajaUnDecimoDeResistencia].
			capasDeSueloDebajo first sinResistencia ifTrue: [ ^self transformarCapaEnArenoso].
			^vecesQueGolpeoCapaActual ]].
	
	self error: 'error'! !


!Perforadora methodsFor: 'initialization' stamp: 'ARM 4/27/2023 21:57:52'!
initializeSobreSuelo: capasDeSueloAExcavarInicialmente

	capasDeSueloDebajo := capasDeSueloAExcavarInicialmente.
	vecesQueGolpeoCapaActual := 0.
	container := OrderedCollection new.
	mechaPuesta := #SinMecha! !


!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 20:17:21'!
capaDeSueloInmediata
	^capasDeSueloDebajo first! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:20:54'!
conMechaRota

	^mechaPuesta = #Rota! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:12:20'!
elementsInContainer
	^container asArray! !

!Perforadora methodsFor: 'accessing' stamp: 'ARM 4/27/2023 21:54:43'!
sinMecha

	^mechaPuesta = #SinMecha! !


!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:17'!
sobreSueloArenoso
	^capasDeSueloDebajo first esArenoso! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:16:14'!
sobreSueloConcreto
	^capasDeSueloDebajo first esConcreto! !

!Perforadora methodsFor: 'sobre qué suelo' stamp: 'ARM 4/27/2023 20:13:58'!
sobreSueloTierra
	^capasDeSueloDebajo first esTierra! !


!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 4/27/2023 20:50:48'!
ponerMechaDiamante
	mechaPuesta := #Diamante! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 4/27/2023 20:27:46'!
ponerMechaSoft
	mechaPuesta := #Soft! !

!Perforadora methodsFor: 'colocar mecha' stamp: 'ARM 4/27/2023 20:38:16'!
ponerMechaWidia
	mechaPuesta := #Widia! !


!Perforadora methodsFor: 'scan' stamp: 'FRT 5/5/2023 16:47:46'!
calcularProfundidadDelSuelo
	
	| acc ix |

	acc := 0.
	ix := 1.
	
	[ix <= capasDeSueloDebajo size] whileTrue: [ | capa altura |
		capa := capasDeSueloDebajo at: ix.
		altura := capa altura.
		altura = nil ifTrue: [ altura := 0 ].
		acc := acc + altura.
		ix := ix + 1.		
	].

	^ acc.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FRT 5/5/2023 17:16:25'!
calcularProfundidadDelSueloHasta: tipoDeCapa
	
	| valor acc ix |
	
	valor := 0.
	tipoDeCapa = #Arenoso ifTrue: [ valor := 7 ].
	tipoDeCapa = #Tierra ifTrue: [ valor := 10 ].
	tipoDeCapa = #Concreto ifTrue: [ valor := 50].	
	
	acc := 0.
	ix := 1.
	
	[ix <= capasDeSueloDebajo size] whileTrue: [ | capa altura |
		capa := capasDeSueloDebajo at: ix.
		
		valor = capa scan ifTrue: [ ^ acc ].
		
		altura := capa altura.
		altura = nil ifTrue: [ altura := 0 ].
		acc := acc + altura.
		ix := ix + 1.		
	].

	^ acc.
	
	 ! !

!Perforadora methodsFor: 'scan' stamp: 'FRT 5/5/2023 17:17:32'!
contarCapas: tipoDeCapa
	
	"Cuenta las capas de tipo tipoDeCapa. Recordar que para identificar cada capa se utiliza el valor de scan que retorna. Por ej. un capa tipo Arenoso retorna 7 al scan"
	
	| valor acc ix |
	
	valor := 0.
	tipoDeCapa = #Arenoso ifTrue: [ valor := 7 ].
	tipoDeCapa = #Tierra ifTrue: [ valor := 10 ].
	tipoDeCapa = #Concreto ifTrue: [ valor := 50].	
	
	acc := 0.
	ix := 1.
	
	[ix <= capasDeSueloDebajo size] whileTrue: [ | capa |
		capa := capasDeSueloDebajo at: ix.
		valor = capa scan ifTrue: [ acc := acc + 1 ].
		ix := ix + 1.		
	].

	^ acc! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Perforadora class' category: 'ISW1-2023-1C-Parcial-1'!
Perforadora class
	instanceVariableNames: ''!

!Perforadora class methodsFor: 'instance creation' stamp: 'ARM 4/27/2023 20:07:05'!
sobreSuelo: capasDeSueloAExcavar 

	^self new initializeSobreSuelo: capasDeSueloAExcavar ! !
