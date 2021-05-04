!classDefinition: #RobotWarsTest category: 'ISW1-2021-1C-1erParcial'!
TestCase subclass: #RobotWarsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 4/30/2021 17:31:10'!
test01ShouldNotAddWeaponIfMaxWeaponWeightExceeded
	
	| robot addedWeapon |
	
	robot := self createAluminum3000.
	addedWeapon := self createTurboLaserCannon.
	robot addWeapon: addedWeapon.
	
	self
		should: [ robot addWeapon: self createTurboLaserCannon ]
		raise: Error
		withMessageText: Robot maxWeaponWeightExceededErrorDescription.
		
	self assert: 1 equals: robot weaponsCount.
	self assert: (robot includesWeapon: addedWeapon)

	
	

	! !

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 4/30/2021 17:31:48'!
test02ShouldNotAddWeaponIfSpeedBelowZero
	
	| robot firstAddedWeapon secondAddedWeapon |
	
	robot := self createTankRover.
	firstAddedWeapon := self createTurboLaserCannon.
	robot addWeapon: firstAddedWeapon.
	secondAddedWeapon := self createTurboLaserCannon.
	robot addWeapon: secondAddedWeapon.
		
	self
		should: [ robot addWeapon: self createTurboLaserCannon ]
		raise: Error
		withMessageText: Robot speedBelowZeroErrorDescription .
		
	self assert: 2 equals: (robot weaponsCount).
	self assert: (robot includesWeapon: firstAddedWeapon).
	self assert: (robot includesWeapon: secondAddedWeapon)
	

	! !

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 5/2/2021 15:49:38'!
test03ShouldHaveZeroWeightWhenNoWeaponsAdded
	
	| robot |
	
	robot := self createTankRover.

	self assert: 0 * kilogram equals: robot totalWeaponWeight.
	
	

	! !

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 4/30/2021 17:32:23'!
test04ShouldAddWeightWhenAddingWeapon
	
	| robot weapon |
	
	robot := self createTankRover.
	weapon := self createTurboLaserCannon.

	robot addWeapon: weapon.

	self assert: weapon weight equals: robot totalWeaponWeight.
	
	

	! !

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 5/2/2021 15:49:58'!
test05ShouldHaveZeroSpeedWhenNoWeaponsAdded
	
	| robot |
	
	robot := self createTankRover.

	self assert: 0 * kilometer / hour equals: robot totalSpeedImpact.
	
	

	! !

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 4/30/2021 17:32:57'!
test06ShouldAddSpeedImpactWhenAddingWeapons

	| robot weapon anotherWeapon |
	
	robot := self createTankRover.
	weapon := self createTurboLaserCannon.
	anotherWeapon := self createClaw.

	robot addWeapon: weapon.
	robot addWeapon: anotherWeapon.

	self assert: weapon weight + anotherWeapon weight equals: robot totalWeaponWeight.
	
	

	! !


!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:47:51'!
test07ClawReducesLifeOfAluminum3000By25

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createClaw.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (25 * year) equals: attacked life
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:48:11'!
test08ClawReducesLifeOfTankRoverBy5

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createClaw.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (5 * year) equals: attacked life
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:48:31'!
test09HSBlasterReducesLifeOfAluminum3000By5

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createHSBlaster.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (5 * year) equals: attacked life
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:47:17'!
test10HSBlasterReducesLifeOfTankRoverBy50

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createHSBlaster.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (50 * year) equals: attacked life
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:49:02'!
test11TurboLaserCannonReducesLifeOfAluminum3000By100

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createTurboLaserCannon.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (100 * year) equals: attacked life
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 15:49:15'!
test12TurboLaserCannonReducesLifeOfTankRoverBy100

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createTurboLaserCannon.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: (100 * year) - (100 * year) equals: attacked life
	
	! !


!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 17:41:40'!
test13CanUseClawOnlyTwiceWhenAttackingAluminum3000

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createClaw.
	attacker addWeapon: attackerWeapon.
	
	2 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self 
		should: [ attacker attack: attacked with: attackerWeapon ]
		raise: Error
		withMessageText: Robot canNotAttackWithWeaponNotBelongingToRobotErrorDescription 
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 17:42:05'!
test14CanUseClawOnlyOnceWhenAttackingTankRover

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createClaw.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self 
		should: [ attacker attack: attacked with: attackerWeapon ]
		raise: Error
		withMessageText: Robot canNotAttackWithWeaponNotBelongingToRobotErrorDescription 
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 19:38:04'!
test15AfterUsing5TimesHSBlasterAgainstAluminum3000RemovesItselfAndAddTurboLaserCannon
	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createHSBlaster.
	attacker addWeapon: attackerWeapon.
	
	5 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self assert: 1 equals: attacker weaponsCount.
	self assert: (attacker includesWeaponOfType: #TurboLaserCannon).
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 19:38:09'!
test16AddsClawWhenAttakingTankRoverWithHSBlasterAndVictingLiveLessOrEqualTo50
	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createHSBlaster .
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: 2 equals: attacker weaponsCount.
	self assert: (attacker includesWeapon: attackerWeapon).
	self assert: (attacker includesWeaponOfType: #Claw).
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 17:43:35'!
test17CanUseOnlyTurboLaserCannon10TimesWhenAttakingAluminum3000

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createTurboLaserCannon.
	attacker addWeapon: attackerWeapon.
	
	10 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self assert: 0 equals: attacker weaponsCount.
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 19:38:16'!
test18CanUseOnlyTurboLaserCannon10TimesWhenAttakingTankRover

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createTurboLaserCannon .
	attacker addWeapon: attackerWeapon.
	
	5 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self assert: 1 equals: attacker weaponsCount.
	self assert: (attacker includesWeaponOfType: #HSBlaster)
	! !


!RobotWarsTest methodsFor: 'robot creation' stamp: 'HAW 4/30/2021 19:37:15'!
createAluminum3000

	^ Robot ofType: #Aluminum3000 ! !

!RobotWarsTest methodsFor: 'robot creation' stamp: 'HAW 4/30/2021 19:37:25'!
createTankRover

	^ Robot ofType: #TankRover ! !


!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 19:37:36'!
createClaw

	^ Weapon ofType: #Claw ! !

!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 19:37:46'!
createHSBlaster

	^ Weapon ofType: #HSBlaster ! !

!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 19:37:52'!
createTurboLaserCannon

	^ Weapon ofType: #TurboLaserCannon ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotWarsTest class' category: 'ISW1-2021-1C-1erParcial'!
RobotWarsTest class
	instanceVariableNames: ''!

!RobotWarsTest class methodsFor: 'class initialization' stamp: 'HAW 5/2/2021 15:40:59'!
initialize

	"Este método está para crear una unidad que falta, no lo deben tocar ni darle importancia durante 
	el parcial - Hernan"
	| kilogram |
	gram := BaseUnit named: 'gram' sign: 'g'.
	kilogram := ProportionalDerivedUnit baseUnit: gram conversionFactor: 1000  named: 'kilogram' sign: 'kg'.
	
	Smalltalk at: #kilogram put: kilogram
	! !


!classDefinition: #Robot category: 'ISW1-2021-1C-1erParcial'!
Object subclass: #Robot
	instanceVariableNames: 'type life speed maxWeaponWeight weapons'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Robot methodsFor: 'type' stamp: 'HAW 4/29/2021 17:46:19'!
type

	^ type	! !


!Robot methodsFor: 'initialization' stamp: 'FRT 4/28/2021 15:36:58'!
initializeType: aRobotType life: lifePoints speed: aSpeed maxWeaponWeight: aMaxWeaponWeight

	type := aRobotType.
	life := lifePoints.
	speed := aSpeed.
	maxWeaponWeight := aMaxWeaponWeight.

	! !


!Robot methodsFor: 'attacking' stamp: 'HAW 4/30/2021 16:57:30'!
attack: aVictim with: aWeapon

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	(weapons includes: aWeapon) 
		ifTrue: [ aWeapon attack: aVictim by: self ]
		ifFalse: [ self signalCanNotAttackWithWeaponNotBelongingToRobot ]! !


!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 16:56:38'!
addWeapon: aWeapon

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].
	
	(self totalWeaponWeight + aWeapon weight) > maxWeaponWeight ifTrue: [ self signalMaxWeaponWeightExceeded ].
	
	(self totalSpeedImpact + aWeapon speedImpact) > speed ifTrue: [ self signalSpeedBelowZero ].
	
	weapons add: aWeapon.
	! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 16:56:43'!
includesWeapon: aWeapon 
	
	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	^weapons includes: aWeapon ! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 16:56:48'!
includesWeaponOfType: aWeaponType

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	^weapons anySatisfy: [ :weapon | weapon type = aWeaponType ]! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 16:56:54'!
removeWeapon: aWeapon 
	
	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	weapons remove: aWeapon ! !

!Robot methodsFor: 'weapons' stamp: 'HAW 5/2/2021 15:51:03'!
totalSpeedImpact

	| total index |

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	total := 0 * kilometer / hour.
	index := 1.
	
	[index <= weapons size] whileTrue: [ | weapon |
		weapon := (weapons at: index).
		(weapon weight > (10 * kilogram)) ifTrue: [ total := total +  weapon speedImpact ].
		index := index + 1.	
	].

	^ total.! !

!Robot methodsFor: 'weapons' stamp: 'HAW 5/2/2021 15:51:34'!
totalWeaponWeight

	| total index |

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	total := 0 * kilogram.
	index := 1.
	
	[index <= weapons size] whileTrue: [ | weapon |
		weapon := (weapons at: index).
		total := total + weapon weight.
		index := index + 1.	
	].

	^ total.	! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 16:57:10'!
weaponsCount

	weapons isNil ifTrue: [ weapons := OrderedCollection new ].

	^ weapons size 	! !


!Robot methodsFor: 'life' stamp: 'FRT 4/28/2021 20:33:19'!
life

	^ life! !

!Robot methodsFor: 'life' stamp: 'HAW 5/2/2021 15:52:01'!
life: newLife

	life := newLife! !


!Robot methodsFor: 'exceptions' stamp: 'HAW 4/29/2021 20:49:49'!
signalCanNotAttackWithWeaponNotBelongingToRobot
	
	self error: self class canNotAttackWithWeaponNotBelongingToRobotErrorDescription! !

!Robot methodsFor: 'exceptions' stamp: 'FRT 4/28/2021 16:02:10'!
signalMaxWeaponWeightExceeded

	self error: self class maxWeaponWeightExceededErrorDescription 	! !

!Robot methodsFor: 'exceptions' stamp: 'FRT 4/28/2021 22:53:14'!
signalSpeedBelowZero

	self error: self class speedBelowZeroErrorDescription 	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: 'ISW1-2021-1C-1erParcial'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'error description' stamp: 'HAW 4/29/2021 20:50:34'!
canNotAttackWithWeaponNotBelongingToRobotErrorDescription
	
	^'Cannot attack with weapon not belonging to robot'! !

!Robot class methodsFor: 'error description' stamp: 'FRT 4/28/2021 16:04:48'!
maxWeaponWeightExceededErrorDescription

	^ 'Maximum weapon weight has been exceeded'! !

!Robot class methodsFor: 'error description' stamp: 'HAW 5/2/2021 15:52:46'!
speedBelowZeroErrorDescription

	^ 'Speed cannot be below zero kilometer per hour'! !


!Robot class methodsFor: 'instance creation' stamp: 'HAW 5/2/2021 15:43:10'!
ofType: aRobotType

	aRobotType = #Aluminum3000 ifTrue: [ ^ self new 
		initializeType: aRobotType 
		life: 100 * year
		speed: 90 * kilometer / hour
		maxWeaponWeight: 50 * kilogram ].
	aRobotType = #TankRover ifTrue: [ ^ self new 
		initializeType: aRobotType 
		life: 100 * year
		speed: 40 * kilometer / hour
		maxWeaponWeight: 200 * kilogram ].

	self error: 'Invalid Robot Type'! !


!classDefinition: #Weapon category: 'ISW1-2021-1C-1erParcial'!
Object subclass: #Weapon
	instanceVariableNames: 'type weight speedImpact usedTimes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Weapon methodsFor: 'accesing' stamp: 'FRT 4/28/2021 22:43:38'!
speedImpact
	
	^ speedImpact! !

!Weapon methodsFor: 'accesing' stamp: 'FRT 4/28/2021 22:43:53'!
weight
	
	^ weight! !


!Weapon methodsFor: 'initialization' stamp: 'HAW 4/30/2021 17:03:09'!
initializeType: aWeaponType weight: aWeight speedImpact: aSpeedImpact 
	
	type := aWeaponType.
	weight := aWeight.
	speedImpact := aSpeedImpact.
	usedTimes := 0.! !


!Weapon methodsFor: 'attacking' stamp: 'HAW 5/2/2021 15:46:43'!
attack: aVictim by: anAttacker 	

	usedTimes := usedTimes + 1.
	type = #Claw ifTrue: [
		aVictim type = #Aluminum3000 ifTrue: [
			aVictim life: aVictim life - (25 * year).
			usedTimes = 2 ifTrue: [ anAttacker removeWeapon: self ].
		].
	
		aVictim type = #TankRover ifTrue: [
			aVictim life: aVictim life - (5 * year).
			anAttacker removeWeapon: self.
		].
	
	].

	type = #HSBlaster ifTrue: [
		aVictim type = #Aluminum3000 ifTrue: [
			aVictim life: aVictim life - (5 * year).
			usedTimes = 5 ifTrue: [ 
				anAttacker removeWeapon: self.
				anAttacker addWeapon: (Weapon ofType: #TurboLaserCannon) ].
		].
	
		aVictim type = #TankRover ifTrue: [
			aVictim life: aVictim life - (50 * year).
			aVictim life <= (50 * year) ifTrue: [ anAttacker addWeapon: (Weapon ofType: #Claw) ].
		].
	].

	type = #TurboLaserCannon ifTrue: [
		aVictim type = #Aluminum3000 ifTrue: [
			aVictim life: aVictim life - (100 * year).
			usedTimes = 10 ifTrue: [ anAttacker removeWeapon: self ]
		].
	
		aVictim type = #TankRover ifTrue: [
			aVictim life: aVictim life - (100 * year).
			usedTimes = 5 ifTrue: [ 
				anAttacker removeWeapon: self.
				anAttacker addWeapon: (Weapon ofType: #HSBlaster) ]
		].
	].! !


!Weapon methodsFor: 'type' stamp: 'HAW 4/30/2021 16:45:24'!
type
	
	^type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Weapon class' category: 'ISW1-2021-1C-1erParcial'!
Weapon class
	instanceVariableNames: ''!

!Weapon class methodsFor: 'instance creation' stamp: 'HAW 5/2/2021 15:44:12'!
ofType: aWeaponType

	aWeaponType = #Claw ifTrue: [ ^self new 
		initializeType: aWeaponType weight: 10 * kilogram speedImpact: 5 * kilometer / hour ].
	aWeaponType = #HSBlaster ifTrue: [ ^ self new 
		initializeType: aWeaponType weight: 20 * kilogram speedImpact: 10 * kilometer / hour ].
	aWeaponType = #TurboLaserCannon ifTrue: [^ self new 
		initializeType: aWeaponType weight: 40 * kilogram speedImpact: 15 * kilometer / hour ].

	self error: 'Invalid Weapon Type'! !

RobotWarsTest initialize!