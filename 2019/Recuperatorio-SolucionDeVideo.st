!classDefinition: #FastFoodStoreTest category: #'Recu-1c2019'!
TestCase subclass: #FastFoodStoreTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:26:05'!
test01EmployeeDoesNotWorkWhenSheetIsEmpty

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:28:13'!
test02EmployeeWorksOnDateAndTimeOfWorkingHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self assert: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:39:28'!
test03EmployeeWorksOnDateAndTimeOfDayOfWeekInterval

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self assert: (employeeWorkingHoursSheet worksOn: July/19/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:37:35'!
test04EmployeeDoesNotWorkOnDateIncludedInDayOfWeekIntervalOfDifferentWeek

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/22/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:40:24'!
test05EmployeeDoesNotWorkOnHourBeforeStartingHourOfWorkingDate

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 7:59:59)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:44:05'!
test06EmployeeWorksOnHourBetweenStartingHourAndEndingHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self assert: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 15:59:59)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:43:08'!
test07EmployeeDoesNotWorkOnEndingHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 from: Monday to: Friday startingAt: 8:00 endingAt: 16:00.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 16:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:50:31'!
test08EmployeeWorkOnDateAndTimeIncludedInWokingHours

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self assert: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:54:14'!
test09EmployeeDoesNotWorkOnDayOfWeekNotIncludedInWorkingHours

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/16/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:56:07'!
test10EmployeeDoesNotWorkOnDayOfWeekIncludedInWorkingHoursButOfDifferentWeek

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/22/2019 at: 8:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 10:58:11'!
test11EmployeeDoesNotWorkOnHourBeforeStaringHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 7:59:59)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 11:00:22'!
test12EmployeeWorksOnHourBeforeEndingHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self assert: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 15:59:59)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 11:01:08'!
test13EmployeeDoesNotWorksOnEndingHour

	| employeeWorkingHoursSheet |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet worksOnWeekStarting: July/15/2019 forAll: { Monday -> (8:00 to: 16:00) }.
	
	self deny: (employeeWorkingHoursSheet worksOn: July/15/2019 at: 16:00)! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 14:15:11'!
test14ThereAreNoNonWorkingHoursWhenEmployeesWorkAllHours

	| employeeWorkingHoursSheet fastFoodStore |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet 
		worksOnWeekStarting: July/15/2019 from: Monday to: Sunday startingAt: 7:00 endingAt: 23:00.
	
	fastFoodStore := FastFoodStore withAll: { employeeWorkingHoursSheet }.
	
	self assert: (fastFoodStore nonWorkingHoursOfWeekStartingAt: July/15/2019) isEmpty! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 14:18:14'!
test15NonWorkingHoursOfADate

	| employeeWorkingHoursSheet fastFoodStore nonWorkingHours |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet 
		worksOnWeekStarting: July/15/2019 from: Monday to: Monday startingAt: 8:00 endingAt: 22:00;
		worksOnWeekStarting: July/15/2019 from: Tuesday to: Sunday startingAt: 7:00 endingAt: 23:00.
	
	fastFoodStore := FastFoodStore withAll: { employeeWorkingHoursSheet }.
	nonWorkingHours := fastFoodStore nonWorkingHoursOfWeekStartingAt: July/15/2019.
	
	self assert: 2 equals: nonWorkingHours size.
	self assert: (nonWorkingHours includes: (July/15/2019 at: 7:00)).
	self assert: (nonWorkingHours includes: (July/15/2019 at: 22:00)).
	! !

!FastFoodStoreTest methodsFor: 'tests' stamp: 'HAW 7/15/2019 14:23:06'!
test16NonWorkingHoursAWeek

	| employeeWorkingHoursSheet fastFoodStore nonWorkingHours |

	employeeWorkingHoursSheet := EmployeeWorkingHoursSheet of: 'Ana Perez'.
	employeeWorkingHoursSheet 
		worksOnWeekStarting: July/15/2019 from: Monday to: Saturday startingAt: 7:00 endingAt: 23:00;
		worksOnWeekStarting: July/15/2019 from: Sunday to: Sunday startingAt: 7:00 endingAt: 22:00.
	
	fastFoodStore := FastFoodStore withAll: { employeeWorkingHoursSheet }.
	nonWorkingHours := fastFoodStore nonWorkingHoursOfWeekStartingAt: July/15/2019.
	
	self assert: 1 equals: nonWorkingHours size.
	self assert: (nonWorkingHours includes: (July/21/2019 at: 22:00)).
	! !


!classDefinition: #EmployeeWorkingHoursSheet category: #'Recu-1c2019'!
Object subclass: #EmployeeWorkingHoursSheet
	instanceVariableNames: 'employee workingHours'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!EmployeeWorkingHoursSheet methodsFor: 'adding working hours' stamp: 'HAW 7/15/2019 10:52:12'!
worksOnWeekStarting: aWeekStartDate forAll: aWorkingHoursPerDayOfWeek 
	
	workingHours add: (PerDayOfWeekWorkingHours forWeekStartingOn: aWeekStartDate forAll: aWorkingHoursPerDayOfWeek)! !

!EmployeeWorkingHoursSheet methodsFor: 'adding working hours' stamp: 'HAW 7/15/2019 12:04:24'!
worksOnWeekStarting: aWeekStartDate from: aStartingDayOfWeek to: anEndingDayOfWeek startingAt: anStartingTime endingAt: anEndingTime

	workingHours add: (DayOfWeekIntervalWorkingHours forWeekStartingOn: aWeekStartDate from: aStartingDayOfWeek to: anEndingDayOfWeek startingAt: anStartingTime endingAt: anEndingTime)! !


!EmployeeWorkingHoursSheet methodsFor: 'initialization' stamp: 'HAW 7/15/2019 10:30:23'!
initializeOf: anEmployee 

	employee := anEmployee.
	workingHours := OrderedCollection new! !


!EmployeeWorkingHoursSheet methodsFor: 'testing' stamp: 'HAW 7/15/2019 10:32:28'!
worksOn: aDate at: aTime
	
	^workingHours anySatisfy: [ :aWorkingHours | aWorkingHours worksOn: aDate at: aTime ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmployeeWorkingHoursSheet class' category: #'Recu-1c2019'!
EmployeeWorkingHoursSheet class
	instanceVariableNames: ''!

!EmployeeWorkingHoursSheet class methodsFor: 'instance creation' stamp: 'HAW 7/15/2019 10:25:09'!
of: anEmployee

	^self new initializeOf: anEmployee ! !


!classDefinition: #FastFoodStore category: #'Recu-1c2019'!
Object subclass: #FastFoodStore
	instanceVariableNames: 'workingHoursSheet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!FastFoodStore methodsFor: 'initialization' stamp: 'HAW 7/15/2019 14:16:06'!
initializeWithAll: anEmployeesWorkingHoursSheet

	workingHoursSheet := anEmployeesWorkingHoursSheet ! !


!FastFoodStore methodsFor: 'non working hours' stamp: 'HAW 7/15/2019 14:26:23'!
nonWorkingHourOf: aDateOfWeek
		
	^((aDateOfWeek at: 7:00) to: (aDateOfWeek at: 22:00) by: 1*hour) 
			reject: [:aDateTime | self hasEmployeeWorkingAt: aDateTime ]! !

!FastFoodStore methodsFor: 'non working hours' stamp: 'HAW 7/15/2019 14:26:41'!
nonWorkingHoursOfWeekStartingAt: aStartWeekDate

	^(self weekDatesOf: aStartWeekDate)
		inject: OrderedCollection new
		into: [ :nonWorkingHours :aDateOfWeek |
			nonWorkingHours addAll: (self nonWorkingHourOf: aDateOfWeek).
			nonWorkingHours ]! !

!FastFoodStore methodsFor: 'non working hours' stamp: 'HAW 7/15/2019 14:26:49'!
weekDatesOf: aStartWeekDate
		
	^aStartWeekDate to: (aStartWeekDate next: 6*day)! !


!FastFoodStore methodsFor: 'testing' stamp: 'HAW 7/15/2019 14:21:17'!
hasEmployeeWorkingAt: aDateTime

	^workingHoursSheet anySatisfy: [ :aWorkingHoursSheet | 
		aWorkingHoursSheet worksOn: aDateTime date at: aDateTime timeOfDay ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FastFoodStore class' category: #'Recu-1c2019'!
FastFoodStore class
	instanceVariableNames: ''!

!FastFoodStore class methodsFor: 'instance creation' stamp: 'HAW 7/15/2019 14:15:51'!
withAll: anEmployeesWorkingHoursSheet

	^self new initializeWithAll: anEmployeesWorkingHoursSheet
! !


!classDefinition: #WorkingHours category: #'Recu-1c2019'!
Object subclass: #WorkingHours
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!WorkingHours methodsFor: 'testing' stamp: 'HAW 7/15/2019 12:04:54'!
worksOn: aDate at: aTime

	self subclassResponsibility ! !


!classDefinition: #DayOfWeekIntervalWorkingHours category: #'Recu-1c2019'!
WorkingHours subclass: #DayOfWeekIntervalWorkingHours
	instanceVariableNames: 'startHour endHour workingDates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!DayOfWeekIntervalWorkingHours methodsFor: 'initialization' stamp: 'HAW 7/15/2019 10:48:14'!
initializeForWeekStartingOn: aWeekStartDate from: aStartingDayOfWeek to: anEndingDayOfWeek startingAt: anStartingTime endingAt: anEndingTime

	| weekDaysInterval |
	
	weekDaysInterval := aStartingDayOfWeek to: anEndingDayOfWeek.
	workingDates := (aWeekStartDate to: (aWeekStartDate next: 6*day)) select: [ :aWeekDate |
		weekDaysInterval includes: aWeekDate day ].
	
	startHour := anStartingTime.
	endHour := anEndingTime ! !


!DayOfWeekIntervalWorkingHours methodsFor: 'testing' stamp: 'HAW 7/15/2019 10:46:59'!
worksOn: aDate at: aTime

	^(workingDates includes: aDate)
		and: [ aTime between: startHour andNotInclusive: endHour ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DayOfWeekIntervalWorkingHours class' category: #'Recu-1c2019'!
DayOfWeekIntervalWorkingHours class
	instanceVariableNames: ''!

!DayOfWeekIntervalWorkingHours class methodsFor: 'instance creation' stamp: 'HAW 7/15/2019 10:30:43'!
forWeekStartingOn: aWeekStartDate from: aStartingDayOfWeek to: anEndingDayOfWeek startingAt: anStartingTime endingAt: anEndingTime

	^self new initializeForWeekStartingOn: aWeekStartDate from: aStartingDayOfWeek to: anEndingDayOfWeek startingAt: anStartingTime endingAt: anEndingTime! !


!classDefinition: #PerDayOfWeekWorkingHours category: #'Recu-1c2019'!
WorkingHours subclass: #PerDayOfWeekWorkingHours
	instanceVariableNames: 'workingHoursPerDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Recu-1c2019'!

!PerDayOfWeekWorkingHours methodsFor: 'initialization' stamp: 'HAW 7/15/2019 12:03:54'!
initializeForWeekStartingOn: aWeekStartDate forAll: aWorkingHoursPerDayOfWeek

	workingHoursPerDate := Dictionary new.
	aWorkingHoursPerDayOfWeek do: [ :aDayOfWeekWorkingHours |
		workingHoursPerDate 
			at: (aWeekStartDate previous nextDay: aDayOfWeekWorkingHours key)
			put: aDayOfWeekWorkingHours value ].
	
! !


!PerDayOfWeekWorkingHours methodsFor: 'testing' stamp: 'HAW 7/15/2019 12:05:29'!
worksOn: aDate at: aTime

	^workingHoursPerDate
		at: aDate 
		ifPresent: [ :workingHours | aTime between: workingHours first  andNotInclusive: workingHours last ]
		ifAbsent: [ false ]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PerDayOfWeekWorkingHours class' category: #'Recu-1c2019'!
PerDayOfWeekWorkingHours class
	instanceVariableNames: ''!

!PerDayOfWeekWorkingHours class methodsFor: 'instance creation' stamp: 'HAW 7/15/2019 14:08:40'!
forWeekStartingOn: aWeekStartDate forAll: aWorkingHoursPerDayOfWeek

	^self new initializeForWeekStartingOn: aWeekStartDate forAll: aWorkingHoursPerDayOfWeek! !
