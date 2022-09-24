!classDefinition: #CrewTest category: 'ISW1-2022-2C-1erParcial'!
TestCase subclass: #CrewTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:37'!
test01MovingCrewToTreePlaceDoesNotMove

	| island crew crewPosition treePosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.
			
	crew moveTo: treePosition.
	
	self deny: (island hasCrewAt: treePosition).
	self assert: (island hasCrewAt: crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:46'!
test02MovingCrewToTreePlaceFilibusteroRemovesTree

	| island crew treePosition crewPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	self deny: (island isEmptyAt: treePosition).
				
	crew moveTo: treePosition.

	self assert: (island isEmptyAt: treePosition).
	
	self deny: (island hasCrewAt: treePosition).
	self assert: (island hasCrewAt: crewPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:37:55'!
test03MovingCrewToFreePlace

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.

	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	nextPosition := 2@1.
	self assert: (island isEmptyAt: nextPosition).
	
	crew moveTo: nextPosition.

	self deny: (island hasCrewAt: crewPosition).
	self assert: (island hasCrewAt: nextPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:05'!
test04MovingCrewToFreePlaceCorsarioWritesDirectionInMap

	| island crew treePosition crewPosition nextPosition map |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: 3@3).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	nextPosition := 2@1.
	self assert: map isEmpty.

	crew moveTo: nextPosition.

	self assert: map stepsSize equals: 1. 
	self assert: map lastPosition equals: nextPosition.
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:15'!
test05CrewCannotBuryTreasureIfBucaneroCannotDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	
	self 
		should: [ crew buryTreasureAt: 3@1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Bucanero cannotDigErrorDescription.
			self deny: map hasTreasureMark ]
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:25'!
test06CrewCanBuryTreasureIfBucaneroCanDig

	| island crew treePosition crewPosition map digPosition |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.
	
	self assert: map hasTreasureMark.
	
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:34'!
test07CaptainCanUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	pirate aCaptainIWasMeantToBe.
	
	self assert: (pirate searchTreasureIn: island with: map)! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/22/2022 16:38:42'!
test08SimplePirateCannotUseMap

	| island crew treePosition crewPosition map digPosition pirate |
	
	crewPosition := 1@1.
	treePosition := 1@2.
	digPosition := 2@2.
	
	island := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition)
		digsAt: (OrderedCollection with: digPosition).
	
	map := Map of: island crewStartsAt: crewPosition.
	
	crew := Crew 
			at: island 
			composedBy: (OrderedCollection with: (Corsario with: map) with: Filibustero new with: Bucanero new)
			at: crewPosition.

	crew moveTo: 2@1.
	crew buryTreasureAt: 2@2.

	pirate := Bucanero new.
	
	self 
		should: [ pirate searchTreasureIn: island with: map ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: 'I am a simple pirate!!'
! !


!classDefinition: #Bucanero category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Bucanero
	instanceVariableNames: 'rank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Bucanero methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:04:57'!
aCaptainIWasMeantToBe

	rank := #Captain! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 20:31:48'!
initialize

	rank := #SimplePirate! !

!Bucanero methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:19'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bucanero class' category: 'ISW1-2022-2C-1erParcial'!
Bucanero class
	instanceVariableNames: ''!

!Bucanero class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 17:12:39'!
cannotDigErrorDescription

	^ 'Arrgh!! I cannot dig this type of terrain!!'.! !


!classDefinition: #Corsario category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Corsario
	instanceVariableNames: 'rank map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:05:03'!
aCaptainIWasMeantToBe

	rank := #Captain! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 22:43:57'!
drawDirectionTo: aPosition

	map nextStep: aPosition - (map lastPosition).
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:22'!
drawTreasureMarkAt: aPosition

	map nextStep: aPosition - map lastPosition.
	map treasureMarkAt: aPosition.
	
! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:04:09'!
initialize

	rank := #NoRank! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 20:32:06'!
initializeWith: aMap

	rank := #SimplePirate.
	map := aMap! !

!Corsario methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:27'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Corsario class' category: 'ISW1-2022-2C-1erParcial'!
Corsario class
	instanceVariableNames: ''!

!Corsario class methodsFor: 'as yet unclassified' stamp: 'FRT 9/15/2022 21:46:08'!
with: aMap

	^ self new initializeWith: aMap.! !


!classDefinition: #Crew category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Crew
	instanceVariableNames: 'island pirates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Crew methodsFor: 'as yet unclassified' stamp: 'HAW 9/22/2022 16:16:45'!
buryTreasureAt: aPosition

	| ix terrain |
	
	terrain := island terrainAt: aPosition.
	
	ix := 1.
	[ix <= pirates size] whileTrue: [ | pirate |
		pirate := pirates at: ix.
		
		(pirate isKindOf: Corsario) ifTrue: [ 
			terrain = #Tree ifTrue: [].
			terrain = #Empty ifTrue: [].
			terrain = #Diggable ifTrue: [ 				pirate drawTreasureMarkAt: aPosition ].
		].
		
		(pirate isKindOf: Filibustero) ifTrue: [
			terrain = #Tree ifTrue: [].
			terrain = #Empty ifTrue: [].
			terrain = #Diggable ifTrue: [].
		].
		
		(pirate isKindOf: Bucanero) ifTrue: [
			terrain = #Tree ifTrue: [ self error: 'Arrgh!! I cannot dig this type of terrain!!' ].
			terrain = #Empty ifTrue: [ self error: 'Arrgh!! I cannot dig this type of terrain!!' ]	.
			terrain = #Diggable ifTrue: [ island receiveTreasureAt: aPosition ].
		].
		
		ix := ix + 1.
	].
	! !

!Crew methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 22:53:00'!
initializeWith: anIsland pirates: aPirates at: aPosition

	island := anIsland.
	pirates := aPirates.
	
	island crewAt: aPosition.! !

!Crew methodsFor: 'as yet unclassified' stamp: 'HAW 9/22/2022 16:21:54'!
moveTo: aPosition

	| acc ix terrain |
	
	terrain := island terrainAt: aPosition.
	
	acc := true.
	ix := 1.
	
	[ix <= pirates size] whileTrue: [ | pirate |
		pirate := pirates at: ix.
		
		(pirate isKindOf: Corsario) ifTrue: [ 
			terrain = #Tree ifTrue: [ acc := acc & false ].
			terrain = #Empty ifTrue: [ 
				pirate drawDirectionTo: aPosition.
				acc := acc & true 
			].
			terrain = #Diggable ifTrue: [ acc := acc & true ].
		].
		
		(pirate isKindOf: Filibustero) ifTrue: [
			terrain = #Tree ifTrue: [ 
				island clearTerrainAt: aPosition.
				acc := acc & false
			].
			terrain = #Empty ifTrue: [ acc := acc & true ].
			terrain = #Diggable ifTrue: [ acc := acc & true ].
		].
		
		(pirate isKindOf: Bucanero) ifTrue: [
			terrain = #Tree ifTrue: [ acc := acc & false ].
			terrain = #Empty ifTrue: [ acc := acc & true ].
			terrain = #Diggable ifTrue: [ acc := acc & true ].
		].
		
		ix := ix + 1.
	].

	"nos movemos si todos pueden moverse"
	acc ifTrue: [ island crewAt: aPosition ].
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Crew class' category: 'ISW1-2022-2C-1erParcial'!
Crew class
	instanceVariableNames: ''!

!Crew class methodsFor: 'as yet unclassified' stamp: 'HAW 9/18/2022 19:21:29'!
at: anIsland composedBy: aCrew at: aPosition

	^ self new initializeWith: anIsland pirates: aCrew at: aPosition ! !


!classDefinition: #Filibustero category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Filibustero
	instanceVariableNames: 'rank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Filibustero methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:05:13'!
aCaptainIWasMeantToBe

	rank := #Captain! !

!Filibustero methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 20:32:13'!
initialize

	rank := #SimplePirate! !

!Filibustero methodsFor: 'as yet unclassified' stamp: 'FRT 9/18/2022 15:01:34'!
searchTreasureIn: island with: aMap

	rank = #SimplePirate ifTrue: [ self error: 'I am a simple pirate!!' ].
	rank = #Captain ifTrue: [ ^ true "Aye, Aye!! La implementación está fuera del scope del parcial." ].
	! !


!classDefinition: #Island category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Island
	instanceVariableNames: 'boardSize treesAt digsAt crewAt treasureAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:34:06'!
clearTerrainAt: aPosition

	| ix |
	
	ix := 1.
	[ix <= treesAt size] whileTrue: [ | pos |
		pos := treesAt at: ix.
		(aPosition = pos) ifTrue: [ ^ treesAt removeIndex: ix ].
		
		ix := ix + 1.
	].
	
! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:37:10'!
crewAt: aPosition

	crewAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:45:56'!
hasCrewAt: aPosition

	^ crewAt = aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:23:00'!
initializeSized: size treesAt: treesPositions digsAt: digsPositions

	boardSize := size.
	treesAt := treesPositions.
	digsAt := digsPositions.
! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:59:38'!
isEmptyAt: aPosition

	| ix |
	
	ix := 1.
	[ix <= treesAt size] whileTrue: [ | pos |
		pos := treesAt at: ix.
		(aPosition = pos) ifTrue: [ ^ false ].
		
		ix := ix + 1.
	].

	^ true! !

!Island methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:27:44'!
receiveTreasureAt: aPosition

	treasureAt := aPosition.! !

!Island methodsFor: 'as yet unclassified' stamp: 'HAW 9/22/2022 16:17:13'!
terrainAt: aPosition

	| ix |
	
	ix := 1.
	[ix <= treesAt size] whileTrue: [ | pos |
		pos := treesAt at: ix.
		(aPosition = pos) ifTrue: [ ^ #Tree ].		
		ix := ix + 1.
	].

	ix := 1.
	[ix <= digsAt size] whileTrue: [ | pos |
		pos := digsAt at: ix.
		(aPosition = pos) ifTrue: [ ^ #Diggable ].
		ix := ix + 1.
	].

	^ #Empty.
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Island class' category: 'ISW1-2022-2C-1erParcial'!
Island class
	instanceVariableNames: ''!

!Island class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 15:46:50'!
sized: size treesAt: treesPositions digsAt: digsPositions

	^ self new initializeSized: size treesAt: treesPositions digsAt: digsPositions 
! !


!classDefinition: #Map category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Map
	instanceVariableNames: 'island startPosition steps treasureMarkPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:00:56'!
hasTreasureMark

	^ treasureMarkPosition isNil not.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:30:31'!
initializeWith: anIsland crewStartsAt: aPosition

	island := anIsland.
	startPosition := aPosition.
	steps := OrderedCollection new.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:43:52'!
isEmpty

	^ steps isEmpty
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:45:55'!
lastPosition

	| acc ix |
	
	acc := startPosition.
	ix := 1.
	
	[ix <= steps size] whileTrue: [
		acc := acc + (steps at: ix)	.
		ix := ix + 1.
	].

	^ acc
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:39:01'!
nextStep: step

	^ steps add: step.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:33:43'!
startPosition

	^ startPosition
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:32:59'!
step: ix

	^ steps at: ix.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:32:23'!
stepsSize

	^ steps size.
	
	! !

!Map methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 19:01:06'!
treasureMarkAt: aPosition

	treasureMarkPosition := aPosition.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Map class' category: 'ISW1-2022-2C-1erParcial'!
Map class
	instanceVariableNames: ''!

!Map class methodsFor: 'as yet unclassified' stamp: 'FRT 9/17/2022 16:28:38'!
of: island crewStartsAt: aPosition.

	^ self new initializeWith: island crewStartsAt: aPosition.! !


!classDefinition: #Pirate category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Pirate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!
