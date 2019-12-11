!classDefinition: #TowersGameTest category: #'Chess-IS1-2Recu-2c2019'!
TestCase subclass: #TowersGameTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:31:25'!
test01NewGamePutWhiteTowersIrRightPosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self assert: (towersGame isWhiteTowerAt: 1@1).
	self assert: (towersGame isWhiteTowerAt: 7@1).! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:35:05'!
test02WhiteTowersDoNotStartInOtherPosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self deny: (towersGame isWhiteTowerAt: 2@1).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:35:53'!
test03NewGamePutBlackTowersIrRightPosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self assert: (towersGame isBlackTowerAt: 2@8).
	self assert: (towersGame isBlackTowerAt: 8@8).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:37:20'!
test04BlackTowersDoNotStartInOtherPosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self deny: (towersGame isBlackTowerAt: 2@1).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:38:03'!
test05BlackTowersAreNotInWhiteTowersPositions

	| towersGame |
	
	towersGame := TowersGame new.
	
	self deny: (towersGame isBlackTowerAt: 1@1).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:39:27'!
test06WhiteTowersAreNotInBlackTowersPositions

	| towersGame |
	
	towersGame := TowersGame new.
	
	self deny: (towersGame isWhiteTowerAt: 2@8).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 18:20:59'!
test07TowerCanMoveHorizontally

	| towersGame |
	
	towersGame := TowersGame new.
	
	towersGame move: 1@1 to: 2@1.
	
	self assert: (towersGame isWhiteTowerAt: 2@1).
	self deny: (towersGame isWhiteTowerAt: 1@1).
	
	self deny: towersGame hasWhiteWon.
	self deny: towersGame isWhiteTurn.
	self assert: towersGame isBlackTurn.
	self deny: towersGame hasBlackWon.

	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:49:42'!
test08TowerCanOnlyMoveHorizontallyAndVertically

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [ towersGame move: 1@1 to: 2@2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: towersGame towersCanOnlyMoveHorizontallyOrVerticallyErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self deny: (towersGame isWhiteTowerAt: 2@2) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:49:22'!
test09TowerCanMoveVertically

	| towersGame |
	
	towersGame := TowersGame new.
	
	towersGame move: 1@1 to: 1@2.
	
	self assert: (towersGame isWhiteTowerAt: 1@2).
	self deny: (towersGame isWhiteTowerAt: 1@1)
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:00:29'!
test10CanNotMoveOutsideXLimit

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 9@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotMoveOutsideBoardErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 9@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:00:18'!
test11CanNotMoveOutsideXStart

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 0@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotMoveOutsideBoardErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 0@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:00:06'!
test12CanNotMoveOutsideYLimit

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 1@9 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotMoveOutsideBoardErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 1@9) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:59:55'!
test13CanNotMoveOutsideYStart

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 1@0 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotMoveOutsideBoardErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 1@0) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 10:57:24'!
test14CanNotMoveFromEmptyPosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 2@1 to: 3@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame thereIsNoTowerToMoveErrorDescription equals: anError messageText.
			self assert: (towersGame isFreeAt: 2@1).
			self assert: (towersGame isFreeAt: 3@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:01:41'!
test15TargetPositionMustHaveIntegerX

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 1.1@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame invalidTargetPositionErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:03:20'!
test16TargetPositionMustHaveIntegerY

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 1@1.1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame invalidTargetPositionErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:12:19'!
test17CanNotJumpOverATowerWhenMovingHorizontallyToTheRight

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 8@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotJumpTowerErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 8@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 15:49:38'!
test18CanNotJumpOverATowerWhenMovingHorizontallyToTheLeft

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 2@1.
	
	self 
		should: [towersGame move: 8@8 to: 1@8 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotJumpTowerErrorDescription equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 8@8).
			self assert: (towersGame isFreeAt: 1@8) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:12:58'!
test19CanNotMoveToSamePosition

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [towersGame move: 1@1 to: 1@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotMoveToSamePosition equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:16:08'!
test20CanNotJumpOverATowerWhenMovingUpVertically

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 2@1.
	towersGame move: 2@8 to: 2@7.
	
	self 
		should: [towersGame move: 2@1 to: 2@8 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotJumpTowerErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 2@1).
			self assert: (towersGame isFreeAt: 2@8) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:20:46'!
test21CanNotJumpOverATowerWhenMovingDownVertically

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@2.
	towersGame move: 2@8 to: 1@8.
	towersGame move: 7@1 to: 8@1.
	
	self 
		should: [towersGame move: 1@8 to: 1@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame canNotJumpTowerErrorDescription equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 1@8).
			self assert: (towersGame isFreeAt: 1@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 18:22:56'!
test22BlackCanNotMoveFirst

	| towersGame |
	
	towersGame := TowersGame new.
	
	self deny: towersGame hasWhiteWon.
	self assert: towersGame isWhiteTurn.
	self deny: towersGame isBlackTurn.
	self deny: towersGame hasBlackWon.

	self 
		should: [towersGame move: 2@8 to: 1@8 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame itIsWhiteTurnErrorDescription equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 2@8).
			self assert: (towersGame isFreeAt: 1@8) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 11:43:43'!
test23WhiteCanNotMoveAfterWhite

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@2.
	
	self 
		should: [towersGame move: 1@2 to: 1@1 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame itIsBlackTurnErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@2).
			self assert: (towersGame isFreeAt: 1@1) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 18:17:37'!
test24WhiteWinsWhenTowersAreAtWinningPositions

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 4@1.
	towersGame move: 2@8 to: 1@8.
	towersGame move: 4@1 to: 4@4.
	towersGame move: 1@8 to: 2@8.
	towersGame move: 7@1 to: 5@1.
	towersGame move: 2@8 to: 1@8.
	towersGame move: 5@1 to: 5@5.
	
	self 
		should: [towersGame move: 1@8 to: 2@8 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame whiteHasWonErrorDescription equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 1@8).
			self assert: (towersGame isFreeAt: 2@8) ].
		
	self assert: towersGame hasWhiteWon.
	self deny: towersGame isWhiteTurn.
	self deny: towersGame isBlackTurn.
	self deny: towersGame hasBlackWon.
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 15:05:44'!
test25BlackCanNotMoveAfterBlack

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@2.
	towersGame move: 2@8 to: 1@8.
	
	self 
		should: [towersGame move: 1@8 to: 2@8 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame itIsWhiteTurnErrorDescription equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 1@8).
			self assert: (towersGame isFreeAt: 2@8) ]
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 18:19:26'!
test26BlackWinsWhenTowersAreAtWinningPositions

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@2.
	towersGame move: 2@8 to: 4@8.
	towersGame move: 1@2 to: 1@1.
	towersGame move: 4@8 to: 4@5.
	towersGame move: 1@1 to: 1@2.
	towersGame move: 8@8 to: 5@8.
	towersGame move: 1@2 to: 1@1.
	towersGame move: 5@8 to: 5@4.
	
	self 
		should: [towersGame move: 1@1 to: 1@2 ]
		raise: Error -MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: towersGame blackHasWonErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1).
			self assert: (towersGame isFreeAt: 1@2) ].
		
	self deny: towersGame hasWhiteWon.
	self deny: towersGame isWhiteTurn.
	self deny: towersGame isBlackTurn.
	self assert: towersGame hasBlackWon.

	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:20:30'!
test27BlackTowerReturnsToOriginalPositionWhenEaten

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 2@8 to: 3@8.
	towersGame move: 1@8 to: 3@8.
	
	self assert: (towersGame isWhiteTowerAt: 3@8).
	self assert: (towersGame isBlackTowerAt: 2@8) 
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:21:52'!
test28WhiteTowerReturnsToOriginalPositionWhenEaten

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 3@1.
	towersGame move: 2@8 to: 2@1.
	towersGame move: 7@1 to: 8@1.
	towersGame move: 2@1 to: 3@1.
	
	self assert: (towersGame isBlackTowerAt: 3@1).
	self assert: (towersGame isWhiteTowerAt: 1@1) 
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:34:19'!
test30WhenOriginalPositionIsNotFreeMovesToNextFreePositionToTheRightTowardsCenter

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 8@8 to: 7@8.
	towersGame move: 1@8 to: 2@8.
	
	self assert: (towersGame isWhiteTowerAt: 2@8).
	self assert: (towersGame isBlackTowerAt: 3@8) 
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:32:22'!
test31WhenOriginalPositionIsNotFreeMovesToNextFreePositionToTheLeftTowardsCenter

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 2@1.
	towersGame move: 8@8 to: 8@1.
	towersGame move: 2@1 to: 3@1.
	towersGame move: 8@1 to: 7@1.
	
	self assert: (towersGame isWhiteTowerAt: 6@1).
	self assert: (towersGame isBlackTowerAt: 7@1) 
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:49:46'!
test32CanNotMoveMoreThatThreeYPositionsWhenEaten

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 2@8 to: 3@8.
	towersGame move: 1@8 to: 3@8.
	
	self 
		should: [ towersGame move: 2@8 to: 2@4 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TowersGame canNotMoveMoreThanThreePositions equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 2@8).
			self assert: (towersGame isFreeAt: 6@8).
			self assert: towersGame isBlackTurn ]! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:48:24'!
test33CanMoveThreeOrLessPositionsWhenEaten

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 2@8 to: 3@8.
	towersGame move: 1@8 to: 3@8.
	towersGame move: 2@8 to: 2@5.
	
	self assert: (towersGame isBlackTowerAt: 2@5).
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 16:51:21'!
test34CanNotMoveMoreThatThreeXPositionsWhenEaten

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 2@8 to: 3@8.
	towersGame move: 1@8 to: 3@8.
	towersGame move: 8@8 to: 8@7.
	towersGame move: 3@8 to: 3@7.
	
	self 
		should: [ towersGame move: 2@8 to: 6@8 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: TowersGame canNotMoveMoreThanThreePositions equals: anError messageText.
			self assert: (towersGame isBlackTowerAt: 2@8).
			self assert: (towersGame isFreeAt: 6@8).
			self assert: towersGame isBlackTurn ]! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 17:02:20'!
test35CanMoveMoreThanThreePositionsAfterFourMovements

	| towersGame |
	
	towersGame := TowersGame new.
	towersGame move: 1@1 to: 1@8.
	towersGame move: 2@8 to: 3@8.
	towersGame move: 1@8 to: 3@8.
	towersGame move: 2@8 to: 2@7. "1"
	towersGame move: 3@8 to: 4@8.
	towersGame move: 2@7 to: 2@6. "2"
	towersGame move: 4@8 to: 5@8.
	towersGame move: 2@6 to: 2@5. "3"
	towersGame move: 5@8 to: 6@8.
	towersGame move: 2@5 to: 2@6. "4"
	towersGame move: 6@8 to: 7@8.
	towersGame move: 2@6 to: 2@1.
	
	self assert: (towersGame isBlackTowerAt: 2@1)
	! !

!TowersGameTest methodsFor: 'tests' stamp: 'HAW 12/10/2019 17:55:48'!
test36CanNotEatATowerOfSameColor

	| towersGame |
	
	towersGame := TowersGame new.
	
	self 
		should: [ towersGame move: 1@1 to: 7@1 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: towersGame canNotEatTowerOfSameColorErrorDescription equals: anError messageText.
			self assert: (towersGame isWhiteTowerAt: 1@1) ]
		
			
	
	! !


!classDefinition: #Tower category: #'Chess-IS1-2Recu-2c2019'!
Object subclass: #Tower
	instanceVariableNames: 'originalPosition state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!Tower methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:44:10'!
assertCanMoveFrom: aSourcePosition to: aTargetPosition.
	
	state assertCanMoveFrom: aSourcePosition to: aTargetPosition.
	! !

!Tower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:45:06'!
moveOnBlackTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame 

	self subclassResponsibility ! !

!Tower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:45:19'!
moveOnWhiteTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame

	self subclassResponsibility ! !

!Tower methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:56:38'!
moved
	
	state moved! !

!Tower methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:40:59'!
startLimitedMovingState
	
	state := LimitedMovingState for: self! !


!Tower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:44:51'!
isBlack

	self subclassResponsibility ! !

!Tower methodsFor: 'testing' stamp: 'HAW 12/10/2019 17:56:28'!
isSameColorAs: aTower 
	
	self subclassResponsibility ! !

!Tower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:44:54'!
isWhite

	self subclassResponsibility ! !


!Tower methodsFor: 'original position' stamp: 'HAW 12/10/2019 16:25:05'!
originalPosition
	
	^originalPosition ! !


!Tower methodsFor: 'initialization' stamp: 'HAW 12/10/2019 16:46:25'!
initializeAtOriginalPosition: aPosition 
	
	originalPosition := aPosition.
	state := NormalMovingState for: self! !


!Tower methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:02:39'!
movedWhenLimitedMovingStateTimes: aNumberOfMovements

	aNumberOfMovements >= 4 ifTrue: [ state := NormalMovingState for: self ]! !

!Tower methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 16:57:26'!
movedWhenOnNormalMovingState
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tower class' category: #'Chess-IS1-2Recu-2c2019'!
Tower class
	instanceVariableNames: ''!

!Tower class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 16:24:31'!
atOriginalPosition: aPosition 
	
	^self new initializeAtOriginalPosition: aPosition ! !


!classDefinition: #BlackTower category: #'Chess-IS1-2Recu-2c2019'!
Tower subclass: #BlackTower
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!BlackTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:37:16'!
isBlack
	
	^true! !

!BlackTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 17:54:58'!
isSameColorAs: aTower

	^aTower isBlack! !

!BlackTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:33:36'!
isWhite
	
	^false! !


!BlackTower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:35:21'!
moveOnBlackTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame 
	
	aTowersGame moveBlackTower: self onBlackTurnFrom: aSourcePosition to: aTargetPosition ! !

!BlackTower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:37:56'!
moveOnWhiteTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame

	aTowersGame moveBlackTower: self onWhiteTurnFrom: aSourcePosition to: aTargetPosition ! !


!classDefinition: #WhiteTower category: #'Chess-IS1-2Recu-2c2019'!
Tower subclass: #WhiteTower
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!WhiteTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:33:27'!
isBlack
	
	^false! !

!WhiteTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 17:54:14'!
isSameColorAs: aTower 
	
	^aTower isWhite ! !

!WhiteTower methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:32:21'!
isWhite
	
	^true! !


!WhiteTower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:36:42'!
moveOnBlackTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame 
	
	aTowersGame moveWhiteTower: self onBlackTurnFrom: aSourcePosition to: aTargetPosition ! !

!WhiteTower methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:30:07'!
moveOnWhiteTurnFrom: aSourcePosition to: aTargetPosition in: aTowersGame 
	
	aTowersGame moveWhiteTower: self onWhiteTurnFrom: aSourcePosition to: aTargetPosition ! !


!classDefinition: #TowerGameState category: #'Chess-IS1-2Recu-2c2019'!
Object subclass: #TowerGameState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!TowerGameState methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:55:45'!
move: aTower from: aSourcePosition to: aTargetPosition 

	self subclassResponsibility ! !


!TowerGameState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:23:46'!
hasBlackWon

	self subclassResponsibility ! !

!TowerGameState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:23:54'!
hasWhiteWon

	self subclassResponsibility ! !

!TowerGameState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:46:05'!
isBlackTurn

	self subclassResponsibility ! !

!TowerGameState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:46:08'!
isWhiteTurn

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TowerGameState class' category: #'Chess-IS1-2Recu-2c2019'!
TowerGameState class
	instanceVariableNames: ''!

!TowerGameState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 15:16:35'!
stateFor: aTowersGame 
	
	^self subclasses
		detect: [ :aStateClass | aStateClass isFor: aTowersGame ]
		ifFound: [ :aStateClass | aStateClass for: aTowersGame ]
		ifNone: [ self shouldNotHappen ]! !


!classDefinition: #BlackTurnState category: #'Chess-IS1-2Recu-2c2019'!
TowerGameState subclass: #BlackTurnState
	instanceVariableNames: 'towersGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!BlackTurnState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 11:40:57'!
initializeFor: aTowersGame 
	
	towersGame := aTowersGame.! !


!BlackTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:21:22'!
hasBlackWon
	
	^false! !

!BlackTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:21:09'!
hasWhiteWon
	
	^false! !

!BlackTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:20:18'!
isBlackTurn
	
	^true! !

!BlackTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:19:28'!
isWhiteTurn
	
	^false! !


!BlackTurnState methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:57:29'!
move: aTower from: aSourcePosition to: aTargetPosition 
	
	^aTower moveOnBlackTurnFrom: aSourcePosition to: aTargetPosition in: towersGame 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BlackTurnState class' category: #'Chess-IS1-2Recu-2c2019'!
BlackTurnState class
	instanceVariableNames: ''!

!BlackTurnState class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 11:40:48'!
for: aTowersGame 
	
	^self new initializeFor: aTowersGame ! !


!BlackTurnState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 15:22:23'!
isFor: aTowersGame 
	
	^aTowersGame isWhiteTurn and: [ (WhiteWonState isFor: aTowersGame) not ]
	! !


!classDefinition: #BlackWonState category: #'Chess-IS1-2Recu-2c2019'!
TowerGameState subclass: #BlackWonState
	instanceVariableNames: 'towersGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!BlackWonState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 15:11:01'!
initializeFor: aTowersGame 
	
	towersGame := aTowersGame.! !


!BlackWonState methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:55:45'!
move: aTower from: aSourcePosition to: aTargetPosition 
	
	^towersGame moveWhenBlackWonFrom: aSourcePosition to: aTargetPosition ! !


!BlackWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:19:59'!
hasBlackWon
	
	^true! !

!BlackWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:19:33'!
hasWhiteWon
	
	^false! !

!BlackWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:19:52'!
isBlackTurn
	
	^false! !

!BlackWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:19:45'!
isWhiteTurn
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BlackWonState class' category: #'Chess-IS1-2Recu-2c2019'!
BlackWonState class
	instanceVariableNames: ''!

!BlackWonState class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 15:10:54'!
for: aTowersGame 
	
	^self new initializeFor: aTowersGame ! !


!BlackWonState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 15:19:00'!
isFor: aTowersGame 
	
	^(aTowersGame isBlackTowerAt: 4@5) and: [ aTowersGame isBlackTowerAt: 5@4 ]! !


!classDefinition: #WhiteTurnState category: #'Chess-IS1-2Recu-2c2019'!
TowerGameState subclass: #WhiteTurnState
	instanceVariableNames: 'towersGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!WhiteTurnState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 11:35:49'!
initializeFor: aTowersGame 
	
	towersGame := aTowersGame.! !


!WhiteTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:23:15'!
hasBlackWon
	
	^false! !

!WhiteTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:23:05'!
hasWhiteWon
	
	^false! !

!WhiteTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:22:34'!
isBlackTurn
	
	^false! !

!WhiteTurnState methodsFor: 'testing' stamp: 'HAW 12/10/2019 15:18:22'!
isWhiteTurn
	
	^true! !


!WhiteTurnState methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:58:58'!
move: aTower from: aSourcePosition to: aTargetPosition

	aTower moveOnWhiteTurnFrom: aSourcePosition to: aTargetPosition in: towersGame 
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WhiteTurnState class' category: #'Chess-IS1-2Recu-2c2019'!
WhiteTurnState class
	instanceVariableNames: ''!

!WhiteTurnState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 11:35:41'!
for: aTowersGame 
	
	^self new initializeFor: aTowersGame ! !

!WhiteTurnState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 15:23:44'!
isFor: aTowersGame 
	
	^aTowersGame isBlackTurn and: [ (BlackWonState isFor: aTowersGame) not ]! !


!classDefinition: #WhiteWonState category: #'Chess-IS1-2Recu-2c2019'!
TowerGameState subclass: #WhiteWonState
	instanceVariableNames: 'towersGame'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!WhiteWonState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 11:49:05'!
initializeFor: aTowersGame 
	
	towersGame := aTowersGame.! !


!WhiteWonState methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:55:45'!
move: aTower from: aSourcePosition to: aTargetPosition 
	
	^towersGame moveWhenWhiteWonFrom: aSourcePosition to: aTargetPosition ! !


!WhiteWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:18:57'!
hasBlackWon
	
	^false! !

!WhiteWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:18:08'!
hasWhiteWon
	
	^true! !

!WhiteWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:18:32'!
isBlackTurn
	
	^false! !

!WhiteWonState methodsFor: 'testing' stamp: 'HAW 12/10/2019 18:18:22'!
isWhiteTurn
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WhiteWonState class' category: #'Chess-IS1-2Recu-2c2019'!
WhiteWonState class
	instanceVariableNames: ''!

!WhiteWonState class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 11:48:58'!
for: aTowersGame 
	
	^self new initializeFor: aTowersGame ! !


!WhiteWonState class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 15:20:44'!
isFor: aTowersGame 
	
	^(aTowersGame isWhiteTowerAt: 4@4) and: [ aTowersGame isWhiteTowerAt: 5@5 ]! !


!classDefinition: #TowerMovingState category: #'Chess-IS1-2Recu-2c2019'!
Object subclass: #TowerMovingState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!TowerMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 17:04:05'!
assertCanMoveFrom: aSourcePosition to: aTargetPosition

	self subclassResponsibility ! !

!TowerMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 17:03:54'!
moved

	self subclassResponsibility ! !


!classDefinition: #LimitedMovingState category: #'Chess-IS1-2Recu-2c2019'!
TowerMovingState subclass: #LimitedMovingState
	instanceVariableNames: 'tower numberOfMovements'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!LimitedMovingState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 17:00:57'!
initializeFor: aTower 
	
	tower := aTower.
	numberOfMovements := 0! !


!LimitedMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:52:09'!
assertCanMoveFrom: aSourcePosition to: aTargetPosition

	(aSourcePosition y - aTargetPosition y) abs > 3 
		ifTrue: [ self error: TowersGame canNotMoveMoreThanThreePositions ].
	
	(aSourcePosition x - aTargetPosition x) abs > 3 
		ifTrue: [ self error: TowersGame canNotMoveMoreThanThreePositions ].
! !

!LimitedMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:59:54'!
moved
	
	numberOfMovements := numberOfMovements + 1.
	tower movedWhenLimitedMovingStateTimes: numberOfMovements ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LimitedMovingState class' category: #'Chess-IS1-2Recu-2c2019'!
LimitedMovingState class
	instanceVariableNames: ''!

!LimitedMovingState class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 16:41:37'!
for: aTower 
	
	^self new initializeFor: aTower ! !


!classDefinition: #NormalMovingState category: #'Chess-IS1-2Recu-2c2019'!
TowerMovingState subclass: #NormalMovingState
	instanceVariableNames: 'tower'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!NormalMovingState methodsFor: 'initialization' stamp: 'HAW 12/10/2019 16:46:53'!
initializeFor: aTower 
	
	tower := aTower.! !


!NormalMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:47:15'!
assertCanMoveFrom: aSourcePosition to: aTargetPosition

	! !

!NormalMovingState methodsFor: 'moving' stamp: 'HAW 12/10/2019 16:56:57'!
moved
	
	tower movedWhenOnNormalMovingState! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NormalMovingState class' category: #'Chess-IS1-2Recu-2c2019'!
NormalMovingState class
	instanceVariableNames: ''!

!NormalMovingState class methodsFor: 'instance creation' stamp: 'HAW 12/10/2019 16:46:47'!
for: aTower 
	
	^self new initializeFor: aTower ! !


!classDefinition: #TowersGame category: #'Chess-IS1-2Recu-2c2019'!
Object subclass: #TowersGame
	instanceVariableNames: 'board state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Chess-IS1-2Recu-2c2019'!

!TowersGame methodsFor: 'initialization' stamp: 'HAW 12/10/2019 17:24:44'!
initialize

	super initialize.
	
	self 
		initializeBoard;
		initializeState.
	! !

!TowersGame methodsFor: 'initialization' stamp: 'HAW 12/10/2019 17:24:21'!
initializeBoard
	
	| towers |
	
	towers := { 
		WhiteTower atOriginalPosition: 1@1.
		WhiteTower atOriginalPosition: 7@1.
		BlackTower atOriginalPosition: 2@8.
		BlackTower atOriginalPosition: 8@8 }.
	
	board := Dictionary new.
	towers do: [ :aTower | board at: aTower originalPosition put: aTower ].
! !

!TowersGame methodsFor: 'initialization' stamp: 'HAW 12/10/2019 17:24:31'!
initializeState

	^ state := WhiteTurnState for: self! !


!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 11:28:39'!
assertAreFreePositionsMovingHorizontallyFrom: aSourcePosition to: aTargetPosition
		
	aSourcePosition x + 1 to: aTargetPosition x - 1 do: [:anX | 
		(self isFreeAt: anX@aSourcePosition y) ifFalse: [ self error: self canNotJumpTowerErrorDescription ]]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 11:29:50'!
assertAreFreePositionsMovingVerticallyFrom: aSourcePosition to: aTargetPosition 
	
	aSourcePosition y + 1 to: aTargetPosition y - 1 do: [:anY | 
		(self isFreeAt: aSourcePosition x@anY) ifFalse: [ self error: self canNotJumpTowerErrorDescription ]]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:34:59'!
assertIsInBoardBounds: anIndex

	^ (anIndex between: 1 and: 8) ifFalse: [ self error: self canNotMoveOutsideBoardErrorDescription ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:37:26'!
assertIsIntegerCoordinate: anIndex

	^ anIndex isInteger ifFalse: [ self error: self invalidTargetPositionErrorDescription ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:38:27'!
assertIsIntegerPosition: aTargetPosition

	self assertIsIntegerCoordinate: aTargetPosition x.
	self assertIsIntegerCoordinate: aTargetPosition y! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:31:35'!
assertIsMovingHorizontallyOrVerticallyFrom: aSourcePosition to: aTargetPosition

	^ (aSourcePosition x ~= aTargetPosition x and: [ aSourcePosition y ~= aTargetPosition y ]) ifTrue: [
		self error: self towersCanOnlyMoveHorizontallyOrVerticallyErrorDescription ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:55:48'!
assertIsNotEatingSameColorTowerFrom: aSourcePosition to: aTargetPosition
	
	board 
		at: aTargetPosition 
		ifPresent: [ :aTower | 
			((board at: aSourcePosition) isSameColorAs: aTower) ifTrue: [
				self error: self canNotEatTowerOfSameColorErrorDescription ]]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:32:15'!
assertIsNotMovingToSamePositionFrom: aTargetPosition to: aSourcePosition

	^ aSourcePosition = aTargetPosition ifTrue: [ self error: self canNotMoveToSamePosition ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:38:12'!
assertIsPositionInBoardBounds: aTargetPosition

	self assertIsInBoardBounds: aTargetPosition x.
	self assertIsInBoardBounds: aTargetPosition y! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:38:36'!
assertIsValidTarget: aTargetPosition

	self 
		assertIsPositionInBoardBounds: aTargetPosition;
		assertIsIntegerPosition: aTargetPosition.
	! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:30:06'!
assertPositionsAreFreeWhenMovingHorizontallyFrom: aSourcePosition to: aTargetPosition

	^ aSourcePosition x < aTargetPosition x
		ifTrue: [ self assertAreFreePositionsMovingHorizontallyFrom: aSourcePosition to: aTargetPosition ]
		ifFalse: [ self assertAreFreePositionsMovingHorizontallyFrom: aTargetPosition to: aSourcePosition ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:31:04'!
assertPositionsAreFreeWhenMovingVerticallyFrom: aSourcePosition to: aTargetPosition

	^ aSourcePosition y < aTargetPosition y
		ifTrue: [ self assertAreFreePositionsMovingVerticallyFrom: aSourcePosition to: aTargetPosition ]
		ifFalse: [ self assertAreFreePositionsMovingVerticallyFrom: aTargetPosition to: aSourcePosition ]! !

!TowersGame methodsFor: 'moving - assertions' stamp: 'HAW 12/10/2019 17:30:55'!
assertTowerDoesNotJumpOtherWhenMovingFrom: aSourcePosition to: aTargetPosition

	^ (self isMovingVerticallyFrom: aSourcePosition to: aTargetPosition) 
		ifTrue: [ self assertPositionsAreFreeWhenMovingHorizontallyFrom: aSourcePosition to: aTargetPosition]
		ifFalse: [ self assertPositionsAreFreeWhenMovingVerticallyFrom: aSourcePosition to: aTargetPosition]! !


!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 15:12:08'!
blackHasWonErrorDescription
	
	^'Black has won'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 17:55:48'!
canNotEatTowerOfSameColorErrorDescription
	
	^'Can not eat tower of same color'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:07:08'!
canNotJumpTowerErrorDescription
	
	^'Can not jump tower'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 10:51:55'!
canNotMoveOutsideBoardErrorDescription
	
	^'Can not move outside board'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:13:50'!
canNotMoveToSamePosition
	
	^'Can not move to same position'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:03:00'!
invalidTargetPositionErrorDescription
	
	^'Positions must have integer coordinates'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:43:29'!
itIsBlackTurnErrorDescription
	
	^'It is black''s turn'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:38:41'!
itIsWhiteTurnErrorDescription
	
	^'It is white''s turn'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 10:57:46'!
thereIsNoTowerToMoveErrorDescription
	
	^'There is no tower to move'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 10:48:25'!
towersCanOnlyMoveHorizontallyOrVerticallyErrorDescription
	
	^'Tower can only move horizontally or vertically'! !

!TowersGame methodsFor: 'exceptions' stamp: 'HAW 12/10/2019 11:50:08'!
whiteHasWonErrorDescription
	
	^'White has won'! !


!TowersGame methodsFor: 'testing - private' stamp: 'HAW 12/10/2019 15:32:11'!
is: aCondition at: aPosition

	^board at: aPosition ifPresent: aCondition ifAbsent: [ false ]! !

!TowersGame methodsFor: 'testing - private' stamp: 'HAW 12/10/2019 17:28:27'!
isMovingVerticallyFrom: aSourcePosition to: aTargetPosition

	^ aSourcePosition y = aTargetPosition y! !


!TowersGame methodsFor: 'testing - tower position' stamp: 'HAW 12/10/2019 15:33:17'!
isBlackTowerAt: aPosition

	^self is: [ :aTower | aTower isBlack ] at: aPosition ! !

!TowersGame methodsFor: 'testing - tower position' stamp: 'HAW 12/10/2019 10:58:54'!
isFreeAt: aPosition

	^(board includesKey: aPosition) not! !

!TowersGame methodsFor: 'testing - tower position' stamp: 'HAW 12/10/2019 15:31:41'!
isWhiteTowerAt: aPosition

	^self is: [ :aTower | aTower isWhite ] at: aPosition ! !


!TowersGame methodsFor: 'testing - state' stamp: 'HAW 12/10/2019 15:20:10'!
isBlackTurn
	
	^state isBlackTurn! !

!TowersGame methodsFor: 'testing - state' stamp: 'HAW 12/10/2019 15:18:15'!
isWhiteTurn
	
	^state isWhiteTurn ! !


!TowersGame methodsFor: 'moving' stamp: 'HAW 12/10/2019 15:55:45'!
move: aSourcePosition to: aTargetPosition

	| tower |
	
	tower := board at: aSourcePosition ifAbsent: [ self error: self thereIsNoTowerToMoveErrorDescription ].

	state move: tower from: aSourcePosition to: aTargetPosition.
	! !


!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:50:56'!
assertCanMove: aTower from: aTargetPosition to: aSourcePosition

	self assertIsNotMovingToSamePositionFrom: aSourcePosition to: aTargetPosition.
	self assertIsMovingHorizontallyOrVerticallyFrom: aSourcePosition to: aTargetPosition.
	self assertIsValidTarget: aTargetPosition.
	self assertTowerDoesNotJumpOtherWhenMovingFrom: aSourcePosition to: aTargetPosition.
	self assertIsNotEatingSameColorTowerFrom: aSourcePosition to: aTargetPosition.
	aTower assertCanMoveFrom: aSourcePosition to: aTargetPosition! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:14:49'!
changeState

	state := TowerGameState stateFor: self! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:59:06'!
findFreeOriginalPositionOf: aTower
	
	| freeOriginalPosition adder |
	
	freeOriginalPosition := aTower originalPosition.
	adder := freeOriginalPosition x <=4 ifTrue: [ 1 ] ifFalse: [ -1 ].
	[ self isFreeAt: freeOriginalPosition ] whileFalse: [ freeOriginalPosition := freeOriginalPosition x + adder @freeOriginalPosition y ].
	
	^freeOriginalPosition ! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:45:36'!
move: aTower from: aSourcePosition to: aTargetPosition 
	
	self 
		assertCanMove: aTower from: aTargetPosition to: aSourcePosition;
		moveInBoard: aTower from: aSourcePosition to: aTargetPosition;
		changeState ! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:48:35'!
moveBlackTower: aBlackTower onBlackTurnFrom: aSourcePosition to: aTargetPosition 
	
	self move: aBlackTower from: aSourcePosition to: aTargetPosition ! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:38:22'!
moveBlackTower: aBlackTower onWhiteTurnFrom: aSourcePosition to: aTargetPosition 

	self error: self itIsWhiteTurnErrorDescription! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:45:19'!
moveInBoard: aTower from: aSourcePosition to: aTargetPosition

	board 
		removeKey: aSourcePosition;
		at: aTargetPosition ifPresent: [ :aTowerToEat | self putAtOriginalPosition: aTowerToEat ];
		at: aTargetPosition put: aTower.
		
	aTower moved.! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:11:58'!
moveWhenBlackWonFrom: aSourcePosition to: aTargetPosition 

	self error: self blackHasWonErrorDescription! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 11:49:54'!
moveWhenWhiteWonFrom: aSourcePosition to: aTargetPosition 

	self error: self whiteHasWonErrorDescription! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:37:03'!
moveWhiteTower: aWhiteTower onBlackTurnFrom: aSourcePosition to: aTargetPosition 

	self error: self itIsBlackTurnErrorDescription 
	! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 15:48:54'!
moveWhiteTower: aWhiteTower onWhiteTurnFrom: aSourcePosition to: aTargetPosition 
	
	self move: aWhiteTower from: aSourcePosition to: aTargetPosition ! !

!TowersGame methodsFor: 'moving - private' stamp: 'HAW 12/10/2019 17:58:17'!
putAtOriginalPosition: aTower 
	
	| newPosition |
	
	newPosition := self findFreeOriginalPositionOf: aTower.
	board at: newPosition put: aTower.
	
	aTower startLimitedMovingState! !


!TowersGame methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 18:18:41'!
hasBlackWon
	
	^state hasBlackWon ! !

!TowersGame methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 18:17:56'!
hasWhiteWon
	
	^state hasWhiteWon ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TowersGame class' category: #'Chess-IS1-2Recu-2c2019'!
TowersGame class
	instanceVariableNames: ''!

!TowersGame class methodsFor: 'as yet unclassified' stamp: 'HAW 12/10/2019 16:45:22'!
canNotMoveMoreThanThreePositions
	
	^'Can not move more that three positions when on limited moving state'! !
