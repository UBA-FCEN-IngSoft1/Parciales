!classDefinition: #MarsRoverTest category: #'MarsRover-With MarsRoverPosition Hierarchy'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:26'!
test01

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:31'!
test02

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:34'!
test03

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:38'!
test04

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:45'!
test05

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:50'!
test06

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:54'!
test07

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:23:59'!
test08

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:06'!
test09

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:12'!
test10

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:20'!
test11

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:25'!
test12

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:29'!
test13

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:33'!
test14

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:24:37'!
test15

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 16:27:43'!
test16

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !


!classDefinition: #MarsRover category: #'MarsRover-With MarsRoverPosition Hierarchy'!
Object subclass: #MarsRover
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:05:48'!
initializeAt: aMarsRoverPositionHeading
	
	position := aMarsRoverPositionHeading ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:07:53'!
isAt: aPosition heading: aCardinalPoint

	^position isAt: aPosition heading: aCardinalPoint ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:23:09'!
moveBackward
	
	position := position backward! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:22:54'!
moveForward
	
	position := position forward! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:19:33'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:26:11'!
rotateLeft
	
	position := position rotateLeft! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:38'!
rotateRight
	
	position := position rotateRight! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 16:56:54'!
at: aPosition heading: aCardinalPoint
	
	^self new initializeAt: (MarsRoverPosition at: aPosition heading: aCardinalPoint)! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverPosition category: #'MarsRover-With MarsRoverPosition Hierarchy'!
Object subclass: #MarsRoverPosition
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:08:17'!
backward

	self subclassResponsibility ! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:08:06'!
forward

	self subclassResponsibility ! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:05:19'!
initializeAt: aPosition

	position := aPosition ! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:07:28'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ self isHeading: aCardinalPoint ]! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:39:39'!
newAt: aPosition

	^self class newAt: aPosition ! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:08:21'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverPosition methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:08:23'!
rotateRight

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPosition class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPosition class
	instanceVariableNames: ''!

!MarsRoverPosition class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:05:47'!
at: aPosition heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass newAt: aPosition ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !

!MarsRoverPosition class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !

!MarsRoverPosition class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !

!MarsRoverPosition class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:05:05'!
newAt: aPosition

	^self new initializeAt: aPosition ! !


!classDefinition: #MarsRoverPositionHeadingEast category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPosition subclass: #MarsRoverPositionHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverPositionHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:43:13'!
backward
	
	^self newAt: position + (-1@0)! !

!MarsRoverPositionHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:41:12'!
forward
	
	^self newAt: position + (1@0)! !

!MarsRoverPositionHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:49'!
rotateLeft
	
	^MarsRoverPositionHeadingNorth newAt: position ! !

!MarsRoverPositionHeadingEast methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:20'!
rotateRight
	
	^MarsRoverPositionHeadingSouth newAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionHeadingEast class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPositionHeadingEast class
	instanceVariableNames: ''!

!MarsRoverPositionHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverPositionHeadingNorth category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPosition subclass: #MarsRoverPositionHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverPositionHeadingNorth methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:40:01'!
backward
	
	^self newAt: position + (0@-1)! !

!MarsRoverPositionHeadingNorth methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:38:33'!
forward
	
	^self newAt: position + (0@1)! !

!MarsRoverPositionHeadingNorth methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:58'!
rotateLeft
	
	^MarsRoverPositionHeadingWest newAt: position ! !

!MarsRoverPositionHeadingNorth methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:23'!
rotateRight
	
	^MarsRoverPositionHeadingEast newAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionHeadingNorth class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPositionHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverPositionHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverPositionHeadingSouth category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPosition subclass: #MarsRoverPositionHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverPositionHeadingSouth methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:59:07'!
backward
	
	^self newAt: position + (0@1)! !

!MarsRoverPositionHeadingSouth methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 18:46:20'!
forward
	
	^self newAt: position +(0@-1)! !

!MarsRoverPositionHeadingSouth methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:26:02'!
rotateLeft
	
	^MarsRoverPositionHeadingEast newAt: position ! !

!MarsRoverPositionHeadingSouth methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:26'!
rotateRight
	
	^MarsRoverPositionHeadingWest newAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionHeadingSouth class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPositionHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverPositionHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverPositionHeadingWest category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPosition subclass: #MarsRoverPositionHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-With MarsRoverPosition Hierarchy'!

!MarsRoverPositionHeadingWest methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:00:25'!
backward

	^self newAt: position + (1@0)! !

!MarsRoverPositionHeadingWest methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 19:00:06'!
forward
	
	^self newAt: position + (-1@0)! !

!MarsRoverPositionHeadingWest methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:26:05'!
rotateLeft
	
	^MarsRoverPositionHeadingSouth newAt: position ! !

!MarsRoverPositionHeadingWest methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:25:29'!
rotateRight
	
	^MarsRoverPositionHeadingNorth newAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverPositionHeadingWest class' category: #'MarsRover-With MarsRoverPosition Hierarchy'!
MarsRoverPositionHeadingWest class
	instanceVariableNames: ''!

!MarsRoverPositionHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !
