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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/12/2020 11:22:22'!
assertCanNotMove: aMoveBlock whenHeading: aCardinalPoint

	| room playableCharacter |
	
	room := self emptyRoom.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: aCardinalPoint in: room.
	
	self 
		should: [ aMoveBlock value: playableCharacter ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: playableCharacter equals: (room at: 0@0).
			self assert: (playableCharacter isAt: 0@0 heading: aCardinalPoint ) ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:58:21'!
assertCanNotStartAt: aPosition

	| room |
	
	room := self emptyRoom.
	self 
		should: [ PlayableCharacter named: 'Luigi' using: self defaultBackpack at: aPosition heading: #West in: room ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: room isEmpty ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test01_forwardWhenHeadingNorthIncrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self emptyRoom .

	playableCharacter moveForward.

	self assert: (playableCharacter isAt: 1@3 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test02_backwardWhenHeadingNorthDecrementsYCoordinate

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self emptyRoom .

	playableCharacter moveBackward.

	self assert: (playableCharacter isAt: 1@1 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test03_rotateRightWhenHeadingNorthHeadsEast

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self emptyRoom .

	playableCharacter rotateRight.

	self assert: (playableCharacter isAt: 1@2 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test04_rotateLeftWhenHeadingNorthHeadsWest

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #North in: self emptyRoom .

	playableCharacter rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #West)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test05_movingWhenHeadingEastWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #East in: self emptyRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 2@2 heading: #North)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test06_movingWhenHeadingSouthWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #South in: self emptyRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@1 heading: #East)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test07_movingWhenHeadingWestWorksAsExpected

	| playableCharacter |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self emptyRoom .

	playableCharacter
		moveForward;
		moveForward;
		moveBackward;
		rotateRight;
		rotateLeft;
		rotateLeft.

	self assert: (playableCharacter isAt: 1@2 heading: #South)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test08_canNotCreatePlayableCharacterWhenHeadingIsNotValid

	self
		should: [PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@2 heading: #X in: self emptyRoom ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: PlayableCharacter invalidCardinalPointErrorDescription equals: anError messageText ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test09_canTakePortableObjects

	| playableCharacter paper |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self emptyRoom .
	paper := NoPointsPortableObject named: 'Paper' weighing: 1.
	
	playableCharacter take: paper.
	
	self assert: (playableCharacter backpackIncludes: paper)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:24:02'!
test10_canNotTakeMoreObjectsThanTheBackpackCanCarry

	| playableCharacter paper key |

	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 2@2 heading: #West in: self emptyRoom .
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

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:58:45'!
test11_cantNotStartOutsideRoomWithInvalidX

	self assertCanNotStartAt: -1@2! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:58:59'!
test12_cantNotStartOutsideRoomWithInvalidY

	self assertCanNotStartAt: 1@-1 ! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:37:15'!
test13_roomKeepsPlayableCharacterPosition

	| room playableCharacter |
	
	room := self emptyRoom.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 1@1 heading: #West in: room.
	
	self assert: playableCharacter equals: (room at: 1@1)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/12/2020 11:23:10'!
test14_canNotMoveForwardOutsideRoom

	self 
		assertCanNotMove: [ :playableCharacter | playableCharacter moveForward ]
		whenHeading: #West
		! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/12/2020 11:23:32'!
test15_canNotMoveBackwardOutsideRoom

	self 
		assertCanNotMove: [ :playableCharacter | playableCharacter moveBackward ]
		whenHeading: #East
		! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 13:37:53'!
test16_canNotMoveToOccupiedPosition

	| room playableCharacter |
	
	room := Room ofSize: 10@10 withAll: { 1@0 -> self createPaper } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	self 
		should: [ playableCharacter moveForward ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room positionIsNotEmptyErrorDescription equals: anError messageText.
			self assert: playableCharacter equals: (room at: 0@0).
			self assert: (playableCharacter isAt: 0@0 heading: #East) ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 13:48:53'!
test17_canTakeAPortableObject

	| room playableCharacter paper |
	
	paper := self createPaper.
	room := Room ofSize: 10@10 withAll: { 1@0 -> paper } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	playableCharacter take.
	
	self assert: (room isEmptyAt: 1@0).
	self assert: (playableCharacter backpackIncludes: paper).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 13:53:57'!
test18_canNotTakeFromAnEmptyPosition

	| room playableCharacter |
	
	room := Room ofSize: 10@10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	self 
		should: [ playableCharacter take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room positionIsEmptyErrorDescription equals: anError messageText.
			self assert: playableCharacter backpackIsEmpty ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 13:57:04'!
test19_canTakeAPortableObjectNoMatterWhereIsHeading

	| room playableCharacter paper |
	
	paper := self createPaper.
	room := Room ofSize: 10@10 withAll: { 0@1 -> paper } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #North in: room.
	
	playableCharacter take.
	
	self assert: (room isEmptyAt: 0@1).
	self assert: (playableCharacter backpackIncludes: paper).! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 14:02:09'!
test20_canNotTakeFromOutSideRoom

	| room playableCharacter |
	
	room := Room ofSize: 10@10.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #West in: room.
	
	self 
		should: [ playableCharacter take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room invalidPositionErrorDescription equals: anError messageText.
			self assert: playableCharacter backpackIsEmpty ]! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 14:05:11'!
test21_NoPortableObjectAreNotRemovedFromRoom

	| room playableCharacter |
	
	room := Room ofSize: 10@10 withAll: {1@0 -> self createDrawer } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	playableCharacter take.
	
	self deny: (room isEmptyAt: 1@0).
	self assert: playableCharacter backpackIsEmpty.! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 14:13:07'!
test22_takesPortableObjectFromNoPortableObject

	| room playableCharacter drawer paper |
	
	paper := self createPaper.
	drawer := NoPortableObject named: 'Drawer' withAll: { paper }.
	
	room := Room ofSize: 10@10 withAll: {1@0 -> drawer } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	playableCharacter take.
	
	self deny: (room isEmptyAt: 1@0).
	self assert: (playableCharacter backpackIncludes: paper).
	self assert: drawer hasNoPortableObjects! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 14:20:57'!
test23_takesPortableObjectFromComposedNoPortableObject

	| room playableCharacter drawer paper box |
	
	paper := self createPaper.
	box := NoPortableObject named: 'box' withAll: { paper }.
	drawer := NoPortableObject named: 'Drawer' withAll: { box }.
	
	room := Room ofSize: 10@10 withAll: {1@0 -> drawer } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	playableCharacter take.
	
	self deny: (room isEmptyAt: 1@0).
	self assert: (playableCharacter backpackIncludes: paper).
	self assert: drawer hasNoPortableObjects.
	self assert: (drawer includes: box)! !

!PlayableCharacterTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 15:18:26'!
test24_stopsTakingWhenBackpackIsFull

	| room playableCharacter drawer paper key |
	
	key := NoPointsPortableObject named: 'Key' weighing: self defaultBackpackWeightLimit.
	paper := self createPaper.
	drawer := NoPortableObject named: 'Drawer' withAll: { key. paper }.
	
	room := Room ofSize: 10@10 withAll: {1@0 -> drawer } asDictionary.
	playableCharacter := PlayableCharacter named: 'Luigi' using: self defaultBackpack at: 0@0 heading: #East in: room.
	
	self 
		should: [ playableCharacter take ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: Backpack maxWeightExceededErrorDescription equals: anError messageText.
			self deny: (room isEmptyAt: 1@0).
			self assert: (playableCharacter backpackIncludes: key).
			self deny: (playableCharacter backpackIncludes: paper).
			self deny: (drawer includes: key).
			self assert: (drawer includes: paper) ]! !


!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 14:05:28'!
createDrawer
	
	^NoPortableObject named: 'Drawer'! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 13:38:01'!
createPaper

	^ NoPointsPortableObject named: 'Paper' weighing: 1! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 14:27:46'!
defaultBackpack

	^ Backpack containingUpTo: self defaultBackpackWeightLimit limitingPointsTo: 100 ! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 14:27:46'!
defaultBackpackWeightLimit

	^ 100! !

!PlayableCharacterTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 12:24:52'!
emptyRoom
	
	^Room ofSize: 10@10! !


!classDefinition: #RoomTest category: 'ISW1-2020-2C-2doParcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:53:03'!
test01_canNotCreateRoomWithXSizeLessThanOne

	self assertInvalidSize: 0@1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:53:30'!
test02_canNotCreateRoomWithYSizeLessThanOne

	self assertInvalidSize: 1@0! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:53:39'!
test03_canNotCreateRoomWithNonIntegerXSize

	self assertInvalidSize: 1.1@1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:53:47'!
test04_canNotCreateRoomWithNonIntegerYSize

	self assertInvalidSize: 1@1.1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:55:02'!
test05_canNotCreateRoomWithElementsWithXPositionLessThanCero

	self assertInvalidPosition: -1@0 ! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:55:13'!
test06_canNotCreateRoomWithElementsWithXPositionBiggerThanXSize

	self assertInvalidPosition: 10@0 ! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:55:29'!
test07_canNotCreateRoomWithElementsWithNonIntegerXPosition

	self assertInvalidPosition: 1.1@0! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:55:39'!
test08_canNotCreateRoomWithElementsWithYPositionLessThanCero

	self assertInvalidPosition: 0@-1! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:55:53'!
test09_canNotCreateRoomWithElementsWithYPositionBiggerThanYSize

	self assertInvalidPosition: 0@10! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 20:56:06'!
test10_canNotCreateRoomWithElementsWithNonIntegerYPosition

	self assertInvalidPosition: 1@1.1 ! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 12:21:24'!
test11_roomKeepsStageObjects

	| room paper |
	
	paper := self createPaper.
	room := Room ofSize: 10@10 withAll: { 1@1 -> paper } asDictionary.
	
	self assert: paper equals: (room at: 1@1)
	
	! !

!RoomTest methodsFor: 'tests' stamp: 'HAW 12/10/2020 13:53:57'!
test12_canNotMoveObjectNotInSourcePosition

	| room |
	
	room := Room ofSize: 10@10.
	
	self 
		should: [ room moveFrom: 0@0 to: 0@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room positionIsEmptyErrorDescription equals: anError messageText.
			self assert: (room isEmptyAt: 0@1) ]! !


!RoomTest methodsFor: 'test objects' stamp: 'HAW 12/10/2020 12:07:44'!
createPaper

	^ NoPointsPortableObject named: 'Paper' weighing: 1! !


!RoomTest methodsFor: 'assertions' stamp: 'HAW 12/10/2020 20:54:45'!
assertInvalidPosition: aPosition

	self
		should: [ Room ofSize: 10@10 withAll: { aPosition -> self createPaper } asDictionary ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Room invalidPositionErrorDescription! !

!RoomTest methodsFor: 'assertions' stamp: 'HAW 12/10/2020 20:53:16'!
assertInvalidSize: aSize

	self
		should: [ Room ofSize: aSize ]
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
	instanceVariableNames: 'position heading backpack name room'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!PlayableCharacter methodsFor: 'initialization' stamp: 'HAW 12/10/2020 12:32:28'!
initializeNamed: aName using: aBackpack at: aPosition heading: aMarsRoverHeading in: aRoom  

	name := aName.
	backpack := aBackpack.
	position := aPosition.
	heading := aMarsRoverHeading.
	room := aRoom.
	
	room at: aPosition put: self! !


!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/9/2020 19:43:44'!
backpackIncludes: aPortableObject 
	
	^backpack includes: aPortableObject ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 12/10/2020 13:55:16'!
backpackIsEmpty
	
	^backpack isEmpty ! !

!PlayableCharacter methodsFor: 'testing' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !


!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/10/2020 13:35:42'!
moveBackward
	
	self moveTo: position - heading forwardPoint ! !

!PlayableCharacter methodsFor: 'moving' stamp: 'HAW 12/10/2020 13:58:01'!
moveForward
	
	self moveTo: self forwardPosition.
	! !


!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:31:55'!
rotateLeft
	
	heading := heading leftHeading! !

!PlayableCharacter methodsFor: 'rotating' stamp: 'HAW 10/11/2019 08:32:04'!
rotateRight
	
	heading := heading rightHeading! !


!PlayableCharacter methodsFor: 'taking objects' stamp: 'HAW 12/10/2020 14:09:10'!
take
	
	| positionToTake objectToTake |
	
	positionToTake := self forwardPosition.
	objectToTake := room at: positionToTake.
	objectToTake takenBy: self at: positionToTake 
	! !


!PlayableCharacter methodsFor: 'taking objects - private' stamp: 'HAW 12/9/2020 19:28:57'!
take: aPortableObject

	backpack add: aPortableObject.! !

!PlayableCharacter methodsFor: 'taking objects - private' stamp: 'HAW 12/10/2020 14:35:46'!
takeNoPortableObject: aNoPortableObject at: aPosition

	aNoPortableObject stageObjectsDo: [ :aStageObject | aStageObject takenBy: self from: aNoPortableObject ]
		! !

!PlayableCharacter methodsFor: 'taking objects - private' stamp: 'HAW 12/10/2020 14:32:49'!
takePortableObject: aPortableObject at: aPosition

	self take: aPortableObject .
	room removeObjectAt: aPosition ! !


!PlayableCharacter methodsFor: 'moving - private' stamp: 'HAW 12/10/2020 13:58:01'!
forwardPosition

	^ position + heading forwardPoint! !

!PlayableCharacter methodsFor: 'moving - private' stamp: 'HAW 12/10/2020 13:40:27'!
moveTo: newPosition

	room moveFrom: position to: newPosition.
	position := newPosition! !

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


!PlayableCharacter class methodsFor: 'instance creation' stamp: 'HAW 12/10/2020 12:24:21'!
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
	instanceVariableNames: 'extent contents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!Room methodsFor: 'initialization' stamp: 'HAW 12/12/2020 11:19:13'!
initializeOfSize: anExtent withAll: aContents 
	
	extent := anExtent.
	contents := aContents.! !


!Room methodsFor: 'board' stamp: 'HAW 12/12/2020 11:19:14'!
at: aPosition

	self assertIsValidPosition: aPosition.
	
	^contents at: aPosition ifAbsent: [self error: self class positionIsEmptyErrorDescription ]! !

!Room methodsFor: 'board' stamp: 'HAW 12/12/2020 11:19:14'!
at: aPosition put: anObject

	self assertIsValidPosition: aPosition.
	self assertIsEmptyAt: aPosition.
	
	^contents at: aPosition put: anObject ! !

!Room methodsFor: 'board' stamp: 'HAW 12/12/2020 11:19:32'!
moveFrom: aSourcePostion to: aTargetPosition

	| objectToMove |
	
	objectToMove := self at: aSourcePostion.
	self at: aTargetPosition put: objectToMove.
	self removeObjectAt: aSourcePostion ! !

!Room methodsFor: 'board' stamp: 'HAW 12/12/2020 11:19:14'!
removeObjectAt: aPosition

	contents removeKey: aPosition ! !


!Room methodsFor: 'testing' stamp: 'HAW 12/12/2020 11:19:14'!
isEmpty
	
	^contents isEmpty ! !

!Room methodsFor: 'testing' stamp: 'HAW 12/12/2020 11:19:14'!
isEmptyAt: aPosition

	^(contents includesKey: aPosition) not! !


!Room methodsFor: 'assertions' stamp: 'HAW 12/10/2020 14:00:42'!
assertIsEmptyAt: aPosition

	^ (self isEmptyAt: aPosition) ifFalse: [self error: self class positionIsNotEmptyErrorDescription ]! !

!Room methodsFor: 'assertions' stamp: 'HAW 12/10/2020 14:03:01'!
assertIsValidPosition: aPosition

	self class assertPositionComponent: aPosition x isValidAndInBounds: extent x.
	self class assertPositionComponent: aPosition y isValidAndInBounds: extent y! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: 'ISW1-2020-2C-2doParcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/10/2020 12:01:15'!
invalidPositionErrorDescription
	
	^'Invalid position'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/10/2020 11:53:04'!
invalidSizeErrorDescription
	
	^'Invalid size'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/10/2020 13:54:04'!
positionIsEmptyErrorDescription
	
	^'Position is empty'! !

!Room class methodsFor: 'error descriptions' stamp: 'HAW 12/10/2020 12:16:01'!
positionIsNotEmptyErrorDescription
	
	^'Position is not empty'! !


!Room class methodsFor: 'instance creation' stamp: 'HAW 12/10/2020 12:19:58'!
ofSize: anExtent 
	
	^self ofSize: anExtent withAll: Dictionary new! !

!Room class methodsFor: 'instance creation' stamp: 'HAW 12/10/2020 14:43:31'!
ofSize: anExtent withAll: aCollectionOfStageObjects 
	
	self assertSizeIsValid: anExtent.
	self assertPositionsOf: anExtent areValidAndInBounds: aCollectionOfStageObjects.
	
	^self new initializeOfSize: anExtent withAll: aCollectionOfStageObjects ! !


!Room class methodsFor: 'assertions' stamp: 'HAW 12/10/2020 11:58:00'!
assertIsValidSizeComponent: aSizeComponent

	^ (aSizeComponent < 1 or: [ aSizeComponent isInteger not ]) ifTrue: [ self error: self invalidSizeErrorDescription ]! !

!Room class methodsFor: 'assertions' stamp: 'HAW 12/10/2020 12:13:04'!
assertPositionComponent: aPositionComponent isValidAndInBounds: aSizeComponent

	^ (aPositionComponent < 0 
		or: [ aPositionComponent >= aSizeComponent 
		or: [ aPositionComponent isInteger not]]) ifTrue: [ self error: self invalidPositionErrorDescription ]! !

!Room class methodsFor: 'assertions' stamp: 'HAW 12/10/2020 12:19:02'!
assertPositionsOf: anExtent areValidAndInBounds: aCollectionOfStageObjects

	^ aCollectionOfStageObjects keysDo: [:aPosition | 
		self assertPositionComponent: aPosition x isValidAndInBounds: anExtent x.
		self assertPositionComponent: aPosition y isValidAndInBounds: anExtent y]! !

!Room class methodsFor: 'assertions' stamp: 'HAW 12/10/2020 11:58:24'!
assertSizeIsValid: anExtent

	self assertIsValidSizeComponent: anExtent x.
	self assertIsValidSizeComponent: anExtent y! !


!classDefinition: #StageObject category: 'ISW1-2020-2C-2doParcial'!
Object subclass: #StageObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!StageObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:41:24'!
takenBy: aPlayableCharacter at: aPosition  
	
	self subclassResponsibility ! !

!StageObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:41:33'!
takenBy: aPlayableCharacter from: anOwner 
	
	self subclassResponsibility ! !


!StageObject methodsFor: 'testing' stamp: 'HAW 12/10/2020 14:41:38'!
isPortable
	
	self subclassResponsibility ! !


!classDefinition: #NoPortableObject category: 'ISW1-2020-2C-2doParcial'!
StageObject subclass: #NoPortableObject
	instanceVariableNames: 'name stageObjects'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-2C-2doParcial'!

!NoPortableObject methodsFor: 'initialization' stamp: 'HAW 12/10/2020 14:05:52'!
initializeNamed: aName 
	
	name := aName.! !

!NoPortableObject methodsFor: 'initialization' stamp: 'HAW 12/10/2020 14:18:45'!
initializeNamed: aName withAll: aCollectionOfStageObjects 
	
	name := aName.
	stageObjects := aCollectionOfStageObjects asOrderedCollection ! !


!NoPortableObject methodsFor: 'stage objects' stamp: 'HAW 12/10/2020 14:24:38'!
remove: aPortableObject 
	
	stageObjects remove: aPortableObject ! !

!NoPortableObject methodsFor: 'stage objects' stamp: 'HAW 12/10/2020 14:36:01'!
stageObjectsDo: aBlock
	
	^stageObjects copy do: aBlock ! !


!NoPortableObject methodsFor: 'testing' stamp: 'HAW 12/10/2020 14:19:33'!
hasNoPortableObjects
	
	^stageObjects noneSatisfy: [ :aStageObject | aStageObject isPortable ]! !

!NoPortableObject methodsFor: 'testing' stamp: 'HAW 12/10/2020 14:25:06'!
includes: aStageObject

	^stageObjects includes: aStageObject ! !

!NoPortableObject methodsFor: 'testing' stamp: 'HAW 12/10/2020 14:24:48'!
isPortable
	
	^false! !


!NoPortableObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:33:28'!
takenBy: aPlayableCharacter at: aPosition  
	
	aPlayableCharacter takeNoPortableObject: self at: aPosition 	! !

!NoPortableObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:36:37'!
takenBy: aPlayableCharacter from: anOwner 
	
	self stageObjectsDo: [:aStageObject | aStageObject takenBy: aPlayableCharacter from: self ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoPortableObject class' category: 'ISW1-2020-2C-2doParcial'!
NoPortableObject class
	instanceVariableNames: ''!

!NoPortableObject class methodsFor: 'instance creation' stamp: 'HAW 12/10/2020 14:18:07'!
named: aName 
	
	^self named: aName withAll: OrderedCollection new! !

!NoPortableObject class methodsFor: 'instance creation' stamp: 'HAW 12/10/2020 14:13:50'!
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

!PortableObject methodsFor: 'testing' stamp: 'HAW 12/10/2020 14:17:32'!
isPortable
	
	^true! !


!PortableObject methodsFor: 'adding' stamp: 'HAW 10/18/2020 12:28:24'!
assertCanAddTo: aBackpack

	self subclassResponsibility	! !


!PortableObject methodsFor: 'accessing' stamp: 'FRT 10/11/2020 18:53:51'!
weight

	^ weight! !


!PortableObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:32:17'!
takenBy: aPlayableCharacter at: aPosition  
	
	aPlayableCharacter takePortableObject: self at: aPosition ! !

!PortableObject methodsFor: 'taken' stamp: 'HAW 12/10/2020 14:24:21'!
takenBy: aPlayableCharacter from: anOwner 
	
	aPlayableCharacter take: self.
	anOwner remove: self
! !


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