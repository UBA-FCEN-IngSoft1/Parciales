!classDefinition: #DrivingAssistantTest category: 'ISW1-2023-1C-2doParcial'!
TestCase subclass: #DrivingAssistantTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/13/2023 11:19:55'!
assertTargetSpeedIsTheOriginalWhenCreatedIn: aMode

	| assistant sensorSystem drivingSystem frontDistanceSensor speedSensor |
	
	speedSensor := ReadStream on: {}.
	frontDistanceSensor := ReadStream on: {}.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor .
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant readingSensorsFrom: sensorSystem sendingActionsTo: drivingSystem in: aMode.
	
	self assert: 0*kilometer / hour equals: assistant speed.
	self assertProximityBeepIsOffOn: assistant.
	self assertIsAceleratingOn: assistant.
	self assertTargetSpeedIsTheOriginalOn: assistant.! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:02:40'!
test01IsAtRightStateWhenTurnOn

	| assistant sensorSystem drivingSystem frontDistanceSensor speedSensor |
	
	speedSensor := ReadStream on: {}.
	frontDistanceSensor := ReadStream on: {}.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor .
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant readingSensorsFrom: sensorSystem sendingActionsTo: drivingSystem in: self manualMode.
	
	self assert: 0*kilometer / hour equals: assistant speed.
	self assertProximityBeepIsOffOn: assistant.
	self assertIsAceleratingOn: assistant.
	self assertNoTargetSpeedOn: assistant
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test02ProximityBeepIsOffWhenNoObjectIfFront

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant]
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test03ProximityBeepIsInDangerWhenInDangerZoneClosestLimit

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self manualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant] 
	
	
			! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test04ProximityBeepIsInDangerWhenInDangerZoneFartherLimit

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test05ProximityBeepIsInWarningWhenInWarningZoneClosestLimit

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test06ProximityBeepIsInWarningWhenInWarningZoneFartherLimit

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.		
			self assertProximityBeepIsInWarningOn: assistant.		
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test07ProximityBeepIsOffWhenInSafeZone

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self manualMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.	
			self assertProximityBeepIsOffOn: assistant.	
			self assertIsAceleratingOn: assistant.
			self assertNoTargetSpeedOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test08BreaksWhenInDangerZoneClosestLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant  ] 
	
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test09BreaksInDangerWhenInDangerZoneFartherLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit
		with: self automaticMode
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant  ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test10DesacelerateWhenInWarningZoneClosestLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/6/2023 16:03:19'!
test11DesacelerateWhenInWarningZoneFartherLimitAndAutomaticMode

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:15:35'!
test12KeepsTargetSpeedWhenInSafeZoneAndAutomaticMode

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:15:35'!
test13KeepsTargetSpeedWhenNoObjectInFrontAndAutomaticMode

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self automaticMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant .
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test14CombinesModesWhenInDangerZoneClosestLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inDangerZoneClosestLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant  ] 
	
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test15CombinesModesWhenInDangerZoneFartherLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inDangerZoneFartherLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInDangerOn: assistant.
			self assertBrakingOn: assistant.
			self assertReducesTargetSpeedForDangerZoneOn: assistant  ]	
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test16CombinesModesWhenInWarningZoneClosestLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inWarningZoneClosestLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test17CombinesModesWhenInWarningZoneFartherLimitAndManualWithAssistance

	self 
		whenFrontObjectAt: self inWarningZoneFartherLimit 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsInWarningOn: assistant.
			self assertDesaceleratingOn: assistant.
			self assertReducesTargetSpeedForWarningZoneOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test18CombinesModesWhenInSafeZoneAndManualWithAssistance

	self 
		whenFrontObjectAt: self inSafeZone 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/7/2023 11:20:47'!
test19CombinesModesWhenNoObjectInFrontAndManualWithAssistance

	self 
		whenFrontObjectAt: self noObjectInFront 
		with: self assistedManualMode 
		assert: [ :assistant |
			self assertCurrentSpeedIsSensorSpeedOn: assistant.
			self assertProximityBeepIsOffOn: assistant.
			self assertIsAceleratingOn: assistant.
			self assertTargetSpeedIsTheOriginalOn: assistant ]! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/13/2023 11:20:12'!
test20TakesTargetSpeedFromAutomaticModeWhenTurnOn

	self assertTargetSpeedIsTheOriginalWhenCreatedIn: self automaticMode.
	! !

!DrivingAssistantTest methodsFor: 'tests' stamp: 'HAW 7/13/2023 11:20:25'!
test21TakesTargetSpeedFromAssistedManualModeWhenTurnOn

	self assertTargetSpeedIsTheOriginalWhenCreatedIn: self assistedManualMode.
	! !


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

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 20:04:04'!
assertTargetSpeedReducesBy: aSpeed lessThanCurrentOn: assistant

	^ self assert:  (100*kilometer /hour) - aSpeed equals: (assistant targetSpeedIfNone: [ self fail ])! !

!DrivingAssistantTest methodsFor: 'assertions' stamp: 'HAW 7/6/2023 15:59:00'!
whenFrontObjectAt: aZone with: aMode assert: assertions

	| assistant sensorSystem drivingSystem speedSensor frontDistanceSensor |
	
	speedSensor := ReadStream on: { self sensorSpeed. }.
	frontDistanceSensor := ReadStream on: { aZone }.
	sensorSystem := SensorSystem readingSpeedFrom: speedSensor distanceFrom: frontDistanceSensor .
	drivingSystem := DrivingSystem new.
	assistant := DrivingAssistant 
		readingSensorsFrom: sensorSystem 
		sendingActionsTo: drivingSystem 
		in: aMode.
	
	assistant tick.
	
	assertions value: assistant! !


!DrivingAssistantTest methodsFor: 'speed' stamp: 'HAW 7/6/2023 15:57:30'!
sensorSpeed

	^ 100*kilometer / hour! !


!classDefinition: #DrivingAssistant category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #DrivingAssistant
	instanceVariableNames: 'sensorSystem drivingSystem speed mode minimunBrakingDistance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingAssistant methodsFor: 'initialization' stamp: 'HAW 7/7/2023 11:18:06'!
initializeReadingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode  
	
	sensorSystem := aSensorSystem.
	drivingSystem := aDrivingSystem.
	mode := aMode.
	
	speed := 0 * kilometer / hour.
	aMode installOn: self.! !


!DrivingAssistant methodsFor: 'ticking' stamp: 'HAW 7/6/2023 15:46:11'!
tick
	
	| distanceToFrontObject |
	
	speed := sensorSystem readSpeedSenor.
	distanceToFrontObject := sensorSystem readFrontDistanceSensor.
	
	self actOnFrontObject: distanceToFrontObject.
	! !


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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DrivingAssistant class' category: 'ISW1-2023-1C-2doParcial'!
DrivingAssistant class
	instanceVariableNames: ''!

!DrivingAssistant class methodsFor: 'instance creation' stamp: 'HAW 7/5/2023 18:34:53'!
readingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode  
	
	^self new initializeReadingSensorsFrom: aSensorSystem sendingActionsTo: aDrivingSystem in: aMode ! !


!classDefinition: #DrivingMode category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #DrivingMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

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


!classDefinition: #AssistedManualMode category: 'ISW1-2023-1C-2doParcial'!
DrivingMode subclass: #AssistedManualMode
	instanceVariableNames: 'manual automatic'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AssistedManualMode class' category: 'ISW1-2023-1C-2doParcial'!
AssistedManualMode class
	instanceVariableNames: ''!

!AssistedManualMode class methodsFor: 'instance creation' stamp: 'HAW 7/6/2023 10:38:36'!
targeting: aTargetSpeed 
	
	^self new initializeTargeting: aTargetSpeed ! !


!classDefinition: #AutomaticMode category: 'ISW1-2023-1C-2doParcial'!
DrivingMode subclass: #AutomaticMode
	instanceVariableNames: 'targetSpeed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AutomaticMode class' category: 'ISW1-2023-1C-2doParcial'!
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


!classDefinition: #ManualMode category: 'ISW1-2023-1C-2doParcial'!
DrivingMode subclass: #ManualMode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

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


!classDefinition: #DrivingSystem category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #DrivingSystem
	instanceVariableNames: 'proximityBeep brakesOn throttleConnected targetSpeed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!DrivingSystem methodsFor: 'initialization' stamp: 'HAW 7/6/2023 11:31:08'!
initialize

	self turnOffProximityBeep.
	self releaseBrakes.
	self connectThrottle.
	! !


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


!classDefinition: #SensorSystem category: 'ISW1-2023-1C-2doParcial'!
Object subclass: #SensorSystem
	instanceVariableNames: 'speedSensor frontDistanceSensor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-1C-2doParcial'!

!SensorSystem methodsFor: 'initialization' stamp: 'HAW 7/6/2023 11:32:12'!
initializeReadingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor    
	
	speedSensor := aSpeedSensor.
	frontDistanceSensor := aFrontDistanceSensor.
	
	! !


!SensorSystem methodsFor: 'sensor reading' stamp: 'HAW 7/5/2023 17:59:54'!
readFrontDistanceSensor
	
	^frontDistanceSensor next! !

!SensorSystem methodsFor: 'sensor reading' stamp: 'HAW 7/5/2023 17:47:00'!
readSpeedSenor
	
	^speedSensor next! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SensorSystem class' category: 'ISW1-2023-1C-2doParcial'!
SensorSystem class
	instanceVariableNames: ''!

!SensorSystem class methodsFor: 'instance creation' stamp: 'HAW 7/6/2023 11:32:29'!
readingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor    
	
	^self new initializeReadingSpeedFrom: aSpeedSensor distanceFrom: aFrontDistanceSensor ! !
