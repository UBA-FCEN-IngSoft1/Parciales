!classDefinition: #MarsRoverTest category: #MarsRover!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

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


!classDefinition: #MarsRover category: #MarsRover!
Object subclass: #MarsRover
	instanceVariableNames: 'position heading'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:33:39'!
addToPosition: aPoint 
	
	 position := position + aPoint ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:05:48'!
initializeAt: aMarsRoverPositionHeading
	
	position := aMarsRoverPositionHeading ! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 13:17:50'!
initializeAt: aPosition heading: aMarsRoverHeading

	position := aPosition.
	heading := aMarsRoverHeading! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/1/2018 14:25:05'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ heading cardinalPoint = aCardinalPoint ]! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:18:45'!
moveBackward
	
	self addToPosition: heading backwardPoint! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:18:18'!
moveForward
	
	self addToPosition: heading forwardPoint! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:34:39'!
newHeadingFor: aCardinalPoint

	heading := self class headingFor: aCardinalPoint ! !

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

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:19:45'!
rotateLeft
	
	self newHeadingFor: heading leftCardinalPoint! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 7/6/2018 18:19:20'!
rotateRight
	
	self newHeadingFor: heading rightCardinalPoint! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #MarsRover!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:19:41'!
at: aPosition heading: aCardinalPoint
	
	| newHeading |

	newHeading := self headingFor: aCardinalPoint.
	
	^self new initializeAt: aPosition heading: newHeading ! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 16:28:16'!
headingFor: aCardinalPoint
	
	^headings at: aCardinalPoint ifAbsent: [ self error: self invalidCardinalPointErrorDescription ]! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:27:41'!
initialize

	self initializeHeadings! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:30:25'!
initializeHeadings

	headings := Dictionary new.
	
	(OrderedCollection 
		with: (MarsRoverHeading for: #North forwardWith: 0@1 backwardWith: 0@-1 rightCardinalPoint: #East leftCardinalPoint: #West)	
		with: (MarsRoverHeading for: #East forwardWith: 1@0 backwardWith: -1@0 rightCardinalPoint: #South leftCardinalPoint: #North)
		with: (MarsRoverHeading for: #South forwardWith: 0@-1 backwardWith: 0@1 rightCardinalPoint: #West leftCardinalPoint: #East)
		with: (MarsRoverHeading for: #West forwardWith: -1@0 backwardWith: 1@0 rightCardinalPoint: #North leftCardinalPoint: #South))
			do: [ :heading | headings at: heading cardinalPoint put: heading ]! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: #MarsRover!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'cardinalPoint forwardPoint backwardPoint rightCardinalPoint leftCardinalPoint'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:30:48'!
backwardPoint
	
	^backwardPoint! !

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:29:44'!
cardinalPoint
	
	^cardinalPoint! !

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:30:39'!
forwardPoint
	
	^forwardPoint! !

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:29:30'!
initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: aRightCardinalPoint leftCardinalPoint: aLeftCardinalPoint
	
	cardinalPoint := aCardinalPoint.
	forwardPoint := aForwardPoint.
	backwardPoint := aBackwardPoint.
	rightCardinalPoint := aRightCardinalPoint.
	leftCardinalPoint := aLeftCardinalPoint ! !

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:31:58'!
leftCardinalPoint
	
	^leftCardinalPoint! !

!MarsRoverHeading methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:30:59'!
rightCardinalPoint
	
	^rightCardinalPoint! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #MarsRover!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 15:28:34'!
for: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint

	^self new initializeFor: aCardinalPoint forwardWith: aForwardPoint backwardWith: aBackwardPoint rightCardinalPoint: rightCardinalPoint leftCardinalPoint: leftCardinalPoint
	! !

MarsRover initialize!