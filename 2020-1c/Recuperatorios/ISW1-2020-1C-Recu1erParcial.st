!classDefinition: #LocomotiveTest category: #'ISW1-2020-1C-Recu1erParcial'!
TestCase subclass: #LocomotiveTest
	instanceVariableNames: 'odometerSimulatorWithNoMovement proximitySimulatorWithNoObstacle proximitySimulatorWithObstacle odometerSimulatorWithFrictionAhead odometerSimulatorMovingWithNoFriction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recu1erParcial'!

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:27:55'!
test01LocomotiveInAutomaticModeAcceleratesWhenNoCurveOrObstacle

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorWithNoMovement
									withProximitySensor: proximitySimulatorWithNoObstacle
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive automatic.
	locomotive step.
	
	self assert: locomotive speedingUp.
	self deny: locomotive enteringCurve.
	self deny: locomotive inFrontOfAnObstacle.
	self deny: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:28:08'!
test02LocomotiveInAutomaticModeDeceleratesAndBrealsInFrontOfAnObstacle

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorMovingWithNoFriction
									withProximitySensor: proximitySimulatorWithObstacle
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive automatic.
	locomotive step.
	
	self deny: locomotive speedingUp.
	self deny: locomotive enteringCurve.
	self assert: locomotive inFrontOfAnObstacle.
	self assert: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:27:55'!
test03LocomotiveInAutomaticModeDeceleratesEnteringACurve

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorWithFrictionAhead
									withProximitySensor: proximitySimulatorWithNoObstacle
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive automatic.
	locomotive step.
	
	self deny: locomotive speedingUp.
	self assert: locomotive enteringCurve.
	self deny: locomotive inFrontOfAnObstacle.
	self deny: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:28:08'!
test04LocomotiveInAutomaticModeDeceleratesAndBreaksInFrontOfAnObstacleAndEnteringACurve

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorWithFrictionAhead 
									withProximitySensor: proximitySimulatorWithObstacle
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive automatic.
	locomotive step.
	
	self deny: locomotive speedingUp.
	self assert: locomotive enteringCurve.
	self assert: locomotive inFrontOfAnObstacle.
	self assert: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:28:08'!
test05LocomotiveInManualModeBreaksInFrontOfAnObstacle

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorMovingWithNoFriction 
									withProximitySensor: proximitySimulatorWithObstacle 
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive manual.
	locomotive step.
	
	self assert: locomotive inFrontOfAnObstacle.
	self assert: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:27:55'!
test06LocomotiveInManualModeDoesntBreakEnteringACurve

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorWithFrictionAhead 
									withProximitySensor: proximitySimulatorWithNoObstacle 
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive manual.
	locomotive step.
	
	self assert: locomotive enteringCurve.
	self deny: locomotive breaking.! !

!LocomotiveTest methodsFor: 'tests' stamp: 'ARM 8/10/2020 13:28:08'!
test07LocomotiveInManualModeBreaksInFrontOfAnObstacleAndEnteringACurve

	| locomotive |
	
	locomotive _ Locomotive withOdometers: odometerSimulatorWithFrictionAhead
									withProximitySensor: proximitySimulatorWithObstacle 
									withMotor: LocomotiveMotor new
									withBreaks: (OrderedCollection with: LocomotiveBreak new). 
	
	locomotive manual.
	locomotive step.
	
	self assert: locomotive inFrontOfAnObstacle.
	self assert: locomotive breaking.! !


!LocomotiveTest methodsFor: 'setUp' stamp: 'ARM 8/10/2020 13:28:08'!
setUp

	odometerSimulatorWithNoMovement _ # (0 0 0 0 0).
	odometerSimulatorWithFrictionAhead _ # (10 11 12 12 12).
	odometerSimulatorMovingWithNoFriction _ # (11 11 11 11 11).
	proximitySimulatorWithNoObstacle _ ProximitySimulator clear.
	proximitySimulatorWithObstacle _ ProximitySimulator obstacle.! !


!classDefinition: #Locomotive category: #'ISW1-2020-1C-Recu1erParcial'!
Object subclass: #Locomotive
	instanceVariableNames: 'motor breaksChain odometersChain proximitySensor manual'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recu1erParcial'!

!Locomotive methodsFor: 'moving' stamp: 'ARM 8/10/2020 13:23:57'!
step

	manual ifFalse:
	[
	self enteringCurve
		ifTrue: [motor decelerate.
			self inFrontOfAnObstacle
				ifFalse: [breaksChain do:[:eachBreak | eachBreak breakFree]]
				ifTrue: [breaksChain do:[:eachBreak | eachBreak break]]]
		ifFalse:[
			self inFrontOfAnObstacle
				ifTrue: [motor decelerate. breaksChain do:[:eachBreak | eachBreak break]]
				ifFalse: [motor accelerate. breaksChain do:[:eachBreak | eachBreak breakFree]
					]
				]
	]
	ifTrue:
	[
			self inFrontOfAnObstacle
				ifTrue: [breaksChain do:[:eachBreak | eachBreak break]]
	]
! !


!Locomotive methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:38:48'!
breaking

	^breaksChain anyOne breaking! !

!Locomotive methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:03:08'!
enteringCurve
	^odometersChain first < odometersChain last! !

!Locomotive methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:02:23'!
inFrontOfAnObstacle
	^proximitySensor obstacleSensed! !

!Locomotive methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:01:46'!
speedingUp
	^motor speedingUp ! !


!Locomotive methodsFor: 'initialization' stamp: 'ARM 8/10/2020 09:39:44'!
initializeWithOdometers: aChainOfOdometers withProximitySensor: aProximitySensor withMotor: aLocomotiveMotor withBreaks: aChainOfBreaks 

	odometersChain := aChainOfOdometers.
	proximitySensor := aProximitySensor.
	motor := aLocomotiveMotor.
	breaksChain := aChainOfBreaks.
	manual _ false! !


!Locomotive methodsFor: 'pilot' stamp: 'ARM 8/10/2020 09:40:16'!
automatic

	manual _ false! !

!Locomotive methodsFor: 'pilot' stamp: 'ARM 8/10/2020 09:40:09'!
manual

	manual _ true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Locomotive class' category: #'ISW1-2020-1C-Recu1erParcial'!
Locomotive class
	instanceVariableNames: ''!

!Locomotive class methodsFor: 'instance creation' stamp: 'ARM 8/9/2020 19:43:35'!
withOdometers: aChainOfOdometers withProximitySensor: aProximitySensor withMotor: aLocomotiveMotor withBreaks: aChainOfBreaks 

	^self new initializeWithOdometers: aChainOfOdometers withProximitySensor: aProximitySensor withMotor: aLocomotiveMotor withBreaks: aChainOfBreaks; yourself! !


!classDefinition: #LocomotiveBreak category: #'ISW1-2020-1C-Recu1erParcial'!
Object subclass: #LocomotiveBreak
	instanceVariableNames: 'pressure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recu1erParcial'!

!LocomotiveBreak methodsFor: 'moving' stamp: 'ARM 8/9/2020 20:24:12'!
break
	
	pressure _ 1000 * gram! !

!LocomotiveBreak methodsFor: 'moving' stamp: 'ARM 8/9/2020 20:22:27'!
breakFree
	
	pressure _ 0 * gram! !


!LocomotiveBreak methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:39:58'!
breaking
	^pressure > (0 * gram)! !


!LocomotiveBreak methodsFor: 'initialization' stamp: 'ARM 8/10/2020 09:55:40'!
initialize
	
	pressure _ 0 * gram! !


!classDefinition: #LocomotiveMotor category: #'ISW1-2020-1C-Recu1erParcial'!
Object subclass: #LocomotiveMotor
	instanceVariableNames: 'acceleration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recu1erParcial'!

!LocomotiveMotor methodsFor: 'moving' stamp: 'ARM 8/9/2020 20:12:28'!
accelerate
	^acceleration _ 10! !

!LocomotiveMotor methodsFor: 'moving' stamp: 'ARM 8/9/2020 20:12:50'!
decelerate
	^acceleration _ 0! !


!LocomotiveMotor methodsFor: 'initialization' stamp: 'ARM 8/9/2020 20:13:17'!
initialize

	acceleration _ 0! !


!LocomotiveMotor methodsFor: 'condition' stamp: 'ARM 8/9/2020 20:11:57'!
speedingUp
	^acceleration > 0! !


!classDefinition: #ProximitySimulator category: #'ISW1-2020-1C-Recu1erParcial'!
Object subclass: #ProximitySimulator
	instanceVariableNames: 'obstacleDistance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recu1erParcial'!

!ProximitySimulator methodsFor: 'initialization' stamp: 'ARM 8/9/2020 19:50:44'!
initializeClear
	
	obstacleDistance _ 10000 * meter! !

!ProximitySimulator methodsFor: 'initialization' stamp: 'ARM 8/9/2020 20:00:49'!
initializeObstacle
	
	obstacleDistance _ 50 * meter ! !


!ProximitySimulator methodsFor: 'accessing' stamp: 'ARM 8/9/2020 20:10:19'!
obstacleSensed
	
	^obstacleDistance < (400 * meter)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProximitySimulator class' category: #'ISW1-2020-1C-Recu1erParcial'!
ProximitySimulator class
	instanceVariableNames: ''!

!ProximitySimulator class methodsFor: 'instance creation' stamp: 'ARM 8/9/2020 19:48:53'!
clear

	^self new initializeClear! !

!ProximitySimulator class methodsFor: 'instance creation' stamp: 'ARM 8/9/2020 20:00:16'!
obstacle

	^self new initializeObstacle! !
