!classDefinition: #TestMyA category: #'2024-2C-Parcial-1'!
TestCase subclass: #TestMyA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 03:49:05'!
test01UnMonstruoAtacaAUnAventureroUsandoSusPVs

	| guerrero |
	
	guerrero := self crearGuerrero.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (5 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:09:06'!
test02UnAventureroPuedeUsarItemsDeDefensaParaProtegerse

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearEscudoMagico.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearOgro atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv - (15 * pv - (5 * pv) - (3 * pv)))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:35'!
test03LosItemsDeDefensaNoPuedenAumentarLosPuntosDeVidaDelAventurero

	| guerrero |
	
	guerrero := self crearGuerrero.
	guerrero equiparItemDeDefensa: self crearArmadura.
	guerrero equiparItemDeDefensa: self crearArmadura.
	
	self crearGoblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 10 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:04:39'!
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

!TestMyA methodsFor: 'tests' stamp: 'LL 9/27/2024 10:48:15'!
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

!TestMyA methodsFor: 'tests' stamp: 'HAW 9/27/2024 09:46:06'!
test06UnGuerreroConEspadaNoProvocaDañoAOtroMonstruoQueNoSeaElDeLaEspada

	| guerrero ogroNoObjetivoDeAtaque itemDeAtaque ogroObjetivoDeAtaque |
	
	guerrero := self crearGuerrero.
	ogroObjetivoDeAtaque := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogroObjetivoDeAtaque.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogroNoObjetivoDeAtaque := self crearOgro.
	
	guerrero atacarA: ogroNoObjetivoDeAtaque con: itemDeAtaque.
	
	self assert: (ogroNoObjetivoDeAtaque tienePuntosDeVida: 15 * pv)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:52'!
test07UnAventureroNoGuerreroPierdeTodosSusPuntosDeVidaSiUsaLaEspada

	| ogro mago itemDeAtaque |
	
	mago := self crearMago.
	ogro := self crearOgro.
	itemDeAtaque := self crearEspadaPara: ogro.
	mago equiparItemDeAtaque: itemDeAtaque.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv).
	self assert: (mago tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:49'!
test08ElMagoUsandoElBaculoMataAlGoblin

	| mago goblin itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	goblin :=  self crearGoblin.
	
	mago atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 0)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:42:26'!
test09ElMagoUsandoElBaculoDañaAOtrosMonstruosSegunSuFuerza

	| mago ogro itemDeAtaque |
	
	mago := self crearMago.
	itemDeAtaque := self crearBaculo.
	mago equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	mago atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (2 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:45'!
test10UnAventureroNoMagoEsPenalizadoAlUsarElBaculoDuplicandoPVDeGoblins

	| guerrero goblin itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	goblin := self crearGoblin.
	
	guerrero atacarA: goblin con: itemDeAtaque.
	
	self assert: (goblin tienePuntosDeVida: 5 * pv * 2)! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:08:38'!
test11UnAventureroNoMagoUsandoElBaculoDañaSegunSuFuerzaAOtrosMonstruos

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	itemDeAtaque := self crearBaculo.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	ogro := self crearOgro.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	
	self assert: (ogro tienePuntosDeVida: 15 * pv - (4 * pv))! !

!TestMyA methodsFor: 'tests' stamp: 'NR 9/27/2024 04:29:01'!
test12UnaEspadaNuncaPuedeSerUsadaEnMonstruosDeMenosDeUnMetro

	| goblin |
	
	goblin := self crearGoblin.
	
	self should: [ self crearEspadaPara: goblin ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
		self assert: anException messageText equals: Espada noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	]
	! !


!TestMyA methodsFor: 'crear items' stamp: 'LL 9/27/2024 02:03:08'!
crearArmadura

	^ ItemDeDefensa armadura! !

!TestMyA methodsFor: 'crear items' stamp: 'LL 9/27/2024 01:24:46'!
crearBaculo

	^ Baculo new! !

!TestMyA methodsFor: 'crear items' stamp: 'LL 9/27/2024 02:03:19'!
crearEscudoMagico

	^ ItemDeDefensa escudoMagico! !

!TestMyA methodsFor: 'crear items' stamp: 'NR 10/5/2024 19:18:19'!
crearEspadaPara: monstruo

	^ Espada conObjetivo: monstruo! !


!TestMyA methodsFor: 'crear combatientes' stamp: 'NR 9/27/2024 04:09:26'!
crearGoblin

	^ Goblin new! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'NR 9/27/2024 04:09:30'!
crearGuerrero

	^ Guerrero new! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'NR 9/27/2024 04:09:33'!
crearMago

	^ Mago new! !

!TestMyA methodsFor: 'crear combatientes' stamp: 'NR 9/27/2024 04:09:36'!
crearOgro

	^ Ogro new! !


!TestMyA methodsFor: 'tests - bonus' stamp: 'NR 10/5/2024 19:36:08'!
test13PersonajeMyANoPuedeQuedarConVidaNegativa

	| guerrero goblin |
	
	guerrero := self crearGuerrero.
	goblin := self crearGoblin.
	
	goblin atacarA: guerrero.
	goblin atacarA: guerrero.
	goblin atacarA: guerrero.
	
	self assert: (guerrero tienePuntosDeVida: 0 * pv)! !

!TestMyA methodsFor: 'tests - bonus' stamp: 'NR 10/5/2024 21:36:57'!
test14AtaquesDeAventureroDerrotadoNoTienenEfecto

	| guerrero ogro itemDeAtaque |
	
	guerrero := self crearGuerrero.
	ogro := self crearOgro.
	ogro atacarA: guerrero.
	ogro atacarA: guerrero.
	itemDeAtaque := self crearEspadaPara: ogro.
	guerrero equiparItemDeAtaque: itemDeAtaque.
	
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: ogro con: itemDeAtaque.
	guerrero atacarA: ogro con: itemDeAtaque.

	self assert: (guerrero tienePuntosDeVida: 0 * pv). 
	self assert: (ogro tienePuntosDeVida: 15 * pv)
! !

!TestMyA methodsFor: 'tests - bonus' stamp: 'NR 10/5/2024 22:16:03'!
test15MonstruoNoPuedeAtacarSiFueDerrotado

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

!classDefinition: 'TestMyA class' category: #'2024-2C-Parcial-1'!
TestMyA class
	instanceVariableNames: ''!

!TestMyA class methodsFor: 'initialization' stamp: 'LL 9/26/2024 20:21:50'!
initialize

	Smalltalk at: #pv put: (BaseUnit named: 'pv' sign: 'pv')! !


!classDefinition: #EstadoDeAventurero category: #'2024-2C-Parcial-1'!
Object subclass: #EstadoDeAventurero
	instanceVariableNames: 'aventurero'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!EstadoDeAventurero methodsFor: 'ataque' stamp: 'NR 10/5/2024 20:54:01'!
atacarA: unItemDeAtaque con: unMonstruo

	self subclassResponsibility ! !


!EstadoDeAventurero methodsFor: 'initialization' stamp: 'NR 10/5/2024 20:19:27'!
initializePara: unAventurero

	aventurero := unAventurero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeAventurero class' category: #'2024-2C-Parcial-1'!
EstadoDeAventurero class
	instanceVariableNames: ''!

!EstadoDeAventurero class methodsFor: 'instance creation' stamp: 'NR 10/5/2024 20:18:52'!
para: unAventurero

	^ self new initializePara: unAventurero! !


!classDefinition: #AventureroDerrotado category: #'2024-2C-Parcial-1'!
EstadoDeAventurero subclass: #AventureroDerrotado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!AventureroDerrotado methodsFor: 'ataque' stamp: 'NR 10/5/2024 20:54:01'!
atacarA: unItemDeAtaque con: unMonstruo

	aventurero derrotado

	! !


!classDefinition: #AventureroEnCombate category: #'2024-2C-Parcial-1'!
EstadoDeAventurero subclass: #AventureroEnCombate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!AventureroEnCombate methodsFor: 'ataque' stamp: 'NR 10/5/2024 20:54:01'!
atacarA: unItemDeAtaque con: unMonstruo

	aventurero atacarEnCombateA: unMonstruo con: unItemDeAtaque! !


!classDefinition: #EstadoDeMonstruo category: #'2024-2C-Parcial-1'!
Object subclass: #EstadoDeMonstruo
	instanceVariableNames: 'monstruo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!EstadoDeMonstruo methodsFor: 'ataque' stamp: 'NR 10/5/2024 20:35:19'!
atacarA: unAventurero 

	self subclassResponsibility ! !


!EstadoDeMonstruo methodsFor: 'initialization' stamp: 'NR 10/5/2024 20:41:31'!
initializePara: unMonstruo

	monstruo := unMonstruo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EstadoDeMonstruo class' category: #'2024-2C-Parcial-1'!
EstadoDeMonstruo class
	instanceVariableNames: ''!

!EstadoDeMonstruo class methodsFor: 'instance creation' stamp: 'NR 10/5/2024 21:08:33'!
para: unMonstruo

	^ self new initializePara: unMonstruo ! !


!classDefinition: #MonstruoDerrotado category: #'2024-2C-Parcial-1'!
EstadoDeMonstruo subclass: #MonstruoDerrotado
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!MonstruoDerrotado methodsFor: 'ataque' stamp: 'NR 10/5/2024 21:04:07'!
atacarA: unAventurero 

	monstruo derrotado
! !


!classDefinition: #MonstruoEnCombate category: #'2024-2C-Parcial-1'!
EstadoDeMonstruo subclass: #MonstruoEnCombate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!MonstruoEnCombate methodsFor: 'ataque' stamp: 'NR 10/5/2024 21:04:31'!
atacarA: unAventurero 

	monstruo atacarEnCombateA: unAventurero! !


!classDefinition: #ItemDeAtaque category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeAtaque
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeAtaque methodsFor: 'ataque' stamp: 'NR 9/27/2024 02:55:23'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	self subclassResponsibility! !

!ItemDeAtaque methodsFor: 'ataque' stamp: 'NR 9/27/2024 02:55:37'!
atacarSiendoMago: unMago a: unMonstruo

	self subclassResponsibility! !


!classDefinition: #Baculo category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Baculo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Baculo methodsFor: 'ataque DD' stamp: 'NR 9/27/2024 03:28:38'!
atacarConGuerrero: unGuerrero aGoblin: unGoblin

	unGoblin duplicarPuntosDeVida
	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 10/6/2024 13:19:06'!
atacarConGuerrero: unGuerrero aOgro: unOgro

	unGuerrero dañarConSuFuerzaA: unOgro

	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 9/27/2024 03:23:12'!
atacarConMago: unMago aGoblin: unGoblin

	unGoblin perderTodosLosPuntosDeVida

	

! !

!Baculo methodsFor: 'ataque DD' stamp: 'NR 10/6/2024 13:19:23'!
atacarConMago: unMago aOgro: unOgro

	unMago dañarConSuFuerzaA: unOgro

	

! !


!Baculo methodsFor: 'ataque' stamp: 'NR 9/27/2024 03:03:35'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	unMonstruo serAtacadoPorGuerrero: unGuerrero conBaculo: self.! !

!Baculo methodsFor: 'ataque' stamp: 'NR 9/27/2024 03:03:13'!
atacarSiendoMago: unMago a: unMonstruo

	unMonstruo serAtacadoPorMago: unMago conBaculo: self! !


!classDefinition: #Espada category: #'2024-2C-Parcial-1'!
ItemDeAtaque subclass: #Espada
	instanceVariableNames: 'monstruoEnemigo'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Espada methodsFor: 'initialization' stamp: 'NR 10/5/2024 19:19:00'!
initializeConObjetivo: unMonstruoEnemigo 

	monstruoEnemigo := unMonstruoEnemigo.! !


!Espada methodsFor: 'ataque' stamp: 'NR 10/6/2024 13:19:43'!
atacarSiendoGuerrero: unGuerrero a: unMonstruo

	(self tieneComoObjetivoA: unMonstruo) ifTrue: [ unGuerrero dañarConSuFuerzaA: unMonstruo]! !

!Espada methodsFor: 'ataque' stamp: 'NR 9/27/2024 04:22:51'!
atacarSiendoMago: unMago a: unMonstruo

	unMago perderTodosLosPuntosDeVida! !

!Espada methodsFor: 'ataque' stamp: 'NR 10/5/2024 19:21:49'!
tieneComoObjetivoA: unMonstruo

	^ unMonstruo = monstruoEnemigo! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Espada class' category: #'2024-2C-Parcial-1'!
Espada class
	instanceVariableNames: ''!

!Espada class methodsFor: 'instance creation' stamp: 'NR 10/5/2024 19:19:00'!
conObjetivo: unMonstruoEnemigo

	(self assertAlturaMenorA1Metro: unMonstruoEnemigo) ifTrue: [ self error: self noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError ].
	
	^ self new initializeConObjetivo: unMonstruoEnemigo! !


!Espada class methodsFor: 'asserts' stamp: 'LL 9/27/2024 10:56:20'!
assertAlturaMenorA1Metro: unMonstruoEnemigo

	^ unMonstruoEnemigo tieneAlturaMenorA: 1 * meter! !


!Espada class methodsFor: 'error messages' stamp: 'NR 9/27/2024 04:29:01'!
noSePuedeAtacarAMonstruoMenorAUnMetroDeAlturaMensajeDeError
	
	^ 'No se puede atacar a monstruo de altura menor a un metro'! !


!classDefinition: #ItemDeDefensa category: #'2024-2C-Parcial-1'!
Object subclass: #ItemDeDefensa
	instanceVariableNames: 'puntosDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!ItemDeDefensa methodsFor: 'initialization' stamp: 'NR 9/27/2024 02:58:27'!
initializeCon: unosPuntosDeDefensa  

	puntosDeDefensa := unosPuntosDeDefensa! !


!ItemDeDefensa methodsFor: 'accessing' stamp: 'NR 9/27/2024 04:15:22'!
puntosDeDefensa

	^ puntosDeDefensa! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ItemDeDefensa class' category: #'2024-2C-Parcial-1'!
ItemDeDefensa class
	instanceVariableNames: ''!

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'NR 9/27/2024 04:15:31'!
armadura

	^ self new initializeCon: 5 * pv! !

!ItemDeDefensa class methodsFor: 'instance creation' stamp: 'NR 9/27/2024 04:15:27'!
escudoMagico

	^ self new initializeCon: 3 * pv! !


!classDefinition: #PersonajeMyA category: #'2024-2C-Parcial-1'!
Object subclass: #PersonajeMyA
	instanceVariableNames: 'puntosDeVida estado'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!PersonajeMyA methodsFor: 'testing' stamp: 'NR 9/27/2024 04:12:11'!
tienePuntosDeVida: unaCantidadDePuntosDeVidaEsperada 

	^ puntosDeVida = unaCantidadDePuntosDeVidaEsperada! !


!PersonajeMyA methodsFor: 'actualizar estado - bonus' stamp: 'NR 10/6/2024 13:03:58'!
personajeFueDerrotado

	self subclassResponsibility 

	! !


!PersonajeMyA methodsFor: 'recibir daño' stamp: 'NR 10/5/2024 13:02:01'!
dañoEfectivo: cantidadDeDañoEfectuado
	
	self subclassResponsibility ! !

!PersonajeMyA methodsFor: 'recibir daño' stamp: 'LL 9/27/2024 00:37:25'!
perderTodosLosPuntosDeVida

	puntosDeVida := 0! !

!PersonajeMyA methodsFor: 'recibir daño' stamp: 'NR 10/6/2024 13:03:58'!
recibirDañoPor: cantidadDeDañoEfectuado
	
	| puntosDeVidaARestar |
	
	puntosDeVidaARestar := (self dañoEfectivo: cantidadDeDañoEfectuado) max: 0.
	puntosDeVida := (puntosDeVida - puntosDeVidaARestar) max: (0 * pv).
	
	puntosDeVida = 0 ifTrue: [ self personajeFueDerrotado ]! !


!PersonajeMyA methodsFor: 'atacar' stamp: 'NR 10/5/2024 22:13:28'!
derrotado

	self subclassResponsibility 
	! !


!classDefinition: #Aventurero category: #'2024-2C-Parcial-1'!
PersonajeMyA subclass: #Aventurero
	instanceVariableNames: 'fuerza itemsDeAtaque itemsDeDefensa'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Aventurero methodsFor: 'initialization' stamp: 'NR 10/5/2024 21:05:41'!
initialize

	itemsDeDefensa := Set new.
	itemsDeAtaque := Set new.
	estado := AventureroEnCombate para: self
	! !


!Aventurero methodsFor: 'atacar' stamp: 'NR 10/5/2024 20:58:24'!
atacarA: unMonstruo con: unItemDeAtaque

	self assertEquipaItem: unItemDeAtaque.

	"bonus"
	estado atacarA: unItemDeAtaque con: unMonstruo! !

!Aventurero methodsFor: 'atacar' stamp: 'NR 10/6/2024 13:18:09'!
dañarConSuFuerzaA: unMonstruo

	unMonstruo recibirDañoPor: fuerza
! !

!Aventurero methodsFor: 'atacar' stamp: 'NR 10/5/2024 22:18:26'!
derrotado

	! !


!Aventurero methodsFor: 'equipar' stamp: 'LL 9/27/2024 01:07:25'!
equiparItemDeAtaque: unItemDeAtaque

	itemsDeAtaque add: unItemDeAtaque! !

!Aventurero methodsFor: 'equipar' stamp: 'LL 9/27/2024 01:46:14'!
equiparItemDeDefensa: unItemDeDefensa

	itemsDeDefensa add: unItemDeDefensa! !


!Aventurero methodsFor: 'recibir daño' stamp: 'NR 10/5/2024 21:40:25'!
dañoEfectivo: cantidadDeDañoEfectuado

	^ cantidadDeDañoEfectuado - self puntosDeDefensa! !


!Aventurero methodsFor: 'defensa' stamp: 'LL 9/27/2024 02:00:42'!
puntosDeDefensa

	^ itemsDeDefensa sum: [ :itemDeDefensa | itemDeDefensa puntosDeDefensa ] ifEmpty: [ 0 ]! !


!Aventurero methodsFor: 'asserts' stamp: 'LL 9/27/2024 10:54:39'!
assertEquipaItem: unItemDeAtaque

	^ (itemsDeAtaque includes: unItemDeAtaque) ifFalse: [ self error: self itemNoDisponibleMensajeDeError ]! !



!Aventurero methodsFor: 'error messages' stamp: 'LL 9/27/2024 10:54:28'!
itemNoDisponibleMensajeDeError

	^ 'El item elegido no fue equipado'! !


!Aventurero methodsFor: 'actualizar estado - bonus' stamp: 'NR 10/6/2024 13:03:58'!
personajeFueDerrotado

	estado := AventureroDerrotado para: self! !


!classDefinition: #Guerrero category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Guerrero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Guerrero methodsFor: 'atacar' stamp: 'NR 10/5/2024 20:58:19'!
atacarEnCombateA: unMonstruo con: unItemDeAtaque 
	
	unItemDeAtaque atacarSiendoGuerrero: self a: unMonstruo! !


!Guerrero methodsFor: 'initialization' stamp: 'NR 10/5/2024 21:05:46'!
initialize

	super initialize.
	fuerza := 4 * pv.
	puntosDeVida := 10 * pv! !


!classDefinition: #Mago category: #'2024-2C-Parcial-1'!
Aventurero subclass: #Mago
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Mago methodsFor: 'atacar' stamp: 'NR 10/5/2024 20:58:40'!
atacarEnCombateA: unMonstruo con: unItemDeAtaque 

	unItemDeAtaque atacarSiendoMago: self a: unMonstruo
	
	! !


!Mago methodsFor: 'initialization' stamp: 'NR 10/5/2024 21:05:34'!
initialize

	super initialize.
	fuerza := 2 * pv.
	puntosDeVida := 15 * pv.	
	! !


!classDefinition: #Monstruo category: #'2024-2C-Parcial-1'!
PersonajeMyA subclass: #Monstruo
	instanceVariableNames: 'altura'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Monstruo methodsFor: 'actualizar estado - bonus' stamp: 'NR 10/6/2024 13:03:58'!
personajeFueDerrotado

	estado := MonstruoDerrotado para: self! !


!Monstruo methodsFor: 'accessing' stamp: 'NR 10/5/2024 21:06:10'!
initialize
	
	estado := MonstruoEnCombate para: self! !

!Monstruo methodsFor: 'accessing' stamp: 'LL 9/27/2024 10:56:03'!
tieneAlturaMenorA: unaAlturaLimite

	^ altura < unaAlturaLimite! !


!Monstruo methodsFor: 'atacar' stamp: 'NR 10/5/2024 22:13:56'!
atacarA: unAventurero 

	"bonus"
	estado atacarA: unAventurero

	! !

!Monstruo methodsFor: 'atacar' stamp: 'NR 10/5/2024 22:14:16'!
atacarEnCombateA: unAventurero 

	"viejo atacarA:"
	unAventurero recibirDañoPor: puntosDeVida

	! !

!Monstruo methodsFor: 'atacar' stamp: 'NR 10/5/2024 22:16:34'!
derrotado

	self error: self monstruoDerrotadoNoPuedeAtacarMensajeDeError 

	! !


!Monstruo methodsFor: 'recibir daño' stamp: 'NR 10/5/2024 13:02:36'!
dañoEfectivo: cantidadDeDañoEfectuado

	^ cantidadDeDañoEfectuado! !


!Monstruo methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 04:18:26'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo

	self subclassResponsibility! !

!Monstruo methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 04:18:36'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	self subclassResponsibility! !


!Monstruo methodsFor: 'message errors' stamp: 'NR 10/5/2024 22:15:44'!
monstruoDerrotadoNoPuedeAtacarMensajeDeError

	^ 'Un monstruo derrotado no puede atacar'! !


!classDefinition: #Goblin category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Goblin
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 04:19:14'!
duplicarPuntosDeVida

	puntosDeVida := puntosDeVida * 2! !

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 03:13:45'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo.

	unBaculo atacarConGuerrero: unGuerrero aGoblin: self! !

!Goblin methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 03:14:36'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	unBaculo atacarConMago: unMago aGoblin: self! !


!Goblin methodsFor: 'initialization' stamp: 'NR 10/5/2024 21:06:24'!
initialize 
	
	super initialize.
	puntosDeVida := 5 * pv.
	altura := 90 * centimeter.! !


!classDefinition: #Ogro category: #'2024-2C-Parcial-1'!
Monstruo subclass: #Ogro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-1'!

!Ogro methodsFor: 'initialization' stamp: 'NR 10/5/2024 21:06:38'!
initialize 

	super initialize.
	puntosDeVida := 15 * pv.
	altura := 220 * centimeter.! !


!Ogro methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 04:17:14'!
serAtacadoPorGuerrero: unGuerrero conBaculo: unBaculo.

	unBaculo atacarConGuerrero: unGuerrero aOgro: self! !

!Ogro methodsFor: 'recibir ataques' stamp: 'NR 9/27/2024 04:17:45'!
serAtacadoPorMago: unMago conBaculo: unBaculo

	unBaculo atacarConMago: unMago aOgro: self! !

TestMyA initialize!