!classDefinition: #CrewTest category: 'ISW1-2022-2C-1erParcial'!
TestCase subclass: #CrewTest
	instanceVariableNames: 'crewPosition1 treePosition1 island1 map1 crew1'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:25:37'!
test01MovingCrewToTreePlaceDoesNotMove
	
	crew1 moveTo: treePosition1.
	
	self deny: (island1 hasCrewAt: treePosition1).
	self assert: (island1 hasCrewAt: crewPosition1).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:26:14'!
test02MovingCrewToTreePlaceFilibusteroRemovesTree

	self deny: (island1 isEmptyAt: treePosition1).
				
	crew1 moveTo: treePosition1.

	self assert: (island1 isEmptyAt: treePosition1).
	
	self deny: (island1 hasCrewAt: treePosition1).
	self assert: (island1 hasCrewAt: crewPosition1).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:26:37'!
test03MovingCrewToFreePlace

	| nextPosition  |
	
	nextPosition := 2@1.
	self assert: (island1 isEmptyAt: nextPosition).
	
	crew1 moveTo: nextPosition.

	self deny: (island1 hasCrewAt: crewPosition1).
	self assert: (island1 hasCrewAt: nextPosition).! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:26:59'!
test04MovingCrewToFreePlaceCorsarioWritesDirectionInMap

	| nextPosition  |
	
	nextPosition := 2@1.
	self assert: map1 isEmpty.

	crew1 moveTo: nextPosition.

	self assert: map1 stepsSize equals: 1. 
	self assert: map1 lastPosition equals: nextPosition.
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:27:11'!
test05CrewCannotBuryTreasureIfBucaneroCannotDig

	crew1 moveTo: 2@1.
	
	self 
		should: [ crew1 buryTreasureAt: 3@1 ] 
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :error | 
			self assert: error messageText equals: Bucanero cannotDigErrorDescription.
			self deny: map1 hasTreasureMark ]
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:27:22'!
test06CrewCanBuryTreasureIfBucaneroCanDig

	crew1 moveTo: 2@1.
	crew1 buryTreasureAt: 2@2.
	
	self assert: map1 hasTreasureMark.
	
			
	
	
	
! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:27:42'!
test07CaptainCanUseMap

	| pirate |
	
	crew1 moveTo: 2@1.
	crew1 buryTreasureAt: 2@2.

	pirate := Bucanero new.
	pirate aCaptainIWasMeantToBe.
	
	self assert: (pirate searchTreasureIn: island1 with: map1)! !

!CrewTest methodsFor: 'tests' stamp: 'HAW 9/24/2022 11:29:16'!
test08SimplePirateCannotUseMap

	| pirate |
	
	crew1 moveTo: 2@1.
	crew1 buryTreasureAt: 2@2.

	pirate := Bucanero new.
	
	self 
		should: [ pirate searchTreasureIn: island1 with: map1 ] 
		raise: Error - MessageNotUnderstood 
		withMessageText: SimplePirate simplePirateErrorDescription 
! !


!CrewTest methodsFor: 'setUp/tearDown' stamp: 'HAW 9/24/2022 11:25:30'!
setUp
	
	crewPosition1 := 1@1.
	treePosition1 := 1@2.
	
	island1 := Island
		sized: 3@3
		treesAt: (OrderedCollection with: treePosition1)
		digsAt: (OrderedCollection with: 2@2).
	
	map1 := Map of: island1 crewStartsAt: crewPosition1.

	crew1 := Crew 
			at: island1 
			composedBy: (OrderedCollection with: (Corsario with: map1) with: Filibustero new with: Bucanero new)
			at: crewPosition1.
			
	! !


!classDefinition: #Crew category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Crew
	instanceVariableNames: 'island pirates'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Crew methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:59:26'!
buryTreasureAt: aPosition

	| terrain |
	
	terrain := island terrainAt: aPosition.
	
	pirates do: [ :pirate | pirate buryTreasureTo: aPosition in: terrain at: island ]! !

!Crew methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:54:44'!
moveTo: aPosition

	| moved terrain |
	
	terrain := island terrainAt: aPosition.
	
	moved := pirates inject: true into: [ :canMove :pirate | canMove & (pirate canMoveTo: aPosition in: terrain at: island )	].

	"nos movemos si todos pueden moverse"
	moved ifTrue: [ island crewAt: aPosition ].
	
	! !


!Crew methodsFor: 'initialization' stamp: 'FRT 9/17/2022 22:53:00'!
initializeWith: anIsland pirates: aPirates at: aPosition

	island := anIsland.
	pirates := aPirates.
	
	island crewAt: aPosition.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Crew class' category: 'ISW1-2022-2C-1erParcial'!
Crew class
	instanceVariableNames: ''!

!Crew class methodsFor: 'instance creation' stamp: 'HAW 9/18/2022 19:21:29'!
at: anIsland composedBy: aCrew at: aPosition

	^ self new initializeWith: anIsland pirates: aCrew at: aPosition ! !


!classDefinition: #Island category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Island
	instanceVariableNames: 'boardSize treesAt digsAt crewAt treasureAt'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Island methodsFor: 'crew' stamp: 'FRT 9/17/2022 15:37:10'!
crewAt: aPosition

	crewAt := aPosition.! !

!Island methodsFor: 'crew' stamp: 'FRT 9/17/2022 15:27:44'!
receiveTreasureAt: aPosition

	treasureAt := aPosition.! !


!Island methodsFor: 'testing' stamp: 'FRT 9/17/2022 15:45:56'!
hasCrewAt: aPosition

	^ crewAt = aPosition.! !

!Island methodsFor: 'testing' stamp: 'HAW 9/24/2022 11:08:53'!
hasTreeAt: aPosition

	^ treesAt includes: aPosition! !

!Island methodsFor: 'testing' stamp: 'HAW 9/24/2022 11:09:18'!
isDiggableAt: aPosition

	^ digsAt includes: aPosition! !

!Island methodsFor: 'testing' stamp: 'HAW 9/24/2022 11:08:53'!
isEmptyAt: aPosition

	^(self hasTreeAt: aPosition) not ! !


!Island methodsFor: 'initialization' stamp: 'FRT 9/17/2022 15:23:00'!
initializeSized: size treesAt: treesPositions digsAt: digsPositions

	boardSize := size.
	treesAt := treesPositions.
	digsAt := digsPositions.
! !


!Island methodsFor: 'terrain' stamp: 'HAW 9/24/2022 11:03:00'!
clearTerrainAt: aPosition

	treesAt remove: aPosition ifAbsent: []! !

!Island methodsFor: 'terrain' stamp: 'HAW 9/24/2022 11:09:18'!
terrainAt: aPosition

	(self hasTreeAt: aPosition ) ifTrue: [^Tree new ].
	(self isDiggableAt: aPosition ) ifTrue: [^Diggable new ].
	^Empty new
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Island class' category: 'ISW1-2022-2C-1erParcial'!
Island class
	instanceVariableNames: ''!

!Island class methodsFor: 'instance creation' stamp: 'FRT 9/17/2022 15:46:50'!
sized: size treesAt: treesPositions digsAt: digsPositions

	^ self new initializeSized: size treesAt: treesPositions digsAt: digsPositions 
! !


!classDefinition: #Map category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Map
	instanceVariableNames: 'island startPosition steps treasureMarkPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Map methodsFor: 'treasure' stamp: 'HAW 9/24/2022 11:10:36'!
lastPosition

	^steps inject: startPosition into: [ :lastPosition :step | lastPosition + step ]
	! !

!Map methodsFor: 'treasure' stamp: 'FRT 9/17/2022 19:01:06'!
treasureMarkAt: aPosition

	treasureMarkPosition := aPosition.
	
	! !


!Map methodsFor: 'testing' stamp: 'HAW 9/24/2022 11:11:27'!
hasTreasureMark

	^ treasureMarkPosition notNil 
	
	! !

!Map methodsFor: 'testing' stamp: 'FRT 9/17/2022 16:43:52'!
isEmpty

	^ steps isEmpty
	
	! !


!Map methodsFor: 'initialization' stamp: 'FRT 9/17/2022 16:30:31'!
initializeWith: anIsland crewStartsAt: aPosition

	island := anIsland.
	startPosition := aPosition.
	steps := OrderedCollection new.
	
	! !


!Map methodsFor: 'steps' stamp: 'FRT 9/17/2022 16:39:01'!
nextStep: step

	^ steps add: step.
	
	! !

!Map methodsFor: 'steps' stamp: 'FRT 9/17/2022 16:32:23'!
stepsSize

	^ steps size.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Map class' category: 'ISW1-2022-2C-1erParcial'!
Map class
	instanceVariableNames: ''!

!Map class methodsFor: 'instance creation' stamp: 'FRT 9/17/2022 16:28:38'!
of: island crewStartsAt: aPosition.

	^ self new initializeWith: island crewStartsAt: aPosition.! !


!classDefinition: #Pirate category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Pirate
	instanceVariableNames: 'rank'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Pirate methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 11:12:06'!
buryTreasureTo: aPosition in: terrain at: island 
	
	self subclassResponsibility ! !

!Pirate methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 11:11:56'!
canMoveTo: aPosition in: terrain at: island 
	
	self subclassResponsibility ! !

!Pirate methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 11:17:51'!
searchTreasureIn: island with: aMap

	^rank searchTreasureFor: self at: island with: aMap! !


!Pirate methodsFor: 'initialization' stamp: 'HAW 9/24/2022 11:17:00'!
initialize

	rank := SimplePirate new! !


!Pirate methodsFor: 'rank' stamp: 'HAW 9/24/2022 11:17:07'!
aCaptainIWasMeantToBe

	rank := Captain new! !


!classDefinition: #Bucanero category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Bucanero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Bucanero methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:59:26'!
buryTreasureTo: aPosition in: terrain at: island 

	^terrain bucanero: self buryTreasureAt: aPosition at: island 
	! !

!Bucanero methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:54:44'!
canMoveTo: aPosition in: terrain at: island 
	
	^terrain canMoveBucanero: self to: aPosition at: island
		
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bucanero class' category: 'ISW1-2022-2C-1erParcial'!
Bucanero class
	instanceVariableNames: ''!

!Bucanero class methodsFor: 'error description' stamp: 'FRT 9/17/2022 17:12:39'!
cannotDigErrorDescription

	^ 'Arrgh!! I cannot dig this type of terrain!!'.! !


!classDefinition: #Corsario category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Corsario
	instanceVariableNames: 'map'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Corsario methodsFor: 'map' stamp: 'FRT 9/17/2022 22:43:57'!
drawDirectionTo: aPosition

	map nextStep: aPosition - (map lastPosition).
	
! !

!Corsario methodsFor: 'map' stamp: 'FRT 9/17/2022 19:01:22'!
drawTreasureMarkAt: aPosition

	map nextStep: aPosition - map lastPosition.
	map treasureMarkAt: aPosition.
	
! !


!Corsario methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:59:53'!
buryTreasureTo: aPosition in: terrain at: island 

	^terrain corsario: self buryTreasureAt: aPosition at: island 
! !

!Corsario methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:54:44'!
canMoveTo: aPosition in: terrain at: island 
	
	^terrain canMoveCorsario: self to: aPosition at: island
			! !


!Corsario methodsFor: 'initialization' stamp: 'HAW 9/24/2022 11:15:13'!
initializeWith: aMap

	map := aMap! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Corsario class' category: 'ISW1-2022-2C-1erParcial'!
Corsario class
	instanceVariableNames: ''!

!Corsario class methodsFor: 'instance creation' stamp: 'FRT 9/15/2022 21:46:08'!
with: aMap

	^ self new initializeWith: aMap.! !


!classDefinition: #Filibustero category: 'ISW1-2022-2C-1erParcial'!
Pirate subclass: #Filibustero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Filibustero methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 11:01:19'!
buryTreasureTo: aPosition in: terrain at: island 

	^terrain filibustero: self buryTreasureAt: aPosition at: island 
! !

!Filibustero methodsFor: 'crew actions' stamp: 'HAW 9/24/2022 10:54:44'!
canMoveTo: aPosition in: terrain at: island 
	
	^terrain canMoveFilibustero: self to: aPosition at: island
		
	! !


!classDefinition: #PirateRank category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #PirateRank
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!PirateRank methodsFor: 'searching treasure' stamp: 'HAW 9/24/2022 11:18:45'!
searchTreasureFor: aPirate at: anIsland with: aMap 

	self subclassResponsibility ! !


!classDefinition: #Captain category: 'ISW1-2022-2C-1erParcial'!
PirateRank subclass: #Captain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Captain methodsFor: 'searching treasure' stamp: 'HAW 9/24/2022 11:18:10'!
searchTreasureFor: aPirate at: anIsland with: aMap 
	
	^ true "Aye, Aye!! La implementación está fuera del scope del parcial." 
	! !


!classDefinition: #SimplePirate category: 'ISW1-2022-2C-1erParcial'!
PirateRank subclass: #SimplePirate
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!SimplePirate methodsFor: 'searching treasure' stamp: 'HAW 9/24/2022 11:28:59'!
searchTreasureFor: aPirate at: anIsland with: aMap 
	
	self error: self class simplePirateErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimplePirate class' category: 'ISW1-2022-2C-1erParcial'!
SimplePirate class
	instanceVariableNames: ''!

!SimplePirate class methodsFor: 'error description' stamp: 'HAW 9/24/2022 11:28:54'!
simplePirateErrorDescription

	^ 'I am a simple pirate!!'! !


!classDefinition: #Terrain category: 'ISW1-2022-2C-1erParcial'!
Object subclass: #Terrain
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Terrain methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:19:19'!
bucanero: aBucanero buryTreasureAt: aPosition at: island 

	self subclassResponsibility ! !

!Terrain methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:20:12'!
corsario: aCorsario buryTreasureAt: aPosition at: island 

	self subclassResponsibility ! !

!Terrain methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:20:24'!
filibustero: aFilistero buryTreasureAt: aPosition at: island 

	self subclassResponsibility ! !


!Terrain methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 11:19:34'!
canMoveBucanero: aBucanero to: aPosition at: island 

	self subclassResponsibility ! !

!Terrain methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 11:19:45'!
canMoveCorsario: aCorsario to: aPosition at: island 

	self subclassResponsibility ! !

!Terrain methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 11:19:56'!
canMoveFilibustero: aFilibustero to: aPosition at: island

	self subclassResponsibility ! !


!classDefinition: #Diggable category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Diggable
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Diggable methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 10:58:32'!
bucanero: aBucanero buryTreasureAt: aPosition at: island 
			
	island receiveTreasureAt: aPosition 
	! !

!Diggable methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:00:18'!
corsario: aCorsario buryTreasureAt: aPosition at: island 

	aCorsario drawTreasureMarkAt: aPosition ! !

!Diggable methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:01:36'!
filibustero: aFilistero buryTreasureAt: aPosition at: island 
! !


!Diggable methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:48:45'!
canMoveBucanero: aBucanero to: aPosition at: island 
	
	^ true 
		
	
	! !

!Diggable methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:49:49'!
canMoveCorsario: aCorsario to: aPosition at: island 

	^ true! !

!Diggable methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:51:12'!
canMoveFilibustero: aFilibustero to: aPosition at: island
		
	^true 
		! !


!classDefinition: #Empty category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Empty methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 10:58:51'!
bucanero: aBucanero buryTreasureAt: aPosition at: island 
		
	self error: 'Arrgh!! I cannot dig this type of terrain!!' 
	! !

!Empty methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:00:26'!
corsario: aCorsario buryTreasureAt: aPosition at: island 

	! !

!Empty methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:01:42'!
filibustero: aFilistero buryTreasureAt: aPosition at: island 
! !


!Empty methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:50:17'!
canMoveBucanero: aBucanero to: aPosition at: island 
	
	^ true 
		
	
	! !

!Empty methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:49:33'!
canMoveCorsario: aCorsario to: aPosition at: island 

	aCorsario drawDirectionTo: aPosition.
	^ true 
			! !

!Empty methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:51:24'!
canMoveFilibustero: aFilibustero to: aPosition at: island
		
	^true ! !


!classDefinition: #Tree category: 'ISW1-2022-2C-1erParcial'!
Terrain subclass: #Tree
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2022-2C-1erParcial'!

!Tree methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 10:59:09'!
bucanero: aBucanero buryTreasureAt: aPosition at: island 
	
	self error: 'Arrgh!! I cannot dig this type of terrain!!' ! !

!Tree methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:00:32'!
corsario: aCorsario buryTreasureAt: aPosition at: island 

	! !

!Tree methodsFor: 'bury treasure' stamp: 'HAW 9/24/2022 11:01:46'!
filibustero: aFilistero buryTreasureAt: aPosition at: island 
! !


!Tree methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:48:36'!
canMoveBucanero: aBucanero to: aPosition at: island 
	
	^true ! !

!Tree methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:46:56'!
canMoveCorsario: aCorsario to: aPosition at: island 
	
	^false ! !

!Tree methodsFor: 'pirate moving' stamp: 'HAW 9/24/2022 10:51:35'!
canMoveFilibustero: aFilibustero to: aPosition at: island

	island clearTerrainAt: aPosition.
	^false
			! !
