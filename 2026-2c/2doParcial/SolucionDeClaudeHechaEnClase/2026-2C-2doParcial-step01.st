!classDefinition: #Tool category: #'2026-2C-2doParcial'!
Object subclass: #Tool
	instanceVariableNames: 'name action'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!Tool methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
initializeNamed: aName doing: anAction

	name := aName.
	action := anAction! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tool class' category: #'2026-2C-2doParcial'!
Tool class
	instanceVariableNames: ''!

!Tool class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
named: aName doing: anAction

	self assertIsNotEmpty: aName.

	^self new initializeNamed: aName doing: anAction! !


!Tool class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
assertIsNotEmpty: aName

	aName ifEmpty: [ self error: self nameCannotBeEmptyErrorDescription ]! !


!Tool class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A tool name cannot be empty'! !


!classDefinition: #ToolTest category: #'2026-2C-2doParcial'!
TestCase subclass: #ToolTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ToolTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:21:50 pm (UTC)'!
test01ToolNameCannotBeEmpty

	self
		should: [ Tool named: '' doing: [ :anAnswer | ] ]
		raise: Error
		withMessageText: Tool nameCannotBeEmptyErrorDescription! !
