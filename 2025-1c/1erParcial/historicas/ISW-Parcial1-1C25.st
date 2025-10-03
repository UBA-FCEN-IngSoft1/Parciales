!classDefinition: #FleetRun category: #'ISW-Parcial1-1C25'!
Object subclass: #FleetRun
	instanceVariableNames: 'fleet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!FleetRun methodsFor: 'initialization' stamp: 'HAW 5/6/2025 08:51:21'!
initializeAssemble: aFleet 
	
	fleet := aFleet.! !


!FleetRun methodsFor: 'run by sectors' stamp: 'HAW 5/6/2025 13:47:42'!
runThrough: sectors 
	
	self shouldBeImplemented ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FleetRun class' category: #'ISW-Parcial1-1C25'!
FleetRun class
	instanceVariableNames: ''!

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 13:26:28'!
allSpaceshipsShouldBeDifferentErrorDescription

	^ 'All the spaceships in the fleet must be unique'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 11:19:11'!
emptyRouteErrorDescription

	^ 'The route cannot be empty'! !

!FleetRun class methodsFor: 'message error' stamp: 'HAW 5/6/2025 13:26:42'!
fleetWithoutSpaceshipsErrorDescription

	^ 'The fleet cannot be empty'! !


!FleetRun class methodsFor: 'instance creation' stamp: 'HAW 5/6/2025 13:47:04'!
assemble: aFleet 
	
	^self new initializeAssemble: aFleet ! !


!classDefinition: #SpaceShip category: #'ISW-Parcial1-1C25'!
Object subclass: #SpaceShip
	instanceVariableNames: 'thrusters maneuverability shields fuel maxDamageLevel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Parcial1-1C25'!

!SpaceShip methodsFor: 'initialization' stamp: 'HAW 5/6/2025 13:48:47'!
initializeWithThrusters: aThrusters maneuverability: aManeuverability shileds: aShields fuel: aFuel damageLevel: aMaxDamageLevel     
	
	thrusters := aThrusters.
	maneuverability := aManeuverability.
	shields := aShields.
	fuel := aFuel.
	maxDamageLevel := aMaxDamageLevel.
	! !

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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:08:31'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:08:37'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:08:42'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 20:08:47'!
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

!FleetRunTests methodsFor: 'tests' stamp: 'HAW 5/6/2025 13:50:17'!
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


!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 13:44:17'!
newAsteroidsSystemWithGravity: gravity andRadiation: radiation

	self shouldBeImplemented ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 13:44:21'!
newNebulaCloudWithGravity: gravity andRadiation: radiation

	self shouldBeImplemented ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 13:44:43'!
newPlanetarySectorJourneySequenceOfSize: numberOfSectors withGravity: gravity withRadiation: radiation 

	self shouldBeImplemented ! !

!FleetRunTests methodsFor: 'space sectors' stamp: 'HAW 5/6/2025 13:44:27'!
newPlanetarySectorWithGravity: gravity andRadiation: radiation

	self shouldBeImplemented ! !


!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 13:44:12'!
gravitonsThrusters

	self shouldBeImplemented ! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 13:44:07'!
impulseThrusters

	self shouldBeImplemented ! !

!FleetRunTests methodsFor: 'thrusters' stamp: 'HAW 5/6/2025 13:44:00'!
warpThrusters

	self shouldBeImplemented ! !
