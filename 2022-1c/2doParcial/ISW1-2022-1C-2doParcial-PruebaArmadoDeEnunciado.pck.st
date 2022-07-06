'From Cuis 6.0 [latest update: #5324] on 3 July 2022 at 9:36:18 pm'!
'Description '!
!provides: 'ISW1-2022-1C-2doParcial' 1 2!
SystemOrganization addCategory: 'ISW1-2022-1C-2doParcial'!


!classDefinition: #BoardShortcutTest category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #BoardShortcutTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'BoardShortcutTest class' category: 'ISW1-2022-1C-2doParcial'!
BoardShortcutTest class
	instanceVariableNames: ''!

!classDefinition: #FloorPositionTest category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #FloorPositionTest
	instanceVariableNames: 'position floorNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'FloorPositionTest class' category: 'ISW1-2022-1C-2doParcial'!
FloorPositionTest class
	instanceVariableNames: ''!

!classDefinition: #LaddersAndSlidesGameTest category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #LaddersAndSlidesGameTest
	instanceVariableNames: 'diceRolls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'LaddersAndSlidesGameTest class' category: 'ISW1-2022-1C-2doParcial'!
LaddersAndSlidesGameTest class
	instanceVariableNames: ''!

!classDefinition: #BoardShortcut category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #BoardShortcut
	instanceVariableNames: 'from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'BoardShortcut class' category: 'ISW1-2022-1C-2doParcial'!
BoardShortcut class
	instanceVariableNames: ''!

!classDefinition: #FloorPosition category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #FloorPosition
	instanceVariableNames: 'position floorNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'FloorPosition class' category: 'ISW1-2022-1C-2doParcial'!
FloorPosition class
	instanceVariableNames: ''!

!classDefinition: #LaddersAndSlidesGame category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #LaddersAndSlidesGame
	instanceVariableNames: 'players floorExtents collectionOfStairs collectionOfSlides startingPoint endingPoint dice playersPositions playersStream shortcuts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'LaddersAndSlidesGame class' category: 'ISW1-2022-1C-2doParcial'!
LaddersAndSlidesGame class
	instanceVariableNames: ''!


!BoardShortcutTest methodsFor: 'tests' stamp: 'HAW 6/28/2022 11:49:37'!
test01SlideCanNotGoToSameFloor

	self 
		should: [ BoardShortcut slideFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 1). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut slideMustGoDownErrorDescription! !

!BoardShortcutTest methodsFor: 'tests' stamp: 'HAW 6/28/2022 11:49:37'!
test02SlideCanNotGoUp

	self 
		should: [ BoardShortcut slideFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2).  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut slideMustGoDownErrorDescription ! !

!BoardShortcutTest methodsFor: 'tests' stamp: 'HAW 6/28/2022 11:49:37'!
test03StairCanNotGoToSameFloor

	self 
		should: [ BoardShortcut stairFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 1). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut stairMustGoUpErrorDescription! !

!BoardShortcutTest methodsFor: 'tests' stamp: 'HAW 6/28/2022 11:49:37'!
test04StairCanNotGoDown

	self 
		should: [ BoardShortcut stairFrom: (2@2 inFloor: 2) to: (1@1 inFloor: 1).  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut stairMustGoUpErrorDescription! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:13:07'!
test01AreEqualForSamePositionAndFloor

	self assert: (2@2 inFloor: 1) equals: (2@2 inFloor: 1)! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:16:05'!
test02IsNotEqualToObjectOfDifferentType

	self deny: (2@2 inFloor: 1) = 1! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:16:56'!
test03IsNotEqualWithDifferentPossition

	self deny: (2@2 inFloor: 1) = (1@1 inFloor: 1)! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:17:17'!
test04IsNotEqualWithDifferentFloor

	self deny: (2@2 inFloor: 1) = (2@2 inFloor: 2)! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:17:34'!
test05HashIsEqualWhenTheyAreEqual

	self assert: (2@2 inFloor: 1) hash equals: (2@2 inFloor: 1) hash! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:18:09'!
test06isOnTopWhenFloorIsBigger

	self assert: ((2@2 inFloor: 2) isOnTopOf: (2@2 inFloor: 1))! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:18:20'!
test07IsNotOnTopWhenSameFloor

	self deny: ((2@2 inFloor: 1) isOnTopOf: (2@2 inFloor: 1))! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:18:45'!
test08isOnSameFloorForWhenOnSameFloorNumber

	self assert: ((2@2 inFloor: 1) isOnSameFloorAs: (2@2 inFloor: 1))! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:19:18'!
test09isNotOnSameFloorWhenOnDifferentFloors

	self deny: ((2@2 inFloor: 2) isOnSameFloorAs: (2@2 inFloor: 1)).
	self deny: ((2@2 inFloor: 1) isOnSameFloorAs: (2@2 inFloor: 2)).
	! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:19:33'!
test10FloorMustBeStrictlyPositive

	self 
		should: [ 1@1 inFloor: 0 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: FloorPosition floorNumberMustBeStrictlyPositiveErrorDescription! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:19:56'!
test11isOverWhenFloorNumberIsBigger

	self assert: ((1@1 inFloor: 2) isOver: 1)! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:20:13'!
test12isNotOverWhenSameFloorNumber

	self deny: ((1@1 inFloor: 1) isOver: 1)! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:20:27'!
test13XPositionMustBeStrictlyPositive

	self 
		should: [ 0@1 inFloor: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: FloorPosition positionMustBeStrictlyPositiveErrorDescription! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:20:39'!
test14YPositionMustBeStrictlyPositive

	self 
		should: [ 1@0 inFloor: 1 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: FloorPosition positionMustBeStrictlyPositiveErrorDescription! !

!FloorPositionTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:20:51'!
test15PrintsPositionAndFlor

	self assert: '1@2 inFloor: 3' equals: (1@2 inFloor: 3) printString! !

!LaddersAndSlidesGameTest methodsFor: 'dice' stamp: 'HAW 6/26/2022 16:33:44'!
diceRolls: rolls

	diceRolls := ReadStream on: rolls ! !

!LaddersAndSlidesGameTest methodsFor: 'dice' stamp: 'HAW 6/26/2022 16:39:28'!
roll
	
	^diceRolls next! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 6/26/2022 16:49:48'!
defaultEndingPoint
	
	^2@2 inFloor: 2! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 6/26/2022 16:49:48'!
defaultStartingPoint
	
	^1@1 inFloor: 1! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/3/2022 21:02:57'!
player1

	^ 'Player1'! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/3/2022 21:03:05'!
player2

	^ 'Player2'! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/3/2022 21:02:09'!
twoFloorsOf_2_2

	^ { 2@2. 2@2 }! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/3/2022 21:02:40'!
twoFloorsOf_3_3

	^ { 3@3. 3@3. }! !

!LaddersAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/3/2022 21:03:05'!
twoPlayers

	^ { self player1. self player2 }! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:09'!
test01CannotUseShortcutWithFromFloorOverMaxFloor

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: self twoFloorsOf_2_2 
			withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 3) to: (2@1 inFloor: 4). }
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut shortcutMustBeOnValidFloorErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:09'!
test02CannotUseShortcutWithToFloorOverMaxFloor

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: self twoFloorsOf_2_2 
			withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 3). }
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut shortcutMustBeOnValidFloorErrorDescription ! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:09'!
test03ShortcutsMustStartInsideFloor

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: self twoFloorsOf_2_2 
			withShortcuts: { BoardShortcut stairFrom: (3@3 inFloor: 1) to: (1@1 inFloor: 2). }
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut shortcutMustBeInsideFloorErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:09'!
test04ShurtcutsMustEndInsideFloor

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: self twoFloorsOf_2_2 
			withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: (3@3 inFloor: 2).}
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: BoardShortcut shortcutMustBeInsideFloorErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:09'!
test05ShortcutsCannotShareFrom

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: self twoFloorsOf_2_2 
			withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: (2@2 inFloor: 2). BoardShortcut stairFrom: (2@2 inFloor: 1) to: (2@2 inFloor: 2) } 
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlidesGame shortcutsCanNotShareFromErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:00:39'!
test06ShortcutCannotStartOnStartingPoint

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: { 2@2. 2@2. 2@2 } 
			withShortcuts: { BoardShortcut stairFrom: self defaultStartingPoint to: (1@1 inFloor: 2). }
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlidesGame shortcutCannotStartOnStartingPointErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:00:39'!
test07ShortcutCannotStartOnEndingPoint

	self 
		should: [ LaddersAndSlidesGame 
			playing: self twoPlayers 
			onFloorsOf: { 2@2. 2@2. 2@2 } 
			withShortcuts: { BoardShortcut slideFrom: self defaultEndingPoint to: (1@1 inFloor: 1). } 
			startingAt: self defaultStartingPoint 
			endingAt: self defaultEndingPoint 
			dice: self.  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: LaddersAndSlidesGame shortcutCannotStartOnEndingPointErrorDescription! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test08PlayersStartOnStartingPoint

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_2_2 
		withShortcuts: {}
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
			
	self assert: self defaultStartingPoint equals: (game positionOf: self player1).
	self assert: self defaultStartingPoint equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test09FirstPlayerMovesCorrectly

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_2_2 
		withShortcuts: {} 
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7).
	
	game play.
			
	self assert: (2@2 inFloor: 1) equals: (game positionOf: self player1).
	self assert: self defaultStartingPoint equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test10MoreThanOnePlayerMovesCorrectly

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: { 3@3. 2@2. } 
		withShortcuts: {}
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7 7 8).
	
	game play; play.
			
	self assert: (2@2 inFloor: 1) equals: (game positionOf: self player1).
	self assert: (2@3 inFloor: 1) equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test11PlayersDontGoOutsideFloorOnBiggerPosition

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: { 3@3. 2@2. } 
		withShortcuts: {}
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(10 11).
	
	game play.
			
	self assert: (3@3 inFloor: 1) equals: (game positionOf: self player1).
	self assert: self defaultStartingPoint equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test12PlayersDontGoOutsideFloorOnSmallerPosition

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: { 3@3. 2@2. } 
		withShortcuts: {}
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(1 1).
	
	game play.
			
	self assert: (1@1 inFloor: 1) equals: (game positionOf: self player1).
	self assert: self defaultStartingPoint equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test13PlayerMovesThroughtShortcuts

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: { 3@3. 2@2. } 
		withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2) }
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7).
	
	game play.
			
	self assert: (1@1 inFloor: 2) equals: (game positionOf: self player1).
	self assert: self defaultStartingPoint equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test14PlayerMovesThroughtManyShortcuts

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_3_3 
		withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2). BoardShortcut slideFrom: (3@3 inFloor: 2) to: (2@2 inFloor: 1)} 
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7 8 8 8 8).
	
	game play; play; play.
			
	self assert: (2@2 inFloor: 1) equals: (game positionOf: self player1).
	self assert: (3@3 inFloor: 1) equals: (game positionOf: self player2).
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:57'!
test15APlayerWinsWhenGettingToEndingPoint

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_3_3 
		withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: self defaultEndingPoint }
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7).
	
	game play.
			
	self assert: self defaultEndingPoint equals: (game positionOf: self player1).
	self assert: game isOver.
	self assert: self player1 equals: (game winnerIfNone: [ self fail ])
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:02:40'!
test16GameIsNotOverWhenThereIsNoWinner

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_3_3 
		withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: self defaultEndingPoint }
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7).
	
	self deny: game isOver.
	self assert: 'no winner' equals: (game winnerIfNone: [ 'no winner' ])
	! !

!LaddersAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/3/2022 21:03:05'!
test17CannotPlayWhenGameIsOver

	| game |
	
	game := LaddersAndSlidesGame 
		playing: self twoPlayers 
		onFloorsOf: self twoFloorsOf_3_3 
		withShortcuts: { BoardShortcut stairFrom: (2@2 inFloor: 1) to: self defaultEndingPoint }
		startingAt: self defaultStartingPoint 
		endingAt: self defaultEndingPoint 
		dice: self.
	self diceRolls: #(7 7 7 7).
	
	game play.
			
	self 
		should: [ game play ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: LaddersAndSlidesGame cannotPlayWhenGameIsOver equals: anError messageText.
			self assert: self defaultStartingPoint equals: (game positionOf: self player2) ]! !

!BoardShortcut methodsFor: 'initialization' stamp: 'HAW 6/25/2022 23:29:39'!
initializeFrom: aFromFloorPosition to: aToFloorPosition 
	
	from := aFromFloorPosition.
	to := aToFloorPosition.! !

!BoardShortcut methodsFor: 'from/to' stamp: 'HAW 6/25/2022 23:30:44'!
from
	
	^from! !

!BoardShortcut methodsFor: 'from/to' stamp: 'HAW 6/26/2022 17:11:59'!
to
	
	^to! !

!BoardShortcut methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:30:53'!
assert: aFloorPosition inOnValidFloorFrom: aFloorExtents

	(aFloorPosition isOver: aFloorExtents size) ifTrue: [ self error: self class shortcutMustBeOnValidFloorErrorDescription ]! !

!BoardShortcut methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:31:00'!
assert: aFloorPosition isInsideFloorFrom: aFloorExtents

	(aFloorPosition isOutisde: (aFloorExtents at: from floorNumber)) ifTrue: [ self error: self class shortcutMustBeInsideFloorErrorDescription ]
! !

!BoardShortcut methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:31:09'!
assert: aFloorPosition isValidOn: aFloorExtents

	self assert: aFloorPosition inOnValidFloorFrom: aFloorExtents.
	self assert: aFloorPosition isInsideFloorFrom: aFloorExtents ! !

!BoardShortcut methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:31:20'!
assertIsValidOn: aFloorExtents

	self assert: from isValidOn: aFloorExtents.
	self assert: to isValidOn: aFloorExtents.
! !

!BoardShortcut methodsFor: 'testing' stamp: 'HAW 6/25/2022 23:42:07'!
isAtSameFromAs: aShortcut 
	
	^self isFrom: aShortcut from! !

!BoardShortcut methodsFor: 'testing' stamp: 'HAW 6/25/2022 23:41:52'!
isFrom: aFloorPosition 
	
	^from = aFloorPosition ! !

!BoardShortcut class methodsFor: 'instance creation' stamp: 'HAW 7/3/2022 21:10:00'!
slideFrom: aFromFloorPosition to: aToFloorPosition

	self assertSlideGoesDownFrom: aFromFloorPosition to: aToFloorPosition.
	
	^self from: aFromFloorPosition to: aToFloorPosition ! !

!BoardShortcut class methodsFor: 'instance creation' stamp: 'HAW 7/3/2022 21:10:07'!
stairFrom: aFromFloorPosition to: aToFloorPosition

	self assertLadderGoUpFrom: aToFloorPosition to: aFromFloorPosition.
	
	^self from: aFromFloorPosition to: aToFloorPosition ! !

!BoardShortcut class methodsFor: 'error description' stamp: 'HAW 6/25/2022 23:29:03'!
shortcutMustBeInsideFloorErrorDescription
	
	^'Shortcut must be inside floor'! !

!BoardShortcut class methodsFor: 'error description' stamp: 'HAW 6/25/2022 23:29:12'!
shortcutMustBeOnValidFloorErrorDescription
	
	^'Shortcut must be on valid floor'! !

!BoardShortcut class methodsFor: 'error description' stamp: 'HAW 6/26/2022 20:59:14'!
slideMustGoDownErrorDescription
	
	^'Slide must go down'! !

!BoardShortcut class methodsFor: 'error description' stamp: 'HAW 6/26/2022 20:42:19'!
stairMustGoUpErrorDescription
	
	^'Stair must go up'! !

!BoardShortcut class methodsFor: 'assertions' stamp: 'HAW 6/28/2022 11:46:54'!
assertLadderGoUpFrom: aToFloorPosition to: aFromFloorPosition

	^ (aToFloorPosition isOnTopOf: aFromFloorPosition) ifFalse: [ self error: self stairMustGoUpErrorDescription ]! !

!BoardShortcut class methodsFor: 'assertions' stamp: 'HAW 6/28/2022 11:46:33'!
assertSlideGoesDownFrom: aFromFloorPosition to: aToFloorPosition

	^ (aFromFloorPosition isOnTopOf: aToFloorPosition) ifFalse: [ self error: self slideMustGoDownErrorDescription ]! !

!BoardShortcut class methodsFor: 'instance creation - private' stamp: 'HAW 7/3/2022 21:10:34'!
from: aFromFloorPosition to: aToFloorPosition

	^ self new initializeFrom: aFromFloorPosition to: aToFloorPosition! !

!FloorPosition methodsFor: 'initialization' stamp: 'HAW 6/25/2022 19:42:38'!
initializeAt: aPosition in: aFloorNumber 
	
	position := aPosition.
	floorNumber := aFloorNumber.! !

!FloorPosition methodsFor: 'comparing' stamp: 'HAW 6/25/2022 19:47:42'!
= aPotentialFloorPosition

	^(aPotentialFloorPosition isKindOf: self class)
		and: [ position = aPotentialFloorPosition position
		and: [ floorNumber = aPotentialFloorPosition floorNumber ]]! !

!FloorPosition methodsFor: 'comparing' stamp: 'HAW 6/25/2022 19:49:03'!
hash
	
	^position hash bitXor: floorNumber hash! !

!FloorPosition methodsFor: 'testing' stamp: 'HAW 6/25/2022 19:58:14'!
isOnSameFloorAs: aFloorPosition 
	
	^floorNumber = aFloorPosition floorNumber ! !

!FloorPosition methodsFor: 'testing' stamp: 'HAW 6/25/2022 19:52:04'!
isOnTopOf: aFloorPosition 
	
	^floorNumber > aFloorPosition floorNumber ! !

!FloorPosition methodsFor: 'testing' stamp: 'HAW 6/25/2022 20:28:02'!
isOutisde: anExtent

	^position > anExtent ! !

!FloorPosition methodsFor: 'testing' stamp: 'HAW 6/25/2022 20:23:05'!
isOver: aFloorNumber

	^floorNumber > aFloorNumber ! !

!FloorPosition methodsFor: 'printing' stamp: 'HAW 6/26/2022 16:48:42'!
printOn: aWriteStream 
	
	aWriteStream 
		print: position;
		nextPutAll: ' inFloor: ';
		print: floorNumber ! !

!FloorPosition methodsFor: 'accessing' stamp: 'HAW 6/25/2022 19:47:22'!
floorNumber
	
	^floorNumber! !

!FloorPosition methodsFor: 'accessing' stamp: 'HAW 6/25/2022 19:46:12'!
position
	
	^position! !

!FloorPosition methodsFor: 'moving' stamp: 'HAW 6/26/2022 19:47:21'!
move: aVector boundingTo: bound 

	| newPosition |
	
	newPosition := ((position + aVector) min: bound) max: position.
	
	^newPosition inFloor: floorNumber ! !

!FloorPosition class methodsFor: 'instance creation' stamp: 'HAW 6/25/2022 21:41:30'!
at: aPosition in: aFloorNumber 
	
	self assertPositionIsStrictlyPositive: aPosition.
	self assertFloorIsStrictlyPositive: aFloorNumber.
	
	^self new initializeAt: aPosition in: aFloorNumber ! !

!FloorPosition class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 20:07:20'!
assertFloorIsStrictlyPositive: aFloorNumber

	^ aFloorNumber strictlyPositive ifFalse: [ self error: self floorNumberMustBeStrictlyPositiveErrorDescription ]! !

!FloorPosition class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 21:43:27'!
assertPositionIsStrictlyPositive: aPosition

	aPosition x strictlyPositive ifFalse: [ self error: self positionMustBeStrictlyPositiveErrorDescription ].
	aPosition y strictlyPositive ifFalse: [ self error: self positionMustBeStrictlyPositiveErrorDescription ].! !

!FloorPosition class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 20:06:10'!
floorNumberMustBeStrictlyPositiveErrorDescription
	
	^'Floor number must be strictly positive'! !

!FloorPosition class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 21:40:51'!
positionMustBeStrictlyPositiveErrorDescription
	
	^'Position x and y must be strictly positive'! !

!LaddersAndSlidesGame methodsFor: 'initialization' stamp: 'HAW 7/3/2022 20:19:28'!
initializePlaying: aCollectionOfPlayers 
	onFloorsOf: aFloorExtents 
	withShortcuts: aCollectionOfShortcuts
	startingAt: aStartingPoint 
	endingAt: anEndingPoint 
	dice: aDice 
	
	players := aCollectionOfPlayers.
	floorExtents := aFloorExtents.
	shortcuts := aCollectionOfShortcuts.
	startingPoint := aStartingPoint.
	endingPoint := anEndingPoint.
	dice := aDice.
	
	playersPositions := Dictionary new.
	players do: [ :aPlayer | playersPositions at: aPlayer put: aStartingPoint ].
	
	playersStream := CircularReadStream on: aCollectionOfPlayers moving: 1 unit.! !

!LaddersAndSlidesGame methodsFor: 'playing' stamp: 'HAW 7/3/2022 21:31:04'!
play
	
	self
		assertIsNotOver;
		moveCurrentPlayer;
		calculateNextPlayer.! !

!LaddersAndSlidesGame methodsFor: 'testing' stamp: 'HAW 6/26/2022 20:03:59'!
isOver
	
	self winnerIfNone: [ ^false ].
	^true! !

!LaddersAndSlidesGame methodsFor: 'players' stamp: 'HAW 6/26/2022 16:40:40'!
positionOf: aPlayer

	^playersPositions at: aPlayer ! !

!LaddersAndSlidesGame methodsFor: 'players' stamp: 'HAW 6/26/2022 20:08:45'!
winnerIfNone: aBlock
	
	^playersPositions keys 
		detect: [ :aPlayer | (playersPositions at: aPlayer) = endingPoint ]
		ifNone: aBlock ! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 6/26/2022 20:22:49'!
assertIsNotOver

	^ self isOver ifTrue: [ self error: self class cannotPlayWhenGameIsOver ]! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 7/3/2022 21:25:29'!
calculateNextPlayer

	^ playersStream next! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 7/3/2022 21:33:02'!
currentPlayer

	^ playersStream current! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 7/3/2022 21:34:16'!
moveCurrentPlayer 
	
	playersPositions 
		at: self currentPlayer 
		put: (self moveThroughtShortcuts: self newPositionOfCurrentPlayer).
	
	! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 7/3/2022 21:35:04'!
moveThroughtShortcuts: aPosition

	^ shortcuts 
		detect: [ :aShortcut | aShortcut isFrom: aPosition ]
		ifFound: [ :aShortcut | aShortcut to ]
		ifNone: [ aPosition ]! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 7/3/2022 21:33:50'!
newPositionOfCurrentPlayer  
	
	| newPosition currentPlayerPosition delta |

	currentPlayerPosition := playersPositions at: self currentPlayer.
	delta := self rollDice @ self rollDice .
	
	newPosition := currentPlayerPosition 
		move: delta 
		boundingTo: (floorExtents at: currentPlayerPosition floorNumber).
	
	^newPosition 
	! !

!LaddersAndSlidesGame methodsFor: 'playing - private' stamp: 'HAW 6/26/2022 20:23:06'!
rollDice

	^ dice roll - 6! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/3/2022 21:07:03'!
assertShortcuts: shortcuts doNotStartOn: aStartingPoint or: anEndingPoint 
 
	(shortcuts anySatisfy: [ :shortcut | shortcut isFrom: aStartingPoint ]) ifTrue: [ self error: self shortcutCannotStartOnStartingPointErrorDescription ].
	(shortcuts anySatisfy: [ :shortcut | shortcut isFrom: anEndingPoint ]) ifTrue: [ self error: self shortcutCannotStartOnEndingPointErrorDescription ]! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:33:34'!
assertShortcutsDoNotShareFrom: shortcuts

	^ shortcuts combinations: 2 atATimeDo: [ :combinedShortcuts | 
		(combinedShortcuts first isAtSameFromAs: combinedShortcuts second) ifTrue: [ self error: self shortcutsCanNotShareFromErrorDescription ]]! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:34:26'!
assertWith: aFloorExtents areValidShortcutsOf: shortcuts

	^ shortcuts do: [ :shortcut | shortcut assertIsValidOn: aFloorExtents ]! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 6/26/2022 20:11:53'!
cannotPlayWhenGameIsOver
	
	^'Cannot play when game is over'! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/3/2022 20:42:12'!
shortcutCannotStartOnEndingPointErrorDescription
	
	^'Slide cannot start on ending point'! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/3/2022 20:39:07'!
shortcutCannotStartOnStartingPointErrorDescription
	
	^'Stair cannot start on starting point'! !

!LaddersAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 6/25/2022 23:33:34'!
shortcutsCanNotShareFromErrorDescription
	
	^'Stairs cannot share from'! !

!LaddersAndSlidesGame class methodsFor: 'instance creation' stamp: 'HAW 7/3/2022 21:06:38'!
playing: aCollectionOfPlayers onFloorsOf: aFloorExtents withShortcuts: aCollectionOfShortcuts startingAt: aStartingPoint endingAt: anEndingPoint dice: aDice       
	
	self assertWith: aFloorExtents areValidShortcutsOf: aCollectionOfShortcuts .
	self assertShortcutsDoNotShareFrom: aCollectionOfShortcuts.
	self assertShortcuts: aCollectionOfShortcuts doNotStartOn: aStartingPoint or: anEndingPoint.
	
	^self new
		initializePlaying: aCollectionOfPlayers 
		onFloorsOf: aFloorExtents 
		withShortcuts: aCollectionOfShortcuts 
		startingAt: aStartingPoint 
		endingAt: anEndingPoint 
		dice: aDice      
! !

!Point methodsFor: '*ISW1-2022-1C-2doParcial' stamp: 'HAW 6/26/2022 16:49:48'!
inFloor: aFloorNumber

	^FloorPosition at: self in: aFloorNumber ! !
