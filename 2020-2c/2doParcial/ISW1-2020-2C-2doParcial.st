!classDefinition: #BackpackTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #BackpackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

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


!classDefinition: #PlayableCharacterTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #PlayableCharacterTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:36:13'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:43:14'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/9/2020 19:47:21'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West .
	paper := NoPointsPortableObject named: 'Paper' weighing: 100.
	key := NoPointsPortableObject named: 'Key' weighing: 1.
	
	playableCharacter take: paper.
	self 
		should: [ playableCharacter take: key ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Backpack maxWeightExceededErrorDescription equals: anError messageText.
			self assert: (playableCharacter backpackIncludes: paper).
			self deny: (playableCharacter backpackIncludes: key) ]
	
	! !


!PlayableCharacterTest methodsFor: 'as yet unclassified' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !


!classDefinition: #Backpack category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Backpack
	instanceVariableNames: 'weightCapacity gamePointsCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

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


!Backpack methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:44:17'!
includes: aPortableObject 
	
	^container includes: aPortableObject ! !

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

!classDefinition: 'Backpack class' category: 'ISW1-2020-2C-2doParcial'!
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


!classDefinition: #PlayableCharacter category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #PlayableCharacter
	instanceVariableNames: 'position heading backpack name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacter methodsFor: 'initialization' stamp: 'HAW 12/9/2020 19:35:22'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading 

	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 10/11/2019 08:22:42'!
moveBackward
	
	position := position - heading forwardPoint ! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 10/11/2019 08:21:58'!
moveForward
	
	position := position + heading forwardPoint! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/9/2020 19:28:57'!
take: aPortableObject

	backpack add: aPortableObject.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacter class' category: 'ISW1-2020-2C-2doParcial'!
PlayableCharacter class
	instanceVariableNames: 'headings'!

!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:28:16'!
headingFor: aCardinalPoint
	
	^headings at: aCardinalPoint ifAbsent: [ self error: self invalidCardinalPointErrorDescription ]! !

!PlayableCharacter class methodsFor: 'heading' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'HAW 12/9/2020 19:36:13'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint 
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading ! !


!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:37:25'!
forHeadingAt: aCardinalPoint leftIs: aLeftCardinalPoint rightIs: aRightCardinalPoint
	
	(headings at: aCardinalPoint) leftHeading: (headings at: aLeftCardinalPoint) rightHeading: (headings at: aRightCardinalPoint).
	! !

!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 7/2/2018 15:27:41'!
initialize

	self initializeHeadings! !

!PlayableCharacter class methodsFor: 'initialization' stamp: 'HAW 12/9/2020 19:31:43'!
initializeHeadings

	headings := Dictionary new.
	
	(OrderedCollection 
		with: (PlayableCharacterHeading for: #North forwardWith: 0@1 )	
		with: (PlayableCharacterHeading for: #East forwardWith: 1@0 )
		with: (PlayableCharacterHeading for: #South forwardWith: 0@-1 )
		with: (PlayableCharacterHeading for: #West forwardWith: -1@0 ))
			do: [ :heading | headings at: heading cardinalPoint put: heading ].
	
	self 
		forHeadingAt: #North leftIs: #West rightIs: #East;
		forHeadingAt: #South leftIs: #East rightIs: #West;
		forHeadingAt: #East leftIs: #North rightIs: #South;
		forHeadingAt: #West leftIs: #South rightIs: #North.
	! !


!classDefinition: #PlayableCharacterHeading category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #PlayableCharacterHeading
	instanceVariableNames: 'cardinalPoint forwardPoint rightHeading leftHeading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 7/2/2018 15:29:44'!
cardinalPoint
	
	^cardinalPoint! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 7/2/2018 15:30:39'!
forwardPoint
	
	^forwardPoint! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 10/11/2019 08:31:33'!
leftHeading
	
	^leftHeading! !

!PlayableCharacterHeading methodsFor: 'accessing' stamp: 'HAW 10/11/2019 08:31:27'!
rightHeading
	
	^rightHeading! !


!PlayableCharacterHeading methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:27:25'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint  
	
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
! !

!PlayableCharacterHeading methodsFor: 'initialization' stamp: 'HAW 10/11/2019 08:31:33'!
leftHeading: aLeftHeading rightHeading: aRightHeading
 
	leftHeading := aLeftHeading.
	rightHeading := aRightHeading ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlayableCharacterHeading class' category: 'ISW1-2020-2C-2doParcial'!
PlayableCharacterHeading class
	instanceVariableNames: ''!

!PlayableCharacterHeading class methodsFor: 'instance creation' stamp: 'HAW 10/11/2019 08:27:46'!
for: aCardinalPoint forwardWith: aForwardPoint  

	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint ! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!


!classDefinition: #PortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #PortableObject
	instanceVariableNames: 'name weight'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints

	self subclassResponsibility	! !


!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!classDefinition: #NoPointsPortableObject category: 'ISW1-2020-2C-2doParcial'!
PortableObject subclass: #NoPointsPortableObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NoPointsPortableObject methodsFor: 'initialization' stamp: 'HAW 10/14/2020 14:34:36'!
initializeNamed: aName weighing: aWeight
	
	name := aName.
	weight := aWeight.! !


!NoPointsPortableObject methodsFor: 'testing' stamp: 'FRT 10/11/2020 17:54:20'!
doesItAddPoints	

	^ false! !


!NoPointsPortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:48'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddNoPointsPortableObject: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPointsPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NoPointsPortableObject class
	instanceVariableNames: ''!

!NoPointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:34:36'!
named: aName weighing: aWeight
	
	^ self new initializeNamed: aName weighing: aWeight. ! !


!classDefinition: #PointsPortableObject category: 'ISW1-2020-2C-2doParcial'!
PortableObject subclass: #PointsPortableObject
	instanceVariableNames: 'points'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

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


!PointsPortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:29:07'!
assertCanAddTo: aBackpack 
	
	^aBackpack assertCanAddPointPortableObject: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PointsPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
PointsPortableObject class
	instanceVariableNames: ''!

!PointsPortableObject class methodsFor: 'instance creation' stamp: 'HAW 10/14/2020 14:36:26'!
named: aName weighing: aWeight worth: gamePoints
	
	^ self new initializeNamed: aName weighing: aWeight worth: gamePoints.! !

PlayableCharacter initialize!