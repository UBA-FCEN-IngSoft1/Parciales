!classDefinition: #ModelContextProtocolServer category: #'2026-2C-2doParcial'!
Object subclass: #ModelContextProtocolServer
	instanceVariableNames: 'name tools'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ModelContextProtocolServer methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
initializeNamed: aName tools: aTools

	name := aName.
	tools := aTools! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModelContextProtocolServer class' category: #'2026-2C-2doParcial'!
ModelContextProtocolServer class
	instanceVariableNames: ''!

!ModelContextProtocolServer class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
named: aName tools: aTools

	self assertIsNotEmpty: aName.

	^self new initializeNamed: aName tools: aTools! !


!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
assertIsNotEmpty: aName

	aName ifEmpty: [ self error: self nameCannotBeEmptyErrorDescription ]! !


!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A server name cannot be empty'! !


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


!Tool methodsFor: 'executing' stamp: 'HAW 24/Nov/2026, 11:22:12 pm (UTC)'!
executeWith: anAnswer

	^action value: anAnswer! !

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


!classDefinition: #ModelContextProtocolServerTest category: #'2026-2C-2doParcial'!
TestCase subclass: #ModelContextProtocolServerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
test01ServerNameCannotBeEmpty

	self
		should: [ ModelContextProtocolServer named: '' tools: (Array with: self evaluateTool) ]
		raise: Error
		withMessageText: ModelContextProtocolServer nameCannotBeEmptyErrorDescription! !


!ModelContextProtocolServerTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
evaluateTool

	^Tool named: 'evaluate' doing: [ :anAnswer | ]! !


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

!ToolTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:12 pm (UTC)'!
test02ToolExecutesItsActionWithAnswer

	| executedAnswer tool |

	tool := Tool named: 'evaluate' doing: [ :anAnswer | executedAnswer := anAnswer ].

	tool executeWith: 'continue'.

	self assert: executedAnswer equals: 'continue'! !
