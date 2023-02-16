!classDefinition: #Super4EnLinesTest category: 'Super4EnLinea'!
TestCase subclass: #Super4EnLinesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Super4EnLinea'!

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:54:44'!
test01BoardStartsEmpty

	| game |
	game := Super4EnLinea winningVertically.
	
	1 to: 7 do: [ :column | 1 to: 6 do: [ :line | self assert: (game isEmptyAt: column@line) ]]! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:55:07'!
test02BoardIsNotEmptyAfterAddingAChip

	| game |
	
	game := Super4EnLinea winningVertically.
	game addChipToColumn: 1.
	
	self deny: (game isEmptyAt: 1@1).
	self assert: (game isRedAt: 1@1).
	self deny: (game isYellowAt: 1@1).! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:55:27'!
test03BoardIsNotEmptyAddingASecondChip

	| game |
	
	game := Super4EnLinea winningVertically.
	game addChipToColumn: 1.
	game addChipToColumn: 1 .
	
	self deny: (game isEmptyAt: 1@2).
	self deny: (game isRedAt: 1@2).
	self assert: (game isYellowAt: 1@2).! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:55:49'!
test04DoesNotHaveEitherChipWhenEmpty

	| game |
	
	game := Super4EnLinea winningVertically.
	
	self assert: (game isEmptyAt: 1@1).
	self deny: (game isRedAt: 1@1).
	self deny: (game isYellowAt: 1@1).! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:56:09'!
test05ChipsCanBeAddedToAnyColumn

	| game |
	
	game := Super4EnLinea winningVertically.
	game addChipToColumn: 2.
	
	self deny: (game isEmptyAt: 2@1).
	self assert: (game isRedAt: 2@1).
	self deny: (game isYellowAt: 2@1).! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:56:24'!
test06ColumnNumberCanNotBeLessThanOne

	| game |
	
	game := Super4EnLinea winningVertically.
	
	self 
		should: [ game addChipToColumn: 0 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Super4EnLinea invalidColumnNumberErrorDescription equals: anError messageText.
			self assert: game isEmpty ]! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:56:38'!
test07ColumnNumberCannotBeGreatherThanSeven

	| game |
	
	game := Super4EnLinea winningVertically.
	
	self 
		should: [ game addChipToColumn: 8 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Super4EnLinea invalidColumnNumberErrorDescription equals: anError messageText.
			self assert: game isEmpty ]! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:56:45'!
test08ColumnNumberMustBeInteger

	| game |
	
	game := Super4EnLinea winningVertically.
	
	self 
		should: [ game addChipToColumn: 1.1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Super4EnLinea invalidColumnNumberErrorDescription equals: anError messageText.
			self assert: game isEmpty ]! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:57:03'!
test09CannotAddMoreThanSixChipsPerColumn

	| game |
	
	game := Super4EnLinea winningVertically.
	6 timesRepeat: [ game addChipToColumn: 1 ].
	
	self 
		should: [ game addChipToColumn: 1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Super4EnLinea columnIsFullErrorDescription equals: anError messageText.
			self assert: 6 equals: (game numberOfChipsInColumn: 1) ]! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:57:29'!
test10IsOverWhenHasFourChipsVertically

	| game |
	
	game := Super4EnLinea winningVertically.
	3 timesRepeat: [ 
		game addChipToColumn: 1. 
		game addChipToColumn: 2].
	
	game addChipToColumn: 1.
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:57:48'!
test11GameIsNotOverWhenJustStarted

	| game |
	
	game := Super4EnLinea winningVertically.
	
	self deny: game isOver.
	self deny: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:58:14'!
test12GameIsNotOverWhenDoesNotMeetWinningStrategy

	| game |
	
	game := Super4EnLinea winningVertically.
	game addChipToColumn: 1. 
	
	self deny: game isOver.
	self deny: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:58:53'!
test13IsOverWhenHasFourChipsHorizontallyStartingOnFirstColumn

	| game |
	
	game := Super4EnLinea winningHorizontally.
	game addChipToColumn: 1.
	game addChipToColumn: 5.
	game addChipToColumn: 2.
	game addChipToColumn: 6.
	game addChipToColumn: 3.
	game addChipToColumn: 7.
	game addChipToColumn: 4.	
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:59:10'!
test14IsOverWhenHasFourChipsHorizontallyStargingOnAnyColumn

	| game |
	
	game := Super4EnLinea winningHorizontally.
	game addChipToColumn: 2.
	game addChipToColumn: 6.
	game addChipToColumn: 3.
	game addChipToColumn: 6.
	game addChipToColumn: 4.
	game addChipToColumn: 6.
	game addChipToColumn: 5.	
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:59:34'!
test15IsOverWhenHasFourChipsInGoingUpDiagonal

	| game |
	
	game := Super4EnLinea winningDiagonally.
	game addChipToColumn: 1.
	game addChipToColumn: 2.
	
	game addChipToColumn: 2.
	game addChipToColumn: 3.
	
	game addChipToColumn: 2.
	game addChipToColumn: 3.
	
	game addChipToColumn: 3.	
	game addChipToColumn: 4.
	
	game addChipToColumn: 3.	
	game addChipToColumn: 4.	
	
	game addChipToColumn: 3.	
	game addChipToColumn: 4.	
	
	game addChipToColumn: 4.	
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 17:59:56'!
test16IsOverWhenHasFourChipsInGoingDownDiagonal

	| game |
	
	game := Super4EnLinea winningDiagonally.
	game addChipToColumn: 4.
	game addChipToColumn: 3.
	
	game addChipToColumn: 3.
	game addChipToColumn: 2.
	
	game addChipToColumn: 3.
	game addChipToColumn: 2.
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.	
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.	
	
	game addChipToColumn: 1.	
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 18:00:52'!
test17CanWinWithAnyWinningStratey

	| game |
	
	game := Super4EnLinea winningComposing: { Super4EnLinea diagonalWinningStrategy. Super4EnLinea horizontalWinningStrategy }.
	game addChipToColumn: 4.
	game addChipToColumn: 3.
	
	game addChipToColumn: 3.
	game addChipToColumn: 2.
	
	game addChipToColumn: 3.
	game addChipToColumn: 2.
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.	
	
	game addChipToColumn: 2.	
	game addChipToColumn: 1.	
	
	game addChipToColumn: 1.	
	
	self assert: game isOver.
	self assert: game hasRedWon.
	self deny: game hasYellowWon.! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 18:01:37'!
test18DoesNotWinIfNoComposingStrategyWins

	| game |
	
	game := Super4EnLinea winningComposing: { Super4EnLinea horizontalWinningStrategy. Super4EnLinea diagonalWinningStrategy }.
	3 timesRepeat: [ 
		game addChipToColumn: 1. 
		game addChipToColumn: 2].
	
	game addChipToColumn: 1.
	
	self deny: game isOver.
	! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 18:01:47'!
test19YellowColorCanWin

	| game |
	
	game := Super4EnLinea winningVertically.
	3 timesRepeat: [ 
		game addChipToColumn: 1. 
		game addChipToColumn: 2].
	
	game addChipToColumn: 3.
	game addChipToColumn: 2.
	
	self assert: game isOver.
	self deny: game hasRedWon.
	self assert: game hasYellowWon ! !

!Super4EnLinesTest methodsFor: 'testing' stamp: 'HAW 2/16/2023 18:01:58'!
test20CannotPlayWhenGameIsOver

	| game |
	
	game := Super4EnLinea winningVertically.
	3 timesRepeat: [ 
		game addChipToColumn: 1. 
		game addChipToColumn: 2].
	
	game addChipToColumn: 1.

	self 
		should: [ game addChipToColumn: 2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Super4EnLinea cannotPlayErrorDescription equals: anError messageText.
			self assert: game hasRedWon.
			self deny: game hasYellowWon ]! !


!classDefinition: #Super4EnLinea category: 'Super4EnLinea'!
Object subclass: #Super4EnLinea
	instanceVariableNames: 'columns colors winner winnigStrategy'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Super4EnLinea'!

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:14:24'!
hasDiagonalDown: aColor
	
	1 to: 4 do: [:x |
		6 to: 4 by: -1 do: [ :y | | hasDiagonal |
			hasDiagonal := (0 to: 3) allSatisfy: [ :displacement | (self colorAt: x+displacement @(y-displacement ) ifEmpty: [nil]) = aColor ].
			hasDiagonal ifTrue: [ ^true ]]].

	^false! !

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:12:28'!
hasDiagonalUp: aColor 
	
	1 to: 4 do: [:x |
		1 to: 3 do: [ :y | | hasDiagonal |
			hasDiagonal := (0 to: 3) allSatisfy: [ :displacement | (self colorAt: x+displacement @(y+displacement ) ifEmpty: [nil]) = aColor ].
			hasDiagonal ifTrue: [ ^true ]]].

	^false! !

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:44:00'!
hasWin: aColor diagonallyAddingTo: aColumn  
	
	^(self hasDiagonalUp: aColor) or: [ self hasDiagonalDown: aColor ]! !

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:47:46'!
hasWin: aColor horizontallyAddingTo: aColumn 
 
	| y consecutiveColor |
	
	y := aColumn size.
	consecutiveColor := 0.
	columns do: [ :column  | 
			(column at: y ifAbsent: [ nil ]) = aColor 
				ifTrue: [ consecutiveColor := consecutiveColor + 1 ]
				ifFalse: [ 0 ].
			consecutiveColor = 4 ifTrue: [ ^true ]].
			
	^false! !

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:44:37'!
hasWin: aColor verticallyAddingTo: aColumn  
	
	| last4 |
	
	last4 := aColumn lastAvailable: 4.
	^last4 size = 4 and: [ last4 allSatisfy: [ :stackedColor | stackedColor = aColor ]].
	
	! !

!Super4EnLinea methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:45:29'!
hasWon: aColor addingTo: aColumn 
 
	^winnigStrategy value: self value: aColor value: aColumn  ! !


!Super4EnLinea methodsFor: 'initialization' stamp: 'HAW 2/16/2023 17:47:07'!
initializeWinnigStrategy: aWinningStrategy 
	
	winnigStrategy := aWinningStrategy.
	columns := (1 to: 7) collect: [ :index | OrderedCollection new ].
	colors := CircularReadStream on: #(#red #yellow) moving: NullUnit new.
	winner := nil! !


!Super4EnLinea methodsFor: 'playing' stamp: 'HAW 2/16/2023 17:49:34'!
addChipToColumn: aColumnNumber 

	| column currentColor |
	
	self assertIsNotOver.
	column := self columnAt: aColumnNumber.
	self assertIsNotFull: column.
	
	currentColor := colors current.
	column add: currentColor.
	
	(self hasWon: currentColor addingTo: column )
		ifTrue: [ winner := currentColor ]
		ifFalse: [ colors next ]
	! !

!Super4EnLinea methodsFor: 'playing' stamp: 'HAW 2/16/2023 17:49:34'!
assertIsNotFull: column

	^ column size = 6 ifTrue: [ self error: self class columnIsFullErrorDescription ]! !

!Super4EnLinea methodsFor: 'playing' stamp: 'HAW 2/16/2023 17:49:14'!
assertIsNotOver

	^ self isOver ifTrue: [ self error: self class cannotPlayErrorDescription ]! !


!Super4EnLinea methodsFor: 'colors' stamp: 'HAW 2/15/2023 19:29:02'!
colorAt: aPosition ifEmpty: whenEmptyBlock
 
	^(self columnAt: aPosition x)
		at: aPosition y 
		ifAbsent: [ ^whenEmptyBlock value ]! !

!Super4EnLinea methodsFor: 'colors' stamp: 'HAW 2/16/2023 17:51:43'!
isRedAt: aPosition
 
	^(self colorAt: aPosition ifEmpty: [ nil ])  = #red! !

!Super4EnLinea methodsFor: 'colors' stamp: 'HAW 2/16/2023 17:51:52'!
isYellowAt: aPosition

	^(self colorAt: aPosition ifEmpty: [ nil ])  = #yellow! !


!Super4EnLinea methodsFor: 'teting board' stamp: 'HAW 2/15/2023 19:17:52'!
isEmpty
	
	^columns allSatisfy: [ :aColumn | aColumn isEmpty ]! !

!Super4EnLinea methodsFor: 'teting board' stamp: 'HAW 2/15/2023 19:29:24'!
isEmptyAt: aPosition 
	
	^(self columnAt: aPosition x) size < aPosition y! !


!Super4EnLinea methodsFor: 'testing winner' stamp: 'HAW 2/16/2023 17:51:07'!
hasRedWon
	
	^winner = #red! !

!Super4EnLinea methodsFor: 'testing winner' stamp: 'HAW 2/16/2023 17:51:18'!
hasYellowWon
	
	^winner = #yellow! !

!Super4EnLinea methodsFor: 'testing winner' stamp: 'HAW 2/16/2023 08:30:29'!
isOver
	
	^winner notNil ! !


!Super4EnLinea methodsFor: 'columns' stamp: 'HAW 2/15/2023 19:28:27'!
columnAt: aColumnNumber 

	(aColumnNumber isInteger and: (aColumnNumber between: 1 and: 7)) ifFalse: [ self error: self class invalidColumnNumberErrorDescription ].
	
	^columns at: aColumnNumber.
	! !

!Super4EnLinea methodsFor: 'columns' stamp: 'HAW 2/15/2023 19:29:38'!
numberOfChipsInColumn: aColumnNumber
 
	^(self columnAt: aColumnNumber) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Super4EnLinea class' category: 'Super4EnLinea'!
Super4EnLinea class
	instanceVariableNames: ''!

!Super4EnLinea class methodsFor: 'error descriptions' stamp: 'HAW 2/16/2023 17:43:15'!
cannotPlayErrorDescription
	
	^'Cannot play because the game is over'! !

!Super4EnLinea class methodsFor: 'error descriptions' stamp: 'HAW 2/15/2023 19:27:05'!
columnIsFullErrorDescription
	
	^'Column is full'! !

!Super4EnLinea class methodsFor: 'error descriptions' stamp: 'HAW 2/15/2023 19:16:52'!
invalidColumnNumberErrorDescription
	
	^'Column number must be an integer between 1 and 7'! !


!Super4EnLinea class methodsFor: 'instance creation' stamp: 'HAW 2/16/2023 15:26:43'!
winnigStrategy: aWinningStrategy
 
	^self new initializeWinnigStrategy: aWinningStrategy
! !

!Super4EnLinea class methodsFor: 'instance creation' stamp: 'HAW 2/16/2023 17:18:20'!
winningComposing: aCollectionOfStrategies

	^self winnigStrategy: (self composingStrategies: aCollectionOfStrategies)! !

!Super4EnLinea class methodsFor: 'instance creation' stamp: 'HAW 2/16/2023 16:54:34'!
winningDiagonally
	
	^self winnigStrategy: self diagonalWinningStrategy ! !

!Super4EnLinea class methodsFor: 'instance creation' stamp: 'HAW 2/16/2023 15:24:18'!
winningHorizontally
	
	^self winnigStrategy: self horizontalWinningStrategy! !

!Super4EnLinea class methodsFor: 'instance creation' stamp: 'HAW 2/16/2023 16:47:10'!
winningVertically
	
	^self winnigStrategy: self verticalWinningStrategy! !


!Super4EnLinea class methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:45:40'!
composingStrategies: aCollectionOfStrategies 
	
	^[ :game :color :column  | 
		aCollectionOfStrategies anySatisfy: [ :aStrategy | aStrategy value: game value: color value: column ]]! !

!Super4EnLinea class methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:45:47'!
diagonalWinningStrategy
	
	^[ :game :color :column | game hasWin: color diagonallyAddingTo: column ]! !

!Super4EnLinea class methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:45:52'!
horizontalWinningStrategy
	
	^[ :game :color :column | game hasWin: color horizontallyAddingTo: column ]! !

!Super4EnLinea class methodsFor: 'winning strategies' stamp: 'HAW 2/16/2023 17:45:57'!
verticalWinningStrategy
	
	^[ :game :color :column | game hasWin: color verticallyAddingTo: column ]! !
