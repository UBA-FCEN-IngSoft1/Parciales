!classDefinition: #BackpackTest category: 'ISW1-2020-2C-Parcial-Enunciado'!
TestCase subclass: #BackpackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:29:03'!
assertShouldAddAll: portableObjects withPoints: expectedTotalPoints

	| aBackpack |
	
	aBackpack := Backpack containingUpTo: self backpackWeight limitingPointsTo: 100.

	portableObjects do: [ :aPortableObject | aBackpack add: aPortableObject ].
	
	self assert: aBackpack size equals: portableObjects size.
	self assert: aBackpack totalWeight equals: (portableObjects sum: [ :aPortableObject | aPortableObject weight ]).
	self assert: aBackpack totalPoints equals: expectedTotalPoints.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:32'!
assertShouldNotAddPortableObjectIfWeightExceeded: aPortableObject

	| aBackpack |
	aBackpack := Backpack containingUpTo: self backpackWeight limitingPointsTo: 100.

	self
		should: [ aBackpack add: aPortableObject ]
		raise: Error
		withMessageText: Backpack maxWeightExceededErrorDescription.
		
	self assert: aBackpack isEmpty. 
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:32'!
backpackWeight

	^ 42! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:41'!
test07ShouldNotAddNoPointsPortableObjectIfWeightExceeded

	self assertShouldNotAddPortableObjectIfWeightExceeded: 
		(NoPointsPortableObject named: 'help-wanted sign' weighing: self backpackWeight + 1)
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:28:47'!
test08ShouldNotAddPointsPortableObjectIfWeightExceeded

	self assertShouldNotAddPortableObjectIfWeightExceeded: 
		(PointsPortableObject named: 'left-handed hammer' weighing: self backpackWeight + 6 worth: 5) ! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:26:42'!
test09ShouldAddPortableObjectsIfWeightUnderMaxWeightCapacity

	self 
		assertShouldAddAll: self twoPortableObjects
		withPoints: 5.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:27:27'!
test10ShouldAddPortableObjectsIfWeightEqualsMaxWeightCapacity

	self 
		assertShouldAddAll:  self twoPortableObjects, {(PointsPortableObject named: 'letter' weighing: 1 worth: 5)}
		withPoints: 10.
! !

!BackpackTest methodsFor: 'adding' stamp: 'HAW 10/18/2020 16:27:39'!
twoPortableObjects

	^ {
		(PointsPortableObject named: 'left-handed hammer' weighing: 40 worth: 5).
		(NoPointsPortableObject named: 'help-wanted sign' weighing: 1) }! !


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

!DoorTest methodsFor: 'closing' stamp: 'HAW 10/18/2020 12:37:04'!
test03ADoorClosedCanNotBeClosedAgain
	
	| mainCharacter aDoor |
	
	mainCharacter := PlayableCharacter named: 'Bernard' using: (Backpack containingUpTo: 100 limitingPointsTo: 100).
	aDoor := Door closed.
	
	self 
		should: [ aDoor toBeClosedBy: mainCharacter ]
		raise: Error - MessageNotUnderstood 
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

!Backpack methodsFor: 'accessing' stamp: 'HAW 10/18/2020 12:20:52'!
totalPoints
		
	^(container select: [ :portableObject | portableObject doesItAddPoints ])	
		sum: [ :portableObject | portableObject points ]
		ifEmpty: [ 0 ]! !

!Backpack methodsFor: 'accessing' stamp: 'HAW 10/18/2020 12:20:20'!
totalWeight
	
	^container 
		sum: [ :portableObject | portableObject weight ]
		ifEmpty: [ 0 ]
		! !


!Backpack methodsFor: 'assertions' stamp: 'FRT 10/12/2020 14:12:36'!
assertPointsAdding: aPointsPortableObject

	(self totalPoints + aPointsPortableObject points) > gamePointsCapacity ifTrue: [ self signalMaxPointsExceeded ]! !

!Backpack methodsFor: 'assertions' stamp: 'FRT 10/15/2020 12:22:34'!
assertWeightAdding: aPortableObject tolerating: aThreshold

	(self totalWeight + aPortableObject weight - weightCapacity) > aThreshold ifTrue: [ self signalMaxWeightExceeded ]! !


!Backpack methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
add: aPortableObject
	
	aPortableObject assertCanAddTo: self.
	
	container add: aPortableObject.
	! !


!Backpack methodsFor: 'testing' stamp: 'FRT 10/11/2020 18:38:38'!
isEmpty

	^ container isEmpty.! !


!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddNoPointsPortableObject: aNoPointsPortableObject 
	
	self assertWeightAdding: aNoPointsPortableObject tolerating: 0.
	! !

!Backpack methodsFor: 'adding - private' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddPointPortableObject: aPointsPortableObject 
	
	self assertWeightAdding: aPointsPortableObject tolerating: 5.
	self assertPointsAdding: aPointsPortableObject.
	! !

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


!DoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:10:33'!
close 

	self subclassResponsibility ! !

!DoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:10:45'!
open 

	self subclassResponsibility ! !

!DoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:11:19'!
openUsing: aKey 

	self subclassResponsibility ! !

!DoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 12:58:22'!
toBeUsedBy: aPlayableCharacter 

	self subclassResponsibility ! !


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


!classDefinition: #ClosedDoorState category: 'ISW1-2020-2C-Parcial-Enunciado'!
DoorState subclass: #ClosedDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!ClosedDoorState methodsFor: 'testing' stamp: 'HAW 10/18/2020 12:55:43'!
isOpen
	
	^ false! !


!ClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:13:18'!
close 
	
	door error: Door alreadyClosedErrorDescription
	! !

!ClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:14:33'!
open 
	
	door open! !

!ClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:14:46'!
openUsing: aKey 
	
	door error: Door noNeedForAKeyErrorDescription! !

!ClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 15:55:29'!
toBeUsedBy: aPlayableCharacter 
	
	door toBeOpenedBy: aPlayableCharacter ! !


!classDefinition: #KeyClosedDoorState category: 'ISW1-2020-2C-Parcial-Enunciado'!
DoorState subclass: #KeyClosedDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!KeyClosedDoorState methodsFor: 'testing' stamp: 'HAW 10/18/2020 12:55:58'!
isOpen
	
	^false! !


!KeyClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:13:36'!
close 
	
	door error: Door alreadyClosedErrorDescription
! !

!KeyClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:15:02'!
open 
	
	door error: Door closedWithKeyErrorDescription
! !

!KeyClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:15:18'!
openUsing: aKey 
	
	door openUsing: aKey ! !

!KeyClosedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 15:55:44'!
toBeUsedBy: aPlayableCharacter 
	
	door toBeOpenedBy: aPlayableCharacter ! !


!classDefinition: #OpenedDoorState category: 'ISW1-2020-2C-Parcial-Enunciado'!
DoorState subclass: #OpenedDoorState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!OpenedDoorState methodsFor: 'testing' stamp: 'HAW 10/18/2020 12:55:30'!
isOpen
	
	^true! !


!OpenedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:14:24'!
close 
	
	door close! !

!OpenedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:15:29'!
open 
	
	door error: Door alreadyOpenedErrorDescription
	! !

!OpenedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 16:15:43'!
openUsing: aKey 
	
	door error: Door alreadyOpenedErrorDescription! !

!OpenedDoorState methodsFor: 'door actions' stamp: 'HAW 10/18/2020 15:55:59'!
toBeUsedBy: aPlayableCharacter 
	
	door toBeClosedBy: aPlayableCharacter ! !


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
	instanceVariableNames: 'key state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-Parcial-Enunciado'!

!Door methodsFor: 'testing' stamp: 'HAW 10/18/2020 12:56:34'!
isOpen

	^ state isOpen! !


!Door methodsFor: 'initialization' stamp: 'HAW 10/18/2020 12:56:34'!
initializeWith: aDoorStateClass

	state := aDoorStateClass for: self.
	! !

!Door methodsFor: 'initialization' stamp: 'HAW 10/18/2020 12:56:18'!
initializeWith: aDoorStateClass using: aKey

	self initializeWith: aDoorStateClass.
	key := aKey.
	! !


!Door methodsFor: 'playable character reactions' stamp: 'HAW 10/18/2020 16:10:33'!
toBeClosedBy: aPlayableCharacter

	state close! !

!Door methodsFor: 'playable character reactions' stamp: 'HAW 10/18/2020 16:10:45'!
toBeOpenedBy: aPlayableCharacter

	state open! !

!Door methodsFor: 'playable character reactions' stamp: 'HAW 10/18/2020 16:11:19'!
toBeOpenedBy: aPlayableCharacter using: aKey

	state openUsing: aKey! !

!Door methodsFor: 'playable character reactions' stamp: 'HAW 10/18/2020 12:56:34'!
toBeUsedBy: aPlayableCharacter

	state toBeUsedBy: aPlayableCharacter ! !


!Door methodsFor: 'reactions - private' stamp: 'HAW 10/18/2020 16:14:24'!
close 
	
	state := ClosedDoorState for: self. 
	! !

!Door methodsFor: 'reactions - private' stamp: 'HAW 10/18/2020 16:14:33'!
open 
	
	state := OpenedDoorState for: self.
	! !

!Door methodsFor: 'reactions - private' stamp: 'HAW 10/18/2020 16:15:18'!
openUsing: aKey 
	
	key = aKey ifTrue: [ ^state := OpenedDoorState for: self ].
	self error: Door notCorrectKeyErrorDescription. 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Door class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
Door class
	instanceVariableNames: ''!

!Door class methodsFor: 'instance creation' stamp: 'HAW 10/18/2020 12:52:10'!
closed

	^self new initializeWith: ClosedDoorState ! !

!Door class methodsFor: 'instance creation' stamp: 'HAW 10/18/2020 12:52:28'!
closedWith: aKey

	^self new initializeWith: KeyClosedDoorState using: aKey.
	! !

!Door class methodsFor: 'instance creation' stamp: 'HAW 10/18/2020 12:52:40'!
opened

	^self new initializeWith: OpenedDoorState ! !


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


!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

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


!NoPointsPortableObject methodsFor: 'as yet unclassified' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddNoPointsPortableObject: self! !

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


!PointsPortableObject methodsFor: 'as yet unclassified' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddPointPortableObject: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointsPortableObject class' category: 'ISW1-2020-2C-Parcial-Enunciado'!
PointsPortableObject class
	instanceVariableNames: ''!

!PointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:36:26'!
named: aName weighing: aWeight worth: gamePoints
	
	^ self new initializeNamed: aName weighing: aWeight worth: gamePoints.! !
