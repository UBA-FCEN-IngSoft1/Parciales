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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:05:24'!
paper

	^ NoPointsPortableObject named: 'Paper' weighing: 100! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self defaultRoom .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self defaultRoom .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self defaultRoom .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self defaultRoom .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East in: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South in: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self defaultRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X in: self defaultRoom ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:00:16'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self defaultRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:05:24'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self defaultRoom .
	paper := self paper.
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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:43:14'!
test11_CanNotCreateCharacterWithInvalidPosition

	| room |

	room := self defaultRoom.
	self 
		should: [ PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@-1 heading: #West in: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: room isEmpty ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:09:38'!
test12_CanNotCreateCharacterOnNotEmptyPosition

	| room paperPosition paper |

	room := self defaultRoom.
	paperPosition := 1@1.
	paper := self paper.
	room at: paperPosition put: paper.
	
	self 
		should: [ PlayableCharacter named: 'Luigi' using: self defaultBackpack at: paperPosition heading: #West in: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room positionIsNotEmptyErrorDescription equals: anError messageText.
			self assert: paper equals: (room at: paperPosition)]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:16:13'!
test13_moveForwardModifiesPositionInRoom

	| room  player |

	room := self defaultRoom.
	
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #West in: room.
	player moveForward.
	
	self assert: (player isAt: 0@1 heading: #West).
	self assert: player equals: (room at: 0@1).
	self assert: (room isEmptyAt: 1@1).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:17:08'!
test14_moveBackwardModifiesPositionInRoom

	| room  player |

	room := self defaultRoom.
	
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #West in: room.
	player moveBackward.
	
	self assert: (player isAt: 2@1 heading: #West).
	self assert: player equals: (room at: 2@1).
	self assert: (room isEmptyAt: 1@1).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:43:14'!
test15_canNotMoveToInvalidPosition

	| room  player |

	room := self defaultRoom.
	
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@1 heading: #West in: room.
	
	self 
		should: [ player moveForward ]
		raise: Error 
		withExceptionDo: [:anError |
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: player equals: (room at: 0@1). ]
			
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:44:47'!
test16_canNotTakeFromAnEmptyOrInvalidPosition

	| room  player |

	room := self defaultRoom.
	
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	self 
		should: [ player take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Room objectNotInRoomErrorDescription equals: anError messageText.
			self assert: player backpackIsEmpty ]
			
! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:46:11'!
test17_canTakeAPortableObject

	| room  player paper |

	room := self defaultRoom.
	paper := self paper.
	room at: 0@1 put: paper.
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	player take.
	
	self assert: (room isEmptyAt: 0@1).
	self assert: (player backpackIncludes: paper).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:50:54'!
test18_emptyNonPortableObjectDoesNotAddObjectsToBackpack

	| room  player box |

	room := self defaultRoom.
	box := NonPortableObject named: 'Box'.
	room at: 0@1 put: box.
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	player take.
	
	self assert: box equals: (room at: 0@1).
	self assert: player backpackIsEmpty.! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:56:03'!
test19_portableInNonPortableObjectIsAddedToBackpack

	| room  player box paper |

	room := self defaultRoom.
	paper := self paper.
	box := NonPortableObject named: 'Box' withAll: { paper }.
	room at: 0@1 put: box.
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	player take.
	
	self assert: box equals: (room at: 0@1).
	self assert: box isEmpty.
	self assert: (player backpackIncludes: paper).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 19:19:55'!
test20_takeFromNonPortableObjectsIsRecursive

	| room  player box paper anotherPaper |

	room := self defaultRoom.
	paper := self paper.
	anotherPaper := self paper.
	box := NonPortableObject named: 'Box' withAll: { paper. anotherPaper }.
	room at: 0@1 put: box.
	player := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	self 
		should: [ player take ]
		raise: Error
		withMessageText: Backpack maxWeightExceededErrorDescription.
	
	self assert: box equals: (room at: 0@1).
	self deny: box isEmpty.
	self assert: (box includes: anotherPaper).
	self assert: (player backpackIncludes: paper).
	self assert: 1 equals: player backpackSize! !


!PlayableCharacterTest methodsFor: 'defaults' stamp: 'HAW 12/9/2020 13:53:29'!
defaultBackpack

	^ Backpack containingUpTo: 100 limitingPointsTo: 100 ! !

!PlayableCharacterTest methodsFor: 'defaults' stamp: 'HAW 12/14/2020 18:02:57'!
defaultRoom
	
	^Room ofWidth: 10 andHeight: 10! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:20:02'!
test01_WidthMustBeStrictlyPositive

	self assertInvalidSizeWith: 0 and: 1
	! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:20:13'!
test02_HeightMustBeStrictlyPositive

	self assertInvalidSizeWith: 1 and: 0
	! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:20:25'!
test03_WidthMustBeInteger

	self assertInvalidSizeWith: 1.1 and: 1
	! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:20:36'!
test04_HeightMustBeInteger

	self assertInvalidSizeWith: 1 and: 1.1
		! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:39:43'!
test05_CanNotPutAStageObjectWithXLessThanCero

	self assertCanNotPutAt: -1@1
		! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:39:49'!
test06_CanNotPutAStageObjectWithXGreaterOrEqualToWidth

	self assertCanNotPutAt: 10@1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:39:56'!
test07_CanNotPutAStageObjectWithANonIntegerX

	self assertCanNotPutAt: 1.1@1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:40:04'!
test08_CanNotPutAStageObjectWithYLessThanCero

	self assertCanNotPutAt: 1@-1
		! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:40:25'!
test09_CanNotPutAStageObjectWithYGreaterOrEqualToHeight

	self assertCanNotPutAt: 1@10! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:41:13'!
test10_CanNotPutAStageObjectWithANonIntegerY

	self assertCanNotPutAt: 1@1.1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 17:46:46'!
test11_StageObjectsAreKeept

	| room |
	
	room := Room ofWidth: 10 andHeight: 10.
	
	room at: 0@0 put: self paper.
	
	self deny: room isEmpty.! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/14/2020 18:30:22'!
test12_canNotGetPositionOfNonPutObject

	| room |
	
	room := Room ofWidth: 10 andHeight: 10.
	self
		should: [ room positionOf: self paper ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room objectNotInRoomErrorDescription! !


!RoomTest methodsFor: 'test objects' stamp: 'HAW 12/14/2020 17:36:15'!
paper

	^ PointsPortableObject named: 'paper' weighing: 1 worth: 1! !


!RoomTest methodsFor: 'assertions' stamp: 'HAW 12/14/2020 18:43:14'!
assertCanNotPutAt: aPosition

	| room width |
	
	width := 10.
	room := Room ofWidth: width andHeight: 10.
	
	self 
		should: [ room at: aPosition put: self paper ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: room isEmpty ].! !

!RoomTest methodsFor: 'assertions' stamp: 'HAW 12/14/2020 17:19:50'!
assertInvalidSizeWith: aWitdh and: aHeight

	self 
		should: [ Room ofWidth: aWitdh andHeight: aHeight ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room invalidSizeErrorDescription! !


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
	instanceVariableNames: 'heading backpack name room'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacter methodsFor: 'initialization' stamp: 'HAW 12/14/2020 18:27:11'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading in: aRoom  

	name := aName.
	backpack := aBackpack.
	heading := aMarsRoverHeading.
	room := aRoom.
	room at: aPosition put: self! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/14/2020 18:25:08'!
isAt: aPosition heading: aCardinalPoint

	^self position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/14/2020 19:09:28'!
forwardPosition

	^ self position + heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/14/2020 18:25:13'!
moveBackward
	
	self moveTo: self position - heading forwardPoint.
	! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/14/2020 19:09:36'!
moveForward
	
	self moveTo: self forwardPosition ! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/14/2020 18:27:14'!
moveTo: aNewPosition
	
	room moveFrom: self position to: aNewPosition.
		! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/14/2020 18:25:48'!
position

	^room positionOf: self! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/14/2020 19:09:28'!
take
	
	| toTake |
	
	toTake := room at: self forwardPosition.
	toTake takenBy: self 
	! !

!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/9/2020 19:28:57'!
take: aPortableObject

	backpack add: aPortableObject.! !


!PlayableCharacter methodsFor: 'taking - private' stamp: 'HAW 12/14/2020 18:58:05'!
takeNonPortableObject: aNonPortableObject 
	
	aNonPortableObject putAllTo: self! !

!PlayableCharacter methodsFor: 'taking - private' stamp: 'HAW 12/14/2020 19:09:51'!
takePortableObject: aPortableObject 
	
	self take: aPortableObject.
	room removeAt: self forwardPosition ! !


!PlayableCharacter methodsFor: 'backpack' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'backpack' stamp: 'HAW 12/14/2020 18:42:40'!
backpackIsEmpty
	
	^backpack isEmpty ! !

!PlayableCharacter methodsFor: 'backpack' stamp: 'HAW 12/14/2020 19:09:03'!
backpackSize
	
	^backpack size! !

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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'HAW 12/14/2020 18:01:51'!
named: aName using: aBackpack at: aPosition heading: aCardinalPoint in: aRoom  
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeNamed: aName using: aBackpack at: aPosition heading: newHeading in: aRoom ! !


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


!classDefinition: #Room category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #Room
	instanceVariableNames: 'width height contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'HAW 12/14/2020 17:47:16'!
initializeOfWidth: aWidth andHeight: aHeight 
	
	width := aWidth.
	height := aHeight.
	contents := Dictionary new.! !


!Room methodsFor: 'contents' stamp: 'HAW 12/14/2020 18:42:28'!
at: aPosition

	^contents at: aPosition ifAbsent: [self error: self class objectNotInRoomErrorDescription ]! !

!Room methodsFor: 'contents' stamp: 'HAW 12/14/2020 18:07:24'!
at: aPosition put: aStageObject

	self assertPositionIsValid: aPosition.
	self assertIsEmpty: aPosition.
	
	contents at: aPosition put: aStageObject ! !

!Room methodsFor: 'contents' stamp: 'HAW 12/14/2020 18:23:18'!
moveFrom: aSourcePosition to: aTargetPosition

	| toMove |
	
	toMove := self at: aSourcePosition.
	self at: aTargetPosition put: toMove.
	contents removeKey: aSourcePosition.
	! !

!Room methodsFor: 'contents' stamp: 'HAW 12/14/2020 18:30:58'!
positionOf: anObject

	contents keysAndValuesDo: [ :aPosition :aPlacedObject |
		aPlacedObject = anObject ifTrue: [ ^aPosition  ]].
	
	self error: self class objectNotInRoomErrorDescription ! !

!Room methodsFor: 'contents' stamp: 'HAW 12/14/2020 18:47:43'!
removeAt: aPosition

	^contents removeKey: aPosition ! !


!Room methodsFor: 'assertions' stamp: 'HAW 12/14/2020 18:09:38'!
assertIsEmpty: aPosition

	^(self isEmptyAt: aPosition) ifFalse: [ self error: self class positionIsNotEmptyErrorDescription ]! !

!Room methodsFor: 'assertions' stamp: 'HAW 12/14/2020 18:43:14'!
assertPositionComponentIsValid: aPositionComponent withLimit: limit 

	^ (aPositionComponent < 0 or: [aPositionComponent >= limit or: [ aPositionComponent isInteger not]]) 
		ifTrue: [self error: self class invalidPositionErrorDescription ]! !

!Room methodsFor: 'assertions' stamp: 'HAW 12/14/2020 17:44:04'!
assertPositionIsValid: aPosition

	self assertPositionComponentIsValid: aPosition x withLimit: width.
	self assertPositionComponentIsValid: aPosition y withLimit: height.
	! !


!Room methodsFor: 'testing' stamp: 'HAW 12/14/2020 17:47:56'!
isEmpty
	
	^contents isEmpty ! !

!Room methodsFor: 'testing' stamp: 'HAW 12/14/2020 18:08:47'!
isEmptyAt: aPosition

	^ (contents includesKey: aPosition) not! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/14/2020 18:43:14'!
invalidPositionErrorDescription
	
	^'Invalid position'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/14/2020 17:16:22'!
invalidSizeErrorDescription
	
	^'Invalid size'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/14/2020 18:30:38'!
objectNotInRoomErrorDescription
	
	^'Object not in room'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/14/2020 18:09:38'!
positionIsNotEmptyErrorDescription
	
	^'Position not empty'! !


!Room class methodsFor: 'instance creation' stamp: 'HAW 12/14/2020 19:27:12'!
ofWidth: aWidth andHeight: aHeight 
	
	self assertIsValidWitdth: aWidth andHeight: aHeight .
	
	^self new initializeOfWidth: aWidth andHeight: aHeight ! !


!Room class methodsFor: 'assertions' stamp: 'HAW 12/14/2020 17:22:01'!
assertIsValidSizeComponent: aSizeComponent

	^ (aSizeComponent < 1 or: [aSizeComponent isInteger not ]) ifTrue: [self error: self invalidSizeErrorDescription ]! !

!Room class methodsFor: 'assertions' stamp: 'HAW 12/14/2020 19:27:12'!
assertIsValidWitdth: aWidth andHeight: aHeight

	self assertIsValidSizeComponent: aWidth.
	self assertIsValidSizeComponent: aHeight! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!StageObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 19:30:06'!
putAllTo: aPlayableCharacter

	self subclassResponsibility 
	! !

!StageObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 19:30:18'!
takenBy: aPlayableCharacter 

	self subclassResponsibility 
	! !


!classDefinition: #NonPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NonPortableObject
	instanceVariableNames: 'name stageObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NonPortableObject methodsFor: 'initialization' stamp: 'HAW 12/14/2020 19:00:02'!
initializeNamed: aName withAll: aCollectionOfStageObjects 
	
	name := aName.
	stageObjects := aCollectionOfStageObjects asOrderedCollection .! !


!NonPortableObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 19:24:52'!
putAllTo: aPlayableCharacter 
	
	| toRemove |
	
	toRemove := OrderedCollection new.
	[ stageObjects do: [ :aStageObject | (aStageObject putAllTo: aPlayableCharacter) ifTrue: [ toRemove add: aStageObject ]]]
		ensure: [ stageObjects removeAll: toRemove ].
	
	^false! !

!NonPortableObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 18:53:21'!
takenBy: aPlayableCharacter 
	
	aPlayableCharacter takeNonPortableObject: self! !


!NonPortableObject methodsFor: 'testing' stamp: 'HAW 12/14/2020 19:08:45'!
includes: aStageObject

	^stageObjects includes: aStageObject ! !

!NonPortableObject methodsFor: 'testing' stamp: 'HAW 12/14/2020 18:57:19'!
isEmpty
	
	^stageObjects isEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NonPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NonPortableObject class
	instanceVariableNames: ''!

!NonPortableObject class methodsFor: 'instance creation' stamp: 'HAW 12/14/2020 19:00:27'!
named: aName 
	
	^self named: aName withAll: #()! !

!NonPortableObject class methodsFor: 'instance creation' stamp: 'HAW 12/14/2020 18:56:40'!
named: aName withAll: aCollectionOfStageObjects 
	
	^self new initializeNamed: aName withAll: aCollectionOfStageObjects ! !


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


!PortableObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 19:15:12'!
putAllTo: aPlayableCharacter

	aPlayableCharacter take: self.
	^true! !

!PortableObject methodsFor: 'taken' stamp: 'HAW 12/14/2020 18:53:53'!
takenBy: aPlayableCharacter 
	
	aPlayableCharacter takePortableObject: self! !


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