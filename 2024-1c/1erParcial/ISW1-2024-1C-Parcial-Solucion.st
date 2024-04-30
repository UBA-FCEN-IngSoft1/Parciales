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

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:42:13'!
test05WhenAFloorReceivesAGuestInARoomReducesTheAvailableRoomsByOneAndIncreaseOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	(floor roomAt: 1) receive: self guestTypeVacation.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 0 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:42:21'!
test06WhenAFloorReceivesOnReservationAGuestInARoomKeepsTheAvailableRoomsAndOccupiedAndReducesTheReservedByOne

	| floor roomsNumber roomsAvailable roomsOccupied roomsReserved |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	(floor roomAt: 1) reserve.

	roomsAvailable := floor totalRoomsAvailable.
	roomsOccupied := floor totalRoomsOccupied.
	roomsReserved := floor totalRoomsReserved.

	(floor roomAt: 1) receiveWithReservation: self guestTypeVacation.
	
	self assert: roomsAvailable equals: floor totalRoomsAvailable. 
	self assert: roomsOccupied equals: floor totalRoomsOccupied.
	self assert: roomsReserved - 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:42:27'!
test07WhenARoomIsReservedTheFloorAvailableRoomsReducesByOneAndIncreaseReservedAndOccupiedByOne

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	(floor roomAt: 1) reserve.
	
	self assert: roomsNumber - 1 equals: floor totalRoomsAvailable. 
	self assert: 1 equals: floor totalRoomsOccupied.
	self assert: 1 equals: floor totalRoomsReserved.
! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:42:32'!
test08TotalProfitShouldBeTheSumOfOccupiedRoomsProfits

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	(floor roomAt: 1) receive: self guestTypeVacation.
	(floor roomAt: 2) receive: self guestTypeConference.
	(floor roomAt: 3) reserve.
		
	self assert: (100*peso) + (200*peso) + (50*peso) equals: floor totalProfits
! !

!FloorTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:42:37'!
test09TotalLossesShouldBeTheSumOfAvailableRoomsLosses

	| floor roomsNumber |
	
	roomsNumber := 10.
	floor := self createFloorWith: roomsNumber and: self defaultPriceList.
	
	(floor roomAt: 1) receive: self guestTypeVacation.
	(floor roomAt: 2) receive: self guestTypeConference.
	(floor roomAt: 3) reserve.
		
	self assert: (200*peso) * 7 equals: floor totalLosses
! !


!FloorTest methodsFor: 'create' stamp: 'HAW 4/30/2024 15:55:40'!
createFloorWith: aNumberOfRooms and: aPrice

	^ Floor numberOfRooms: aNumberOfRooms prices: aPrice.! !

!FloorTest methodsFor: 'create' stamp: 'FRT 4/21/2024 17:01:23'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: 100*peso;
		at: self guestTypeConference put: 200*peso;
		yourself ! !

!FloorTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:44:45'!
guestTypeConference
	
	^ Room guestTypeConference ! !

!FloorTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:45:29'!
guestTypeVacation
	
	^ Room guestTypeVacation ! !


!classDefinition: #HotelTest category: #'ISW1-2024-1C-Parcial'!
TestCase subclass: #HotelTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 15:59:48'!
test01CannotCreateHotelWithoutFloors

	self
		should: [ Hotel floors: OrderedCollection new. ]
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

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 15:59:55'!
test07HotelProfitsAreTheSumOfEachFloorProfits
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel floors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	self assert: floor1 totalProfits + floor2 totalProfits equals:		hotel totalProfits.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:00'!
test08HotelLossesAreTheSumOfEachFloorLosses
	
	| hotel floor1 floor2 floors |
	
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.
	floor2 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1 with: floor2.
	hotel := 	Hotel floors: floors.
	
	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 1.
	hotel receive: self guestTypeConference atFloor: 2 atRoom: 1.

	hotel reserveRoom: 4 atFloor: 1.
	hotel reserveRoom: 2 atFloor: 2.

	self assert: floor1 totalLosses + floor2 totalLosses equals:		hotel totalLosses.! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:06'!
test09HotelCannotReserveANonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel floors: floors.
	
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

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:11'!
test10HotelCannotReserveANonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel floors: floors.
	
	self 
	should: [ 	hotel reserveRoom: 1 atFloor: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:18'!
test11HotelCannotReceiveAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel floors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 1 atRoom: 42. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel roomNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:23'!
test12HotelCannotReceiveAtNonexistentFloor
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel floors: floors.
	
	self 
	should: [ 	hotel receive: self guestTypeVacation atFloor: 42 atRoom: 1. ]
	raise: Error - MessageNotUnderstood 
	withExceptionDo: [		:error |	
		self assert: Hotel floorNumberDoesNotExistErrorDescription equals: error messageText.
		
		self assert: hotel	 totalRooms equals: hotel totalRoomsAvailable.
		self assert: 0 equals: hotel totalRoomsReserved.
		self assert: 0 equals: hotel totalRoomsOccupied.
	]! !

!HotelTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:00:29'!
test13HotelCannotReceiveWithReservationAtNonexistentRoom
	
	| hotel floor1 floors |
	
	floor1 := self createFloorWith: 10 and: self defaultPriceList.

	floors := OrderedCollection with: floor1.
	hotel := 	Hotel floors: floors.

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


!HotelTest methodsFor: 'create' stamp: 'HAW 4/30/2024 15:56:04'!
createFloorWith: aNumberOfRooms and: aPrice

	^ Floor numberOfRooms: aNumberOfRooms prices: aPrice.! !

!HotelTest methodsFor: 'create' stamp: 'HAW 4/30/2024 15:57:29'!
createHotel

	^ Hotel floors: (OrderedCollection 
		with: (self createFloorWith: 10 and: self defaultPriceList)
		with: (self createFloorWith: 1 and: self defaultPriceList)).
								! !

!HotelTest methodsFor: 'create' stamp: 'FRT 4/22/2024 10:27:22'!
defaultPriceList
	
	^ Dictionary new
		at: self guestTypeVacation put: self minPriceInList;
		at: self guestTypeConference put: self maxPriceInList;
		yourself ! !

!HotelTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:44:40'!
guestTypeConference
	
	^ Room guestTypeConference ! !

!HotelTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:45:34'!
guestTypeVacation
	
	^ Room guestTypeVacation ! !

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

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:36:59'!
test13LossesOfAvailableRoomIsTheMaxPriceInList

	| room |

	room := Room new.

	self assert: self maxPriceInList equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).

! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:38:52'!
test14LossesOfReservedRoomIsCeroPesos

	| room |

	room := Room new.

	room reserve.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

!RoomTest methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:39:13'!
test15LossesOfOccupiedRoomIsCeroPesos

	| room |
	
	room := Room new.

	room receive: self guestTypeVacation.

	self assert: 0*peso equals: (room lossUsing: self defaultPriceList ifAbsentGuestType: [ self fail ]).
! !

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

!RoomTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:44:23'!
guestTypeConference
	
	^ Room guestTypeConference ! !

!RoomTest methodsFor: 'create' stamp: 'HAW 4/30/2024 16:45:04'!
guestTypeVacation
	
	^Room guestTypeVacation ! !

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


!Floor methodsFor: 'initialization' stamp: 'HAW 4/30/2024 15:54:43'!
initializeNumberOfRooms: aNumberOfRooms prices: aPriceList 
	
	self initializeRoomsWith: aNumberOfRooms.
	prices := aPriceList.! !

!Floor methodsFor: 'initialization' stamp: 'HAW 4/30/2024 15:54:24'!
initializeRoomsWith: aNumberOfRooms

	rooms := OrderedCollection new.
	
	aNumberOfRooms timesRepeat: [ rooms add: Room new ]
! !


!Floor methodsFor: 'accessing rooms' stamp: 'HAW 4/30/2024 16:35:16'!
roomAt: aRoomNumber
 
	^rooms at: aRoomNumber ! !

!Floor methodsFor: 'accessing rooms' stamp: 'HAW 4/30/2024 16:30:22'!
roomsAt: aRoomNumber ifAbsent: absentBlock

	^rooms at: aRoomNumber ifAbsent: absentBlock ! !

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

!Floor class methodsFor: 'assertions' stamp: 'HAW 4/30/2024 16:01:12'!
assertIsValidNumberOfRooms: aNumberOfRooms

	self assertIsPositive: aNumberOfRooms ifFalse: [ self signalNumberOfRoomsMustBePositive ].
	self assertIsInteger: aNumberOfRooms ifFalse: [ self signalNumberOfRoomsMustBeInteger ]! !

!Floor class methodsFor: 'assertions' stamp: 'HAW 4/30/2024 16:01:31'!
assertIsValidPriceList: aPriceList

	aPriceList isEmpty ifTrue: [ self signalNoPrices ].
	aPriceList values do: [ :price | self assertIsPositive: price ifFalse: [ self signalPriceMustBePositive ]]! !


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


!Floor class methodsFor: 'instance creation' stamp: 'HAW 4/30/2024 16:01:34'!
numberOfRooms: aNumberOfRooms prices: aPriceList 
	
	self assertIsValidNumberOfRooms: aNumberOfRooms.	
	self assertIsValidPriceList: aPriceList.
	
	^self new initializeNumberOfRooms: aNumberOfRooms prices: aPriceList ! !


!classDefinition: #Hotel category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Hotel
	instanceVariableNames: 'floors availableRoomsCount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Hotel methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:41:09'!
totalLosses

	^floors sum: [ :floor | floor totalLosses ]. 
! !

!Hotel methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:41:32'!
totalProfits

	^floors sum: [ :floor | floor totalProfits ]. 
! !


!Hotel methodsFor: 'initialization' stamp: 'HAW 4/30/2024 15:59:18'!
initializeFloors: aFloors 
	
	floors := aFloors.
	availableRoomsCount := self totalRooms.	
! !


!Hotel methodsFor: 'totals' stamp: 'HAW 4/30/2024 16:33:03'!
totalRooms

	^floors sum: [ :aFloor | aFloor totalRooms ]! !

!Hotel methodsFor: 'totals' stamp: 'FRT 4/22/2024 11:43:00'!
totalRoomsAvailable

	^ availableRoomsCount.
! !

!Hotel methodsFor: 'totals' stamp: 'HAW 4/30/2024 16:33:55'!
totalRoomsOccupied

	^floors sum: [ :aFloor | aFloor totalRoomsOccupied ]
! !

!Hotel methodsFor: 'totals' stamp: 'HAW 4/30/2024 16:34:14'!
totalRoomsReserved

	^floors sum: [ :aFloor | aFloor totalRoomsReserved ]
! !


!Hotel methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:29:29'!
isEmpty

	^floors allSatisfy: [ :aFloor | aFloor isAvailable ]! !


!Hotel methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:40:30'!
receive: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	|  room |
	
	room := self roomAt: aRoomNumber inFloor: aFloorNumber.
	room receive: aGuestType.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:32:06'!
receiveWithReservation: aGuestType atFloor: aFloorNumber atRoom: aRoomNumber

	| room |
	
	room := self roomAt: aRoomNumber inFloor: aFloorNumber.
	room receiveWithReservation: aGuestType.

! !

!Hotel methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:32:26'!
reserveRoom: aRoomNumber atFloor: aFloorNumber

	| room |
	
	room := self roomAt: aRoomNumber inFloor: aFloorNumber.
	room reserve.
	
	availableRoomsCount := availableRoomsCount - 1.
! !

!Hotel methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:40:47'!
roomAt: aRoomNumber inFloor: aFloorNumber

	| floor room |
	
	floor := floors at: aFloorNumber ifAbsent:  [ self class signalFloorNumberDoesNotExist ].
	room := floor roomsAt: aRoomNumber ifAbsent: [ self class signalRoomNumberDoesNotExist ].
	
	^ room! !

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


!Hotel class methodsFor: 'instance creation' stamp: 'HAW 4/30/2024 15:59:06'!
floors: aFloorsCollection 

	self assertHaveFloors: aFloorsCollection .

	^self new initializeFloors: aFloorsCollection ! !


!classDefinition: #Room category: #'ISW1-2024-1C-Parcial'!
Object subclass: #Room
	instanceVariableNames: 'status'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!Room methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:10:04'!
receive: aGuestType

	status receive: aGuestType in: self! !

!Room methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:14:35'!
receiveWithReservation: aGuestType
	
	status receiveWithReservation: aGuestType in: self! !

!Room methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:07:45'!
reserve

	status reserveIn: self ! !


!Room methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:22:10'!
isAvailable

	^ status isAvailable ! !

!Room methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:19:35'!
isOccupied

	^ status isOccupied 
! !

!Room methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:19:59'!
isReserved

	^ status isReserved ! !


!Room methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:38:06'!
lossUsing: aPriceList ifAbsentGuestType: absentBlock

	^status lossUsing: aPriceList ifAbsentGuestType: absentBlock ! !

!Room methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:26:06'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	^status profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	! !


!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:50:03'!
receiveWhenAvailable: aGuestType 
	
	status := OccupiedRoom with: aGuestType ! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:13:03'!
receiveWhenOccupied: aGuestType 
	
	self error: self class roomIsNotEmptyErrorDescription 
	! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:13:38'!
receiveWhenReserved: aGuestType 
	
	self error: self class roomIsNotEmptyErrorDescription 
		! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:15:57'!
receiveWithReservationWhenAvailable: aGuestType 
	
	self error: self class roomIsNotReservedErrorDescription ! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:16:29'!
receiveWithReservationWhenOccupied: aGuestType 
	
	self error: self class roomIsNotReservedErrorDescription! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:50:03'!
receiveWithReservationWhenReserved: aGuestType 
	
	status := OccupiedRoom with: aGuestType ! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:50:14'!
reserveWhenAvailable
	
	status := ReservedRoom new! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:12:08'!
reserveWhenOccupied
	
	self error: self class roomIsNotEmptyErrorDescription! !

!Room methodsFor: 'guests-private' stamp: 'HAW 4/30/2024 16:09:12'!
reserveWhenReserved
	
	self error: self class roomIsNotEmptyErrorDescription! !


!Room methodsFor: 'initialization' stamp: 'HAW 4/30/2024 16:49:51'!
initialize

	status := AvailableRoom new! !

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


!Room class methodsFor: 'as yet unclassified' stamp: 'HAW 4/30/2024 16:44:31'!
guestTypeConference
	
	^#conferenceGuest! !

!Room class methodsFor: 'as yet unclassified' stamp: 'HAW 4/30/2024 16:45:19'!
guestTypeVacation
	
	 ^#vacationGuest! !


!classDefinition: #RoomStatus category: #'ISW1-2024-1C-Parcial'!
Object subclass: #RoomStatus
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!RoomStatus methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:22:15'!
isAvailable

	^false! !

!RoomStatus methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:06:21'!
isOccupied

	^false! !

!RoomStatus methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:06:25'!
isReserved

	^false! !


!RoomStatus methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:48:11'!
receive: aGuestType in: aRoom

	self subclassResponsibility! !

!RoomStatus methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:48:15'!
receiveWithReservation: aGuestType in: aRoom

	self subclassResponsibility! !

!RoomStatus methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:48:18'!
reserveIn: aRoom

	self subclassResponsibility! !


!RoomStatus methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:48:02'!
lossUsing: aPriceList ifAbsentGuestType: absentBlock

	self subclassResponsibility! !

!RoomStatus methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:48:07'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock

	self subclassResponsibility! !


!classDefinition: #AvailableRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #AvailableRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!AvailableRoom methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:22:21'!
isAvailable
	
	^true! !


!AvailableRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:38:31'!
lossUsing: aPriceList ifAbsentGuestType: absentBlock 
	
	^aPriceList value max! !

!AvailableRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:26:23'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	
	^ 0*peso

	! !


!AvailableRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:10:27'!
receive: aGuestType in: aRoom 
	
	aRoom receiveWhenAvailable: aGuestType ! !

!AvailableRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:15:43'!
receiveWithReservation: aGuestType in: aRoom 
	
	aRoom receiveWithReservationWhenAvailable: aGuestType ! !

!AvailableRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:08:06'!
reserveIn: aRoom 
	
	aRoom reserveWhenAvailable! !


!classDefinition: #OccupiedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #OccupiedRoom
	instanceVariableNames: 'guestType'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!OccupiedRoom methodsFor: 'initialization' stamp: 'HAW 4/30/2024 16:11:18'!
initializeWith: aGuestType 
	
	guestType := aGuestType.! !


!OccupiedRoom methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:06:36'!
isOccupied

	^true ! !


!OccupiedRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:39:21'!
lossUsing: aPriceList ifAbsentGuestType: absentBlock 
	
	^0*peso! !

!OccupiedRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:26:50'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	
	^ aPriceList at: guestType ifAbsent: unknownGuestTypeBlock 
	
	! !


!OccupiedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:12:32'!
receive: aGuestType in: aRoom 
	
	aRoom receiveWhenOccupied: aGuestType ! !

!OccupiedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:16:16'!
receiveWithReservation: aGuestType in: aRoom 
	
	aRoom receiveWithReservationWhenOccupied: aGuestType ! !

!OccupiedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:11:50'!
reserveIn: aRoom 
	
	aRoom reserveWhenOccupied! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OccupiedRoom class' category: #'ISW1-2024-1C-Parcial'!
OccupiedRoom class
	instanceVariableNames: ''!

!OccupiedRoom class methodsFor: 'instance creation' stamp: 'HAW 4/30/2024 16:11:12'!
with: aGuestType 
	
	^self new initializeWith: aGuestType ! !


!classDefinition: #ReservedRoom category: #'ISW1-2024-1C-Parcial'!
RoomStatus subclass: #ReservedRoom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Parcial'!

!ReservedRoom methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:19:50'!
isOccupied
	
	^true ! !

!ReservedRoom methodsFor: 'testing' stamp: 'HAW 4/30/2024 16:06:46'!
isReserved
	
	^true ! !


!ReservedRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:39:00'!
lossUsing: aPriceList ifAbsentGuestType: absentBlock 
	
	^0*peso! !

!ReservedRoom methodsFor: 'accounting' stamp: 'HAW 4/30/2024 16:26:35'!
profitUsing: aPriceList ifAbsentGuestType: unknownGuestTypeBlock 
	
	^ aPriceList values min / 2 ! !


!ReservedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:13:24'!
receive: aGuestType in: aRoom 
	
	aRoom receiveWhenReserved: aGuestType ! !

!ReservedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:15:00'!
receiveWithReservation: aGuestType in: aRoom 
	
	aRoom receiveWithReservationWhenReserved: aGuestType ! !

!ReservedRoom methodsFor: 'guests' stamp: 'HAW 4/30/2024 16:08:58'!
reserveIn: aRoom 
	
	aRoom reserveWhenReserved! !
