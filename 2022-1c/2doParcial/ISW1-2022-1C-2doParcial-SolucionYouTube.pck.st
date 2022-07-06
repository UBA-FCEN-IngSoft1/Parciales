'From Cuis 6.0 [latest update: #5324] on 6 July 2022 at 6:59:23 pm'!
'Description renames'!
!provides: 'ISW1-2022-1C-2doParcial' 1 4!
SystemOrganization addCategory: 'ISW1-2022-1C-2doParcial'!


!classDefinition: #LadderAndSlidesGameTest category: 'ISW1-2022-1C-2doParcial'!
TestCase subclass: #LadderAndSlidesGameTest
	instanceVariableNames: 'diceRolls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'LadderAndSlidesGameTest class' category: 'ISW1-2022-1C-2doParcial'!
LadderAndSlidesGameTest class
	instanceVariableNames: ''!

!classDefinition: #Dice category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Dice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'Dice class' category: 'ISW1-2022-1C-2doParcial'!
Dice class
	instanceVariableNames: ''!

!classDefinition: #RamdomDice category: 'ISW1-2022-1C-2doParcial'!
Dice subclass: #RamdomDice
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'RamdomDice class' category: 'ISW1-2022-1C-2doParcial'!
RamdomDice class
	instanceVariableNames: ''!

!classDefinition: #LadderAndSlidesGame category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #LadderAndSlidesGame
	instanceVariableNames: 'players floorExtentions startingPosition endingPosition dice playersPosition playersStream shortcuts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'LadderAndSlidesGame class' category: 'ISW1-2022-1C-2doParcial'!
LadderAndSlidesGame class
	instanceVariableNames: ''!

!classDefinition: #PositionInFloor category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #PositionInFloor
	instanceVariableNames: 'position floorNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'PositionInFloor class' category: 'ISW1-2022-1C-2doParcial'!
PositionInFloor class
	instanceVariableNames: ''!

!classDefinition: #Shortcut category: 'ISW1-2022-1C-2doParcial'!
Object subclass: #Shortcut
	instanceVariableNames: 'from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-2doParcial'!
!classDefinition: 'Shortcut class' category: 'ISW1-2022-1C-2doParcial'!
Shortcut class
	instanceVariableNames: ''!


!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test01PlayersStartOnStaringPosition

	| game |
	
	game := self defaultGame.
		
	self assert: (game positionOf: self player1 is: self startingPosition).
	self assert: (game positionOf: self player2 is: self startingPosition).! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test02PositionInFloorIsNotTheSameWithDifferentPosition

	| game |
	
	game := self defaultGame.
		
	self deny: (game positionOf: self player1 is: (2@1 inFloor: 1)).
! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test03PositionInFloorIsNotTheSameOnDifferentFloor

	| game |
	
	game := self defaultGame.
		
	self deny: (game positionOf: self player1 is: (1@1 inFloor: 2)).
! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test04FirstPlayerMovesCorrectly

	| game |
	
	game := self defaultGame.
	self diceRolls: #(7 7).
	
	game play.
		
	self assert: (game positionOf: self player1 is: (2@2 inFloor: 1)).
! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:13:25'!
test05FloorInPositionIsNotEqualToObjectsOfDiffentType

	self deny: self endingPosition = 1! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:13:36'!
test06FloorPositionsHaveSameHashWhenEqual

	self assert: self endingPosition hash equals: self endingPosition hash! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test07AllPlayersMove

	| game |
	
	game := self defaultGame.
	
	self diceRolls: #(7 7 7 6).
	game play; play.
		
	self assert: (game positionOf: self player1 is: (2@2 inFloor: 1)).
	self assert: (game positionOf: self player2 is: (2@1 inFloor: 1)).
! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test08PlayersCannotMoveOutsideFloorExtent

	| game |
	
	game := self defaultGame.
	
	self diceRolls: #(8 8).
	game play.
		
	self assert: (game positionOf: self player1 is: (2@2 inFloor: 1)).
	! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:24:11'!
test09PlayerCannotMoveOnPositionBelow1_1

	| game |
	
	game := self defaultGame.
	
	self diceRolls: #(5 5).
	game play.
		
	self assert: (game positionOf: self player1 is: self startingPosition).
	! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:23:46'!
test10PlayerCanMoveThrougthShorcut

	| game |
	
	game := self defaultGameWith: { Shortcut ladderFrom: (2@2 inFloor: 1) to: (self endingPosition) }.
	
	self diceRolls: #(7 7).
	game play.
		
	self assert: (game positionOf: self player1 is: self endingPosition).
	! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 19:00:51'!
test11LadderCanNotHaveSameStartingAndEndingFloor

	self 
		should: [ Shortcut ladderFrom: (2@2 inFloor: 2) to: ( 3@3 inFloor: 2). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Shortcut ladderMustGoUpErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 19:00:16'!
test12LadderMustGoUp

	self 
		should: [ Shortcut ladderFrom: (2@2 inFloor: 3) to: ( 3@3 inFloor: 2). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Shortcut ladderMustGoUpErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:46:49'!
test13SlideCannotHaveSameStargingAndEndingFloor

	self 
		should: [ Shortcut slideFrom: (2@2 inFloor: 2) to: ( 3@3 inFloor: 2). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Shortcut slideMustDownUpErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:46:49'!
test14SlideMustGoDown

	self 
		should: [ Shortcut slideFrom: (2@2 inFloor: 1) to: ( 3@3 inFloor: 2). ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Shortcut slideMustDownUpErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test15ShortcutsFromCannotBeOutsideFloorExtent

	self 
		assertShortcutIsInvalid: (Shortcut ladderFrom: (3@3 inFloor: 1) to: self endingPosition) 
		because: LadderAndSlidesGame shortcutsMustBeInsideFloorsErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test16ShortcutFromMustBeEqualOrBiggerTo1_1

	self 
		assertShortcutIsInvalid: (Shortcut ladderFrom: (0@0 inFloor: 1) to: self endingPosition)
		because: LadderAndSlidesGame shortcutsMustBeInsideFloorsErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test17ShortcutFromMustBeOnValidFloor

	self 
		assertShortcutIsInvalid: (Shortcut ladderFrom: (1@1 inFloor: 0) to: self endingPosition)
		because: LadderAndSlidesGame shortcutsMustBeOnValidFloorsErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test18ShortcutToMustBeInsideFloorExtents

	self 
		assertShortcutIsInvalid: (Shortcut ladderFrom: self startingPosition to: (4@4 inFloor: 2))
		because: LadderAndSlidesGame shortcutsMustBeInsideFloorsErrorDescription ! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test19ShortcutCannotStartOnStartingPosition

	self 
		assertShortcutIsInvalid: (Shortcut ladderFrom: self startingPosition to: (1@1 inFloor: 2))
		because: LadderAndSlidesGame shortcutsCannotStartOnStartingPositionErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test20ShortcutsCannotStartOnEndingPosition

	self
		should: [ LadderAndSlidesGame 
			players: self twoPlayers 
			floorExtentions: self twoFloorExtentions 
			startingOn: self startingPosition
			endingOn: (2@2 inFloor: 1) 
			shortcuts: { Shortcut ladderFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2) }
			dice: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: LadderAndSlidesGame shortcutsCannotStartOnEndingPositionErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test21ShortcutsCannotStartOnSamePosition

	self 
		assertShortcutsAreInvalid: { Shortcut ladderFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2). Shortcut ladderFrom: (2@2 inFloor: 1) to: (2@2 inFloor: 2) }
		because: LadderAndSlidesGame shortcutsCannotStartOnSamePositionErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test22ShortcutsCannotEndOnAnotherShortcutStart

	self 
		assertShortcutsAreInvalid: { Shortcut ladderFrom: (2@2 inFloor: 1) to: (1@1 inFloor: 2). Shortcut slideFrom: (1@1 inFloor: 2) to: (1@2 inFloor: 1) }
		because: LadderAndSlidesGame shortcutsCannotEndOnAnotherShortcutStartErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:22:42'!
test23GameIsOverWhenAPlayerGetsIntoEndingPosition

	| game |
	
	game := self gameOverGame.
	
	self diceRolls: #(7 7).
	game play.
		
	self assert: game isOver.
	self assert: self player1 equals: (game winnerIfNone: [ self fail ]).! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/5/2022 20:22:42'!
test24GameIsNotOverWhenNoPlayerIsOnEndingPosition

	| game |
	
	game := self gameOverGame.
	
	self diceRolls: #(7 7).
		
	self deny: game isOver.
	self assert: 'no winner' equals: (game winnerIfNone: [ 'no winner' ]).! !

!LadderAndSlidesGameTest methodsFor: 'tests' stamp: 'HAW 7/6/2022 18:47:30'!
test25CannotPlayWhenGameIsOver

	| game |
	
	game := self gameOverGame.
	
	self diceRolls: #(7 7).
	game play.
	
	self
		should: [ game play ]
		raise: Error
		withMessageText: LadderAndSlidesGame cannotPlayWhenGameIsOverErrorDescription! !

!LadderAndSlidesGameTest methodsFor: 'dice simulation' stamp: 'HAW 7/5/2022 11:45:53'!
diceRolls: aCollectionOfRolls

	diceRolls := ReadStream on: aCollectionOfRolls ! !

!LadderAndSlidesGameTest methodsFor: 'dice simulation' stamp: 'HAW 7/5/2022 11:46:07'!
roll
	
	^diceRolls next! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 20:24:11'!
defaultGame

	^ self defaultGameWith: {}! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/6/2022 18:47:30'!
defaultGameWith: shortcuts

	^ LadderAndSlidesGame 
		players: self twoPlayers 
		floorExtentions: self twoFloorExtentions 
		startingOn: self startingPosition
		endingOn: self endingPosition
		shortcuts: shortcuts
		dice: self! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 18:50:33'!
endingPosition

	^ 3@3 inFloor: 2! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 20:23:04'!
gameOverGame

	^ self defaultGameWith: { Shortcut ladderFrom: (2@2 inFloor: 1) to: self endingPosition }
	! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 11:24:08'!
player1

	^ 'Player1'! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 11:24:14'!
player2

	^ 'Player2'! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 18:50:12'!
startingPosition

	^ 1@1 inFloor: 1! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 19:05:44'!
twoFloorExtentions

	^ { 2@2. 3@3 }! !

!LadderAndSlidesGameTest methodsFor: 'test data' stamp: 'HAW 7/5/2022 19:05:59'!
twoPlayers

	^ { self player1. self player2 }! !

!LadderAndSlidesGameTest methodsFor: 'assertions' stamp: 'HAW 7/5/2022 19:12:13'!
assertShortcutIsInvalid: shortcut because: errorMessage 

	^ self assertShortcutsAreInvalid: { shortcut. } because: errorMessage! !

!LadderAndSlidesGameTest methodsFor: 'assertions' stamp: 'HAW 7/5/2022 20:21:39'!
assertShortcutsAreInvalid: shortcuts because: errorMessage 

	^ self
		should: [ self defaultGameWith: shortcuts ]
		raise: Error - MessageNotUnderstood 
		withMessageText: errorMessage! !

!Dice methodsFor: 'rolling' stamp: 'HAW 7/5/2022 18:48:23'!
roll

	self subclassResponsibility ! !

!RamdomDice methodsFor: 'rolling' stamp: 'HAW 7/5/2022 18:49:09'!
roll

	^Random new nextInteger: 12! !

!LadderAndSlidesGame methodsFor: 'initialization' stamp: 'HAW 7/5/2022 18:29:43'!
initializePlayers: aCollectionOfPlayers floorExtentions: aFloorExtentions startingOn: aStartingPosition endingOn: anEndingPosition shortcuts: aCollectionOfShortcuts dice: aDice 
	
	players := aCollectionOfPlayers.
	floorExtentions := aFloorExtentions.
	startingPosition := aStartingPosition.
	endingPosition := anEndingPosition.
	shortcuts := aCollectionOfShortcuts.
	dice := aDice.
	playersStream := CircularReadStream on: players moving: NullUnit new.
	
	self initiliazePlayersPosition.
	! !

!LadderAndSlidesGame methodsFor: 'initialization' stamp: 'HAW 7/5/2022 18:29:28'!
initiliazePlayersPosition

	playersPosition := Dictionary new.
	players do: [ :aPlayer | playersPosition at: aPlayer put: startingPosition ]! !

!LadderAndSlidesGame methodsFor: 'play' stamp: 'HAW 7/5/2022 18:38:52'!
play
	
	self
		assertGameIsNotOver;
		moveCurrentPlayer;
		calculateNextPlayer
	! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/5/2022 18:35:31'!
assertGameIsNotOver

	^ self isOver ifTrue: [ self error: self class cannotPlayWhenGameIsOverErrorDescription ]! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/6/2022 18:42:28'!
calculateNextPlayer

	^ playersStream next! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/5/2022 18:41:43'!
currentPlayerNewPosition
	
	| delta currentPlayerPosition |
	
	delta := self rollDice @ self rollDice.
	currentPlayerPosition := playersPosition at: self currentPlayer.
	
	^currentPlayerPosition
		addInFloor: delta 
		boundingTo: (floorExtentions at: currentPlayerPosition floorNumber).
	! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/5/2022 18:38:25'!
moveCurrentPlayer

	^ playersPosition 
		at: self currentPlayer 
		put: (self moveThroughtShortcuts: self currentPlayerNewPosition)! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/5/2022 18:37:16'!
moveThroughtShortcuts: newPosition

	^ shortcuts 
		detect: [ :aLadder | aLadder startsOn: newPosition ]
		ifFound: [ :aLadder | aLadder to ]
		ifNone: [ newPosition ]! !

!LadderAndSlidesGame methodsFor: 'play - private' stamp: 'HAW 7/5/2022 11:24:47'!
rollDice

	^ dice roll - 6! !

!LadderAndSlidesGame methodsFor: 'testing' stamp: 'HAW 7/5/2022 18:32:25'!
isOver
	
	self winnerIfNone: [ ^false ].
	^true! !

!LadderAndSlidesGame methodsFor: 'testing' stamp: 'HAW 7/5/2022 11:33:44'!
positionOf: aPlayer is: aPositionInFloor 
	
	^(playersPosition at: aPlayer) = aPositionInFloor ! !

!LadderAndSlidesGame methodsFor: 'players' stamp: 'HAW 7/5/2022 11:48:14'!
currentPlayer

	^ playersStream current! !

!LadderAndSlidesGame methodsFor: 'players' stamp: 'HAW 7/5/2022 18:33:11'!
winnerIfNone: aNoneBlock

	^players detect: [ :player | self positionOf: player is: endingPosition ] ifNone: aNoneBlock ! !

!LadderAndSlidesGame class methodsFor: 'instance creation' stamp: 'HAW 7/5/2022 18:26:31'!
players: aCollectionOfPlayers 
	floorExtentions: aFloorExtentions 
	startingOn: aStartingPosition 
	endingOn: anEndingPosition 
	shortcuts: aCollectionOfShortcuts 
	dice: aDice  
	
	self assert: aCollectionOfShortcuts areValidOn: aFloorExtentions startingOn: aStartingPosition endingOn: anEndingPosition.
	self assertShortcutsDonotShareStaringPositionOrAreContiguous: aCollectionOfShortcuts.
	
	^self new 
		initializePlayers: aCollectionOfPlayers 
		floorExtentions: aFloorExtentions 
		startingOn: aStartingPosition 
		endingOn: anEndingPosition 
		shortcuts: aCollectionOfShortcuts 
		dice: aDice ! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:25:21'!
assert: aCollectionOfShortcuts areValidOn: aFloorExtentions startingOn: aStartingPosition endingOn: anEndingPosition

	aCollectionOfShortcuts do: [ :aShortcut | 
		aShortcut assertIsValidOn: aFloorExtentions startingOn: aStartingPosition endingOn: anEndingPosition ].
	! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:45:25'!
assertShortcutsDonotShareStaringPositionOrAreContiguous: aCollectionOfShortcuts

	^ aCollectionOfShortcuts combinations: 2 atATimeDo: [ :shortcuts | 
		shortcuts first assertDoesNotShareStartingPositionOrIsContigousTo: shortcuts second ].
	! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:21:46'!
shortcutsCannotEndOnAnotherShortcutStartErrorDescription
	
	^'Shortcuts cannot end on another shortcut''s start'! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:16:13'!
shortcutsCannotStartOnEndingPositionErrorDescription
	
	^'Shortcuts cannot start on ending position'! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:17:43'!
shortcutsCannotStartOnSamePositionErrorDescription
	
	^'Shortcut cannot start on same position'! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:15:59'!
shortcutsCannotStartOnStartingPositionErrorDescription
	
	^'Shortcut cannot start on starting point'! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 17:52:44'!
shortcutsMustBeInsideFloorsErrorDescription
	
	^'Shortcuts must be inside floor'! !

!LadderAndSlidesGame class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:05:37'!
shortcutsMustBeOnValidFloorsErrorDescription
	
	^'Shortcut must start on valid floor'! !

!LadderAndSlidesGame class methodsFor: 'as yet unclassified' stamp: 'HAW 7/5/2022 18:34:23'!
cannotPlayWhenGameIsOverErrorDescription
	
	^'Cannot play when game is over'! !

!PositionInFloor methodsFor: 'initialization' stamp: 'HAW 7/5/2022 11:30:57'!
initializeAt: aPosition in: aFloorNumber 
	
	position := aPosition.
	floorNumber := aFloorNumber.! !

!PositionInFloor methodsFor: 'comparing' stamp: 'HAW 7/5/2022 11:42:14'!
= anObject 
	
	^(anObject isKindOf: self class)
		and: [ position = anObject position 
		and: [ floorNumber = anObject floorNumber ]]! !

!PositionInFloor methodsFor: 'comparing' stamp: 'HAW 7/5/2022 11:42:57'!
hash
	
	^position hash bitXor: floorNumber hash! !

!PositionInFloor methodsFor: 'accessing' stamp: 'HAW 7/5/2022 11:34:52'!
floorNumber
	
	^floorNumber! !

!PositionInFloor methodsFor: 'accessing' stamp: 'HAW 7/5/2022 11:34:46'!
position
	
	^position! !

!PositionInFloor methodsFor: 'testing' stamp: 'HAW 7/5/2022 17:48:37'!
isBelow: aPositionInFloor 
	
	^floorNumber < aPositionInFloor floorNumber ! !

!PositionInFloor methodsFor: 'testing' stamp: 'HAW 7/5/2022 17:49:39'!
isOnTopOf: aPositionInFloor 
	
	^floorNumber > aPositionInFloor floorNumber ! !

!PositionInFloor methodsFor: 'adding' stamp: 'HAW 7/5/2022 18:41:43'!
addInFloor: aDelta boundingTo: anExtent 

	| newPositionInFloorBounds newPosition |
	
	newPosition := position + aDelta.
	newPositionInFloorBounds := (newPosition min: anExtent) max: 1@1.
	
	^newPositionInFloorBounds inFloor: floorNumber ! !

!PositionInFloor methodsFor: 'printing' stamp: 'HAW 7/5/2022 17:34:44'!
printOn: aStream

	aStream 
		print: position;
		nextPutAll: ' inFloor: ';
		print: floorNumber ! !

!PositionInFloor methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:47:30'!
assertIsValidOn: floorExtentions

	| floorExtention |
	
	floorExtention := floorExtentions at: floorNumber ifAbsent: [ self error: LadderAndSlidesGame shortcutsMustBeOnValidFloorsErrorDescription ].
	(position between: 1@1 and: floorExtention) ifFalse: [ self error: LadderAndSlidesGame shortcutsMustBeInsideFloorsErrorDescription ]! !

!PositionInFloor class methodsFor: 'instance creation' stamp: 'HAW 7/5/2022 11:30:47'!
at: aPosition in: aFloorNumber 
	
	^self new initializeAt: aPosition in: aFloorNumber ! !

!Shortcut methodsFor: 'initialization' stamp: 'HAW 7/5/2022 12:00:35'!
initializeFrom: aFrom to: aTo 
	
	from := aFrom.
	to := aTo.! !

!Shortcut methodsFor: 'from/to' stamp: 'HAW 7/5/2022 18:20:10'!
from
	
	^from! !

!Shortcut methodsFor: 'from/to' stamp: 'HAW 7/5/2022 12:04:48'!
to
	
	^to! !

!Shortcut methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:47:30'!
assertDoNotStartOnSamePosition: aShortcut

	^ (self startsOnSamePositionAs: aShortcut) ifTrue: [ self error: LadderAndSlidesGame shortcutsCannotStartOnSamePositionErrorDescription ]! !

!Shortcut methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:46:08'!
assertDoesNotShareStartingPositionOrIsContigousTo: aShortcut 
	
	self assertDoNotStartOnSamePosition: aShortcut.
	self assertIsNotContigousTo: aShortcut 
! !

!Shortcut methodsFor: 'assertions' stamp: 'HAW 7/5/2022 18:47:21'!
assertDoesNotStartOn: aStartingPosition onError: errorDescription 

	^ from = aStartingPosition ifTrue: [ self error: errorDescription ]! !

!Shortcut methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:47:30'!
assertIsNotContigousTo: aShortcut 
	
	(self endsOnSameStartAs: aShortcut ) ifTrue: [ self error: LadderAndSlidesGame shortcutsCannotEndOnAnotherShortcutStartErrorDescription ].! !

!Shortcut methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:47:30'!
assertIsValidOn: floorExtentions startingOn: aStartingPosition endingOn: anEndingPosition  

	from assertIsValidOn: floorExtentions.
	to assertIsValidOn: floorExtentions.
	
	self assertDoesNotStartOn: aStartingPosition onError: LadderAndSlidesGame shortcutsCannotStartOnStartingPositionErrorDescription.
	self assertDoesNotStartOn: anEndingPosition onError: LadderAndSlidesGame shortcutsCannotStartOnEndingPositionErrorDescription ! !

!Shortcut methodsFor: 'testing' stamp: 'HAW 7/5/2022 18:22:46'!
endsOnSameStartAs: aShortcut 
	
	^to = aShortcut from ! !

!Shortcut methodsFor: 'testing' stamp: 'HAW 7/5/2022 12:04:37'!
startsOn: aPositionInFloor 
	
	^from = aPositionInFloor ! !

!Shortcut methodsFor: 'testing' stamp: 'HAW 7/5/2022 18:20:04'!
startsOnSamePositionAs: aShortcut 
	
	^from = aShortcut from! !

!Shortcut class methodsFor: 'instance creation' stamp: 'HAW 7/5/2022 17:50:18'!
ladderFrom: aFrom to: aTo 
	
	self assert: aFrom isBelow: aTo.
	
	^self from: aFrom to: aTo! !

!Shortcut class methodsFor: 'instance creation' stamp: 'HAW 7/6/2022 18:46:25'!
slideFrom: aFrom to: aTo 
	
	self assert: aFrom isOnTopOf: aTo.
	
	^self from: aFrom to: aTo ! !

!Shortcut class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 17:48:54'!
assert: aFrom isBelow: aTo

	^ (aFrom isBelow: aTo) ifFalse: [ self error: self ladderMustGoUpErrorDescription ]! !

!Shortcut class methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:46:49'!
assert: aFrom isOnTopOf: aTo

	^ (aFrom isOnTopOf: aTo) ifFalse: [ self error: self slideMustDownUpErrorDescription ]! !

!Shortcut class methodsFor: 'assertions' stamp: 'HAW 7/5/2022 17:41:32'!
ladderMustGoUpErrorDescription
	
	^'Ladders must go up'! !

!Shortcut class methodsFor: 'assertions' stamp: 'HAW 7/6/2022 18:46:52'!
slideMustDownUpErrorDescription
	
	^'Slides must go down'! !

!Shortcut class methodsFor: 'intance creation - private' stamp: 'HAW 7/5/2022 17:50:32'!
from: aFrom to: aTo

	^ self new initializeFrom: aFrom to: aTo! !

!Point methodsFor: '*ISW1-2022-1C-2doParcial' stamp: 'HAW 7/5/2022 11:30:01'!
inFloor: aFloorNumber

	^PositionInFloor at: self in: aFloorNumber ! !
