!classDefinition: #CalendarTest category: #Calendar!
TestCase subclass: #CalendarTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test01CalendarIsFreeWhenHasNoEvents

	| calendar |
	
	calendar := IndividualCalendar new.
	
	self assert: (calendar isFreeAt: January /1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test02CalendarIsNotFreeForSameDateAndTimeAsAnEvent

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (OneTimeEvent at:  January /1/2019 from: 10:00 to: 11:00).
	
	self deny: (calendar isFreeAt: January /1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test03CalendarIsFreeWhenDateIsDifferentToEventDate

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar  addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /2/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test04CalendarIsFreeWhenEndTimeIsBeforeOrEqualToEventStartTime

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar  addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /1/2019 from: 9:00 to: 10:00)! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test05CalendarIsFreeWhenStartTimeIsAfterOrEqualToEventEndTime

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar  addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /1/2019 from: 11:00 to: 12:00)! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test06CalendarIsNotFreeWhenSameDateAndTimeForRepeatedEvent

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self deny: (calendar isFreeAt: January /1/2019 from: 10:00 to: 11:00).
	self deny: (calendar isFreeAt: January /3/2019 from: 10:00 to: 11:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test07CalendarIsFreeWhenDateIsBeforeRepeatedEventStartDate

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: December /31/2018 from: 10:00 to: 11:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test08CalendarIsFreeWhenDateIsAfterRepeatedEventEndDate

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /4/2019 from: 10:00 to: 11:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test09CalendarIsFreeWhenDateIsNotIncludedInRepeatedEventDateInterval

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /2/2019 from: 10:00 to: 11:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test10CalendarIsFreeWhenEndTimeIsBeforeOrEqualToRepeatedEventStartTime

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /1/2019 from: 9:00 to: 10:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test11CalendarIsFreeWhenStartTimeIsAfterOrEqualToRepeatedEventEndTime

	| calendar |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent at: January /1/2019 repeatedEvery: 2*day upTo: January /3/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January /1/2019 from: 11:00 to: 12:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:44:27'!
test12TeamCalendarIsFreeWhenItHasNoCalendars

	| calendar |
	
	calendar := TeamCalendar new.
	
	self assert: (calendar isFreeAt: January /1/2019 from: 11:00 to: 12:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test13TeamCalendarIsNotFreeWhenAtLeastOneOfItsCalendarsIsNotFree

	| calendar individualCalendar |
	
	calendar := TeamCalendar new.
	individualCalendar := IndividualCalendar new.
	individualCalendar addEvent: (OneTimeEvent at: January /1/2019 from: 11:00 to: 12:00).
	calendar add: individualCalendar.
	
	self deny: (calendar isFreeAt: January /1/2019 from: 11:00 to: 12:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:05'!
test14EventsAddedToTeamCalendarAreAddedToItsCalendars

	| calendar individualCalendar |
	
	calendar := TeamCalendar new.
	individualCalendar := IndividualCalendar new.
	calendar add: individualCalendar.
	calendar addEvent: (OneTimeEvent at: January /1/2019 from: 11:00 to: 12:00).
	
	self deny: (calendar isFreeAt: January /1/2019 from: 11:00 to: 12:00).
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:06:33'!
test15FindsTheFirstSpotWhenCalendarHasNoEvents

	| calendar freeSpot |
	
	calendar := IndividualCalendar new.
	
	freeSpot := calendar findSpotFrom: January /1/2019 to: January /2/2019 startingAt: 10:00 orAsLateAs: 12:00 of: 1*hour ifNone: [self fail].
	
	self assert: (freeSpot isAt: January /1/2019 from: 10:00 to: 11:00)
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:06:33'!
test16FindsASpotInFollowingDays

	| calendar freeSpot |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 12:00).
	
	freeSpot := calendar findSpotFrom: January /1/2019 to: January /2/2019 startingAt: 10:00 orAsLateAs: 11:00 of: 1*hour ifNone: [self fail].
	
	self assert: (freeSpot isAt: January /2/2019 from: 10:00 to: 11:00)
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:06:33'!
test17FindsASpotInFollowingTime

	| calendar freeSpot |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 11:00).
	
	freeSpot := calendar findSpotFrom: January /1/2019 to: January /2/2019 startingAt: 10:00 orAsLateAs: 12:00 of: 1*hour ifNone: [self fail].
	
	self assert: (freeSpot isAt: January /1/2019 from: 11:00 to: 12:00)
	! !

!CalendarTest methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:07:21'!
test18NoSpotIsFoundWhenCalendarIsNotFree

	| calendar found |
	
	found := false.
	calendar := IndividualCalendar new.
	calendar addEvent: (OneTimeEvent at: January /1/2019 from: 10:00 to: 12:00).
	calendar addEvent: (OneTimeEvent at: January /2/2019 from: 10:00 to: 12:00).
	
	calendar findSpotFrom: January /1/2019 to: January /2/2019 startingAt: 10:00 orAsLateAs: 11:00 of: 1*hour ifNone: [found := true].
	
	self assert: found.! !


!classDefinition: #Calendar category: #Calendar!
Object subclass: #Calendar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!Calendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:33'!
addEvent: anEvent

	self subclassResponsibility ! !

!Calendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:14:23'!
findSpotFrom: aStartDate to: anEndDate startingAt: aStartingTime orAsLateAs: aLatestStartTime of: aLenght ifNone: noneBlock  
	
	^(CalendarSpotFinder on: self from: aStartDate to: anEndDate startingAt: aStartingTime orAsLateAs: aLatestStartTime of: aLenght) valueIfNone: noneBlock
! !

!Calendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:52:43'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility ! !


!classDefinition: #IndividualCalendar category: #Calendar!
Calendar subclass: #IndividualCalendar
	instanceVariableNames: 'events'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!IndividualCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:49:26'!
addEvent: anEvent

	events add: anEvent ! !

!IndividualCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:18:07'!
initialize

	events := OrderedCollection new.! !

!IndividualCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:24:03'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^events allSatisfy: [ :anEvent | anEvent isFreeAt: aDate from: aStartTime to: anEndTime ]! !


!classDefinition: #TeamCalendar category: #Calendar!
Calendar subclass: #TeamCalendar
	instanceVariableNames: 'calendars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!TeamCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:45:58'!
add: aCalendar 
	
	calendars add: aCalendar ! !

!TeamCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:50:28'!
addEvent: anEvent

	calendars do: [:aCalendar | aCalendar addEvent: anEvent ]! !

!TeamCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:46:16'!
initialize

	calendars := OrderedCollection new.! !

!TeamCalendar methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:46:54'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^calendars allSatisfy: [ :aCalendar | aCalendar isFreeAt: aDate from: aStartTime to: anEndTime ]! !


!classDefinition: #CalendarEvent category: #Calendar!
Object subclass: #CalendarEvent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:43:39'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility ! !


!classDefinition: #OneTimeEvent category: #Calendar!
CalendarEvent subclass: #OneTimeEvent
	instanceVariableNames: 'date startTime endTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!OneTimeEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:25:27'!
intitializeAt: aDate from: aStartTime to: anEndTime

	date := aDate.
	startTime := aStartTime.
	endTime := anEndTime ! !

!OneTimeEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 21:52:09'!
isAt: aDate from: aStartingTime to: anEndTime

	^date = aDate and: [startTime = aStartingTime and: [ endTime = anEndTime ]]! !

!OneTimeEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:30:08'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^aDate ~= date or: [ anEndTime <= startTime or: [ aStartTime >= endTime ]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OneTimeEvent class' category: #Calendar!
OneTimeEvent class
	instanceVariableNames: ''!

!OneTimeEvent class methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:24:49'!
at: aDate from: aStartTime to: anEndTime

	^self new intitializeAt: aDate from: aStartTime to: anEndTime! !


!classDefinition: #RepeatedEvent category: #Calendar!
CalendarEvent subclass: #RepeatedEvent
	instanceVariableNames: 'startTime endTime dateInterval'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!RepeatedEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:39:36'!
initializeAt: aStartDate repeatedEvery: aStep upTo: anEndDate from: aStartTime to: anEndTime

	dateInterval := aStartDate to: anEndDate by: aStep.
	
	startTime := aStartTime.
	endTime := anEndTime ! !

!RepeatedEvent methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:41:55'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^(dateInterval includes: aDate) not 
		or: [ anEndTime <= startTime 
		or: [ aStartTime >= endTime ]]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RepeatedEvent class' category: #Calendar!
RepeatedEvent class
	instanceVariableNames: ''!

!RepeatedEvent class methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 20:33:42'!
at: aStartDate repeatedEvery: aStep upTo: anEndDate from: aStartTime to: anEndTime

	^self new initializeAt: aStartDate repeatedEvery: aStep upTo: anEndDate from: aStartTime to: anEndTime! !


!classDefinition: #CalendarSpotFinder category: #Calendar!
Object subclass: #CalendarSpotFinder
	instanceVariableNames: 'startDate endDate startTime latestStartTime length calendar currentDate currentStartTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:21:04'!
calculateNextDateAndStartTimeIfNone: noneBlock
	  
	self calculateNextTime.
	self calculateNextDateIfNone: noneBlock ! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:20:09'!
calculateNextDateIfNone: noneBlock 

	currentStartTime > latestStartTime ifTrue: [self startOnNextDateIfNone: noneBlock]! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:18:47'!
calculateNextTime
	
	currentStartTime := currentStartTime next: 1*hour.! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:15:32'!
initializeOn: aCalendar from: aStartDate to: anEndDate startingAt: aStartingTime orAsLateAs: aLatestStartTime of: aLenght

	calendar := aCalendar.
	startDate := aStartDate.
	endDate := anEndDate.
	startTime := aStartingTime.
	latestStartTime := aLatestStartTime.
	length := aLenght ! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:20:47'!
isCalendarFreeAtCurrentDateAndStartTime

	^calendar isFreeAt: currentDate from: currentStartTime to: (currentStartTime next: length) ! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:19:46'!
startOnNextDateIfNone: noneBlock

	currentStartTime := startTime.
	currentDate := currentDate next.
	currentDate > endDate ifTrue: [^noneBlock value ]! !

!CalendarSpotFinder methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:21:04'!
valueIfNone: noneBlock

	currentDate := startDate.
	currentStartTime := startTime.
	
	[self isCalendarFreeAtCurrentDateAndStartTime]
		whileFalse: [self calculateNextDateAndStartTimeIfNone: noneBlock].
		
	^OneTimeEvent at: currentDate from: currentStartTime to: (currentStartTime next: length) ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CalendarSpotFinder class' category: #Calendar!
CalendarSpotFinder class
	instanceVariableNames: ''!

!CalendarSpotFinder class methodsFor: 'as yet unclassified' stamp: 'HAW 7/10/2019 22:15:24'!
on: aCalendar from: aStartDate to: anEndDate startingAt: aStartingTime orAsLateAs: aLatestStartTime of: aLenght

	^self new initializeOn: aCalendar from: aStartDate to: anEndDate startingAt: aStartingTime orAsLateAs: aLatestStartTime of: aLenght! !
