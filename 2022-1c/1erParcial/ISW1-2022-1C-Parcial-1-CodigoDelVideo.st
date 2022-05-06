!classDefinition: #FormulaOneTest category: 'ISW1-2022-1C-Parcial-1'!
TestCase subclass: #FormulaOneTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:30:17'!
test01SectorLengthMustBePositive

	self 
		should: [  TurboSector of: 0 * kilometer.]
		raise: Error
		withMessageText: Sector lengthMustBePositiveErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:01:31'!
test02ACarCanNotBePlacedInAKilometerGreaterThanSectorLength

	| sector  outside car |
	
	sector _ self tenKilometersTurboSector.
	outside _ sector length + (1 * millimeter).
	car _ self schumacherCar.
	
	self 
		should: [ sector put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (sector includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:01:55'!
test03CarCannotActivateTurboInNonTurboSector

	| car sector |

	sector _ self tenKilomentersNoTurboSector.
	car _ self schumacherCar.
	
	sector atStartPut: car.
	
	self should: [ car activateTurbo ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector turboNotAllowedErrorDescription equals: error messageText.
			self deny: car isTurboActivated]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:02:26'!
test04CarCannotActivateTurboWhenNoCarAhead

	| schumacher hamilton sector |
	
	sector _ self twentyKilometersTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	sector put: schumacher at: 12 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self 
		should: [ hamilton activateTurbo]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
			self assert: Sector cannotActivateTurboWhenNoCarAheadErrorDescription equals: exception messageText. 
			self deny: hamilton isTurboActivated ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:23:51'!
test05CarCanActivateTurboWhenLessThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometersTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.95 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:23:51'!
test06CarCannotActivateTurboWhenMoreThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometersTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.9 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self should: [schumacher activateTurbo]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error |
			self 
				assert: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription 
				equals: error messageText.
			self deny: schumacher isTurboActivated]
			! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:40'!
test07TrackMustHaveSectors

	self
		should: [ Track withSectors: #() ]
		raise: Error
		withMessageText: Track mustHaveSectorsErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:06:37'!
test08TheLengthOfATrackShouldBeTheSumOfItsSectors

	| track |
	
	track _ self twoSectorsTrack.
	
	self assert: 30 * kilometer equals: 	track length! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:06:37'!
test09ACarCanNotBePlacedInAKilometerGreaterThanTrackLength

	| track car outside |
	
	track _ self twoSectorsTrack.
	outside _ track length + (1 * millimeter).
	car _ self schumacherCar.
	
	self should: [ track put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Track cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (track includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:04:28'!
test10TrackShouldPlaceCarInKilometerWithinSector

	| sectors track car positionInTrack positionInSector2 |
	
	sectors _ self twoSectors.
		
	positionInSector2 _ 5 * kilometer.
	positionInTrack _ sectors first length + positionInSector2.
	
	track _ Track withSectors: sectors.
	car _ self schumacherCar.

	track put: car at: positionInTrack.
	
	self assert: sectors second equals: (track sectorOf: car).
	self assert: positionInTrack equals: (track positionOf: car).
	
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:07:09'!
test11TrackShouldKnowCarsInRunning

	| sectors track car1 car2 |
	
	sectors _ self twoSectors.
		
	track _ Track withSectors: sectors.
	car1 _ self schumacherCar.
	car2 _ self verstappenCar.

	track put: car1 at: 10 * kilometer.
	track put: car2 at: 30 * kilometer.
	
	self assert: (track includes: car1).
	self assert: (track includes: car2).
		
	self assert: (sectors first includes: car1).
	self assert: (sectors second includes: car2).

! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:07:29'!
test12CarCannotBeInMoreThanOneSectorAtATime

	| sectors track car |
	
	sectors _ self twoSectors.
	
	track _ Track withSectors: sectors.
	car _ self schumacherCar.

	track put: car at: 5 * kilometer.
	track put: car at: 15 * kilometer.
	
	self assert: sectors second equals: (track sectorOf: car).
	self deny: (sectors first includes: car).
	self assert: (sectors second includes: car)
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:07:51'!
test13GrandPrixLengthShouldBeTrackLengthTimesNumberOfLaps

	| track grandPrix numberOfLaps |
	
	track _ self twoSectorsTrack.
	numberOfLaps _ 100.
	
	grandPrix _ GrandPrix on: track running: numberOfLaps.
	
	self assert: track length * numberOfLaps	 equals: grandPrix length
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:08:33'!
test14TwoCarsCanBeAtTheSameDistanceFromStart

	| grandPrix hamilton verstappen |
	
	grandPrix _ GrandPrix 
		on: self oneSectorTrack
		running: 100.
	
	verstappen _ self verstappenCar.
	hamilton _ self hamiltonCar.	
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix put: hamilton at: 5 * kilometer.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert:  5 * kilometer equals: (grandPrix locationOf: hamilton). 
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:08:39'!
test15ACarStoppedShouldNotMoveAfterSomeTime

	| grandPrix verstappen |
	
	verstappen _ self verstappenCar.
	verstappen speed: 0 * kilometer / hour.
	
	grandPrix _ GrandPrix 
		on: self oneSectorTrack
		running: 100
		with: (Set with: verstappen).
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix advance: 10 * minute.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen) 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:07:09'!
test16ACarSpeedingShouldMoveAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ self verstappenCar.
	verstappen speed: 0* kilometer / hour.
	
	sectors _ self twoSectors.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
	
	grandPrix put: verstappen at: 0 * kilometer.
	verstappen speed: 300 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 300 * kilometer equals: (grandPrix locationOf: verstappen). 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:09:01'!
test17GrandPrixKnowsSectorOfCar

	| grandPrix verstappen sectors |
	
	verstappen _ self verstappenCar.
	
	sectors _ self twoSectors.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
		
	grandPrix put: verstappen at: 5 * kilometer.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:07:09'!
test18GrandPrixKnowsSectorOfCarAfterSomeTime

	| grandPrix verstappen sectors |
	
	verstappen _ self verstappenCar.
	
	sectors _ self twoSectors.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: sectors)
		running: 100
		with: (Set with: verstappen).
		
	grandPrix put: verstappen at: 0 * kilometer.
	
	verstappen speed: 5 * kilometer / hour. ":)"
	grandPrix advance: 1 * hour.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectors first equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:09:43'!
test19GrandPrixMovesCarsBetweenSectors

	| grandPrix verstappen sectorA sectorB |
	
	verstappen _ self verstappenCar.
	sectorA _ self tenKilometersTurboSector.
	sectorB _ self thirtyKilomentersTurboSector.
	
	grandPrix _ GrandPrix 
		on: (Track withSectors: (OrderedCollection with: sectorA with: sectorB))
		running: 100
		with: (Set new add: verstappen; yourself).
		
	grandPrix put: verstappen at: 5 * kilometer.

	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectorA equals: (grandPrix sectorOf: verstappen).
	
	verstappen speed: 15 * kilometer / hour.
	grandPrix advance: 1 * hour.
	
	self assert: 20 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert: sectorB equals: (grandPrix sectorOf: verstappen).
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:18:18'!
test20FirstTurboIncrementsSpeedByTwentyPercent

	self 
		assertSpeedIs: 120 * kilometer / hour 
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo ].! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:18:27'!
test21SecondTurboSpeedsByTenPercent

	self 
		assertSpeedIs: 110 * kilometer / hour 
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo ]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:17:30'!
test22ThirdTurboSpeedsByFivePercent

	self 
		assertSpeedIs: 105 * kilometer / hour 
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo ]
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:18:11'!
test23AfterThridTurbo_TurboIsExhausted

	self 
		assertSpeedIs: 100 * kilometer / hour 
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo. ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:22:21'!
test24CanNotActivateTurboWhenTurboIsActivated

	self withTurboAvailableCarDo: [ :turboAvailableCar |
		turboAvailableCar activateTurbo.
		
		self 
			should: [ turboAvailableCar activateTurbo ]
			raise: Error - MessageNotUnderstood 
			withMessageText: turboAvailableCar turboAlreadyActivatedErrorDescription ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/6/2022 17:22:59'!
test25CanNotDeactivateTurboWhenIsDeactivated

	self withTurboAvailableCarDo: [ :turboAvailableCar |
	
		self 
			should: [ turboAvailableCar deactivateTurbo ]
			raise: Error - MessageNotUnderstood 
			withMessageText: turboAvailableCar turboAlreadydeActivatedErrorDescription ]	! !


!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/6/2022 17:02:26'!
hamiltonCar

	^ FormulaOneCar drivenBy: #Hamilton! !

!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/6/2022 17:01:31'!
schumacherCar

	^ FormulaOneCar drivenBy: #Schumacher! !

!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/6/2022 17:07:09'!
verstappenCar

	^ FormulaOneCar drivenBy: #Verstappen! !


!FormulaOneTest methodsFor: 'assertions' stamp: 'HAW 5/6/2022 17:21:51'!
assertSpeedIs: anExpectedSpeed after: aTurboAvailableCarBlock 

	self withTurboAvailableCarDo: [ :turboAvailableCar |  
	
		aTurboAvailableCarBlock value: turboAvailableCar.
	
		self assert: turboAvailableCar isTurboActivated.
		self assert: anExpectedSpeed equals: turboAvailableCar speed ]! !

!FormulaOneTest methodsFor: 'assertions' stamp: 'HAW 5/6/2022 17:23:51'!
withTurboAvailableCarDo: aTurboAvailableCarBlock

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometersTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	aTurboAvailableCarBlock value: schumacher.
	
	! !


!FormulaOneTest methodsFor: 'tracks' stamp: 'HAW 5/6/2022 17:08:29'!
oneSectorTrack

	^ Track withSectors: (OrderedCollection with: (self tenKilometersTurboSector))! !

!FormulaOneTest methodsFor: 'tracks' stamp: 'HAW 5/6/2022 17:06:37'!
twoSectorsTrack

	^ Track withSectors: self twoSectors! !


!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:51'!
tenKilomentersNoTurboSector

	^ NoTurboSector of: 10*kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:17'!
tenKilometersTurboSector

	^ TurboSector of: 10 * kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:17'!
thirtyKilomentersTurboSector

	^ TurboSector of: 30 * kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:17'!
twentyFourKilometersTurboSector

	^ TurboSector of: 24 * kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:51'!
twentyKilometersNoTurboSector

	^ NoTurboSector of: 20 * kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:30:17'!
twentyKilometersTurboSector

	^ TurboSector of: 20 * kilometer.! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/6/2022 17:04:28'!
twoSectors

	^ OrderedCollection 
		with: (self tenKilometersTurboSector)
		with: (self twentyKilometersNoTurboSector)! !


!classDefinition: #FormulaOneCar category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #FormulaOneCar
	instanceVariableNames: 'grandPrix driver speed traveledDistance currentSector turboStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneCar methodsFor: 'initialization' stamp: 'HAW 5/6/2022 17:56:05'!
firstTurboActivated

	^ TurboActivated 
			speeding: 12/10
			next: (TurboActivated
				speeding: 11/10
				next: (TurboActivated
					speeding: 105/100
					next: TurboActivated exhaustedTurbo))! !

!FormulaOneCar methodsFor: 'initialization' stamp: 'HAW 5/6/2022 17:58:10'!
initializeDrivenBy: aDriver 

	driver _ aDriver.
	turboStatus _ TurboDeactivated next: self firstTurboActivated.
	speed _ 0*kilometer/hour.
	traveledDistance _ 0.
	! !

!FormulaOneCar methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:28'!
runningInGrandPrix: aGrandPrix
	
	grandPrix _ aGrandPrix! !


!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:07'!
advance: aDistance

	traveledDistance _ traveledDistance + aDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'FRT 4/30/2022 16:33:07'!
atSector: aSector

	currentSector _ aSector.! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 5/6/2022 17:57:53'!
speed

	^speed * turboStatus speedingRatio! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 5/1/2022 17:34:26'!
speed: newSpeed

	speed _ newSpeed! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:19'!
traveledDistance

	^ traveledDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:31'!
traveledDistance: aDistance

	traveledDistance _ aDistance! !


!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:37:32'!
activateTurbo

	turboStatus activeOn: self! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:41:36'!
deactivateTurbo
	
	turboStatus deactiveOn: self! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:25:13'!
turboAlreadydeActivatedErrorDescription
	
	^'Turbo is already deactivated'! !


!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/6/2022 17:43:31'!
isTurboActivated
	
	^turboStatus isActivated! !

!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/2/2022 14:23:06'!
turboAlreadyActivatedErrorDescription
	
	^'Turbo already activated'! !


!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/6/2022 17:58:04'!
activateTurboInSectorWithTurbo
	
	turboStatus _ turboStatus next.! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/6/2022 17:40:33'!
activeTurboWhenActivated
	
	self error: self turboAlreadyActivatedErrorDescription
! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/6/2022 17:38:35'!
activeTurboWhenDeactivated
	
	currentSector activateTurboTo: self.
! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/6/2022 17:54:50'!
deactiveTurboWhenActivated
	
	turboStatus _ TurboDeactivated next: turboStatus next! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/6/2022 17:42:46'!
deactiveTurboWhenDeactivated
	
	self error: self turboAlreadydeActivatedErrorDescription
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FormulaOneCar class' category: 'ISW1-2022-1C-Parcial-1'!
FormulaOneCar class
	instanceVariableNames: ''!

!FormulaOneCar class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 18:44:15'!
drivenBy: aDriver 

	^self new initializeDrivenBy: aDriver ! !


!classDefinition: #GrandPrix category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #GrandPrix
	instanceVariableNames: 'track numberOfLaps'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!GrandPrix methodsFor: 'initialization' stamp: 'FRT 5/1/2022 11:26:39'!
initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars

	track _ aTrack.
	numberOfLaps _ aNumberOfLaps.
	aCollectionOfCars do: [ :car | car runningInGrandPrix: self ].
! !


!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 22:23:59'!
locationOf: aCar

	^ aCar traveledDistance.	! !

!GrandPrix methodsFor: 'car position' stamp: 'HAW 4/30/2022 19:15:32'!
put: aCar at: aDistance

	| distanceInTrack |
	
	aCar traveledDistance: aDistance.
	
	distanceInTrack _ aDistance \\ track length.
	track put: aCar at: distanceInTrack.
	! !

!GrandPrix methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:38:16'!
sectorOf: aCar 

	^ track sectorOf: aCar.! !


!GrandPrix methodsFor: 'length' stamp: 'HAW 4/30/2022 18:43:17'!
length

	^ track length * numberOfLaps! !


!GrandPrix methodsFor: 'simulation' stamp: 'HAW 5/6/2022 18:05:50'!
advance: aTimeLapse
	
	track cars do: [ :car |self relocate: car after: aTimeLapse ]! !

!GrandPrix methodsFor: 'simulation' stamp: 'HAW 5/1/2022 17:35:43'!
relocate: aCar after: aTimeLapse 

	| distanceMoved distanceInTrack |
	
	distanceMoved _ aCar speed * aTimeLapse.
	aCar advance: distanceMoved.
	
	distanceInTrack _ aCar traveledDistance \\ track length.
	track put: aCar at: distanceInTrack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GrandPrix class' category: 'ISW1-2022-1C-Parcial-1'!
GrandPrix class
	instanceVariableNames: ''!

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:05'!
on: aTrack running: aNumberOfLaps 

	^self on: aTrack running: aNumberOfLaps with: #()! !

!GrandPrix class methodsFor: 'instance creation' stamp: 'HAW 4/30/2022 19:36:16'!
on: aTrack running: aNumberOfLaps with: aCollectionOfCars

	^self new initializeWithTrack: aTrack andNumberOfLaps: aNumberOfLaps andCars: aCollectionOfCars! !


!GrandPrix class methodsFor: 'error message' stamp: 'ARM 4/28/2022 15:09:05'!
distanceOutSideRaceTrackLengthErrorMessage

	^'Distance outside Race Track length'! !

!GrandPrix class methodsFor: 'error message' stamp: 'FRT 5/1/2022 12:24:57'!
turboNotAllowedWithRainTiresErrorMessage

	^ 'Turbo not allowed with rain tires'! !


!classDefinition: #Sector category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Sector
	instanceVariableNames: 'cars length'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Sector methodsFor: 'initialization' stamp: 'FRT 5/1/2022 10:02:21'!
initializeOf: aLength 

	cars _ Dictionary new.
	length _ aLength.! !


!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
assertValidPosition: aPosition

	length < aPosition ifTrue: [ self error: self class cannotPlacedCarErrorDescription ]! !

!Sector methodsFor: 'car position' stamp: 'HAW 5/1/2022 16:59:05'!
atStartPut: aCar
 
	self put: aCar at: 0*kilometer! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 09:23:35'!
positionOf: aCar
 
	^ cars at: aCar.
! !

!Sector methodsFor: 'car position' stamp: 'FRT 5/1/2022 14:13:55'!
put: aCar at: aPosition
 
	self assertValidPosition: aPosition.
	
	cars at: aCar put: aPosition.
	aCar atSector: self.! !

!Sector methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:04:40'!
remove: aCar
 
	cars removeKey: aCar ifAbsent: [].
! !


!Sector methodsFor: 'accessing' stamp: 'FRT 4/30/2022 22:08:51'!
cars
	
	^ cars keys! !

!Sector methodsFor: 'accessing' stamp: 'HAW 5/2/2022 14:26:16'!
length

	^length! !


!Sector methodsFor: 'testing' stamp: 'HAW 5/1/2022 16:54:33'!
includes: aCar

	^ cars includesKey: aCar! !


!Sector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:27:37'!
activateTurboTo: aCarToActivateTurboTo

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: 'ISW1-2022-1C-Parcial-1'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 17:28:51'!
assertIsValidLength: aLength

	^ aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]! !

!Sector class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 17:29:08'!
of: aLength 
	
	self assertIsValidLength: aLength	.
		
	^ self new initializeOf: aLength! !


!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:24:41'!
cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription
	
	^ 'Cannot activate Turbo when opponent is more than 1 second ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 20:13:07'!
cannotActivateTurboWhenNoCarAheadErrorDescription
	
	^ 'Cannot activate Turbo without opponent ahead'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 10:08:26'!
cannotPlacedCarErrorDescription

	^ 'Driver can not be placed outside section'! !

!Sector class methodsFor: 'error message' stamp: 'HAW 4/30/2022 17:05:20'!
lengthMustBePositiveErrorDescription

	^ 'Length must be positive'! !

!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 09:54:45'!
turboNotAllowedErrorDescription
	
	^ 'Turbo not allowed in this Sector'! !


!classDefinition: #NoTurboSector category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #NoTurboSector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!NoTurboSector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:26:39'!
activateTurboTo: aCarToActivateTurboTo

	self error: Sector turboNotAllowedErrorDescription! !


!classDefinition: #TurboSector category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #TurboSector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:26:52'!
activateTurboTo: aCarToActivateTurboTo

	| positionOfCarAhead |

	positionOfCarAhead _ self 
		positionOfCarAheadOf: aCarToActivateTurboTo 
		ifNone: [self error: Sector cannotActivateTurboWhenNoCarAheadErrorDescription ].
		
	self 
		assertDriverIsOneSecondOrLess: aCarToActivateTurboTo
		ofDriverAt: positionOfCarAhead.

	aCarToActivateTurboTo activateTurboInSectorWithTurbo
! !

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:34:07'!
assertDriverIsOneSecondOrLess: aCarToActivateTurboTo ofDriverAt: positionOfCarAhead

	| carAhead carAheadTime carToActiveTurboTime |
	
	carAhead _ self carAtPosition: positionOfCarAhead.
	
	carAheadTime _ positionOfCarAhead / carAhead speed.
	carToActiveTurboTime _ (cars at: aCarToActivateTurboTo) / aCarToActivateTurboTo speed.
	
	carAheadTime - carToActiveTurboTime < (1 * second)
		ifFalse: [self error: Sector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription ].! !

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:34:54'!
carAtPosition: positionOfDriver

	^cars keyAtValue: positionOfDriver! !

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/6/2022 17:32:16'!
positionOfCarAheadOf: aCarToActiveTurboTo ifNone: alternativeClosure

	| sortedPositions carToActivateTurboToPosition |
	
	carToActivateTurboToPosition _ cars at: aCarToActiveTurboTo.
	sortedPositions _ cars asSortedCollection remove: carToActivateTurboToPosition; yourself.
	 
	^ sortedPositions 
		detect: [:aPosition | aPosition > carToActivateTurboToPosition ]
		ifNone: alternativeClosure ! !


!classDefinition: #Track category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Track
	instanceVariableNames: 'sectors driversDistanceFromBeginning'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Track methodsFor: 'initialization' stamp: 'HAW 4/30/2022 17:06:50'!
initializeWithSectors: aSectors

	sectors _ aSectors copy.! !


!Track methodsFor: 'car position' stamp: 'HAW 5/6/2022 18:12:58'!
assertCanPlaceCarAt: aPosition

	^ aPosition > self length ifTrue: [ self error: self class cannotPlacedCarErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
carNotFoundErrorDescription

	^ 'Car not found'! !

!Track methodsFor: 'car position' stamp: 'HAW 5/6/2022 18:12:33'!
positionOf: aCar

	| accumulatedLength |
	
	accumulatedLength _ 0 * kilometer.
	
	sectors do: [ :sector |
		(sector includes: aCar) ifTrue: [ ^ accumulatedLength + (sector positionOf: aCar)].
		accumulatedLength _ accumulatedLength + sector length ].
	
	self error: self carNotFoundErrorDescription ! !

!Track methodsFor: 'car position' stamp: 'HAW 5/6/2022 18:16:23'!
put: aCar at: aPosition

	| accumulatedLength |
	
	self assertCanPlaceCarAt: aPosition.

	self remove: aCar.
	accumulatedLength _ 0 * kilometer.
	sectors do: [ :sector |
		aPosition <= (accumulatedLength +  sector length) ifTrue: [ ^sector put: aCar at: aPosition - accumulatedLength].
		accumulatedLength _ accumulatedLength + sector length ].
	
	self shouldNotHappenBecause: #assertCanPlaceCarAt:! !

!Track methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:15:27'!
remove: aCar
	
	| currentSector |
	
	currentSector _ self sectorOf: aCar ifNone: [ ^ self ].
	currentSector remove: aCar.
	! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
sectorOf: aCar
	
	^self sectorOf: aCar ifNone: [ self error: self carNotFoundErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'HAW 5/6/2022 18:17:14'!
sectorOf: aCar ifNone: aBlock

	 ^sectors detect: [ :sector | sector includes: aCar ] ifNone: aBlock ! !


!Track methodsFor: 'accessing' stamp: 'HAW 5/6/2022 18:05:19'!
cars

	^sectors
		inject: OrderedCollection new
		into: [ :cars :sector | cars addAll: sector cars; yourself ]
		
! !

!Track methodsFor: 'accessing' stamp: 'HAW 5/6/2022 18:07:41'!
length

	^sectors sum: [ :sector | sector length ] ifEmpty: [ 0 * kilometer ]
! !


!Track methodsFor: 'testing' stamp: 'HAW 5/6/2022 18:06:49'!
includes: aCar
	"Returns if any of the sectors includes aCar"
	
	^sectors anySatisfy: [ :sector | sector includes: aCar ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Track class' category: 'ISW1-2022-1C-Parcial-1'!
Track class
	instanceVariableNames: ''!

!Track class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 18:07:59'!
assertNotEmpty: sectors

	^ sectors isEmpty ifTrue: [ self error: self mustHaveSectorsErrorDescription ]! !

!Track class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 18:07:59'!
withSectors: sectors

	self assertNotEmpty: sectors.
	
	^ self new initializeWithSectors: sectors! !


!Track class methodsFor: 'error messages' stamp: 'FRT 4/29/2022 18:22:32'!
cannotPlacedCarErrorDescription

	^ 'Car cannot be placed in track'! !

!Track class methodsFor: 'error messages' stamp: 'HAW 4/30/2022 17:09:27'!
mustHaveSectorsErrorDescription

	^'Track must have sectors'! !


!classDefinition: #TurboStatus category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #TurboStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboStatus methodsFor: 'next' stamp: 'HAW 5/6/2022 18:00:52'!
next

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 17:59:59'!
activeOn: aFormulaOneCar 

	self subclassResponsibility ! !

!TurboStatus methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 18:00:16'!
deactiveOn: aFormulaOneCar 

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'testing' stamp: 'HAW 5/6/2022 18:00:34'!
isActivated

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'speed' stamp: 'HAW 5/6/2022 18:01:00'!
speedingRatio

	self subclassResponsibility ! !


!classDefinition: #TurboActivated category: 'ISW1-2022-1C-Parcial-1'!
TurboStatus subclass: #TurboActivated
	instanceVariableNames: 'next speedingRatio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboActivated methodsFor: 'initialization' stamp: 'HAW 5/6/2022 17:59:27'!
initializeExhaustedTurbo
	
	self initializeSpeeding: 1 next: self! !

!TurboActivated methodsFor: 'initialization' stamp: 'HAW 5/6/2022 17:53:02'!
initializeSpeeding: aSpeedingRatio next: aNext 
	
	speedingRatio := aSpeedingRatio.
	next := aNext.! !


!TurboActivated methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 17:40:21'!
activeOn: aFormulaOneCar 
	
	^aFormulaOneCar activeTurboWhenActivated! !

!TurboActivated methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 17:41:59'!
deactiveOn: aFormulaOneCar 
	
	^aFormulaOneCar deactiveTurboWhenActivated! !


!TurboActivated methodsFor: 'testing' stamp: 'HAW 5/6/2022 17:43:50'!
isActivated
	
	^true! !


!TurboActivated methodsFor: 'next' stamp: 'HAW 5/6/2022 17:55:30'!
next
	
	^next! !


!TurboActivated methodsFor: 'speed' stamp: 'HAW 5/6/2022 17:57:53'!
speedingRatio 
		
	^speedingRatio ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboActivated class' category: 'ISW1-2022-1C-Parcial-1'!
TurboActivated class
	instanceVariableNames: ''!

!TurboActivated class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 17:52:18'!
exhaustedTurbo
	
	^self new initializeExhaustedTurbo! !

!TurboActivated class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 17:52:56'!
speeding: aSpeedingRatio next: aNext 
	
	^self new initializeSpeeding: aSpeedingRatio next: aNext ! !


!classDefinition: #TurboDeactivated category: 'ISW1-2022-1C-Parcial-1'!
TurboStatus subclass: #TurboDeactivated
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboDeactivated methodsFor: 'initialization' stamp: 'HAW 5/6/2022 17:53:21'!
initializeNext: aNext 
	
	next := aNext.! !


!TurboDeactivated methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 17:38:14'!
activeOn: aFormulaOneCar 
	
	^aFormulaOneCar activeTurboWhenDeactivated! !

!TurboDeactivated methodsFor: 'activate/deactive' stamp: 'HAW 5/6/2022 17:42:32'!
deactiveOn: aFormulaOneCar 
	
	^aFormulaOneCar deactiveTurboWhenDeactivated! !


!TurboDeactivated methodsFor: 'testing' stamp: 'HAW 5/6/2022 17:43:40'!
isActivated
	
	^false! !


!TurboDeactivated methodsFor: 'next' stamp: 'HAW 5/6/2022 17:55:21'!
next
	
	^next! !


!TurboDeactivated methodsFor: 'speed' stamp: 'HAW 5/6/2022 17:57:53'!
speedingRatio

	^1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboDeactivated class' category: 'ISW1-2022-1C-Parcial-1'!
TurboDeactivated class
	instanceVariableNames: ''!

!TurboDeactivated class methodsFor: 'instance creation' stamp: 'HAW 5/6/2022 17:53:15'!
next: aNext 
	
	^self new initializeNext: aNext ! !
