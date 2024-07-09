!classDefinition: #ProjectTest category: #'ISW1-2024-1C-2doParcial'!
TestCase subclass: #ProjectTest
	instanceVariableNames: 'danIngalls'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 11:59:15'!
test01ConcreteTaskWithSameEffortAsDeveloperDedicationEndsOnStartingDate

	| ssaTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	
	self assert: (ssaTask endsOn: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 11:59:15'!
test02ConcreteTaskWithSameEffortAsDeveloperDedicationDoesNotEndDifferentDateAsStartingDate

	| ssaTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	
	self deny: (ssaTask endsOn: July/2/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:06:01'!
test03ConcreteTaskWithDifferentEffortAsDeveloperDedicationUsesWholeDaysToComplete

	| ssaTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 10*hour dependingOn: {}.
	
	self assert: (ssaTask endsOn: July/2/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:09:51'!
test04TeamTimeToIsTheSlowestDeveloperTimeToComplete

	| ssbTask |
	
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	
	self assert: (ssbTask endsOn: (July/1/2024 next: (16*hour/(6*hour/day)) ceiling) previous)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:17:01'!
test05ConcreteTaskWithoutDependentsStartsOnDesiredStartingDate

	| ssaTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	
	self assert: (ssaTask startsOn: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:17:47'!
test06ConcreteTaskWithoutDependentsDoesNotStartsOnDifferentDateAsDesiredStartingDate

	| ssaTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	
	self deny: (ssaTask startsOn: July/2/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:25:44'!
test07ConcreteTaskWithDependentsEndingAfterDesiredStartingDateStartsOnNextLastDependentEndDate

	| ssaTask ssbTask sscTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	sscTask := ConcreteTask named: 'SS C' startingOn: July/2/2024 developedBy: self alanKay taking: 16*hour dependingOn: {ssaTask. ssbTask }.
	
	self assert: (sscTask startsOn: ssbTask endDate next)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:25:36'!
test08ConcreteTaskWithDependentsEndingBeforeDesiredStartingDateStartsOnDesiredStartingDate

	| ssaTask sscTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	sscTask := ConcreteTask named: 'SS C' startingOn: July/3/2024 developedBy: self alanKay taking: 16*hour dependingOn: {ssaTask }.
	
	self assert: (sscTask startsOn: sscTask desiredStaringDate)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:34:59'!
test09ConcreteTaskEndDateUsesStartDateAndNotDesiredStartDate

	| ssaTask sscTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	sscTask := ConcreteTask named: 'SS C' startingOn: July/1/2024 developedBy: self danIngalls taking: 16*hour dependingOn: {ssaTask }.
	
	self assert: (sscTask endsOn: July/4/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:42:23'!
test10ProjectStartsOnFirstStartDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self assert: (modelProject startsOn: ssbTask startDate)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:43:02'!
test11ProjectDoesNotStartOnDifferentDateOfFirstStartDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self deny: (modelProject startsOn: ssbTask startDate next)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:43:50'!
test12ProjectEndsOnLastEndDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self assert: (modelProject endsOn: ssbTask endDate)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 12:44:35'!
test13ProjectDoesNotEndOnDifferentDateOfLastEndDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self deny: (modelProject endsOn: ssbTask endDate next)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:18:39'!
test14WhenDeveloperDoNotHaveOverworkProjectDoNotHaveOverwork

	| ssaTask modelProject modelWoorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask }.
	modelWoorksheet := modelProject worksheet.
	
	self deny: modelWoorksheet hasOverwork ! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:18:57'!
test15WhenADeveloperHasOverworkProjectHasOverwork

	| ssaTask modelProject ssbTask modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	self assert: modelWorksheet hasOverwork! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:19:53'!
test16DeveloperWithoutOneTasksOnSameDateHasNoOverwork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates isEmpty ! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:20:15'!
test17DeveloperWithMoreThanOneTaskOnSameDateHasOverwork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates size equals: 1.
	self assert: (danIngallsOverworkingDates includes: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:20:32'!
test18DeveloperWithoutWorkHasNoOveworkingDates

	| ssaTask modelProject ssbTask alanKayOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	alanKayOverworkingDates := modelWorksheet overworkingDatesOf: self alanKay .
	
	self assert: alanKayOverworkingDates isEmpty! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:20:51'!
test19TeamCanHaveDevelopersWithOverWork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 8*hour dependingOn: {}.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates size equals: 1.
	self assert: (danIngallsOverworkingDates includes: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/7/2024 13:25:17'!
test20ProjectCostIsTheSumOfEachDeveloperCostPerWorkingDates

	| ssaTask modelProject ssbTask eprProject sscTask uiTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	sscTask := ConcreteTask named: 'SS C' startingOn: July/2/2024 developedBy: self alanKay taking: 16*hour dependingOn: {ssaTask. ssbTask }.
	modelProject := Project named: 'Modelo' composedBy: { ssaTask. ssbTask. sscTask }.
	uiTask := ConcreteTask named: 'UI' startingOn: July/2/2024 developedBy: self adeleGoldberg taking: 6*hour dependingOn: { modelProject }.
	eprProject := Project named: 'EPR' composedBy: { modelProject. uiTask }.
	
	self assert: eprProject worksheet totalCost equals: 5450 * dollar! !


!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/7/2024 13:26:06'!
adeleGoldberg
	
	^Developer named: 'Adele Goldberg' thatWorks: 10*hour/day earning: 65*dollar/hour! !

!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/7/2024 12:10:56'!
alanKay
	
	^Developer named: 'Alan Kay' thatWorks: 6*hour/day earning: 80*dollar/hour! !

!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/7/2024 13:00:38'!
danIngalls

	danIngalls ifNil: [ danIngalls := Developer named: 'Dan Ingalls' thatWorks: 8*hour/day earning: 60*dollar/hour ].
	^danIngalls! !


!ProjectTest methodsFor: 'teams' stamp: 'HAW 7/7/2024 12:10:19'!
parcMobTeam
	
	^Team named: 'Parc Mob Team' composedBy: { self danIngalls. self alanKay }! !


!classDefinition: #Responsable category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Responsable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Responsable methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:30:37'!
addWorkingDates: aWorkingDates to: aWorksheet

	self subclassResponsibility! !


!Responsable methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:35:56'!
timeToComplete: anEffort

	self subclassResponsibility! !


!classDefinition: #Developer category: #'ISW1-2024-1C-2doParcial'!
Responsable subclass: #Developer
	instanceVariableNames: 'name dedication cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Developer methodsFor: 'initialization' stamp: 'HAW 7/7/2024 11:55:16'!
initializeNamed: aName thatWorks: aDedication earning: aCost 
	
	name := aName.
	dedication := aDedication.
	cost := aCost.! !


!Developer methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:10:37'!
addWorkingDates: aWorkingDates to: aWorksheet 
	
	aWorksheet addWorkingDates: aWorkingDates toDeveloper: self! !

!Developer methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:32:14'!
dailyCost
	
	^dedication * cost! !

!Developer methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:32:04'!
totalCostWorking: aWorkingDates 
	
	^aWorkingDates size * day * self dailyCost ! !


!Developer methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:06:37'!
timeToComplete: anEffort 
	
	^(anEffort / dedication) ceiling ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'ISW1-2024-1C-2doParcial'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 11:55:10'!
named: aName thatWorks: aDedication earning: aCost 
	
	^self new initializeNamed: aName thatWorks: aDedication earning: aCost ! !


!classDefinition: #Team category: #'ISW1-2024-1C-2doParcial'!
Responsable subclass: #Team
	instanceVariableNames: 'name responsables'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Team methodsFor: 'initialization' stamp: 'HAW 7/7/2024 12:11:30'!
initializeNamed: aName composedBy: aResponsables 
	
	name := aName.
	responsables := aResponsables.! !


!Team methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:14:59'!
addWorkingDates: aWorkingDates to: aWorksheet 
	
	responsables do: [ :aResponsable | aResponsable addWorkingDates: aWorkingDates to: aWorksheet ]! !


!Team methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:13:56'!
timeToComplete: anEffort 
	
	^responsables max: [ :aResponsable | aResponsable timeToComplete: anEffort ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'ISW1-2024-1C-2doParcial'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 12:11:22'!
named: aName composedBy: aResponsables 
	
	^self new initializeNamed: aName composedBy: aResponsables ! !


!classDefinition: #Task category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Task
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Task methodsFor: 'start date' stamp: 'HAW 7/7/2024 12:46:14'!
startDate

	self subclassResponsibility! !

!Task methodsFor: 'start date' stamp: 'HAW 7/7/2024 12:46:34'!
startsOn: aPotentialStaringDate 
	
	^aPotentialStaringDate = self startDate ! !


!Task methodsFor: 'end date' stamp: 'HAW 7/7/2024 12:45:46'!
endDate

	self subclassResponsibility! !

!Task methodsFor: 'end date' stamp: 'HAW 7/7/2024 12:46:00'!
endsOn: aPotentialEndDate 
	
	^aPotentialEndDate = self endDate! !


!Task methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:34:19'!
addWorkingDatesTo: aWorksheet

	self subclassResponsibility! !


!classDefinition: #ConcreteTask category: #'ISW1-2024-1C-2doParcial'!
Task subclass: #ConcreteTask
	instanceVariableNames: 'name desiredStartDate responsable dependents effort'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!ConcreteTask methodsFor: 'initialization' stamp: 'HAW 7/7/2024 11:59:53'!
initializeNamed: aName startingOn: aDesiredStartDate developedBy: aResponsable taking: anEffort dependingOn: aDependents 
	
	name := aName.
	desiredStartDate := aDesiredStartDate.
	responsable := aResponsable.
	effort := anEffort.
	dependents := aDependents.! !


!ConcreteTask methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:03:56'!
timeToComplete

	^ (responsable timeToComplete: effort) - (1*day)! !


!ConcreteTask methodsFor: 'end date' stamp: 'HAW 7/7/2024 12:32:23'!
endDate

	^ self startDate next: self timeToComplete! !

!ConcreteTask methodsFor: 'end date' stamp: 'HAW 7/7/2024 12:29:33'!
maxDependentsEndDate

	^ dependents max: [ :aDependent | aDependent endDate ]! !


!ConcreteTask methodsFor: 'start date' stamp: 'HAW 7/7/2024 12:25:59'!
desiredStaringDate
	
	^desiredStartDate ! !

!ConcreteTask methodsFor: 'start date' stamp: 'HAW 7/7/2024 13:54:20'!
startDate

	^ dependents 
		ifEmpty: [ desiredStartDate ]
		ifNotEmpty: [ self startDateWithDependents ]! !

!ConcreteTask methodsFor: 'start date' stamp: 'HAW 7/7/2024 13:54:20'!
startDateWithDependents

	^ self maxDependentsEndDate next max: desiredStartDate! !


!ConcreteTask methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:53:20'!
addWorkingDatesTo: aWorksheet 
	
	responsable addWorkingDates: self workingDates to: aWorksheet ! !

!ConcreteTask methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:53:15'!
workingDates

	^ self startDate to: self endDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcreteTask class' category: #'ISW1-2024-1C-2doParcial'!
ConcreteTask class
	instanceVariableNames: ''!

!ConcreteTask class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 11:59:42'!
named: aName startingOn: aDesiredStartDate developedBy: aResponsable taking: anEffort dependingOn: aDependents 
	
	^self new initializeNamed: aName startingOn: aDesiredStartDate developedBy: aResponsable taking: anEffort dependingOn: aDependents ! !


!classDefinition: #Project category: #'ISW1-2024-1C-2doParcial'!
Task subclass: #Project
	instanceVariableNames: 'name subtasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Project methodsFor: 'initialization' stamp: 'HAW 7/7/2024 12:38:45'!
initializeNamed: aName composedBy: aSubtasks 
	
	name := aName.
	subtasks := aSubtasks.! !


!Project methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:26:40'!
addWorkingDatesTo: aWorksheet 
	
	subtasks do: [ :aSubtask | aSubtask addWorkingDatesTo: aWorksheet ]! !

!Project methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:36:18'!
subtasksDo: aBlock 
	
	subtasks do: aBlock ! !

!Project methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:17:32'!
worksheet

	^ Worksheet of: self! !


!Project methodsFor: 'end date' stamp: 'HAW 7/7/2024 12:45:13'!
endDate
	
	^subtasks max: [ :aSubtask | aSubtask endDate ]! !


!Project methodsFor: 'start date' stamp: 'HAW 7/7/2024 12:41:10'!
startDate
	
	^subtasks min: [ :subtask | subtask startDate ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'ISW1-2024-1C-2doParcial'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 12:38:40'!
named: aName composedBy: aSubtasks 
	
	^self new initializeNamed: aName composedBy: aSubtasks ! !


!classDefinition: #Worksheet category: #'ISW1-2024-1C-2doParcial'!
Object subclass: #Worksheet
	instanceVariableNames: 'developersWorkingDates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-2doParcial'!

!Worksheet methodsFor: 'cost' stamp: 'HAW 7/7/2024 13:41:42'!
totalCost
	
	^developersWorkingDates keys sum: [ :aDeveloper | aDeveloper totalCostWorking: (self workingDatesOf: aDeveloper) ]! !


!Worksheet methodsFor: 'initialization' stamp: 'HAW 7/7/2024 15:30:44'!
initializeOf: aProject 
	
	developersWorkingDates := Dictionary new.
	aProject addWorkingDatesTo: self.
! !


!Worksheet methodsFor: 'overwork' stamp: 'HAW 7/7/2024 13:37:47'!
hasOverwork
	
	^developersWorkingDates keys anySatisfy: [ :aDeveloper | (self overworkingDatesOf: aDeveloper) notEmpty ]! !

!Worksheet methodsFor: 'overwork' stamp: 'HAW 7/7/2024 13:40:20'!
overworkingDatesOf: aDeveloper  
	
	| developerOverWorkingDates |
	
	developerOverWorkingDates := Set new.
	(self workingDatesOf: aDeveloper) withOccurrencesDo: [ :date :occurrences | 
		occurrences > 1 ifTrue: [ developerOverWorkingDates add: date ]].
	
	^developerOverWorkingDates
	! !


!Worksheet methodsFor: 'developers workingdates' stamp: 'HAW 7/7/2024 13:39:22'!
addWorkingDates: aWorkingDates toDeveloper: aDeveloper 
	
	| developerWorkingDates |
	
	developerWorkingDates := self workingDatesOf: aDeveloper.
	developerWorkingDates addAll: aWorkingDates ! !

!Worksheet methodsFor: 'developers workingdates' stamp: 'HAW 7/7/2024 13:39:22'!
workingDatesOf: aDeveloper

	^ developersWorkingDates at: aDeveloper ifAbsentPut: [ Bag new ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Worksheet class' category: #'ISW1-2024-1C-2doParcial'!
Worksheet class
	instanceVariableNames: ''!

!Worksheet class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 13:08:35'!
of: aProject 
	
	^self new initializeOf: aProject ! !
