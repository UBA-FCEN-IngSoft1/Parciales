!classDefinition: #AgenticCodeTest category: #2026-2C-2doParcial!
TestCase subclass: #AgenticCodeTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2026-2C-2doParcial'!

!classDefinition: #LLM category: #LLM!
Object subclass: #LLM
	instanceVariableNames: 'answers toolsToExecute'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LLM'!

!LLM methodsFor: 'initialization' stamp: 'HAW 10/Nov/2026, 10:21:17 pm (UTC)'!
initializeAnswers: anAnswers toolsToExecute: anArrayOfToolNames
	
	answers := ReadStream on: anAnswers.
	toolsToExecute := ReadStream on: anArrayOfToolNames ! !


!LLM methodsFor: 'testing - private' stamp: 'HAW 9/Nov/2026, 7:21:20 pm (UTC)'!
wereAllAnswersConsumed
	
	^answers atEnd! !

!LLM methodsFor: 'testing - private' stamp: 'HAW 10/Nov/2026, 6:53:36 pm (UTC)'!
wereAllToolsConsumed
	
	^toolsToExecute atEnd! !


!LLM methodsFor: 'prompting - private' stamp: 'HAW 10/Nov/2026, 10:48:07 pm (UTC)'!
assert: aToolName isConfiguredIn: aConfiguredTools

	"Si falla acá es porque se le dijo al LLM devolver una tool que no está configurada"
	(aConfiguredTools includesSubString: aToolName) 
		ifFalse: [ self error: aToolName, ' is not a valid tool']! !

!LLM methodsFor: 'prompting - private' stamp: 'HAW 10/Nov/2026, 10:47:51 pm (UTC)'!
assertTools: aTools areValidFor: aConfiguredTools 

	(aTools substringsSeparatedBy: $,) do: [ :aToolName |
		aToolName notEmpty ifTrue: [ self assert: aToolName isConfiguredIn: aConfiguredTools]]! !


!LLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:53:46 pm (UTC)'!
costOfContext: aMemory

	self subclassResponsibility! !

!LLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:53:52 pm (UTC)'!
costOfPrompt: aPrompt

	self subclassResponsibility! !

!LLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:53:56 pm (UTC)'!
costOfTools: aTools

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LLM class' category: #LLM!
LLM class
	instanceVariableNames: ''!

!LLM class methodsFor: 'instance creation' stamp: 'HAW 10/Nov/2026, 10:21:27 pm (UTC)'!
answers: anAnswers

	^self answers: anAnswers toolsToExecute: (Array new: anAnswers size withAll: '')! !

!LLM class methodsFor: 'instance creation' stamp: 'HAW 10/Nov/2026, 10:21:27 pm (UTC)'!
answers: anAnswers toolsToExecute: anArrayOfToolNames

	^self new initializeAnswers: anAnswers toolsToExecute: anArrayOfToolNames! !


!classDefinition: #AffordableLLM category: #LLM!
LLM subclass: #AffordableLLM
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LLM'!

!AffordableLLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:52:00 pm (UTC)'!
costOfContext: aMemory

	^aMemory size / 2 * (0.001*dollar)! !

!AffordableLLM methodsFor: 'cost' stamp: 'HAW 9/Nov/2026, 12:46:38 am (UTC)'!
costOfPrompt: aPrompt

	| numberOfVowels |
	
	numberOfVowels := aPrompt count: [ :char | char isVowel ].
	^ numberOfVowels * (0.01*dollar) + (aPrompt size - numberOfVowels * (0.001*dollar))! !

!AffordableLLM methodsFor: 'cost' stamp: 'HAW 9/Nov/2026, 12:42:24 am (UTC)'!
costOfTools: aTools

	^aTools isEmpty
		ifTrue: [ 0*dollar ]
		ifFalse: [ 0.007*dollar ] 
	
	! !


!AffordableLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 9:52:00 pm (UTC)'!
responseOf: aQuery 
	
	| memory prompt stream tools configuredTools |
	
	stream := aQuery readStream.
	prompt := stream nextLine.
	memory := stream nextLine.
	configuredTools := stream nextLine.
	
	self asssertIsValidQuery: stream.
	
	tools := toolsToExecute next.
	self assertTools: tools areValidFor: configuredTools.
	
	^Dictionary new
		at: #cost put: (self costOfPrompt: prompt)+(self costOfContext: memory)+(self costOfTools: configuredTools);
		at: #answer put: answers next;
		at: #tools put: tools;
		yourself! !


!AffordableLLM methodsFor: 'testing for end' stamp: 'HAW 9/Nov/2026, 10:32:47 pm (UTC)'!
hasFinshed: anAnswer 
	
	^anAnswer = 'stop'! !


!AffordableLLM methodsFor: 'prompting - private' stamp: 'HAW 10/Nov/2026, 10:48:27 pm (UTC)'!
asssertIsValidQuery: stream

	"Si falla acá es porque hicieron mal aQuery"
	stream atEnd ifFalse: [ self error: 'Invalid query' ]! !


!classDefinition: #CheapLLM category: #LLM!
LLM subclass: #CheapLLM
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LLM'!

!CheapLLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:53:02 pm (UTC)'!
costOfContext: aMemory 
	
	^ (aMemory count: [ :char | char isVowel not]) * (0.005*dollar)! !

!CheapLLM methodsFor: 'cost' stamp: 'HAW 14/Nov/2026, 9:52:46 pm (UTC)'!
costOfPrompt: aText

	^ (aText count: [ :char | char isVowel ]) * (0.01*dollar)! !

!CheapLLM methodsFor: 'cost' stamp: 'HAW 9/Nov/2026, 12:23:32 am (UTC)'!
costOfTools: aTools

	^aTools size * (0.0025*dollar)! !


!CheapLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 9:53:02 pm (UTC)'!
prompt: aQuery

	| promptCost memoryCost toolsCost tools |
	
	self assertIsValidQuery: aQuery.
	
	promptCost := self costOfPrompt: aQuery first.
	memoryCost := self costOfContext: aQuery second.
	toolsCost := self costOfTools: aQuery third.
	
	tools := toolsToExecute next.
	self assertTools: tools areValidFor: aQuery third.

	^Array 
		with: promptCost + memoryCost + toolsCost 
		with: answers next 
		with: tools! !


!CheapLLM methodsFor: 'testing for end' stamp: 'HAW 9/Nov/2026, 7:51:34 pm (UTC)'!
stopsOn: anAnswer 
	
	^anAnswer isEmpty ! !


!CheapLLM methodsFor: 'prompting - private' stamp: 'HAW 10/Nov/2026, 10:48:52 pm (UTC)'!
assertIsValidQuery: anArray

	"Se falla acá es porque aQuery no es correcto"
	anArray size = 3 ifFalse: [ self error: 'Invalid prompt' ]! !


!classDefinition: #ExpensiveLLM category: #LLM!
LLM subclass: #ExpensiveLLM
	instanceVariableNames: 'prompt context toolNames nextPromptCost nextPrompt tools'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LLM'!

!ExpensiveLLM methodsFor: 'costs' stamp: 'HAW 14/Nov/2026, 9:53:19 pm (UTC)'!
costOfContext: aMemory
	
	^aMemory size * (0.001*dollar)! !

!ExpensiveLLM methodsFor: 'costs' stamp: 'HAW 9/Nov/2026, 10:38:18 pm (UTC)'!
costOfPrompt: aPrompt
	
	| numberOfConsonant |
	
	numberOfConsonant := aPrompt count: [ :char | char isVowel not ].
	^ numberOfConsonant * (0.015*dollar) ! !

!ExpensiveLLM methodsFor: 'costs' stamp: 'HAW 9/Nov/2026, 10:38:58 pm (UTC)'!
costOfTools: aTools
	
	^aTools size * (0.003*dollar)! !


!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:14:19 pm (UTC)'!
context: aContext

	context := aContext ! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:14:25 pm (UTC)'!
nextPrompt
	
	^nextPrompt! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:14:31 pm (UTC)'!
nextPromptCost
	
	^nextPromptCost! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 9/Nov/2026, 6:57:18 pm (UTC)'!
prompt: aText

	prompt := aText! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 14/Nov/2026, 10:14:31 pm (UTC)'!
run
	
	nextPromptCost := (self costOfPrompt: prompt)+(self costOfContext: context)+(self costOfTools: toolNames).
	nextPrompt := answers next.
	tools := toolsToExecute next.
	
	self assertTools: tools areValidFor: toolNames! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 10/Nov/2026, 6:56:19 pm (UTC)'!
toolNames: aToolNames

	toolNames := aToolNames ! !

!ExpensiveLLM methodsFor: 'prompting' stamp: 'HAW 10/Nov/2026, 8:28:07 pm (UTC)'!
tools
	
	^tools! !


!ExpensiveLLM methodsFor: 'testing for end' stamp: 'HAW 10/Nov/2026, 5:54:09 pm (UTC)'!
hasToStopWith: anAnswer 
	
	^anAnswer isNil! !


!classDefinition: #LLMTest category: #LLM!
TestCase subclass: #LLMTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LLM'!

!LLMTest methodsFor: 'cheap llm' stamp: 'HAW 14/Nov/2026, 9:53:02 pm (UTC)'!
test01_CheapLLM_OnePromptAnswers_TheCostTheResponseAndToolsToExecute

	| model response |
	
	model := CheapLLM answers: (Array with: 'first' with: '') toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	response := model prompt: (Array with: 'hello' with: 'bye' with: 'Smalltalk/evaluate,Smalltalk/debug').
	
	self assert: response first equals: (model costOfPrompt: 'hello')+(model costOfContext: 'bye')+(model costOfTools: 'Smalltalk/evaluate,Smalltalk/debug').
	self assert: response second equals: 'first'.
	self assert: response third equals: 'Smalltalk/evaluate'.
	
	self deny: model wereAllAnswersConsumed.
	self deny: model wereAllToolsConsumed 
	! !

!LLMTest methodsFor: 'cheap llm' stamp: 'HAW 10/Nov/2026, 10:23:39 pm (UTC)'!
test02_CheapLLM_MoreThanOnePromptAnswers_TheConfiguredResponsesAndTools

	| model secondResponse firstResponse |
	
	model := CheapLLM answers: (Array with: 'first' with: '') toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	firstResponse := model prompt: (Array with: 'hello' with: '' with: 'Smalltalk/evaluate,Smalltalk/debug').
	secondResponse := model prompt: (Array with: firstResponse second with: 'hello' with: '').
	
	self assert: secondResponse second equals: ''.
	self assert: secondResponse third equals: ''.
	
	self assert: model wereAllAnswersConsumed.
	self assert: model wereAllToolsConsumed 
	! !


!LLMTest methodsFor: 'affordable llm' stamp: 'HAW 10/Nov/2026, 10:22:22 pm (UTC)'!
queryFor: aPrompt memory: aMemory tools: aTools

	^(WriteStream on: String new)
		nextPutAll: aPrompt; newLine;
		nextPutAll: aMemory; newLine;
		nextPutAll: aTools; newLine;
		contents! !

!LLMTest methodsFor: 'affordable llm' stamp: 'HAW 14/Nov/2026, 9:52:15 pm (UTC)'!
test03_AffordableLLM_OnePromptAnswers_TheCostTheResponseAndToolsToExecute

	| model response query |
	
	model := AffordableLLM answers: (Array with: 'first' with: '') toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	query := self queryFor: 'hello' memory: 'bye' tools: 'Smalltalk/evaluate,Smalltalk/debug'.
	response := model responseOf: query.
	
	self 
		assert: (response at: #cost) 
		equals: (model costOfPrompt: 'hello')+(model costOfContext: 'bye')+(model costOfTools: 'Smalltalk/evaluate,Smalltalk/debug').
	self assert: (response at: #answer) equals: 'first'.
	self assert: (response at: #tools) equals: 'Smalltalk/evaluate'.
	
	self deny: model wereAllAnswersConsumed.
	self deny: model wereAllToolsConsumed 
! !

!LLMTest methodsFor: 'affordable llm' stamp: 'HAW 10/Nov/2026, 10:27:00 pm (UTC)'!
test04_AffordableLLM_MoreThanOnePromptAnswers_TheConfiguredResponsesAndTools

	| model firstResponse secondResponse |
	
	model := AffordableLLM answers: (Array with: 'first' with: 'stop') toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	firstResponse := model responseOf: (self queryFor: 'hello' memory: '' tools: 'Smalltalk/evaluate,Smalltalk/debug').
	secondResponse := model responseOf: (self queryFor: (firstResponse at: #answer) memory: 'hello' tools: '').
	
	self assert: (secondResponse at: #answer) equals: 'stop'.
	self assert: (secondResponse at: #tools) equals: ''.
	
	self assert: model wereAllAnswersConsumed .
	self assert: model wereAllToolsConsumed 
! !


!LLMTest methodsFor: 'expensive llm' stamp: 'HAW 14/Nov/2026, 10:14:13 pm (UTC)'!
test05_ExpensiveLLM_OnePromptAnswers_TheCostTheResponseAndToolsToExecute

	| model |
	
	model := ExpensiveLLM answers: (Array with: 'first' with: nil) toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	model prompt: 'hello'.
	model context: 'bye'.
	model toolNames: 'Smalltalk/evaluate,Smalltalk/debug'.
	
	model run.
	
	self 
		assert: model nextPromptCost
		equals: (model costOfPrompt: 'hello')+(model costOfContext: 'bye')+(model costOfTools: 'Smalltalk/evaluate,Smalltalk/debug').
	self assert: model nextPrompt equals: 'first'.
	self assert: model tools equals: 'Smalltalk/evaluate'.
	
	self deny: model wereAllAnswersConsumed.
	self deny: model wereAllToolsConsumed 
 
	! !

!LLMTest methodsFor: 'expensive llm' stamp: 'HAW 14/Nov/2026, 10:13:59 pm (UTC)'!
test06_ExpensiveLLM_MoreThanOnePromptAnswers_TheConfiguredResponsesAndTools

	| model |
	
	model := ExpensiveLLM answers: (Array with: 'first' with: nil) toolsToExecute: (Array with: 'Smalltalk/evaluate' with: '').
	
	model
		prompt: 'hello';
		context: '';
		toolNames: 'Smalltalk/evaluate,Smalltalk/debug';
		run.
	
	model
		prompt: model nextPrompt;
		context: 'hello';
		toolNames: '';
		run.
	
	self assert: model nextPrompt isNil.
	self assert: model tools isEmpty.
	
	self assert: model wereAllAnswersConsumed .
	self assert: model wereAllToolsConsumed 

	! !
