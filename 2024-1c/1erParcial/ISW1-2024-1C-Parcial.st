!classDefinition: #FloorTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #FloorTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:54:55'!
test01CannotCreateFloorWithoutRooms

	self
		should: [ self createFloorWith: 0 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBePositiveErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:02'!
test02CannotCreateFloorWithNoIntergerNumberOfRooms

	self
		should: [ self createFloorWith: 1.5 and: self defaultPriceList ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor numberOfRoomsMustBeIntegerErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 16:55:06'!
test03CannotCreateFloorWithoutPrices

	self
		should: [ self createFloorWith: 10 and:  Dictionary new ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Floor pricesListCannotBeEmptyErrorDescription ! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 16:53:28'!
test04WhenAFloorIsCreatedAllTheRoomsAreAvailable

	| floor |
	
	floor := self createFloorWith: 10 and: self defaultPriceList.
	
	self assert: floor isAvailable.
	self assert: 0 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 17:00:43'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:58:54'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsAndOccupiedAndReducesTheReservedByOne

	| floor roomsNumber roomsAvailable roomsOccupied roomsReserved |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) reserve.

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	"Tech Debt"
	((floor rooms) at: 1) receiveWithReservation: self guestTypeVacation.
	
	self assert: roomsAvailable equals: floor totalRoomsAvailable. 
	self assert: roomsOccupied equals: floor totalRoomsOccupied.
	self assert: roomsReserved - 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 20:01:42'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedAndOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) reserve.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 20:01:30'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	((floor rooms) at: 2) receive: self guestTypeConference.
	((floor rooms) at: 3) reserve.
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 20:01:22'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	"Tech Debt"
	((floor rooms) at: 1) receive: self guestTypeVacation.
	((floor rooms) at: 2) receive: self guestTypeConference.
	((floor rooms) at: 3) reserve.
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 14:35:45'!
createFloorWith: aNumberOfRooms and: aPrice

	| floor |

	floor := Floor new.
	floor setNumberOfRooms: aNumberOfRooms.
	floor setPrices: aPrice.
	
	^ floor.! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:09'!
guestTypeConference
	
	^ #conferenceGuest! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:00:42'!
guestTypeVacation
	
	^ #vacationGuest! !


!classDefinition: #HotelTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:16:52'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel new setFloors: OrderedCollection new. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Hotel noFloorsErrorDescription.! !

!HotelTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:30:09'!
test02NewHotelsAreEmpty

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel isEmpty.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:22'!
test03HotelCanReceiveATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:32'!
test04HotelCanTakeAReservationForARoomAtFloor

	| hotel |
	
	hotel := self createHotel.

	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 1 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:41'!
test05HotelCanReceiveWithReservationATypeOfGuestInRoomAtFloor

	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	hotel reserveRoom: 2 atFloor: 1.
	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2.

	self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
	self assert: 0 equals: hotel totalRoomsReserved.
	self assert: 1 equals: hotel totalRoomsOccupied.
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:17:34'!
test06HotelCannotReceiveWithReservationWithoutPreviousReservation
	
	| hotel |
	
	hotel := self createHotel.
	
	self assert: hotel totalRooms equals: hotel	 totalRoomsAvailable.

	self 
		should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [		:error |	
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
			self assert: 0 equals: hotel totalRoomsReserved.
			self assert: 0 equals: hotel totalRoomsOccupied.
		]


! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:18:52'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel new setFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:19:02'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel new setFloors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:19:21'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 42 atFloor: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]
! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:19:32'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 1 atFloor: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:20:37'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:20:45'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:20:54'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel new setFloors: floors.

	hotel reserveRoom: 1 atFloor: 1. 
	
	self 
	should: [ 	hotel receiveWithReservation: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms - 1 equals: hotel totalRoomsAvailable.
		self assert: 1 equals: hotel totalRoomsReserved.
		self assert: 1 equals: hotel totalRoomsOccupied.
	]! !


!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:05'!
createFloorWith: aNumberOfRooms and: aPrice

	| floor |

	floor := Floor new.
	floor setNumberOfRooms: aNumberOfRooms.
	floor setPrices: aPrice.
	
	^ floor.! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:32:32'!
createHotel

	^ Hotel new 
		      setFloors: (OrderedCollection with: (self createFloorWith: 10 and: self defaultPriceList)
								      	 with: (self createFloorWith: 1 and: self defaultPriceList)).
								! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:36'!
guestTypeConference
	
	^ #conferenceGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:42'!
guestTypeVacation
	
	^ #vacationGuest! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:48'!
maxPriceInList
	
	^ 200*peso ! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:53'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #RoomTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #RoomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/21/2024 22:11:08'!
test01NewRoomsAreAvailable

	| room |
	
	room := Room new.

	self assert: room isAvailable.
	
	self deny: room isOccupied.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:03:07'!
test02ReceivingAGuestMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self assert: room isOccupied.

	self deny: room isAvailable.
	self deny: room isReserved.! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:04:16'!
test03ReservingARoomMakesTheRoomReservedAndOccupied

	| room |
	
	room := Room new.

	room reserve.

	self assert: room isReserved.
	self assert: room isOccupied.

	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:25'!
test04CannotReceiveAGuestInAOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.

			self assert: room isOccupied.
			
			self deny: room isAvailable.
			self deny: room isReserved.
		]
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:32'!
test05CannotReceiveAGuestInAReservedRoom

	| room |
	
	room := Room new.

	room reserve.
	
	self 
		should: [ room receive: self guestTypeVacation ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotEmptyErrorDescription equals: error messageText.
			
			self assert: room isReserved.
			self assert: room isOccupied.
			
			self deny: room isAvailable.
		]

	

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:58:29'!
test06ReceivingOnReservationMakesTheRoomOccupied

	| room |
	
	room := Room new.

	room reserve.
	
	room receiveWithReservation: self guestTypeVacation.
	
	self assert: room isOccupied.
	
	self deny: room isReserved.
	self deny: room isAvailable.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:40'!
test07CannotReceiveOnReservationAnAvailableRoom

	| room |
	
	room := Room new.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.

			self assert: room isAvailable.

			self deny: room isReserved.
			self deny: room isOccupied.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/26/2024 17:30:50'!
test08CannotReceiveOnReservationAnOccupiedRoom

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room receiveWithReservation: self guestTypeVacation. ] 
		raise: Error - MessageNotUnderstood 	
		withExceptionDo:  [ 	:error |
			self assert: Room roomIsNotReservedErrorDescription equals: error messageText.
			
			self assert: room isOccupied.

			self deny: room isReserved.
			self deny: room isAvailable.
		]

	
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:22:02'!
test09ProfitOfAvailableRoomIsCeroPesos

	| room |
	
	room := Room new.

	self assert: 0*peso equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:22:57'!
test10ProfitOfReservedRoomIsHalfTheMinPriceInList

	| room |
	
	room := Room new.

	room reserve.

	self assert: self minPriceInList / 2 equals: (room profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:45:00'!
test11ProfitOfOccupiedRoomDependsOnGuestType

	| roomWithConferenceGuest roomWithVacationGuest |
	
	roomWithConferenceGuest := Room new.
	roomWithConferenceGuest receive: self guestTypeConference.
	
	roomWithVacationGuest := Room new.
	roomWithVacationGuest receive: self guestTypeVacation.

	self assert: (self defaultPriceList at: self guestTypeConference) 
		equals: (roomWithConferenceGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

	self assert: (self defaultPriceList at: self guestTypeVacation) 
		equals: (roomWithVacationGuest profitUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'FRT 4/22/2024 09:52:21'!
test12NoProfitOnOccupiedRoomByUnknownGuestType

	| room |
	
	room := Room new.
	room receive: #unknownGuest.
	
	room profitUsing: self defaultPriceList ifAbsentGuestType: [ ^self ].
	
	"we should not get here"
	self failWith: 'should not calculate profit on room occupied by unknown guest type'.
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:21:19'!
test13LossesOfAvailableRoomIsHalfTheMaxPriceInList

	self shouldFail: [
		| room |
	
		room := Room new.

		self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	]	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:21:36'!
test14LossesOfReservedRoomIsCeroPesos

	self shouldFail: [
		| room |
	
		room := Room new.

		room reserve.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	]	
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/29/2024 11:21:50'!
test15LossesOfOccupiedRoomIsCeroPesos

	self shouldFail: [
		| room |
		
		room := Room new.

		room receive: self guestTypeVacation.

		self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
	]! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:31'!
test16CannotReserveWhenReserved

	| room |
	
	room := Room new.

	room reserve.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isReserved ].! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/28/2024 15:53:48'!
test17CannotReserveWhenOccupied

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self 
		should: [ room reserve ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Room roomIsNotEmptyErrorDescription equals: anError messageText.
			self assert: room isOccupied ].! !


!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:28'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:20:45'!
guestTypeConference
	
	^ #conferenceGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:02:15'!
guestTypeVacation
	
	^ #vacationGuest! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:16:13'!
maxPriceInList
	
	^ 200*peso ! !

!RoomTest methodsFor: 'create' stamp: 'FRT 4/22/2024 09:40:38'!
minPriceInList
	
	^ 100*peso ! !


!classDefinition: #Floor category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Floor
	instanceVariableNames: 'rooms prices'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Floor methodsFor: 'testing' stamp: 'FRT 4/21/2024 15:02:31'!
isAvailable
	
	^ self totalRooms = self totalRoomsAvailable

		
! !


!Floor methodsFor: 'accessing' stamp: 'FRT 4/20/2024 21:34:09'!
rooms

	^ rooms! !


!Floor methodsFor: 'accounting' stamp: 'FRT 4/21/2024 13:23:04'!
totalLosses
	
	| total |
	
	total := 0*peso.
	rooms do: [ :room | room isAvailable ifTrue: [ total := total + prices values max ] ].

	^ total

		
! !

!Floor methodsFor: 'accounting' stamp: 'FRT 4/21/2024 22:06:47'!
totalProfits

	| total |
	
	total := 0*peso.
	rooms do: [ :room | | roomTotal | 
		room isOccupied ifTrue: [
			roomTotal := 	room profitUsing: prices ifAbsentGuestType: [ self class signalUnknownGuestType ].
			total := total + roomTotal.
		]
	].

	^ total
! !


!Floor methodsFor: 'setters' stamp: 'FRT 4/20/2024 19:48:41'!
setNumberOfRooms: aNumberOfRooms

	self class assertIsPositive: aNumberOfRooms ifFalse: [ self class signalNumberOfRoomsMustBePositive ].
	self class assertIsInteger: aNumberOfRooms ifFalse: [ self class signalNumberOfRoomsMustBeInteger ].
	
	self initializeRoomsWith: aNumberOfRooms.
! !

!Floor methodsFor: 'setters' stamp: 'FRT 4/21/2024 15:00:28'!
setPrices: aPriceList

	aPriceList isEmpty ifTrue: [ self class signalNoPrices ].
	
	aPriceList values do: [ :price | 
		self class assertIsPositive: price ifFalse: [ self class signalPriceMustBePositive ].
	].
	
	self initializeWith: aPriceList.! !


!Floor methodsFor: 'totals' stamp: 'FRT 4/21/2024 14:49:55'!
totalRooms
	
	^ rooms size
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:36'!
totalRoomsAvailable
	
	^rooms count: [ :room | room isAvailable ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:49:47'!
totalRoomsOccupied
	
	^rooms count: [ :room | room isOccupied ]
		
! !

!Floor methodsFor: 'totals' stamp: 'HAW 4/28/2024 16:50:07'!
totalRoomsReserved
	
	^rooms count: [ :room | room isReserved ]! !


!Floor methodsFor: 'initialization' stamp: 'FRT 4/20/2024 19:57:37'!
initializeRoomsWith: aNumberOfRooms

	| ix |
	
	rooms := OrderedCollection new.
	
	ix := 1.
	[ ix <= aNumberOfRooms ] whileTrue: [ 
		rooms add: Room new.
		ix := ix + 1.
	]
! !

!Floor methodsFor: 'initialization' stamp: 'FRT 4/21/2024 00:23:52'!
initializeWith: aPriceList

	prices := aPriceList! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Floor class' category: #'ISW1-2024-1C-Parcial'!
Floor class
	instanceVariableNames: ''!

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:39:26'!
assertIsInteger: aNumber ifFalse: signalsBlock

	aNumber isInteger ifFalse: signalsBlock! !

!Floor class methodsFor: 'assertions' stamp: 'FRT 4/20/2024 19:40:06'!
assertIsPositive: aNumber ifFalse: signalsBlock

	aNumber strictlyPositive ifFalse: signalsBlock! !


!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:02:53'!
numberOfRoomsMustBeIntegerErrorDescription
	
	^ 'Number of rooms must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:35:54'!
numberOfRoomsMustBePositiveErrorDescription
	
	^'The number of rooms must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:12'!
priceMustBeIntegerErrorDescription
	
	^ 'Price must be integer'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/20/2024 19:42:25'!
priceMustBePositiveErrorDescription
	
	^'Price must be positive'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:43:01'!
pricesListCannotBeEmptyErrorDescription 
	
	^ 'Prices List must not be empty'! !

!Floor class methodsFor: 'error messages' stamp: 'FRT 4/21/2024 14:47:30'!
unknownGuestTypeErrorDescription
	
	^ 'The guest type is unknown'! !


!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:42:33'!
signalNoPrices
	
	self error: self pricesListCannotBeEmptyErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:02:35'!
signalNumberOfRoomsMustBeInteger
	
	self error: self numberOfRoomsMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:35:54'!
signalNumberOfRoomsMustBePositive

	self error: self numberOfRoomsMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:37'!
signalPriceMustBeInteger
	
	self error: self priceMustBeIntegerErrorDescription ! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 19:41:58'!
signalPriceMustBePositive

	self error: self priceMustBePositiveErrorDescription! !

!Floor class methodsFor: 'exceptions' stamp: 'FRT 4/21/2024 14:48:09'!
signalUnknownGuestType

	self error: self class unknownGuestTypeErrorDescription
! !


!classDefinition: #Hotel category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors availableRoomsCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Hotel methodsFor: 'accounting' stamp: 'FRT 4/21/2024 00:02:28'!
totalLosses

	| acc |
	
	acc := 0.
	floors do: [ :floor | acc := acc + floor totalLosses ]. 

	^ acc.
! !

!Hotel methodsFor: 'accounting' stamp: 'FRT 4/22/2024 13:55:50'!
totalProfits

	| acc |
	
	acc := 0.
	floors do: [ :floor | acc := acc + floor totalProfits ]. 

	^ acc.
! !


!Hotel methodsFor: 'initialization' stamp: 'FRT 4/20/2024 23:37:37'!
initialize

	availableRoomsCount := 0.
! !


!Hotel methodsFor: 'setters' stamp: 'FRT 4/22/2024 11:50:40'!
setFloors: aFloorsCollection

	self class assertHaveFloors: aFloorsCollection.

	floors := aFloorsCollection.
	
	availableRoomsCount := self totalRooms.! !


!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:27'!
totalRooms

	| ix acc |

	acc := 0.

	ix := 1.	
	[ ix <= floors size ] whileTrue: [ | floor jx |
		floor := floors at: ix.

		jx := 1.
		[ jx <= floor rooms size ] whileTrue: [ 
			acc := acc + 1.
			
			jx := jx + 1.
		].
			
		ix := ix + 1.				
	].

	^ acc.

! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:00'!
totalRoomsAvailable

	^ availableRoomsCount.
! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:42:53'!
totalRoomsOccupied

	| ix acc |

	acc := 0.

	ix := 1.	
	[ ix <= floors size ] whileTrue: [ | floor jx |
		floor := floors at: ix.

		jx := 1.
		[ jx <= floor rooms size ] whileTrue: [ | room | 
			room := floor rooms at: jx.
			room isOccupied ifTrue: [ 			acc := acc + 1. ].
			
			jx := jx + 1.
		].
			
		ix := ix + 1.				
	].

	^ acc.

! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:13'!
totalRoomsReserved

	| ix acc |

	acc := 0.

	ix := 1.	
	[ ix <= floors size ] whileTrue: [ | floor jx |
		floor := floors at: ix.

		jx := 1.
		[jx <= floor rooms size] whileTrue: [ | room | 
			room := floor rooms at: jx.
			room isReserved ifTrue: [ 			acc := acc + 1. ].
			
			jx := jx + 1.
		].
			
		ix := ix + 1.				
	].

	^ acc.

! !


!Hotel methodsFor: 'testing' stamp: 'FRT 4/22/2024 11:32:03'!
isEmpty

	| ix acc |
	
	acc := true.

	ix := 1.	
	[ ix <= floors size ] whileTrue: [ | floor jx |
		floor := floors at: ix.

		jx := 1.
		[ jx <= floor rooms size ] whileTrue: [ | room |
			room := floor rooms at: jx.
			acc := acc and: room isAvailable.
			
			jx := jx + 1.
		].
			
		ix := ix + 1.				
	].

	^ acc.
! !


!Hotel methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:45:24'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor room |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	room := floor rooms at: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].

	room receive: aGuestType.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:55:45'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| floor room |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	room := floor rooms at: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].

	room receiveWithReservation: aGuestType.

! !

!Hotel methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:56:34'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	| floor room |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	room := floor rooms at: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].
	 
	room reserve.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Hotel class' category: #'ISW1-2024-1C-Parcial'!
Hotel class
	instanceVariableNames: ''!

!Hotel class methodsFor: 'assertions' stamp: 'HAW 4/29/2024 08:48:39'!
assertHaveFloors: aFloorsCollection

	aFloorsCollection isEmpty ifTrue: [ self signalNoFloors ].! !


!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:42:02'!
floorNumberDoesNotExistErrorDescription

	^ 'Floor number does not exist'.! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/20/2024 21:42:02'!
noFloorsErrorDescription

	^ 'Cannot have a Hotel without floors'! !

!Hotel class methodsFor: 'error description' stamp: 'FRT 4/25/2024 21:41:41'!
roomNumberDoesNotExistErrorDescription

	^ 'Room number does not exist'.! !


!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:24'!
signalFloorNumberDoesNotExist

	self error: self floorNumberDoesNotExistErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/20/2024 21:41:30'!
signalNoFloors

	self error: self noFloorsErrorDescription.! !

!Hotel class methodsFor: 'exceptions' stamp: 'FRT 4/25/2024 21:42:39'!
signalRoomNumberDoesNotExist

	self error: self roomNumberDoesNotExistErrorDescription.! !


!classDefinition: #Room category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Room
	instanceVariableNames: 'guest'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Room methodsFor: 'guests' stamp: 'FRT 4/21/2024 00:18:42'!
guestType

	^ guest! !

!Room methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:07:35'!
receive: aGuestType

	"Room Occupied"
	(guest notNil or: [guest = #reserved])
		ifTrue: [ self error: self class roomIsNotEmptyErrorDescription ]
		ifFalse: [  guest := aGuestType ] ! !

!Room methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:07:41'!
receiveWithReservation: aGuestType
	
	"Room Reserved"
	guest = #reserved
		ifTrue: [  guest := aGuestType ] 
		ifFalse: [ self error: self class roomIsNotReservedErrorDescription ]
! !

!Room methodsFor: 'guests' stamp: 'FRT 4/25/2024 21:10:12'!
reserve

	"Room Occupied"
	(guest notNil or: [guest = #reserved]) 
		ifTrue: [ self error: self class roomIsNotEmptyErrorDescription ]
		ifFalse: [  	guest := #reserved ]! !


!Room methodsFor: 'testing' stamp: 'FRT 4/20/2024 22:33:39'!
isAvailable

	^ guest isNil! !

!Room methodsFor: 'testing' stamp: 'FRT 4/25/2024 21:08:13'!
isOccupied

	^ guest notNil or: [guest = #reserved]
! !

!Room methodsFor: 'testing' stamp: 'FRT 4/25/2024 21:02:45'!
isReserved

	^ guest = #reserved! !


!Room methodsFor: 'accounting' stamp: 'HAW 4/28/2024 16:04:40'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	"Room Available"
	guest isNil ifTrue: [ ^ 0*peso ].

	"Room Reserved"
	guest = #reserved ifTrue: [ ^ aPriceList values min / 2 ].
	
	"Room Occupied"
	(guest notNil or: [guest = #reserved]) ifTrue: [ ^ aPriceList at: guest ifAbsent: unknownGuestTypeBlock ].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Room class' category: #'ISW1-2024-1C-Parcial'!
Room class
	instanceVariableNames: ''!

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:14'!
roomIsNotEmptyErrorDescription

	^ 'Room is not empty.'! !

!Room class methodsFor: 'error messages' stamp: 'FRT 4/22/2024 09:01:43'!
roomIsNotReservedErrorDescription

	^ 'Room is not reserved.'! !
