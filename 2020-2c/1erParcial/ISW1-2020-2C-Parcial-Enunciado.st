!classDefinition: #BackpackTest category: 'ISW1-2020-2C-Parcial-Enunciado'!
TestCase subclass: #BackpackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!BackpackTest methodsFor: 'adding' stamp: 'FRT 10/15/2020 12:40:22'!
test07ShouldNotAddNoPointsPortableObjectIfWeightExceeded

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self
		should: [ aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 42 + 1) ]
		raise: Error
		withMessageText: Backpack maxWeightExceededErrorDescription.
		
	self assert: aBackpack isEmpty. 
! !

!BackpackTest methodsFor: 'adding' stamp: 'FRT 10/15/2020 12:36:55'!
test08ShouldNotAddPointsPortableObjectIfWeightExceeded

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self
		should: [ aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 42 + 6 worth: 5) ]
		raise: Error
		withMessageText: Backpack maxWeightExceededErrorDescription.
		
	self assert: aBackpack isEmpty. 
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/14/2020 14:35:57'!
test09ShouldAddPortableObjectsIfWeightUnderMaxWeightCapacity

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 40 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1).
	
	self assert: aBackpack size equals: 2.
	self assert: aBackpack totalWeight equals: 41.
	self assert: aBackpack totalPoints equals: 5.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/14/2020 14:35:57'!
test10ShouldAddPortableObjectsIfWeightEqualsMaxWeightCapacity

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 40 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 1).
	aBackpack add: (PointsPortableObject named: 'letter' weighing: 1 worth: 5).
	
	self assert: aBackpack size equals: 3.
	self assert: aBackpack totalWeight equals: 42.
	self assert: aBackpack totalPoints equals: 10.
! !


!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test01CanNotCreateBackpackWithZeroMaxWeight

	self
		should: [ Backpack containingUpTo: 0 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack invalidWeightCapacityErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test02CanNotCreateBackpackWithNegativeMaxWeight

	self
		should: [ Backpack containingUpTo: -1 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack invalidWeightCapacityErrorDescription.! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test03CanNotCreateBackpackWithZeroMaxPoints

	self
		should: [ Backpack containingUpTo: 10 limitingPointsTo: 0 ]
		raise: Error
		withMessageText: Backpack invalidPointsCapacityErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test04CanNotCreateBackpackWithNegativeMaxPoints

	self
		should: [ Backpack containingUpTo: 10 limitingPointsTo: -1 ]
		raise: Error
		withMessageText: Backpack invalidPointsCapacityErrorDescription.! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test05CanNotCreateBackpackWithNoIntegerMaxWeight

	self
		should: [ Backpack containingUpTo: 1.0 limitingPointsTo: 100 ]
		raise: Error
		withMessageText: Backpack weightCapacityMustBeIntegerErrorDescription.
! !

!BackpackTest methodsFor: 'creating' stamp: 'HAW 10/14/2020 14:31:04'!
test06CanNotCreateBackpackWithNoIntegerMaxPoints

	self
		should: [ Backpack containingUpTo: 100 limitingPointsTo: 1.0 ]
		raise: Error
		withMessageText: Backpack pointsCapacityMustBeIntegerErrorDescription.
! !


!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:49:20'!
test11ShouldAddZeroWeightWhenEmpty

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self assert: aBackpack totalWeight equals: 0.
	self assert: aBackpack isEmpty
! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test12ShouldAddWeightWhenAddingPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	
	self assert: aBackpack size equals: 2.
	self assert: aBackpack totalWeight equals: 20.

! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:49:31'!
test13ShouldAddZeroPointsWhenEmpty

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	self assert: aBackpack totalPoints equals: 0.
	self assert: aBackpack isEmpty.
! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test14ShouldAddPointsWhenAddingPointsPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (PointsPortableObject named: 'car key' weighing: 10 worth: 20).
	
	self assert: aBackpack size equals: 2.
	self assert: aBackpack totalPoints equals: 25.

! !

!BackpackTest methodsFor: 'accessing' stamp: 'HAW 10/14/2020 14:35:57'!
test15ShouldNotAddPointsWhenAddingNoPointsPortableObjects

	| aBackpack |
	aBackpack := Backpack containingUpTo: 42 limitingPointsTo: 100.

	aBackpack add: (PointsPortableObject named: 'left-handed hammer' weighing: 10 worth: 5).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	aBackpack add: (NoPointsPortableObject named: 'help-wanted sign' weighing: 10).
	
	self assert: aBackpack size equals: 3.
	self assert: aBackpack totalPoints equals: 5.

! !


!classDefinition: #DoorTest category: 'ISW1-2020-2C-Parcial-Enunciado'!
TestCase subclass: #DoorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:43:48'!
test01ADoorOpenedCanNotBeOpenedAgain
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door opened.
	
	self 
		should: [ aDoor toBeOpenedBy: mainCharacter ]
		raise: Error
		withMessageText: Door alreadyOpenedErrorDescription.
		
	self assert: aDoor isOpen.! !

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:44:18'!
test04ADoorClosedCanBeOpened
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door closed.
	
	self deny: aDoor isOpen.
	aDoor toBeOpenedBy: mainCharacter.
	self assert: aDoor isOpen.! !

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:44:30'!
test05ADoorClosedCanNotBeOpenedWithAKey
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door closed.
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	
	self 
		should: [ aDoor toBeOpenedBy: mainCharacter using: oldKey ]
		raise: Error
		withMessageText: Door noNeedForAKeyErrorDescription.
		
	self deny: aDoor isOpen.! !

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:47:44'!
test07ADoorKeyClosedCanNotBeOpenedWithoutAKey
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	aDoor := Door closedWith: oldKey.
	
	self 
		should: [ aDoor toBeOpenedBy: mainCharacter ]
		raise: Error
		withMessageText: Door closedWithKeyErrorDescription.
		
	self deny: aDoor isOpen! !

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:47:52'!
test08ADoorKeyClosedCanNotBeOpenWithAnyKey
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	aDoor := Door closedWith: oldKey.
	
	self 
		should: [ aDoor toBeOpenedBy: mainCharacter using: (PointsPortableObject named: 'car key' weighing: 2 worth: 1000) ]
		raise: Error
		withMessageText: Door notCorrectKeyErrorDescription.
		
	self deny: aDoor isOpen ! !

!DoorTest methodsFor: 'opening' stamp: 'HAW 10/14/2020 14:48:03'!
test09ADoorKeyClosedCanBeOpenWithTheCorrectKey
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	aDoor := Door closedWith: oldKey.
	
	self deny: aDoor isOpen.
	aDoor toBeOpenedBy: mainCharacter using: oldKey.
	self assert: aDoor isOpen! !


!DoorTest methodsFor: 'closing' stamp: 'HAW 10/14/2020 14:43:40'!
test02ADoorOpenedCanBeClosed
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door opened.
	
	self assert: aDoor isOpen.
	aDoor toBeClosedBy: mainCharacter.
	self deny: aDoor isOpen.
	! !

!DoorTest methodsFor: 'closing' stamp: 'HAW 10/14/2020 14:48:16'!
test03ADoorClosedCanNotBeClosedAgain
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door closed.
	
	self 
		should: [ aDoor toBeClosedBy: mainCharacter ]
		raise: Error
		withMessageText: Door alreadyClosedErrorDescription.
		
	self deny: aDoor isOpen! !

!DoorTest methodsFor: 'closing' stamp: 'HAW 10/14/2020 14:48:25'!
test06ADoorKeyClosedCanNotBeClosedAgain
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	aDoor := Door closedWith: oldKey.
	
	self 
		should: [ aDoor toBeClosedBy: mainCharacter ]
		raise: Error
		withMessageText: Door alreadyClosedErrorDescription.
		
	self deny: aDoor isOpen! !


!DoorTest methodsFor: 'using' stamp: 'HAW 10/14/2020 14:48:39'!
test10WhenUsingADoorClosedGetsOpened
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door closed.
	
	self deny: aDoor isOpen.
	aDoor toBeUsedBy: mainCharacter.	
	self assert: aDoor isOpen ! !

!DoorTest methodsFor: 'using' stamp: 'HAW 10/14/2020 14:48:50'!
test11WhenUsingADoorOpenedGetsClosed
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door opened.
	
	self assert: aDoor isOpen.
	aDoor toBeUsedBy: mainCharacter.	
	self deny: aDoor isOpen.! !

!DoorTest methodsFor: 'using' stamp: 'HAW 10/14/2020 14:49:01'!
test12WhenUsingADoorKeyClosedCanNotBeOpened
	
	| mainCharacter aDoor oldKey |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	oldKey := (PointsPortableObject named: 'old-rusty key' weighing: 2 worth: 1000).
	aDoor := Door closedWith: oldKey.
	
	self 
		should: [ aDoor toBeUsedBy: mainCharacter ]
		raise: Error
		withMessageText: Door closedWithKeyErrorDescription.
		
	self deny: aDoor isOpen! !


!classDefinition: #Backpack category: 'ISW1-2020-2C-Parcial-Enunciado'!
Object subclass: #Backpack
	instanceVariableNames: 'weightCapacity gamePointsCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!Backpack methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 18:02:29'!
signalMaxPointsExceeded

	self error: self class maxPointsExceededErrorDescription ! !

!Backpack methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 18:02:47'!
signalMaxWeightExceeded

	self error: self class maxWeightExceededErrorDescription ! !


!Backpack methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:31:56'!
initializeContainingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity

	weightCapacity := aWeightCapacity.
	gamePointsCapacity := pointsCapacity.
	
	container := OrderedCollection new.
	
	
	! !


!Backpack methodsFor: 'accessing' stamp: 'FRT 10/11/2020 19:14:47'!
size

	^ container size.! !

!Backpack methodsFor: 'accessing' stamp: 'FRT 10/12/2020 13:59:37'!
totalPoints
		
	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [ | portableObject |
		portableObject := (container at: index).
		(portableObject doesItAddPoints) ifTrue: [ total := total +  portableObject points ].
		index := index + 1.	
	].

	^ total.! !

!Backpack methodsFor: 'accessing' stamp: 'FRT 10/12/2020 14:00:21'!
totalWeight
	
	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [ | portableObject |
		portableObject := (container at: index).
		total := total + portableObject weight.
		index := index + 1.	
	].

	^ total.! !


!Backpack methodsFor: 'assertions' stamp: 'FRT 10/12/2020 14:12:36'!
assertPointsAdding: aPointsPortableObject

	(self totalPoints + aPointsPortableObject points) > gamePointsCapacity ifTrue: [ self signalMaxPointsExceeded ]! !

!Backpack methodsFor: 'assertions' stamp: 'FRT 10/15/2020 12:22:34'!
assertWeightAdding: aPortableObject tolerating: aThreshold

	(self totalWeight + aPortableObject weight - weightCapacity) > aThreshold ifTrue: [ self signalMaxWeightExceeded ]! !


!Backpack methodsFor: 'adding' stamp: 'FRT 10/15/2020 12:21:12'!
add: aPortableObject
	
	(aPortableObject isKindOf: NoPointsPortableObject) ifTrue: [
		self assertWeightAdding: aPortableObject tolerating: 0.
		container add: aPortableObject.
	].

	(aPortableObject isKindOf: PointsPortableObject) ifTrue: [
		self assertWeightAdding: aPortableObject tolerating: 5.
		self assertPointsAdding: aPortableObject.
		container add: aPortableObject.
	].	! !


!Backpack methodsFor: 'testing' stamp: 'FRT 10/11/2020 18:38:38'!
isEmpty

	^ container isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Backpack class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
Backpack class
	instanceVariableNames: ''!

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 18:27:33'!
invalidPointsCapacityErrorDescription

	^ 'Points capacity must be positive'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 18:21:04'!
invalidWeightCapacityErrorDescription

	^ 'Weight capacity must be positive'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:36:29'!
maxPointsExceededErrorDescription

	^ 'Maximum points has been exceeded'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:36:17'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:43:00'!
pointsCapacityMustBeIntegerErrorDescription

	^ 'Points capacity must be integer'! !

!Backpack class methodsFor: 'error messages' stamp: 'FRT 10/8/2020 17:42:48'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !


!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/11/2020 18:27:16'!
signalInvalidPointsCapacity

	self error: self invalidPointsCapacityErrorDescription 
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/11/2020 18:21:51'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription 
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 17:41:06'!
signalPointsCapacityMustBeInteger

	self error: self pointsCapacityMustBeIntegerErrorDescription
! !

!Backpack class methodsFor: 'exceptions' stamp: 'FRT 10/8/2020 17:40:47'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Backpack class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:31:56'!
containingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity

	aWeightCapacity strictlyPositive  ifFalse: [ self signalInvalidWeightCapacity ].
	pointsCapacity strictlyPositive ifFalse: [ self signalInvalidPointsCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	pointsCapacity isInteger ifFalse: [ self signalPointsCapacityMustBeInteger ].
	
	^ self new initializeContainingUpTo: aWeightCapacity limitingPointsTo: pointsCapacity.
! !


!classDefinition: #DoorState category: 'ISW1-2020-2C-Parcial-Enunciado'!
Object subclass: #DoorState
	instanceVariableNames: 'door'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!DoorState methodsFor: 'initialization' stamp: 'FRT 10/13/2020 14:26:58'!
initializeFor: aDoor

	door := aDoor! !


!DoorState methodsFor: 'door actions' stamp: 'FRT 10/13/2020 14:47:14'!
close

	self subclassResponsibility! !

!DoorState methodsFor: 'door actions' stamp: 'FRT 10/13/2020 14:47:36'!
open

	self subclassResponsibility! !

!DoorState methodsFor: 'door actions' stamp: 'FRT 10/13/2020 14:47:48'!
openUsing: aKey

	self subclassResponsibility! !


!DoorState methodsFor: 'testing' stamp: 'FRT 10/13/2020 14:47:24'!
isOpen

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DoorState class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
DoorState class
	instanceVariableNames: ''!

!DoorState class methodsFor: 'instance creation' stamp: 'FRT 10/13/2020 14:25:25'!
for: aDoor

	^ self new initializeFor: aDoor! !


!classDefinition: #PlayableCharacter category: 'ISW1-2020-2C-Parcial-Enunciado'!
Object subclass: #PlayableCharacter
	instanceVariableNames: 'name backpack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!PlayableCharacter methodsFor: 'actions' stamp: 'FRT 10/14/2020 22:59:08'!
close: aStageObject

	aStageObject toBeClosedBy: self.! !

!PlayableCharacter methodsFor: 'actions' stamp: 'FRT 10/14/2020 22:59:35'!
open: aStageObject

	aStageObject toBeOpenedBy: self.! !

!PlayableCharacter methodsFor: 'actions' stamp: 'FRT 10/14/2020 23:00:42'!
take: aPortableObject

	backpack add: aPortableObject.! !

!PlayableCharacter methodsFor: 'actions' stamp: 'FRT 10/14/2020 22:59:51'!
use: aStageObject

	aStageObject toBeUsedBy: self.! !


!PlayableCharacter methodsFor: 'initialization' stamp: 'FRT 10/8/2020 19:44:29'!
initializeNamed: aName using: aBackpack

	name := aName.
	backpack := aBackpack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacter class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
PlayableCharacter class
	instanceVariableNames: ''!

!PlayableCharacter class methodsFor: 'instance creation' stamp: 'FRT 10/8/2020 19:43:11'!
named: aName using: aBackpack

	^ self new initializeNamed: aName using: aBackpack! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-Parcial-Enunciado'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!StageObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:23:07'!
toBeClosedBy: aPlayableCharacter

	self subclassResponsibility! !

!StageObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:23:25'!
toBeOpenedBy: aPlayableCharacter

	self subclassResponsibility! !

!StageObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:23:51'!
toBeOpenedBy: aPlayableCharacter using: aKey

	self subclassResponsibility! !

!StageObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:23:39'!
toBeUsedBy: aPlayableCharacter

	self subclassResponsibility! !


!classDefinition: #Door category: 'ISW1-2020-2C-Parcial-Enunciado'!
StageObject subclass: #Door
	instanceVariableNames: 'state key'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!Door methodsFor: 'testing' stamp: 'FRT 10/12/2020 00:34:03'!
isOpen

	^ state == #Opened
! !


!Door methodsFor: 'initialization' stamp: 'FRT 10/13/2020 14:28:44'!
initializeWith: aDoorState

	state := aDoorState
! !

!Door methodsFor: 'initialization' stamp: 'FRT 10/13/2020 14:30:34'!
initializeWith: aDoorState using: aKey

	state := aDoorState.
	key := aKey.
! !


!Door methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:24:11'!
toBeClosedBy: aPlayableCharacter

	(state == #Opened) ifTrue: [ ^ state := #Closed ].
	(state == #Closed) ifTrue: [ self error: Door alreadyClosedErrorDescription ].
	(state == #KeyClosed) ifTrue: [ self error: Door alreadyClosedErrorDescription ].! !

!Door methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:24:23'!
toBeOpenedBy: aPlayableCharacter

	(state == #Opened) ifTrue: [ self error: Door alreadyOpenedErrorDescription ].
	(state == #Closed) ifTrue: [ ^ state := #Opened ].
	(state == #KeyClosed) ifTrue: [ self error: Door closedWithKeyErrorDescription ].! !

!Door methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:24:38'!
toBeOpenedBy: aPlayableCharacter using: aKey

	(state == #Opened) ifTrue: [ self error: Door alreadyOpenedErrorDescription ].
	(state == #Closed) ifTrue: [ self error: Door noNeedForAKeyErrorDescription ].
	(state == #KeyClosed) ifTrue: [ 
		(key == aKey) ifTrue: [ ^ state := #Opened ].
		self error: Door notCorrectKeyErrorDescription. 
	]! !

!Door methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:24:50'!
toBeUsedBy: aPlayableCharacter

	(state == #Opened) ifTrue: [ ^ self toBeClosedBy: aPlayableCharacter ].
	(state == #Closed) ifTrue: [ ^ self toBeOpenedBy: aPlayableCharacter ].
	(state == #KeyClosed) ifTrue: [ ^ self toBeOpenedBy: aPlayableCharacter ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Door class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
Door class
	instanceVariableNames: ''!

!Door class methodsFor: 'instance creation' stamp: 'FRT 10/13/2020 14:29:27'!
closed

	| door |
	
	door := Door new.
	door initializeWith: #Closed.
	
	^ door.! !

!Door class methodsFor: 'instance creation' stamp: 'FRT 10/13/2020 14:31:20'!
closedWith: aKey

	| door |
	
	door := Door new.
	door initializeWith: #KeyClosed using: aKey.
	
	^ door.! !

!Door class methodsFor: 'instance creation' stamp: 'FRT 10/13/2020 14:29:52'!
opened

	| door |
	
	door := Door new.
	door initializeWith: #Opened.
	
	^ door.! !


!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 19:50:28'!
alreadyClosedErrorDescription

	^ 'The door is already closed'! !

!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 20:15:28'!
alreadyOpenedErrorDescription

	^ 'The door is already opened'! !

!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 22:15:06'!
closedWithKeyErrorDescription

	^ 'The door is closed with key'! !

!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 19:50:40'!
keyClosedErrorDescription

	^ 'The door is closed with a key'! !

!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 22:26:32'!
noNeedForAKeyErrorDescription

	^ 'The door is not key-closed'! !

!Door class methodsFor: 'error messages' stamp: 'FRT 10/11/2020 22:31:16'!
notCorrectKeyErrorDescription

	^ 'Not the correct key!!'! !


!classDefinition: #PortableObject category: 'ISW1-2020-2C-Parcial-Enunciado'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'FRT 10/8/2020 18:38:17'!
addTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!PortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:27:01'!
toBeClosedBy: aPlayableCharacter

	self subclassResponsibility! !

!PortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:27:14'!
toBeOpenedBy: aPlayableCharacter

	self subclassResponsibility! !

!PortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:27:27'!
toBeOpenedBy: aPlayableCharacter using: aKey

	self subclassResponsibility! !

!PortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:27:39'!
toBeUsedBy: aPlayableCharacter

	self subclassResponsibility! !


!classDefinition: #NoPointsPortableObject category: 'ISW1-2020-2C-Parcial-Enunciado'!
PortableObject subclass: #NoPointsPortableObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!NoPointsPortableObject methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:34:36'!
initializeNamed: aName weighing: aWeight
	
	name := aName.
	weight := aWeight.! !


!NoPointsPortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints	

	^ false! !


!NoPointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:27:59'!
toBeClosedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

!NoPointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:28:14'!
toBeOpenedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

!NoPointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:28:24'!
toBeOpenedBy: aPlayableCharacter using: aKey

	"No implementado en 1er Parcial"! !

!NoPointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:28:34'!
toBeUsedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPointsPortableObject class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
NoPointsPortableObject class
	instanceVariableNames: ''!

!NoPointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:34:36'!
named: aName weighing: aWeight
	
	^ self new initializeNamed: aName weighing: aWeight. ! !


!classDefinition: #PointsPortableObject category: 'ISW1-2020-2C-Parcial-Enunciado'!
PortableObject subclass: #PointsPortableObject
	instanceVariableNames: 'points'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!PointsPortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	^ true! !


!PointsPortableObject methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:36:26'!
initializeNamed: aName weighing: aWeight worth: gamePoints
	
	name := aName.
	weight := aWeight.
	points := gamePoints.! !


!PointsPortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 19:06:57'!
points

	^ points! !


!PointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:28:49'!
toBeClosedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

!PointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:28:59'!
toBeOpenedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

!PointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:29:14'!
toBeOpenedBy: aPlayableCharacter using: aKey

	"No implementado en 1er Parcial"! !

!PointsPortableObject methodsFor: 'playable character reactions' stamp: 'FRT 10/12/2020 23:29:25'!
toBeUsedBy: aPlayableCharacter

	"No implementado en 1er Parcial"! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointsPortableObject class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
PointsPortableObject class
	instanceVariableNames: ''!

!PointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:36:26'!
named: aName weighing: aWeight worth: gamePoints
	
	^ self new initializeNamed: aName weighing: aWeight worth: gamePoints.! !
