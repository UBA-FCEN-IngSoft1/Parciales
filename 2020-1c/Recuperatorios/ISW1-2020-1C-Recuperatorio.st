!classDefinition: #CargoVehicleTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #CargoVehicleTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:38:43'!
test01TruckCanNotCarryTruck

	self assert: self truckType canNotCarry: self truckType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test02TruckCanCarryMotocicly

	self assertTruckCanCarry: self motorcycleType! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test03VehicleDoesNotCarryNotCarryingVehicles

	| carriedLeavingTime vehicle carriedVehicleTargetCity targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	carriedLeavingTime := GregorianDateTime now.
	
	vehicle := CargoVehicle 
		ofType: self motorcycleType 
		from: targetCity 
		to: carriedVehicleTargetCity 
		leavingAt:carriedLeavingTime 
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	self deny: (vehicle carries: vehicle).! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:40:17'!
test04TruckCanNotCarryDrone

	self assertTruckCanCarry: self droneType! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test05MotorcicleCanCarryDrone

	self assert: self motorcycleType canCarry: self droneType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test06MotorcicleCanNotCarryMotorcicle

	self assert: self motorcycleType canNotCarry: self motorcycleType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test07MotorcicleCanNotCarryTruck

	self assert: self motorcycleType canNotCarry: self truckType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:41:53'!
test08DroneCanNotCarryTruck

	self assert: self droneType canNotCarry: self truckType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:56:14'!
test09DroneCanNotCarryMotorcicle

	self assert: self droneType canNotCarry: self motorcycleType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:43:07'!
test10DroneCanNotCarryDrone

	self assert: self droneType canNotCarry: self droneType ! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 14:53:28'!
test11TypeCanOnlyBeTruckOrMotorcicleOrDrone

	| carriedLeavingTime carriedVehicleTargetCity targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	carriedLeavingTime := GregorianDateTime now.
	
	self 
		should: [  CargoVehicle 
			ofType: #InvalidType
			from: targetCity 
			to: carriedVehicleTargetCity 
			leavingAt:carriedLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: {} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CargoVehicle invalidVehicleTypeErrorDescription! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 15:05:49'!
test12CarriedVehicleSourceCityMustBeConveyorTargetCity

	| carriedLeavingTime carriedVehicle carriedVehicleTargetCity conveyorLeavingTime targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	conveyorLeavingTime := GregorianDateTime now.
	carriedLeavingTime := conveyorLeavingTime next: 1*day.
	
	carriedVehicle := CargoVehicle 
		ofType: self droneType 
		from: 'alguna ciudad' 
		to: carriedVehicleTargetCity 
		leavingAt:carriedLeavingTime 
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	self 
		should: [ CargoVehicle 
			ofType: self truckType 
			from: 'CABA'
			to: targetCity 
			leavingAt: conveyorLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: { carriedVehicle } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CargoVehicle carriedSourceCityMustBeConveryorTargetCityErrorDescription
		! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 15:11:07'!
test13CarriedVehicleLeavingTimeCanNotBeTheSameAsConveyorArrivingTime

	| carriedLeavingTime carriedVehicle carriedVehicleTargetCity conveyorLeavingTime targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	conveyorLeavingTime := GregorianDateTime now.
	carriedLeavingTime := conveyorLeavingTime next: 1*day.
	
	carriedVehicle := CargoVehicle 
		ofType: self droneType 
		from: targetCity 
		to: carriedVehicleTargetCity 
		leavingAt: (conveyorLeavingTime next: self travelingTime)
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	self 
		should: [ CargoVehicle 
			ofType: self truckType 
			from: 'CABA'
			to: targetCity 
			leavingAt: conveyorLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: { carriedVehicle } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CargoVehicle carriedLeavingTimeMustBeAfterConveyorArrivingTime
		! !

!CargoVehicleTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 15:13:47'!
test14CarriedVehicleLeavingTimeCanNotBeBeforeConveyorArrivingTime

	| carriedLeavingTime carriedVehicle carriedVehicleTargetCity conveyorLeavingTime targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	conveyorLeavingTime := GregorianDateTime now.
	carriedLeavingTime := conveyorLeavingTime next: 1*day.
	
	carriedVehicle := CargoVehicle 
		ofType: self droneType 
		from: targetCity 
		to: carriedVehicleTargetCity 
		leavingAt: ((conveyorLeavingTime next: self travelingTime) previous: 1*second)
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	self 
		should: [ CargoVehicle 
			ofType: self truckType 
			from: 'CABA'
			to: targetCity 
			leavingAt: conveyorLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: { carriedVehicle } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CargoVehicle carriedLeavingTimeMustBeAfterConveyorArrivingTime
		! !


!CargoVehicleTest methodsFor: 'assertions' stamp: 'HAW 8/13/2020 14:57:15'!
assert: aConveyorVehicleType canCarry: aCarriedVehicleType

	| carriedLeavingTime carriedVehicle carriedVehicleTargetCity conveyorLeavingTime targetCity conveyorVehicle |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	conveyorLeavingTime := GregorianDateTime now.
	carriedLeavingTime := conveyorLeavingTime next: 1*day.
	
	carriedVehicle := CargoVehicle 
		ofType: aCarriedVehicleType
		from: targetCity 
		to: carriedVehicleTargetCity 
		leavingAt:carriedLeavingTime 
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	conveyorVehicle := CargoVehicle 
			ofType: aConveyorVehicleType 
			to: targetCity 
			leavingAt: conveyorLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: { carriedVehicle }.
			
	self assert: (conveyorVehicle carries: carriedVehicle).! !

!CargoVehicleTest methodsFor: 'assertions' stamp: 'HAW 8/13/2020 14:36:01'!
assert: aConveyorVehicleType canNotCarry: aCarriedVehicleType

	| carriedLeavingTime carriedVehicle carriedVehicleTargetCity conveyorLeavingTime targetCity |
	
	targetCity := 'Cordoba'.
	carriedVehicleTargetCity := 'Santa Fe'.
	conveyorLeavingTime := GregorianDateTime now.
	carriedLeavingTime := conveyorLeavingTime next: 1*day.
	
	carriedVehicle := CargoVehicle 
		ofType: aCarriedVehicleType 
		from: targetCity 
		to: carriedVehicleTargetCity 
		leavingAt:carriedLeavingTime 
		maxWeight: 10 
		routingWith: self 
		carrying: {}.
		
	self 
		should: [ CargoVehicle 
			ofType: aConveyorVehicleType 
			to: targetCity 
			leavingAt: conveyorLeavingTime 
			maxWeight: 10 
			routingWith: self 
			carrying: { carriedVehicle } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CargoVehicle canNotTranportVehicleErrorDescription
		! !

!CargoVehicleTest methodsFor: 'assertions' stamp: 'HAW 8/13/2020 14:33:56'!
assertTruckCanCarry: aCarriedVehicleType

	self assert: #Truck canCarry: aCarriedVehicleType ! !


!CargoVehicleTest methodsFor: 'vehicle types' stamp: 'HAW 8/13/2020 15:34:04'!
droneType

	^ CargoVehicle droneType! !

!CargoVehicleTest methodsFor: 'vehicle types' stamp: 'HAW 8/13/2020 15:36:19'!
motorcycleType

	^ CargoVehicle motorcycleType ! !

!CargoVehicleTest methodsFor: 'vehicle types' stamp: 'HAW 8/13/2020 15:36:28'!
truckType

	^ CargoVehicle truckType ! !


!CargoVehicleTest methodsFor: 'routing time calculator' stamp: 'HAW 8/13/2020 15:10:29'!
from: aFromCity to: aTargetCity forCargoVehicleType: aType

	^self travelingTime ! !

!CargoVehicleTest methodsFor: 'routing time calculator' stamp: 'HAW 8/13/2020 15:10:29'!
travelingTime

	^ 1*minute! !


!classDefinition: #CashierTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 5/4/2020 11:45:58'!
shouldRaise: errorMessage when: aBlock

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ aBlock value: aRobot value: aCashier ]
		raise: Error
		withMessageText: errorMessage.
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 5/4/2020 11:47:39'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	self 
		shouldRaise: Cashier trailerIsEmptyErrorDescription 
		when: [ :aRobot :aCashier | aCashier receiveOrderFromNormal: aRobot ]
! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'FRT 6/11/2020 17:02:13'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	self 
		shouldRaise: Cashier trailerIsEmptyErrorDescription 
		when: [ :aRobot :aCashier | 
			aRobot withMechanicalFailure.
			aCashier receiveOrderFromMechanicalFailure: aRobot 
		]
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'LL 7/24/2020 18:57:05'!
test03ShouldNotAcceptSensorsFailureRobot

	self 
		shouldRaise: Cashier robotSensorsFailureErrorDescription 
		when: [ :aRobot :aCashier | 
			aRobot withSensorsFailure.
			aCashier receiveOrderFromSensorsFailure: aRobot 
		]
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'F 5/20/2020 23:55:01'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	self 
		shouldRaise: Robot outOfOrderErrorDescription
		when: [ :aRobot :aCashier |
			aRobot take: (ProductA with: 1  and: 1).
			aRobot withMechanicalFailure.
			
			aCashier receiveOrderFromMechanicalFailure: aRobot.			
			
			aRobot take: (ProductA with: 1 and: 1).
		]
! !


!classDefinition: #CleaningTrailerTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #CleaningTrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:45:09'!
test01ProductsAreNotCleanedWhenThereIsNoCleaners

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer. 
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {}.
	initialPollutionIndex := 10.
	product := ProductA with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.
	
	self assertPollutionIndexOf: product is: initialPollutionIndex andIncludedIn: trailer
	! !

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:45:53'!
test02BleachCleanerReducesProductBPollutionIndexBy3

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer.
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {BleachCleaner new}.
	initialPollutionIndex := 10.
	product := ProductB with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.
	
	self assertPollutionIndexOf: product is: initialPollutionIndex - 3 andIncludedIn: trailer

! !

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:46:03'!
test03BleachCleanerDoesNotReduceProductAPollutionIndex

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer.
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {BleachCleaner new}.
	initialPollutionIndex := 10.
	product := ProductA with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.
	
	self assertPollutionIndexOf: product is: initialPollutionIndex andIncludedIn: trailer
! !

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:46:15'!
test04UVRaysCleanerReducesProductAPollutionIndexBy80Percent

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer.
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {UVRaysCleaner new}.
	initialPollutionIndex := 10.
	product := ProductA with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.

	self assertPollutionIndexOf: product is: initialPollutionIndex - (initialPollutionIndex * 0.8) andIncludedIn: trailer
	! !

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:46:28'!
test05UVRaysCleanerReducesProductBPollutionIndexBy80Percent

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer.
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {UVRaysCleaner new}.
	initialPollutionIndex := 10.
	product := ProductB with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.
	
	self assertPollutionIndexOf: product is: initialPollutionIndex - (initialPollutionIndex * 0.8) andIncludedIn: trailer
! !

!CleaningTrailerTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 10:46:39'!
test06CleanersAreAppliedInOrder

	| cleaningTrailer initialPollutionIndex product trailer |
	
	trailer := self createTrailer.
	cleaningTrailer := CleaningTrailer for: trailer cleaningWith: {UVRaysCleaner new. BleachCleaner new}.
	initialPollutionIndex := 10.
	product := ProductB with: 1 and: 1 pollutionIndex: initialPollutionIndex.
	
	cleaningTrailer carry: product.
	
	self assertPollutionIndexOf: product is: initialPollutionIndex - (initialPollutionIndex * 0.8) - 3 andIncludedIn: trailer
! !


!CleaningTrailerTest methodsFor: 'test objects' stamp: 'HAW 7/28/2020 10:42:46'!
createTrailer

	^ Trailer with: self defaultWeight and: self defaultHeight! !

!CleaningTrailerTest methodsFor: 'test objects' stamp: 'HAW 7/28/2020 10:17:53'!
defaultHeight
	
	^20! !

!CleaningTrailerTest methodsFor: 'test objects' stamp: 'HAW 7/28/2020 10:17:42'!
defaultWeight
	
	^20
	! !


!CleaningTrailerTest methodsFor: 'assertions' stamp: 'HAW 7/28/2020 10:45:35'!
assertPollutionIndexOf: product is: aPollutionIndex andIncludedIn: trailer

	self assert: aPollutionIndex equals: product pollutionIndex.
	self assert: (trailer includes: product)! !


!classDefinition: #MountableTrailerTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #MountableTrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:17:25'!
test01MountableTrailerMustHaveTrailers

	self 
		should: [ MountableTrailer selectingBiggerCapacityOf: {}]
		raise: Error - MessageNotUnderstood 
		withMessageText: MountableTrailer mustHaveTrailersErrorDescription! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:24:21'!
test02ProductsArePlacesInInnerTrailers

	| mountableTrailer innerTrailer productToCarry |
	
	innerTrailer := Trailer with: 10 and: 10.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { innerTrailer }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerTrailer includes: productToCarry).
	self assert: (mountableTrailer includes: productToCarry)
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:24:55'!
test03BiggerCapacityTrailerIsSelected

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 |
	
	innerTrailer1 := Trailer with: 10 and: 10.
	innerTrailer2 := Trailer with: 20 and: 10.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. innerTrailer2 }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerTrailer2 includes: productToCarry).
	self deny: (innerTrailer1 includes: productToCarry).
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:25:21'!
test04FailsWhenNoTrailerCanCarryProduct

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 |
	
	innerTrailer1 := Trailer with: 10 and: 10.
	innerTrailer2 := Trailer with: 20 and: 10.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. innerTrailer2 }.
	
	productToCarry := ProductA with: 30 and: 1.
	self 
		should: [mountableTrailer carry: (productToCarry) ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: mountableTrailer notTrailerAvailableErrorDescription equals: anError messageText.
			self deny: (innerTrailer2 includes: productToCarry).
			self deny: (innerTrailer1 includes: productToCarry). ]
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:26:00'!
test05LooksForTheTrailerAvailableToCarryProduct

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 |
	
	innerTrailer1 := Trailer with: 10 and: 10.
	innerTrailer2 := Trailer with: 20 and: 10.
	innerTrailer2 carry: (ProductA with: 20 and: 1).
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. innerTrailer2 }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self deny: (innerTrailer2 includes: productToCarry).
	self assert: (innerTrailer1 includes: productToCarry). 
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:26:21'!
test06MountableTrailersCanBePartOfMountableTrailers

	| mountableTrailer innerInnerTrailer productToCarry mountableInnerTrailer innerTrailer |
	
	innerInnerTrailer := Trailer with: 10 and: 10.
	mountableInnerTrailer := MountableTrailer selectingBiggerCapacityOf: { innerInnerTrailer }.
	innerTrailer := Trailer with: 20 and: 10.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { mountableInnerTrailer. innerTrailer }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerTrailer includes: productToCarry). 
	self deny: (mountableInnerTrailer includes: productToCarry). 
	
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:27:32'!
test07SelectsTrailersRecursively

	| mountableTrailer innerInnerTrailer productToCarry mountableInnerTrailer innerTrailer |
	
	innerInnerTrailer := Trailer with: 30 and: 10.
	mountableInnerTrailer := MountableTrailer selectingBiggerCapacityOf: { innerInnerTrailer }.
	innerTrailer := Trailer with: 20 and: 10.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { mountableInnerTrailer. innerTrailer }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerInnerTrailer includes: productToCarry). 
	self deny: (innerTrailer includes: productToCarry). 
	
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:27:53'!
test08CanSelectLigtherTrailer

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 |
	
	innerTrailer1 := Trailer with: 30 and: 10.
	innerTrailer2 := Trailer with: 20 and: 10.
	innerTrailer1 carry: (ProductA with: 1 and: 1).
	
	mountableTrailer := MountableTrailer selectingLighterOf: { innerTrailer1 . innerTrailer2 }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerTrailer2 includes: productToCarry). 
	self deny: (innerTrailer1 includes: productToCarry). 
	
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:28:20'!
test09CanSelectLigtherMountableTrailer

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 innerMountableTrailer |
	
	innerTrailer1 := Trailer with: 30 and: 10.
	innerTrailer2 := Trailer with: 30 and: 10.
	innerTrailer2 carry: (ProductA with: 1 and: 1).
	innerMountableTrailer := MountableTrailer selectingLighterOf: { innerTrailer1 }.
	mountableTrailer := MountableTrailer selectingLighterOf: { innerMountableTrailer. innerTrailer2 }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	
	self assert: (innerTrailer1 includes: productToCarry). 
	self deny: (innerTrailer2 includes: productToCarry). 
	
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:28:39'!
test10CountsFailedCarriesOnTrailers

	| mountableTrailer innerTrailer1 productToCarry innerTrailer2 productToCarry2 |
	
	innerTrailer1 := Trailer with: 10 and: 10.
	innerTrailer2 := Trailer with: 20 and: 10.
	innerTrailer2 carry: (ProductA with: 20 and: 1).
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. innerTrailer2 }.
	
	productToCarry := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry).
	productToCarry2 := ProductA with: 1 and: 1.
	mountableTrailer carry: (productToCarry2).
	
	self assert: (mountableTrailer failedCarriesFor: innerTrailer2) equals: 2.
	self assert: (mountableTrailer failedCarriesFor: innerTrailer1) equals: 0.
	
	
	
	! !

!MountableTrailerTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 18:28:53'!
test11TrailersCanNotBeShared

	| innerTrailer1 innerTrailer2 |
	
	innerTrailer1 := Trailer with: 10 and: 10.
	innerTrailer2 := MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. }.
	
	self 
		should: [ MountableTrailer selectingBiggerCapacityOf: { innerTrailer1. innerTrailer2 } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MountableTrailer canNotShareTrailersErrorDescripition! !


!classDefinition: #ProductTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:51:50'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ ProductA with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:53:22'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ ProductA with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'F 5/5/2020 11:19:12'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'F 5/5/2020 11:19:17'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #ShippingTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #ShippingTest
	instanceVariableNames: 'routingTimeCalculator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:21:03'!
asssert: robot canNotBeShippTo: targetCity at: maxDeliveryTime in: distributionCenter with: cargoVehicle.
	
	^ self 
		should: [ distributionCenter 
			ship: robot to: targetCity at: maxDeliveryTime selectingWith: ArrivingLastSelectionCriteria new ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self asssert: robot isNotShippedWith: cargoVehicle dueTo: anError in: distributionCenter]! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:20:49'!
asssert: robot isNotShippedWith: cargoVehicle dueTo: anError in: distributionCenter

	self assert: distributionCenter noCargoVehicleAvailableErrorDescription equals: anError messageText.
			self assert: robot hasTrailerAttached.
			self deny: (cargoVehicle willShip: robot trailer)! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:13:20'!
createRobot
	
	| robot trailer |
	
	trailer := CleaningTrailer for: (Trailer with: 20 and: 20) cleaningWith: {}.
	robot := Robot with: trailer.
	robot carry: (ProductA with: 10 and: 10).
	
	^robot! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:12:03'!
test01CanNotShipRobotWhenThereIsNoCargoVehicleAvailable

	| distributionCenter maxDeliveryTime robot targetCity |
	 
	robot := self createRobot.
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {}.
	
	self 
		should: [distributionCenter 
				ship: robot
				to: targetCity 
				at: maxDeliveryTime 
				selectingWith: ArrivingLastSelectionCriteria new ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: distributionCenter noCargoVehicleAvailableErrorDescription equals: anError messageText.
			self assert: robot hasTrailerAttached ].
	! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:15:44'!
test02RobotIsShippedWhenThereIsACargoVehicleToShipIt

	| distributionCenter maxDeliveryTime robot targetCity trailer cargoVehicle selectedCargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	trailer := robot trailer.
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 10 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle}.

	selectedCargoVehicle := distributionCenter 
		ship: robot to: targetCity at: maxDeliveryTime selectingWith: ArrivingLastSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (selectedCargoVehicle willShip: trailer)
	! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:20:03'!
test03CanNotShipRobotWhenThereIsNoCargoVehicleToTargetCity

	| distributionCenter maxDeliveryTime robot targetCity cargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: 'Mendoza' leavingAt: maxDeliveryTime previous maxWeight: 10 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle}.

	self asssert: robot canNotBeShippTo: targetCity at: maxDeliveryTime in: distributionCenter with: cargoVehicle.
		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:21:19'!
test04CanNotShipRobotWhenRobotWeightExceedsCargoVehicleWeight

	| distributionCenter maxDeliveryTime robot targetCity cargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 0 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle}.

	self asssert: robot canNotBeShippTo: targetCity at: maxDeliveryTime in: distributionCenter with: cargoVehicle.

		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:21:32'!
test05CanNotShipRobotWhenCurrentVehicleWeightPlusRobotWeightIsGreaterThanMaxVehicleWeight

	| distributionCenter maxDeliveryTime robot targetCity cargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.	
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle}.
	distributionCenter ship: robot to: targetCity at: maxDeliveryTime selectingWith: ArrivingLastSelectionCriteria new.

	robot := self createRobot.
	
	self asssert: robot canNotBeShippTo: targetCity at: maxDeliveryTime in: distributionCenter with: cargoVehicle.
! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:21:43'!
test06CanNotShipRobotWhenArrivingTimeIsLaterThanMaxDeliveryTime

	| distributionCenter maxDeliveryTime robot targetCity cargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	
	routingTimeCalculator := [ :fromCity :toCity :type | 2*second ].
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle}.
		
	self asssert: robot canNotBeShippTo: targetCity at: maxDeliveryTime in: distributionCenter with: cargoVehicle.
! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:16:25'!
test07ArrivingLastSelectsTheLatestArrivingCargoVehicle

	| distributionCenter maxDeliveryTime robot targetCity trailer arrivingFirstCargoVehicle arrivingLastCargoVehicle selectedCargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	trailer := robot trailer.
	
	arrivingFirstCargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: (maxDeliveryTime previous: 10*second) maxWeight: 11 routingWith: self.
	arrivingLastCargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {arrivingFirstCargoVehicle. arrivingLastCargoVehicle }.
		
	selectedCargoVehicle := distributionCenter 
		ship: robot to: targetCity at: maxDeliveryTime selectingWith: ArrivingLastSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (arrivingLastCargoVehicle willShip: trailer).
	self assert: arrivingLastCargoVehicle equals: selectedCargoVehicle
		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 7/28/2020 12:16:38'!
test08LighterSelectionCriteriaSelectsLigtherCargoVehicle

	| distributionCenter maxDeliveryTime robot targetCity trailer heavierCargoVehicle lighterCargoVehicle selectedCargoVehicle |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	heavierCargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	lighterCargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {heavierCargoVehicle. lighterCargoVehicle }.
	robot shipWith: heavierCargoVehicle.
	
	robot := self createRobot.
	trailer := robot trailer.
	selectedCargoVehicle := distributionCenter 
		ship: robot to: targetCity at: maxDeliveryTime selectingWith: LigtherCargoVehicleSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (lighterCargoVehicle willShip: trailer).
	self assert: lighterCargoVehicle equals: selectedCargoVehicle
		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 15:51:08'!
test09CarriedVehiclesAreUsedInShipping

	| distributionCenter maxDeliveryTime robot targetCity trailer carriedVehicle conveyorVehicle selectedCargoVehicle carriedTargetCity carriedVehicleLeavingTime |
	
	targetCity := 'CABA'.
	carriedTargetCity := 'Cordoba'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	trailer := robot trailer.
	
	carriedVehicleLeavingTime := (maxDeliveryTime next: self defaultTravelTime) next.
	carriedVehicle := CargoVehicle 
		ofType: CargoVehicle droneType from: targetCity to: carriedTargetCity leavingAt: carriedVehicleLeavingTime maxWeight: 11 routingWith: self carrying: {}.
	conveyorVehicle := CargoVehicle 
		ofType: CargoVehicle truckType to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self 
		carrying: { carriedVehicle }.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: { conveyorVehicle }.
		
	selectedCargoVehicle := distributionCenter 
		ship: robot to: carriedTargetCity at: (carriedVehicleLeavingTime next: 1*day) selectingWith: ArrivingLastSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (carriedVehicle willShip: trailer).
	self assert: carriedVehicle equals: selectedCargoVehicle
		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 15:55:34'!
test10SelectsLatestCarriedVehicleWithLatestSelectedCriteria

	| distributionCenter maxDeliveryTime robot targetCity trailer earlierCarriedVehicle conveyorVehicle selectedCargoVehicle carriedTargetCity carriedVehicleLeavingTime latestCarriedVehicle |
	
	targetCity := 'CABA'.
	carriedTargetCity := targetCity.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	robot := self createRobot.
	trailer := robot trailer.
	
	carriedVehicleLeavingTime := (maxDeliveryTime next: self defaultTravelTime) next.
	earlierCarriedVehicle := CargoVehicle 
		ofType: CargoVehicle droneType from: targetCity to: carriedTargetCity leavingAt: carriedVehicleLeavingTime maxWeight: 11 routingWith: self carrying: {}.
	latestCarriedVehicle := CargoVehicle 
		ofType: CargoVehicle droneType from: targetCity to: carriedTargetCity leavingAt: carriedVehicleLeavingTime next maxWeight: 11 routingWith: self carrying: {}.
	conveyorVehicle := CargoVehicle 
		ofType: CargoVehicle truckType to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self 
		carrying: { earlierCarriedVehicle. latestCarriedVehicle }.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: { conveyorVehicle }.
		
	selectedCargoVehicle := distributionCenter 
		ship: robot to: carriedTargetCity at: (carriedVehicleLeavingTime next: 1*day) selectingWith: ArrivingLastSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (latestCarriedVehicle willShip: trailer).
	self assert: latestCarriedVehicle equals: selectedCargoVehicle
		! !

!ShippingTest methodsFor: 'tests' stamp: 'HAW 8/13/2020 16:50:31'!
test11TrailerOfMountableTrailersAreShipped

	| distributionCenter maxDeliveryTime robot targetCity trailer cargoVehicle mountableTrailer |
	
	targetCity := 'CABA'.
	maxDeliveryTime := GregorianDateTime now next: 10*hour. 
	
	trailer := Trailer with: 20 and: 20.
	mountableTrailer := MountableTrailer selectingBiggerCapacityOf: { trailer }.
	robot := Robot with: mountableTrailer.
	robot carry: (ProductA with: 10 and: 10).
		
	cargoVehicle := CargoVehicle 
		ofType: #Truck to: targetCity leavingAt: maxDeliveryTime previous maxWeight: 11 routingWith: self.
	distributionCenter := DistibutionCenter withAvailableCargoVehicles: {cargoVehicle }.
		
	distributionCenter 
		ship: robot to: targetCity at: maxDeliveryTime selectingWith: ArrivingLastSelectionCriteria new.
	
	self deny: robot hasTrailerAttached.
	self assert: (cargoVehicle willShip: trailer).
	self deny: (cargoVehicle willShip: mountableTrailer).
	
		! !


!ShippingTest methodsFor: 'setUp/tearDown' stamp: 'HAW 8/13/2020 15:44:10'!
defaultTravelTime

	^ 1*second! !

!ShippingTest methodsFor: 'setUp/tearDown' stamp: 'HAW 8/13/2020 15:44:10'!
setUp

	routingTimeCalculator := [ :fromCity :toCity :cargoVehicleType | self defaultTravelTime ].! !


!ShippingTest methodsFor: 'routing time calculator' stamp: 'HAW 7/28/2020 11:41:25'!
from: aFromCity to: aTargetCity forCargoVehicleType: aType

	^routingTimeCalculator value: aFromCity value: aTargetCity value: aType! !


!classDefinition: #TrailerTest category: #'ISW1-2020-1C-Recuperatorio'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 15:14:57'!
shouldAcceptProducts: aTrailerBlock withAmount: anExpectedAmount andWeight: anExpectedWeight  

	| aTrailer |
	aTrailer := Trailer with: 11  and: 100.
	
	aTrailer carry: (ProductA with: 1 and: 1).
	aTrailer carry: (ProductA with: 2 and: 1).
	aTrailer carry: (ProductB with: 3 and: 1).
	aTrailer carry: (ProductB with: 4 and: 1).
	aTrailerBlock value: aTrailer.
		
	self assert: aTrailer totalProductsAmount equals: anExpectedAmount.
	self assert: aTrailer totalProductsWeight equals: anExpectedWeight ! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 16:47:37'!
shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: aProductType

	| aTrailer |
	aTrailer := Trailer with: 20  and: 100.
	
	self
		should: [ aTrailer carry: (aProductType with: 21 and: 1)]
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:29:39'!
test01CanNotCreateTrailerWithCeroOrLessMaxWeight

	self
		should: [ Trailer with: 0  and: 100 ]
		raise: Error
		withMessageText: Trailer invalidWeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:30:47'!
test02CanNotCreateTrailerWithCeroOrLessMaxHeight

	self
		should: [ Trailer with: 1  and: 0 ]
		raise: Error
		withMessageText: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:04'!
test03CanNotCreateTrailerWithNoIntegerMaxWeight

	self
		should: [ Trailer with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'FRT 5/4/2020 17:41:29'!
test04CanNotCreateTrailerWithNoIntegerMaxHeight

	self
		should: [ Trailer with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 16:46:28'!
test05ShouldRejectProductAIfWeightExceeded

	self shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: ProductA ! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 16:45:53'!
test06ShouldRejectProductBIfWeightExceeded

	self shouldSignalMaxWeightExceededErrorDescriptionWhenAdding: ProductB
	! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 15:14:15'!
test07ShouldAcceptProductsIfWeightUnderMaxWeightCapacity

	self shouldAcceptProducts: [ :trailer | ] withAmount: 4 andWeight: 10.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'HAW 6/7/2020 15:15:27'!
test08ShouldAcceptProductsIfWeightEqualsMaxWeightCapacity

	self shouldAcceptProducts: [ :trailer | trailer carry: (ProductB with: 1 and: 1).] withAmount: 5 andWeight: 11.
! !


!TrailerTest methodsFor: 'height capacity' stamp: 'HAW 6/7/2020 15:25:07'!
assertHeightShouldBe: anExpectedHeightBlock whenAdding: aProductTypeToAdd 

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (aProductTypeToAdd with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: (anExpectedHeightBlock value: halfExceededHeightCapacity)! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 16:54:16'!
test09ShouldAcceptNonStackableProductsIgnoringHeightCapacity

	self assertHeightShouldBe: [ :aHeight | 0 ] whenAdding: ProductA! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 17:00:21'!
test10ShouldIgnoreNonStackableProductsWhenAddingStackableProduct

	self assertHeightShouldBe: [ :aHeight | aHeight ] whenAdding: ProductB! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 6/11/2020 16:58:06'!
test11ShouldRejectStackableProductExceedingHeightCapacity

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !


!classDefinition: #CargoVehicle category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #CargoVehicle
	instanceVariableNames: 'targetCity leavingTime maxWeight trailers arrivingTime sourceCity carryingVehicles type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CargoVehicle methodsFor: 'initialization' stamp: 'HAW 7/28/2020 11:45:07'!
initializeTo: aTargetCity leavingAt: aLeavingTime arrivingAt: anArrivingTime maxWeight: aMaxWeight 
	
	targetCity := aTargetCity.
	leavingTime := aLeavingTime.
	arrivingTime := anArrivingTime.
	maxWeight := aMaxWeight.
	trailers := OrderedCollection new.! !

!CargoVehicle methodsFor: 'initialization' stamp: 'HAW 8/13/2020 14:25:56'!
initializeType: aType to: aTargetCity from: aSourceCity leavingAt: aLeavingTime arrivingAt: anArrivingTime maxWeight: aMaxWeight carrying: aCollectionOfCargoVehicles
	
	type := aType.
	sourceCity := aSourceCity.
	targetCity := aTargetCity.
	leavingTime := aLeavingTime.
	arrivingTime := anArrivingTime.
	maxWeight := aMaxWeight.
	carryingVehicles := aCollectionOfCargoVehicles.
	trailers := OrderedCollection new.! !


!CargoVehicle methodsFor: 'times' stamp: 'HAW 7/28/2020 11:58:51'!
arrivingTime
	
	^arrivingTime! !

!CargoVehicle methodsFor: 'times' stamp: 'HAW 8/13/2020 15:12:21'!
leavingTime
	
	^leavingTime! !


!CargoVehicle methodsFor: 'adding trailer' stamp: 'HAW 7/28/2020 11:22:10'!
add: aTrailer 
	
	trailers add: aTrailer ! !


!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:24:06'!
arrivesBefore: aMaxDeliveryTime

	^ arrivingTime <= aMaxDeliveryTime! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:23:56'!
canAddWeightOf: aRobot

	^ aRobot trailerTotalProductsWeight + self totalWeight <= maxWeight! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:24:09'!
canShip: aRobot to: aTargetCity at: aMaxDeliveryTime
 
	^(self shipsTo: aTargetCity) 
		and: [ (self canAddWeightOf: aRobot)
		and: [ self arrivesBefore: aMaxDeliveryTime ] ]! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 8/13/2020 14:29:47'!
carries: aCargoVehicle 
	
	^carryingVehicles includes: aCargoVehicle ! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 8/13/2020 18:15:05'!
leavesAfter: aTime

	^leavingTime > aTime! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:23:33'!
shipsTo: aTargetCity

	^ targetCity = aTargetCity! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 11:22:52'!
willShip: aTrailer 
	
	^trailers includes: aTrailer ! !


!CargoVehicle methodsFor: 'weight' stamp: 'HAW 7/28/2020 12:03:22'!
totalWeight

	^ trailers sum: [ :aTrailer | aTrailer totalProductsWeight ] ifEmpty: [ 0 ]! !


!CargoVehicle methodsFor: 'type' stamp: 'HAW 8/13/2020 14:26:41'!
type
	
	^type! !


!CargoVehicle methodsFor: 'cities' stamp: 'HAW 8/13/2020 15:07:21'!
sourceCity
	
	^sourceCity! !


!CargoVehicle methodsFor: 'enumeration vehicles' stamp: 'HAW 8/13/2020 15:47:56'!
addVehiclesTo: aCollectorOfVehicles

	aCollectorOfVehicles add: self.
	carryingVehicles do: [ :aCargoVehicle | aCargoVehicle addVehiclesTo: aCollectorOfVehicles ].
	
	^aCollectorOfVehicles ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CargoVehicle class' category: #'ISW1-2020-1C-Recuperatorio'!
CargoVehicle class
	instanceVariableNames: ''!

!CargoVehicle class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 18:12:27'!
ofType: aType from: aSourceCity to: aTargetCity leavingAt: aLeavingTime maxWeight: aMaxWeight routingWith: aRouteTimeCalculator carrying: aCollectionOfCargoVehicles
	
	| arrivingTime |
	
	arrivingTime := aLeavingTime next: (aRouteTimeCalculator from: aSourceCity to: aTargetCity forCargoVehicleType: aType).
	
	self assertIsValidType: aType.
	self assertType: aType canCarry: aCollectionOfCargoVehicles after: arrivingTime from: aTargetCity.
	
	^self new initializeType: aType to: aTargetCity from: aSourceCity leavingAt: aLeavingTime arrivingAt: arrivingTime maxWeight: aMaxWeight carrying: aCollectionOfCargoVehicles! !

!CargoVehicle class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 15:03:05'!
ofType: aType to: aTargetCity leavingAt: aLeavingTime maxWeight: aMaxWeight routingWith: aRouteTimeCalculator  
	
	^self 
		ofType: aType 
		to: aTargetCity 
		leavingAt: aLeavingTime 
		maxWeight: aMaxWeight 
		routingWith: aRouteTimeCalculator  
		carrying: {}
! !

!CargoVehicle class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 15:02:24'!
ofType: aType to: aTargetCity leavingAt: aLeavingTime maxWeight: aMaxWeight routingWith: aRouteTimeCalculator carrying: aCollectionOfCargoVehicles

	^self 
		ofType: aType 
		from: 'CABA' 
		to: aTargetCity 
		leavingAt: aLeavingTime 
		maxWeight: aMaxWeight 
		routingWith: aRouteTimeCalculator 
		carrying: aCollectionOfCargoVehicles! !


!CargoVehicle class methodsFor: 'error description' stamp: 'HAW 8/13/2020 14:21:11'!
canNotTranportVehicleErrorDescription
	
	^'Can not transport vehicle'! !

!CargoVehicle class methodsFor: 'error description' stamp: 'HAW 8/13/2020 15:11:35'!
carriedLeavingTimeMustBeAfterConveyorArrivingTime
	
	^'Carried leaving time must be after conveyor arriving time'! !

!CargoVehicle class methodsFor: 'error description' stamp: 'HAW 8/13/2020 15:06:19'!
carriedSourceCityMustBeConveryorTargetCityErrorDescription
	
	^'Carried Source City Must Be Converyor Target City'! !

!CargoVehicle class methodsFor: 'error description' stamp: 'HAW 8/13/2020 14:53:47'!
invalidVehicleTypeErrorDescription
	
	^'Invalid vehicle type'! !


!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 15:01:02'!
assert: aType canCarry: aCarriedVehicleType 
	
	| validCarryTypes |
	
	validCarryTypes := self validTypeCombination 
		at: aType 
		ifAbsent: [self error: 'Should not happen because vehicle type was verified on creation'].
		
	(validCarryTypes includes: aCarriedVehicleType) ifFalse: [self error: self canNotTranportVehicleErrorDescription ].

	! !

!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 18:16:23'!
assert: aCarriedVehicle  leavesAfter: aConveyourArrivingTime

	(aCarriedVehicle leavesAfter: aConveyourArrivingTime)
		ifFalse: [ self error: self carriedLeavingTimeMustBeAfterConveyorArrivingTime ]! !

!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 15:08:05'!
assertConveyorTargetCity: aConveyorTargetCity is: aCarriedSourceCity

	aConveyorTargetCity = aCarriedSourceCity ifFalse: [ self error: self carriedSourceCityMustBeConveryorTargetCityErrorDescription ]! !

!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 15:02:05'!
assertIsValidType: aType

	^ (self validTypeCombination includesKey: aType) ifFalse: [self error: self invalidVehicleTypeErrorDescription ]! !

!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 18:13:30'!
assertType: aType canCarry: aCollectionOfCargoVehicles after: arrivingTime from: aTargetCity

	^ aCollectionOfCargoVehicles do: [ :aCarriedVehicle |
		self assert: aType canCarry: aCarriedVehicle type.
		self assertConveyorTargetCity: aTargetCity is: aCarriedVehicle sourceCity.
		self assert: aCarriedVehicle leavesAfter: arrivingTime 	]! !

!CargoVehicle class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 15:36:03'!
validTypeCombination
	
 	^Dictionary new
		at: self truckType put: { self motorcycleType. self droneType };
		at: self motorcycleType put: {self droneType };
		at: self droneType put: {};
		yourself
	! !


!CargoVehicle class methodsFor: 'types' stamp: 'HAW 8/13/2020 15:34:50'!
droneType

	^#Drone! !

!CargoVehicle class methodsFor: 'types' stamp: 'HAW 8/13/2020 15:35:20'!
motorcycleType

	^ #Motorcycle! !

!CargoVehicle class methodsFor: 'types' stamp: 'HAW 8/13/2020 15:35:49'!
truckType
	
	^#Truck! !


!classDefinition: #CargoVehicleSelectionCriteria category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #CargoVehicleSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CargoVehicleSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 12:22:18'!
applyTo: aCargoVehicles

	self subclassResponsibility! !


!classDefinition: #ArrivingLastSelectionCriteria category: #'ISW1-2020-1C-Recuperatorio'!
CargoVehicleSelectionCriteria subclass: #ArrivingLastSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ArrivingLastSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 11:58:43'!
applyTo: aCargoVehicles

	^aCargoVehicles detectMax: [ :aCargoVehicle | aCargoVehicle arrivingTime ]! !


!classDefinition: #LigtherCargoVehicleSelectionCriteria category: #'ISW1-2020-1C-Recuperatorio'!
CargoVehicleSelectionCriteria subclass: #LigtherCargoVehicleSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!LigtherCargoVehicleSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 12:03:34'!
applyTo: aCargoVehicles

	^aCargoVehicles detectMin: [ :aCargoVehicle | aCargoVehicle totalWeight ]! !


!classDefinition: #Cashier category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!Cashier methodsFor: 'accept buy order' stamp: 'F 5/14/2020 11:01:58'!
acceptProductsFrom: aRobot

	| aTrailer |

	aTrailer := aRobot trailer.	
	self assertTrailerNotEmpty: aTrailer.
		
	"Comentario: en este punto el cashier realizaría el checkout de los productos."

	^ true! !


!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/4/2020 11:19:10'!
receiveOrderFromMechanicalFailure: aRobot
	
	aRobot outOfOrder.
	^ self acceptProductsFrom: aRobot.! !

!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/4/2020 11:19:01'!
receiveOrderFromNormal: aRobot
	
	^ self acceptProductsFrom: aRobot! !

!Cashier methodsFor: 'receiving buy order' stamp: 'FRT 5/3/2020 23:01:39'!
receiveOrderFromSensorsFailure: aRobot
	
	aRobot outOfOrder.
	self signalRobotSensorsFailure! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'ISW1-2020-1C-Recuperatorio'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Cleaner category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #Cleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!Cleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:40:15'!
affectProductAPollutionIndex: aPollutionIndex

	self subclassResponsibility ! !

!Cleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:40:17'!
affectProductBPollutionIndex: aPollutionIndex

	self subclassResponsibility ! !


!classDefinition: #BleachCleaner category: #'ISW1-2020-1C-Recuperatorio'!
Cleaner subclass: #BleachCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!BleachCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:32:09'!
affectProductAPollutionIndex: aPollutionIndex

	^aPollutionIndex ! !

!BleachCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:31:10'!
affectProductBPollutionIndex: aPollutionIndex

	^aPollutionIndex - 3! !


!classDefinition: #UVRaysCleaner category: #'ISW1-2020-1C-Recuperatorio'!
Cleaner subclass: #UVRaysCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:24'!
affectPollutionIndex: aPollutionIndex

	^ aPollutionIndex / 5! !

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:24'!
affectProductAPollutionIndex: aPollutionIndex

	^self affectPollutionIndex: aPollutionIndex! !

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:31'!
affectProductBPollutionIndex: aPollutionIndex

	^self affectPollutionIndex: aPollutionIndex ! !


!classDefinition: #DistibutionCenter category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #DistibutionCenter
	instanceVariableNames: 'cargoVehicles'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!DistibutionCenter methodsFor: 'initialization' stamp: 'HAW 7/28/2020 11:09:16'!
initializeWithAvailableCargoVehicles: aCollectionOfCargoVehicles 
	
	cargoVehicles := aCollectionOfCargoVehicles.! !


!DistibutionCenter methodsFor: 'shipping' stamp: 'HAW 8/13/2020 15:46:47'!
ship: aRobot to: aTargetCity at: aMaxDeliveryTime selectingWith: aSelectionCriteria  

	| shippingCargoVehicle shippingCargoVehicles allCargoVehicles |
	
	allCargoVehicles := cargoVehicles 
		inject: OrderedCollection new
		into: [ :vehicles :aCargoVehicle | aCargoVehicle addVehiclesTo: vehicles ].
	shippingCargoVehicles := allCargoVehicles select: [ :aCargoVehicle | 
		aCargoVehicle canShip: aRobot to: aTargetCity at: aMaxDeliveryTime ].
	
	shippingCargoVehicles ifEmpty: [ self error: self noCargoVehicleAvailableErrorDescription ].
	
	shippingCargoVehicle := aSelectionCriteria applyTo: shippingCargoVehicles.
	aRobot shipWith: shippingCargoVehicle.
	
	^shippingCargoVehicle! !


!DistibutionCenter methodsFor: 'exceptions' stamp: 'HAW 7/28/2020 11:11:15'!
noCargoVehicleAvailableErrorDescription
	
	^'There is no cargo vehicle availble to ship the robot trailer'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistibutionCenter class' category: #'ISW1-2020-1C-Recuperatorio'!
DistibutionCenter class
	instanceVariableNames: ''!

!DistibutionCenter class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 11:08:57'!
withAvailableCargoVehicles: aCollectionOfCargoVehicles 
	
	^self new initializeWithAvailableCargoVehicles: aCollectionOfCargoVehicles ! !


!classDefinition: #Product category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #Product
	instanceVariableNames: 'weight height pollutionIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !


!Product methodsFor: 'initialization' stamp: 'HAW 7/28/2020 10:19:29'!
initializeWith: aWeight and: aHeight pollutionIndex: aPollutionIndex 
	
	weight := aWeight.
	height := aHeight.
	pollutionIndex := aPollutionIndex.! !


!Product methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:51:21'!
cleanWith: aCleaner

	self subclassResponsibility ! !

!Product methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:20:35'!
pollutionIndex
	
	^pollutionIndex! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'ISW1-2020-1C-Recuperatorio'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 10:22:18'!
defaultPollutionIndex

	^0! !

!Product class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 10:22:12'!
with: aWeight and: aHeight
	
	^self with: aWeight and: aHeight pollutionIndex: self defaultPollutionIndex! !

!Product class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 10:21:52'!
with: aWeight and: aHeight pollutionIndex: aPollutionIndex 
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^self new initializeWith: aWeight and: aHeight  pollutionIndex: aPollutionIndex ! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'ISW1-2020-1C-Recuperatorio'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!ProductA methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:31:55'!
cleanWith: aCleaner 

	pollutionIndex := aCleaner affectProductAPollutionIndex: pollutionIndex ! !


!classDefinition: #ProductB category: #'ISW1-2020-1C-Recuperatorio'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!ProductB methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:30:53'!
cleanWith: aCleaner 
	
	pollutionIndex := aCleaner affectProductBPollutionIndex: pollutionIndex.! !


!classDefinition: #ProductCarrier category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #ProductCarrier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!ProductCarrier methodsFor: 'action' stamp: 'LL 7/25/2020 18:48:44'!
carry: aProduct
	
	^ aProduct carryBy: self! !


!ProductCarrier methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:25:20'!
isEmpty
	
	self subclassResponsibility ! !


!ProductCarrier methodsFor: 'weight' stamp: 'HAW 7/28/2020 12:25:34'!
totalProductsWeight

	self subclassResponsibility ! !


!ProductCarrier methodsFor: 'capacity' stamp: 'HAW 8/13/2020 17:35:04'!
weightCapacity
	
	self subclassResponsibility ! !


!ProductCarrier methodsFor: 'enumerationg trailers' stamp: 'HAW 8/13/2020 17:35:15'!
addTrailersTo: aTrailerCollector

	self subclassResponsibility ! !


!ProductCarrier methodsFor: 'shipping' stamp: 'HAW 8/13/2020 17:35:41'!
shipWith: aCargoVehicle 

	self subclassResponsibility ! !


!classDefinition: #MountableTrailer category: #'ISW1-2020-1C-Recuperatorio'!
ProductCarrier subclass: #MountableTrailer
	instanceVariableNames: 'trailers selectionStrategy failedCarries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!MountableTrailer methodsFor: 'initialization' stamp: 'HAW 8/13/2020 16:33:17'!
initializeSelectingWith: aSelectionStrategy of: aCollectionOfTrailers 
	
	selectionStrategy := aSelectionStrategy.
	trailers := aCollectionOfTrailers.
	failedCarries := Bag new.! !


!MountableTrailer methodsFor: 'enumerating trailers' stamp: 'HAW 8/13/2020 16:41:10'!
addTrailersTo: aTrailerCollector

	aTrailerCollector add: self.
	trailers do: [ :aTrailer | aTrailer addTrailersTo: aTrailerCollector ].
	
	^aTrailerCollector ! !


!MountableTrailer methodsFor: 'action' stamp: 'HAW 8/13/2020 16:32:58'!
carry: aProduct
	
	| sortedTrailers |
	
	sortedTrailers := trailers sorted: selectionStrategy.
	
	sortedTrailers do: [ :aTrailer |
		[ ^aTrailer carry: aProduct ]
			on: Error
			do: [:anError | failedCarries add: aTrailer ] ].
		
	self error: self notTrailerAvailableErrorDescription ! !


!MountableTrailer methodsFor: 'testing' stamp: 'HAW 8/13/2020 16:19:17'!
includes: aProduct
	
	^trailers anySatisfy: [ :aTrailer | aTrailer includes: aProduct ]! !

!MountableTrailer methodsFor: 'testing' stamp: 'HAW 8/13/2020 16:44:46'!
isEmpty
	
	^trailers allSatisfy: [ :aTrailer | aTrailer isEmpty ]! !


!MountableTrailer methodsFor: 'weight' stamp: 'HAW 8/13/2020 16:29:41'!
totalProductsWeight
	
	^trailers sum: [:aTrailer | aTrailer totalProductsWeight ]! !


!MountableTrailer methodsFor: 'shipping' stamp: 'HAW 8/13/2020 16:46:38'!
shipWith: aCargoVehicle 
	
	trailers do: [ :aTrailer | aTrailer shipWith: aCargoVehicle ]! !


!MountableTrailer methodsFor: 'failed carries' stamp: 'HAW 8/13/2020 16:34:08'!
failedCarriesFor: aTrailer 
	
	^failedCarries occurrencesOf: aTrailer ! !


!MountableTrailer methodsFor: 'error description' stamp: 'HAW 8/13/2020 16:08:19'!
notTrailerAvailableErrorDescription
	
	^'There is no availabe trailer'! !


!MountableTrailer methodsFor: 'capacity' stamp: 'HAW 8/13/2020 16:18:06'!
weightCapacity
	
	^trailers sum: [ :aTrailer | aTrailer weightCapacity ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MountableTrailer class' category: #'ISW1-2020-1C-Recuperatorio'!
MountableTrailer class
	instanceVariableNames: ''!

!MountableTrailer class methodsFor: 'error description' stamp: 'HAW 8/13/2020 16:35:56'!
canNotShareTrailersErrorDescripition
	
	^'Can not share trailers'! !

!MountableTrailer class methodsFor: 'error description' stamp: 'HAW 8/13/2020 15:58:38'!
mustHaveTrailersErrorDescription
	
	^'Must have trailers'! !


!MountableTrailer class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 16:24:09'!
selectingBiggerCapacityOf: aCollectionOfTrailers 
	
	^self 
		selectingWith:  [ :leftTrailer :rightTrailer | leftTrailer weightCapacity > rightTrailer weightCapacity ] 
		of: aCollectionOfTrailers ! !

!MountableTrailer class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 16:25:13'!
selectingLighterOf: aCollectionOfTrailers 
	
	^self 
		selectingWith: [ :leftTrailer :rightTrailer | leftTrailer totalProductsWeight < rightTrailer totalProductsWeight ] 
		of: aCollectionOfTrailers ! !

!MountableTrailer class methodsFor: 'instance creation' stamp: 'HAW 8/13/2020 18:20:05'!
selectingWith: aSelectionStrategy of: aCollectionOfTrailers 
	
	self assertIsNotEmpty: aCollectionOfTrailers.
	self assertTrailersAreNotShared: aCollectionOfTrailers.
		
	^self new initializeSelectingWith: aSelectionStrategy of: aCollectionOfTrailers ! !


!MountableTrailer class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 18:19:14'!
assertIsNotEmpty: aCollectionOfTrailers

	^ aCollectionOfTrailers ifEmpty: [ self error: self mustHaveTrailersErrorDescription ]! !

!MountableTrailer class methodsFor: 'assertions' stamp: 'HAW 8/13/2020 18:19:57'!
assertTrailersAreNotShared: aCollectionOfTrailers

	| allTrailers |
	
	allTrailers := aCollectionOfTrailers 
		inject: Bag new
		into: [ :trailers :aTrailer |
			aTrailer addTrailersTo: trailers ].
	
	(allTrailers allSatisfy: [:aTrailer | (allTrailers occurrencesOf: aTrailer) = 1 ]) 
		ifFalse: [ self error: self canNotShareTrailersErrorDescripition ]! !


!classDefinition: #SingleTrailer category: #'ISW1-2020-1C-Recuperatorio'!
ProductCarrier subclass: #SingleTrailer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!SingleTrailer methodsFor: 'enumeration trailers' stamp: 'HAW 8/13/2020 16:48:11'!
addTrailersTo: aTrailerCollector

	aTrailerCollector add: self.
	^aTrailerCollector ! !


!SingleTrailer methodsFor: 'shipping' stamp: 'HAW 8/13/2020 16:48:16'!
shipWith: aCargoVehicle 
	
	^aCargoVehicle add: self! !


!classDefinition: #CleaningTrailer category: #'ISW1-2020-1C-Recuperatorio'!
SingleTrailer subclass: #CleaningTrailer
	instanceVariableNames: 'trailer cleaners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!CleaningTrailer methodsFor: 'initialization' stamp: 'HAW 7/28/2020 10:18:26'!
initializeFor: aTrailer cleaningWith: aCollectionOfCleaners 
	
	trailer := aTrailer.
	cleaners := aCollectionOfCleaners.! !


!CleaningTrailer methodsFor: 'action' stamp: 'HAW 7/28/2020 10:29:10'!
carry: aProduct
	
	cleaners do: [:aCleaner | aProduct cleanWith: aCleaner ].
	
	trailer carry: aProduct. ! !


!CleaningTrailer methodsFor: 'testing' stamp: 'HAW 7/28/2020 11:09:49'!
isEmpty
	
	^trailer isEmpty ! !


!CleaningTrailer methodsFor: 'weight' stamp: 'HAW 7/28/2020 11:32:04'!
totalProductsWeight
	
	^trailer totalProductsWeight ! !


!CleaningTrailer methodsFor: 'capacity' stamp: 'HAW 8/13/2020 16:48:55'!
weightCapacity
	
	^trailer weightCapacity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CleaningTrailer class' category: #'ISW1-2020-1C-Recuperatorio'!
CleaningTrailer class
	instanceVariableNames: ''!

!CleaningTrailer class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 10:18:13'!
for: aTrailer cleaningWith: aCollectionOfCleaners 
	
	^self new initializeFor: aTrailer cleaningWith: aCollectionOfCleaners ! !


!classDefinition: #Trailer category: #'ISW1-2020-1C-Recuperatorio'!
SingleTrailer subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accesing totals' stamp: 'LL 7/26/2020 21:46:40'!
includes: aProduct

	^ container includes: aProduct! !

!Trailer methodsFor: 'accesing totals' stamp: 'HAW 6/7/2020 13:34:29'!
total: aContainer using: aBlock
	
	^ aContainer sum: [ :aProduct |  (aBlock value: aProduct) ] ifEmpty: [ 0 ]! !

!Trailer methodsFor: 'accesing totals' stamp: 'FRT 5/4/2020 10:28:36'!
totalHeight: aContainer

	^ self total: aContainer using: [ :aProduct | aProduct height ]! !

!Trailer methodsFor: 'accesing totals' stamp: 'FRT 5/4/2020 10:28:15'!
totalWeight: aContainer

	^ self total: aContainer using: [ :aProduct | aProduct weight ]! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/5/2020 11:14:31'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"
	
	^ self totalHeight: (container select: [ :aProduct | aProduct isStackable])! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/5/2020 11:14:17'!
totalProductsWeight
	
	^ self totalWeight: container.! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 10:17:59'!
add: aProduct asserting: aBlock

	aBlock value.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'NR 7/26/2020 02:11:27'!
carry: aProduct
	
	^ aProduct carryBy: self! !

!Trailer methodsFor: 'action' stamp: 'LL 7/19/2020 19:34:10'!
carryProductA: aProduct
	
	self add: aProduct 
		 asserting: [ 
			self assertWeightAdding: aProduct.
	 	 ]! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 10:50:33'!
carryProductB: aProduct

	self add: aProduct 
		 asserting: [ 
			self assertWeightAdding: aProduct.
			self assertHeightAdding: aProduct.
	 	 ]
! !


!Trailer methodsFor: 'assertions' stamp: 'F 5/5/2020 11:14:31'!
assertHeightAdding: aProduct
	
	(self totalProductsHeight + aProduct height) > heightCapacity ifTrue: [ self signalMaxHeightCapacityExceeded ]! !

!Trailer methodsFor: 'assertions' stamp: 'F 5/5/2020 11:14:17'!
assertWeightAdding: aProduct
	
	(self totalProductsWeight + aProduct weight) > weightCapacity ifTrue: [ self signalMaxWeightCapacityExceeded ]! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !


!Trailer methodsFor: 'capacity' stamp: 'HAW 8/13/2020 16:06:37'!
weightCapacity
	
	^weightCapacity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'ISW1-2020-1C-Recuperatorio'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !


!classDefinition: #Robot category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!Robot methodsFor: 'actions' stamp: 'HAW 6/7/2020 15:33:01'!
closeOrderUsing: aCashier

	^ status closeOrderUsing: aCashier! !

!Robot methodsFor: 'actions' stamp: 'FRT 5/3/2020 22:40:35'!
take: aProduct

	status take: aProduct! !


!Robot methodsFor: 'status' stamp: 'LL 7/25/2020 18:44:35'!
detachTrailer

	trailer := nil.! !

!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:42:57'!
outOfOrder

	status := OutOfOrder for: self
! !

!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:50:41'!
withMechanicalFailure

	status := MechanicalFailure for: self
! !

!Robot methodsFor: 'status' stamp: 'FRT 5/3/2020 22:50:45'!
withSensorsFailure

	status := SensorsFailure for: self
! !


!Robot methodsFor: 'accessing' stamp: 'LL 7/25/2020 18:47:15'!
hasTrailerAttached

	^ trailer isNil not
! !

!Robot methodsFor: 'accessing' stamp: 'LL 7/24/2020 17:29:29'!
trailer

	self hasTrailerAttached ifFalse: [self error: self class noTrailerAttachedErrorDescription].
	
	^trailer
! !


!Robot methodsFor: 'initialization' stamp: 'LL 7/24/2020 17:31:27'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := WorkingNormal for: self.
! !


!Robot methodsFor: 'status related' stamp: 'LL 7/24/2020 16:56:47'!
carry: aProduct
	
	self trailer carry: aProduct! !


!Robot methodsFor: 'as yet unclassified' stamp: 'HAW 8/13/2020 16:46:10'!
shipWith: aCargoVehicle 
	
	self trailer shipWith: aCargoVehicle. 
	self detachTrailer ! !

!Robot methodsFor: 'as yet unclassified' stamp: 'HAW 7/28/2020 11:31:50'!
trailerTotalProductsWeight
	
	^self trailer totalProductsWeight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'ISW1-2020-1C-Recuperatorio'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'F 5/5/2020 11:17:36'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'LL 7/24/2020 17:30:04'!
noTrailerAttachedErrorDescription
	^'No trailer attached!!'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'F 5/5/2020 11:18:28'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: #'ISW1-2020-1C-Recuperatorio'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!RobotStatus methodsFor: 'initialization' stamp: 'FRT 5/3/2020 21:32:00'!
initializeWith: aRobot

	robot := aRobot! !


!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 6/12/2020 10:35:01'!
closeOrderUsing: aCashier

	self subclassResponsibility! !

!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:38:22'!
take: aProduct

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotStatus class' category: #'ISW1-2020-1C-Recuperatorio'!
RobotStatus class
	instanceVariableNames: ''!

!RobotStatus class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 21:30:55'!
for: aRobot
	
	^ self new initializeWith: aRobot! !


!classDefinition: #MechanicalFailure category: #'ISW1-2020-1C-Recuperatorio'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:46:51'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromMechanicalFailure: robot
	! !

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:44:39'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #OutOfOrder category: #'ISW1-2020-1C-Recuperatorio'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'F 5/5/2020 11:20:34'!
closeOrderUsing: aCashier
	
	Robot signalOutOfOrder! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'HAW 6/7/2020 15:32:51'!
take: aProduct
	
	Robot signalOutOfOrder! !


!classDefinition: #SensorsFailure category: #'ISW1-2020-1C-Recuperatorio'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:54'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromSensorsFailure: robot! !

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:43:35'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #WorkingNormal category: #'ISW1-2020-1C-Recuperatorio'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-Recuperatorio'!

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:19'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromNormal: robot! !

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:41:15'!
take: aProduct
	
	robot carry: aProduct! !
