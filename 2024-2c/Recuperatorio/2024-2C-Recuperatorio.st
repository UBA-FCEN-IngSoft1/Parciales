!classDefinition: #TetrisTest category: #'2024-2C-Recuperatorio'!
TestCase subclass: #TetrisTest
	instanceVariableNames: 'nextPieceIds'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio'!

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 10:51:25'!
test01CannotCreateGameWithLessThan4Columns

	nextPieceIds := ReadStream on: #(1).
	self 
		should: [ TetrisGame of: 3@5 definingNextPieceWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TetrisGame invalidBoardExtentErrorDescription! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 10:52:01'!
test02CannotCreateGameWithLessThan5Rows

	nextPieceIds := ReadStream on: #(1).
	self 
		should: [ TetrisGame of: 4@4 definingNextPieceWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TetrisGame invalidBoardExtentErrorDescription! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 10:52:57'!
test03TetrominoOIsRepresentedCorrectlyAsString

	| game |
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#-**-#'
'#-**-#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:11:50'!
test04TetrominoTIsRepresentedCorrectlyAsString

	| game |
	
	nextPieceIds := ReadStream on: #(2).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#***-#'
'#-*--#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:12:32'!
test05InitialColumnIsTheBoardCenter

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 6@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#--**--#'
'#--**--#'
'#------#'
'#------#'
'#------#'
'########')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:13:21'!
test06TetrominoIIsRepresentedCorrectlyAsString

	| game |
	
	nextPieceIds := ReadStream on: #(3).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#-*--#'
'#-*--#'
'#-*--#'
'#-*--#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:15:31'!
test07TetrominoZIsRepresentedCorrectlyAsString

	| game |
	
	nextPieceIds := ReadStream on: #(4).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#**--#'
'#-**-#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:17:46'!
test08TetrominoZIsRepresentedCorrectlyAsString

	| game |
	
	nextPieceIds := ReadStream on: #(5).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: game stringBoard equals: #(
'#-*--#'
'#-*--#'
'#-**-#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:20:23'!
test09OnTickCurrentPieceMovesDown

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game tick.
	
	self assert: game stringBoard equals: #(
'#----#'
'#-**-#'
'#-**-#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:21:43'!
test10CurrentPieceCanMoveLeft

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceLeft.
	
	self assert: game stringBoard equals: #(
'#**--#'
'#**--#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:22:35'!
test11CurrentPieceCanMoveRight

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceRight.
	
	self assert: game stringBoard equals: #(
'#--**#'
'#--**#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:24:52'!
test12CannotLeaveBoardWhenMovingLeft

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceLeft; moveCurrentPieceLeft.
	
	self assert: game stringBoard equals: #(
'#**--#'
'#**--#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 11:27:29'!
test13CannotLeaveBoardWhenMovingRight

	| game |
	
	nextPieceIds := ReadStream on: #(1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceRight; moveCurrentPieceRight.
	
	self assert: game stringBoard equals: #(
'#--**#'
'#--**#'
'#----#'
'#----#'
'#----#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 15:49:29'!
test14CurrentPieceCannotMoveBelowBottomWall

	| game |
	
	nextPieceIds := ReadStream on: #(1 2).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	3 timesRepeat: [ game tick ].
	game tick.
	
	self assert: game stringBoard equals: #(
'#***-#'
'#-*--#'
'#----#'
'#-**-#'
'#-**-#'
'######')! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 18:31:19'!
test15CurrentPieceCannotMoveAfterHittingAnotherPiece

	| game |
	
	nextPieceIds := ReadStream on: #(1 2 1).
	game := TetrisGame of: 4@6 definingNextPieceWith: self.
	
	7 timesRepeat: [ game tick ].
	game tick.
	self assert: game stringBoard equals: #(
'#-**-#'
'#-**-#'
'#***-#'
'#-*--#'
'#-**-#'
'#-**-#'
'######').
	! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 18:42:24'!
test16BottomRowIsRemovedWhenCompleted
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 5 1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceLeft.
	4 timesRepeat: [ game tick ].
	game moveCurrentPieceRight.
	game tick; tick; tick.
	
	self assert: game stringBoard equals: #(
'#-**-#'
'#-**-#'
'#----#'
'#--*-#'
'#***-#'
'######').
	! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 18:44:14'!
test17AllCompletedRowsAreRemoved
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 1 1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceLeft.
	4 timesRepeat: [ game tick ].
	game moveCurrentPieceRight.
	game tick; tick; tick; tick.
	
	self assert: game stringBoard equals: #(
'#-**-#'
'#-**-#'
'#----#'
'#----#'
'#----#'
'######').
	! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 18:56:02'!
test18NotBottomRowsCouldBeCompleted
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 2 1).
	game := TetrisGame of: 5@5 definingNextPieceWith: self.
	
	game moveCurrentPieceLeft.
	4 timesRepeat: [ game tick ].
	game moveCurrentPieceRight; moveCurrentPieceRight.
	game tick; tick; tick; tick.
	
	self assert: game stringBoard equals: #(
'#-**--#'
'#-**--#'
'#-----#'
'#-----#'
'#**-*-#'
'#######').
	! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 19:01:43'!
test19TenPointsAreAddedPerCompletedLine
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 1 1).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	self assert: 0 equals: game points.
	
	game moveCurrentPieceLeft.
	4 timesRepeat: [ game tick ].
	game moveCurrentPieceRight.
	3 timesRepeat: [ game tick ].
	game tick.
	
	self assert: 20 equals: game points
	! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 19:24:50'!
test20GameEndsWhenNewPieceIntersectsWithOccupiedPositions
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 1 1).
	game := TetrisGame of: 5@5 definingNextPieceWith: self.
	
	3 timesRepeat: [ game tick ].
	game tick; tick; tick.
	
	self assertIsOverWhen: [ game tick ].
	self assert: game isOver ! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/19/2024 16:40:44'!
test21CannotAcceptActionWhenGameIsOver
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 1 1).
	game := TetrisGame of: 5@5 definingNextPieceWith: self.
	
	6 timesRepeat: [ game tick ].
	
	self assertIsOverWhen: [ game tick ].
	self assertIsOverWhen: [ game moveCurrentPieceLeft ].
	self assertIsOverWhen: [ game moveCurrentPieceRight ].
	self assertIsOverWhen: [ game moveCurrentPieceDown ].! !

!TetrisTest methodsFor: 'testing' stamp: 'HAW 12/17/2024 19:28:50'!
test22CanMoveCurrentPieceAllTheWayDown
	
	| game |
	
	nextPieceIds := ReadStream on: #(1 2).
	game := TetrisGame of: 4@5 definingNextPieceWith: self.
	
	game moveCurrentPieceDown.
	
	self assert: game stringBoard equals: #(
'#***-#'
'#-*--#'
'#----#'
'#-**-#'
'#-**-#'
'######')! !


!TetrisTest methodsFor: 'assertions' stamp: 'HAW 12/17/2024 19:16:44'!
assertIsOverWhen: aBlock

	self 
		should: aBlock
		raise: Error
		withMessageText: TetrisGame gameIsOverErrorDescription ! !


!TetrisTest methodsFor: 'random simulation' stamp: 'HAW 12/17/2024 10:57:24'!
nextInteger: aLimit 
	
	self assert: aLimit equals: 5.
	
	^nextPieceIds next! !


!classDefinition: #TetrisGame category: #'2024-2C-Recuperatorio'!
Object subclass: #TetrisGame
	instanceVariableNames: 'extent random currentPiece occupiedPositions points over'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio'!

!TetrisGame methodsFor: 'initialization' stamp: 'HAW 12/17/2024 11:10:53'!
initialColumnFor: aTetromino
	
	^extent x - aTetromino width // 2 + 1! !

!TetrisGame methodsFor: 'initialization' stamp: 'HAW 12/19/2024 16:37:06'!
initializeOf: anExtent definingNextPieceWith: aRandom 
	
	extent := anExtent.
	random := aRandom.
	occupiedPositions := Set new.
	points := 0.
	over := false.
	
	currentPiece := self nextPiece.
! !


!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:03:32'!
addCurrentPieceToOccupiedPositions

	occupiedPositions addAll: currentPiece positions! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:03:49'!
moveDownOccupiedPositionsOver: rowNumber

	occupiedPositions := occupiedPositions collect: [ :posicion | posicion y < rowNumber 
		ifTrue: [ posicion + (0@1) ]
		ifFalse: [ posicion ]]! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 16:49:48'!
occupiedPositionsAt: rowNumber

	^occupiedPositions select: [ :position | position y = rowNumber ]! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:04:14'!
removeCompletedRows
	
	extent y to: 1 by: -1 do: [ :rowNumber | self removeIfCompleted: rowNumber ].! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:02:52'!
removeIfCompleted: rowNumber 

	| toRemove | 
	
	[ toRemove := self occupiedPositionsAt: rowNumber.
	self areAllColumnsOccupiedIn: toRemove ] whileTrue: [ 
		self incrementPoints.
		self removeOccupiedPositions: toRemove andMoveRowsDownOver: rowNumber]! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:03:08'!
removeOccupiedPositions: toRemove

	occupiedPositions removeAll: toRemove! !

!TetrisGame methodsFor: 'ticking - private' stamp: 'HAW 12/19/2024 17:03:49'!
removeOccupiedPositions: toRemove andMoveRowsDownOver: rowNumber
		
	self removeOccupiedPositions: toRemove.
	self moveDownOccupiedPositionsOver: rowNumber! !


!TetrisGame methodsFor: 'ticking' stamp: 'HAW 12/17/2024 15:39:25'!
nextPiece
	
	| nextPieceId |
	
	nextPieceId := random nextInteger: 5.
	
	nextPieceId = 1 ifTrue: [ ^Tetromino oIn: self ].
	nextPieceId = 2 ifTrue: [ ^Tetromino tIn: self ].
	nextPieceId = 3 ifTrue: [ ^Tetromino iIn: self ].
	nextPieceId = 4 ifTrue: [ ^Tetromino zIn: self ].
	nextPieceId = 5 ifTrue: [ ^Tetromino lIn: self ].
	
	self error: 'Invalid piece id'! !

!TetrisGame methodsFor: 'ticking' stamp: 'HAW 12/19/2024 17:04:20'!
tick
	
	self defineIfGameIsOver.	
	self assertIsNotOver.
	
	self cannotMoveDown 
		ifTrue: [
			self addCurrentPieceToOccupiedPositions.
			self removeCompletedRows.	
			currentPiece := self nextPiece ]
		ifFalse: [
			currentPiece moveDown ]! !


!TetrisGame methodsFor: 'over' stamp: 'HAW 12/17/2024 19:23:16'!
assertIsNotOver

	self isOver ifTrue: [ self error: self class gameIsOverErrorDescription ]! !

!TetrisGame methodsFor: 'over' stamp: 'HAW 12/19/2024 17:00:31'!
defineIfGameIsOver

	(currentPiece isAtTop and: [ currentPiece isHittingOccupiedPositions ])
		ifTrue: [ over := true ]! !


!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:46:16'!
bottomWall

	^ String new: extent x+2 withAll: $#! !

!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:55:46'!
characterRepresentationAt: position

	^((currentPiece positions includes: position) or: [ occupiedPositions includes: position ])
		ifTrue: [ $* ]
		ifFalse: [ $- ]! !

!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:46:22'!
stringBoard
	
	| rows |
	
	rows := OrderedCollection new.
	
	self writeStringBoardInto: rows.
	rows add: self bottomWall.
	
	^rows asArray.! !

!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:43:44'!
stringRowFor: aRowNumber
	
	^String streamContents: [ :stream |
		stream nextPut: $#.
		self writeBoardRow: aRowNumber into: stream.
		stream nextPut: $# ]! !

!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:45:31'!
writeBoardRow: aRowNumber into: stream

	1 to: extent x do: [ :aColumnNumber |
		stream nextPut: (self characterRepresentationAt: aColumnNumber@aRowNumber)]! !

!TetrisGame methodsFor: 'string board representation' stamp: 'HAW 12/17/2024 15:54:43'!
writeStringBoardInto: rows

	1 to: extent y do: [ :aRowNumber | rows add: (self stringRowFor: aRowNumber) ]! !


!TetrisGame methodsFor: 'testing' stamp: 'HAW 12/19/2024 17:00:02'!
areAllColumnsOccupiedIn: rowPositions 
	
	^rowPositions size = extent x! !

!TetrisGame methodsFor: 'testing' stamp: 'HAW 12/19/2024 16:58:25'!
cannotMoveDown

	^ currentPiece isAtBottom or: [ currentPiece isHittingOccupiedPositions ]! !

!TetrisGame methodsFor: 'testing' stamp: 'HAW 12/19/2024 16:57:30'!
isOccupiedAnyOf: aPositions

	^occupiedPositions includesAnyOf: aPositions ! !

!TetrisGame methodsFor: 'testing' stamp: 'HAW 12/17/2024 19:22:16'!
isOver
	
	^over! !


!TetrisGame methodsFor: 'moving current piece' stamp: 'HAW 12/19/2024 16:41:15'!
moveCurrentPieceDown
	
	| pieceToMoveDown |
	
	self assertIsNotOver.

	pieceToMoveDown := currentPiece.
	[ self tick.
	pieceToMoveDown = currentPiece ] whileTrue.! !

!TetrisGame methodsFor: 'moving current piece' stamp: 'HAW 12/17/2024 19:18:09'!
moveCurrentPieceLeft
	
	self assertIsNotOver.
	
	currentPiece moveLeft
	! !

!TetrisGame methodsFor: 'moving current piece' stamp: 'HAW 12/17/2024 19:18:23'!
moveCurrentPieceRight

	self assertIsNotOver.
	
	currentPiece moveRight! !


!TetrisGame methodsFor: 'points' stamp: 'HAW 12/19/2024 17:06:57'!
incrementPoints

	points := points + 10! !

!TetrisGame methodsFor: 'points' stamp: 'HAW 12/17/2024 18:57:51'!
points
	
	^points! !


!TetrisGame methodsFor: 'board' stamp: 'HAW 12/17/2024 11:29:13'!
numberOfColumns
	
	^extent x! !

!TetrisGame methodsFor: 'board' stamp: 'HAW 12/19/2024 16:45:05'!
numberOfRows
	
	^extent y! !


!TetrisGame methodsFor: 'as yet unclassified' stamp: 'HAW 12/19/2024 16:56:02'!
occupiedPositions
	^occupiedPositions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TetrisGame class' category: #'2024-2C-Recuperatorio'!
TetrisGame class
	instanceVariableNames: ''!

!TetrisGame class methodsFor: 'error description' stamp: 'HAW 12/17/2024 19:17:01'!
gameIsOverErrorDescription
	
	^'Game is over'! !

!TetrisGame class methodsFor: 'error description' stamp: 'HAW 12/17/2024 10:45:04'!
invalidBoardExtentErrorDescription
	
	^'Board extent must be at least 4 columns and 5 rows'! !


!TetrisGame class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 10:51:40'!
of: anExtent definingNextPieceWith: aRandom 
	
	self assertHasValidExtent: anExtent.

	^self new initializeOf: anExtent definingNextPieceWith: aRandom ! !


!TetrisGame class methodsFor: 'assertions' stamp: 'HAW 12/17/2024 10:46:23'!
assertHasValidExtent: anExtent

	(anExtent x < 4 or: [anExtent y < 5]) 
		ifTrue: [ self error: self invalidBoardExtentErrorDescription ]! !


!classDefinition: #Tetromino category: #'2024-2C-Recuperatorio'!
Object subclass: #Tetromino
	instanceVariableNames: 'position game width offsets'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Recuperatorio'!

!Tetromino methodsFor: 'initialization' stamp: 'HAW 12/17/2024 15:35:56'!
initializeWidth: aWidth offsets: anOffsets in: aTetrisGame 
	
	width := aWidth.
	offsets := anOffsets.
	game := aTetrisGame.
	position := (aTetrisGame initialColumnFor: self)@1! !


!Tetromino methodsFor: 'dimention' stamp: 'HAW 12/17/2024 15:28:18'!
maxColumnPosition

	^ game numberOfColumns - self width + 1! !

!Tetromino methodsFor: 'dimention' stamp: 'HAW 12/17/2024 15:34:28'!
width

	^width ! !


!Tetromino methodsFor: 'testing' stamp: 'HAW 12/19/2024 16:44:54'!
isAtBottom

	^ self positions anySatisfy: [ :aPosition | aPosition y = game numberOfRows ]! !

!Tetromino methodsFor: 'testing' stamp: 'HAW 12/17/2024 19:10:14'!
isAtTop
	
	^position y = 1! !

!Tetromino methodsFor: 'testing' stamp: 'HAW 12/19/2024 16:57:44'!
isHittingOccupiedPositions

	^ game isOccupiedAnyOf: self nextPositionsGoingDown.! !


!Tetromino methodsFor: 'actions' stamp: 'HAW 12/17/2024 15:26:20'!
moveDown
	
	position := position + (0@1)! !

!Tetromino methodsFor: 'actions' stamp: 'HAW 12/19/2024 17:10:12'!
moveLeft
	
	| newColumn |
	
	newColumn := position x - 1 max: 1.
	position := newColumn@position y! !

!Tetromino methodsFor: 'actions' stamp: 'HAW 12/17/2024 15:28:31'!
moveRight
	
	| newColumn |
	
	newColumn := position x + 1 min: self maxColumnPosition.
	position := newColumn@position y! !


!Tetromino methodsFor: 'positions' stamp: 'HAW 12/19/2024 16:39:28'!
nextPositionsGoingDown

	^ self positions collect: [ :aPosition | aPosition + (0@1) ]! !

!Tetromino methodsFor: 'positions' stamp: 'HAW 12/17/2024 15:35:24'!
positions

	^(Set with: position) 
		addAll: (offsets collect: [ :anOffset | position + anOffset ]);
		yourself ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tetromino class' category: #'2024-2C-Recuperatorio'!
Tetromino class
	instanceVariableNames: ''!

!Tetromino class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 15:38:12'!
iIn: aTetrisGame 
	
	^self width: 1 offsets: (Array with: 0@1 with: 0@2 with: 0@3) in: aTetrisGame ! !

!Tetromino class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 15:40:25'!
lIn: aTetrisGame 
	
	^self width: 2 offsets: (Array with: 0@1 with: 0@2 with:1@2)  in: aTetrisGame ! !

!Tetromino class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 15:31:47'!
oIn: aTetrisGame 
	
	^self width: 2 offsets: (Array with: 1@0 with: 0@1 with: 1@1) in: aTetrisGame ! !

!Tetromino class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 15:37:09'!
tIn: aTetrisGame 
	
	^self width: 3 offsets: (Array with: 1@0 with: 2@0 with: 1@1) in: aTetrisGame ! !

!Tetromino class methodsFor: 'instance creation' stamp: 'HAW 12/17/2024 15:39:15'!
zIn: aTetrisGame 
	
	^self width: 3 offsets: (Array with: 1@0 with: 1@1 with: 2@1) in: aTetrisGame ! !


!Tetromino class methodsFor: 'instance creation - private' stamp: 'HAW 12/17/2024 15:32:12'!
width: aWidth offsets: anOffsets in: aTetrisGame 
	
	^self new initializeWidth: aWidth offsets: anOffsets in: aTetrisGame ! !
