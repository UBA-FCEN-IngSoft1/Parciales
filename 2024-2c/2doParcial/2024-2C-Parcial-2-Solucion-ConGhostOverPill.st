!classDefinition: #PacmanGameTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #PacmanGameTest
	instanceVariableNames: 'nextIntegers'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test01PacmanStartsMovingLeft

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick.

	self
		assert: game stringRepresentationOfBoard
		equals: #(
'######'
'#-BC-#'
'#p=--#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test02AddsOnePointWhenEatingSmallPill

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick.

	self assert: 1 equals: game points.
	self
		assert: game stringRepresentationOfBoard
		equals: #(
'######'
'#-BC-#'
'#p=--#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test03AddsTwoPointsWhenEatingBigPill

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#*p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick.

	self assert: 2 equals: game points.
	self
		assert: game stringRepresentationOfBoard
		equals: #(
'######'
'#-BC-#'
'#p=--#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test04GameStartsWithCeroPoints

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#*p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	self assert: 0 equals: game points! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test05PacmanCannotMoveIntoWall

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#p---#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick.
	
	self assert: 0 equals: game points.
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#p---#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test06PacmanCanMoveIntoSpace

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#=p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick.
	
	self assert: 0 equals: game points.
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#p=--#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test07PacmanMovesCorrecltyMoreThanOneTick

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#--p-#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game tick; tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#p==-#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test08PacmanCanMoveRight

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#--p-#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanRight.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#--=p#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test09PacmanCanMoveUp

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#p---#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanUp.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#pBC-#'
'#=---#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test10PacmanCanMoveDown

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#pBC-#'
'#----#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanDown.
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#=BC-#'
'#p---#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test11BlinkyStartsMovingLeftOnFourthTick

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p--#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	3 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#B=C-#'
'#p=--#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test12ClideStartsMovingRightOnFifthTick

	| board game |

	board := StringPacmanBoard representedAs:#(
'#######'
'#--BC-#'
'#--p--#'
'#######').

	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'#######'
'#B-==C#'
'#p==--#'
'#######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test13GhostLeavePreviousElementWhenMoving

	| board game |

	board := StringPacmanBoard representedAs:#(
'#######'
'#--BC-#'
'#--p--#'
'#######').

	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'#######'
'#B-==C#'
'#p==--#'
'#######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test14GhostCanEatPacman

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#p---#'
'######').

	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanUp.
	3 timesRepeat: [game tick].
	game tick.
	
	self assert: 2 equals: game pacmanLives.
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#B=C-#'
'#p---#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test15GhostKeepsBigPill

	| board game |

	board := StringPacmanBoard representedAs:#(
'#######'
'#-*BC-#'
'#-p---#'
'#######').

	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'#######'
'#B*==C#'
'#p=---#'
'#######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:49:54'!
test16GhostKeepsSpace

	| board game |

	board := StringPacmanBoard representedAs:#(
'#######'
'#-=BC-#'
'#-p---#'
'#######').

	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'#######'
'#B===C#'
'#p=---#'
'#######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:54:02'!
test17GhostMovesRightWhenHitsAWallAndRandomDisplacmentSelectorsIs5

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#p---#'
'######').

	nextIntegers := ReadStream on: #(5).
	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-B=C#'
'#p---#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:58:47'!
test18GhostMovesDownWhenHitsAWallAndRandomDisplacmentSelectorsIs4

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#---p#'
'######').

	nextIntegers := ReadStream on: #(4).
	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanRight.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#-==C#'
'#B--p#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 20:59:48'!
test19GhostMovesUpWhenHitsAWallAndRandomDisplacmentSelectorsIs3

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#---p#'
'#-BC-#'
'######').

	nextIntegers := ReadStream on: #(3).
	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanRight.
	4 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#B--p#'
'#-==C#'
'######').! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/28/2024 21:06:19'!
test20GhostMovesLeftWhenHitsAWallAndRandomDisplacmentSelectorsIs2AndsDisplacementWhen1

	| board game |

	board := StringPacmanBoard representedAs:#(
'#####'
'#--p#'
'#BC-#'
'#####').

	nextIntegers := ReadStream on: #(1 1 1 2).
	game := PacmanGame on: board randomizingWith: self.
	game startMovingPacmanRight.
	5 timesRepeat: [game tick].
	game tick.
	
	self assert: game stringRepresentationOfBoard equals: #(
'#####'
'#--p#'
'#BC-#'
'#####').
! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/29/2024 15:27:46'!
test21GameIsOverWhenPacmanHasNoLives

	| board game |

	board := StringPacmanBoard representedAs:#(
'######'
'#-B*C#'
'#-p--#'
'######').

	nextIntegers := ReadStream on: #(4 5 1 1 1).
	game := PacmanGame on: board randomizingWith: self.
	game tick.
	game startMovingPacmanUp.
	7 timesRepeat: [game tick].
	game startMovingPacmanRight.
	6 timesRepeat: [game tick].

	self assert: game isOver.
	self assert: 0 equals: game pacmanLives.
	self assert: game stringRepresentationOfBoard equals: #(
'######'
'#==*C#'
'#=p=B#'
'######').
! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/29/2024 15:19:39'!
test22GameIsOverWhenThereNoMorePills

	| board game |

	board := StringPacmanBoard representedAs:#(
'#####'
'#=BC#'
'#*-p#'
'#####').

	nextIntegers := ReadStream on: #().
	game := PacmanGame on: board randomizingWith: self.
	2 timesRepeat: [game tick].
	
	self assert: game isOver.
	self assert: 3 equals: game pacmanLives.
! !

!PacmanGameTest methodsFor: 'tests' stamp: 'HAW 11/29/2024 15:32:20'!
test23CannotPlayIfGameIsOver

	| board game |

	board := StringPacmanBoard representedAs:#(
'#####'
'#=BC#'
'#*-p#'
'#####').

	nextIntegers := ReadStream on: #().
	game := PacmanGame on: board randomizingWith: self.
	2 timesRepeat: [game tick].
	
	self assert: game isOver.
	
	self assertCannotDo: [ game tick ] in: game.
	self assertCannotDo: [ game startMovingPacmanDown ] in: game.
	self assertCannotDo: [ game startMovingPacmanUp ] in: game.
	self assertCannotDo: [ game startMovingPacmanRight ] in: game.
	self assertCannotDo: [ game startMovingPacmanLeft ] in: game.
! !

!PacmanGameTest methodsFor: 'tests' stamp: 'TRN 12/3/2024 01:40:03'!
test24GameIsNotOverWhenGhostsHoverOverPills

	| board game |

	board := StringPacmanBoard representedAs:#(
'#####'
'#-BC#'
'#*-p#'
'#####').

	nextIntegers := ReadStream on: #().
	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	
	self deny: game isOver.
	self assert: game stringRepresentationOfBoard equals:#(
'#####'
'#B=C#'
'#p==#'
'#####') .
! !


!PacmanGameTest methodsFor: 'random simulation' stamp: 'HAW 11/29/2024 16:04:52'!
nextInteger: aLimit

	self assert: 5 equals: aLimit.
	self deny: nextIntegers atEnd.
	
	^nextIntegers next! !


!PacmanGameTest methodsFor: 'assertions' stamp: 'HAW 11/29/2024 15:31:53'!
assertCannotDo: aBlock in: game 

	^ self 
		should: aBlock
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: game gameIsOverErrorDescription equals: anError messageText.
			self assert: game stringRepresentationOfBoard equals:#(
'#####'
'#=BC#'
'#p==#'
'#####'). ]! !


!classDefinition: #StringPacmanBoardTest category: #'2024-2C-Parcial-2'!
TestCase subclass: #StringPacmanBoardTest
	instanceVariableNames: 'visitedElements'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test01CannotCreateABoardWithoutThePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test02CannotCreateABoardWithMoreThanOnePacman

	self 
		should: [ StringPacmanBoard representedAs: #('BCpp') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard pacmanName)
		! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:48:10'!
test03CannotCreateABoardWithoutBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 14:32:55'!
test04CannotCreateABoardWithMoreThanOneBlinky

	self 
		should: [ StringPacmanBoard representedAs: #('pBBC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard blinkyName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:33'!
test05CannotCreateABoardWithoutClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pB') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard characterIsMissingErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:40'!
test06CannotCreateABoardWithMoreThanOneClyde

	self 
		should: [ StringPacmanBoard representedAs: #('pBCC') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard shouldBeUniqueErrorDescriptionFor: StringPacmanBoard clydeName)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:50:49'!
test07AllRowsHaveSameSize

	self 
		should: [ StringPacmanBoard representedAs: #('pBC' '') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: StringPacmanBoard rowsMustHaveSameSizeErrorDescription! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:00'!
test08VisitElementsWithRightPosition

	| board |
	
	visitedElements := Dictionary new.
	
	board := StringPacmanBoard representedAs: #('pBC#-*=').
	board visitElementsWith: self.
	
	self assert: (visitedElements at: #pacman) equals: 1@1.
	self assert: (visitedElements at: #blinky) equals: 2@1.
	self assert: (visitedElements at: #clyde) equals: 3@1.
	self assert: (visitedElements at: #wall) equals: 4@1.
	self assert: (visitedElements at: #smallPill) equals: 5@1.
	self assert: (visitedElements at: #bigPill) equals: 6@1.
	self assert: (visitedElements at: #space) equals: 7@1.
	self assert: visitedElements size equals: 7
	
	
	! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 10:51:11'!
test09InvalidCharactersAreNotAllowed

	self 
		should: [ StringPacmanBoard representedAs: #('pBCx') ]
		raise: Error - MessageNotUnderstood 
		withMessageText: (StringPacmanBoard notAllowCharaterErrorDescriptionFor: $x)! !

!StringPacmanBoardTest methodsFor: 'tests' stamp: 'HAW 11/22/2024 16:42:59'!
test10BoardTranslationExample
"
	HACER PASAR ESTE TEST ANTES DE COMENZAR: falla porque en la posicion del pacman (p) pone un string en vez de #pacman
"
	| board translator |
	
	board := StringPacmanBoard representedAs:#(
'######'
'#-BC-#'
'#-p=-#'
'######').

	translator := BoardTranslatorExample on: board.
	
	self assert: translator stringRepresentationOfBoard equals: #(
'######'
'#-BC-#'
'#-p=-#'
'######').
! !


!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:25'!
visitBigPillAt: position 
	
	visitedElements at: #bigPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:27'!
visitBlinkyAt: position 
	
	visitedElements at: #blinky put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:56'!
visitClydeAt: position 
	
	visitedElements at: #clyde put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:15:10'!
visitPacmanAt: position 
	
	visitedElements at: #pacman put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:14'!
visitSmallPillAt: position 
	
	visitedElements at: #smallPill put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:17:12'!
visitSpaceAt: position 
	
	visitedElements at: #space put: position ! !

!StringPacmanBoardTest methodsFor: 'visiting board elements' stamp: 'HAW 11/20/2024 17:16:05'!
visitWallAt: position 
	
	visitedElements at: #wall put: position ! !


!classDefinition: #BoardTranslatorExample category: #'2024-2C-Parcial-2'!
Object subclass: #BoardTranslatorExample
	instanceVariableNames: 'board boardExtent'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:38:51'!
characterRepresentationOf: anElement
	
	(anElement = #smallPill) ifTrue: [ ^StringPacmanBoard smallPillCharacter ].
	(anElement = #bigPill) ifTrue: [ ^StringPacmanBoard bigPillCharacter ].
	(anElement = #blinky) ifTrue: [ ^StringPacmanBoard blinkyCharacter ].
	(anElement = #clyde) ifTrue: [ ^StringPacmanBoard clydeCharacter ].
	(anElement = #space) ifTrue: [ ^StringPacmanBoard spaceCharacter ].
	(anElement = #wall) ifTrue: [ ^StringPacmanBoard wallCharacter ].
	(anElement = #pacman) ifTrue: [ ^StringPacmanBoard pacmanCharacter ].
	
	self error: 'Unknown pacman element type'! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'HAW 11/22/2024 14:45:23'!
representationOfRowNumber: y
	
	^String streamContents: [ :rowStream |
		1 to: boardExtent x do: [ :x |
			rowStream nextPut: (self characterRepresentationOf: (board at: x@y))]]! !

!BoardTranslatorExample methodsFor: 'string representation' stamp: 'LL 11/22/2024 10:44:29'!
stringRepresentationOfBoard
	
	| rows |
	
	rows := OrderedCollection new.

	1 to: boardExtent y do: [ :y | 
		rows add: (self representationOfRowNumber: y) ].
	
	^rows asArray! !


!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:42:38'!
visitBigPillAt: aPosition 
	
	board at: aPosition put: #bigPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:40:34'!
visitBlinkyAt: aPosition 
	
	board at: aPosition put: #blinky! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:04'!
visitClydeAt: aPosition 
	
	board at: aPosition put: #clyde! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'HAW 11/28/2024 19:24:18'!
visitPacmanAt: aPosition 
	
	board at: aPosition put: #pacman! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:22'!
visitSmallPillAt: aPosition 
	
	board at: aPosition put: #smallPill! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:30'!
visitSpaceAt: aPosition

	board at: aPosition put: #space
	
	! !

!BoardTranslatorExample methodsFor: 'string board visiting' stamp: 'LL 11/22/2024 11:43:35'!
visitWallAt: aPosition 
	
	board at: aPosition put: #wall! !


!BoardTranslatorExample methodsFor: 'initialization' stamp: 'HAW 11/22/2024 14:43:18'!
initializeOn: aBoard

	board := Dictionary new.
	boardExtent := aBoard extent.
	aBoard visitElementsWith: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BoardTranslatorExample class' category: #'2024-2C-Parcial-2'!
BoardTranslatorExample class
	instanceVariableNames: ''!

!BoardTranslatorExample class methodsFor: 'instance creation' stamp: 'LL 11/22/2024 10:37:38'!
on: aBoard

	^self new initializeOn: aBoard! !


!classDefinition: #PacmanElement category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanElement methodsFor: 'testing' stamp: 'HAW 12/3/2024 09:27:25'!
isOnPill

	^false! !

!PacmanElement methodsFor: 'testing' stamp: 'HAW 11/29/2024 15:22:08'!
isPill

	^false! !


!PacmanElement methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:45:24'!
ghost: aGhost wantsToMoveIntoIn: aPacmanGame

	self subclassResponsibility! !


!PacmanElement methodsFor: 'representation' stamp: 'HAW 11/29/2024 15:45:04'!
characterRepresentation

	self subclassResponsibility! !


!PacmanElement methodsFor: 'pacman moving' stamp: 'HAW 11/29/2024 15:45:29'!
pacmanWantsToMoveIntoIn: aPacmanGame

	self subclassResponsibility! !


!classDefinition: #PacmanActor category: #'2024-2C-Parcial-2'!
PacmanElement subclass: #PacmanActor
	instanceVariableNames: 'position displacement'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanActor methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:19:11'!
startMovingDown
	
	displacement := 0@1! !

!PacmanActor methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:19:15'!
startMovingLeft

	^ displacement := -1@0! !

!PacmanActor methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:19:19'!
startMovingRight
	
	displacement := 1@0! !

!PacmanActor methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:19:24'!
startMovingUp
	
	displacement := 0@-1! !


!PacmanActor methodsFor: 'representation' stamp: 'HAW 11/28/2024 20:18:28'!
characterRepresentation

	self subclassResponsibility! !


!PacmanActor methodsFor: 'position' stamp: 'HAW 11/28/2024 20:19:01'!
nextPosition

	^ self position + displacement! !

!PacmanActor methodsFor: 'position' stamp: 'HAW 11/28/2024 20:19:06'!
position
	
	^position! !


!classDefinition: #Ghost category: #'2024-2C-Parcial-2'!
PacmanActor subclass: #Ghost
	instanceVariableNames: 'previousElement charRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Ghost methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:41:24'!
moveWithPreviousElement: aPreviousElement

	previousElement := aPreviousElement.
	^position := self nextPosition ! !

!Ghost methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:28:29'!
previousElement
	
	^previousElement! !


!Ghost methodsFor: 'initialization' stamp: 'HAW 11/29/2024 15:37:57'!
initializeLocatedAt: aPosition representedWith: aCharRepresentation 
	
	position := aPosition.
	charRepresentation := aCharRepresentation.
	previousElement := Space new.
! !


!Ghost methodsFor: 'representation' stamp: 'HAW 11/29/2024 15:37:10'!
characterRepresentation
	
	^charRepresentation ! !


!Ghost methodsFor: 'testing' stamp: 'HAW 12/3/2024 09:30:11'!
isOnPill

	^previousElement isPill ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ghost class' category: #'2024-2C-Parcial-2'!
Ghost class
	instanceVariableNames: ''!

!Ghost class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:36:52'!
blinkyLocatedAt: aPosition

	^(self locatedAt: aPosition representedWith: StringPacmanBoard blinkyCharacter)
		startMovingLeft;
		yourself ! !

!Ghost class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:38:25'!
clydeLocatedAt: aPosition

	^(self locatedAt: aPosition representedWith: StringPacmanBoard clydeCharacter)
		startMovingRight;
		yourself ! !

!Ghost class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:36:22'!
locatedAt: aPosition representedWith: aCharRepresentation 
	
	^self new initializeLocatedAt: aPosition representedWith: aCharRepresentation ! !


!classDefinition: #Pacman category: #'2024-2C-Parcial-2'!
PacmanActor subclass: #Pacman
	instanceVariableNames: 'lives initialPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Pacman methodsFor: 'initialization' stamp: 'HAW 11/28/2024 20:40:33'!
initializeLocatedAt: anInitialPosition 
	
	position := initialPosition := anInitialPosition.
	lives := 3.
	
	self startMovingLeft ! !


!Pacman methodsFor: 'moving' stamp: 'HAW 11/29/2024 15:11:14'!
die
	
	lives := lives - 1.
	position := initialPosition.
	
	self startMovingLeft ! !

!Pacman methodsFor: 'moving' stamp: 'HAW 11/29/2024 15:10:00'!
lives
	
	^lives ! !

!Pacman methodsFor: 'moving' stamp: 'HAW 11/28/2024 20:28:41'!
move

	^ position := self nextPosition! !


!Pacman methodsFor: 'representation' stamp: 'HAW 11/28/2024 19:49:45'!
characterRepresentation

	^StringPacmanBoard pacmanCharacter ! !


!Pacman methodsFor: 'ghost moving' stamp: 'HAW 11/28/2024 20:38:22'!
ghost: aGhost wantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame ghostWantsToMoveIntoPacman: aGhost! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pacman class' category: #'2024-2C-Parcial-2'!
Pacman class
	instanceVariableNames: ''!

!Pacman class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:54:16'!
locatedAt: anInitialPosition 
	
	^self new initializeLocatedAt: anInitialPosition ! !


!classDefinition: #Pill category: #'2024-2C-Parcial-2'!
PacmanElement subclass: #Pill
	instanceVariableNames: 'pointsToAdd charRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Pill methodsFor: 'initialization' stamp: 'HAW 11/29/2024 15:41:04'!
initializePointsToAddWhenEated: aPointsToAdd charRepresentation: aCharRepresentation 
	
	pointsToAdd := aPointsToAdd.
	charRepresentation := aCharRepresentation.! !


!Pill methodsFor: 'points' stamp: 'HAW 11/29/2024 15:42:05'!
pointsToAdd
	
	^pointsToAdd! !


!Pill methodsFor: 'representation' stamp: 'HAW 11/29/2024 15:43:10'!
characterRepresentation
	
	^charRepresentation ! !


!Pill methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:42:41'!
ghost: aGhost wantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame ghost: aGhost wantsToMoveIntoPill: self! !


!Pill methodsFor: 'testing' stamp: 'HAW 11/29/2024 15:43:33'!
isPill
	
	^true! !


!Pill methodsFor: 'pacman moving' stamp: 'HAW 11/29/2024 15:41:31'!
pacmanWantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame pacmanWantsToMoveIntoPill: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pill class' category: #'2024-2C-Parcial-2'!
Pill class
	instanceVariableNames: ''!

!Pill class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:40:34'!
bigPill
	
	^self pointsToAddWhenEated: 2 charRepresentation: StringPacmanBoard bigPillCharacter ! !

!Pill class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:40:58'!
pointsToAddWhenEated: aPointsToAdd charRepresentation: aCharRepresentation 
	
	^self new initializePointsToAddWhenEated: aPointsToAdd charRepresentation: aCharRepresentation ! !

!Pill class methodsFor: 'instance creation' stamp: 'HAW 11/29/2024 15:44:02'!
smallPill
	
	^self pointsToAddWhenEated: 1 charRepresentation: StringPacmanBoard smallPillCharacter ! !


!classDefinition: #Space category: #'2024-2C-Parcial-2'!
PacmanElement subclass: #Space
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Space methodsFor: 'representation' stamp: 'HAW 11/28/2024 19:58:39'!
characterRepresentation
	
	^StringPacmanBoard spaceCharacter ! !


!Space methodsFor: 'ghost moving' stamp: 'HAW 11/28/2024 20:47:06'!
ghost: aGhost wantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame ghost: aGhost wantsToMoveIntoSpace: self! !


!Space methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 19:57:57'!
pacmanWantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame pacmanWantsToMoveIntoSpace
	! !


!classDefinition: #Wall category: #'2024-2C-Parcial-2'!
PacmanElement subclass: #Wall
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!Wall methodsFor: 'representation' stamp: 'HAW 11/28/2024 19:53:40'!
characterRepresentation
	
	^StringPacmanBoard wallCharacter ! !


!Wall methodsFor: 'ghost moving' stamp: 'HAW 11/28/2024 20:50:23'!
ghost: aGhost wantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame ghost: aGhost wantsToMoveIntoWall: self ! !


!Wall methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 19:54:25'!
pacmanWantsToMoveIntoIn: aPacmanGame 
	
	aPacmanGame pacmanWantsToMoveIntoWall! !


!classDefinition: #PacmanGame category: #'2024-2C-Parcial-2'!
Object subclass: #PacmanGame
	instanceVariableNames: 'board boardExtent points pacman ticks blinky clyde random'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!PacmanGame methodsFor: 'string representation' stamp: 'HAW 11/29/2024 16:06:41'!
representationOfRowNumber: y
	
	^String streamContents: [ :rowStream |
		1 to: boardExtent x do: [ :x |
			rowStream nextPut: (board at: x@y) characterRepresentation ]]! !

!PacmanGame methodsFor: 'string representation' stamp: 'HAW 11/28/2024 19:28:59'!
stringRepresentationOfBoard
	
	| rows |
	
	rows := OrderedCollection new.

	1 to: boardExtent y do: [ :y | 
		rows add: (self representationOfRowNumber: y) ].
	
	^rows asArray! !


!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/29/2024 15:39:47'!
visitBigPillAt: aPosition 
	
	board at: aPosition put: Pill bigPill! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/29/2024 15:35:55'!
visitBlinkyAt: aPosition 
	
	blinky := Ghost blinkyLocatedAt: aPosition.
	board at: aPosition put: blinky.! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/29/2024 15:38:34'!
visitClydeAt: aPosition 
	
	clyde := Ghost clydeLocatedAt: aPosition.
	board at: aPosition put: clyde! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/28/2024 19:46:12'!
visitPacmanAt: aPosition 
	
	pacman := Pacman locatedAt: aPosition.
	board at: aPosition put: pacman! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/29/2024 15:43:50'!
visitSmallPillAt: aPosition 
	
	board at: aPosition put: Pill smallPill! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/28/2024 19:57:40'!
visitSpaceAt: aPosition

	board at: aPosition put: Space new
	
	! !

!PacmanGame methodsFor: 'string board visiting' stamp: 'HAW 11/28/2024 19:52:39'!
visitWallAt: aPosition 
	
	board at: aPosition put: Wall new! !


!PacmanGame methodsFor: 'initialization' stamp: 'HAW 11/29/2024 15:32:58'!
initializeOn: aBoard randomizingWith: aRandom 

	board := Dictionary new.
	boardExtent := aBoard extent.
	aBoard visitElementsWith: self.
	
	points := 0.
	ticks := 0.
	random := aRandom.
	
	self startMovingPacmanLeft ! !


!PacmanGame methodsFor: 'lives/points' stamp: 'HAW 11/28/2024 20:32:44'!
pacmanLives
	
	^pacman lives! !

!PacmanGame methodsFor: 'lives/points' stamp: 'HAW 11/28/2024 19:36:19'!
points
	
	^points! !


!PacmanGame methodsFor: 'assertions' stamp: 'HAW 11/29/2024 15:29:16'!
assertGameIsNotOver

	^ self isOver ifTrue: [ self error: self gameIsOverErrorDescription ]! !

!PacmanGame methodsFor: 'assertions' stamp: 'HAW 11/29/2024 15:25:53'!
gameIsOverErrorDescription
	
	^'Game is over'! !


!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:43:00'!
ghost: aGhost wantsToMoveIntoPill: aPill 
	
	self move: aGhost withPreviousElement: aPill ! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/28/2024 20:47:26'!
ghost: aGhost wantsToMoveIntoSpace: aSpace 
	
	board at: aGhost position put: aGhost previousElement.
	board at: (aGhost moveWithPreviousElement: aSpace) put: aGhost ! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:52:17'!
ghost: aGhost wantsToMoveIntoWall: aWall 
	
	| randomDisplacementSelector |
	
	randomDisplacementSelector := random nextInteger: 5.
	
	randomDisplacementSelector = 1 ifTrue: [ ^self ].
	randomDisplacementSelector = 2 ifTrue: [ aGhost startMovingLeft ].
	randomDisplacementSelector = 3 ifTrue: [ aGhost startMovingUp ].
	randomDisplacementSelector = 4 ifTrue: [ aGhost startMovingDown ].
	randomDisplacementSelector = 5 ifTrue: [ aGhost startMovingRight ].
	
	self tryToMoveGhost: aGhost 
	! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:51:45'!
ghostWantsToMoveIntoPacman: aGhost 
	
	pacman die.
	
	self move: aGhost withPreviousElement: Space new.
	board at: pacman position put: pacman.
	
	ticks := 0.! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:51:08'!
move: aGhost withPreviousElement: aPacmanElement

	board at: aGhost position put: aGhost previousElement.
	board at: (aGhost moveWithPreviousElement: aPacmanElement) put: aGhost! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:52:17'!
tryToMoveGhost: aGhost

	| elementAtNextPosition |
	
	elementAtNextPosition := board at: aGhost nextPosition.
	elementAtNextPosition ghost: aGhost wantsToMoveIntoIn: self.
! !

!PacmanGame methodsFor: 'ghost moving' stamp: 'HAW 11/29/2024 15:52:17'!
tryToMoveGhosts

	ticks > 3 ifTrue: [ self tryToMoveGhost: blinky ].
	ticks > 4 ifTrue: [ self tryToMoveGhost: clyde ]! !


!PacmanGame methodsFor: 'testing' stamp: 'HAW 12/3/2024 09:30:52'!
areThereNoPills
	
	^board noneSatisfy: [ :aPacmanElement | aPacmanElement isPill or: [ aPacmanElement isOnPill ]]! !

!PacmanGame methodsFor: 'testing' stamp: 'HAW 11/29/2024 15:49:58'!
isOver
	
	^self pacmanLives = 0 or: [ self areThereNoPills ]! !


!PacmanGame methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 20:11:27'!
movePacman

	board at: pacman position put: Space new.
	board at: pacman move put: pacman! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'HAW 11/29/2024 15:41:59'!
pacmanWantsToMoveIntoPill: aPill 
	
	points := points + aPill pointsToAdd.
	self movePacman ! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 19:59:32'!
pacmanWantsToMoveIntoSpace
	
	self movePacman  
	! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 19:54:33'!
pacmanWantsToMoveIntoWall
	
	! !

!PacmanGame methodsFor: 'pacman moving' stamp: 'HAW 11/28/2024 20:21:51'!
tryToMovePacman
	
	| elementAtNextPosition |
	
	elementAtNextPosition := board at: pacman nextPosition.
	elementAtNextPosition pacmanWantsToMoveIntoIn: self.
! !


!PacmanGame methodsFor: 'actions' stamp: 'HAW 11/29/2024 15:29:30'!
startMovingPacmanDown
	
	self assertGameIsNotOver.
	
	pacman startMovingDown! !

!PacmanGame methodsFor: 'actions' stamp: 'HAW 11/29/2024 15:33:33'!
startMovingPacmanLeft 

	self assertGameIsNotOver.
	
	pacman startMovingLeft ! !

!PacmanGame methodsFor: 'actions' stamp: 'HAW 11/29/2024 15:32:38'!
startMovingPacmanRight
	
	self assertGameIsNotOver.
	
	pacman startMovingRight! !

!PacmanGame methodsFor: 'actions' stamp: 'HAW 11/29/2024 15:32:43'!
startMovingPacmanUp
	
	self assertGameIsNotOver.
	
	pacman startMovingUp! !

!PacmanGame methodsFor: 'actions' stamp: 'HAW 11/29/2024 15:52:05'!
tick
	
	self assertGameIsNotOver.
	
	ticks := ticks + 1.
	
	self tryToMovePacman.
	self tryToMoveGhosts.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PacmanGame class' category: #'2024-2C-Parcial-2'!
PacmanGame class
	instanceVariableNames: ''!

!PacmanGame class methodsFor: 'instance creation' stamp: 'HAW 11/28/2024 20:55:38'!
on: aBoard randomizingWith: aRandom 

	^self new initializeOn: aBoard randomizingWith: aRandom! !


!classDefinition: #StringPacmanBoard category: #'2024-2C-Parcial-2'!
Object subclass: #StringPacmanBoard
	instanceVariableNames: 'stringRepresentation'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2024-2C-Parcial-2'!

!StringPacmanBoard methodsFor: 'initialization' stamp: 'HAW 11/18/2024 19:29:26'!
initializeRepresentedAs: aStringRepresentation 
	
	stringRepresentation := aStringRepresentation.! !


!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:23:48'!
bigPillCharacter

	^self class bigPillCharacter! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:20'!
blinkyCharacter

	^ self class blinkyCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:30'!
clydeCharacter

	^ self class clydeCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:24:52'!
pacmanCharacter

	^ self class pacmanCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:15'!
smallPillCharacter

	^self class smallPillCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:25:37'!
spaceCharacter

	^self class spaceCharacter ! !

!StringPacmanBoard methodsFor: 'element character' stamp: 'HAW 11/20/2024 17:26:00'!
wallCharacter

	^self class wallCharacter! !


!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:21'!
isBigPill: anElement

	^ anElement = self bigPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:36'!
isBlinky: anElement

	^ anElement = self blinkyCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:09'!
isClyde: anElement

	^ anElement = self clydeCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:17'!
isPacman: anElement

	^ anElement = self pacmanCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:12'!
isSmalltPill: anElement

	^ anElement = self smallPillCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:21:29'!
isSpace: anElement

	^ anElement = self spaceCharacter! !

!StringPacmanBoard methodsFor: 'testing' stamp: 'HAW 11/20/2024 17:20:03'!
isWall: anElement

	^ anElement = self wallCharacter! !


!StringPacmanBoard methodsFor: 'visiting' stamp: 'HAW 11/22/2024 14:38:19'!
visit: anElement at: position with: aPacmanBoardVisitor

	(self isWall: anElement) ifTrue: [ ^aPacmanBoardVisitor visitWallAt: position ].
	(self isSmalltPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSmallPillAt: position ].
	(self isBigPill: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBigPillAt: position ].
	(self isBlinky: anElement) ifTrue: [ ^aPacmanBoardVisitor visitBlinkyAt: position ].
	(self isClyde: anElement) ifTrue: [ ^aPacmanBoardVisitor visitClydeAt: position ].
	(self isPacman: anElement) ifTrue: [ ^aPacmanBoardVisitor visitPacmanAt: position ].
	(self isSpace: anElement) ifTrue: [ ^aPacmanBoardVisitor visitSpaceAt: position ].
	
	"No hay necesidad de generar un error porque no se permite crear un board con caracteres distintos a todos estos - Hernan"! !

!StringPacmanBoard methodsFor: 'visiting' stamp: 'HAW 11/20/2024 17:22:41'!
visitElementsWith: aPacmanBoardVisitor

	stringRepresentation withIndexDo: [ :aRow :y |
		aRow withIndexDo: [ :anElement :x | 
			self visit: anElement at: x@y with: aPacmanBoardVisitor.]]! !


!StringPacmanBoard methodsFor: 'extent' stamp: 'HAW 11/22/2024 10:50:10'!
extent
	
	"There is always a row and their size is the same to all - Hernan"
	^stringRepresentation first size @ stringRepresentation size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StringPacmanBoard class' category: #'2024-2C-Parcial-2'!
StringPacmanBoard class
	instanceVariableNames: ''!

!StringPacmanBoard class methodsFor: 'instance creation' stamp: 'HAW 11/22/2024 10:48:32'!
representedAs: aStringRepresentation 
	
	| elementCharactersCount |
	
	elementCharactersCount := self elementCharacterCountOf: aStringRepresentation.	
	self asserltAllActorsAreIn: elementCharactersCount.
	"If I get here the there is always a row - Hernan"
	self assertAllRowsHaveSameSizeIn: aStringRepresentation.
	
	^self new initializeRepresentedAs: aStringRepresentation 
	! !


!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:30'!
characterIsMissingErrorDescriptionFor: aCharacterName
	
	^aCharacterName, ' is missing'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:39:12'!
notAllowCharaterErrorDescriptionFor: aCharacter

	^'Character ', aCharacter asString, ' is not allowed'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 17:07:31'!
rowsMustHaveSameSizeErrorDescription
	
	^'Rows must have same number of columns'! !

!StringPacmanBoard class methodsFor: 'error description' stamp: 'HAW 11/20/2024 16:58:01'!
shouldBeUniqueErrorDescriptionFor: aCharacterName
	
	^'There should be only one ', aCharacterName ! !


!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/21/2024 20:17:42'!
allowedCharacters
	
	^ {
	self pacmanCharacter.
	self blinkyCharacter.
	self clydeCharacter.
	self wallCharacter.
	self bigPillCharacter.
	self smallPillCharacter.
	self spaceCharacter.
	}! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:24:06'!
bigPillCharacter
	
	^ $*! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:25'!
blinkyCharacter
	
	^$B! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:56:42'!
clydeCharacter
	
	^$C! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 16:41:25'!
pacmanCharacter
	
	^$p! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:24'!
smallPillCharacter
	
	^ $-! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:25:46'!
spaceCharacter
	
	^ $=! !

!StringPacmanBoard class methodsFor: 'elements characters' stamp: 'HAW 11/20/2024 17:26:06'!
wallCharacter
	
	^ $#! !


!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:12'!
blinkyName

	^ #blinky! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:29'!
clydeName

	^ #clyde! !

!StringPacmanBoard class methodsFor: 'character names' stamp: 'HAW 11/20/2024 17:02:05'!
pacmanName

	^ #pacman! !


!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/21/2024 19:59:27'!
asserltAllActorsAreIn: elementCharactersCount

	{ self pacmanName. self blinkyName. self clydeName } do: [ :aCharacterName | 
		self assertActorIsCorrect: aCharacterName in: elementCharactersCount ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:04'!
assert: anElementCharacter isAllowed: allowedCharacters

	(allowedCharacters includes: anElementCharacter) ifFalse: [ self error: (self notAllowCharaterErrorDescriptionFor: anElementCharacter) ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:48:41'!
assertActorIsCorrect: aCharacterName in: elements 
	
	| characterIdentifier |
	
	characterIdentifier := self perform: (aCharacterName, #Character) asSymbol.
	(elements includes: characterIdentifier)
		ifFalse: [ self error: (self characterIsMissingErrorDescriptionFor: aCharacterName) ].
		
	(elements occurrencesOf: characterIdentifier) > 1
		ifTrue: [ self error: (self shouldBeUniqueErrorDescriptionFor: aCharacterName) ].
! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:16'!
assertAllRowsHaveSameSizeIn: aStringRepresentation

	(aStringRepresentation allSatisfy: [ :aRow | aRow size = aStringRepresentation first size ]) ifFalse: [ 
		self error: self rowsMustHaveSameSizeErrorDescription ]! !

!StringPacmanBoard class methodsFor: 'assertions' stamp: 'HAW 11/20/2024 17:49:30'!
elementCharacterCountOf: aStringRepresentation

	| elementCharactersCount allowedCharacters |
	
	elementCharactersCount := Bag new.
	allowedCharacters := self allowedCharacters.
	
	aStringRepresentation do: [ :aRow |
		aRow do: [ :anElementCharacter | 
			self assert: anElementCharacter isAllowed: allowedCharacters.
			elementCharactersCount add: anElementCharacter ]].
	
	^elementCharactersCount ! !
