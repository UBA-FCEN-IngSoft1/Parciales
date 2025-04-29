!classDefinition: #TestsDungeonGame category: #'ISW-1erParcial'!
TestCase subclass: #TestsDungeonGame
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:00'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:02'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:05'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:09'!
test04UnAventureroNoPuedeAtacarSinItemsEquipados

	| guerrero ogro espada |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	espada := self crearEspadaPara: ogro.
	
	self should: [ guerrero atacarA: ogro con: (espada) ] 
		raise: Error-MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
			self assert: (ogro tienePuntosDeVida: 15 * pv)
	]
	! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:12'!
test05UnGuerreroConEspadaProvocaDañoSegunSuFuerza

	| guerrero ogro itemDeAtaque otroItemDeAtaque otroOgro |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	otroOgro := self crearOgro.
	otroItemDeAtaque := self crearEspadaPara: otroOgro.
	guerrero equiparItemDeAtaque: otroItemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: otroOgro con: otroItemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (otroOgro tienePuntosDeVida: 15 * pv - (4 * pv)).
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:14'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/11/2024 01:19:47'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0 * pv)! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/11/2024 01:19:52'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0 * pv)
	! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:23'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:27'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:31'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:32:33'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !

!TestsDungeonGame methodsFor: 'tests' stamp: 'NR 11/9/2024 17:16:36'!
test13PersonajeNoPuedeQuedarConVidaNegativa

	| guerrero goblin |
	
	guerrero := self crearGuerrero.
	goblin := self crearGoblin.
	
	goblin atacarA: guerrero.
	goblin atacarA: guerrero.
	goblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 0 * pv)! !


!TestsDungeonGame methodsFor: 'crear items' stamp: 'NR 11/9/2024 17:31:29'!
crearArmadura

	^ ItemDeDefensa armadura! !

!TestsDungeonGame methodsFor: 'crear items' stamp: 'NR 11/9/2024 17:31:34'!
crearBaculo

	^ Baculo new! !

!TestsDungeonGame methodsFor: 'crear items' stamp: 'NR 11/9/2024 17:31:37'!
crearEscudoMagico

	^ ItemDeDefensa escudoMagico! !

!TestsDungeonGame methodsFor: 'crear items' stamp: 'NR 11/9/2024 17:31:40'!
crearEspadaPara: monstruo

	^ Espada conObjetivo: monstruo! !


!TestsDungeonGame methodsFor: 'crear combatientes' stamp: 'NR 11/9/2024 17:31:47'!
crearGoblin

	^ Goblin new! !

!TestsDungeonGame methodsFor: 'crear combatientes' stamp: 'NR 11/9/2024 17:31:50'!
crearGuerrero

	^ Guerrero new! !

!TestsDungeonGame methodsFor: 'crear combatientes' stamp: 'NR 11/9/2024 17:31:53'!
crearMago

	^ Mago new! !

!TestsDungeonGame methodsFor: 'crear combatientes' stamp: 'NR 11/9/2024 17:31:56'!
crearOgro

	^ Ogro new! !


!TestsDungeonGame methodsFor: 'tests - derrotado' stamp: 'NR 11/9/2024 16:46:01'!
test14AtaquesDeAventureroDerrotadoNoTienenEfecto

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro atacarA: guerrero.
	ogro atacarA: guerrero.
		
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: ogro con: itemDeAtaque.

	self assert: (guerrero tienePuntosDeVida: 0 * pv). 
	self assert: (ogro tienePuntosDeVida: 15 * pv)
! !

!TestsDungeonGame methodsFor: 'tests - derrotado' stamp: 'NR 11/9/2024 17:31:03'!
test15NoTieneEfectoEquiparItemsDeAtaqueEnAventureroDerrotado

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	ogro atacarA: guerrero.
	ogro atacarA: guerrero.
	
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	
	self should: [
		guerrero assertEquipaItem: itemDeAtaque 
	] raise: Error-MessageNotUnderstood withExceptionDo: [ :anException |
		self assert: anException messageText equals: guerrero itemNoDisponibleMensajeDeError.
		self assert: (guerrero tienePuntosDeVida: 0 * pv)
	].

! !

!TestsDungeonGame methodsFor: 'tests - derrotado' stamp: 'NR 11/9/2024 17:31:11'!
test16NoTieneEfectoEquiparItemsDeDefensaEnAventureroDerrotado

	| guerrero ogro itemDeDefensa |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	ogro atacarA: guerrero.
	ogro atacarA: guerrero.
	
	itemDeDefensa := self crearArmadura.
	guerrero equiparItemDeDefensa: itemDeDefensa.
	
	self assert: (guerrero puntosDeDefensa) equals: (0 * pv)
	
	
! !

!TestsDungeonGame methodsFor: 'tests - derrotado' stamp: 'NR 11/9/2024 17:31:19'!
test17MonstruoNoPuedeAtacarSiFueDerrotado

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	4 timesRepeat: [ guerrero atacarA: ogro con: itemDeAtaque ].
	
	self should: [
		ogro atacarA: guerrero.
	] raise: Error-MessageNotUnderstood withExceptionDo: [ :anException |
		self assert: anException messageText equals: ogro monstruoDerrotadoNoPuedeAtacarMensajeDeError.
		self assert: (guerrero tienePuntosDeVida: 10 * pv)
	].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TestsDungeonGame class' category: #'ISW-1erParcial'!
TestsDungeonGame class
	instanceVariableNames: ''!

!TestsDungeonGame class methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:14:18'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !


!classDefinition: #EstadoDeAventurero category: #'ISW-1erParcial'!
Object subclass: #EstadoDeAventurero
	instanceVariableNames: 'aventurero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!EstadoDeAventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 15:52:12'!
equiparItemDeAtaque: unItemDeAtaque

	self subclassResponsibility! !

!EstadoDeAventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 15:52:16'!
equiparItemDeDefensa: unItemDeDefensa

	self subclassResponsibility! !


!EstadoDeAventurero methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:26:57'!
atacarA: unItemDeAtaque con: unMonstruo

	self subclassResponsibility ! !


!EstadoDeAventurero methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:27:00'!
initializePara: unAventurero

	aventurero := unAventurero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeAventurero class' category: #'ISW-1erParcial'!
EstadoDeAventurero class
	instanceVariableNames: ''!

!EstadoDeAventurero class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:25:23'!
para: unAventurero

	^ self new initializePara: unAventurero! !


!classDefinition: #AventureroDerrotado category: #'ISW-1erParcial'!
EstadoDeAventurero subclass: #AventureroDerrotado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!AventureroDerrotado methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:25:29'!
atacarA: unItemDeAtaque con: unMonstruo

	aventurero derrotado

	! !


!AventureroDerrotado methodsFor: 'equipar' stamp: 'NR 11/10/2024 23:25:32'!
equiparItemDeAtaque: unItemDeAtaque

	aventurero derrotado

	! !

!AventureroDerrotado methodsFor: 'equipar' stamp: 'NR 11/9/2024 15:50:12'!
equiparItemDeDefensa: unItemDeDefensa

	aventurero derrotado

	! !


!classDefinition: #AventureroEnCombate category: #'ISW-1erParcial'!
EstadoDeAventurero subclass: #AventureroEnCombate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!AventureroEnCombate methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:25:41'!
atacarA: unItemDeAtaque con: unMonstruo

	aventurero atacarEnCombateA: unMonstruo con: unItemDeAtaque! !


!AventureroEnCombate methodsFor: 'recibir daño' stamp: 'NR 11/9/2024 16:40:56'!
equiparItemDeAtaque: unItemDeAtaque

	aventurero equiparItemDeAtaqueEnCombate: unItemDeAtaque ! !

!AventureroEnCombate methodsFor: 'recibir daño' stamp: 'NR 11/9/2024 16:41:25'!
equiparItemDeDefensa: unItemDeDefensa

	aventurero equiparItemDeDefensaEnCombate: unItemDeDefensa ! !


!classDefinition: #EstadoDeMonstruo category: #'ISW-1erParcial'!
Object subclass: #EstadoDeMonstruo
	instanceVariableNames: 'monstruo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!EstadoDeMonstruo methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:57'!
atacarA: unAventurero

	self subclassResponsibility ! !


!EstadoDeMonstruo methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:25:00'!
initializePara: unMonstruo

	monstruo := unMonstruo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeMonstruo class' category: #'ISW-1erParcial'!
EstadoDeMonstruo class
	instanceVariableNames: ''!

!EstadoDeMonstruo class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:25:04'!
para: unMonstruo

	^ self new initializePara: unMonstruo ! !


!classDefinition: #MonstruoDerrotado category: #'ISW-1erParcial'!
EstadoDeMonstruo subclass: #MonstruoDerrotado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!MonstruoDerrotado methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:53'!
atacarA: unAventurero

	monstruo derrotado
! !


!classDefinition: #MonstruoEnCombate category: #'ISW-1erParcial'!
EstadoDeMonstruo subclass: #MonstruoEnCombate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!MonstruoEnCombate methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:49'!
atacarA: unAventurero

	monstruo atacarEnCombateA: unAventurero! !


!classDefinition: #ItemDeAtaque category: #'ISW-1erParcial'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!ItemDeAtaque methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:42'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	self subclassResponsibility! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:39'!
atacarSiendoMago: unMago a: unMonstruo

	self subclassResponsibility! !


!classDefinition: #Baculo category: #'ISW-1erParcial'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Baculo methodsFor: 'ataque DD' stamp: 'NR 11/10/2024 23:24:07'!
atacarConGuerrero: unGuerrero aGoblin: unGoblin

	unGoblin duplicarPuntosDeVida
	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 11/10/2024 23:24:09'!
atacarConGuerrero: unGuerrero aOgro: unOgro

	unGuerrero dañarConSuFuerzaA: unOgro

	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 11/10/2024 23:24:12'!
atacarConMago: unMago aGoblin: unGoblin

	unGoblin perderTodosLosPuntosDeVida

	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 11/10/2024 23:24:16'!
atacarConMago: unMago aOgro: unOgro

	unMago dañarConSuFuerzaA: unOgro

	

! !


!Baculo methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:20'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	unMonstruo serAtacadoPorGuerrero: unGuerrero conBaculo: self.! !

!Baculo methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:24:23'!
atacarSiendoMago: unMago a: unMonstruo

	unMonstruo serAtacadoPorMago: unMago conBaculo: self! !


!classDefinition: #Espada category: #'ISW-1erParcial'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoEnemigo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Espada methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:23:36'!
initializeConObjetivo: unMonstruoEnemigo

	monstruoEnemigo := unMonstruoEnemigo! !


!Espada methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:23:20'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	(self tieneComoObjetivoA: unMonstruo) ifTrue: [ unGuerrero dañarConSuFuerzaA: unMonstruo]! !

!Espada methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:23:23'!
atacarSiendoMago: unMago a: unMonstruo

	unMago perderTodosLosPuntosDeVida! !

!Espada methodsFor: 'ataque' stamp: 'NR 11/10/2024 23:23:30'!
tieneComoObjetivoA: unMonstruo

	^ unMonstruo = monstruoEnemigo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'ISW-1erParcial'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:23:52'!
conObjetivo: unMonstruoEnemigo

	(self assertAlturaMenorA1Metro: unMonstruoEnemigo) ifTrue: [ self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ].
	
	^ self new initializeConObjetivo: unMonstruoEnemigo! !


!Espada class methodsFor: 'asserts' stamp: 'NR 11/10/2024 23:23:48'!
assertAlturaMenorA1Metro: unMonstruoEnemigo

	^ unMonstruoEnemigo tieneAlturaMenorA: 1 * meter! !


!Espada class methodsFor: 'error messages' stamp: 'NR 11/10/2024 23:23:56'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	
	^ 'No se puede atacar a monstruo de altura menor a un metro'! !


!classDefinition: #ItemDeDefensa category: #'ISW-1erParcial'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'puntosDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!ItemDeDefensa methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:22:55'!
initializeCon: unosPuntosDeDefensa

	puntosDeDefensa := unosPuntosDeDefensa! !


!ItemDeDefensa methodsFor: 'accessing' stamp: 'NR 11/10/2024 23:22:59'!
puntosDeDefensa

	^ puntosDeDefensa! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'ISW-1erParcial'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:23:12'!
armadura

	^ self con: 5 * pv! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:23:08'!
con: puntosDeVidaDeResistencia

	^ self new initializeCon: puntosDeVidaDeResistencia ! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'NR 11/10/2024 23:23:05'!
escudoMagico

	^ self con: 3 * pv! !


!classDefinition: #Personaje category: #'ISW-1erParcial'!
Object subclass: #Personaje
	instanceVariableNames: 'puntosDeVida estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Personaje methodsFor: 'testing' stamp: 'NR 11/10/2024 23:22:46'!
tienePuntosDeVida: unaCantidadDePuntosDeVidaEsperada

	^ puntosDeVida = unaCantidadDePuntosDeVidaEsperada! !


!Personaje methodsFor: 'actualizar estado - bonus' stamp: 'NR 11/10/2024 23:22:39'!
personajeFueDerrotado

	self subclassResponsibility 

	! !


!Personaje methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:18:33'!
dañoEfectivo: cantidadDeDañoEfectuado
	
	self subclassResponsibility ! !

!Personaje methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:36:49'!
pasarADerrotadoSiVidaLlegaACero

	^ puntosDeVida = (0 * pv)  ifTrue: [ self personajeFueDerrotado ]! !

!Personaje methodsFor: 'recibir daño' stamp: 'NR 11/11/2024 01:20:32'!
perderTodosLosPuntosDeVida

	puntosDeVida := 0 * pv.
	self personajeFueDerrotado! !

!Personaje methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:50:58'!
puntosDeVida: unaCantidadDePuntosDeVida

	puntosDeVida = unaCantidadDePuntosDeVida ! !

!Personaje methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:22:42'!
recibirDañoPor: cantidadDeDañoEfectuado
	
	| puntosDeVidaARestar |
	
	puntosDeVidaARestar := (self dañoEfectivo: cantidadDeDañoEfectuado) max: 0.
	puntosDeVida := (puntosDeVida - puntosDeVidaARestar) max: (0 * pv).
	
	self pasarADerrotadoSiVidaLlegaACero! !


!Personaje methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:22:30'!
derrotado

	self subclassResponsibility 
	! !


!classDefinition: #Aventurero category: #'ISW-1erParcial'!
Personaje subclass: #Aventurero
	instanceVariableNames: 'fuerza itemsDeAtaque itemsDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Aventurero methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:18:08'!
initialize

	itemsDeDefensa := Set new.
	itemsDeAtaque := Set new.
	estado := AventureroEnCombate para: self
	
	! !


!Aventurero methodsFor: 'atacar' stamp: 'NR 11/10/2024 15:45:14'!
atacarA: unMonstruo con: unItemDeAtaque

	self assertEquipaItem: unItemDeAtaque.

	estado atacarA: unItemDeAtaque con: unMonstruo! !

!Aventurero methodsFor: 'atacar' stamp: 'NR 11/9/2024 15:59:49'!
atacarEnCombateA: unMonstruo con: unItemDeAtaque 

	self subclassResponsibility ! !

!Aventurero methodsFor: 'atacar' stamp: 'NR 11/9/2024 20:57:47'!
dañarConSuFuerzaA: unMonstruo

	unMonstruo recibirDañoPor: fuerza
! !

!Aventurero methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:17:20'!
derrotado
	! !


!Aventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 16:40:16'!
equiparItemDeAtaque: unItemDeAtaque

	estado equiparItemDeAtaque: unItemDeAtaque! !

!Aventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 16:42:00'!
equiparItemDeAtaqueEnCombate: unItemDeAtaque

	itemsDeAtaque add: unItemDeAtaque! !

!Aventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 16:40:30'!
equiparItemDeDefensa: unItemDeDefensa

	estado equiparItemDeDefensa: unItemDeDefensa! !

!Aventurero methodsFor: 'equipar' stamp: 'NR 11/9/2024 16:42:25'!
equiparItemDeDefensaEnCombate: unItemDeDefensa

	itemsDeDefensa add: unItemDeDefensa! !


!Aventurero methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:17:16'!
dañoEfectivo: cantidadDeDañoEfectuado

	^ cantidadDeDañoEfectuado - self puntosDeDefensa! !


!Aventurero methodsFor: 'defensa' stamp: 'NR 11/10/2024 23:17:50'!
puntosDeDefensa
	
	^ itemsDeDefensa sum: [ :itemDeDefensa | itemDeDefensa puntosDeDefensa ] ifEmpty: [ 0 ]! !


!Aventurero methodsFor: 'asserts' stamp: 'NR 11/10/2024 23:16:40'!
assertEquipaItem: unItemDeAtaque

	^ (itemsDeAtaque includes: unItemDeAtaque) ifFalse: [ self error: self itemNoDisponibleMensajeDeError ]! !


!Aventurero methodsFor: 'error messages' stamp: 'NR 11/10/2024 23:17:43'!
itemNoDisponibleMensajeDeError

	^ 'El item elegido no fue equipado'! !


!Aventurero methodsFor: 'actualizar estado - bonus' stamp: 'NR 11/10/2024 23:17:46'!
personajeFueDerrotado

	estado := AventureroDerrotado para: self! !


!classDefinition: #Guerrero category: #'ISW-1erParcial'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Guerrero methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:16:28'!
atacarEnCombateA: unMonstruo con: unItemDeAtaque
	
	unItemDeAtaque atacarSiendoGuerrero: self a: unMonstruo! !


!Guerrero methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:16:24'!
initialize

	super initialize.
	fuerza := 4 * pv.
	puntosDeVida := 10 * pv! !


!classDefinition: #Mago category: #'ISW-1erParcial'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Mago methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:16:06'!
atacarEnCombateA: unMonstruo con: unItemDeAtaque

	unItemDeAtaque atacarSiendoMago: self a: unMonstruo
	
	! !


!Mago methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:16:12'!
initialize

	super initialize.
	fuerza := 2 * pv.
	puntosDeVida := 15 * pv
	! !


!classDefinition: #Monstruo category: #'ISW-1erParcial'!
Personaje subclass: #Monstruo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Monstruo methodsFor: 'actualizar estado - bonus' stamp: 'NR 11/10/2024 23:15:35'!
personajeFueDerrotado

	estado := MonstruoDerrotado para: self! !


!Monstruo methodsFor: 'accessing' stamp: 'NR 11/10/2024 23:15:29'!
initialize
	
	estado := MonstruoEnCombate para: self! !

!Monstruo methodsFor: 'accessing' stamp: 'NR 11/10/2024 23:15:50'!
tieneAlturaMenorA: unaAlturaLimite

	^ altura < unaAlturaLimite! !


!Monstruo methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:14:52'!
atacarA: unAventurero 

	estado atacarA: unAventurero

	! !

!Monstruo methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:14:58'!
atacarEnCombateA: unAventurero 

	unAventurero recibirDañoPor: puntosDeVida

	! !

!Monstruo methodsFor: 'atacar' stamp: 'NR 11/10/2024 23:15:26'!
derrotado

	self error: self monstruoDerrotadoNoPuedeAtacarMensajeDeError 

	! !


!Monstruo methodsFor: 'recibir daño' stamp: 'NR 11/10/2024 23:15:23'!
dañoEfectivo: cantidadDeDañoEfectuado

	^ cantidadDeDañoEfectuado! !


!Monstruo methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:15:43'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo

	self subclassResponsibility! !

!Monstruo methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:15:47'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	self subclassResponsibility! !


!Monstruo methodsFor: 'message errors' stamp: 'NR 11/10/2024 23:15:32'!
monstruoDerrotadoNoPuedeAtacarMensajeDeError

	^ 'Un monstruo derrotado no puede atacar'! !


!classDefinition: #Goblin category: #'ISW-1erParcial'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:13:54'!
duplicarPuntosDeVida

	puntosDeVida := puntosDeVida * 2! !

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:13:48'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo

	unBaculo atacarConGuerrero: unGuerrero aGoblin: self! !

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:13:45'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	unBaculo atacarConMago: unMago aGoblin: self! !


!Goblin methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:13:39'!
initialize 
	
	super initialize.
	puntosDeVida := 5 * pv.
	altura := 90 * centimeter! !


!classDefinition: #Ogro category: #'ISW-1erParcial'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-1erParcial'!

!Ogro methodsFor: 'initialization' stamp: 'NR 11/10/2024 23:14:07'!
initialize 

	super initialize.
	puntosDeVida := 15 * pv.
	altura := 220 * centimeter! !


!Ogro methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:14:03'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo 

	unBaculo atacarConGuerrero: unGuerrero aOgro: self! !

!Ogro methodsFor: 'recibir ataques' stamp: 'NR 11/10/2024 23:13:59'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	unBaculo atacarConMago: unMago aOgro: self! !

TestsDungeonGame initialize!