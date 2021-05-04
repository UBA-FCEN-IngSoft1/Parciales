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

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 5/2/2021 16:04:51'!
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

!RobotWarsTest methodsFor: 'robot creation tests' stamp: 'HAW 5/2/2021 16:05:22'!
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


!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:06:05'!
test07ClawReducesLifeOfAluminum3000By25

	self assertAttacking: self createAluminum3000 with: self createClaw reducesLifeBy: 25 * year
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:06:09'!
test08ClawReducesLifeOfTankRoverBy5

	self assertAttacking: self createTankRover with: self createClaw reducesLifeBy: 5 * year
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:06:13'!
test09HSBlasterReducesLifeOfAluminum3000By5

	self assertAttacking: self createAluminum3000 with: self createHSBlaster reducesLifeBy: 5 * year
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:05:33'!
test10HSBlasterReducesLifeOfTankRoverBy50

	self assertAttacking: self createTankRover with: self createHSBlaster reducesLifeBy: 50 * year
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:06:20'!
test11TurboLaserCannonReducesLifeOfAluminum3000By100

	self assertAttacking: self createAluminum3000 with: self createTurboLaserCannon reducesLifeBy: 100 * year
	
	! !

!RobotWarsTest methodsFor: 'victim life after attacking tests' stamp: 'HAW 5/2/2021 16:06:24'!
test12TurboLaserCannonReducesLifeOfTankRoverBy100

	self assertAttacking: self createTankRover with: self createTurboLaserCannon reducesLifeBy: 100 * year! !


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

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 17:58:31'!
test15AfterUsing5TimesHSBlasterAgainstAluminum3000RemovesItselfAndAddTurboLaserCannon
	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createAluminum3000.
	attackerWeapon := self createHSBlaster.
	attacker addWeapon: attackerWeapon.
	
	5 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self assert: 1 equals: attacker weaponsCount.
	self assert: (attacker includesWeaponOfType: TurboLaserCannon).
	! !

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 17:58:48'!
test16AddsClawWhenAttakingTankRoverWithHSBlasterAndVictingLiveLessOrEqualTo50
	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createHSBlaster .
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: 2 equals: attacker weaponsCount.
	self assert: (attacker includesWeapon: attackerWeapon).
	self assert: (attacker includesWeaponOfType: Claw).
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

!RobotWarsTest methodsFor: 'weapon use after attacking tests' stamp: 'HAW 4/30/2021 19:31:17'!
test18CanUseOnlyTurboLaserCannon10TimesWhenAttakingTankRover

	| attacker attacked attackerWeapon |
	
	attacker := self createAluminum3000.
	attacked := self createTankRover.
	attackerWeapon := self createTurboLaserCannon .
	attacker addWeapon: attackerWeapon.
	
	5 timesRepeat: [ attacker attack: attacked with: attackerWeapon ].
	
	self assert: 1 equals: attacker weaponsCount.
	self assert: (attacker includesWeaponOfType: HSBlaster)
	! !


!RobotWarsTest methodsFor: 'robot creation' stamp: 'HAW 4/30/2021 17:49:45'!
createAluminum3000

	^ Aluminum3000 new! !

!RobotWarsTest methodsFor: 'robot creation' stamp: 'HAW 4/30/2021 17:49:52'!
createTankRover

	^ TankRover new! !


!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 17:45:41'!
createClaw

	^ Claw new! !

!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 17:45:50'!
createHSBlaster

	^ HSBlaster new! !

!RobotWarsTest methodsFor: 'weapon creation' stamp: 'HAW 4/30/2021 17:45:56'!
createTurboLaserCannon

	^ TurboLaserCannon new! !


!RobotWarsTest methodsFor: 'assertions' stamp: 'HAW 5/2/2021 16:05:45'!
assertAttacking: attacked with: attackerWeapon reducesLifeBy: delta  

	| attacker |
	
	attacker := self createAluminum3000.
	attacker addWeapon: attackerWeapon.
	
	attacker attack: attacked with: attackerWeapon.
	
	self assert: 100 * year - delta equals: attacked life! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotWarsTest class' category: 'ISW1-2021-1C-1erParcial'!
RobotWarsTest class
	instanceVariableNames: ''!

!RobotWarsTest class methodsFor: 'class initialization' stamp: 'HAW 5/2/2021 16:01:30'!
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
	instanceVariableNames: 'life weapons'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Robot methodsFor: 'assertions' stamp: 'HAW 4/30/2021 19:23:06'!
assertAddingNewWeaponDoesNotPassMaxWeaponWeight: aWeapon

	^ (self totalWeaponWeight + aWeapon weight) > self maxWeaponWeight ifTrue: [ self signalMaxWeaponWeightExceeded ]! !

!Robot methodsFor: 'assertions' stamp: 'HAW 4/30/2021 19:21:43'!
assertAddingNewWeaponDoesNotPassSpeed: aWeapon

	^ (self totalSpeedImpact + aWeapon speedImpact) > self speed ifTrue: [ self signalSpeedBelowZero ]! !


!Robot methodsFor: 'attacking' stamp: 'HAW 4/30/2021 17:13:38'!
attack: aVictim with: aWeapon

	(weapons includes: aWeapon) 
		ifTrue: [ aWeapon attack: aVictim by: self ]
		ifFalse: [ self signalCanNotAttackWithWeaponNotBelongingToRobot ]! !


!Robot methodsFor: 'attacking - private' stamp: 'HAW 4/30/2021 18:06:40'!
attackedWith: aWeapon by: anAttacker

	self subclassResponsibility ! !


!Robot methodsFor: 'exceptions' stamp: 'HAW 4/29/2021 20:49:49'!
signalCanNotAttackWithWeaponNotBelongingToRobot
	
	self error: self class canNotAttackWithWeaponNotBelongingToRobotErrorDescription! !

!Robot methodsFor: 'exceptions' stamp: 'FRT 4/28/2021 16:02:10'!
signalMaxWeaponWeightExceeded

	self error: self class maxWeaponWeightExceededErrorDescription 	! !

!Robot methodsFor: 'exceptions' stamp: 'FRT 4/28/2021 22:53:14'!
signalSpeedBelowZero

	self error: self class speedBelowZeroErrorDescription 	! !


!Robot methodsFor: 'initialization' stamp: 'HAW 5/2/2021 16:01:56'!
initialize
	
	weapons := OrderedCollection new.
	life := 100 * year.

	! !


!Robot methodsFor: 'life' stamp: 'FRT 4/28/2021 20:33:19'!
life

	^ life! !

!Robot methodsFor: 'life' stamp: 'HAW 4/30/2021 18:05:23'!
reduceLifeBy: lifePoints

	life := life - lifePoints! !


!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 17:18:10'!
addWeapon: aWeapon

	self assertAddingNewWeaponDoesNotPassMaxWeaponWeight: aWeapon.
	self assertAddingNewWeaponDoesNotPassSpeed: aWeapon.
	
	weapons add: aWeapon.
	! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 17:13:44'!
includesWeapon: aWeapon 
	
	^weapons includes: aWeapon ! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 17:58:42'!
includesWeaponOfType: aWeaponType

	^weapons anySatisfy: [ :weapon | weapon class = aWeaponType ]! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 17:13:54'!
removeWeapon: aWeapon 
	
	weapons remove: aWeapon ! !

!Robot methodsFor: 'weapons' stamp: 'HAW 5/2/2021 16:02:46'!
totalSpeedImpact

	^ (weapons select: [ :weapon | weapon weight > (10 * kilogram) ])
		sum: [ :weapon | weapon speedImpact ] ifEmpty: [ 0 * kilometer / hour ]! !

!Robot methodsFor: 'weapons' stamp: 'HAW 5/2/2021 16:02:54'!
totalWeaponWeight

	^weapons sum: [ :weapon | weapon weight ] ifEmpty: [ 0 * kilogram ]! !

!Robot methodsFor: 'weapons' stamp: 'HAW 4/30/2021 17:14:11'!
weaponsCount

	^ weapons size 	! !


!Robot methodsFor: 'accesing' stamp: 'HAW 4/30/2021 19:24:25'!
maxWeaponWeight

	self subclassResponsibility ! !

!Robot methodsFor: 'accesing' stamp: 'HAW 4/30/2021 19:24:30'!
speed

	self subclassResponsibility ! !

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

!Robot class methodsFor: 'error description' stamp: 'FRT 4/28/2021 22:53:14'!
speedBelowZeroErrorDescription

	^ 'Speed cannot be below zero'! !


!classDefinition: #Aluminum3000 category: 'ISW1-2021-1C-1erParcial'!
Robot subclass: #Aluminum3000
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Aluminum3000 methodsFor: 'attacking - private' stamp: 'HAW 4/30/2021 17:51:56'!
attackedWith: aWeapon by: anAttacker

	^aWeapon attackAluminum3000: self by: anAttacker ! !


!Aluminum3000 methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:12'!
maxWeaponWeight

	^50 * kilogram ! !

!Aluminum3000 methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:22'!
speed

	^ 90 * kilometer / hour
	! !


!classDefinition: #TankRover category: 'ISW1-2021-1C-1erParcial'!
Robot subclass: #TankRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!TankRover methodsFor: 'attacking - private' stamp: 'HAW 4/30/2021 17:53:09'!
attackedWith: aWeapon by: anAttacker

	^aWeapon attackTankRover: self by: anAttacker ! !


!TankRover methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:30'!
maxWeaponWeight

	^200 * kilogram ! !

!TankRover methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:40'!
speed
	
	^40 * kilometer / hour! !


!classDefinition: #Weapon category: 'ISW1-2021-1C-1erParcial'!
Object subclass: #Weapon
	instanceVariableNames: 'usedTimes'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Weapon methodsFor: 'accesing' stamp: 'HAW 4/30/2021 19:28:14'!
speedImpact
	
	self subclassResponsibility ! !

!Weapon methodsFor: 'accesing' stamp: 'HAW 4/30/2021 19:28:21'!
weight
	
	self subclassResponsibility ! !


!Weapon methodsFor: 'initialization' stamp: 'HAW 4/30/2021 19:27:23'!
initialize 
	
	usedTimes := 0.! !


!Weapon methodsFor: 'attacking' stamp: 'HAW 4/30/2021 17:57:18'!
attack: aVictim by: anAttacker 	

	usedTimes := usedTimes + 1.
	aVictim attackedWith: self by: anAttacker 
	! !


!Weapon methodsFor: 'attacking - private' stamp: 'HAW 4/30/2021 18:01:40'!
attackAluminum3000: aVictim by: anAttacker

	self subclassResponsibility ! !

!Weapon methodsFor: 'attacking - private' stamp: 'HAW 4/30/2021 18:01:55'!
attackTankRover: aVictim by: anAttacker
	
	self subclassResponsibility ! !


!classDefinition: #Claw category: 'ISW1-2021-1C-1erParcial'!
Weapon subclass: #Claw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!Claw methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:06:56'!
attackAluminum3000: aVictim by: anAttacker
 
	aVictim reduceLifeBy: 25 * year.
	usedTimes = 2 ifTrue: [ anAttacker removeWeapon: self ].
! !

!Claw methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:07:01'!
attackTankRover: aVictim by: anAttacker

	aVictim reduceLifeBy: 5 * year.
	anAttacker removeWeapon: self.
	! !


!Claw methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:53'!
speedImpact

	^ 5 * kilometer / hour
! !

!Claw methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:03:58'!
weight

	^ 10 * kilogram ! !


!classDefinition: #HSBlaster category: 'ISW1-2021-1C-1erParcial'!
Weapon subclass: #HSBlaster
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!HSBlaster methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:07:09'!
attackAluminum3000: aVictim by: anAttacker
 
	aVictim reduceLifeBy: 5 * year.
	usedTimes = 5 ifTrue: [ 
		anAttacker removeWeapon: self.
		anAttacker addWeapon: TurboLaserCannon new ].
! !

!HSBlaster methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:08:21'!
attackTankRover: aVictim by: anAttacker
 
	aVictim reduceLifeBy: 50 * year.
	aVictim life <= (50 * year) ifTrue: [ anAttacker addWeapon: Claw new ].
! !


!HSBlaster methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:04:07'!
speedImpact

	^ 10 * kilometer / hour! !

!HSBlaster methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:04:14'!
weight

	^ 20 * kilogram ! !


!classDefinition: #TurboLaserCannon category: 'ISW1-2021-1C-1erParcial'!
Weapon subclass: #TurboLaserCannon
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-1C-1erParcial'!

!TurboLaserCannon methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:07:19'!
attackAluminum3000: aVictim by: anAttacker 
	
	aVictim reduceLifeBy: 100 * year.
	usedTimes = 10 ifTrue: [ anAttacker removeWeapon: self ].
	! !

!TurboLaserCannon methodsFor: 'attacking - private' stamp: 'HAW 5/2/2021 16:07:25'!
attackTankRover: aVictim by: anAttacker

	aVictim reduceLifeBy: 100 * year.
	usedTimes = 5 ifTrue: [ 
		anAttacker removeWeapon: self.
		anAttacker addWeapon: HSBlaster new].
	! !


!TurboLaserCannon methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:04:24'!
speedImpact

	^ 15 * kilometer / hour! !

!TurboLaserCannon methodsFor: 'accesing' stamp: 'HAW 5/2/2021 16:04:32'!
weight

	^ 40 * kilogram ! !

RobotWarsTest initialize!