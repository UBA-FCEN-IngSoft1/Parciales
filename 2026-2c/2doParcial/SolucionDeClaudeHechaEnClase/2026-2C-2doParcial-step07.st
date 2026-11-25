!classDefinition: #CodingAgent category: #'2026-2C-2doParcial'!
Object subclass: #CodingAgent
	instanceVariableNames: 'availableMoney servers llm context'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgent methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
initializeAvailableMoney: aMoney servers: aServers llm: aLLM

	availableMoney := aMoney.
	servers := aServers.
	llm := aLLM.
	context := ''! !


!CodingAgent methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
prompt: aPrompt

	self assertHasMoneyAvailable! !


!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
assertHasMoneyAvailable

	availableMoney <= (0*dollar) ifTrue: [ self error: self class noMoneyAvailableErrorDescription ]! !


!CodingAgent methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
availableMoney

	^availableMoney! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgent class' category: #'2026-2C-2doParcial'!
CodingAgent class
	instanceVariableNames: ''!

!CodingAgent class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
availableMoney: aMoney servers: aServers llm: aLLM

	self assertNamesAreUniqueIn: aServers.

	^self new initializeAvailableMoney: aMoney servers: aServers llm: aLLM! !


!CodingAgent class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
assertNamesAreUniqueIn: aServers

	(aServers collect: [ :aServer | aServer name ]) asSet size = aServers size
		ifFalse: [ self error: self serverNamesMustBeUniqueErrorDescription ]! !


!CodingAgent class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
noMoneyAvailableErrorDescription

	^'There is no money available to prompt the LLM'! !

!CodingAgent class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
serverNamesMustBeUniqueErrorDescription

	^'Server names must be unique in an agent'! !


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


!ModelContextProtocolServer methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
name

	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ModelContextProtocolServer class' category: #'2026-2C-2doParcial'!
ModelContextProtocolServer class
	instanceVariableNames: ''!

!ModelContextProtocolServer class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
named: aName tools: aTools

	self assertIsNotEmpty: aName.
	self assertHasTools: aTools.
	self assertNamesAreUniqueIn: aTools.

	^self new initializeNamed: aName tools: aTools! !


!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
assertHasTools: aTools

	aTools ifEmpty: [ self error: self toolsCannotBeEmptyErrorDescription ]! !

!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
assertIsNotEmpty: aName

	aName ifEmpty: [ self error: self nameCannotBeEmptyErrorDescription ]! !

!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
assertNamesAreUniqueIn: aTools

	(aTools collect: [ :aTool | aTool name ]) asSet size = aTools size
		ifFalse: [ self error: self toolNamesMustBeUniqueErrorDescription ]! !


!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A server name cannot be empty'! !

!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
toolNamesMustBeUniqueErrorDescription

	^'Tool names must be unique in a server'! !

!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
toolsCannotBeEmptyErrorDescription

	^'A server must have at least one tool'! !


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


!Tool methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
name

	^name! !

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


!classDefinition: #CodingAgentTest category: #'2026-2C-2doParcial'!
TestCase subclass: #CodingAgentTest
	instanceVariableNames: 'evaluatedAnswers createdFiles'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentTest methodsFor: 'setup' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
setUp

	evaluatedAnswers := OrderedCollection new.
	createdFiles := OrderedCollection new! !


!CodingAgentTest methodsFor: 'servers' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
smalltalkServer

	^ModelContextProtocolServer
		named: 'Smalltalk'
		tools: (Array with: (Tool named: 'evaluate' doing: [ :anAnswer | evaluatedAnswers add: anAnswer ]))! !


!CodingAgentTest methodsFor: 'llms' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
cheapLLMEndingImmediately

	^CheapLLM answers: (Array with: '')! !


!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
test01ServerNamesMustBeUniqueInAgent

	self
		should: [
			CodingAgent
				availableMoney: 10*dollar
				servers: (Array with: self smalltalkServer with: self smalltalkServer)
				llm: self cheapLLMEndingImmediately ]
		raise: Error
		withMessageText: CodingAgent serverNamesMustBeUniqueErrorDescription! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
test02AgentWithoutMoneyCannotPrompt

	| agent |

	agent := self agentWith: 0*dollar using: self cheapLLMEndingImmediately.

	self
		should: [ agent prompt: 'hello' ]
		raise: Error
		withMessageText: CodingAgent noMoneyAvailableErrorDescription.
	self assert: agent availableMoney equals: 0*dollar.
	self assert: evaluatedAnswers isEmpty! !


!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
agentWith: aMoney using: aLLM

	^CodingAgent
		availableMoney: aMoney
		servers: (Array with: self smalltalkServer)
		llm: aLLM! !


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

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
test02ServerMustHaveTools

	self
		should: [ ModelContextProtocolServer named: 'Smalltalk' tools: #() ]
		raise: Error
		withMessageText: ModelContextProtocolServer toolsCannotBeEmptyErrorDescription! !

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
test03ToolNamesMustBeUniqueInServer

	self
		should: [ ModelContextProtocolServer named: 'Smalltalk' tools: (Array with: self evaluateTool with: self evaluateTool) ]
		raise: Error
		withMessageText: ModelContextProtocolServer toolNamesMustBeUniqueErrorDescription! !


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
