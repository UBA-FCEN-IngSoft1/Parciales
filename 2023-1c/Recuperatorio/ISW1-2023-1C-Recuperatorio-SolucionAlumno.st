!classDefinition: #DrivingAssistantTest category: 'ISW1-2023-1C-Recuperatorio'!
TestCase subclass: #DrivingAssistantTest
	instanceVariableNames: 'clockOffset'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:10:16'!
test01IsAtRightStateWhenTurnOn

	| assistant sensorSystem drivingSystem frontDistanceSensor speedSensor laneAlignmentSensor |
	
	speedSensor := ReadStream on: {}.
	frontDistanceSensor := ReadStream on: {}.
	laneAlignmentSensor := ReadStream on: {}.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor alignmentFrom: laneAlignmentSensor.
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant readingSensorsFrom: sensorSystem sendingActionsTo: drivingSystem in: self manualMode.
	
	self assert: 0*kilometer / hour equals: assistant speed.
	self assertProximityBeepIsOffOn: assistant.
	self assertIsAceleratingOn: assistant.
	self assertNoTargetSpeedOn: assistant.
	self assertLaneAlignmentBeepIsOffOn: assistant.
	self assertIsGoingStraightOn: assistant.
	self assertIsTurnSignalOffOn: assistant
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:12:55'!
test02ProximityBeepIsOffWhenNoObjectIfFront

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:00'!
test03ProximityBeepIsInDangerWhenInDangerZoneClosestLimit

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
	
	
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:05'!
test04ProximityBeepIsInDangerWhenInDangerZoneFartherLimit

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:13'!
test05ProximityBeepIsInWarningWhenInWarningZoneClosestLimit

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:17'!
test06ProximityBeepIsInWarningWhenInWarningZoneFartherLimit

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.		
			self assertProximityBeepIsInWarningOn: assistant.		
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:20'!
test07ProximityBeepIsOffWhenInSafeZone

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.	
			self assertProximityBeepIsOffOn: assistant.	
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:23'!
test08BreaksWhenInDangerZoneClosestLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
	
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:27'!
test09BreaksInDangerWhenInDangerZoneFartherLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit
		with: self automaticMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:30'!
test10DesacelerateWhenInWarningZoneClosestLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:34'!
test11DesacelerateWhenInWarningZoneFartherLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:37'!
test12KeepsTargetSpeedWhenInSafeZoneAndAutomaticMode

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:40'!
test13KeepsTargetSpeedWhenNoObjectInFrontAndAutomaticMode

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:43'!
test14CombinesModesWhenInDangerZoneClosestLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:46'!
test15CombinesModesWhenInDangerZoneFartherLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:49'!
test16CombinesModesWhenInWarningZoneClosestLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:51'!
test17CombinesModesWhenInWarningZoneFartherLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:54'!
test18CombinesModesWhenInSafeZoneAndManualWithAssistance

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:13:58'!
test19CombinesModesWhenNoObjectInFrontAndManualWithAssistance

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/13/2023 11:20:12'!
test20TakesTargetSpeedFromAutomaticModeWhenTurnOn

	self assertTargetSpeedIsTheOriginalWhenCreatedIn: self automaticMode.
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/13/2023 11:20:25'!
test21TakesTargetSpeedFromAssistedManualModeWhenTurnOn

	self assertTargetSpeedIsTheOriginalWhenCreatedIn: self assistedManualMode.
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:16:23'!
test22LaneAlignmentBeepIsOffWhenCentered

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:21:02'!
test23LaneAlignmentBeepIsOnWhenShiftedLeft

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 18:32:55'!
test24LaneAlignmentBeepIsOnWhenShiftedRight

	self 
		whenLaneAlignmentIs: #shiftedRight
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:10:32'!
test25LaneAlignmentBeepIsOffWhenShiftedLeftAndTurningLeft

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self manualMode
		beforeTickDo: [ :assistant | assistant signalTurnLeft ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:11:07'!
test26LaneAlignmentBeepIsOffWhenShiftedRightAndTurningRight

	self 
		whenLaneAlignmentIs: #shiftedRight
		with: self manualMode
		beforeTickDo: [ :assistant | assistant signalTurnRight ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalRightOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:12:16'!
test27LaneAlignmentBeepIsOnWhenCenteredAndSignalingLeftFor2Minutes

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode
		beforeTickDo: [ :assistant |
			assistant signalTurnLeft.
			self advanceClock: 2*minute ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:13:17'!
test28LaneAlignmentBeepIsOnWhenCenteredAndSignalingLeftForMoreThan2Minutes

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode
		beforeTickDo: [ :assistant |
			assistant signalTurnLeft.
			self advanceClock: ((2*minute) + (1*millisecond)) ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:13:57'!
test29LaneAlignmentBeepIsOffWhenCenteredAndNotSignaling

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode
		beforeTickDo: [ :assistant |
			assistant turnOffTurnSignal.
			self advanceClock: 2*minute ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:14:46'!
test30LaneAlignmentBeepIsOnWhenCenteredAndSignalingRight

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode
		beforeTickDo: [ :assistant |
			assistant signalTurnRight.
			self advanceClock: 2*minute ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalRightOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:16:12'!
test31LaneAlignmentBeepTurnsOffWhenSignalTurnsOff

	self 
		whenLaneAlignmentIs: #centered
		with: self manualMode
		beforeTickDo: [ :assistant |
			assistant signalTurnRight.
			self advanceClock: 2*minute ]
		afterTickDo: [ :assistant |
			assistant turnOffTurnSignal.
			assistant tick ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 20:42:14'!
test32SteerLeftWhenDeviatingRightInAutomaticMode

	self 
		whenLaneAlignmentIs: #shiftedRight
		with: self automaticMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsSteeringLeftOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:21'!
test33SteerRightWhenDeviatingLeftInAutomaticMode

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self automaticMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsSteeringRightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:33'!
test34LaneAlignmentBeepIsOnWhenCenteredAndSignalingForMoreThan1MinuteInAutomaticMode

	self 
		whenLaneAlignmentIs: #centered
		with: self automaticMode
		beforeTickDo: [ :assistant |
			assistant signalTurnLeft.
			self advanceClock: ((1*minute) + (1*millisecond)) ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:39'!
test35LaneAlignmentBeepTurnsOffWhenSignalTurnsOffInAutomaticMode

	self 
		whenLaneAlignmentIs: #centered
		with: self automaticMode
		beforeTickDo: [ :assistant |
			assistant signalTurnLeft.
			self advanceClock: ((1*minute) + (1*millisecond)) ]
		afterTickDo: [ :assistant |
			assistant turnOffTurnSignal.
			assistant tick ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:44'!
test36SteerStraightWhenWellAlignedInAutomaticMode

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self automaticMode
		beforeTickDo: [ :assistant ]
		afterTickDo: [ :assistant |
			assistant signalTurnLeft.
			assistant tick ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:50'!
test37CombinesModesWhenDeviatingLeftInAssistedManualMode

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self assistedManualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsSteeringRightOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:24:55'!
test38CombinesModesWhenDeviatingRightInAssistedManualMode

	self 
		whenLaneAlignmentIs: #shiftedRight
		with: self assistedManualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsSteeringLeftOn: assistant.
			self assertIsTurnSignalOffOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:25:03'!
test39BehavesLikeAutomaticModeWhenNotTurningOnTimeInAssistedManualMode

	self 
		whenLaneAlignmentIs: #centered
		with: self assistedManualMode
		beforeTickDo: [ :assistant |
			assistant signalTurnLeft.
			self advanceClock: ((1*minute) + (1*millisecond)) ]
		afterTickDo: [ :assistant ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOnOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'TM 7/17/2023 21:25:11'!
test40BehavesLikeAutomaticModeWhenWellAlignedInAssistedManualMode

	self 
		whenLaneAlignmentIs: #shiftedLeft
		with: self assistedManualMode
		beforeTickDo: [ :assistant ]
		afterTickDo: [ :assistant |
			assistant signalTurnLeft.
			assistant tick ]
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant.
			self assertLaneAlignmentBeepIsOffOn: assistant.
			self assertIsGoingStraightOn: assistant.
			self assertIsTurnSignalLeftOn: assistant]! !


!DrivingAssistantTest methodsFor: 'driving mode' stamp: 'HAW 7/7/2023 11:20:47'!
assistedManualMode
	
	^AssistedManualMode targeting: self targetSpeed ! !

!DrivingAssistantTest methodsFor: 'driving mode' stamp: 'HAW 7/6/2023 12:02:41'!
automaticMode

	^ AutomaticMode targeting: self targetSpeed! !

!DrivingAssistantTest methodsFor: 'driving mode' stamp: 'HAW 7/5/2023 18:34:29'!
manualMode
	
	^ManualMode new! !

!DrivingAssistantTest methodsFor: 'driving mode' stamp: 'HAW 7/6/2023 12:05:26'!
targetSpeed

	^ 90*kilometer /hour! !


!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/6/2023 11:40:23'!
inDangerZoneClosestLimit

	^ 0*meter! !

!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/6/2023 15:59:37'!
inDangerZoneFartherLimit
	
	^self sensorSpeed^2 / (180000*kilometer / (hour^2))! !

!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/6/2023 15:59:48'!
inSafeZone
	
	^self inWarningZoneFartherLimit + (1*millimeter)! !

!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/6/2023 15:59:37'!
inWarningZoneClosestLimit
	
	^self inDangerZoneFartherLimit + (1*millimeter)! !

!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/6/2023 15:59:48'!
inWarningZoneFartherLimit
	
	^self inDangerZoneFartherLimit * 2! !

!DrivingAssistantTest methodsFor: 'front object zone' stamp: 'HAW 7/5/2023 18:02:57'!
noObjectInFront

	^ nil! !


!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:22:35'!
assertBrakingOn: assistant

	self deny: assistant isThrottleConnected.
	self deny: assistant areBrakesOff! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 16:03:19'!
assertCurrentSpeedIsSensorSpeedOn: assistant

	^ self assert: self sensorSpeed equals: assistant speed! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:22:39'!
assertDesaceleratingOn: assistant

	self deny: assistant isThrottleConnected.
	self assert: assistant areBrakesOff! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 16:02:40'!
assertIsAceleratingOn: assistant

	self assert: assistant isThrottleConnected.
	self assert: assistant areBrakesOff! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 17:38:39'!
assertIsGoingStraightOn: assistant 

	self assert: assistant isGoingStraight.
	self deny: assistant isSteeringLeft.
	self deny: assistant isSteeringRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 20:42:40'!
assertIsSteeringLeftOn: assistant

	self deny: assistant isGoingStraight.
	self assert: assistant isSteeringLeft.
	self deny: assistant isSteeringRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 20:33:03'!
assertIsSteeringRightOn: assistant

	self deny: assistant isGoingStraight.
	self deny: assistant isSteeringLeft.
	self assert: assistant isSteeringRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 18:52:39'!
assertIsTurnSignalLeftOn: assistant 
	
	self deny: assistant isTurnSignalOff.
	self assert: assistant isTurnSignalLeft.
	self deny: assistant isTurnSignalRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 17:57:04'!
assertIsTurnSignalOffOn: assistant 

	self assert: assistant isTurnSignalOff.
	self deny: assistant isTurnSignalLeft.
	self deny: assistant isTurnSignalRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 18:57:29'!
assertIsTurnSignalRightOn: assistant 
	
	self deny: assistant isTurnSignalOff.
	self deny: assistant isTurnSignalLeft.
	self assert: assistant isTurnSignalRight! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 18:11:51'!
assertLaneAlignmentBeepIsOffOn: assistant

	self deny: assistant isLaneAlignmentBeepOn! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 18:21:28'!
assertLaneAlignmentBeepIsOnOn: assistant 

	self assert: assistant isLaneAlignmentBeepOn! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:01:53'!
assertNoTargetSpeedOn: assistant

	^ self assert:  'no target speed' equals: (assistant targetSpeedIfNone: [ 'no target speed' ])! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:16:03'!
assertProximityBeepIsInDangerOn: assistant

	self deny: assistant isProximityBeepOff.
	self assert: assistant isProximityBeepInDanger.
	self deny: assistant isProximityBeepInWarning! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:16:10'!
assertProximityBeepIsInWarningOn: assistant

	self deny: assistant isProximityBeepOff.
	self deny: assistant isProximityBeepInDanger.
	self assert: assistant isProximityBeepInWarning! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 12:16:17'!
assertProximityBeepIsOffOn: assistant

	self assert: assistant isProximityBeepOff.
	self deny: assistant isProximityBeepInDanger.
	self deny: assistant isProximityBeepInWarning! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 20:04:04'!
assertReducesTargetSpeedForDangerZoneOn: assistant

	^ self assertTargetSpeedReducesBy: AutomaticMode dangerZoneSpeedReduction lessThanCurrentOn: assistant! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 20:04:04'!
assertReducesTargetSpeedForWarningZoneOn: assistant

	^self assertTargetSpeedReducesBy: AutomaticMode warningZoneSpeedReduction lessThanCurrentOn: assistant ! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/7/2023 11:15:34'!
assertTargetSpeedIsTheOriginalOn: assistant

	^ self assert: self targetSpeed equals: (assistant targetSpeedIfNone: [ self fail ])! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 18:14:15'!
assertTargetSpeedIsTheOriginalWhenCreatedIn: aMode

	| assistant sensorSystem drivingSystem frontDistanceSensor speedSensor laneAlignmentSensor |
	
	speedSensor := ReadStream on: {}.
	frontDistanceSensor := ReadStream on: {}.
	laneAlignmentSensor := ReadStream on: {}.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor alignmentFrom: laneAlignmentSensor.
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant readingSensorsFrom: sensorSystem sendingActionsTo: drivingSystem in: aMode.
	
	self assert: 0*kilometer / hour equals: assistant speed.
	self assertProximityBeepIsOffOn: assistant.
	self assertIsAceleratingOn: assistant.
	self assertTargetSpeedIsTheOriginalOn: assistant.
	self assertLaneAlignmentBeepIsOffOn: assistant.
	self assertIsGoingStraightOn: assistant.
	self assertIsTurnSignalOffOn: assistant! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 20:04:04'!
assertTargetSpeedReducesBy: aSpeed lessThanCurrentOn: assistant

	^ self assert:  (100*kilometer /hour) - aSpeed equals: (assistant targetSpeedIfNone: [ self fail ])! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 17:50:55'!
whenFrontObjectAt: aZone with: aMode assert: assertions

	| assistant sensorSystem drivingSystem speedSensor frontDistanceSensor laneAlignmentSensor |
	
	speedSensor := ReadStream on: { self sensorSpeed. }.
	frontDistanceSensor := ReadStream on: { aZone }.
	laneAlignmentSensor := ReadStream on: { }.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor alignmentFrom: laneAlignmentSensor.
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant 
		readingSensorsFrom: sensorSystem 
		sendingActionsTo: drivingSystem 
		in: aMode.
	
	assistant tick.
	
	assertions value: assistant! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 20:08:05'!
whenLaneAlignmentIs: anAlignment with: aMode assert: assertions

	self
		whenLaneAlignmentIs: anAlignment
		with: aMode
		beforeTickDo: [ :assistant ]
		afterTickDo: [ :assistant ]
		assert: assertions! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'TM 7/17/2023 20:06:06'!
whenLaneAlignmentIs: anAlignment with: aMode beforeTickDo: beforeTick afterTickDo: afterTick assert: assertions

	| assistant sensorSystem drivingSystem speedSensor frontDistanceSensor laneAlignmentSensor |
	
	speedSensor := ReadStream on: { self sensorSpeed. self sensorSpeed. }.
	frontDistanceSensor := ReadStream on: { self inSafeZone. self inSafeZone }.
	laneAlignmentSensor := ReadStream on: { anAlignment. anAlignment }.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor alignmentFrom: laneAlignmentSensor.
	drivingSystem := DrivingSystem new.
	
	assistant := DrivingAssistant 
		readingSensorsFrom: sensorSystem 
		sendingActionsTo: drivingSystem 
		in: aMode
		withClock: self.
	
	beforeTick value: assistant.
	
	assistant tick.
	
	afterTick value: assistant.
	
	assertions value: assistant! !


!DrivingAssistantTest methodsFor: 'speed' stamp: 'HAW 7/6/2023 15:57:30'!
sensorSpeed

	^ 100*kilometer / hour! !



!DrivingAssistantTest methodsFor: 'clock simulation' stamp: 'TM 7/17/2023 19:22:44'!
advanceClock: aTimeInterval

	clockOffset := clockOffset + aTimeInterval! !

!DrivingAssistantTest methodsFor: 'clock simulation' stamp: 'TM 7/17/2023 19:25:28'!
now

	^GregorianDateTime now next: clockOffset! !

!DrivingAssistantTest methodsFor: 'clock simulation' stamp: 'TM 7/17/2023 19:23:39'!
resetClock

	clockOffset := 0! !

!DrivingAssistantTest methodsFor: 'clock simulation' stamp: 'TM 7/17/2023 19:23:26'!
retardClock: aTimeInterval

	clockOffset := clockOffset - aTimeInterval! !

!DrivingAssistantTest methodsFor: 'clock simulation' stamp: 'TM 7/17/2023 19:44:15'!
theEndOfTime

	^GregorianDateTime theEndOfTime! !


!DrivingAssistantTest methodsFor: 'setUp/tearDown' stamp: 'TM 7/17/2023 19:28:00'!
setUp

	self resetClock! !


!classDefinition: #DrivingAssistant category: 'ISW1-2023-1C-Recuperatorio'!
Object subclass: #DrivingAssistant
	instanceVariableNames: 'sensorSystem drivingSystem speed mode minimunBrakingDistance clock lastSignaledOn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!DrivingAssistant methodsFor: 'initialization' stamp: 'TM 7/17/2023 19:43:28'!
initializeReadingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode withClock: aClock
	
	sensorSystem := aSensorSystem.
	drivingSystem := aDrivingSystem.
	mode := aMode.
	
	speed := 0 * kilometer / hour.
	aMode installOn: self.
	
	clock := aClock.
	lastSignaledOn := clock theEndOfTime.! !


!DrivingAssistant methodsFor: 'ticking' stamp: 'TM 7/17/2023 18:22:59'!
tick
	
	| distanceToFrontObject laneAlignment |
	
	speed := sensorSystem readSpeedSenor.
	distanceToFrontObject := sensorSystem readFrontDistanceSensor.
	laneAlignment := sensorSystem readLaneAlignmentSenor.
	
	self actOnFrontObject: distanceToFrontObject.
	self actOnLaneAlignment: laneAlignment! !


!DrivingAssistant methodsFor: 'brakes' stamp: 'HAW 7/5/2023 18:43:30'!
areBrakesOff
	
	^drivingSystem areBrakesOff! !


!DrivingAssistant methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:55:53'!
isProximityBeepInDanger
	
	^drivingSystem isProximityBeepInDanger! !

!DrivingAssistant methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:56:22'!
isProximityBeepInWarning
	
	^drivingSystem isProximityBeepInWarning! !

!DrivingAssistant methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:55:13'!
isProximityBeepOff
	
	^drivingSystem isProximityBeepOff! !


!DrivingAssistant methodsFor: 'throttle' stamp: 'HAW 7/5/2023 18:43:17'!
isThrottleConnected
	
	^drivingSystem isThrottleConnected! !


!DrivingAssistant methodsFor: 'speed' stamp: 'HAW 7/7/2023 11:18:44'!
keepSpeedAt: aTargetSpeed 
	
	drivingSystem keepSpeedAt: aTargetSpeed ! !

!DrivingAssistant methodsFor: 'speed' stamp: 'HAW 7/5/2023 17:47:15'!
speed
	
	^speed ! !

!DrivingAssistant methodsFor: 'speed' stamp: 'HAW 7/5/2023 18:46:33'!
targetSpeedIfNone: noTargetSpeedBlock 
	
	^drivingSystem targetSpeedIfNone: noTargetSpeedBlock 
! !


!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 15:48:18'!
actOnFrontObject: distanceToFrontObject
	
	minimunBrakingDistance :=  speed^2/(180000*kilometer / (hour^2)).
	
	(self hasNoObjectInFront: distanceToFrontObject) ifTrue: [^ mode noObjectInFrontFor: self ].
	(self isInDangerZone: distanceToFrontObject) ifTrue: [ ^mode frontObjectInDangerZoneFor: self ].
	(self isInWarningZone: distanceToFrontObject) ifTrue: [ ^mode frontObjectInWarningZoneFor: self ].
	mode frontObjectInSafeZoneFor: self.
	
	"Como no hay posibilidad que las lecturas del sensor sean erróneas y no hay límite de la zona segura, 
	es que asumo que si el objeto no está en las otras zonas debe estar definitivamente en la zona segura 
	y por eso no hay un caso de error - Hernan"
! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:18:21'!
hasNoObjectInFront: distanceToFrontObject 
	
	^distanceToFrontObject isNil! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:20:07'!
isInDangerZone: distanceToFrontObject

	^ distanceToFrontObject <= minimunBrakingDistance! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/13/2023 11:25:32'!
isInWarningZone: distanceToFrontObject

	"No estoy probando que minimunBrakingDistance < distanceToFrontObject por como está construido
	actOnFrontObject: 
	Esto genera un acoplamiento no explicito, pero si pongo esa condición no se cubre todo con los tests y habría que hacer
	uno solo para cubrir la condición. 
	Lo dejo así porque es un mensaje interno, se envía en un solo lugar de manera controlada y si cambiase como se lo envía 
	debería fallar algún test, pero es riesgoso y no siempre conviene hacerlo así - Hernan"  
	^ distanceToFrontObject <= (minimunBrakingDistance*2)! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:15:49'!
noObjectInFronWhenAutomatic
	
	self objectInSafeZoneWhenAutomatic ! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:16:16'!
noObjectInFrontWhenManual
	
	 drivingSystem turnOffProximityBeep ! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 15:49:07'!
objectInDangerZoneWhenInAutomatic
	
	drivingSystem 
		applyBrakes;
		disconnectThrottle;
		keepSpeedAt: speed - AutomaticMode dangerZoneSpeedReduction! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/5/2023 18:47:57'!
objectInDangerZoneWhenInManual
	
	 drivingSystem dangerProximityBeep ! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:13:00'!
objectInSafeZoneWhenAutomatic
	
	drivingSystem 
		connectThrottle;
		releaseBrakes;
		keepSpeedAt: mode targetSpeed! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 10:13:31'!
objectInSafeZoneWhenManual
	
	 drivingSystem turnOffProximityBeep ! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 15:51:05'!
objectInWarningZoneWhenInAutomatic
	
	drivingSystem 
		releaseBrakes;
		disconnectThrottle;
		keepSpeedAt: speed - AutomaticMode warningZoneSpeedReduction! !

!DrivingAssistant methodsFor: 'front object' stamp: 'HAW 7/6/2023 09:50:37'!
objectInWarningZoneWhenInManual
	
	drivingSystem warningProximityBeep ! !


!DrivingAssistant methodsFor: 'steering' stamp: 'TM 7/17/2023 20:38:12'!
isGoingStraight

	^drivingSystem isGoingStraight! !

!DrivingAssistant methodsFor: 'steering' stamp: 'TM 7/17/2023 20:44:31'!
isSteeringLeft
	
	^drivingSystem isSteeringLeft! !

!DrivingAssistant methodsFor: 'steering' stamp: 'TM 7/17/2023 20:41:06'!
isSteeringRight
	
	^drivingSystem isSteeringRight! !


!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:48:18'!
isTurnSignalLeft
	
	^drivingSystem isTurnSignalLeft.! !

!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:48:29'!
isTurnSignalOff
	
	^drivingSystem isTurnSignalOff.! !

!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:48:41'!
isTurnSignalRight
	
	^drivingSystem isTurnSignalRight.! !

!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 19:29:00'!
signalTurnLeft

	lastSignaledOn := clock now.
	drivingSystem signalTurnLeft! !

!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 19:44:54'!
signalTurnRight
	
	lastSignaledOn := clock now.
	drivingSystem signalTurnRight! !

!DrivingAssistant methodsFor: 'turn signal' stamp: 'TM 7/17/2023 19:38:21'!
turnOffTurnSignal
	
	^drivingSystem turnOffTurnSignal! !


!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:32:19'!
actOnLaneAlignment: laneAlignment 
	
	(self isNotTurningOnTime: laneAlignment) 	ifTrue: [ ^mode notTurningOnTimeFor: self ].
	(self isDeviatingLeft: laneAlignment) 	ifTrue: [ ^mode deviatingLeftFor: self ].
	(self isDeviatingRight: laneAlignment) 	ifTrue: [ ^mode deviatingRightFor: self ].
	mode wellAlignedFor: self! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:35:50'!
deviatingLeftWhenAutomatic
	
	drivingSystem steerRight.! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:35:21'!
deviatingLeftWhenManual

	drivingSystem turnOnLaneAlignmentBeep! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:43:45'!
deviatingRightWhenAutomatic
	
	drivingSystem steerLeft! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:35:18'!
deviatingRightWhenManual

	drivingSystem turnOnLaneAlignmentBeep! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 19:47:36'!
isDeviatingLeft: laneAlignment

	^laneAlignment = #shiftedLeft and: self isTurnSignalLeft not! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 19:50:56'!
isDeviatingRight: laneAlignment

	^laneAlignment = #shiftedRight and: self isTurnSignalRight not! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 18:32:17'!
isLaneAlignmentBeepOn
	
	^drivingSystem isLaneAlignmentBeepOn.! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:55:26'!
isNotTurningOnTime: laneAlignment

	^
	(laneAlignment = #centered) and:
	(self isTurnSignalOff not) and:
	(mode isNotTurningOnTime: (lastSignaledOn distanceTo: clock now))! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:59:35'!
notTurningOnTimeWhenAutomatic

	drivingSystem turnOnLaneAlignmentBeep! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:35:25'!
notTurningOnTimeWhenManual

	drivingSystem turnOnLaneAlignmentBeep! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 21:08:50'!
wellAlignedWhenAutomatic

	drivingSystem turnOffLaneAlignmentBeep.
	drivingSystem goStraight! !

!DrivingAssistant methodsFor: 'lane alignment' stamp: 'TM 7/17/2023 20:35:28'!
wellAlignedWhenManual

	drivingSystem turnOffLaneAlignmentBeep! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DrivingAssistant class' category: 'ISW1-2023-1C-Recuperatorio'!
DrivingAssistant class
	instanceVariableNames: ''!

!DrivingAssistant class methodsFor: 'instance creation' stamp: 'TM 7/17/2023 19:20:23'!
readingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode  
	
	^self readingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode withClock: GregorianDateTime! !

!DrivingAssistant class methodsFor: 'instance creation' stamp: 'TM 7/17/2023 19:20:51'!
readingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode withClock: aClock 
	
	^self new initializeReadingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode withClock: aClock! !


!classDefinition: #DrivingMode category: 'ISW1-2023-1C-Recuperatorio'!
Object subclass: #DrivingMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!DrivingMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:29:28'!
deviatingLeftFor: aDrivingAssistant

	self subclassResponsibility! !

!DrivingMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:29:33'!
deviatingRightFor: aDrivingAssistant

	self subclassResponsibility! !

!DrivingMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:56:43'!
isNotTurningOnTime: turningTime

	self subclassResponsibility! !

!DrivingMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:29:37'!
notTurningOnTimeFor: aDrivingAssistant

	self subclassResponsibility! !

!DrivingMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:29:44'!
wellAlignedFor: aDrivingAssistant

	self subclassResponsibility! !


!DrivingMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:56:53'!
frontObjectInDangerZoneFor: aDrivingAssistant 

	self subclassResponsibility ! !

!DrivingMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:57:07'!
frontObjectInSafeZoneFor: aDrivingAssistant 

	self subclassResponsibility ! !

!DrivingMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:57:18'!
frontObjectInWarningZoneFor: aDrivingAssistant 
	
	self subclassResponsibility ! !

!DrivingMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:57:55'!
noObjectInFrontFor: aDrivingAssistant 

	self subclassResponsibility ! !


!DrivingMode methodsFor: 'installing' stamp: 'HAW 7/7/2023 11:21:11'!
installOn: aDrivingAssistant

	self subclassResponsibility ! !


!classDefinition: #AssistedManualMode category: 'ISW1-2023-1C-Recuperatorio'!
DrivingMode subclass: #AssistedManualMode
	instanceVariableNames: 'manual automatic'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!AssistedManualMode methodsFor: 'initialization' stamp: 'HAW 7/6/2023 10:41:25'!
initializeTargeting: aTargetSpeed 
	
	manual := ManualMode new.
	automatic := AutomaticMode targeting: aTargetSpeed ! !


!AssistedManualMode methodsFor: 'target speed' stamp: 'HAW 7/6/2023 10:48:08'!
targetSpeed
	
	^automatic targetSpeed ! !


!AssistedManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:41:53'!
frontObjectInDangerZoneFor: aDrivingAssistant 
	
	manual frontObjectInDangerZoneFor: aDrivingAssistant.
	automatic frontObjectInDangerZoneFor: aDrivingAssistant.
	! !

!AssistedManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:47:53'!
frontObjectInSafeZoneFor: aDrivingAssistant 
	
	manual frontObjectInSafeZoneFor: aDrivingAssistant.
	automatic frontObjectInSafeZoneFor: aDrivingAssistant ! !

!AssistedManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:46:30'!
frontObjectInWarningZoneFor: aDrivingAssistant 
	
	manual frontObjectInWarningZoneFor: aDrivingAssistant.
	automatic frontObjectInWarningZoneFor: aDrivingAssistant ! !

!AssistedManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:49:20'!
noObjectInFrontFor: aDrivingAssistant 
	
	manual noObjectInFrontFor: aDrivingAssistant.
	automatic noObjectInFrontFor: aDrivingAssistant ! !


!AssistedManualMode methodsFor: 'installing' stamp: 'HAW 7/7/2023 11:22:52'!
installOn: aDrivingAssistant 
	
	manual installOn: aDrivingAssistant.
	automatic installOn: aDrivingAssistant ! !


!AssistedManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:13:41'!
deviatingLeftFor: aDrivingAssistant

	manual deviatingLeftFor: aDrivingAssistant.
	automatic deviatingLeftFor: aDrivingAssistant! !

!AssistedManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:14:28'!
deviatingRightFor: aDrivingAssistant

	manual deviatingRightFor: aDrivingAssistant.
	automatic deviatingRightFor: aDrivingAssistant! !

!AssistedManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:17:31'!
isNotTurningOnTime: turningTime

	^automatic isNotTurningOnTime: turningTime! !

!AssistedManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:17:42'!
notTurningOnTimeFor: aDrivingAssistant 

	automatic notTurningOnTimeFor: aDrivingAssistant! !

!AssistedManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:19:15'!
wellAlignedFor: aDrivingAssistant 

	automatic wellAlignedFor: aDrivingAssistant! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AssistedManualMode class' category: 'ISW1-2023-1C-Recuperatorio'!
AssistedManualMode class
	instanceVariableNames: ''!

!AssistedManualMode class methodsFor: 'instance creation' stamp: 'HAW 7/6/2023 10:38:36'!
targeting: aTargetSpeed 
	
	^self new initializeTargeting: aTargetSpeed ! !


!classDefinition: #AutomaticMode category: 'ISW1-2023-1C-Recuperatorio'!
DrivingMode subclass: #AutomaticMode
	instanceVariableNames: 'targetSpeed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!AutomaticMode methodsFor: 'initialization' stamp: 'HAW 7/5/2023 18:38:47'!
initializeTargeting: aTargetSpeed 
	
	targetSpeed := aTargetSpeed.! !


!AutomaticMode methodsFor: 'target speed' stamp: 'HAW 7/6/2023 10:13:07'!
targetSpeed
	
	^targetSpeed! !


!AutomaticMode methodsFor: 'front object actions' stamp: 'HAW 7/5/2023 18:40:28'!
frontObjectInDangerZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInDangerZoneWhenInAutomatic! !

!AutomaticMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:12:06'!
frontObjectInSafeZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInSafeZoneWhenAutomatic! !

!AutomaticMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 09:49:03'!
frontObjectInWarningZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInWarningZoneWhenInAutomatic! !

!AutomaticMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:15:49'!
noObjectInFrontFor: aDrivingAssistant 
	
	aDrivingAssistant noObjectInFronWhenAutomatic! !


!AutomaticMode methodsFor: 'installing' stamp: 'HAW 7/7/2023 11:18:30'!
installOn: aDrivingAssistant 
	
	aDrivingAssistant keepSpeedAt: targetSpeed ! !


!AutomaticMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:34:54'!
deviatingLeftFor: aDrivingAssistant

	aDrivingAssistant deviatingLeftWhenAutomatic! !

!AutomaticMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:43:22'!
deviatingRightFor: aDrivingAssistant 

	aDrivingAssistant deviatingRightWhenAutomatic! !

!AutomaticMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:58:26'!
isNotTurningOnTime: turningTime

	 ^turningTime > (1*minute)! !

!AutomaticMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:59:08'!
notTurningOnTimeFor: aDrivingAssistant

	aDrivingAssistant notTurningOnTimeWhenAutomatic! !

!AutomaticMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 21:03:35'!
wellAlignedFor: aDrivingAssistant

	aDrivingAssistant wellAlignedWhenAutomatic! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AutomaticMode class' category: 'ISW1-2023-1C-Recuperatorio'!
AutomaticMode class
	instanceVariableNames: ''!

!AutomaticMode class methodsFor: 'instance creation' stamp: 'HAW 7/5/2023 18:38:40'!
targeting: aTargetSpeed 
	
	^self new initializeTargeting: aTargetSpeed ! !


!AutomaticMode class methodsFor: 'speed reduction' stamp: 'HAW 7/6/2023 15:49:32'!
dangerZoneSpeedReduction
	
	^10*kilometer / hour! !

!AutomaticMode class methodsFor: 'speed reduction' stamp: 'HAW 7/6/2023 15:51:26'!
warningZoneSpeedReduction
	
	^5*kilometer / hour! !


!classDefinition: #ManualMode category: 'ISW1-2023-1C-Recuperatorio'!
DrivingMode subclass: #ManualMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!ManualMode methodsFor: 'front object actions' stamp: 'HAW 7/5/2023 18:47:26'!
frontObjectInDangerZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInDangerZoneWhenInManual! !

!ManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:13:23'!
frontObjectInSafeZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInSafeZoneWhenManual! !

!ManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 09:50:06'!
frontObjectInWarningZoneFor: aDrivingAssistant 
	
	aDrivingAssistant objectInWarningZoneWhenInManual! !

!ManualMode methodsFor: 'front object actions' stamp: 'HAW 7/6/2023 10:16:09'!
noObjectInFrontFor: aDrivingAssistant 
	
	aDrivingAssistant noObjectInFrontWhenManual! !


!ManualMode methodsFor: 'installing' stamp: 'HAW 7/7/2023 11:19:00'!
installOn: aDrivingAssistant 
	
	! !


!ManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:31:01'!
deviatingLeftFor: aDrivingAssistant 

	aDrivingAssistant deviatingLeftWhenManual! !

!ManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:31:10'!
deviatingRightFor: aDrivingAssistant 

	aDrivingAssistant deviatingRightWhenManual! !

!ManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:57:09'!
isNotTurningOnTime: turningTime

	 ^turningTime >= (2*minute)! !

!ManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:31:18'!
notTurningOnTimeFor: aDrivingAssistant 

	aDrivingAssistant notTurningOnTimeWhenManual! !

!ManualMode methodsFor: 'lane alignment actions' stamp: 'TM 7/17/2023 20:31:26'!
wellAlignedFor: aDrivingAssistant 

	aDrivingAssistant wellAlignedWhenManual! !


!classDefinition: #DrivingSystem category: 'ISW1-2023-1C-Recuperatorio'!
Object subclass: #DrivingSystem
	instanceVariableNames: 'proximityBeep brakesOn throttleConnected targetSpeed laneAlignmentBeepOn turnSignal steering'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!DrivingSystem methodsFor: 'initialization' stamp: 'TM 7/17/2023 20:39:16'!
initialize

	self turnOffProximityBeep.
	self releaseBrakes.
	self connectThrottle.
	self turnOffLaneAlignmentBeep.
	self goStraight.
	self turnOffTurnSignal! !


!DrivingSystem methodsFor: 'brakes' stamp: 'HAW 7/5/2023 18:41:38'!
applyBrakes
	
	brakesOn := true! !

!DrivingSystem methodsFor: 'brakes' stamp: 'HAW 7/5/2023 18:46:19'!
areBrakesOff
	
	^brakesOn not! !

!DrivingSystem methodsFor: 'brakes' stamp: 'HAW 7/5/2023 18:45:49'!
releaseBrakes
	
	brakesOn := false! !


!DrivingSystem methodsFor: 'throttle' stamp: 'HAW 7/5/2023 18:45:59'!
connectThrottle
	
	throttleConnected := true! !

!DrivingSystem methodsFor: 'throttle' stamp: 'HAW 7/5/2023 18:41:53'!
disconnectThrottle
	
	throttleConnected := false! !

!DrivingSystem methodsFor: 'throttle' stamp: 'HAW 7/5/2023 18:46:09'!
isThrottleConnected
	
	^throttleConnected ! !


!DrivingSystem methodsFor: 'lane alignment beep' stamp: 'TM 7/17/2023 18:31:22'!
isLaneAlignmentBeepOn
	
	^laneAlignmentBeepOn! !

!DrivingSystem methodsFor: 'lane alignment beep' stamp: 'TM 7/17/2023 18:31:27'!
turnOffLaneAlignmentBeep

	laneAlignmentBeepOn := false! !

!DrivingSystem methodsFor: 'lane alignment beep' stamp: 'TM 7/17/2023 18:31:31'!
turnOnLaneAlignmentBeep

	laneAlignmentBeepOn := true! !


!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:54:37'!
dangerProximityBeep
	
	proximityBeep := #Danger! !

!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:56:08'!
isProximityBeepInDanger
	
	^proximityBeep = #Danger! !

!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 18:09:35'!
isProximityBeepInWarning
	
	^proximityBeep = #Warning! !

!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 17:55:35'!
isProximityBeepOff
	
	^proximityBeep = #Off! !

!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 18:02:26'!
turnOffProximityBeep
	
	proximityBeep := #Off.! !

!DrivingSystem methodsFor: 'proximity beep' stamp: 'HAW 7/5/2023 18:09:17'!
warningProximityBeep
	
	proximityBeep := #Warning! !


!DrivingSystem methodsFor: 'speed' stamp: 'HAW 7/5/2023 18:42:52'!
keepSpeedAt: aTargetSpeed 
	
	targetSpeed := aTargetSpeed ! !

!DrivingSystem methodsFor: 'speed' stamp: 'HAW 7/5/2023 18:47:03'!
targetSpeedIfNone: noTargetSpeedBlock 
	
	^targetSpeed ifNil: noTargetSpeedBlock ! !


!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:50:59'!
isTurnSignalLeft
	
	^turnSignal = #Left.! !

!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:52:53'!
isTurnSignalOff
	
	^turnSignal = #Off.! !

!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:56:36'!
isTurnSignalRight
	
	^turnSignal = #Right.! !

!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:50:49'!
signalTurnLeft

	turnSignal := #Left.! !

!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:56:25'!
signalTurnRight

	turnSignal := #Right! !

!DrivingSystem methodsFor: 'turn signal' stamp: 'TM 7/17/2023 18:58:14'!
turnOffTurnSignal
	
	turnSignal := #Off! !


!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:39:38'!
goStraight
	
	steering := #Straight! !

!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:38:48'!
isGoingStraight

	^steering = #Straight! !

!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:45:28'!
isSteeringLeft
	
	^steering = #Left! !

!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:41:30'!
isSteeringRight
	
	^steering = #Right! !

!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:44:00'!
steerLeft
	
	steering := #Left! !

!DrivingSystem methodsFor: 'steering' stamp: 'TM 7/17/2023 20:37:06'!
steerRight
	
	steering := #Right! !


!classDefinition: #SensorSystem category: 'ISW1-2023-1C-Recuperatorio'!
Object subclass: #SensorSystem
	instanceVariableNames: 'speedSensor frontDistanceSensor laneAlignmentSensor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-Recuperatorio'!

!SensorSystem methodsFor: 'initialization' stamp: 'TM 7/17/2023 17:51:58'!
initializeReadingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor alignmentFrom: aLaneAlignmentSensor     
	
	speedSensor := aSpeedSensor.
	frontDistanceSensor := aFrontDistanceSensor.
	laneAlignmentSensor := aLaneAlignmentSensor.
	
	! !


!SensorSystem methodsFor: 'sensor reading' stamp: 'HAW 7/5/2023 17:59:54'!
readFrontDistanceSensor
	
	^frontDistanceSensor next! !

!SensorSystem methodsFor: 'sensor reading' stamp: 'TM 7/17/2023 17:52:28'!
readLaneAlignmentSenor
	
	^laneAlignmentSensor next! !

!SensorSystem methodsFor: 'sensor reading' stamp: 'HAW 7/5/2023 17:47:00'!
readSpeedSenor
	
	^speedSensor next! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SensorSystem class' category: 'ISW1-2023-1C-Recuperatorio'!
SensorSystem class
	instanceVariableNames: ''!

!SensorSystem class methodsFor: 'instance creation' stamp: 'TM 7/17/2023 17:51:40'!
readingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor alignmentFrom: aLaneAlignmentSensor     
	
	^self new initializeReadingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor alignmentFrom: aLaneAlignmentSensor ! !
