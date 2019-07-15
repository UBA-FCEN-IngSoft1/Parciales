!classDefinition: #CalendarTest category: #Calendar!
TestCase subclass: #CalendarTest
	instanceVariableNames: 'calendar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test01IndividualCalendarWithoutEventsIsFreeAtAnyMoment

	calendar := IndividualCalendar new.
	
	self assert: (calendar isFreeAt: January/1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test02IndividualCalendarIsNotFreeAtAFixedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	
	self deny: (calendar isFreeAt: January/1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test03IndividualCalendarIsFreeAtASpotBeforeAFixedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January/1/2019 from: 9:00 to: 10:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test04IndividualCalendarIsFreeAtASpotAfterAFixedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January/1/2019 from: 11:00 to: 12:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test05IndividualCalendarIsFreeAtASpotInADifferentDateOfAFixedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	
	self assert: (calendar isFreeAt: January/2/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test06IndividualCalendarIsNotFreeAtARepeatedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent every: 1*day startingAt: January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019).
	
	self deny: (calendar isFreeAt: January/1/2019 from: 10:00 to: 11:00).
	self deny: (calendar isFreeAt: January/2/2019 from: 10:00 to: 11:00).! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test07IndividualCalendarIsFreeAtASpotBeforeRepeatedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent every: 1*day startingAt: January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019).
	
	self assert: (calendar isFreeAt: January/1/2019 from: 9:00 to: 10:00).
	self assert: (calendar isFreeAt: January/2/2019 from: 9:00 to: 10:00).
! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test08IndividualCalendarIsFreeAtASpotBeforeRepeatedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent every: 1*day startingAt: January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019).
	
	self assert: (calendar isFreeAt: January/1/2019 from: 11:00 to: 12:00).
	self assert: (calendar isFreeAt: January/2/2019 from: 11:00 to: 12:00).
! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:09:27'!
test09IndividualCalendarIsFreeAtASpotInADateNotInTheRepeatedEvent

	calendar := IndividualCalendar new.
	calendar addEvent: (RepeatedEvent every: 1*day startingAt: January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019).
	
	self assert: (calendar isFreeAt: December/31/2018 from: 10:00 to: 11:00).
	self assert: (calendar isFreeAt: January/3/2019 from: 10:00 to: 11:00).
! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:26:06'!
test10CanNotCreateAFixedEventWithAnEmptyTimeSpot

	self 
		should: [ FixedEvent at: January/1/2019 from: 12:00 to: 11:00 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TimeSpot invalidTimeIntervalErrorDescription
		 ! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:26:33'!
test11CanNotCreateARepeatedEventWithAnEmptyTimeSpot

	self 
		should: [ RepeatedEvent every: 1*day startingAt:  January/1/2019 from: 12:00 to: 11:00 upTo: January/2/2019 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: TimeSpot invalidTimeIntervalErrorDescription
		 ! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:25:56'!
test12CanNotCreateARepeatedEventWithAStepLessThanADay

	self 
		should: [ RepeatedEvent every: 23*hour+(59*minute) startingAt:  January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RepeatedEvent invalidStepErrorDescription
		 ! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:25:40'!
test13CanNotCreateARepeatedEventWithAStepLessThanADay

	self 
		should: [ RepeatedEvent every: 1.5*day startingAt:  January/1/2019 from: 10:00 to: 11:00 upTo: January/2/2019 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: RepeatedEvent invalidStepAmountErrorDescription
		 
		
	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/1/2019 16:28:29'!
test14CanNotCreateARepeatedEventWithAnEmptyDateInterval

	self 
		should: [ RepeatedEvent every: 1*day startingAt:  January/2/2019 from: 10:00 to: 11:00 upTo: January/1/2019 ]
		raise: InvalidIntervalException - MessageNotUnderstood 
	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 15:58:21'!
test15TeamCalendarIsFreeWithoutCalendars

	calendar := TeamCalendar new.
	
	self assert: (calendar isFreeAt: January/1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:00:58'!
test16TeamCalendarIsNotFreeWhenOneOfItsCalendarIsNotFree

	| individualCalendar |
	
	calendar := TeamCalendar new.
	individualCalendar := IndividualCalendar new.
	individualCalendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	calendar addCalendar: individualCalendar.
	
	self deny: (calendar isFreeAt: January/1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:03:45'!
test17AddingAnEventToATeamCalendarAddsItToItsIndividualCalendars

	| individualCalendar |
	
	calendar := TeamCalendar new.
	individualCalendar := IndividualCalendar new.
	calendar addCalendar: individualCalendar.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	
	self deny: (individualCalendar isFreeAt: January/1/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:14:28'!
test18FindsTheFirstSpotWhenCalendarIsFreeAtIt

	| spotFinder spot |
	
	calendar := IndividualCalendar new.
	spotFinder := CalendarSpotFinder on: calendar from: January/1/2019 to: January/1/2019 startingAt: 10:00 of: 1*hour asLateAs: 11:00.
	
	spot := spotFinder findIfNone: [ self fail ].
	
	self assert: (spot isAt: January/1/2019 from: 10:00 to: 11:00)
	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:15:56'!
test19FindsTheNextFreeSpotOnSameDateWhenCalendarIsFreeAtIt

	| spotFinder spot |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 11:00).
	spotFinder := CalendarSpotFinder on: calendar from: January/1/2019 to: January/1/2019 startingAt: 10:00 of: 1*hour asLateAs: 12:00.
	
	spot := spotFinder findIfNone: [ self fail ].
	
	self assert: (spot isAt: January/1/2019 from: 11:00 to: 12:00)
	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:23:53'!
test20StopsLookingWhenStartDateIsAfterLatestStart

	| spotFinder |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 12:00).
	spotFinder := CalendarSpotFinder on: calendar from: January/1/2019 to: January/1/2019 startingAt: 10:00 of: 1*hour asLateAs: 11:00.
	
	spotFinder findIfNone: [ ^self ].
	
	self failWith: 'Should not have found a spot'	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/2/2019 16:28:51'!
test21LoopsOnNextDateWhenNoSpotFoundOnCurrentDate

	| spotFinder spot |
	
	calendar := IndividualCalendar new.
	calendar addEvent: (FixedEvent at: January/1/2019 from: 10:00 to: 12:00).
	spotFinder := CalendarSpotFinder on: calendar from: January/1/2019 to: January/2/2019 startingAt: 10:00 of: 1*hour asLateAs: 11:00.
	
	spot := spotFinder findIfNone: [ self fail ].
	
	self assert: (spot isAt: January/2/2019 from: 10:00 to: 11:00)! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/3/2019 16:27:20'!
test22CanNotFindASpotWithInvalidDateInterval

	self
		should: [ CalendarSpotFinder on: IndividualCalendar new from: January/2/2019 to: January/1/2019 startingAt: 10:00 of: 1*hour asLateAs: 11:00 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CalendarSpotFinder invalidDateIntervalErrorMessage.
	! !

!CalendarTest methodsFor: 'tests' stamp: 'HAW 7/3/2019 16:30:46'!
test23CanNotFindASpotWithInvalidTimeInterval

	self
		should: [ CalendarSpotFinder on: IndividualCalendar new from: January/1/2019 to: January/2/2019 startingAt: 12:00 of: 1*hour asLateAs: 11:00 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: CalendarSpotFinder invalidTimeIntervalErrorMessage.
	! !


!classDefinition: #Calendar category: #Calendar!
Object subclass: #Calendar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!Calendar methodsFor: 'events' stamp: 'HAW 7/2/2019 16:04:52'!
addEvent: anEvent

	self subclassResponsibility ! !


!Calendar methodsFor: 'testing' stamp: 'HAW 7/2/2019 16:05:06'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility ! !


!classDefinition: #IndividualCalendar category: #Calendar!
Calendar subclass: #IndividualCalendar
	instanceVariableNames: 'events'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!IndividualCalendar methodsFor: 'events' stamp: 'HAW 7/1/2019 15:37:21'!
addEvent: anEvent

	events add: anEvent ! !


!IndividualCalendar methodsFor: 'initialization' stamp: 'HAW 7/1/2019 15:37:37'!
initialize

	events := OrderedCollection new! !


!IndividualCalendar methodsFor: 'testing' stamp: 'HAW 7/1/2019 16:09:27'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^events allSatisfy: [ :anEvent | anEvent isFreeAt: aDate from: aStartTime to: anEndTime ]! !


!classDefinition: #TeamCalendar category: #Calendar!
Calendar subclass: #TeamCalendar
	instanceVariableNames: 'calendars'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!TeamCalendar methodsFor: 'calendar management' stamp: 'HAW 7/2/2019 16:01:42'!
addCalendar: aCalendar

	calendars add: aCalendar ! !


!TeamCalendar methodsFor: 'events' stamp: 'HAW 7/2/2019 16:04:16'!
addEvent: anEvent

	calendars do: [ :aCalendar | aCalendar addEvent: anEvent ]! !


!TeamCalendar methodsFor: 'initialization' stamp: 'HAW 7/2/2019 16:01:16'!
initialize

	calendars := OrderedCollection new.! !


!TeamCalendar methodsFor: 'testing' stamp: 'HAW 7/2/2019 16:02:16'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^calendars allSatisfy: [ :aCalendar | aCalendar isFreeAt: aDate from: aStartTime to: anEndTime ]! !


!classDefinition: #CalendarEvent category: #Calendar!
Object subclass: #CalendarEvent
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarEvent methodsFor: 'testing' stamp: 'HAW 7/1/2019 16:12:20'!
isFreeAt: aDate from: aStartTime to: anEndTime

	self subclassResponsibility ! !


!classDefinition: #FixedEvent category: #Calendar!
CalendarEvent subclass: #FixedEvent
	instanceVariableNames: 'date timeSpot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!FixedEvent methodsFor: 'testing' stamp: 'HAW 7/2/2019 16:13:10'!
isAt: aDate from: aStartTime to: anEndTime

	^ date = aDate and: [ timeSpot isFrom: aStartTime to: anEndTime ]! !

!FixedEvent methodsFor: 'testing' stamp: 'HAW 7/1/2019 16:11:47'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^aDate ~= date or: [ timeSpot isFreeFrom: aStartTime to: anEndTime ]! !


!FixedEvent methodsFor: 'initialization' stamp: 'HAW 7/1/2019 16:17:23'!
initializeAt: aDate timeSpot: aTimeSpot 
	
	date := aDate.
	timeSpot := aTimeSpot ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FixedEvent class' category: #Calendar!
FixedEvent class
	instanceVariableNames: ''!

!FixedEvent class methodsFor: 'instance creation' stamp: 'HAW 7/1/2019 16:15:49'!
at: aDate from: aStartTime to: anEndTime

	^self new initializeAt: aDate timeSpot: (TimeSpot from: aStartTime to: anEndTime)! !


!classDefinition: #RepeatedEvent category: #Calendar!
CalendarEvent subclass: #RepeatedEvent
	instanceVariableNames: 'dates timeSpot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!RepeatedEvent methodsFor: 'initialization' stamp: 'HAW 7/1/2019 16:19:06'!
initializeEvery: aStep startingAt: aStartingDate upTo: anEndDate timeSpot: aTimeSpot

	dates := aStartingDate to: anEndDate by: aStep.
	timeSpot := aTimeSpot! !


!RepeatedEvent methodsFor: 'testing' stamp: 'HAW 7/1/2019 16:11:14'!
isFreeAt: aDate from: aStartTime to: anEndTime

	^(dates includes: aDate) not or: [ timeSpot isFreeFrom: aStartTime to: anEndTime ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RepeatedEvent class' category: #Calendar!
RepeatedEvent class
	instanceVariableNames: ''!

!RepeatedEvent class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:25:40'!
assertStepAmountIsInteger: aStep

	aStep amount isInteger ifFalse: [ self error: self invalidStepAmountErrorDescription ]! !

!RepeatedEvent class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:25:56'!
assertStepIsOneDayOrMore: aStep

	aStep >= (1*day) ifFalse: [ self error: self invalidStepErrorDescription ]! !

!RepeatedEvent class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:27:30'!
invalidDateIntervalErrorDescription
	
	^'Start date has to be before end date'! !

!RepeatedEvent class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:25:40'!
invalidStepAmountErrorDescription
	
	^'Step amount must be integer'! !

!RepeatedEvent class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:25:56'!
invalidStepErrorDescription
	
	^'Repetition step has to be greater or equal to one day'! !


!RepeatedEvent class methodsFor: 'instance creation' stamp: 'HAW 7/1/2019 16:24:48'!
every: aStep startingAt: aStartingDate from: aStartingTime to: anEndTime upTo: anEndDate
 
	self assertStepIsOneDayOrMore: aStep.
	self assertStepAmountIsInteger: aStep.
	
	^self new initializeEvery: aStep startingAt: aStartingDate upTo: anEndDate timeSpot: (TimeSpot from: aStartingTime to: anEndTime)
! !


!classDefinition: #CalendarSpotFinder category: #Calendar!
Object subclass: #CalendarSpotFinder
	instanceVariableNames: 'calendar startDate endDate startTime length latestStartTime currentDate currentStartTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!CalendarSpotFinder methodsFor: 'finding - private' stamp: 'HAW 7/2/2019 16:38:15'!
calculateNextDateStartTimeIfAtEnd: aNoneClosure

	currentDate = endDate 
		ifTrue: [ ^ aNoneClosure value]
		ifFalse: [ 
			currentDate := currentDate next.
			currentStartTime := startTime ]! !

!CalendarSpotFinder methodsFor: 'finding - private' stamp: 'HAW 7/2/2019 16:34:45'!
calculateNextStartTime
		
	currentStartTime := currentStartTime next: 1*hour.
! !

!CalendarSpotFinder methodsFor: 'finding - private' stamp: 'HAW 7/2/2019 16:38:15'!
findNextSpotIfNone: aNoneClosure 

	self calculateNextStartTime.
	self hasPassedLatestStartTime ifTrue: [ self calculateNextDateStartTimeIfAtEnd: aNoneClosure ]! !

!CalendarSpotFinder methodsFor: 'finding - private' stamp: 'HAW 7/2/2019 16:35:17'!
hasPassedLatestStartTime
		
	^currentStartTime > latestStartTime! !

!CalendarSpotFinder methodsFor: 'finding - private' stamp: 'HAW 7/2/2019 16:33:20'!
isCalendarFreeAtCurrentSpot 
		
	^ calendar isFreeAt: currentDate from: currentStartTime to: (currentStartTime next: length) ! !


!CalendarSpotFinder methodsFor: 'initialization' stamp: 'HAW 7/2/2019 16:11:10'!
initializeOn: aCalendar from: aStartDate to: anEndDate startingAt: aStartTime of: aLength asLateAs: aLateStartTime

	calendar := aCalendar.
	startDate := aStartDate.
	endDate := anEndDate.
	startTime := aStartTime.
	length := aLength.
	latestStartTime := aLateStartTime ! !


!CalendarSpotFinder methodsFor: 'finding' stamp: 'HAW 7/2/2019 16:33:47'!
findIfNone: aNoneClosure

	currentDate := startDate.
	currentStartTime := startTime.
	
	[self isCalendarFreeAtCurrentSpot ] whileFalse: [self findNextSpotIfNone: aNoneClosure ].
	
	^FixedEvent at: currentDate from: currentStartTime to: (currentStartTime next: length).
	
		! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CalendarSpotFinder class' category: #Calendar!
CalendarSpotFinder class
	instanceVariableNames: ''!

!CalendarSpotFinder class methodsFor: 'instance creation' stamp: 'HAW 7/3/2019 16:28:56'!
on: aCalendar from: aStartDate to: anEndDate startingAt: aStartTime of: aLength asLateAs: aLateStartTime 

	self assertValidDateIntervalFrom: aStartDate to: anEndDate.
	self assertValidTimeIntervalFrom: aStartTime to: aLateStartTime.
	
	^self new initializeOn: aCalendar from: aStartDate to: anEndDate startingAt: aStartTime of: aLength asLateAs: aLateStartTime! !


!CalendarSpotFinder class methodsFor: 'assertions' stamp: 'HAW 7/3/2019 16:32:48'!
assertValidDateIntervalFrom: aStartDate to: anEndDate

	aStartDate > anEndDate ifTrue: [ self error: self invalidDateIntervalErrorMessage ]! !

!CalendarSpotFinder class methodsFor: 'assertions' stamp: 'HAW 7/3/2019 16:31:59'!
assertValidTimeIntervalFrom: aStartTime to: aLatestStartTime

	aStartTime > aLatestStartTime ifTrue: [ self error: self invalidTimeIntervalErrorMessage ]! !

!CalendarSpotFinder class methodsFor: 'assertions' stamp: 'HAW 7/3/2019 16:25:40'!
invalidDateIntervalErrorMessage
	
	^'Start date has to be before or equal to end date'! !

!CalendarSpotFinder class methodsFor: 'assertions' stamp: 'HAW 7/3/2019 16:28:17'!
invalidTimeIntervalErrorMessage
	
	^'Start time has to be before or equal to the latest possible start time'! !


!classDefinition: #TimeSpot category: #Calendar!
Object subclass: #TimeSpot
	instanceVariableNames: 'start end'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Calendar'!

!TimeSpot methodsFor: 'testing' stamp: 'HAW 7/1/2019 16:09:10'!
isFreeFrom: aStart to: anEnd

	^ aStart >= end or: [ anEnd <= start ]! !

!TimeSpot methodsFor: 'testing' stamp: 'HAW 7/2/2019 16:13:38'!
isFrom: aStart to: anEnd

	^ start = aStart and: [ end = anEnd ]! !


!TimeSpot methodsFor: 'initialization' stamp: 'HAW 7/1/2019 16:08:04'!
initializeFrom: aStart to: anEnd

	start := aStart.
	end := anEnd ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TimeSpot class' category: #Calendar!
TimeSpot class
	instanceVariableNames: ''!

!TimeSpot class methodsFor: 'instance creation' stamp: 'HAW 7/1/2019 16:16:08'!
from: aStart to: anEnd 
	
	self assert: aStart isBefore: anEnd.
	
	^self new initializeFrom: aStart to: anEnd! !


!TimeSpot class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:26:06'!
assert: aStart isBefore: anEnd

	aStart < anEnd ifFalse: [ self error: self invalidTimeIntervalErrorDescription ]! !

!TimeSpot class methodsFor: 'assertions' stamp: 'HAW 7/1/2019 16:26:06'!
invalidTimeIntervalErrorDescription
	
	^'Start time has to be before end time'! !
