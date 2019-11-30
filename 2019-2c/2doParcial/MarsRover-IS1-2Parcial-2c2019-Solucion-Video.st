!classDefinition: #MarsRoverTest category: #'MarsRover-IS1-2Parcial-2c2019'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'marsMap randomInteger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:32:07'!
test01EmptyCommandStringDoesNothing

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: ''.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:32:38'!
test02fWhenHeadingNorthIncrementsY

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 1@3 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:33:00'!
test03bWhenHeadingNorthDecrementsY

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 1@1 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:34:11'!
test04rWhenHeadingNorthMakesMarsRoverPointToEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:34:03'!
test05lWhenHeadingNorthMakesMarsRovePointToWest

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:35:16'!
test06InvalidCommandsAreNotProcessed

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: #North) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:35:37'!
test07MoreThanOneCommandAreProcessedCorrectly

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'ff'.
	
	self assert: (marsRover isAt: 1@4 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:35:52'!
test08fWhenHeadingEastIncrementsX

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'f'.
	
	self assert: (marsRover isAt: 2@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:36:09'!
test09bWhenHeadingEastDecrementsX

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'b'.
	
	self assert: (marsRover isAt: 0@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:36:32'!
test10rWhenHeadingEastMakesMarsRoverPointToSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'r'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:37:31'!
test11lWhenHeadingEastMakesMarsRoverPointToNorth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:38:17'!
test12fbrAreProcessedCorrectlyWhenHeadingSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 1@1 heading: #West)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:38:40'!
test13lWhenHeadingSouthMakesMarsRoverPointToEast

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #South.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #East)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:39:01'!
test14fbrAreProcessedCorrectlyWhenHeadingWest

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'ffbr'.
	
	self assert: (marsRover isAt: 0@2 heading: #North)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:39:23'!
test15lWhenHeadingWestMakesMarsRoverPointToSouth

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #West.
	
	marsRover process: 'l'.
	
	self assert: (marsRover isAt: 1@2 heading: #South)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/24/2019 17:39:54'!
test16CanNotCreateAMarsRoverWithAnInvalidHeading

	self 
		should: [MarsRover at: 1@2 heading: #X ]
		raise: Error
		withExceptionDo: [:anError |
			self assert: MarsRover invalidCardinalPointErrorDescription equals: anError messageText ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 13:59:46'!
test17ForwardCanBeRepeated

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'f0'.
	
	self assert: (marsRover isAt: 1@5 heading: #North)
		! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:04:15'!
test18AnyCommandCanBeRepeated

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: 'b0'.
	
	self assert: (marsRover isAt: 1@-1 heading: #North)
		! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:07:10'!
test19CanNotRepeatARepeatCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: 'b00' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRepeatAReapeatCommandErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@-1 heading: #North) ]
		! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:10:23'!
test20CanNotRepeatNotExecutedCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: '0' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRepeatNotExecutedCommandErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
		! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:28:58'!
test21MovesForwardWithEarthGroundType

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@3 put: EarthGroundType new;
		yourself.
	
	marsRover process: 'f'.
	self assert: (marsRover isAt: 1@3 heading: #North)
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:41:08'!
test22CanNotMoveNorthIntoRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@3 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'f' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:41:18'!
test23CanNotMoveSouthIntoRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@1 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'b' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:41:42'!
test24CanNotMoveEastIntoRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 2@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'f' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #East) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:43:07'!
test25CanNotMoveWestIntoRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 0@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'b' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #East) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:48:57'!
test26CanNotPointToSouthWhenAtRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'r' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRotateWhenAtRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #East) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:49:20'!
test27CanNotPointToNorthWhenAtRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #East sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'l' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRotateWhenAtRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #East) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:50:34'!
test28CanNotPointToEastWhenAtRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'r' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRotateWhenAtRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 14:51:27'!
test29CanNotPointToWestWhenAtRock

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: 'l' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRotateWhenAtRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 15:01:30'!
test30MovingIntoIceIsUnpredictable

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	randomInteger := 3.
	marsMap := Dictionary new
		at: 1@3 put: (IceGroundType randomizingWith: self);
		yourself.
	
	marsRover process: 'f'.
	self assert: (marsRover isAt: 1@5 heading: #North)
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 15:11:52'!
test31RotatingRightOnIceIsUnpredictable

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	randomInteger := 2.
	marsMap := Dictionary new
		at: 1@2 put: (IceGroundType randomizingWith: self);
		yourself.
	
	marsRover process: 'r'.
	self assert: (marsRover isAt: 1@2 heading: #South)
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 15:12:05'!
test32RotatingLeftOnIceIsUnpredictable

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	randomInteger := 3.
	marsMap := Dictionary new
		at: 1@2 put: (IceGroundType randomizingWith: self);
		yourself.
	
	marsRover process: 'l'.
	self assert: (marsRover isAt: 1@2 heading: #East)
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/28/2019 15:18:41'!
test33WhenThereAreNoErrorMovingSafelyMovesRoverNormally

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: '(f)'.
	self assert: (marsRover isAt: 1@3 heading: #North)
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:03:46'!
test34ReturnsToOriginalPositionWhenReachingARockMovingForwardInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@3 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: '(f)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:05:55'!
test35ReturnsToOriginalPositionWhenReachingARockMovingForwardMoreThanOnceInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@4 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: '(ff)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:06:03'!
test36ReturnsToOriginalPositionWhenReachingARockMovingBackwardInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@0 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: '(bb)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:06:12'!
test37ReturnsToOriginalPositionWhenReachingIceInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@4 put: (IceGroundType randomizingWith: Random new);
		yourself.
	
	self 
		should: [ marsRover process: '(ff)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveSafelyIntoIceErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:06:20'!
test38ReturnsToOriginalPositionWhenRotatingOnIceOnSafeStateInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 1@2 put: (IceGroundType randomizingWith: Random new);
		yourself.
	
	self 
		should: [ marsRover process: '(r)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRotateSafelyIntoIceErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:06:38'!
test39CanNotEnterSafeStateWhenOnSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: '(f(' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotGoIntoSafeStateWhenAtSafeStateErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:07:00'!
test40CanNotLeaveSafeStateWhenAtUnsafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: ')' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotGoIntoUnsafeStateWhenAtUnsafeStateErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:07:20'!
test41CanProcessManySafeStates

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	marsRover process: '(f)(f)'.
	self assert: (marsRover isAt: 1@4 heading: #North) 
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:07:37'!
test42CanNotRepeatLeavingSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: '(f)0' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRepeatLeavingSafeStateErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@3 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:07:54'!
test43CanNotRepeatEnterIntoSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: '(0)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotRepeatEnterIntoSafeStateErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:08:14'!
test44CanNotEndInSafeState

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North.
	
	self 
		should: [ marsRover process: '(f' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotEndInSafeStateErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:08:42'!
test45RotateRightIsUndoneCorrectly

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 2@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: '(rf)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:08:55'!
test46RotateLeftIsUndoneCorrectly

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	marsMap := Dictionary new
		at: 0@2 put: RockType new;
		yourself.
	
	self 
		should: [ marsRover process: '(lf)' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover canNotMoveIntoRockErrorDescription equals: anError messageText.
			self assert: (marsRover isAt: 1@2 heading: #North) ]
	

! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 11/30/2019 08:09:16'!
test47FailsWhenAskingUndoOfInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: #North sensoringGroundWith: self.
	
	self 
		should: [ marsRover undoCommandOf: $x ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: marsRover invalidCommandErrorDescription equals: anError messageText ]
	

! !


!MarsRoverTest methodsFor: 'simulation' stamp: 'HAW 11/28/2019 15:32:39'!
groundTypeAt: aPosition

	^marsMap at: aPosition ifAbsent: [ EarthGroundType new ]! !

!MarsRoverTest methodsFor: 'simulation' stamp: 'HAW 11/28/2019 14:59:23'!
nextInteger: aLimit

	^randomInteger ! !


!classDefinition: #GroundSensor category: #'MarsRover-IS1-2Parcial-2c2019'!
Object subclass: #GroundSensor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!GroundSensor methodsFor: 'sensing' stamp: 'HAW 11/28/2019 15:15:21'!
groundTypeAt: aPosition

	self subclassResponsibility ! !


!classDefinition: #AllwaysEarthGroundSensor category: #'MarsRover-IS1-2Parcial-2c2019'!
GroundSensor subclass: #AllwaysEarthGroundSensor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!AllwaysEarthGroundSensor methodsFor: 'sensing' stamp: 'HAW 11/28/2019 14:26:07'!
groundTypeAt: aPosition

	^EarthGroundType new! !


!classDefinition: #GrountType category: #'MarsRover-IS1-2Parcial-2c2019'!
Object subclass: #GrountType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!GrountType methodsFor: 'rotating' stamp: 'HAW 11/28/2019 15:14:54'!
rotate: aMarsRover doing: aClosure 

	self subclassResponsibility ! !


!GrountType methodsFor: 'moving' stamp: 'HAW 11/28/2019 15:14:45'!
move: aMarsRover adding: anOffset  

	self subclassResponsibility ! !


!classDefinition: #EarthGroundType category: #'MarsRover-IS1-2Parcial-2c2019'!
GrountType subclass: #EarthGroundType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!EarthGroundType methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:37:26'!
move: aMarsRover adding: anOffset  
	
	aMarsRover moveWhenReachingEarthAdding: anOffset! !


!EarthGroundType methodsFor: 'rotating' stamp: 'HAW 11/28/2019 15:07:12'!
rotate: aMarsRover doing: aClosure 
	
	aMarsRover rotateWhenAtEarthDoing: aClosure ! !


!classDefinition: #IceGroundType category: #'MarsRover-IS1-2Parcial-2c2019'!
GrountType subclass: #IceGroundType
	instanceVariableNames: 'random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!IceGroundType methodsFor: 'initialization' stamp: 'HAW 11/28/2019 14:57:42'!
initializeRandomizingWith: aRandom 
	
	random := aRandom.! !


!IceGroundType methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:59:04'!
move: aMarsRover adding: anOffset

	aMarsRover moveWhenReachingIceAdding: (anOffset * (random nextInteger: 10))! !


!IceGroundType methodsFor: 'rotating' stamp: 'HAW 11/28/2019 15:09:23'!
rotate: aMarsRover doing: aClosure 
	
	aMarsRover rotateWhenAtIceDoing: [ (random nextInteger: 10) timesRepeat: aClosure ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IceGroundType class' category: #'MarsRover-IS1-2Parcial-2c2019'!
IceGroundType class
	instanceVariableNames: ''!

!IceGroundType class methodsFor: 'instance creation' stamp: 'HAW 11/28/2019 14:57:36'!
randomizingWith: aRandom

	^self new initializeRandomizingWith: aRandom! !


!classDefinition: #RockType category: #'MarsRover-IS1-2Parcial-2c2019'!
GrountType subclass: #RockType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!RockType methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:39:43'!
move: aMarsRover adding: anOffset  
	
	aMarsRover moveWhenReachingRockAdding: anOffset! !


!RockType methodsFor: 'rotating' stamp: 'HAW 11/28/2019 15:07:41'!
rotate: aMarsRover doing: aClosure 
	
	aMarsRover rotateWhenAtRockDoing: aClosure ! !


!classDefinition: #MarsRover category: #'MarsRover-IS1-2Parcial-2c2019'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head lastCommand groundSensor state safelyExecutedCommands'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 16:01:20'!
canNotEndInSafeStateErrorDescription
	
	^'Can not end in safe state'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 16:04:25'!
canNotGoIntoSafeStateWhenAtSafeStateErrorDescription
	
	^'Can not go into safe state when at safe state'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 16:04:34'!
canNotGoIntoUnsafeStateWhenAtUnsafeStateErrorDescription
	
	^'Can not go into unsafe state when at unsafe state'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 14:25:48'!
canNotMoveIntoRockErrorDescription
	
	^'Can not move into rock'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 15:41:31'!
canNotMoveSafelyIntoIceErrorDescription
	
	^'Can not move safely into ice'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 14:09:17'!
canNotRepeatAReapeatCommandErrorDescription
	
	^'Can not repeat a reapeat command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 15:58:35'!
canNotRepeatEnterIntoSafeStateErrorDescription
	
	^'Can not repeat enter into safe state'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 15:56:38'!
canNotRepeatLeavingSafeStateErrorDescription
	
	^'Can not repeat leaving safe state'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 14:12:34'!
canNotRepeatNotExecutedCommandErrorDescription
	
	^'There is no command to repeat'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 15:45:18'!
canNotRotateSafelyIntoIceErrorDescription
	
	^'Can not rotate safely into ice'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 11/28/2019 14:47:46'!
canNotRotateWhenAtRockErrorDescription
	
	^'Can not ratate when at rock'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 11/28/2019 15:46:19'!
initializeAt: aPosition heading: aHeading sensoringGroundWith: aGroundSensor 

	position := aPosition.
	head := aHeading.
	groundSensor := aGroundSensor.
	state := MoveUnsafelyState for: self! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:20'!
headEast
	
	head := MarsRoverHeadingEast new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:30'!
headNorth
	
	head := MarsRoverHeadingNorth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:16:05'!
headSouth
	
	head := MarsRoverHeadingSouth new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:14:38'!
headWest
	
	head := MarsRoverHeadingWest new! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 11/28/2019 15:11:42'!
rotateLeft
	
	(groundSensor groundTypeAt: position) rotate: self doing: [ head rotateLeft: self ]! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 11/28/2019 15:06:37'!
rotateRight
	
	(groundSensor groundTypeAt: position) rotate: self doing: [ head rotateRight: self ]! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 11/28/2019 16:09:09'!
hasExecutedCommand

	^ lastCommand isNil! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 8/22/2019 12:00:30'!
isAt: aPosition heading: aCardinalPoint

	^position = aPosition and: [ head isHeading: aCardinalPoint ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 11/28/2019 16:06:20'!
isEnterInSafeState: aCommand

	^ aCommand = $(! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 11/28/2019 16:06:32'!
isLeaveSafeState: aCommand

	^ aCommand = $)! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward
	
	head moveBackward: self! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:54:09'!
moveEast
	
	self moveAdding: 1@0.
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:55'!
moveForward
	
	head moveForward: self! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:54:45'!
moveNorth
	
	self moveAdding: 0@1
	! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:54:51'!
moveSouth
	
	self moveAdding: 0@-1
! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 11/28/2019 14:54:58'!
moveWest
	
	self moveAdding: -1@0
	! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 11/28/2019 16:09:39'!
assertCanRepeatCommand

	self hasExecutedCommand ifTrue: [ self error: self canNotRepeatNotExecutedCommandErrorDescription ].
	(self isRepeatCommand: lastCommand) ifTrue: [ self error: self canNotRepeatAReapeatCommandErrorDescription ].
	(self isLeaveSafeState: lastCommand) ifTrue: [self error: self canNotRepeatLeavingSafeStateErrorDescription ].
	(self isEnterInSafeState: lastCommand) ifTrue: [self error: self canNotRepeatEnterIntoSafeStateErrorDescription ]! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 11/28/2019 14:04:43'!
isRepeatCommand: aCommand

	^ aCommand isDigit! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 11/28/2019 16:00:35'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | 
		state processCommand: aCommand.
		lastCommand := aCommand ].
	
	state finishProcessing.
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 11/28/2019 15:53:21'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].
	(self isRepeatCommand: aCommand) ifTrue: [ ^self repeatLastCommand: aCommand digitValue + 2].
	
	self signalInvalidCommand.! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 11/28/2019 14:15:11'!
repeatLastCommand: aNumberOfTimes

	self assertCanRepeatCommand.
	
	^ aNumberOfTimes timesRepeat: [ self processCommand: lastCommand ]! !


!MarsRover methodsFor: 'heading - private' stamp: 'HAW 11/28/2019 15:45:03'!
rotateSafelyWhenAtIceDoing: aClosure 
	
	self error: self canNotRotateSafelyIntoIceErrorDescription! !

!MarsRover methodsFor: 'heading - private' stamp: 'HAW 11/28/2019 15:49:51'!
rotateUnsafelyWhenAtIceDoing: aClosure

	aClosure value! !

!MarsRover methodsFor: 'heading - private' stamp: 'HAW 11/28/2019 15:07:22'!
rotateWhenAtEarthDoing: aClosure 
	
	aClosure value! !

!MarsRover methodsFor: 'heading - private' stamp: 'HAW 11/28/2019 15:46:57'!
rotateWhenAtIceDoing: aClosure 
	
	state rotateWhenAtIceDoing: aClosure ! !

!MarsRover methodsFor: 'heading - private' stamp: 'HAW 11/28/2019 15:08:09'!
rotateWhenAtRockDoing: aClosure 
	
	self error: self canNotRotateWhenAtRockErrorDescription! !


!MarsRover methodsFor: 'processing - private' stamp: 'HAW 11/28/2019 16:03:06'!
finishProcessingSafely
	
	self undoSafelyExecutedCommands.
	self error: self canNotEndInSafeStateErrorDescription! !

!MarsRover methodsFor: 'processing - private' stamp: 'HAW 11/28/2019 16:03:32'!
finishProcessingUnsafely
	
	! !

!MarsRover methodsFor: 'processing - private' stamp: 'HAW 11/28/2019 16:06:32'!
processCommandSafely: aCommand

	[ (self isEnterInSafeState: aCommand) ifTrue: [ self error: self canNotGoIntoSafeStateWhenAtSafeStateErrorDescription ].
	(self isLeaveSafeState: aCommand) ifTrue: [ ^state := MoveUnsafelyState for: self ].
			
	self processCommand: aCommand.
	safelyExecutedCommands add: aCommand ]
		on: Error - MessageNotUnderstood 
		do: [ :anError |
			self undoSafelyExecutedCommands.
			anError pass ].
			! !

!MarsRover methodsFor: 'processing - private' stamp: 'HAW 11/28/2019 16:07:40'!
processCommandUnsafely: aCommand

	(self isEnterInSafeState: aCommand) ifTrue: [^self enterSafeState ].
	(self isLeaveSafeState: aCommand) ifTrue: [ ^self error: self canNotGoIntoUnsafeStateWhenAtUnsafeStateErrorDescription ].

	self processCommand: aCommand! !


!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 14:54:27'!
moveAdding: anOffset

	(groundSensor groundTypeAt: position + anOffset) move: self adding: anOffset ! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 15:41:18'!
moveSafelyIntoIceAdding: anOffset

	self error: self canNotMoveSafelyIntoIceErrorDescription! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 15:49:03'!
moveUnsafelyWhenReacingIceAdding: anOffset

	position := position + anOffset! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 14:38:51'!
moveWhenReachingEarthAdding: anOffset
	
	position := position + anOffset ! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 15:46:37'!
moveWhenReachingIceAdding: anOffset

	state moveWhenReachingIceAdding: anOffset ! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 14:39:43'!
moveWhenReachingRockAdding: anOffset
	
	self error: self canNotMoveIntoRockErrorDescription! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/30/2019 07:45:41'!
undoCommandOf: aCommand

	aCommand = $f ifTrue: [ ^$b ].
	aCommand = $b ifTrue: [ ^$f ].
	aCommand = $r ifTrue: [ ^$l ].
	aCommand = $l ifTrue: [ ^$r ].
	
	self signalInvalidCommand ! !

!MarsRover methodsFor: 'moving - private' stamp: 'HAW 11/28/2019 16:10:59'!
undoSafelyExecutedCommands

	^ safelyExecutedCommands reverseDo: [ :aCommandToUndo | 
		self processCommand: (self undoCommandOf: aCommandToUndo )]! !


!MarsRover methodsFor: 'state' stamp: 'HAW 11/28/2019 16:07:50'!
enterSafeState
 
	safelyExecutedCommands := OrderedCollection new.
	state := MoveSafelyState for: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 11/28/2019 14:20:38'!
at: aPosition heading: aCardinalPoint
	
	^self at: aPosition heading: aCardinalPoint sensoringGroundWith: AllwaysEarthGroundSensor new! !

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 11/28/2019 14:18:38'!
at: aPosition heading: aCardinalPoint sensoringGroundWith: aGroundSensor 
	
	^self new initializeAt: aPosition heading: (MarsRoverHeading heading: aCardinalPoint) sensoringGroundWith: aGroundSensor ! !


!MarsRover class methodsFor: 'exceptions' stamp: 'HAW 7/2/2018 16:26:14'!
invalidCardinalPointErrorDescription
	
	^'Invalid cardinal point'! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-IS1-2Parcial-2c2019'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:06:17'!
rotateLeft: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:08:23'!
rotateRight: aMarsRover

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 7/2/2018 19:07:42'!
isHeading: aCardinalPoint

	^self class isFor: aCardinalPoint! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:20'!
moveBackward: aMarsRover

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:05:54'!
moveForward: aMarsRover

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'cardinal point' stamp: 'HAW 7/2/2018 19:07:01'!
cardinalPoint

	self subclassResponsibility ! !


!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 8/22/2019 12:02:00'!
heading: aCardinalPoint

	^self subclasses 
		detect: [ :aMarsRoverPositionClass | aMarsRoverPositionClass isFor: aCardinalPoint ]
		ifFound: [ :aMarsRoverPositionClass | aMarsRoverPositionClass new ]
		ifNone: [ self error: MarsRover invalidCardinalPointErrorDescription ]! !


!MarsRoverHeading class methodsFor: 'testing' stamp: 'HAW 7/2/2018 17:01:33'!
isFor: aCardinalPoint

	^self cardinalPoint = aCardinalPoint ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:19'!
moveBackward: aMarsRover
	
	^aMarsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:09:28'!
moveForward: aMarsRover
	
	^aMarsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:42'!
rotateLeft: aMarsRover
	
	^aMarsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:09:54'!
rotateRight: aMarsRover
	
	^aMarsRover headSouth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingEast class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeadingEast class
	instanceVariableNames: ''!

!MarsRoverHeadingEast class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:01:53'!
cardinalPoint

	^#East! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:12'!
moveBackward: aMarsRover
	
	^aMarsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:10:23'!
moveForward: aMarsRover
	
	^aMarsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:40'!
rotateLeft: aMarsRover
	
	^aMarsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:10:51'!
rotateRight: aMarsRover
	
	^aMarsRover headEast! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingNorth class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeadingNorth class
	instanceVariableNames: ''!

!MarsRoverHeadingNorth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:11'!
cardinalPoint

	^#North! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:15'!
moveBackward: aMarsRover
	
	^aMarsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:11:25'!
moveForward: aMarsRover
	
	^aMarsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:55'!
rotateLeft: aMarsRover
	
	^aMarsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:11:50'!
rotateRight: aMarsRover
	
	^aMarsRover headWest! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingSouth class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeadingSouth class
	instanceVariableNames: ''!

!MarsRoverHeadingSouth class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:17'!
cardinalPoint

	^#South! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:07'!
moveBackward: aMarsRover

	^aMarsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:12:15'!
moveForward: aMarsRover
	
	^aMarsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:26'!
rotateLeft: aMarsRover
	
	^aMarsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 8/22/2019 12:12:41'!
rotateRight: aMarsRover
	
	^aMarsRover headNorth! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeadingWest class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverHeadingWest class
	instanceVariableNames: ''!

!MarsRoverHeadingWest class methodsFor: 'as yet unclassified' stamp: 'HAW 7/2/2018 17:03:23'!
cardinalPoint

	^#West! !


!classDefinition: #MarsRoverState category: #'MarsRover-IS1-2Parcial-2c2019'!
Object subclass: #MarsRoverState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MarsRoverState methodsFor: 'moving' stamp: 'HAW 11/30/2019 08:11:06'!
moveWhenReachingIceAdding: anOffset

	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'moving' stamp: 'HAW 11/30/2019 08:11:32'!
rotateWhenAtIceDoing: aClosure 

	self subclassResponsibility ! !


!MarsRoverState methodsFor: 'processing' stamp: 'HAW 11/30/2019 08:10:55'!
finishProcessing

	self subclassResponsibility ! !

!MarsRoverState methodsFor: 'processing' stamp: 'HAW 11/30/2019 08:11:20'!
processCommand: aCommand

	self subclassResponsibility ! !


!classDefinition: #MoveSafelyState category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverState subclass: #MoveSafelyState
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MoveSafelyState methodsFor: 'initialization' stamp: 'HAW 11/28/2019 15:23:57'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MoveSafelyState methodsFor: 'processing' stamp: 'HAW 11/28/2019 16:00:55'!
finishProcessing
	
	marsRover finishProcessingSafely! !

!MoveSafelyState methodsFor: 'processing' stamp: 'HAW 11/28/2019 15:24:24'!
processCommand: aCommand

	marsRover processCommandSafely: aCommand ! !


!MoveSafelyState methodsFor: 'moving' stamp: 'HAW 11/28/2019 15:40:59'!
moveWhenReachingIceAdding: anOffset

	marsRover moveSafelyIntoIceAdding: anOffset ! !

!MoveSafelyState methodsFor: 'moving' stamp: 'HAW 11/28/2019 15:44:47'!
rotateWhenAtIceDoing: aClosure 
	
	marsRover rotateSafelyWhenAtIceDoing: aClosure ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveSafelyState class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MoveSafelyState class
	instanceVariableNames: ''!

!MoveSafelyState class methodsFor: 'instance creation' stamp: 'HAW 11/28/2019 15:23:47'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !


!classDefinition: #MoveUnsafelyState category: #'MarsRover-IS1-2Parcial-2c2019'!
MarsRoverState subclass: #MoveUnsafelyState
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-IS1-2Parcial-2c2019'!

!MoveUnsafelyState methodsFor: 'initialization' stamp: 'HAW 11/28/2019 15:47:12'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !


!MoveUnsafelyState methodsFor: 'processing' stamp: 'HAW 11/28/2019 16:03:26'!
finishProcessing
	
	marsRover finishProcessingUnsafely! !

!MoveUnsafelyState methodsFor: 'processing' stamp: 'HAW 11/28/2019 15:47:46'!
processCommand: aCommand

	marsRover processCommandUnsafely: aCommand! !


!MoveUnsafelyState methodsFor: 'moving' stamp: 'HAW 11/28/2019 15:48:32'!
moveWhenReachingIceAdding: anOffset

	marsRover moveUnsafelyWhenReacingIceAdding: anOffset ! !

!MoveUnsafelyState methodsFor: 'moving' stamp: 'HAW 11/28/2019 15:49:29'!
rotateWhenAtIceDoing: aClosure 
	
	marsRover rotateUnsafelyWhenAtIceDoing: aClosure ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MoveUnsafelyState class' category: #'MarsRover-IS1-2Parcial-2c2019'!
MoveUnsafelyState class
	instanceVariableNames: ''!

!MoveUnsafelyState class methodsFor: 'instance creation' stamp: 'HAW 11/28/2019 15:47:06'!
for: aMarsRover 

	^self new initializeFor: aMarsRover ! !
