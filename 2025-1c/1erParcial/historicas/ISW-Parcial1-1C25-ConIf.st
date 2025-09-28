!classDefinition: #FleetRun category: #'ISW-Parcial1-1C25'!
Object subclass: #FleetRun
	instanceVariableNames: 'fleet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!FleetRun methodsFor: 'initialization' stamp: 'HAW 5/6/2025 08:51:21'!
initializeAssemble: aFleet 
	
	fleet := aFleet.! !


!FleetRun methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 11:19:11'!
assertSectorsNotEmpty: sectors 
	
	sectors ifEmpty: [ self error: self class emptyRouteErrorDescription ]! !

!FleetRun methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 08:55:34'!
hasSurvived: aShip

	^fleet includes: aShip ! !

!FleetRun methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 16:29:18'!
isNumberOfSurvivors: aFleetSize 
	
	^fleet size = aFleetSize ! !

!FleetRun methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 11:18:18'!
runThrough: sectors 
	
	self assertSectorsNotEmpty: sectors.
	
	sectors do: [ :aSector |
		fleet := fleet reject: [ :aShip | aShip isDepleted ].
		fleet do: [ :aShip | aShip passBy: aSector ].
		fleet := fleet reject: [ :aShip | aShip isDestroyed ]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FleetRun class' category: #'ISW-Parcial1-1C25'!
FleetRun class
	instanceVariableNames: ''!

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 16:29:47'!
allSpaceshipsShouldBeDifferentErrorDescription

	^ 'All the spaceships in the fleet must be unique'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 11:19:11'!
emptyRouteErrorDescription

	^ 'The route cannot be empty'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 16:29:58'!
fleetWithoutSpaceshipsErrorDescription

	^ 'The fleet cannot be empty'! !


!FleetRun class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:14:52'!
assemble: aFleet 
	
	self assertFleetIsNotEmpty: aFleet.
	self assertShipsAreUniqueIn: aFleet.
	
	^self new initializeAssemble: aFleet ! !


!FleetRun class methodsFor: 'assertions' stamp: 'HAW 5/6/2025 16:29:58'!
assertFleetIsNotEmpty: aFleet 
	
	aFleet isEmpty ifTrue: [ self error: self fleetWithoutSpaceshipsErrorDescription ]! !

!FleetRun class methodsFor: 'assertions' stamp: 'HAW 5/6/2025 16:29:47'!
assertShipsAreUniqueIn: aFleet 
	
	aFleet asSet size = aFleet size ifFalse: [ self error: self allSpaceshipsShouldBeDifferentErrorDescription ]! !


!classDefinition: #SpaceSector category: #'ISW-Parcial1-1C25'!
Object subclass: #SpaceSector
	instanceVariableNames: 'gravity radiation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!SpaceSector methodsFor: 'initialization' stamp: 'HAW 5/6/2025 11:22:02'!
initializeGravity: aGravity andRadiation: aRadiation 
	
	gravity := aGravity.
	radiation := aRadiation.! !


!SpaceSector methodsFor: 'gravity' stamp: 'HAW 5/6/2025 11:22:07'!
gravity
	
	^gravity! !


!SpaceSector methodsFor: 'radiation' stamp: 'HAW 5/6/2025 11:22:13'!
radiation
	
	^radiation! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpaceSector class' category: #'ISW-Parcial1-1C25'!
SpaceSector class
	instanceVariableNames: ''!

!SpaceSector class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:22:48'!
gravity: aGravity andRadiation: aRadiation 
	
	^self new initializeGravity: aGravity andRadiation: aRadiation ! !


!classDefinition: #AsteroidsSystem category: #'ISW-Parcial1-1C25'!
SpaceSector subclass: #AsteroidsSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!


!classDefinition: #NebulaCloud category: #'ISW-Parcial1-1C25'!
SpaceSector subclass: #NebulaCloud
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!


!classDefinition: #PlanetarySector category: #'ISW-Parcial1-1C25'!
SpaceSector subclass: #PlanetarySector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!


!classDefinition: #SpaceShip category: #'ISW-Parcial1-1C25'!
Object subclass: #SpaceShip
	instanceVariableNames: 'thrusters maneuverability shields fuel maxDamageLevel damageLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!SpaceShip methodsFor: 'initialization' stamp: 'HAW 5/6/2025 11:26:54'!
initializeWithThrusters: aThrusters maneuverability: aManeuverability shileds: aShields fuel: aFuel damageLevel: aMaxDamageLevel     
	
	thrusters := aThrusters.
	maneuverability := aManeuverability.
	shields := aShields.
	fuel := aFuel.
	maxDamageLevel := aMaxDamageLevel.
	
	damageLevel := 0.! !


!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:23:26'!
hasDamageLevel: aLevel
 
	^damageLevel = aLevel! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 11:59:13'!
hasFuel: aLevel

	^fuel = aLevel ! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 10:36:27'!
hasManeuverability: aLevel

	^maneuverability = aLevel ! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:57:50'!
hasShieldLevelsAt: aLevel

	^shields = aLevel ! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:28:34'!
isDamaged
	
	^damageLevel > 0! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:03:29'!
isDepleted
	
	^fuel <= 0! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 11:26:54'!
isDestroyed
	
	^damageLevel > maxDamageLevel ! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:57:43'!
isOnGravitons
	
	^thrusters = #gravitons! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:51:18'!
isOnImpulse
	
	^thrusters = #impulse! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 09:46:12'!
isOnWarp
	
	^thrusters = #warp! !

!SpaceShip methodsFor: 'as yet unclassified' stamp: 'HAW 5/6/2025 16:32:08'!
passBy: aSector 
	
	aSector class = NebulaCloud ifTrue: [ 
		self isOnWarp ifTrue: [ ^self ].
		self isOnImpulse ifTrue: [
			fuel := fuel  - 10.
			aSector gravity > maneuverability ifTrue: [ damageLevel := damageLevel + 1 ].
			aSector radiation > shields ifTrue: [ damageLevel := damageLevel + 1 ]].
		self isOnGravitons ifTrue: [ fuel := fuel - 20  ]].
	
	aSector class = PlanetarySector ifTrue: [ 
		self isOnGravitons ifTrue: [ fuel := fuel - 20  ].
		self isOnImpulse ifTrue: [ 
			fuel := fuel  - 10.
			aSector gravity > maneuverability ifTrue: [ damageLevel := damageLevel + 1 ] .
			aSector radiation > shields ifTrue: [ self isOnImpulse ifTrue: [ damageLevel := damageLevel + 1 ]]].	
		self isOnWarp ifTrue: [
			fuel := fuel  - 10.
			aSector gravity > maneuverability ifTrue: [ damageLevel := damageLevel + 1 ]]].
		
	aSector class = AsteroidsSystem ifTrue: [
		self isOnGravitons ifTrue: [ 
				fuel := fuel - 20.
				aSector radiation > shields ifTrue: [ damageLevel := damageLevel + 1 ] ].
		self isOnImpulse ifTrue: [ 
			 fuel := fuel  - 10.
			shields := shields - 20.
			damageLevel := damageLevel + 1 ].
		self isOnWarp ifTrue: [
			 fuel := fuel  - 10 .
			shields := 0.
			damageLevel := damageLevel + 1.
			aSector radiation > shields ifTrue: [ damageLevel := damageLevel + 1 ]]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SpaceShip class' category: #'ISW-Parcial1-1C25'!
SpaceShip class
	instanceVariableNames: ''!

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:29:22'!
heavyCruiserWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 50 shileds: 100 fuel: 50 damageLevel: 5 ! !

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:32:34'!
lightInterceptorWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 90 shileds: 30 fuel: 30 damageLevel: 2 
! !

!SpaceShip class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 11:33:41'!
smugglerTransportWithThrusters: aThrusters 
	
	^self new initializeWithThrusters: aThrusters maneuverability: 70 shileds: 50 fuel: 95 damageLevel: 2 
! !


!classDefinition: #FleetRunTests category: #'ISW-Parcial1-1C25'!
TestCase subclass: #FleetRunTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:26:42'!
test01TheFleetShouldHaveAtLeastOneSpaceship
	
	self 
		should: [ FleetRun assemble: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: FleetRun fleetWithoutSpaceshipsErrorDescription ! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:26:28'!
test02TheFleetCannotHaveDuplicatedShips

	| heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	
	self 
		should: [ FleetRun assemble: { heavyCruiserOnImpulse. heavyCruiserOnImpulse } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: FleetRun allSpaceshipsShouldBeDifferentErrorDescription ! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 11:19:11'!
test03TheSequenceRouteOfSectorsToGoThroughShouldNotBeEmpty

	| heavyCruiserOnImpulse fleet |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasFuel: 50).
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	self 
		should: [ fleet runThrough: {  } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: FleetRun emptyRouteErrorDescription equals: error messageText.
			self assert: (heavyCruiserOnImpulse hasFuel: 50) ]
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test04FuelOfSpaceshipShouldSufficeSingleNormalPlanetarySectorRunAndSurvive

	| planetarySector fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasFuel: 50).
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	planetarySector := self newPlanetarySectorWithGravity: 50 andRadiation: 50.
	
	fleet runThrough: { planetarySector }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasFuel: (50 - 10))
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test05SpaceshipCanRunOutOfFuelButSurviveAnyway

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDepleted.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 5 withGravity: 50 withRadiation: 50).
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: heavyCruiserOnImpulse isDepleted
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test06SpaceshipThatRunsOutOfFuelBeforeFinishingRunDoesntSurvive

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDepleted.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	"Secuencia de 6 sistemas planetarios seguidos..."
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 6 withGravity: 50 withRadiation: 50).
	
	self assert: (fleet isNumberOfSurvivors: 0).
	self deny: (fleet hasSurvived: heavyCruiserOnImpulse).
	self assert: heavyCruiserOnImpulse isDepleted
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test07SpaceshipPassingThroughSectorWithHigherGravityThanManeuverabilityGetsDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 70 andRadiation: 50 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 1).
	self assert: heavyCruiserOnImpulse isDamaged.
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test08SpaceshipPassingThroughSectorWithHigherRadiationThanShieldsGetsDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 50 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 1).
	self assert: heavyCruiserOnImpulse isDamaged.

	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test09SpaceshipPassingThroughSectorWithHigherGravityAndRadiationThanManeuverabilityAndShieldsGetsDoubleDamaged

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 0).
	self deny: heavyCruiserOnImpulse isDamaged.

	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 70 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: heavyCruiserOnImpulse ).
	self assert: (heavyCruiserOnImpulse hasDamageLevel: 2).
	self assert: heavyCruiserOnImpulse isDamaged.
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test10SpaceshipTakingMoreDamageLevelsThanTheirHullCapacityGetsDestroyedAndDoesntSurvive

	| fleet heavyCruiserOnImpulse |
	
	heavyCruiserOnImpulse := self newHeavyCruiserShipOnImpulse.
	self deny: heavyCruiserOnImpulse isDestroyed.
	
	fleet := FleetRun assemble: { heavyCruiserOnImpulse }.
	
	"6 niveles de daño en una clase de naves que sólo admite 5 como máximo..."
	fleet runThrough: (self newPlanetarySectorJourneySequenceOfSize: 3 withGravity: 70 withRadiation: 200).
	
	self assert: (fleet isNumberOfSurvivors: 0).
	self deny: (fleet hasSurvived: heavyCruiserOnImpulse).
	self assert: heavyCruiserOnImpulse isDestroyed
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test11IntactHullSpaceshipPassingThroughPlanetarySectorUsingWarpIgnoresRadiationLevelsOfSector

	| fleet smugglerTransportOnWarp |
	
	"Si el casco de la nave no ha sido dañado y se viaja en Warp (o Light Speed, Subluminal, FTL: Faster Than Light, o como tu autor de ciencia ficción favorito lo llame) en un sector de sistema de planetas, se puede pasar tan rápido que se ignoran los efectos de la radiación"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.

	fleet := FleetRun assemble: { smugglerTransportOnWarp}.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 50 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: (95 - 10)).
	
	"El daño proviene aquí de la alta gravedad y no de la radiación..."	
	fleet runThrough: { self newPlanetarySectorWithGravity: 90 andRadiation: 200 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: (smugglerTransportOnWarp hasDamageLevel: 1).
	self assert: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: (95 - 20))
	
	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test12SpaceshipPassingThroughAsteroidSystemUsingImpulseThrustersLowersShields

	| fleet smugglerTransportOnImpulse |
	
	"Si el casco de la nave no ha sido dañado y se viaja en un sector de asteroidos utilizando el propulsor básico, los shields indefectiblemente reciben el impacto de los asteroides (nada que pueda hacer el piloto con ese tipo de propulsores) y se reducen permanentemente en 20"
	
	smugglerTransportOnImpulse := self newSmugglerTransportShipOnImpulse.
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 0).
	self deny: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasShieldLevelsAt: 50).

	fleet := FleetRun assemble: { smugglerTransportOnImpulse}.
	
	fleet runThrough: { self newAsteroidsSystemWithGravity: 65 andRadiation: 35 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnImpulse).
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 1).
	self assert: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasShieldLevelsAt: 50 - 20).

	
	
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test13SpaceshipPassingThroughAsteroidSystemUsingGravitonThrustersIgnoresGravityButConsumesDoubleFuel

	| fleet smugglerTransportOnGravitons |
	
	"Si el casco de la nave no ha sido dañado y se viaja en un sector de asteroides utilizando el avanzado sistema de propulsores basado en Gravitones, el piloto automático de la nave puede sin problema eludirlos sin impactos. Como el piloto no participa, no se tiene en cuenta el rating de maniobrabilidad de la nave, ni la gravedad del sector"
	
	"Al mismo tiempo, lamentablemente el sistema consume el doble de combustible que lo normal"
	
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons.
	
	fleet := FleetRun assemble: { smugglerTransportOnGravitons}.
	
	"La alta gravedad no son nada para el sistema avanzado de propulsores de Gravitones"
	fleet runThrough: { self newAsteroidsSystemWithGravity: 90 andRadiation: 30 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	"Doble gasto de combustible"
	self assert: (smugglerTransportOnGravitons hasFuel: (95 - 20)).

	"La radiación del sector es la que produce el daño (60 supera a los 50 de los shields de la nave) y no la gravedad..."
	fleet runThrough: { self newAsteroidsSystemWithGravity: 90 andRadiation: 60 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self assert: (smugglerTransportOnGravitons hasDamageLevel: 1).
	self assert: smugglerTransportOnGravitons isDamaged.
	"Doble gasto de combustible"
	self assert: (smugglerTransportOnGravitons hasFuel: (95 - 40))
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:14:40'!
test14SpaceshipPassingThroughAsteroidSystemUsingWarpLowersShieldsToZeroAndGetsDamaged

	| fleet smugglerTransportOnWarp |
	
	"Si el casco de la nave no ha sido dañado y se atraviesa un sector de asteroides utilizando warp, vas derecho al desastre... quien sea que haya trazado ese curso estará condenado, porque irá en linea recta contra un cinturón de asteroides a la velocidad de la luz (duh!!). En terminos prácticos, la nave pierde todos sus escudos permanentemente (pasan a 0) debido a los impactos con los asteroides, se le inflinje 1 nivel de daño al casco y además casi seguro se le suma otro nivel más por radiación al esta no contar más con sus escudos"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 0).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasShieldLevelsAt: 50).
	
	fleet := FleetRun assemble: { smugglerTransportOnWarp }.
	
	"Usar Warp con asteroides acaba con los shields y suma 1 nivel de daño al casco".
	"La radición daña al casco de la nave ya que sus shields se reducen a 0"
	fleet runThrough: { self newAsteroidsSystemWithGravity: 65 andRadiation: 30 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self assert: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasDamageLevel: 2).
	self assert: (smugglerTransportOnWarp hasShieldLevelsAt: 0).
	! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:14:35'!
test15SpaceshipPassingThroughNebulaUsingWarpIgnoresAllSectorChecksAndConsumesNoFuel

	| fleet smugglerTransportOnWarp |
	
	"Si el casco de la nave no ha sido dañado y se viaja hacia una nebula utilizando Warp, el modulo Warp se revigoriza por un efecto cuántico bien conocido por el contacto con los gases de la nébula, y casi la teletransporta de inmediato al próximo sector galáctico de la trayectoria del viaje. Luego no se consume combustible, y no se efectua ninguno de los chequeos típicos de supervivencia en el sector"
	
	smugglerTransportOnWarp := self newSmugglerTransportShipOnWarp.
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnWarp }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnWarp).
	self deny: smugglerTransportOnWarp isDamaged.
	self assert: (smugglerTransportOnWarp hasFuel: 95).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:14:31'!
test16SpaceshipPassingThroughNebulaUsingImpulseCosumesFuelsAndIsSubjectToGravityAndRadiation

	| fleet smugglerTransportOnImpulse |
	
	smugglerTransportOnImpulse := self newSmugglerTransportShipOnImpulse .
	self deny: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnImpulse }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnImpulse).
	self assert: (smugglerTransportOnImpulse hasDamageLevel: 2).
	self assert: smugglerTransportOnImpulse isDamaged.
	self assert: (smugglerTransportOnImpulse hasFuel: 95 - 10).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:14:27'!
test17SpaceshipPassingThroughNebulaUsingGravitonsOnlyCosumesFuels

	| fleet smugglerTransportOnGravitons |
			
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons .
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnGravitons }.
	
	fleet runThrough: { self newNebulaCloudWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95 - 20).
! !

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 16:27:15'!
test18PassingByPlanetarySectorWithGravitonsCosumesDoubleFuel

	| fleet smugglerTransportOnGravitons |
	
	smugglerTransportOnGravitons := self newSmugglerTransportShipOnGravitons .
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95).

	fleet := FleetRun assemble: { smugglerTransportOnGravitons }.
	
	fleet runThrough: { self newPlanetarySectorWithGravity: 90 andRadiation: 90 }.
	
	self assert: (fleet isNumberOfSurvivors: 1).
	self assert: (fleet hasSurvived: smugglerTransportOnGravitons).
	self deny: smugglerTransportOnGravitons isDamaged.
	self assert: (smugglerTransportOnGravitons hasFuel: 95 - 20).
! !


!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:36'!
newHeavyCruiserShipOnImpulse

	^SpaceShip heavyCruiserWithThrusters: self impulseThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:46'!
newLightInterceptorShipOnWarp

	^SpaceShip lightInterceptorWithThrusters: self warpThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:43:00'!
newSmugglerTransportShipOnGravitons

	^SpaceShip smugglerTransportWithThrusters: self gravitonsThrusters ! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:36'!
newSmugglerTransportShipOnImpulse

	^SpaceShip smugglerTransportWithThrusters: self impulseThrusters! !

!FleetRunTests methodsFor: 'spaceships' stamp: 'HAW 5/6/2025 13:42:46'!
newSmugglerTransportShipOnWarp

	^SpaceShip smugglerTransportWithThrusters: self warpThrusters! !


!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 09:49:05'!
newAsteroidsSystemWithGravity: gravity andRadiation: radiation

	^AsteroidsSystem gravity: gravity andRadiation: radiation ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 10:12:46'!
newNebulaCloudWithGravity: gravity andRadiation: radiation

	^NebulaCloud gravity: gravity andRadiation: radiation ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 09:03:05'!
newPlanetarySectorJourneySequenceOfSize: numberOfSectors withGravity: gravity withRadiation: radiation 

	^(1 to: numberOfSectors) collect: [ :sectorNumber | self newPlanetarySectorWithGravity: gravity andRadiation: radiation ].
	! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 08:51:43'!
newPlanetarySectorWithGravity: gravity andRadiation: radiation

	^PlanetarySector gravity: gravity andRadiation: radiation
! !


!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 20:14:01'!
gravitonsThrusters

	^ #gravitons ! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 20:14:09'!
impulseThrusters

	^ #impulse ! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 20:14:15'!
warpThrusters

	^ #warp ! !
