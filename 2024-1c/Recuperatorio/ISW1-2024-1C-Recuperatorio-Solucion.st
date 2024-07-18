!classDefinition: #ProjectTest category: #'ISW1-2024-1C-Recuperatorio'!
TestCase subclass: #ProjectTest
	instanceVariableNames: 'danIngalls alanKay adeleGoldberg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

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

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test10ProjectStartsOnFirstStartDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self assert: (modelProject startsOn: ssbTask startDate)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test11ProjectDoesNotStartOnDifferentDateOfFirstStartDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self deny: (modelProject startsOn: ssbTask startDate next)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test12ProjectEndsOnLastEndDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self assert: (modelProject endsOn: ssbTask endDate)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test13ProjectDoesNotEndOnDifferentDateOfLastEndDateOfSubtasks

	| ssaTask modelProject ssbTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	
	self deny: (modelProject endsOn: ssbTask endDate next)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test14WhenDeveloperDoNotHaveOverworkProjectDoNotHaveOverwork

	| ssaTask modelProject modelWoorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask }.
	modelWoorksheet := modelProject worksheet.
	
	self deny: modelWoorksheet hasOverwork ! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test15WhenADeveloperHasOverworkProjectHasOverwork

	| ssaTask modelProject ssbTask modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	self assert: modelWorksheet hasOverwork! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test16DeveloperWithoutOneTasksOnSameDateHasNoOverwork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/2/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates isEmpty ! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test17DeveloperWithMoreThanOneTaskOnSameDateHasOverwork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates size equals: 1.
	self assert: (danIngallsOverworkingDates includes: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test18DeveloperWithoutWorkHasNoOveworkingDates

	| ssaTask modelProject ssbTask alanKayOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	alanKayOverworkingDates := modelWorksheet overworkingDatesOf: self alanKay .
	
	self assert: alanKayOverworkingDates isEmpty! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 20:49:37'!
test19TeamCanHaveDevelopersWithOverWork

	| ssaTask modelProject ssbTask danIngallsOverworkingDates modelWorksheet |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 8*hour dependingOn: {}.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask }.
	modelWorksheet := modelProject worksheet.
	
	danIngallsOverworkingDates := modelWorksheet overworkingDatesOf: self danIngalls .
	
	self assert: danIngallsOverworkingDates size equals: 1.
	self assert: (danIngallsOverworkingDates includes: July/1/2024)! !

!ProjectTest methodsFor: 'tests' stamp: 'HAW 7/17/2024 19:41:14'!
test20ProjectCostIsTheSumOfEachDeveloperCostPerWorkingDates
	
	self assert: self erpProject worksheet totalCost equals: 5450 * dollar! !


!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/17/2024 19:59:49'!
adeleGoldberg
	
	adeleGoldberg ifNil: [ adeleGoldberg := Developer named: 'Adele Goldberg' thatWorks: 10*hour/day earning: 65*dollar/hour ].
	
	^adeleGoldberg! !

!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/17/2024 19:59:18'!
alanKay
	
	alanKay ifNil: [ alanKay := Developer named: 'Alan Kay' thatWorks: 6*hour/day earning: 80*dollar/hour ].
	^alanKay! !

!ProjectTest methodsFor: 'developers' stamp: 'HAW 7/7/2024 13:00:38'!
danIngalls

	danIngalls ifNil: [ danIngalls := Developer named: 'Dan Ingalls' thatWorks: 8*hour/day earning: 60*dollar/hour ].
	^danIngalls! !


!ProjectTest methodsFor: 'teams' stamp: 'HAW 7/17/2024 12:54:24'!
parcMobTeam
	
	^MobTeam named: 'Parc Mob Team' composedBy: { self danIngalls. self alanKay }! !


!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 11:57:56'!
test21DevelopersCannotHaveBlankName

	self 
		should: [ Developer named: ' ' thatWorks: 8*hour/day earning: 60*dollar/ hour ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Developer nameCannotBeBlankErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:54:24'!
test22TeamCannotHaveBlankName

	self 
		should: [ MobTeam named: ' ' composedBy: { self danIngalls. self alanKay } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MobTeam nameCannotBeBlankErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:05:26'!
test23ConcreteTaskCannotHaveBlankName

	self 
		should: [ ConcreteTask named: ' ' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour  dependingOn: {} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ConcreteTask nameCannotBeBlankErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test24ProjectCannotHaveBlankName

	| ssa |
	
	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	self 
		should: [ SubProject named: ' ' composedBy: { ssa. }]
		raise: Error - MessageNotUnderstood 
		withMessageText: SubProject nameCannotBeBlankErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:11:56'!
test25ConcreteTaskEffortMustBeStrictlyPositive

	self 
		should: [ ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 0*hour  dependingOn: {} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: ConcreteTask effortMustBeStrictlyPositiveErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:14:26'!
test26DevelopersDedicationMustBeStrictlyPositive

	self 
		should: [ Developer named: 'Pepe' thatWorks: 0*hour/day earning: 60*dollar/ hour ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Developer dedicationMustBeStrictlyPositiveErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:15:47'!
test27DevelopersCostMustBeStrictlyPositive

	self 
		should: [ Developer named: 'Pepe' thatWorks: 8*hour/day earning: 0*dollar/ hour ]
		raise: Error - MessageNotUnderstood 
		withMessageText: Developer costMustBeStrictlyPositiveErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:54:24'!
test28TeamsCannotHaveDirectRepeatedDevelopers

	self 
		should: [ MobTeam named: 'repeated' composedBy: { self danIngalls. self danIngalls }]
		raise: Error - MessageNotUnderstood 
		withMessageText: MobTeam developersMustBeUniqueErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:54:24'!
test29TeamsCannotHaveIndirectRepeatedDevelopers

	self 
		should: [ MobTeam named: 'repeated' composedBy: { 
			MobTeam named: 'team' composedBy: { self danIngalls. self alanKay }.
			self danIngalls }]
		raise: Error - MessageNotUnderstood 
		withMessageText: MobTeam developersMustBeUniqueErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:54:24'!
test30TeamsMustHaveAtLeastTwoDevelopers

	self 
		should: [ MobTeam named: 'repeated' composedBy: { self danIngalls. } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MobTeam mustHaveAtLeastTwoDevelopersErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:29:20'!
test31ConcreteTaskCannotHaveDirectRepatedDependents

	| dependent |
	dependent :=  ConcreteTask named: 'dependent' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	self 
		should: [ ConcreteTask 
				named: 'SS A' 
				startingOn: July/1/2024 
				developedBy: self danIngalls 
				taking: 8*hour 
				dependingOn: { dependent. dependent }]
		raise: Error - MessageNotUnderstood 
		withMessageText: ConcreteTask directDependentsMustBeUniqueErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test32ProjectMustHaveAtLeastOneSubtask

	self 
		should: [SubProject named: 'project' composedBy: {} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SubProject projectMustHaveAtLeasOneSubtaskErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test33ProjectCannotHaveDirectRepeatedConcreteTasks

	| ssa |
	
	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	self 
		should: [SubProject named: 'project' composedBy: { ssa. ssa. } ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SubProject concreteTasksMustBeUniqueErrorDescription! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:42:36'!
test34EffortIsDividedByItsDevelopersWhenUsingParallelTeam

	| ssa team |
	
	team := ParallelTeam named: 'parallel' composedBy: { self danIngalls. self alanKay }.
	
	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: team taking: 16*hour dependingOn: {}.
	
	self assert: (ssa endsOn: July/2/2024)
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:49:28'!
test35EffortIsDividedByAllItsDevelopersWhenUsingParallelTeam

	| ssa team |
	
	team := ParallelTeam named: 'parallel' composedBy: { 
		ParallelTeam named: 'indirect' composedBy: {self danIngalls. self alanKay }.
		self adeleGoldberg }.

	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: team taking: 40*hour dependingOn: {}.
	
	self assert: (ssa endsOn: July/3/2024)
	
! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 12:58:28'!
test36FastTeamUsedMoreDedicatedDeveloper

	| ssa team |
	
	team := FastTeam named: 'parallel' composedBy: { self danIngalls. self alanKay }.

	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: team taking: 8*hour dependingOn: {}.
	
	self assert: (ssa endsOn: July/1/2024)
	
! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 13:00:47'!
test37ComposedTeamsMustBeOfSameType

	self 
		should: [ MobTeam named: 'mob' composedBy: { FastTeam named: 'fast' composedBy: { self danIngalls. self alanKay }} ]
		raise: Error - MessageNotUnderstood 
		withMessageText: 	Team composedTeamsMustBeOfSameTypeErrorDescription 
! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 19:39:37'!
test38ConcreteTaskWithOneDeveloperCanBePrinted

	| ssa lines |
	
	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024  developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	
	lines := ProjectPrinter valueFor: ssa.
	
	self assert: lines size equals: 1.
	self assert: lines first equals: '2024/07/01 - 2024/07/01 - 1 * day  - 1 dev  |-> SS A'! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 19:39:32'!
test39ConcreteTaskWithMoreThanOneDeveloperCanBePrinted

	| ssa lines |
	
	ssa := ConcreteTask named: 'SS A' startingOn: July/1/2024  developedBy: self parcMobTeam taking: 8*hour dependingOn: {}.
	
	lines := ProjectPrinter valueFor: ssa.
	
	self assert: lines size equals: 1.
	self assert: lines first equals: '2024/07/01 - 2024/07/02 - 2 * days - 2 devs |-> SS A'! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:03:29'!
test40ProjectWithWithSubProjectCanBePrinted

	| lines |
	
	lines := ReadStream on: (ProjectPrinter valueFor: self erpProject).
	
	self assert: lines next equals: '2024/07/01 - 2024/07/07 - 7 * days - 3 devs |-> Sistema ERP'.
	self assert: lines next equals: '2024/07/01 - 2024/07/06 - 6 * days - 2 devs  |-> Modelo'.
	self assert: lines next equals: '2024/07/01 - 2024/07/01 - 1 * day  - 1 dev    |-> SS A'.
	self assert: lines next equals: '2024/07/01 - 2024/07/03 - 3 * days - 2 devs   |-> SS B'.
	self assert: lines next equals: '2024/07/04 - 2024/07/06 - 3 * days - 1 dev    |-> SS C'.
	self assert: lines next equals: '2024/07/07 - 2024/07/07 - 1 * day  - 1 dev   |-> UI'.
	
	self assert: lines atEnd 
! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:18:37'!
test41RootProjectCannotBeCreatedWithDirectDependentsNotInProject

	| dependent ssa |
	
	dependent := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependent}.
	
	self 
		should: [ RootProject named: 'root' composedBy: { ssa } ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject dependentTaskMustBePartOfRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:22:01'!
test42RootProjectCannotBeCreatedWithInderectDependentsNotInProject

	| dependentNotInProject ssa dependentInProject |
	
	dependentNotInProject := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	dependentInProject := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependentNotInProject}.
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependentInProject}.
	
	self 
		should: [ RootProject named: 'root' composedBy: { ssa. dependentInProject } ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject dependentTaskMustBePartOfRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test43RootProjectCannotBeCreatedWithInderectDependentsOfProjectNotInProject

	| dependentNotInProject ssa dependentInProject |
	
	dependentNotInProject := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	dependentInProject := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependentNotInProject}.
	ssa := SubProject named: 'ss a' composedBy: {dependentInProject}.
	
	self 
		should: [ RootProject named: 'root' composedBy: { ssa. dependentInProject } ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject dependentTaskMustBePartOfRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test44RootProjectCannotBeCreatedWithProjectAsInderectDependentsNotInProject

	| dependentNotInProject ssa dependentInProject ssb |
	
	dependentNotInProject := ConcreteTask named: 'not in project' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssb := ConcreteTask named: 'ss b' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependentNotInProject }.
	dependentInProject := SubProject named: 'in project' composedBy: {ssb }.
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {dependentInProject }.
	
	self 
		should: [ RootProject named: 'root' composedBy: { ssa. dependentInProject } ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject dependentTaskMustBePartOfRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:40:46'!
test45DirectRootProjectCannotBePartOfRootProject

	| ssa |
	
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: { }.
	
	self 
		should: [ RootProject named: 'root' composedBy: { RootProject named: 'sub' composedBy: { ssa }} ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject rootProjectCannotBePartOfAnotherRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test46IndirectDirectRootProjectCannotBePartOfRootProject

	| ssa |
	
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: { }.
	
	self 
		should: [ RootProject named: 'root' composedBy: { 
					SubProject named: 'sub1' composedBy: { 
						RootProject named: 'sub' composedBy: { ssa }}} ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject rootProjectCannotBePartOfAnotherRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:46:08'!
test47DependentRootProjectCannotBePartOfRootProject

	| ssa dependet ssb |
	
	ssb := ConcreteTask named: 'ss b' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	dependet := RootProject named: 'sub' composedBy: { ssb }.
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: { dependet }.
	
	self 
		should: [ RootProject named: 'root' composedBy: { ssa. ssb } ]
	       raise: Error - MessageNotUnderstood 
		withMessageText: RootProject rootProjectCannotBePartOfAnotherRootProjectErrorDescription
		
	
	! !

!ProjectTest methodsFor: 'test del recu' stamp: 'HAW 7/17/2024 20:49:37'!
test48RootProjectCanBeCreated

	| ssa dependet ssb |
	
	ssb := ConcreteTask named: 'ss b' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	dependet := SubProject named: 'sub' composedBy: { ssb }.
	ssa := ConcreteTask named: 'ss a' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: { dependet }.
	
	self 
		shouldnt: [ RootProject named: 'root' composedBy: { ssa. dependet} ]
	       raise: Error! !


!ProjectTest methodsFor: 'tasks' stamp: 'HAW 7/17/2024 20:49:37'!
erpProject

	| ssaTask modelProject ssbTask erpProject sscTask uiTask |
	
	ssaTask := ConcreteTask named: 'SS A' startingOn: July/1/2024 developedBy: self danIngalls taking: 8*hour dependingOn: {}.
	ssbTask := ConcreteTask named: 'SS B' startingOn: July/1/2024 developedBy: self parcMobTeam taking: 16*hour dependingOn: {}.
	sscTask := ConcreteTask named: 'SS C' startingOn: July/2/2024 developedBy: self alanKay taking: 16*hour dependingOn: {ssaTask. ssbTask }.
	modelProject := SubProject named: 'Modelo' composedBy: { ssaTask. ssbTask. sscTask }.
	uiTask := ConcreteTask named: 'UI' startingOn: July/2/2024 developedBy: self adeleGoldberg taking: 6*hour dependingOn: { modelProject }.
	erpProject := SubProject named: 'Sistema ERP' composedBy: { modelProject. uiTask }.
	
	^erpProject! !


!classDefinition: #ProjectPrinter category: #'ISW1-2024-1C-Recuperatorio'!
Object subclass: #ProjectPrinter
	instanceVariableNames: 'task lines identation'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!ProjectPrinter methodsFor: 'initialization' stamp: 'HAW 7/17/2024 19:45:24'!
initializeFor: aTask 
	
	task := aTask.! !


!ProjectPrinter methodsFor: 'evaluating' stamp: 'HAW 7/17/2024 19:46:39'!
value
	
	lines := OrderedCollection new.
	identation := 0.
	
	task printWith: self.
	
	^lines
		
			! !


!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 19:55:50'!
printConcreteTask: aConcreteTask 
	
	self printTask: aConcreteTask ! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 19:18:28'!
printDate: aDate on: stream 
	
	stream 
		print: aDate year number;
		nextPut: $/;
		nextPutAll: ((aDate month number printString) padded: #left to: 2 with: $0);
		nextPut: $/;
		nextPutAll: ((aDate dayNumber printString) padded: #left to: 2 with: $0)! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:10:22'!
printEndDateOf: aTask on: stream

	^ self printDate: aTask endDate on: stream! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:13:02'!
printIdentationOn: stream

	^ stream nextPutAll: ('|-> ' padded: #left to: 4+identation with: $ )! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:13:10'!
printNameOf: aTask on: stream

	^ stream nextPutAll: aTask name! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:12:49'!
printNumberOfDevelopersOf: aTask on: stream

	| numberOfDevelopers |
	
	numberOfDevelopers := aTask numberOfDevelopers.
	stream 	print: numberOfDevelopers.
	stream nextPutAll: ((' dev' pluralize: numberOfDevelopers > 1) padded: #right to: 6 with: $ )! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 19:47:49'!
printProject: aProject 
	
	self printTask: aProject.
	identation := identation + 1.
	aProject printSubtaskWith: self.
	identation := identation - 1! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:09:58'!
printSeparatorOn: stream

	^ stream nextPutAll: ' - '! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:10:13'!
printStartDateOf: aTask on: stream

	^ self printDate: aTask startDate on: stream! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:13:10'!
printTask: aTask 
	
	| line |
	
	line := String streamContents: [ :stream |
		self printStartDateOf: aTask on: stream.
		self printSeparatorOn: stream.
		self printEndDateOf: aTask on: stream.
		self printSeparatorOn: stream.
		self printTimeToCompleteOf: aTask on: stream.
		self printSeparatorOn: stream.
		self printNumberOfDevelopersOf: aTask on: stream.
		self printIdentationOn: stream.
		self printNameOf: aTask on: stream ].
	
	lines add: line.
	! !

!ProjectPrinter methodsFor: 'printing - private' stamp: 'HAW 7/17/2024 20:10:46'!
printTimeToCompleteOf: aTask on: stream

	^ stream nextPutAll: ((aTask timeToComplete + (1*day)) printString padded: #right to: 8 with: $ )! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ProjectPrinter class' category: #'ISW1-2024-1C-Recuperatorio'!
ProjectPrinter class
	instanceVariableNames: ''!

!ProjectPrinter class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 19:12:13'!
valueFor: aTask

	^(self for: aTask) value

	 
	
	! !


!ProjectPrinter class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 19:12:22'!
for: aTask 
	
	^self new initializeFor: aTask ! !


!classDefinition: #Responsable category: #'ISW1-2024-1C-Recuperatorio'!
Object subclass: #Responsable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!Responsable methodsFor: 'worksheet' stamp: 'HAW 7/7/2024 13:30:37'!
addWorkingDates: aWorkingDates to: aWorksheet

	self subclassResponsibility! !


!Responsable methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:35:56'!
timeToComplete: anEffort

	self subclassResponsibility! !


!Responsable methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:58:39'!
addDevelopersTo: allDevelopers

	self subclassResponsibility! !

!Responsable methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:58:43'!
assertIsDeveloperOrTeamOfType: aTeamType

	self subclassResponsibility! !

!Responsable methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:58:47'!
numberOfDevelopers

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Responsable class' category: #'ISW1-2024-1C-Recuperatorio'!
Responsable class
	instanceVariableNames: ''!

!Responsable class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:06:46'!
assertNameIsNotBlank: aName

	| trimmedName |
	
	trimmedName := aName withBlanksTrimmed.
	trimmedName ifEmpty: [ self error: self nameCannotBeBlankErrorDescription ].
	
	^trimmedName ! !

!Responsable class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:03:08'!
nameCannotBeBlankErrorDescription
	
	^'Name cannot be blank'! !


!classDefinition: #Developer category: #'ISW1-2024-1C-Recuperatorio'!
Responsable subclass: #Developer
	instanceVariableNames: 'name dedication cost'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

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


!Developer methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 12:23:50'!
addDevelopersTo: allDevelopers 
	
	allDevelopers add: self! !

!Developer methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 13:07:20'!
assertIsDeveloperOrTeamOfType: aTeamType

! !

!Developer methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 19:25:03'!
numberOfDevelopers
	
	^1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Developer class' category: #'ISW1-2024-1C-Recuperatorio'!
Developer class
	instanceVariableNames: ''!

!Developer class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 12:16:25'!
named: aName thatWorks: aDedication earning: aCost 
	
	| trimmedName |
	
	trimmedName := self assertNameIsNotBlank: aName.
	self assertDedicationIsValid: aDedication.
	self assertCostIsValid: aCost.
	
	^self new initializeNamed: trimmedName thatWorks: aDedication earning: aCost ! !


!Developer class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:16:43'!
assertCostIsValid: aCost 
	
	aCost strictlyPositive ifFalse: [ self error: self costMustBeStrictlyPositiveErrorDescription ]! !

!Developer class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:15:24'!
assertDedicationIsValid: aDedication 
	
	aDedication strictlyPositive ifFalse: [ self error: self dedicationMustBeStrictlyPositiveErrorDescription ]! !

!Developer class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:16:00'!
costMustBeStrictlyPositiveErrorDescription
	
	^'Cost must be strictly positive'! !

!Developer class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:14:41'!
dedicationMustBeStrictlyPositiveErrorDescription
	
	^'Dedication must be strictly positive'! !


!classDefinition: #Team category: #'ISW1-2024-1C-Recuperatorio'!
Responsable subclass: #Team
	instanceVariableNames: 'responsables name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!Team methodsFor: 'initialization' stamp: 'HAW 7/17/2024 12:56:18'!
initializeNamed: aName composedBy: aResponsables 
	
	name := aName.
	responsables := aResponsables.! !


!Team methodsFor: 'worksheet' stamp: 'HAW 7/17/2024 12:56:25'!
addWorkingDates: aWorkingDates to: aWorksheet 
	
	responsables do: [ :aResponsable | aResponsable addWorkingDates: aWorkingDates to: aWorksheet ]! !


!Team methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 12:56:34'!
addDevelopersTo: allDevelopers 
	
	responsables do: [ :aResponsable | aResponsable addDevelopersTo: allDevelopers ]! !

!Team methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 12:56:01'!
allDevelopers
	
	^self class allDevelopersIn: responsables ! !

!Team methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 13:06:51'!
assertIsDeveloperOrTeamOfType: aTeamType

	self class = aTeamType ifFalse: [ self error: self class composedTeamsMustBeOfSameTypeErrorDescription ].
	! !

!Team methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 19:31:26'!
numberOfDevelopers
	
	^self allDevelopers size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'ISW1-2024-1C-Recuperatorio'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 13:01:45'!
named: aName composedBy: aResponsables 
	
	| trimmedName |
	
	trimmedName := self assertNameIsNotBlank: aName.
	self assertResponsablesAreValid: aResponsables.
	self assertComposedTeamsAreOfSameType: aResponsables.
	
	^self new initializeNamed: trimmedName composedBy: aResponsables ! !


!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:55:26'!
allDevelopersIn: aResponsables 
	
	| allDevelopers |
	
	allDevelopers := OrderedCollection new.
	aResponsables do: [ :responsable | responsable addDevelopersTo: allDevelopers ].
	
	^allDevelopers ! !

!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 13:06:51'!
assertComposedTeamsAreOfSameType: aResponsables 
	
	aResponsables do: [ :aResponsable | aResponsable assertIsDeveloperOrTeamOfType: self ]! !

!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:55:18'!
assertResponsablesAreValid: aResponsables 
	
	| potentialRepeatedDevelopers notRepatedDevelopers |
	
	potentialRepeatedDevelopers := self allDevelopersIn: aResponsables.
	
	notRepatedDevelopers := potentialRepeatedDevelopers asSet.
	notRepatedDevelopers size = potentialRepeatedDevelopers size ifFalse: [ self error: self developersMustBeUniqueErrorDescription ].
	notRepatedDevelopers size < 2 ifTrue: [ self error: self mustHaveAtLeastTwoDevelopersErrorDescription ].! !

!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 13:01:00'!
composedTeamsMustBeOfSameTypeErrorDescription
	
	^'Composed teams must be of same type'! !

!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:55:30'!
developersMustBeUniqueErrorDescription
	
	^'Developers of a team must be unique'! !

!Team class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 12:55:34'!
mustHaveAtLeastTwoDevelopersErrorDescription
	
	^'Team must have at least two developers'! !


!classDefinition: #FastTeam category: #'ISW1-2024-1C-Recuperatorio'!
Team subclass: #FastTeam
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!FastTeam methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:59:02'!
timeToComplete: anEffort

	^responsables min: [ :aResponsable | aResponsable timeToComplete: anEffort ]! !


!classDefinition: #MobTeam category: #'ISW1-2024-1C-Recuperatorio'!
Team subclass: #MobTeam
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!MobTeam methodsFor: 'effort' stamp: 'HAW 7/7/2024 12:13:56'!
timeToComplete: anEffort 
	
	^responsables max: [ :aResponsable | aResponsable timeToComplete: anEffort ]! !


!classDefinition: #ParallelTeam category: #'ISW1-2024-1C-Recuperatorio'!
Team subclass: #ParallelTeam
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!ParallelTeam methodsFor: 'effort' stamp: 'HAW 7/17/2024 12:53:48'!
timeToComplete: anEffort
 
	| dividedEffort allDevelopers |
	
	allDevelopers := self allDevelopers.
	dividedEffort := anEffort / allDevelopers size.
	
	^allDevelopers max: [ :aDeveloper | aDeveloper timeToComplete: dividedEffort ].! !


!classDefinition: #Task category: #'ISW1-2024-1C-Recuperatorio'!
Object subclass: #Task
	instanceVariableNames: 'name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

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


!Task methodsFor: 'name' stamp: 'HAW 7/17/2024 19:28:09'!
name

	^name! !


!Task methodsFor: 'effort' stamp: 'HAW 7/17/2024 20:54:52'!
timeToComplete

	self subclassResponsibility! !


!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:33'!
addConcreteTaskTo: allTalks

	self subclassResponsibility! !

!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:37'!
addDependentsTo: allDependents

	self subclassResponsibility! !

!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:40'!
addDevelopersTo: allDevelopers

	self subclassResponsibility! !

!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:44'!
asDependentAddDependentsTo: allDependents

	self subclassResponsibility! !

!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:47'!
assertCanBeAddedToRootProject

	self subclassResponsibility! !

!Task methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:58'!
numberOfDevelopers

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Task class' category: #'ISW1-2024-1C-Recuperatorio'!
Task class
	instanceVariableNames: ''!

!Task class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:07:46'!
assertNameIsNotBlank: aName

	| trimmedName |
	
	trimmedName := aName withBlanksTrimmed.
	trimmedName ifEmpty: [ self error: self nameCannotBeBlankErrorDescription ].
	
	^trimmedName ! !

!Task class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:05:52'!
nameCannotBeBlankErrorDescription
	
	^'Name cannot be blank'! !


!classDefinition: #ConcreteTask category: #'ISW1-2024-1C-Recuperatorio'!
Task subclass: #ConcreteTask
	instanceVariableNames: 'desiredStartDate responsable dependents effort'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

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


!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 12:37:58'!
addConcreteTaskTo: allTalks

	allTalks add: self
	
	! !

!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:37:22'!
addDependentsTo: allDependents 
	
	dependents do: [ :aDependent | aDependent asDependentAddDependentsTo: allDependents ]! !

!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 19:54:17'!
addDevelopersTo: allDevelopers 
	
	responsable addDevelopersTo: allDevelopers
	
	! !

!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:38:24'!
asDependentAddDependentsTo: allDependents 
	
	allDependents add: self.
	self addDependentsTo: allDependents ! !

!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:47:14'!
assertCanBeAddedToRootProject
	
	dependents do: [ :aDependent | aDependent assertCanBeAddedToRootProject ]! !

!ConcreteTask methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 19:24:52'!
numberOfDevelopers
	
	^responsable numberOfDevelopers ! !


!ConcreteTask methodsFor: 'printing' stamp: 'HAW 7/17/2024 19:55:36'!
printWith: aProjectPrinter 
	
	aProjectPrinter printConcreteTask: self ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ConcreteTask class' category: #'ISW1-2024-1C-Recuperatorio'!
ConcreteTask class
	instanceVariableNames: ''!

!ConcreteTask class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 12:30:09'!
named: aName startingOn: aDesiredStartDate developedBy: aResponsable taking: anEffort dependingOn: aDependents 
	
	| trimmedName |
	
	trimmedName := self assertNameIsNotBlank: aName.
	self assertEffortIsValid: anEffort.
	self assertDirectDependetsAreUnique: aDependents.
	
	^self new initializeNamed: trimmedName startingOn: aDesiredStartDate developedBy: aResponsable taking: anEffort dependingOn: aDependents ! !


!ConcreteTask class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:30:48'!
assertDirectDependetsAreUnique: aDependents 
	
	aDependents asSet size = aDependents size ifFalse: [ self error: self directDependentsMustBeUniqueErrorDescription ]! !

!ConcreteTask class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:13:10'!
assertEffortIsValid: anEffort 
	
	anEffort strictlyPositive ifFalse: [ self error: self effortMustBeStrictlyPositiveErrorDescription ]! !

!ConcreteTask class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:29:34'!
directDependentsMustBeUniqueErrorDescription
	
	^'Direct dependents must be unique'! !

!ConcreteTask class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 12:12:11'!
effortMustBeStrictlyPositiveErrorDescription
	
	^'Effort must be strictly positive'! !


!classDefinition: #Project category: #'ISW1-2024-1C-Recuperatorio'!
Task subclass: #Project
	instanceVariableNames: 'subtasks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!Project methodsFor: 'initialization' stamp: 'HAW 7/17/2024 20:50:40'!
initializeNamed: aName composedBy: aSubtasks 
	
	name := aName.
	subtasks := aSubtasks.! !


!Project methodsFor: 'worksheet' stamp: 'HAW 7/17/2024 20:50:48'!
addWorkingDatesTo: aWorksheet 
	
	subtasks do: [ :aSubtask | aSubtask addWorkingDatesTo: aWorksheet ]! !

!Project methodsFor: 'worksheet' stamp: 'HAW 7/17/2024 20:50:53'!
subtasksDo: aBlock 
	
	subtasks do: aBlock ! !

!Project methodsFor: 'worksheet' stamp: 'HAW 7/17/2024 20:50:58'!
worksheet

	^ Worksheet of: self! !


!Project methodsFor: 'end date' stamp: 'HAW 7/17/2024 20:51:04'!
endDate
	
	^subtasks max: [ :aSubtask | aSubtask endDate ]! !


!Project methodsFor: 'start date' stamp: 'HAW 7/17/2024 20:51:09'!
startDate
	
	^subtasks min: [ :subtask | subtask startDate ]! !


!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:51:19'!
addConcreteTaskTo: allTaks

	subtasks do: [ :aTask | aTask addConcreteTaskTo: allTaks ]
	
	! !

!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:51:24'!
addDependentsTo: allDependents 
	
	subtasks do: [ :aTask | aTask addDependentsTo: allDependents ]! !

!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:51:27'!
addDevelopersTo: allDevelopers 
	
	subtasks do: [ :aTask | aTask addDevelopersTo: allDevelopers ]! !

!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:51:32'!
allDevelopers
	
	| allDevelopers |
	
	allDevelopers := Set new.
	subtasks do: [ :aTask | aTask addDevelopersTo: allDevelopers ].
	
	^allDevelopers! !

!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:51:36'!
asDependentAddDependentsTo: allDependents 
	
	subtasks do: [ :aTask | aTask addDependentsTo: allDependents ]! !

!Project methodsFor: 'composite behavior' stamp: 'HAW 7/17/2024 20:56:21'!
numberOfDevelopers
	
	^self allDevelopers size! !


!Project methodsFor: 'printing' stamp: 'HAW 7/17/2024 20:51:42'!
printSubtaskWith: aProjectPrinter 
	
	subtasks do: [ :aTask | aTask printWith: aProjectPrinter ]! !

!Project methodsFor: 'printing' stamp: 'HAW 7/17/2024 20:51:47'!
printWith: aProjectPrinter 
	
	aProjectPrinter printProject: self! !


!Project methodsFor: 'effort' stamp: 'HAW 7/17/2024 20:51:52'!
timeToComplete
	
	^self startDate distanceTo: self endDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Project class' category: #'ISW1-2024-1C-Recuperatorio'!
Project class
	instanceVariableNames: ''!

!Project class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 20:52:30'!
assertSubtasksAreValid: aSubtasks 
	
	| potentialRepatedTasks notRepeatedTasks |
	
	potentialRepatedTasks := OrderedCollection new.
	aSubtasks do: [ :aSubtask | aSubtask addConcreteTaskTo: potentialRepatedTasks].
	
	notRepeatedTasks := potentialRepatedTasks asSet.
	notRepeatedTasks size = potentialRepatedTasks size ifFalse: [ self error: self concreteTasksMustBeUniqueErrorDescription ].
	notRepeatedTasks ifEmpty: [ self error: self projectMustHaveAtLeasOneSubtaskErrorDescription ]! !

!Project class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 20:52:37'!
concreteTasksMustBeUniqueErrorDescription
	
	^'Concrete task must be unique'! !

!Project class methodsFor: 'as yet unclassified' stamp: 'HAW 7/17/2024 20:52:41'!
projectMustHaveAtLeasOneSubtaskErrorDescription
	
	^'Project must have at least one subtask'! !


!Project class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 20:52:30'!
named: aName composedBy: aSubtasks 
	
	| trimmedName |
	
	trimmedName := self assertNameIsNotBlank: aName.
	self assertSubtasksAreValid: aSubtasks.
	
	^self new initializeNamed: trimmedName composedBy: aSubtasks ! !


!classDefinition: #RootProject category: #'ISW1-2024-1C-Recuperatorio'!
Project subclass: #RootProject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!RootProject methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:42:16'!
assertCanBeAddedToRootProject
	
	self error: self class rootProjectCannotBePartOfAnotherRootProjectErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RootProject class' category: #'ISW1-2024-1C-Recuperatorio'!
RootProject class
	instanceVariableNames: ''!

!RootProject class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:53:43'!
assertAllDepentesAreInRootProject: aSubtasks

	| allConcreteTasks allDependents |
	
	allConcreteTasks := Set new.
	aSubtasks do: [ :aTask | aTask addConcreteTaskTo: allConcreteTasks ].
	allDependents := Set new.
	aSubtasks do: [ :aTask | aTask addDependentsTo: allDependents ].
	
	(allConcreteTasks includesAllOf: allDependents) ifFalse: [ self error: self dependentTaskMustBePartOfRootProjectErrorDescription ]! !

!RootProject class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:53:22'!
assertCannotIncludeRootProjectIn: aSubtasks

	^ aSubtasks do: [ :aTask | aTask assertCanBeAddedToRootProject ]! !

!RootProject class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:16:52'!
dependentTaskMustBePartOfRootProjectErrorDescription
	
	^'Dependent tasks must be part of root project'! !

!RootProject class methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:41:06'!
rootProjectCannotBePartOfAnotherRootProjectErrorDescription
	
	^'Root project cannot be part of another root project'! !


!RootProject class methodsFor: 'instance creation' stamp: 'HAW 7/17/2024 20:53:46'!
named: aName composedBy: aSubtasks

	self assertAllDepentesAreInRootProject: aSubtasks.
	self assertCannotIncludeRootProjectIn: aSubtasks.
	
	^super named: aName composedBy: aSubtasks ! !


!classDefinition: #SubProject category: #'ISW1-2024-1C-Recuperatorio'!
Project subclass: #SubProject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

!SubProject methodsFor: 'assertions' stamp: 'HAW 7/17/2024 20:44:04'!
assertCanBeAddedToRootProject
	
	subtasks do: [ :aTask | aTask assertCanBeAddedToRootProject ]! !


!classDefinition: #Worksheet category: #'ISW1-2024-1C-Recuperatorio'!
Object subclass: #Worksheet
	instanceVariableNames: 'developersWorkingDates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2024-1C-Recuperatorio'!

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

!classDefinition: 'Worksheet class' category: #'ISW1-2024-1C-Recuperatorio'!
Worksheet class
	instanceVariableNames: ''!

!Worksheet class methodsFor: 'instance creation' stamp: 'HAW 7/7/2024 13:08:35'!
of: aProject 
	
	^self new initializeOf: aProject ! !
