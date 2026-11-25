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


!CodingAgent methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
prompt: aPrompt

	| response |

	response := self runCycleWith: aPrompt.
	[ llm shouldStopOn: response answer ]
		whileFalse: [ response := self runCycleWith: response answer ]! !


!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
assertHasMoneyAvailable

	availableMoney <= (0*dollar)
		ifTrue: [ self error: self class noMoneyAvailableErrorDescription ]! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
qualifiedToolNames

	^servers
		inject: #()
		into: [ :toolNames :aServer | toolNames, aServer qualifiedToolNames ]! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
runCycleWith: aPrompt

	| response |

	self assertHasMoneyAvailable.
	response := llm prompt: aPrompt context: context tools: self toolNames.
	availableMoney := availableMoney - response cost.
	self executeToolsNamed: response toolNames with: response answer.
	context := context, aPrompt.

	^response! !

!CodingAgent methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:25:10 pm (UTC)'!
toolNames

	^String streamContents: [ :aStream |
		self qualifiedToolNames
			do: [ :aQualifiedToolName | aStream nextPutAll: aQualifiedToolName ]
			separatedBy: [ aStream nextPut: $, ] ]! !


!CodingAgent methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:23:51 pm (UTC)'!
availableMoney

	^availableMoney! !


!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
executeToolNamed: aQualifiedToolName with: anAnswer

	| nameStream |

	nameStream := aQualifiedToolName readStream.
	(self serverNamed: (nameStream upTo: $/))
		executeToolNamed: nameStream upToEnd
		with: anAnswer! !

!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
executeToolsNamed: aQualifiedToolNames with: anAnswer

	aQualifiedToolNames ifEmpty: [ ^self ].
	(aQualifiedToolNames substringsSeparatedBy: $,) do: [ :aQualifiedToolName |
		self executeToolNamed: aQualifiedToolName with: anAnswer ]! !

!CodingAgent methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
serverNamed: aName

	^servers detect: [ :aServer | aServer name = aName ]! !

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


!classDefinition: #LLMAdapter category: #'2026-2C-2doParcial'!
Object subclass: #LLMAdapter
	instanceVariableNames: 'model'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!LLMAdapter methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
initializeOn: aLLM

	model := aLLM! !


!LLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	self subclassResponsibility! !


!LLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
shouldStopOn: anAnswer

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LLMAdapter class' category: #'2026-2C-2doParcial'!
LLMAdapter class
	instanceVariableNames: ''!

!LLMAdapter class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
on: aLLM

	^self new initializeOn: aLLM! !


!classDefinition: #AffordableLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #AffordableLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!AffordableLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	| response |

	response := self responseFor: aPrompt context: aContext tools: aToolNames.

	^LLMResponse
		cost: (response at: #cost)
		answer: (response at: #answer)
		toolNames: (response at: #tools)! !


!AffordableLLMAdapter methodsFor: 'prompting - private' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
responseFor: aPrompt context: aContext tools: aToolNames

	^model responseOf: (String streamContents: [ :aStream |
		aStream
			nextPutAll: aPrompt; newLine;
			nextPutAll: aContext; newLine;
			nextPutAll: aToolNames; newLine ])! !


!AffordableLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model hasFinshed: anAnswer! !


!classDefinition: #CheapLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #CheapLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CheapLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	| response |

	response := model
		prompt: (Array with: aPrompt with: aContext with: aToolNames).

	^LLMResponse
		cost: response first
		answer: response second
		toolNames: response third! !


!CheapLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model stopsOn: anAnswer! !


!classDefinition: #ExpensiveLLMAdapter category: #'2026-2C-2doParcial'!
LLMAdapter subclass: #ExpensiveLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ExpensiveLLMAdapter methodsFor: 'prompting' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
prompt: aPrompt context: aContext tools: aToolNames

	model
		prompt: aPrompt;
		context: aContext;
		toolNames: aToolNames;
		run.

	^LLMResponse
		cost: model nextPromptCost
		answer: model nextPrompt
		toolNames: model tools! !


!ExpensiveLLMAdapter methodsFor: 'testing for end' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
shouldStopOn: anAnswer

	^model hasToStopWith: anAnswer! !


!classDefinition: #LLMResponse category: #'2026-2C-2doParcial'!
Object subclass: #LLMResponse
	instanceVariableNames: 'cost answer toolNames'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!LLMResponse methodsFor: 'initialization' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
initializeCost: aCost answer: anAnswer toolNames: aToolNames

	cost := aCost.
	answer := anAnswer.
	toolNames := aToolNames! !


!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
answer

	^answer! !

!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cost

	^cost! !

!LLMResponse methodsFor: 'accessing' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
toolNames

	^toolNames! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LLMResponse class' category: #'2026-2C-2doParcial'!
LLMResponse class
	instanceVariableNames: ''!

!LLMResponse class methodsFor: 'instance creation' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cost: aCost answer: anAnswer toolNames: aToolNames

	^self new initializeCost: aCost answer: anAnswer toolNames: aToolNames! !


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


!ModelContextProtocolServer methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
executeToolNamed: aName with: anAnswer

	^(self toolNamed: aName) executeWith: anAnswer! !

!ModelContextProtocolServer methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
qualifiedToolNames

	^tools collect: [ :aTool | name, '/', aTool name ]! !


!ModelContextProtocolServer methodsFor: 'tools - private' stamp: 'HAW 24/Nov/2026, 11:24:36 pm (UTC)'!
toolNamed: aName

	^tools detect: [ :aTool | aTool name = aName ]! !

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

!ModelContextProtocolServer class methodsFor: 'preconditions' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
assertNamesAreUniqueIn: aTools

	(aTools collect: [ :aTool | aTool name ]) asSet size = aTools size
		ifFalse: [ self error: self repeatedToolNameErrorDescription ]! !


!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
nameCannotBeEmptyErrorDescription

	^'A server name cannot be empty'! !

!ModelContextProtocolServer class methodsFor: 'error descriptions' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
repeatedToolNameErrorDescription

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
	instanceVariableNames: 'evaluatedAnswers createdFiles llm'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentTest methodsFor: 'setup' stamp: 'HAW 24/Nov/2026, 11:23:50 pm (UTC)'!
setUp

	evaluatedAnswers := OrderedCollection new.
	createdFiles := OrderedCollection new! !


!CodingAgentTest methodsFor: 'servers' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
fileSystemServer

	^ModelContextProtocolServer
		named: 'FileSystem'
		tools: (Array with: self createFileTool)! !

!CodingAgentTest methodsFor: 'servers' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
smalltalkServer

	^ModelContextProtocolServer
		named: 'Smalltalk'
		tools: (Array with: self evaluateTool)! !


!CodingAgentTest methodsFor: 'llms' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
cheapLLMEndingImmediately

	^CheapLLMAdapter on: (CheapLLM answers: (Array with: ''))! !


!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
test01ServerNamesMustBeUniqueInAgent

	self
		should: [
			CodingAgent
				availableMoney: self initialMoney
				servers: (Array with: self smalltalkServer with: self smalltalkServer)
				llm: self cheapLLMEndingImmediately ]
		raise: Error
		withMessageText: CodingAgent serverNamesMustBeUniqueErrorDescription! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test02AgentWithoutMoneyCannotPrompt

	| agent |

	agent := self configuredWith: 0*dollar using: self cheapLLMEndingImmediately.

	self
		should: [ agent prompt: 'hello' ]
		raise: Error
		withMessageText: CodingAgent noMoneyAvailableErrorDescription.
	self assert: agent availableMoney equals: 0*dollar.
	self assertNoToolWasExecuted! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test03PromptEndingImmediatelyChargesItsCostAndExecutesNoTool

	| agent |

	llm := CheapLLM answers: #('').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assert: agent spent: (self costOfPrompts: #('hello')).
	self assertNoToolWasExecuted! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test04ToolsAnsweredByLLMAreExecutedWithItsAnswerUntilItStops

	| agent |

	llm := CheapLLM answers: #('continue' '') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test05SeveralToolsOfDifferentServersAnsweredByLLMAreAllExecuted

	| agent toolNames |

	toolNames := 'Smalltalk/evaluate,FileSystem/createFile'.
	llm := CheapLLM answers: #('continue' '') toolsToExecute: (Array with: toolNames with: '').
	agent := self configuredWithBothServersUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assertCreated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue') tools: toolNames)! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test06ContextKeepsPromptsOfPreviousLoops

	| agent |

	llm := CheapLLM answers: #('' '').
	agent := self configuredUsing: (CheapLLMAdapter on: llm).

	agent prompt: 'hello'.
	agent prompt: 'bye'.

	self assertNoToolWasExecuted.
	self assert: agent spent: (self costOfPrompts: #('hello' 'bye'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:54 pm (UTC)'!
test07LoopCannotContinueWhenMoneyRunsOut

	| agent money |

	money := 0.01*dollar.
	llm := CheapLLM answers: #('continue' '') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredWith: money using: (CheapLLMAdapter on: llm).

	self
		should: [ agent prompt: 'hello' ]
		raise: Error
		withMessageText: CodingAgent noMoneyAvailableErrorDescription.
	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello')) from: money! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test08AffordableLLMIsPromptedLikeAnyOtherLLM

	| agent |

	llm := AffordableLLM answers: #('continue' 'stop') toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (AffordableLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !

!CodingAgentTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
test09ExpensiveLLMIsPromptedLikeAnyOtherLLM

	| agent |

	llm := ExpensiveLLM answers: #('continue' nil) toolsToExecute: #('Smalltalk/evaluate' '').
	agent := self configuredUsing: (ExpensiveLLMAdapter on: llm).

	agent prompt: 'hello'.

	self assertEvaluated: #('continue').
	self assert: agent spent: (self costOfPrompts: #('hello' 'continue'))! !


!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
configuredUsing: aLLM

	^self configuredWith: self initialMoney using: aLLM! !

!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
configuredWith: aMoney using: aLLM

	^CodingAgent
		availableMoney: aMoney
		servers: (Array with: self smalltalkServer)
		llm: aLLM! !

!CodingAgentTest methodsFor: 'agents' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
configuredWithBothServersUsing: aLLM

	^CodingAgent
		availableMoney: self initialMoney
		servers: (Array with: self smalltalkServer with: self fileSystemServer)
		llm: aLLM! !


!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
costOfPrompting: aPrompt withContext: aContext tools: aToolNames

	^(llm costOfPrompt: aPrompt)
		+ (llm costOfContext: aContext)
		+ (llm costOfTools: aToolNames)! !

!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
costOfPrompts: aPrompts

	^self costOfPrompts: aPrompts tools: self smalltalkToolNames! !

!CodingAgentTest methodsFor: 'costs' stamp: 'HAW 24/Nov/2026, 11:31:54 pm (UTC)'!
costOfPrompts: aPrompts tools: aToolNames

	| context total |

	context := ''.
	total := 0*dollar.
	aPrompts do: [ :aPrompt |
		total := total
			+ (self costOfPrompting: aPrompt withContext: context tools: aToolNames).
		context := context, aPrompt ].

	^total! !


!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:24:35 pm (UTC)'!
assert: aMoney isCloseTo: anExpectedMoney

	self assert: (aMoney - anExpectedMoney) abs < (0.001*dollar)! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assert: anAgent spent: aCost

	self assert: anAgent spent: aCost from: self initialMoney! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assert: anAgent spent: aCost from: anInitialMoney

	self assert: anAgent availableMoney isCloseTo: anInitialMoney - aCost! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertCreated: aFiles

	self assert: createdFiles asArray equals: aFiles! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertEvaluated: anAnswers

	self assert: evaluatedAnswers asArray equals: anAnswers! !

!CodingAgentTest methodsFor: 'assertions' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
assertNoToolWasExecuted

	self assert: evaluatedAnswers isEmpty.
	self assert: createdFiles isEmpty! !


!CodingAgentTest methodsFor: 'money' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
initialMoney

	^10*dollar! !


!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
createFileTool

	^Tool named: 'createFile' doing: [ :anAnswer | createdFiles add: anAnswer ]! !

!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
evaluateTool

	^Tool named: 'evaluate' doing: [ :anAnswer | evaluatedAnswers add: anAnswer ]! !

!CodingAgentTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
smalltalkToolNames

	^'Smalltalk/evaluate'! !


!classDefinition: #ModelContextProtocolServerTest category: #'2026-2C-2doParcial'!
TestCase subclass: #ModelContextProtocolServerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:29:40 pm (UTC)'!
test01ServerNameCannotBeEmpty

	self
		should: [
			ModelContextProtocolServer
				named: ''
				tools: (Array with: self evaluateTool) ]
		raise: Error
		withMessageText: ModelContextProtocolServer nameCannotBeEmptyErrorDescription! !

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:22:32 pm (UTC)'!
test02ServerMustHaveTools

	self
		should: [ ModelContextProtocolServer named: 'Smalltalk' tools: #() ]
		raise: Error
		withMessageText: ModelContextProtocolServer toolsCannotBeEmptyErrorDescription! !

!ModelContextProtocolServerTest methodsFor: 'tests' stamp: 'HAW 24/Nov/2026, 11:32:13 pm (UTC)'!
test03ToolNamesMustBeUniqueInServer

	self
		should: [
			ModelContextProtocolServer
				named: 'Smalltalk'
				tools: self toolsNamedAlike ]
		raise: Error
		withMessageText: ModelContextProtocolServer repeatedToolNameErrorDescription! !


!ModelContextProtocolServerTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:22:13 pm (UTC)'!
evaluateTool

	^Tool named: 'evaluate' doing: [ :anAnswer | ]! !

!ModelContextProtocolServerTest methodsFor: 'tools' stamp: 'HAW 24/Nov/2026, 11:31:35 pm (UTC)'!
toolsNamedAlike

	^Array with: self evaluateTool with: self evaluateTool! !


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
