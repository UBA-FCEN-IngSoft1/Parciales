!classDefinition: #CashierTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!classDefinition: #CleaningTrailerTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #CleaningTrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!classDefinition: #ProductTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!classDefinition: #RobotTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!classDefinition: #ShippingTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #ShippingTest
	instanceVariableNames: 'routingTimeCalculator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!ShippingTest methodsFor: 'setUp/tearDown' stamp: 'HAW 7/28/2020 11:42:14'!
setUp

	routingTimeCalculator := [ :fromCity :toCity :cargoVehicleType | 1*second ].! !


!ShippingTest methodsFor: 'routing time calculator' stamp: 'HAW 7/28/2020 11:41:25'!
from: aFromCity to: aTargetCity forCargoVehicleType: aType

	^routingTimeCalculator value: aFromCity value: aTargetCity value: aType! !


!classDefinition: #TrailerTest category: #'ISW1-2020-1C-2doParcial'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!classDefinition: #CargoVehicle category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #CargoVehicle
	instanceVariableNames: 'targetCity leavingTime maxWeight trailers arrivingTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!CargoVehicle methodsFor: 'initialization' stamp: 'HAW 7/28/2020 11:45:07'!
initializeTo: aTargetCity leavingAt: aLeavingTime arrivingAt: anArrivingTime maxWeight: aMaxWeight 
	
	targetCity := aTargetCity.
	leavingTime := aLeavingTime.
	arrivingTime := anArrivingTime.
	maxWeight := aMaxWeight.
	trailers := OrderedCollection new.! !


!CargoVehicle methodsFor: 'arring time' stamp: 'HAW 7/28/2020 11:58:51'!
arrivingTime
	
	^arrivingTime! !


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

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:23:33'!
shipsTo: aTargetCity

	^ targetCity = aTargetCity! !

!CargoVehicle methodsFor: 'testing' stamp: 'HAW 7/28/2020 11:22:52'!
willShip: aTrailer 
	
	^trailers includes: aTrailer ! !


!CargoVehicle methodsFor: 'weight' stamp: 'HAW 7/28/2020 12:03:22'!
totalWeight

	^ trailers sum: [ :aTrailer | aTrailer totalProductsWeight ] ifEmpty: [ 0 ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CargoVehicle class' category: #'ISW1-2020-1C-2doParcial'!
CargoVehicle class
	instanceVariableNames: ''!

!CargoVehicle class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 11:44:42'!
ofType: aType to: aTargetCity leavingAt: aLeavingTime maxWeight: aMaxWeight routingWith: aRouteTimeCalculator  
	
	| arrivingTime |
	
	arrivingTime := aLeavingTime next: (aRouteTimeCalculator from: 'CABA' to: aTargetCity forCargoVehicleType: aType).
	
	^self new initializeTo: aTargetCity leavingAt: aLeavingTime arrivingAt: arrivingTime maxWeight: aMaxWeight ! !


!classDefinition: #CargoVehicleSelectionCriteria category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #CargoVehicleSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!CargoVehicleSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 12:22:18'!
applyTo: aCargoVehicles

	self subclassResponsibility! !


!classDefinition: #ArrivingLastSelectionCriteria category: #'ISW1-2020-1C-2doParcial'!
CargoVehicleSelectionCriteria subclass: #ArrivingLastSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!ArrivingLastSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 11:58:43'!
applyTo: aCargoVehicles

	^aCargoVehicles detectMax: [ :aCargoVehicle | aCargoVehicle arrivingTime ]! !


!classDefinition: #LigtherCargoVehicleSelectionCriteria category: #'ISW1-2020-1C-2doParcial'!
CargoVehicleSelectionCriteria subclass: #LigtherCargoVehicleSelectionCriteria
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!LigtherCargoVehicleSelectionCriteria methodsFor: 'applying' stamp: 'HAW 7/28/2020 12:03:34'!
applyTo: aCargoVehicles

	^aCargoVehicles detectMin: [ :aCargoVehicle | aCargoVehicle totalWeight ]! !


!classDefinition: #Cashier category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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

!classDefinition: 'Cashier class' category: #'ISW1-2020-1C-2doParcial'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Cleaner category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #Cleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!Cleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:40:15'!
affectProductAPollutionIndex: aPollutionIndex

	self subclassResponsibility ! !

!Cleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:40:17'!
affectProductBPollutionIndex: aPollutionIndex

	self subclassResponsibility ! !


!classDefinition: #BleachCleaner category: #'ISW1-2020-1C-2doParcial'!
Cleaner subclass: #BleachCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!BleachCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:32:09'!
affectProductAPollutionIndex: aPollutionIndex

	^aPollutionIndex ! !

!BleachCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:31:10'!
affectProductBPollutionIndex: aPollutionIndex

	^aPollutionIndex - 3! !


!classDefinition: #UVRaysCleaner category: #'ISW1-2020-1C-2doParcial'!
Cleaner subclass: #UVRaysCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:24'!
affectPollutionIndex: aPollutionIndex

	^ aPollutionIndex / 5! !

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:24'!
affectProductAPollutionIndex: aPollutionIndex

	^self affectPollutionIndex: aPollutionIndex! !

!UVRaysCleaner methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:50:31'!
affectProductBPollutionIndex: aPollutionIndex

	^self affectPollutionIndex: aPollutionIndex ! !


!classDefinition: #DistibutionCenter category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #DistibutionCenter
	instanceVariableNames: 'cargoVehicles'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!DistibutionCenter methodsFor: 'initialization' stamp: 'HAW 7/28/2020 11:09:16'!
initializeWithAvailableCargoVehicles: aCollectionOfCargoVehicles 
	
	cargoVehicles := aCollectionOfCargoVehicles.! !


!DistibutionCenter methodsFor: 'shipping' stamp: 'HAW 7/28/2020 11:58:10'!
ship: aRobot to: aTargetCity at: aMaxDeliveryTime selectingWith: aSelectionCriteria  

	| shippingCargoVehicle shippingCargoVehicles |
	
	shippingCargoVehicles := cargoVehicles select: [ :aCargoVehicle | 
		aCargoVehicle canShip: aRobot to: aTargetCity at: aMaxDeliveryTime ].
	
	shippingCargoVehicles ifEmpty: [ self error: self noCargoVehicleAvailableErrorDescription ].
	
	shippingCargoVehicle := aSelectionCriteria applyTo: shippingCargoVehicles.
	aRobot shipWith: shippingCargoVehicle.
	
	^shippingCargoVehicle! !


!DistibutionCenter methodsFor: 'exceptions' stamp: 'HAW 7/28/2020 11:11:15'!
noCargoVehicleAvailableErrorDescription
	
	^'There is no cargo vehicle availble to ship the robot trailer'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DistibutionCenter class' category: #'ISW1-2020-1C-2doParcial'!
DistibutionCenter class
	instanceVariableNames: ''!

!DistibutionCenter class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 11:08:57'!
withAvailableCargoVehicles: aCollectionOfCargoVehicles 
	
	^self new initializeWithAvailableCargoVehicles: aCollectionOfCargoVehicles ! !


!classDefinition: #Product category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #Product
	instanceVariableNames: 'weight height pollutionIndex'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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

!classDefinition: 'Product class' category: #'ISW1-2020-1C-2doParcial'!
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


!classDefinition: #ProductA category: #'ISW1-2020-1C-2doParcial'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!ProductA methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:31:55'!
cleanWith: aCleaner 

	pollutionIndex := aCleaner affectProductAPollutionIndex: pollutionIndex ! !


!classDefinition: #ProductB category: #'ISW1-2020-1C-2doParcial'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!ProductB methodsFor: 'cleaning' stamp: 'HAW 7/28/2020 10:30:53'!
cleanWith: aCleaner 
	
	pollutionIndex := aCleaner affectProductBPollutionIndex: pollutionIndex.! !


!classDefinition: #ProductCarrier category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #ProductCarrier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!ProductCarrier methodsFor: 'action' stamp: 'LL 7/25/2020 18:48:44'!
carry: aProduct
	
	^ aProduct carryBy: self! !


!ProductCarrier methodsFor: 'testing' stamp: 'HAW 7/28/2020 12:25:20'!
isEmpty
	
	self subclassResponsibility ! !


!ProductCarrier methodsFor: 'weight' stamp: 'HAW 7/28/2020 12:25:34'!
totalProductsWeight

	self subclassResponsibility ! !


!classDefinition: #CleaningTrailer category: #'ISW1-2020-1C-2doParcial'!
ProductCarrier subclass: #CleaningTrailer
	instanceVariableNames: 'trailer cleaners'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CleaningTrailer class' category: #'ISW1-2020-1C-2doParcial'!
CleaningTrailer class
	instanceVariableNames: ''!

!CleaningTrailer class methodsFor: 'instance creation' stamp: 'HAW 7/28/2020 10:18:13'!
for: aTrailer cleaningWith: aCollectionOfCleaners 
	
	^self new initializeFor: aTrailer cleaningWith: aCollectionOfCleaners ! !


!classDefinition: #Trailer category: #'ISW1-2020-1C-2doParcial'!
ProductCarrier subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'ISW1-2020-1C-2doParcial'!
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


!classDefinition: #Robot category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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


!Robot methodsFor: 'as yet unclassified' stamp: 'HAW 7/28/2020 11:21:47'!
shipWith: aCargoVehicle 
	
	aCargoVehicle add: self trailer.
	self detachTrailer ! !

!Robot methodsFor: 'as yet unclassified' stamp: 'HAW 7/28/2020 11:31:50'!
trailerTotalProductsWeight
	
	^self trailer totalProductsWeight ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'ISW1-2020-1C-2doParcial'!
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


!classDefinition: #RobotStatus category: #'ISW1-2020-1C-2doParcial'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

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

!classDefinition: 'RobotStatus class' category: #'ISW1-2020-1C-2doParcial'!
RobotStatus class
	instanceVariableNames: ''!

!RobotStatus class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 21:30:55'!
for: aRobot
	
	^ self new initializeWith: aRobot! !


!classDefinition: #MechanicalFailure category: #'ISW1-2020-1C-2doParcial'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:46:51'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromMechanicalFailure: robot
	! !

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:44:39'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #OutOfOrder category: #'ISW1-2020-1C-2doParcial'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'F 5/5/2020 11:20:34'!
closeOrderUsing: aCashier
	
	Robot signalOutOfOrder! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'HAW 6/7/2020 15:32:51'!
take: aProduct
	
	Robot signalOutOfOrder! !


!classDefinition: #SensorsFailure category: #'ISW1-2020-1C-2doParcial'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:54'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromSensorsFailure: robot! !

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:43:35'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #WorkingNormal category: #'ISW1-2020-1C-2doParcial'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial'!

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:19'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromNormal: robot! !

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:41:15'!
take: aProduct
	
	robot carry: aProduct! !
