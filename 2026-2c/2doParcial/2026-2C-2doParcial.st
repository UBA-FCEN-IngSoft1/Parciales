!classDefinition: #CodingAgent category: '2026-2C-2doParcial'!
Object subclass: #CodingAgent
	instanceVariableNames: 'budget mcpServers llm context'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgent methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 9:41:20 pm (UTC)'!
initializeBudgetOf: aBudget mcpServer: aMCPServers using: aLLM 
	
	budget := aBudget.
	mcpServers := aMCPServers.
	llm := CodingAgentToLLMAdapter for: aLLM.
	
	context := ''.
	! !


!CodingAgent methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:06:41 pm (UTC)'!
prompt: aPrompt

	| response currentPrompt  tools |
	
	currentPrompt := aPrompt.
	tools := self toolNames.
	
	[ self assertHasBudget.
	
	response := llm prompt: currentPrompt context: context tools: tools.
	self
		reduceBudgetBy: response cost;
		executeToolsOf: response;
		increaseContextWith: currentPrompt.
	
	currentPrompt := response nextPrompt.
	llm shouldStopOn: currentPrompt ] whileFalse.
	
	! !


!CodingAgent methodsFor: 'budget' stamp: 'HAW 14/Nov/2026, 10:07:36 pm (UTC)'!
assertHasBudget

	budget <= (0*dollar) ifTrue: [ self error: self class noBudgetToPromptErrorDescription ]! !

!CodingAgent methodsFor: 'budget' stamp: 'HAW 14/Nov/2026, 2:36:03 pm (UTC)'!
budget
	
	^budget! !

!CodingAgent methodsFor: 'budget' stamp: 'HAW 14/Nov/2026, 10:05:33 pm (UTC)'!
reduceBudgetBy: aCost

	budget := budget - aCost! !


!CodingAgent methodsFor: 'tools' stamp: 'HAW 14/Nov/2026, 3:35:45 pm (UTC)'!
executeToolNamed: aCompleteToolNamed with: aPrompt

	| mcpServerName toolToExecuteComponents |
	
	toolToExecuteComponents := aCompleteToolNamed substringsSeparatedBy: $/.
	mcpServerName := toolToExecuteComponents first.
	(mcpServers detect: [:mcpServer |  mcpServer isNamed: mcpServerName ])
		executeToolNamed: toolToExecuteComponents second with: aPrompt ! !

!CodingAgent methodsFor: 'tools' stamp: 'HAW 14/Nov/2026, 3:57:26 pm (UTC)'!
executeToolsOf: response

	| toolsToExecute prompt |
	
	toolsToExecute := response toolsToExecute.
	toolsToExecute isEmpty ifTrue: [ ^self ].
	
	prompt := response nextPrompt.
	(toolsToExecute substringsSeparatedBy: $,) 
		do: [ :aCompleteToolNamed | self executeToolNamed: aCompleteToolNamed with: prompt]! !

!CodingAgent methodsFor: 'tools' stamp: 'HAW 14/Nov/2026, 3:32:43 pm (UTC)'!
toolNames

	^ String streamContents: [ :stream | 
		mcpServers 
			do: [ :mcpServer | mcpServer writeToolNamesOn: stream ]
			separatedBy: [ stream nextPut: $, ]]! !


!CodingAgent methodsFor: 'context' stamp: 'HAW 14/Nov/2026, 10:06:00 pm (UTC)'!
increaseContextWith: currentPrompt

	^ context := context, currentPrompt! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgent class' category: '2026-2C-2doParcial'!
CodingAgent class
	instanceVariableNames: ''!

!CodingAgent class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 9:50:38 pm (UTC)'!
budgetOf: aBudget mcpServer: aMCPServers using: aLLM 

	self assertMCPServersAreUnique: aMCPServers.
	
	^self new initializeBudgetOf: aBudget mcpServer: aMCPServers using: aLLM ! !


!CodingAgent class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 9:37:56 pm (UTC)'!
mcpServerNamesMustBeUniqueErrorDescription
	
	^'MCP server names must be unique'! !

!CodingAgent class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 2:35:57 pm (UTC)'!
noBudgetToPromptErrorDescription
	
	^'There is not enough money to prompt the LLM'! !


!CodingAgent class methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:50:38 pm (UTC)'!
assertMCPServersAreUnique: aMCPServers

	^ (aMCPServers collect: [:aMCPServer | aMCPServer name]) asSet size = aMCPServers size 
		ifFalse: [ self error: self mcpServerNamesMustBeUniqueErrorDescription ]! !


!classDefinition: #CodingAgentMCPServer category: '2026-2C-2doParcial'!
Object subclass: #CodingAgentMCPServer
	instanceVariableNames: 'name tools'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentMCPServer methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 2:59:53 pm (UTC)'!
initializeNamed: aName withTools: aTools 
	
	name := aName.
	tools := aTools.! !


!CodingAgentMCPServer methodsFor: 'tools' stamp: 'HAW 14/Nov/2026, 3:31:05 pm (UTC)'!
executeToolNamed: aToolName with: aPrompt 
	
	| toolToExecute |
	
	toolToExecute := tools detect: [:aTool | aTool isNamed: aToolName ].
	
	toolToExecute execute: aPrompt! !

!CodingAgentMCPServer methodsFor: 'tools' stamp: 'HAW 14/Nov/2026, 3:07:50 pm (UTC)'!
writeToolNamesOn: aStream

	tools 
		do: [ :aTool | aStream nextPutAll: name; nextPut: $/; nextPutAll: aTool name]
		separatedBy: [ aStream nextPut: $, ]! !


!CodingAgentMCPServer methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 3:30:16 pm (UTC)'!
isNamed: aName

	^name = aName ! !

!CodingAgentMCPServer methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 9:39:01 pm (UTC)'!
name
	
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgentMCPServer class' category: '2026-2C-2doParcial'!
CodingAgentMCPServer class
	instanceVariableNames: ''!

!CodingAgentMCPServer class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 9:50:04 pm (UTC)'!
named: aName withTools: aTools 
	
	self assertNameIsNotBlanks: aName.
	self assertHasTools: aTools.
	self assertToolsAreUnique: aTools.
	
	^self new initializeNamed: aName withTools: aTools ! !


!CodingAgentMCPServer class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 9:31:27 pm (UTC)'!
invalidNameErrorDescription
	
	^'MCP server name cannot be empty'! !

!CodingAgentMCPServer class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 9:32:28 pm (UTC)'!
mcpServerMustHaveToolsErrorDescription
	
	^'MCP server must have tools'! !

!CodingAgentMCPServer class methodsFor: 'error description' stamp: 'HAW 14/Nov/2026, 9:35:27 pm (UTC)'!
toolNamesMustBeUniqueErrorDescription
	
	^'Tool names must be unique'! !


!CodingAgentMCPServer class methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:49:54 pm (UTC)'!
assertHasTools: aTools

	^ aTools isEmpty ifTrue: [ self error: self mcpServerMustHaveToolsErrorDescription ]! !

!CodingAgentMCPServer class methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:49:47 pm (UTC)'!
assertNameIsNotBlanks: aName

	^ aName withBlanksTrimmed isEmpty ifTrue: [ self error: self invalidNameErrorDescription ]! !

!CodingAgentMCPServer class methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:50:04 pm (UTC)'!
assertToolsAreUnique: aTools

	^ (aTools collect: [ :aTool | aTool name ]) asSet size = aTools size ifFalse: [ self error: self toolNamesMustBeUniqueErrorDescription ]! !


!classDefinition: #CodingAgentToLLMAdapter category: '2026-2C-2doParcial'!
Object subclass: #CodingAgentToLLMAdapter
	instanceVariableNames: 'llm'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentToLLMAdapter methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 4:08:39 pm (UTC)'!
initializeAdapting: aLLM 
	
	llm := aLLM.! !


!CodingAgentToLLMAdapter methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 9:40:01 pm (UTC)'!
prompt: prompt context: context tools: tools

	self subclassResponsibility! !


!CodingAgentToLLMAdapter methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 9:40:06 pm (UTC)'!
shouldStopOn: prompt

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgentToLLMAdapter class' category: '2026-2C-2doParcial'!
CodingAgentToLLMAdapter class
	instanceVariableNames: ''!

!CodingAgentToLLMAdapter class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 4:08:00 pm (UTC)'!
adapting: aLLM 
	
	^self new initializeAdapting: aLLM ! !

!CodingAgentToLLMAdapter class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 4:07:27 pm (UTC)'!
for: aLLM 
	
	^(self subclasses detect: [ :anLLMAdapterClass | anLLMAdapterClass isFor: aLLM ]) adapting: aLLM! !


!CodingAgentToLLMAdapter class methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 9:39:33 pm (UTC)'!
isFor: aLLM

	self subclassResponsibility! !


!classDefinition: #CodingAgentToAffordableLLMAdapter category: '2026-2C-2doParcial'!
CodingAgentToLLMAdapter subclass: #CodingAgentToAffordableLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentToAffordableLLMAdapter methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 4:10:49 pm (UTC)'!
prompt: prompt context: context tools: tools 
	
	| llmResponse |
	
	llmResponse := llm responseOf: (String streamContents: [:stream |
			stream nextPutAll: prompt; newLine; nextPutAll: context; newLine; nextPutAll: tools; newLine ]).
		
	^ PromptResponse 
			cost: (llmResponse at: #cost) 
			nextPrompt: (llmResponse at: #answer)
			toolsToExecute: (llmResponse at: #tools).! !


!CodingAgentToAffordableLLMAdapter methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:11:01 pm (UTC)'!
shouldStopOn: prompt 
	
	^llm hasFinshed: prompt ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgentToAffordableLLMAdapter class' category: '2026-2C-2doParcial'!
CodingAgentToAffordableLLMAdapter class
	instanceVariableNames: ''!

!CodingAgentToAffordableLLMAdapter class methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:08:58 pm (UTC)'!
isFor: aLLM 
	
	^aLLM isKindOf: AffordableLLM ! !


!classDefinition: #CodingAgentToCheapLLMAdapter category: '2026-2C-2doParcial'!
CodingAgentToLLMAdapter subclass: #CodingAgentToCheapLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentToCheapLLMAdapter methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 4:09:43 pm (UTC)'!
prompt: prompt context: context tools: tools 
	
	| llmResponse |
	
	llmResponse := llm prompt: (Array with: prompt with: context with: tools).
	
	^PromptResponse 
			cost: llmResponse first 
			nextPrompt: llmResponse second 
			toolsToExecute: llmResponse third.! !


!CodingAgentToCheapLLMAdapter methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:10:20 pm (UTC)'!
shouldStopOn: prompt 
	
	^llm stopsOn: prompt ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgentToCheapLLMAdapter class' category: '2026-2C-2doParcial'!
CodingAgentToCheapLLMAdapter class
	instanceVariableNames: ''!

!CodingAgentToCheapLLMAdapter class methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:07:47 pm (UTC)'!
isFor: aLLM 
	
	^aLLM isKindOf: CheapLLM ! !


!classDefinition: #CodingAgentToExpensiveLLMAdapter category: '2026-2C-2doParcial'!
CodingAgentToLLMAdapter subclass: #CodingAgentToExpensiveLLMAdapter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!CodingAgentToExpensiveLLMAdapter methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:13:59 pm (UTC)'!
prompt: prompt context: context tools: tools 
	
	llm prompt: prompt.
	llm context: context.
	llm toolNames: tools.
	llm run.
	
	^PromptResponse 
		cost: llm nextPromptCost 
		nextPrompt: llm nextPrompt 
		toolsToExecute: llm tools ! !


!CodingAgentToExpensiveLLMAdapter methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:14:16 pm (UTC)'!
shouldStopOn: prompt 
	
	^llm hasToStopWith: prompt ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CodingAgentToExpensiveLLMAdapter class' category: '2026-2C-2doParcial'!
CodingAgentToExpensiveLLMAdapter class
	instanceVariableNames: ''!

!CodingAgentToExpensiveLLMAdapter class methodsFor: 'testing' stamp: 'HAW 14/Nov/2026, 4:12:18 pm (UTC)'!
isFor: aLLM 
	
	^aLLM isKindOf: ExpensiveLLM ! !


!classDefinition: #MCPServerTool category: '2026-2C-2doParcial'!
Object subclass: #MCPServerTool
	instanceVariableNames: 'name block'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!MCPServerTool methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 2:59:33 pm (UTC)'!
initializeNamed: aName executing: aBlock 
	
	name := aName.
	block := aBlock.! !


!MCPServerTool methodsFor: 'executing' stamp: 'HAW 14/Nov/2026, 3:17:10 pm (UTC)'!
execute: aPrompt 
	
	block value: aPrompt ! !


!MCPServerTool methodsFor: 'name' stamp: 'HAW 14/Nov/2026, 3:22:40 pm (UTC)'!
isNamed: toolNameToExecute 
	
	^name = toolNameToExecute ! !

!MCPServerTool methodsFor: 'name' stamp: 'HAW 14/Nov/2026, 3:04:21 pm (UTC)'!
name
	
	^name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MCPServerTool class' category: '2026-2C-2doParcial'!
MCPServerTool class
	instanceVariableNames: ''!

!MCPServerTool class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 9:51:02 pm (UTC)'!
named: aName executing: aBlock 
	
	self assertNameIsNotBlanks: aName.
	
	^self new initializeNamed: aName executing: aBlock ! !


!MCPServerTool class methodsFor: 'error descriptions' stamp: 'HAW 14/Nov/2026, 9:28:23 pm (UTC)'!
invalidNameErrorDescription
	
	^'Tool name cannot be empty'! !


!MCPServerTool class methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:51:02 pm (UTC)'!
assertNameIsNotBlanks: aName

	^ aName withBlanksTrimmed isEmpty ifTrue: [ self error: self invalidNameErrorDescription ]! !


!classDefinition: #PromptResponse category: '2026-2C-2doParcial'!
Object subclass: #PromptResponse
	instanceVariableNames: 'cost nextPrompt toolsToExecute'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!PromptResponse methodsFor: 'initialization' stamp: 'HAW 14/Nov/2026, 3:56:55 pm (UTC)'!
initializeCost: aCost nextPrompt: aNextPrompt toolsToExecute: aToolsToExecute 
	
	cost := aCost.
	nextPrompt := aNextPrompt.
	toolsToExecute := aToolsToExecute.! !


!PromptResponse methodsFor: 'accessing' stamp: 'HAW 14/Nov/2026, 3:57:03 pm (UTC)'!
cost
	
	^cost! !

!PromptResponse methodsFor: 'accessing' stamp: 'HAW 14/Nov/2026, 3:57:39 pm (UTC)'!
nextPrompt
	
	^nextPrompt! !

!PromptResponse methodsFor: 'accessing' stamp: 'HAW 14/Nov/2026, 3:57:30 pm (UTC)'!
toolsToExecute
	
	^toolsToExecute! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PromptResponse class' category: '2026-2C-2doParcial'!
PromptResponse class
	instanceVariableNames: ''!

!PromptResponse class methodsFor: 'instance creation' stamp: 'HAW 14/Nov/2026, 3:56:50 pm (UTC)'!
cost: aCost nextPrompt: aNextPrompt toolsToExecute: aToolsToExecute 
	
	^self new initializeCost: aCost nextPrompt: aNextPrompt toolsToExecute: aToolsToExecute ! !


!classDefinition: #AgenticCodeTest category: '2026-2C-2doParcial'!
TestCase subclass: #AgenticCodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:43:01 pm (UTC)'!
test01_CannotPromptWhenThereIsNoBudget

	| agent |
	
	agent := CodingAgent 
		budgetOf: 0*dollar 
		mcpServer: #() 
		using: (CheapLLM answers: (Array with: 'something')).
	
	self 
		should: [ agent prompt: 'hello' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CodingAgent noBudgetToPromptErrorDescription.
			self assertBudgetOf: agent is: 0*dollar ]! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:52:46 pm (UTC)'!
test02_CostForOnePromptIsTheExpected

	| agent llm |
	
	llm := CheapLLM answers: (Array with: '').
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: #() 
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello')! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:53:02 pm (UTC)'!
test03_CostForMoreThanOnePromptIsTheExpected

	| agent llm |
	
	llm := CheapLLM answers: (Array with: 'continue' with: '').
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: #() 
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello') - (llm costOfPrompt: 'continue') - (llm costOfContext: 'hello')! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:52:46 pm (UTC)'!
test04_CannotPromptAfterPromptingWhenThereIsNoBudget

	| agent llm |
	
	llm := CheapLLM answers: (Array with: 'continue' with: '').
	agent := CodingAgent 
		budgetOf: 0.0001*dollar 
		mcpServer: #() 
		using: llm.
	
	self 
		should: [ agent prompt: 'hello' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: CodingAgent noBudgetToPromptErrorDescription.
			self assertBudgetOf: agent is: 0.0001*dollar - (llm costOfPrompt: 'hello') ]! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:53:02 pm (UTC)'!
test05_ConxtextIsConcatenatedBetweenDifferentPrompts

	| agent llm |
	
	llm := CheapLLM answers: (Array with: '' with: '').
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: #() 
		using: llm.
	
	agent prompt: 'hello'.
	agent prompt: 'bye'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello') - (llm costOfPrompt: 'bye') - (llm costOfContext: 'hello')! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test06_CostOfOneToolOfOneMCPServerIsTheExpected

	| agent llm evaluateTool smallalktMCPServer |
	
	llm := CheapLLM answers: (Array with: '').
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello') - (llm costOfTools: 'Smalltalk/evaluate') ! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test07_CostOfMoreThatOneToolWithOneMCPServerIsTheExpected

	| agent llm evaluateTool smallalktMCPServer debugTool |
	
	llm := CheapLLM answers: (Array with: '').
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | ].
	debugTool := MCPServerTool named: 'debug' executing: [ :prompt | ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool with: debugTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello') - (llm costOfTools: 'Smalltalk/evaluate,Smalltalk/debug') ! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test08_CostOfMoreThanOneMPCServerIsTheExpected

	| agent llm evaluateTool smallalktMCPServer debugTool fileSystemMCPServer readFile |
	
	llm := CheapLLM answers: (Array with: '').
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | ].
	debugTool := MCPServerTool named: 'debug' executing: [ :prompt | ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool with: debugTool).
	readFile := MCPServerTool named: 'readFile' executing: [ :prompt | ].
	fileSystemMCPServer := CodingAgentMCPServer named: 'FileSystem' withTools: (Array with: readFile).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer with: fileSystemMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - (llm costOfPrompt: 'hello') - (llm costOfTools: 'Smalltalk/evaluate,Smalltalk/debug,FileSystem/readFile') ! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test09_OneToolToExecuteIsExecuted

	| agent llm evaluateTool smallalktMCPServer evaluateToolExecuted debugTool debugToolExecuted |
	
	llm := CheapLLM answers: (Array with: '') toolsToExecute: (Array with: 'Smalltalk/evaluate,Smalltalk/debug').
	evaluateToolExecuted := false.
	debugToolExecuted := false.
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | evaluateToolExecuted := true ].
	debugTool := MCPServerTool named: 'debug' executing: [ :prompt | debugToolExecuted := true ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool with: debugTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assert: evaluateToolExecuted.
	self assert: debugToolExecuted! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test10_MoreThanOneToolCanBeExecuted

	| agent llm evaluateTool smallalktMCPServer evaluateToolExecuted readFileTool readFileExecuted fileSystemMCPServer |
	
	llm := CheapLLM answers: (Array with: '') toolsToExecute: (Array with: 'Smalltalk/evaluate,FileSystem/readFile').
	evaluateToolExecuted := false.
	readFileExecuted := false.
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | evaluateToolExecuted := true ].
	readFileTool := MCPServerTool named: 'readFile' executing: [ :prompt | readFileExecuted := true ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool).
	fileSystemMCPServer := CodingAgentMCPServer named: 'FileSystem' withTools: (Array with: readFileTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer with: fileSystemMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assert: evaluateToolExecuted.
	self assert: readFileExecuted! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test11_CanPromptToAffordableLLM

	| agent llm evaluateTool smallalktMCPServer evaluateToolExecuted |
	
	llm := AffordableLLM answers: (Array with: 'continue' with: 'stop') toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	evaluateToolExecuted := false.
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | evaluateToolExecuted := true ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self assertBudgetOf: agent is: 10*dollar - ((llm costOfPrompt: 'hello') + (llm costOfContext: '') + (llm costOfTools: 'Smalltalk/evaluate')) - 
		((llm costOfPrompt: 'continue') + (llm costOfContext: 'hello') + (llm costOfTools: 'Smalltalk/evaluate')).
	self assert: evaluateToolExecuted 
	! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test12_CanPromptToExpensiveLLM

	| agent llm evaluateTool smallalktMCPServer evaluateToolExecuted |
	
	llm := ExpensiveLLM answers: (Array with: 'continue' with: nil) toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	evaluateToolExecuted := false.
	evaluateTool := MCPServerTool named: 'evaluate' executing: [ :prompt | evaluateToolExecuted := true ].
	smallalktMCPServer := CodingAgentMCPServer named: 'Smalltalk' withTools: (Array with: evaluateTool).
	agent := CodingAgent 
		budgetOf: 10*dollar 
		mcpServer: (Array with: smallalktMCPServer)
		using: llm.
	
	agent prompt: 'hello'.
	
	self 
		assertBudgetOf: agent 
		is: 10*dollar 
		- ((llm costOfPrompt: 'hello') + (llm costOfContext: '') + (llm costOfTools: 'Smalltalk/evaluate')) 
		- (llm costOfPrompt: 'continue') - (llm costOfContext: 'hello') - (llm costOfTools: 'Smalltalk/evaluate').
	self assert: evaluateToolExecuted 
	! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:48:25 pm (UTC)'!
test13_ToolNameCannotBeEmpty

	self 
		should: [ MCPServerTool named: '' executing: [ :prompt | ] ]
		raise: Error
		withMessageText: MCPServerTool invalidNameErrorDescription
		! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 9:48:36 pm (UTC)'!
test14_ToolNameCannotBeBlanks

	self 
		should: [ MCPServerTool named: ' ' executing: [ :prompt | ] ]
		raise: Error
		withMessageText: MCPServerTool invalidNameErrorDescription
		! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test15_MCPServerNameCannotBeBlanks

	self 
		should: [ CodingAgentMCPServer  named: ' ' withTools: (Array with: (MCPServerTool named: 'something' executing: [:prompt| ] )) ]
		raise: Error
		withMessageText: CodingAgentMCPServer invalidNameErrorDescription
		! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test16_MCPServerToolsCannotBeEmpty

	self 
		should: [ CodingAgentMCPServer  named: 'Smalltalk' withTools: #() ]
		raise: Error
		withMessageText: CodingAgentMCPServer mcpServerMustHaveToolsErrorDescription
		! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test17_ToolsMustBeUniqueForAnMCPServer

	| evaluateTool |
	
	evaluateTool := MCPServerTool named: 'evalaute' executing: [:prompt | ].
	self 
		should: [ CodingAgentMCPServer  named: 'Smalltalk' withTools: (Array with: evaluateTool with: evaluateTool) ]
		raise: Error
		withMessageText: CodingAgentMCPServer toolNamesMustBeUniqueErrorDescription
		
		! !

!AgenticCodeTest methodsFor: 'as yet unclassified' stamp: 'HAW 14/Nov/2026, 10:04:16 pm (UTC)'!
test18_MCPServerMustBeUniqueForACodingAgent

	| evaluateTool mcpServer |
	
	evaluateTool := MCPServerTool named: 'evalaute' executing: [:prompt | ].
	mcpServer :=  CodingAgentMCPServer  named: 'Smalltalk' withTools: (Array with: evaluateTool).
	self 
		should: [ CodingAgent 
				budgetOf: 10*dollar 
				mcpServer: (Array with: mcpServer with: mcpServer) 
				using: (AffordableLLM answers: #())]
		raise: Error
		withMessageText: CodingAgent mcpServerNamesMustBeUniqueErrorDescription
		
		! !


!AgenticCodeTest methodsFor: 'assertions' stamp: 'HAW 14/Nov/2026, 9:23:32 pm (UTC)'!
assertBudgetOf: agent is: anExpectedBudget

	self assert: (agent budget - anExpectedBudget) abs < (0.001*dollar)! !
