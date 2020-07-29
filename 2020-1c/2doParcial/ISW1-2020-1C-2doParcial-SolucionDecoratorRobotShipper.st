!classDefinition: #CashierTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

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



!classDefinition: #HealthAndHygieneProtocolsTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #HealthAndHygieneProtocolsTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!HealthAndHygieneProtocolsTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:45:20'!
test01ATrailerWithBleachCleanerReducesContaminationBy3WhenCarryingAProduct

	| aProduct aTrailerWithBleachCleaner |
	
	aProduct := ProductB with: 5 and: 10 contaminatedBy: 5.
	
	aTrailerWithBleachCleaner := self aTrailerWithBleachCleanerCarrying: aProduct.
		
	self assertContaminationOf: aProduct is: 2 andIncludedIn: aTrailerWithBleachCleaner 

	! !

!HealthAndHygieneProtocolsTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:45:26'!
test02ATrailerWithBleachCleanerHasNotEffectOnAProductA

	| aProductA aTrailerWithBleachCleaner |
	
	aProductA := ProductA with: 5 and: 10 contaminatedBy: 5.
	
	aTrailerWithBleachCleaner := self aTrailerWithBleachCleanerCarrying: aProductA.

	self assertContaminationOf: aProductA is: 5 andIncludedIn: aTrailerWithBleachCleaner ! !

!HealthAndHygieneProtocolsTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:21:18'!
test03ATrailerWithUVCleanerReducesContaminationBy80PercentOnProductA

	| aProduct aTrailerWithUVCleaner |
	
	aProduct := ProductA with: 5 and: 10 contaminatedBy: 5.
			
	aTrailerWithUVCleaner := self aTrailerWithUVCleanerCarrying: aProduct.
	
	self assertContaminationOf: aProduct is: 1 andIncludedIn: aTrailerWithUVCleaner 

	! !

!HealthAndHygieneProtocolsTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:44:52'!
test04ATrailerWithUVCleanerReducesContaminationBy80PercentOnProductB

	| aProduct aTrailerWithUVCleaner |
	
	aProduct := ProductB with: 5 and: 10 contaminatedBy: 5.
			
	aTrailerWithUVCleaner := self aTrailerWithUVCleanerCarrying: aProduct.
	
	self assertContaminationOf: aProduct is: 1 andIncludedIn: aTrailerWithUVCleaner 

	! !

!HealthAndHygieneProtocolsTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:45:40'!
test05AProductCanBeCleanedCombiningMultipleCleaners

	| aProduct aCombinedCleaningTrailer |
	
	aProduct := ProductB with: 5 and: 10 contaminatedBy: 8.
	
	aCombinedCleaningTrailer := self aTrailerWithMultipleCleanersCombinedCarrying: aProduct.
	
	self assertContaminationOf: aProduct is: 1 andIncludedIn: aCombinedCleaningTrailer ! !


!HealthAndHygieneProtocolsTest methodsFor: 'factories' stamp: 'NR 7/28/2020 22:05:01'!
aTrailerWithBleachCleanerCarrying: aProduct

	 | aTrailerWithBleachCleaner |
	
	aTrailerWithBleachCleaner := TrailerWithBleachCleaner using: (Trailer with: 100 and: 100).	
	aTrailerWithBleachCleaner carry: aProduct.
	
	^aTrailerWithBleachCleaner! !

!HealthAndHygieneProtocolsTest methodsFor: 'factories' stamp: 'NR 7/28/2020 22:14:54'!
aTrailerWithMultipleCleanersCombinedCarrying: aProduct

	| aCombinedCleaningTrailer |
	
	aCombinedCleaningTrailer := TrailerWithBleachCleaner using: (TrailerWithUVCleaner using: (Trailer with: 100 and: 100)).	
	aCombinedCleaningTrailer carry: aProduct.
	
	^aCombinedCleaningTrailer ! !

!HealthAndHygieneProtocolsTest methodsFor: 'factories' stamp: 'NR 7/28/2020 22:08:39'!
aTrailerWithUVCleanerCarrying: aProduct

	| aTrailerWithUVCleaner |
	
	aTrailerWithUVCleaner := TrailerWithUVCleaner using: (Trailer with: 100 and: 100).
	aTrailerWithUVCleaner carry: aProduct.
	
	^aTrailerWithUVCleaner.! !

!HealthAndHygieneProtocolsTest methodsFor: 'factories' stamp: 'NR 7/28/2020 22:17:51'!
assertContaminationOf: product is: aContaminationIndex andIncludedIn: trailer

	self assert: aContaminationIndex equals: product contamination.
	self assert: (trailer includes: product)! !



!classDefinition: #ProductTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

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


!classDefinition: #RobotTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

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

!RobotTest methodsFor: 'taking products' stamp: 'NR 7/29/2020 15:30:51'!
test10CanNotTakeProductIfTrailerWasDetached

	| aRobot aTrailer |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot detachTrailer.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot noTrailerAttachedErrorDescription 
	
	
 
! !

!RobotTest methodsFor: 'taking products' stamp: 'NR 7/29/2020 16:06:38'!
test12ShouldNotTakeProductsWhenFinishedOperations

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot finishOperation.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot finishedOperationsErrorDescription.
	
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

!RobotTest methodsFor: 'closing order' stamp: 'NR 7/29/2020 15:48:26'!
test11CanNotCloseOrderIfTrailerWasDetached

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot detachTrailer.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot noTrailerAttachedErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'NR 7/29/2020 16:08:27'!
test13CanNotCloseOrderWhenFinishedOperations

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot finishOperation.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot finishedOperationsErrorDescription.
 
! !


!classDefinition: #ShippingTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #ShippingTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/26/2020 04:33:42'!
test01ARobotCannotShipIfThereAreNoVehiclesOnTheWarehouse

	| warehouseVehicles aRobot robotTrailer |	
	warehouseVehicles := OrderedCollection new.
	
	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aRobot class noSuitableCargoVehiclesAvailableErrorDescription.
	self assert: aRobot trailer equals: robotTrailer.! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 15:18:17'!
test02ARobotCannotShipIfThereIsASingleVehicleAndItGoesToADifferentDestination

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToMarDelPlata.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.
	
	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aRobot class noSuitableCargoVehiclesAvailableErrorDescription.
	self assert: aRobot trailer equals: robotTrailer.
	self assert: aCargoVehicle hasNotLoad: robotTrailer andCargoWeights: 0! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 15:18:58'!
test03ARobotCannotShipIfThereIsASingleVehicleAndItWouldNotDeliverOnTime

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnNextDay.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aRobot class noSuitableCargoVehiclesAvailableErrorDescription.
	self assert: aRobot trailer equals: robotTrailer.
	self assert: aCargoVehicle hasNotLoad: robotTrailer andCargoWeights: 0
! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 15:19:05'!
test04ARobotCannotShipIfThereIsASingleVehicleWithNotEnoughWeightCapacity

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithWeightCapacity: 3.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.
	
	aRobot := self aRobotAfterClosingOrderWithAProductWeighting: 5.
	robotTrailer := aRobot trailer.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aRobot class noSuitableCargoVehiclesAvailableErrorDescription.
	self assert: aRobot trailer equals: robotTrailer.
	self assert: aCargoVehicle hasNotLoad: robotTrailer andCargoWeights: 0
! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 14:54:46'!
test05ARobotCannotShipIfThereIsASingleVehicleAndWeightIsExceeded

	| aCargoVehicle warehouseVehicles aRobot robotTrailer anotherRobot anotherRobotTrailer |
	
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithWeightCapacity: 6.
	
	warehouseVehicles := OrderedCollection with: aCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProductWeighting: 5.
	robotTrailer := aRobot trailer.
	anotherRobot := self aRobotAfterClosingOrderWithAProductWeighting: 5.
	anotherRobotTrailer := anotherRobot trailer.
	
	aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new.
			
	self assert: anotherRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: anotherRobot class noSuitableCargoVehiclesAvailableErrorDescription.
	
	self deny: aRobot hasTrailerAttached.
	self assert: anotherRobot trailer equals: anotherRobotTrailer.
	
	self assert: aCargoVehicle loadWeight: 5 containing: robotTrailer.
	self deny: (aCargoVehicle contains: anotherRobotTrailer).! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 14:31:28'!
test06ARobotCanShipIfThereIsASuitableVehicle

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.
	
	aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new.
	
	self deny: aRobot hasTrailerAttached.
	self assert: aCargoVehicle loadWeight: 5 containing: robotTrailer! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:10:44'!
test07ARobotShouldChooseVehicleThatArrivesLatestIfThatStrategyIsUsed

	| aCargoVehicle anotherCargoVehicle warehouseVehicles aRobot robotTrailer |
	
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	anotherCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt2pmWithEnoughCapacity.
	warehouseVehicles := OrderedCollection with: aCargoVehicle with: anotherCargoVehicle.
	
	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.
	
	aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LatestArrivalStrategy new.
	
	self deny: aRobot hasTrailerAttached.	
	self assert: aCargoVehicle hasNotLoad: robotTrailer andCargoWeights: 0.
	self assert: anotherCargoVehicle loadWeight: 5 containing: robotTrailer.! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:10:55'!
test08ARobotShouldChooseVehicleWithLessWeightIfThatStrategyIsUsed

	| aCargoVehicle anotherCargoVehicle warehouseVehicles aRobot robotTrailer anotherRobot anotherRobotTrailer |
	
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	anotherCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	warehouseVehicles := OrderedCollection with: aCargoVehicle with: anotherCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProductWeighting: 5.
	robotTrailer := aRobot trailer.
	anotherRobot := self aRobotAfterClosingOrderWithAProductWeighting: 5.
	anotherRobotTrailer := anotherRobot trailer.
	
	aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new.
	anotherRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new.
	
	self deny: aRobot hasTrailerAttached.
	self deny: anotherRobot hasTrailerAttached.
	self assert: aCargoVehicle loadWeight: 5 containing: robotTrailer.
	self assert: anotherCargoVehicle loadWeight: 5 containing: anotherRobotTrailer.
	! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:11:04'!
test09CannotCreateCargoVehicleWithUnreachableExternalServiceDestination

	| externalSystem |
	externalSystem := [:origin :destination :vehicleType | self error: CargoVehicle unreachableDestinationErrorDescription ].
	
	self should: [CargoVehicle withDestinationTo: 'Ushuaia' departureDateTime: (July/20/2020 at: 10:00) 
											weightCapacity: 20
											calculatingArrivalUsing: externalSystem type: #Motorcycle.] raiseWithDescription: CargoVehicle unreachableDestinationErrorDescription.
	
	
												
	! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:11:10'!
test10ACargoVehicleCanObtainArrivingDateTimeOfAVehicleUsingAnExternalService

	| externalSystem aCargoVehicle |
	externalSystem := [:origin :destination :vehicleType | 4 * hour].
	aCargoVehicle := CargoVehicle withDestinationTo: 'CABA' departureDateTime: (July/20/2020 at: 10:00) 
											weightCapacity: 20
											calculatingArrivalUsing: externalSystem type: #Drone.
											
	self assert: aCargoVehicle arrivingOn equals: (July/20/2020 at: 14:00)

	
	! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:11:45'!
test11ARobotCannotShipAgainIfItHasShippedAlready

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProduct.
	robotTrailer := aRobot trailer.

	aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aRobot class finishedOperationsErrorDescription.
	
	self deny: aRobot hasTrailerAttached.
	self assert: aCargoVehicle loadWeight: 5 containing: robotTrailer.
	
	
	! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:52:31'!
test12ARobotCannotShipIfIsOutOfOrder

	self assertCannotShipAfterChangingStatusTo: #outOfOrder withError: Robot outOfOrderErrorDescription.
! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:52:31'!
test13ARobotCannotShipIfHasMechanicalFailures

	self assertCannotShipAfterChangingStatusTo: #withMechanicalFailure withError: Robot cannotShipErrorDescription.! !

!ShippingTest methodsFor: 'tests' stamp: 'NR 7/29/2020 16:52:31'!
test14ARobotCannotShipIfHasSensorsFailure

	self assertCannotShipAfterChangingStatusTo: #withSensorsFailure withError: Robot cannotShipErrorDescription! !


!ShippingTest methodsFor: 'assertions' stamp: 'NR 7/28/2020 23:19:48'!
assert: aRobot cannotShipTo: aDestination dueTo: aDatetimeLimit using: warehouseVehicles

	^ self should: [aRobot shipTo: aDestination dueTo: aDatetimeLimit using: warehouseVehicles considering: LightestVehicleStrategy new] raiseWithDescription: aRobot class noSuitableCargoVehiclesAvailableErrorDescription! !

!ShippingTest methodsFor: 'assertions' stamp: 'NR 7/26/2020 04:32:29'!
assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: anErrorDescription

	^ self should: [aRobot shipTo: 'CABA' dueTo: (July/22/2020 at: 15:00) using: warehouseVehicles considering: LightestVehicleStrategy new] raiseWithDescription: anErrorDescription! !

!ShippingTest methodsFor: 'assertions' stamp: 'NR 7/29/2020 15:18:40'!
assert: aCargoVehicle hasNotLoad: aTrailer andCargoWeights: aWeight.

	self deny: (aCargoVehicle contains: aTrailer).
	self assert: aCargoVehicle loadWeight equals: aWeight
! !

!ShippingTest methodsFor: 'assertions' stamp: 'NR 7/29/2020 14:22:27'!
assert: aCargoVehicle loadWeight: aLoadWeight containing: aTrailer

	self assert: aCargoVehicle loadWeight equals: aLoadWeight.
	self assert: (aCargoVehicle contains: aTrailer).! !

!ShippingTest methodsFor: 'assertions' stamp: 'NR 7/29/2020 16:52:31'!
assertCannotShipAfterChangingStatusTo: aChangeStatusMessage withError: aMessageError

	| aCargoVehicle warehouseVehicles aRobot robotTrailer |
	aCargoVehicle := self aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity.
	warehouseVehicles := OrderedCollection with: aCargoVehicle.

	aRobot := self aRobotAfterClosingOrderWithAProduct.
	aRobot perform: aChangeStatusMessage.
	robotTrailer := aRobot trailer.
	
	self assert: aRobot cannotShipToCABAOnDateAt3pmUsing: warehouseVehicles because: aMessageError.
	self assert: aRobot trailer equals: robotTrailer.
	self assert: aCargoVehicle hasNotLoad: robotTrailer andCargoWeights: 0! !

!ShippingTest methodsFor: 'assertions' stamp: 'LL 7/21/2020 23:54:06'!
should: aBlock raiseWithDescription: anErrorDescription

	self should: aBlock
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anException |
			self assert: anException messageText equals: anErrorDescription
		]! !


!ShippingTest methodsFor: 'factories' stamp: 'NR 7/29/2020 15:09:11'!
aCargoVehicleToCABAArrivingOnADateAt1pmWithEnoughCapacity

	^self aCargoVehicleToCABAArrivingOnADateAt1pmWithWeightCapacity: 100.
	! !

!ShippingTest methodsFor: 'factories' stamp: 'NR 7/28/2020 23:18:37'!
aCargoVehicleToCABAArrivingOnADateAt1pmWithWeightCapacity: aWeightCapacity

	^CargoVehicle withDestinationTo: 'CABA' departureDateTime: (July/22/2020 at: 10:00) 
											weightCapacity: aWeightCapacity
											calculatingArrivalUsing: [:origin :destination :vehicleType |3 * hour] type: #Drone.! !

!ShippingTest methodsFor: 'factories' stamp: 'NR 7/28/2020 23:05:48'!
aCargoVehicleToCABAArrivingOnADateAt2pmWithEnoughCapacity

	^CargoVehicle withDestinationTo: 'CABA' departureDateTime: (July/22/2020 at: 12:00) 
											weightCapacity: 100
											calculatingArrivalUsing: [:origin :destination :vehicleType |2 * hour] type: #Drone.! !

!ShippingTest methodsFor: 'factories' stamp: 'NR 7/28/2020 23:10:05'!
aCargoVehicleToCABAArrivingOnNextDay

	^CargoVehicle withDestinationTo: 'CABA' departureDateTime: (July/23/2020 at: 18:00) 
											weightCapacity: 100
											calculatingArrivalUsing: [:origin :destination :vehicleType |3 * hour] type: #Drone.! !

!ShippingTest methodsFor: 'factories' stamp: 'NR 7/28/2020 23:05:53'!
aCargoVehicleToMarDelPlata

	^CargoVehicle withDestinationTo: 'Mar Del Plata' departureDateTime: (July/22/2020 at: 10:00) 
											weightCapacity: 100
											calculatingArrivalUsing: [:origin :destination :vehicleType |3 * hour] type: #Drone.! !

!ShippingTest methodsFor: 'factories' stamp: 'LL 7/25/2020 20:45:39'!
aRobotAfterClosingOrderWithAProduct
	
	^self aRobotAfterClosingOrderWithAProductWeighting: 5.! !

!ShippingTest methodsFor: 'factories' stamp: 'NR 7/28/2020 23:13:32'!
aRobotAfterClosingOrderWithAProductWeighting: aWeight

	| aRobot aCombinedCleaningTrailer |
	
	aCombinedCleaningTrailer := TrailerWithBleachCleaner using: (TrailerWithUVCleaner using: (Trailer with: 100 and: 100)).
	aRobot := Robot with: aCombinedCleaningTrailer. 
	aRobot take: (ProductA with: aWeight and: 100).
	aRobot closeOrderUsing: Cashier new.
	^aRobot! !


!classDefinition: #TrailerTest category: #'ISW1-2020-1C-2doParcial-Solucion'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

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


!classDefinition: #CargoVehicle category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #CargoVehicle
	instanceVariableNames: 'destination arrivingOn trailers weightCapacity vehicleType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!CargoVehicle methodsFor: 'initialization' stamp: 'NR 7/29/2020 00:00:38'!
initializeWithDestinationTo: aDestination weightCapacity: aWeightCapacity withArrival: anArrivalDatetime type: aVehicleType
	
	destination := aDestination.
	arrivingOn := anArrivalDatetime.
	trailers := OrderedCollection new.
	weightCapacity := aWeightCapacity.
! !


!CargoVehicle methodsFor: 'accessing' stamp: 'LL 7/23/2020 19:48:05'!
arrivingOn

	^ arrivingOn! !

!CargoVehicle methodsFor: 'accessing' stamp: 'LL 7/25/2020 19:21:51'!
loadWeight

	^ trailers sum: [:aTrailer | aTrailer totalProductsWeight] ifEmpty: [^0]! !


!CargoVehicle methodsFor: 'testing' stamp: 'NR 7/28/2020 23:16:36'!
canShip: aTrailer to: aDestination dueTo: aDateTimeLimit

	^ ((self destinationDifferentFrom: aDestination) not) and: 
		[(self arrivesAfter: aDateTimeLimit) not] and: 
		[(self wouldExceedWeightIfLoads: aTrailer) not].! !

!CargoVehicle methodsFor: 'testing' stamp: 'LL 7/25/2020 19:54:41'!
contains: aTrailer

	^trailers includes: aTrailer.! !


!CargoVehicle methodsFor: 'private' stamp: 'LL 7/24/2020 12:53:53'!
arrivesAfter: dueDateTime

	^ dueDateTime < self arrivingOn! !

!CargoVehicle methodsFor: 'private' stamp: 'LL 7/24/2020 13:08:14'!
destinationDifferentFrom: aDestination

	^ aDestination ~= destination! !

!CargoVehicle methodsFor: 'private' stamp: 'LL 7/24/2020 16:46:47'!
loadTrailer: aTrailer

	trailers add: aTrailer.! !

!CargoVehicle methodsFor: 'private' stamp: 'NR 7/26/2020 02:21:07'!
wouldExceedWeightIfLoads: aTrailer
	
	^weightCapacity < (self loadWeight + aTrailer totalProductsWeight).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CargoVehicle class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
CargoVehicle class
	instanceVariableNames: ''!

!CargoVehicle class methodsFor: 'error messages' stamp: 'NR 7/28/2020 23:52:19'!
unreachableDestinationErrorDescription
	
	^ 'The destination is unreacheable'! !


!CargoVehicle class methodsFor: 'instance creation' stamp: 'NR 7/29/2020 00:00:14'!
withDestinationTo: aDestination departureDateTime: aDepartureDatetime weightCapacity: aWeightCapacity calculatingArrivalUsing: anExternalService type: aVehicleType

	| arrivalDatetime |
	
	arrivalDatetime := aDepartureDatetime next: (anExternalService value: 'CABA' value: aDestination value: aVehicleType).

	^ self new initializeWithDestinationTo: aDestination weightCapacity: aWeightCapacity withArrival: arrivalDatetime type: aVehicleType.! !


!classDefinition: #Cashier category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

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

!classDefinition: 'Cashier class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #Product
	instanceVariableNames: 'weight height contaminationIndex edible'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!Product methodsFor: 'instance creation' stamp: 'LL 7/24/2020 11:23:12'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.
	contaminationIndex := 0.! !

!Product methodsFor: 'instance creation' stamp: 'LL 7/24/2020 11:23:03'!
initializeWith: aWeight and: aHeight contaminatedBy: aContaminationIndex
	
	self initializeWith: aWeight and: aHeight.
	contaminationIndex := aContaminationIndex.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !

!Product methodsFor: 'action' stamp: 'LL 7/24/2020 10:50:01'!
cleanedBy: amountCleaned
	
	contaminationIndex := self contamination - amountCleaned! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'LL 7/24/2020 19:00:46'!
contamination

	^ contaminationIndex! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'NR 7/28/2020 21:30:56'!
defaultContaminationIndex

	^0
	! !

!Product class methodsFor: 'instance creation' stamp: 'NR 7/28/2020 21:30:56'!
with: aWeight and: aHeight
	
	^ self with: aWeight and: aHeight contaminatedBy: self defaultContaminationIndex! !

!Product class methodsFor: 'instance creation' stamp: 'NR 7/28/2020 21:16:47'!
with: aWeight and: aHeight contaminatedBy: aVirus

	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].

	^ self new initializeWith: aWeight and: aHeight contaminatedBy: aVirus.
	! !


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


!classDefinition: #ProductA category: #'ISW1-2020-1C-2doParcial-Solucion'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'ISW1-2020-1C-2doParcial-Solucion'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #ProductCarrier category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #ProductCarrier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!ProductCarrier methodsFor: 'action' stamp: 'LL 7/23/2020 19:53:43'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!ProductCarrier methodsFor: 'action' stamp: 'LL 7/23/2020 19:54:07'!
carryProductA: aProduct

	self subclassResponsibility! !

!ProductCarrier methodsFor: 'action' stamp: 'LL 7/23/2020 19:54:11'!
carryProductB: aProduct

	self subclassResponsibility! !


!ProductCarrier methodsFor: 'weight' stamp: 'NR 7/28/2020 22:59:54'!
totalProductsWeight

	self subclassResponsibility! !


!ProductCarrier methodsFor: 'testing' stamp: 'NR 7/28/2020 21:50:01'!
includes: aProduct

	self subclassResponsibility ! !

!ProductCarrier methodsFor: 'testing' stamp: 'NR 7/28/2020 22:51:31'!
isEmpty
	
	self subclassResponsibility ! !


!classDefinition: #Trailer category: #'ISW1-2020-1C-2doParcial-Solucion'!
ProductCarrier subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accesing totals' stamp: 'NR 7/28/2020 21:35:33'!
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

!classDefinition: 'Trailer class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
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


!classDefinition: #TrailerWithCleaner category: #'ISW1-2020-1C-2doParcial-Solucion'!
ProductCarrier subclass: #TrailerWithCleaner
	instanceVariableNames: 'trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!TrailerWithCleaner methodsFor: 'testing' stamp: 'NR 7/28/2020 21:49:29'!
includes: aProduct

	^ trailer includes: aProduct! !

!TrailerWithCleaner methodsFor: 'testing' stamp: 'NR 7/28/2020 23:00:59'!
isEmpty
	
	^ trailer isEmpty! !

!TrailerWithCleaner methodsFor: 'testing' stamp: 'NR 7/28/2020 23:01:17'!
totalProductsWeight

	^ trailer totalProductsWeight! !


!TrailerWithCleaner methodsFor: 'action' stamp: 'LL 7/23/2020 23:51:44'!
clean: aProduct

	self subclassResponsibility.! !



!TrailerWithCleaner methodsFor: 'initialization' stamp: 'LL 7/23/2020 23:50:20'!
initializeUsing: aTrailer

	trailer := aTrailer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TrailerWithCleaner class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
TrailerWithCleaner class
	instanceVariableNames: ''!

!TrailerWithCleaner class methodsFor: 'as yet unclassified' stamp: 'LL 7/23/2020 23:50:32'!
using: aTrailer

	^self new initializeUsing: aTrailer! !


!classDefinition: #TrailerWithBleachCleaner category: #'ISW1-2020-1C-2doParcial-Solucion'!
TrailerWithCleaner subclass: #TrailerWithBleachCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!TrailerWithBleachCleaner methodsFor: 'action' stamp: 'LL 7/21/2020 20:38:30'!
carryProductA: aProduct

	trailer carryProductA: aProduct.! !

!TrailerWithBleachCleaner methodsFor: 'action' stamp: 'LL 7/21/2020 20:38:23'!
carryProductB: aProduct

	self clean: aProduct.
	trailer carryProductB: aProduct.! !

!TrailerWithBleachCleaner methodsFor: 'action' stamp: 'LL 7/23/2020 23:42:57'!
clean: aProduct
		
	aProduct cleanedBy: 3! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TrailerWithBleachCleaner class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
TrailerWithBleachCleaner class
	instanceVariableNames: 'trailer'!


!classDefinition: #TrailerWithUVCleaner category: #'ISW1-2020-1C-2doParcial-Solucion'!
TrailerWithCleaner subclass: #TrailerWithUVCleaner
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!TrailerWithUVCleaner methodsFor: 'action' stamp: 'LL 7/21/2020 20:59:20'!
carryProductA: aProduct

	self clean: aProduct.
	trailer carryProductA: aProduct.! !

!TrailerWithUVCleaner methodsFor: 'action' stamp: 'LL 7/21/2020 20:59:30'!
carryProductB: aProduct

	self clean: aProduct.
	trailer carryProductB: aProduct.! !

!TrailerWithUVCleaner methodsFor: 'action' stamp: 'LL 7/23/2020 23:45:20'!
clean: aProduct

	aProduct cleanedBy: (aProduct contamination * 0.8).! !


!classDefinition: #Robot category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!Robot methodsFor: 'actions' stamp: 'HAW 6/7/2020 15:33:01'!
closeOrderUsing: aCashier

	^ status closeOrderUsing: aCashier! !

!Robot methodsFor: 'actions' stamp: 'LL 7/25/2020 19:06:08'!
detachTrailer

	trailer := nil! !

!Robot methodsFor: 'actions' stamp: 'NR 7/29/2020 16:50:20'!
shipTo: aDestination dueTo: aDateTimeLimit using: vehiclesInWarehouse considering: aDispatchingStrategy
	
	status shipTo: aDestination dueTo: aDateTimeLimit using: vehiclesInWarehouse considering: aDispatchingStrategy! !

!Robot methodsFor: 'actions' stamp: 'FRT 5/3/2020 22:40:35'!
take: aProduct

	status take: aProduct! !


!Robot methodsFor: 'status' stamp: 'NR 7/26/2020 02:28:51'!
finishOperation

	status := FinishedOperations for: self.! !

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


!Robot methodsFor: 'accessing' stamp: 'LL 7/25/2020 19:16:10'!
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


!Robot methodsFor: 'private' stamp: 'NR 7/29/2020 16:49:37'!
canShipTo: aDestination dueTo: aDateTimeLimit using: aCargoVehicle
	
	^ aCargoVehicle canShip: self trailer to: aDestination dueTo: aDateTimeLimit! !

!Robot methodsFor: 'private' stamp: 'NR 7/29/2020 16:49:59'!
selectSuitableVehicles: vehiclesInWarehouse forShippingTo: aDestination dueTo: aDateTimeLimit

	| suitableVehicles |
	
	suitableVehicles := vehiclesInWarehouse select: [:aCargoVehicle | self canShipTo: aDestination dueTo: aDateTimeLimit using: aCargoVehicle].
	suitableVehicles ifEmpty: [self error: Robot noSuitableCargoVehiclesAvailableErrorDescription].
	^suitableVehicles! !

!Robot methodsFor: 'private' stamp: 'NR 7/29/2020 16:50:51'!
whenWorkingNormalShipTo: aDestination dueTo: aDateTimeLimit using: vehiclesInWarehouse considering: aDispatchingStrategy

	| aCargoVehicle |
	
	aCargoVehicle := aDispatchingStrategy bestMatchFor: (self selectSuitableVehicles: vehiclesInWarehouse forShippingTo: aDestination dueTo: aDateTimeLimit).
	aCargoVehicle loadTrailer: self trailer.
	self detachTrailer.
	self finishOperation.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
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


!Robot class methodsFor: 'error messages' stamp: 'NR 7/26/2020 03:50:26'!
cannotShipErrorDescription
	
	^'Cannot dispatch trailer using this robot'.! !

!Robot class methodsFor: 'error messages' stamp: 'NR 7/29/2020 16:00:07'!
finishedOperationsErrorDescription
	
	^'The robot has already finished its operations'! !

!Robot class methodsFor: 'error messages' stamp: 'NR 7/26/2020 03:49:13'!
noSuitableCargoVehiclesAvailableErrorDescription
	
	^'No suitable cargo vehicles available'! !

!Robot class methodsFor: 'error messages' stamp: 'NR 7/26/2020 03:48:15'!
noTrailerAttachedErrorDescription
	
	^'No trailer attached'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'F 5/5/2020 11:18:28'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!RobotStatus methodsFor: 'initialization' stamp: 'FRT 5/3/2020 21:32:00'!
initializeWith: aRobot

	robot := aRobot! !


!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 6/12/2020 10:35:01'!
closeOrderUsing: aCashier

	self subclassResponsibility! !

!RobotStatus methodsFor: 'robot actions' stamp: 'NR 7/26/2020 02:32:43'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy

	self subclassResponsibility! !

!RobotStatus methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:38:22'!
take: aProduct

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RobotStatus class' category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus class
	instanceVariableNames: ''!

!RobotStatus class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 21:30:55'!
for: aRobot
	
	^ self new initializeWith: aRobot! !


!classDefinition: #FinishedOperations category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus subclass: #FinishedOperations
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!FinishedOperations methodsFor: 'as yet unclassified' stamp: 'NR 7/29/2020 16:03:39'!
closeOrderUsing: aCashier
	
	self error: robot class finishedOperationsErrorDescription! !

!FinishedOperations methodsFor: 'as yet unclassified' stamp: 'NR 7/29/2020 16:04:08'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy

	self error: robot class finishedOperationsErrorDescription! !

!FinishedOperations methodsFor: 'as yet unclassified' stamp: 'NR 7/29/2020 16:04:12'!
take: aProduct

	self error: robot class finishedOperationsErrorDescription! !


!classDefinition: #MechanicalFailure category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:46:51'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromMechanicalFailure: robot
	! !

!MechanicalFailure methodsFor: 'robot actions' stamp: 'NR 7/26/2020 02:34:22'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy

	self error: robot class cannotShipErrorDescription! !

!MechanicalFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:44:39'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #OutOfOrder category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'F 5/5/2020 11:20:34'!
closeOrderUsing: aCashier
	
	Robot signalOutOfOrder! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'NR 7/29/2020 16:06:00'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy
	
	Robot signalOutOfOrder! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'HAW 6/7/2020 15:32:51'!
take: aProduct
	
	Robot signalOutOfOrder! !


!classDefinition: #SensorsFailure category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:54'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromSensorsFailure: robot! !

!SensorsFailure methodsFor: 'robot actions' stamp: 'NR 7/26/2020 02:34:37'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy

	self error: robot class cannotShipErrorDescription! !

!SensorsFailure methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:43:35'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #WorkingNormal category: #'ISW1-2020-1C-2doParcial-Solucion'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 22:45:19'!
closeOrderUsing: aCashier
	
	^ aCashier receiveOrderFromNormal: robot! !

!WorkingNormal methodsFor: 'robot actions' stamp: 'LL 7/25/2020 20:17:49'!
shipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy

	robot whenWorkingNormalShipTo: aDestination dueTo: aDateTime using: vehiclesInWarehouse considering: aDispatchingStrategy! !

!WorkingNormal methodsFor: 'robot actions' stamp: 'FRT 5/3/2020 21:41:15'!
take: aProduct
	
	robot carry: aProduct! !


!classDefinition: #ShippingStrategy category: #'ISW1-2020-1C-2doParcial-Solucion'!
Object subclass: #ShippingStrategy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!ShippingStrategy methodsFor: 'testing' stamp: 'LL 7/23/2020 19:46:56'!
bestMatchFor: aCollectionOfVehicles

	self subclassResponsibility! !


!classDefinition: #LatestArrivalStrategy category: #'ISW1-2020-1C-2doParcial-Solucion'!
ShippingStrategy subclass: #LatestArrivalStrategy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!LatestArrivalStrategy methodsFor: 'testing' stamp: 'LL 7/23/2020 19:42:26'!
bestMatchFor: aCollectionOfVehicles

	^aCollectionOfVehicles detectMax: [:aCargoVehicle | aCargoVehicle arrivingOn]! !


!classDefinition: #LightestVehicleStrategy category: #'ISW1-2020-1C-2doParcial-Solucion'!
ShippingStrategy subclass: #LightestVehicleStrategy
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2020-1C-2doParcial-Solucion'!

!LightestVehicleStrategy methodsFor: 'testing' stamp: 'LL 7/25/2020 19:21:51'!
bestMatchFor: aCollectionOfVehicles

	^aCollectionOfVehicles detectMin: [:aCargoVehicle | aCargoVehicle loadWeight].! !
