!classDefinition: #FormulaOneTest category: 'ISW1-2022-1C-Parcial-1'!
TestCase subclass: #FormulaOneTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 16:05:05'!
test01SectorLengthMustBePositive

	self 
		should: [ TurboSector of: 0 * kilometer.]
		raise: Error
		withMessageText: Sector lengthMustBePositiveErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:49:28'!
test02ACarCanNotBePlacedInAKilometerGreaterThanSectorLength

	| sector  outside car |
	
	sector _ self tenKilometerTurboSector.
	outside _ sector length + (1 * millimeter).
	car _ self schumacherCar.
	
	self 
		should: [ sector put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Sector cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (sector includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:41:46'!
test03CarCannotActivateTurboInNonTurboSector

	| car sector |

	sector _ self tenKilometerWithoutTurboSector.
	car _ self schumacherCar.
	
	sector atStartPut: car.
	
	self should: [ car activateTurbo ]
		raise: Error
		withExceptionDo: [ :error |
			self assert: NoTurboSector turboNotAllowedErrorDescription equals: error messageText.
			self deny: car isTurboActivated]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:42:46'!
test04CarCannotActivateTurboWhenNoCarAhead

	| schumacher hamilton sector |
	
	sector _ self twentyKilometerTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	sector put: schumacher at: 12 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	self 
		should: [ hamilton activateTurbo]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [:exception |
			self assert: TurboSector cannotActivateTurboWhenNoCarAheadErrorDescription equals: exception messageText. 
			self deny: hamilton isTurboActivated ]! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:51:18'!
test05CarCanActivateTurboWhenLessThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometerTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	schumacher speed: 300 * kilometer / hour.
	hamilton speed: 300 * kilometer / hour.
	
	sector put: schumacher at: 12.95 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	schumacher activateTurbo.
	
	self assert: schumacher isTurboActivated
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:43:40'!
test06CarCannotActivateTurboWhenMoreThanASecondBehindAnotherCar

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometerTurboSector.
	
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
				assert: TurboSector cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription 
				equals: error messageText.
			self deny: schumacher isTurboActivated]
			! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 09:16:40'!
test07TrackMustHaveSectors

	self
		should: [ Track withSectors: #() ]
		raise: Error
		withMessageText: Track mustHaveSectorsErrorDescription! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:52:08'!
test08TheLengthOfATrackShouldBeTheSumOfItsSectors

	| sectors track |
	
	sectors _ self twoSectors.
	track _ Track withSectors: sectors.
	
	self assert: 30 * kilometer equals: 	track length! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:52:08'!
test09ACarCanNotBePlacedInAKilometerGreaterThanTrackLength

	| sectors track car outside |
	
	sectors _ self twoSectors.
	
	track _ Track withSectors: sectors.
	outside _ track length + (1 * millimeter).
	car _ self schumacherCar.
	
	self should: [ track put: car at: outside ] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Track cannotPlacedCarErrorDescription equals: error messageText.
			self deny: (track includes: car) ]	
! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:52:08'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:53:19'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:52:08'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:53:43'!
test13GrandPrixLengthShouldBeTrackLengthTimesNumberOfLaps

	| track grandPrix numberOfLaps |
	
	track _ Track withSectors: self twoSectors.
	numberOfLaps _ 100.
	
	grandPrix _ GrandPrix on: track running: numberOfLaps.
	
	self assert: track length * numberOfLaps	 equals: grandPrix length
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:54:30'!
test14TwoCarsCanBeAtTheSameDistanceFromStart

	| grandPrix hamilton verstappen |
	
	grandPrix _ GrandPrix 
		on: self trackWithTenKilometerSector
		running: 100.
	
	verstappen _ self verstappenCar.
	hamilton _ self hamiltonCar.	
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix put: hamilton at: 5 * kilometer.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen). 
	self assert:  5 * kilometer equals: (grandPrix locationOf: hamilton). 
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:54:39'!
test15ACarStoppedShouldNotMoveAfterSomeTime

	| grandPrix verstappen |
	
	verstappen _ self verstappenCar.
	verstappen speed: 0 * kilometer / hour.
	
	grandPrix _ GrandPrix 
		on: self trackWithTenKilometerSector
		running: 100
		with: (Set with: verstappen).
	
	grandPrix put: verstappen at: 5 * kilometer.
	grandPrix advance: 10 * minute.
	
	self assert: 5 * kilometer equals: (grandPrix locationOf: verstappen) 
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:53:19'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:53:19'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 15:53:19'!
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/2/2022 16:05:12'!
test19GrandPrixMovesCarsBetweenSectors

	| grandPrix verstappen sectorA sectorB |
	
	verstappen _ self verstappenCar.
	sectorA _ self tenKilometerTurboSector.
	sectorB _ TurboSector of: 30 * kilometer.
	
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

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:01'!
test20FirstTurboIncrementsSpeedByTwentyPercent

	self 
		assertSpeedShouldBe: 120 * kilometer / hour  
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo ].
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:06'!
test21SecondTurboSpeedsByTenPercent

	self 
		assertSpeedShouldBe: 110 * kilometer / hour  
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo ]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:11'!
test22ThirdTurboSpeedsByFivePercent

	self 
		assertSpeedShouldBe: 105 * kilometer / hour  
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo ]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:16'!
test23AfterThridTurbo_TurboIsExhausted

	"Se podría generalizar el hecho de hacer activateTurbo; deaactiveTurbo... no lo hago para dejar
	más generico el mensaje con el bloque - Hernan"
	self 
		assertSpeedShouldBe: 100 * kilometer / hour  
		after: [ :turboAvailableCar | turboAvailableCar activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo; deactivateTurbo; activateTurbo ]
	
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:22'!
test24CanNotActivateTurboWhenTurboIsActivated

	self withTurboAvailableCarDo: [ :turboAvailableCar |	
		turboAvailableCar activateTurbo.
	
		self 
			should: [ turboAvailableCar activateTurbo ]
			raise: Error - MessageNotUnderstood 
			withMessageText: turboAvailableCar turboAlreadyActivatedErrorDescription ]
	! !

!FormulaOneTest methodsFor: 'tests' stamp: 'HAW 5/3/2022 13:52:30'!
test25CanNotDeactivateTurboWhenIsDeactivated

	self withTurboAvailableCarDo: [ :turboAvailableCar |	
		self 
			should: [ turboAvailableCar deactivateTurbo ]
			raise: Error - MessageNotUnderstood 
			withMessageText: turboAvailableCar turboAlreadydeActivatedErrorDescription ]! !


!FormulaOneTest methodsFor: 'assertions' stamp: 'HAW 5/3/2022 13:48:40'!
assertSpeedShouldBe: aSpeed after: aBlock

	self withTurboAvailableCarDo: [ :turboAvailableCar |
		aBlock value: turboAvailableCar.
	
		self assert: turboAvailableCar isTurboActivated.
		self assert: aSpeed equals: turboAvailableCar speed ]! !


!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/2/2022 15:50:34'!
hamiltonCar

	^ FormulaOneCar drivenBy: #Hamilton! !

!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/2/2022 15:49:28'!
schumacherCar

	^ FormulaOneCar drivenBy: #Schumacher! !

!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/2/2022 15:53:19'!
verstappenCar

	^ FormulaOneCar drivenBy: #Verstappen! !

!FormulaOneTest methodsFor: 'cars' stamp: 'HAW 5/3/2022 13:48:40'!
withTurboAvailableCarDo: aBlock

	| schumacher hamilton sector |
	
	sector _ self twentyFourKilometerTurboSector.
	
	schumacher _ self schumacherCar.
	hamilton _ self hamiltonCar.
	
	schumacher speed: 100 * kilometer / hour.
	hamilton speed: 100 * kilometer / hour.
	
	sector put: schumacher at: 12.99 * kilometer.
	sector put: hamilton at: 13 * kilometer.
	
	aBlock value: schumacher.
	! !


!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 16:04:59'!
tenKilometerTurboSector

	^ TurboSector of: 10 * kilometer! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 16:14:54'!
tenKilometerWithoutTurboSector

	^ NoTurboSector of: 10*kilometer! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 16:05:19'!
twentyFourKilometerTurboSector

	^ TurboSector of: 24 * kilometer! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 16:05:31'!
twentyKilometerTurboSector

	^ TurboSector of: 20 * kilometer! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 16:15:01'!
twentyKilometerWithoutTurboSector

	^ NoTurboSector of: 20 * kilometer! !

!FormulaOneTest methodsFor: 'sectors' stamp: 'HAW 5/2/2022 15:52:08'!
twoSectors

	^ OrderedCollection 
		with: (self tenKilometerTurboSector)
		with: (self twentyKilometerWithoutTurboSector)! !


!FormulaOneTest methodsFor: 'tracks' stamp: 'HAW 5/2/2022 15:54:25'!
trackWithTenKilometerSector

	^ Track withSectors: (OrderedCollection with: (self tenKilometerTurboSector))! !


!classDefinition: #FormulaOneCar category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #FormulaOneCar
	instanceVariableNames: 'grandPrix driver speed traveledDistance currentSector turboStatus'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!FormulaOneCar methodsFor: 'initialization' stamp: 'HAW 5/3/2022 14:13:04'!
initializeDrivenBy: aDriver 

	driver _ aDriver.
	turboStatus _ TurboDeactivated next: TurboActivated firstInActivationChain.
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

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 5/3/2022 14:10:14'!
speed

	^turboStatus speedUp: speed! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 5/1/2022 17:34:26'!
speed: newSpeed

	speed _ newSpeed! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:19'!
traveledDistance

	^ traveledDistance! !

!FormulaOneCar methodsFor: 'moving' stamp: 'HAW 4/30/2022 19:15:31'!
traveledDistance: aDistance

	traveledDistance _ aDistance! !


!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:59:29'!
activateTurbo

	turboStatus activeTurboOn: self! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:57:47'!
deactivateTurbo
	
	turboStatus deactiveTurboOn: self! !

!FormulaOneCar methodsFor: 'turbo' stamp: 'HAW 5/2/2022 14:25:13'!
turboAlreadydeActivatedErrorDescription
	
	^'Turbo is already deactivated'! !


!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/3/2022 14:12:15'!
isTurboActivated
	
	^turboStatus isActivated! !

!FormulaOneCar methodsFor: 'testing' stamp: 'HAW 5/2/2022 14:23:06'!
turboAlreadyActivatedErrorDescription
	
	^'Turbo already activated'! !


!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/3/2022 14:12:55'!
activateTurboInSectorWithTurbo
	
	turboStatus _ turboStatus next.! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/3/2022 13:59:45'!
activeTurboWhenActivated

	self error: self turboAlreadyActivatedErrorDescription! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/3/2022 13:59:58'!
activeTurboWhenDeactivated
	
	currentSector activateTurboTo: self.
! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/3/2022 14:13:00'!
deactiveTurboWhenActivated

	turboStatus _ TurboDeactivated next: turboStatus next.! !

!FormulaOneCar methodsFor: 'turbo-private' stamp: 'HAW 5/3/2022 13:58:13'!
deactiveTurboWhenDeactivated

	self error: self turboAlreadydeActivatedErrorDescription! !

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


!GrandPrix methodsFor: 'simulation' stamp: 'HAW 5/3/2022 14:18:43'!
advance: aTimeLapse
	
	track cars do: [ :car | self relocate: car after: aTimeLapse ]! !

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

!Sector methodsFor: 'car position' stamp: 'HAW 5/3/2022 13:46:00'!
carAtPosition: positionOfDriver

	^cars keyAtValue: positionOfDriver! !

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


!Sector methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:41:00'!
activateTurboTo: aCarToActivateTurboTo

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sector class' category: 'ISW1-2022-1C-Parcial-1'!
Sector class
	instanceVariableNames: ''!

!Sector class methodsFor: 'instance creation' stamp: 'HAW 5/3/2022 13:38:25'!
of: aLength 
	
	self assertIsValid: aLength	.
		
	^ self new initializeOf: aLength! !


!Sector class methodsFor: 'error message' stamp: 'FRT 4/30/2022 10:08:26'!
cannotPlacedCarErrorDescription

	^ 'Driver can not be placed outside section'! !

!Sector class methodsFor: 'error message' stamp: 'HAW 4/30/2022 17:05:20'!
lengthMustBePositiveErrorDescription

	^ 'Length must be positive'! !


!Sector class methodsFor: 'assertions' stamp: 'HAW 5/3/2022 13:38:25'!
assertIsValid: aLength

	^ aLength strictlyPositive ifFalse: [ self error: self lengthMustBePositiveErrorDescription ]! !


!classDefinition: #NoTurboSector category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #NoTurboSector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!NoTurboSector methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:42:11'!
activateTurboTo: aCarToActivateTurboTo

	self error: self class turboNotAllowedErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NoTurboSector class' category: 'ISW1-2022-1C-Parcial-1'!
NoTurboSector class
	instanceVariableNames: ''!

!NoTurboSector class methodsFor: 'error message' stamp: 'HAW 5/3/2022 13:41:33'!
turboNotAllowedErrorDescription
	
	^ 'Turbo not allowed in this Sector'! !


!classDefinition: #TurboSector category: 'ISW1-2022-1C-Parcial-1'!
Sector subclass: #TurboSector
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:42:38'!
activateTurboTo: aCarToActivateTurboTo

	| positionOfCarAhead |

	positionOfCarAhead _ self 
		positionOfCarAheadOf: aCarToActivateTurboTo 
		ifNone: [self error: self class cannotActivateTurboWhenNoCarAheadErrorDescription ].
		
	self 
		assertDriverIsOneSecondOrLess: aCarToActivateTurboTo
		ofDriverAt: positionOfCarAhead.

	aCarToActivateTurboTo activateTurboInSectorWithTurbo
! !

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:44:46'!
assertDriverIsOneSecondOrLess: aCarToActivateTurboTo ofDriverAt: positionOfCarAhead

	| carAhead carAheadTime carToActiveTurboTime |
	
	carAhead _ self carAtPosition: positionOfCarAhead.
	carAheadTime _ positionOfCarAhead / carAhead speed.
	carToActiveTurboTime _ (cars at: aCarToActivateTurboTo) / aCarToActivateTurboTo speed.
	
	carAheadTime - carToActiveTurboTime < (1 * second)
		ifFalse: [self error: self class cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription ].! !

!TurboSector methodsFor: 'turbo' stamp: 'HAW 5/3/2022 13:40:39'!
positionOfCarAheadOf: aCarToActiveTurboTo ifNone: alternativeClosure

	| sortedPositions carToActivateTurboToPosition |
	
	carToActivateTurboToPosition _ cars at: aCarToActiveTurboTo.
	sortedPositions _ cars asSortedCollection remove: carToActivateTurboToPosition; yourself.
	 
	^ sortedPositions 
		detect: [:aPosition | aPosition > carToActivateTurboToPosition ]
		ifNone: alternativeClosure ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboSector class' category: 'ISW1-2022-1C-Parcial-1'!
TurboSector class
	instanceVariableNames: ''!

!TurboSector class methodsFor: 'error message' stamp: 'HAW 5/3/2022 13:43:26'!
cannotActivateTurboWhenMoreThanASecondBehindAnotherCarErrorDescription
	
	^ 'Cannot activate Turbo when opponent is more than 1 second ahead'! !

!TurboSector class methodsFor: 'error message' stamp: 'HAW 5/3/2022 13:42:29'!
cannotActivateTurboWhenNoCarAheadErrorDescription
	
	^ 'Cannot activate Turbo without opponent ahead'! !


!classDefinition: #Track category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #Track
	instanceVariableNames: 'sectors driversDistanceFromBeginning'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!Track methodsFor: 'initialization' stamp: 'HAW 4/30/2022 17:06:50'!
initializeWithSectors: aSectors

	sectors _ aSectors copy.! !


!Track methodsFor: 'car position' stamp: 'HAW 5/3/2022 14:25:16'!
assertCanPlaceCarAt: aPosition

	^ aPosition > self length ifTrue: [ self error: self class cannotPlacedCarErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
carNotFoundErrorDescription

	^ 'Car not found'! !

!Track methodsFor: 'car position' stamp: 'HAW 5/3/2022 14:24:12'!
positionOf: aCar

	| accumulatedLength |
	
	accumulatedLength _ 0 * kilometer.
	sectors do: [ :sector |
		(sector includes: aCar) ifTrue: [ ^accumulatedLength + (sector positionOf: aCar).].
		accumulatedLength _ accumulatedLength + sector length ].
				
	! !

!Track methodsFor: 'car position' stamp: 'HAW 5/3/2022 14:25:16'!
put: aCar at: aPosition

	| accumulator |
	
	self assertCanPlaceCarAt: aPosition.

	self remove: aCar.

	accumulator _ 0 * kilometer.

	sectors do: [ :sector | 
		aPosition <= (accumulator +  sector length) ifTrue: [ ^sector put: aCar at: aPosition - accumulator].
		accumulator _ accumulator + sector length.
	].

! !

!Track methodsFor: 'car position' stamp: 'FRT 4/30/2022 15:15:27'!
remove: aCar
	
	| currentSector |
	
	currentSector _ self sectorOf: aCar ifNone: [ ^ self ].
	currentSector remove: aCar.
	! !

!Track methodsFor: 'car position' stamp: 'HAW 5/2/2022 14:10:18'!
sectorOf: aCar
	
	^self sectorOf: aCar ifNone: [ self error: self carNotFoundErrorDescription ]! !

!Track methodsFor: 'car position' stamp: 'HAW 5/3/2022 14:25:55'!
sectorOf: aCar ifNone: aBlock

	^sectors detect: [ :sector | sector includes: aCar ] ifNone: aBlock ! !


!Track methodsFor: 'accessing' stamp: 'HAW 5/3/2022 14:18:07'!
cars
	
	^(sectors collect: [ :sector | sector cars ]) flatten
	
	"otra posible implementación que hace mejor uso de recursos:
	^sectors 
		inject: OrderedCollection new
		into: [ :cars :sector | cars addAll: sector cars; yourself ]
	"! !

!Track methodsFor: 'accessing' stamp: 'HAW 5/3/2022 14:22:19'!
length

	"Aunque no puede haber tracks sin sectores, uso el sum:ifEmpty: por si 
	esa restricción cambia y se olvidan de esta dependencia - Hernan"
	^sectors sum: [ :sector | sector length ] ifEmpty: [ 0 * kilometer ]
! !


!Track methodsFor: 'testing' stamp: 'HAW 5/3/2022 14:19:57'!
includes: aCar
	"Returns if any of the sectors includes aCar"
	
	^sectors anySatisfy: [ :sector | sector includes: aCar ]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Track class' category: 'ISW1-2022-1C-Parcial-1'!
Track class
	instanceVariableNames: ''!

!Track class methodsFor: 'instance creation' stamp: 'HAW 5/3/2022 14:20:51'!
withSectors: sectors

	self assertNotEmpty: sectors.
	
	^ self new initializeWithSectors: sectors! !


!Track class methodsFor: 'error messages' stamp: 'FRT 4/29/2022 18:22:32'!
cannotPlacedCarErrorDescription

	^ 'Car cannot be placed in track'! !

!Track class methodsFor: 'error messages' stamp: 'HAW 4/30/2022 17:09:27'!
mustHaveSectorsErrorDescription

	^'Track must have sectors'! !


!Track class methodsFor: 'assertions' stamp: 'HAW 5/3/2022 14:20:51'!
assertNotEmpty: sectors

	^ sectors isEmpty ifTrue: [ self error: self mustHaveSectorsErrorDescription ]! !


!classDefinition: #TurboStatus category: 'ISW1-2022-1C-Parcial-1'!
Object subclass: #TurboStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboStatus methodsFor: 'next' stamp: 'HAW 5/3/2022 14:14:18'!
next

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 14:13:48'!
activeTurboOn: aFormulaOneCar 

	self subclassResponsibility ! !

!TurboStatus methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 14:13:54'!
deactiveTurboOn: aFormulaOneCar 

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'testing' stamp: 'HAW 5/3/2022 14:14:06'!
isActivated

	self subclassResponsibility ! !


!TurboStatus methodsFor: 'speeding' stamp: 'HAW 5/3/2022 14:14:32'!
speedUp: aSpeed

	self subclassResponsibility ! !


!classDefinition: #TurboActivated category: 'ISW1-2022-1C-Parcial-1'!
TurboStatus subclass: #TurboActivated
	instanceVariableNames: 'next speedingRatio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboActivated methodsFor: 'initialization' stamp: 'HAW 5/3/2022 14:27:12'!
initializeExhausted
	
	self initializeSpeeding: 1 next: self! !

!TurboActivated methodsFor: 'initialization' stamp: 'HAW 5/3/2022 14:07:22'!
initializeSpeeding: aSpeedingRatio next: aNext 
	
	speedingRatio := aSpeedingRatio.
	next := aNext.! !


!TurboActivated methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 14:01:06'!
activeTurboOn: aFormulaOneCar 
	
	^aFormulaOneCar activeTurboWhenActivated ! !

!TurboActivated methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 13:58:48'!
deactiveTurboOn: aFormulaOneCar 
	
	^aFormulaOneCar deactiveTurboWhenActivated ! !


!TurboActivated methodsFor: 'testing' stamp: 'HAW 5/3/2022 14:12:43'!
isActivated
	
	^true! !


!TurboActivated methodsFor: 'next' stamp: 'HAW 5/3/2022 14:08:32'!
next
	
	^next! !


!TurboActivated methodsFor: 'speeding' stamp: 'HAW 5/3/2022 14:11:06'!
speedUp: aSpeed

	^aSpeed * speedingRatio ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboActivated class' category: 'ISW1-2022-1C-Parcial-1'!
TurboActivated class
	instanceVariableNames: ''!

!TurboActivated class methodsFor: 'instance creation' stamp: 'HAW 5/3/2022 14:06:21'!
exhausted
	
	^self new initializeExhausted! !

!TurboActivated class methodsFor: 'instance creation' stamp: 'HAW 5/3/2022 14:07:12'!
speeding: aSpeedingRatio next: aNext 
	
	^self new initializeSpeeding: aSpeedingRatio next: aNext ! !


!TurboActivated class methodsFor: 'activation chain' stamp: 'HAW 5/3/2022 14:26:37'!
firstInActivationChain
	
	^self 
		speeding: 12 / 10
		next: (self 
			speeding: 11 / 10
			next: (self
				speeding: 105 / 100
				next: self exhausted))! !


!classDefinition: #TurboDeactivated category: 'ISW1-2022-1C-Parcial-1'!
TurboStatus subclass: #TurboDeactivated
	instanceVariableNames: 'next'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-1C-Parcial-1'!

!TurboDeactivated methodsFor: 'initialization' stamp: 'HAW 5/3/2022 14:07:52'!
initializeNext: aNextTurboStatus 
	
	next := aNextTurboStatus.! !


!TurboDeactivated methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 14:00:45'!
activeTurboOn: aFormulaOneCar 
	
	^aFormulaOneCar activeTurboWhenDeactivated ! !

!TurboDeactivated methodsFor: 'activate/deactivate' stamp: 'HAW 5/3/2022 13:59:02'!
deactiveTurboOn: aFormulaOneCar 
	
	^aFormulaOneCar deactiveTurboWhenDeactivated ! !


!TurboDeactivated methodsFor: 'testing' stamp: 'HAW 5/3/2022 14:12:25'!
isActivated
	
	^false! !


!TurboDeactivated methodsFor: 'next' stamp: 'HAW 5/3/2022 14:09:18'!
next
	
	^next! !


!TurboDeactivated methodsFor: 'speeding' stamp: 'HAW 5/3/2022 14:10:26'!
speedUp: aSpeed

	^aSpeed ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TurboDeactivated class' category: 'ISW1-2022-1C-Parcial-1'!
TurboDeactivated class
	instanceVariableNames: ''!

!TurboDeactivated class methodsFor: 'instance creation' stamp: 'HAW 5/3/2022 14:07:40'!
next: aNextTurboStatus 
	
	^self new initializeNext: aNextTurboStatus ! !
