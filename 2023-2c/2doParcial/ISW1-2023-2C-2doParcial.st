!classDefinition: #MineFieldTest category: #'ISW1-2023-2C-2doParcial'!
TestCase subclass: #MineFieldTest
	instanceVariableNames: 'randoms'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/5/2023 16:51:46'!
test01BoardExtentXMustBeGreaterOrEqualTo2

	"No hago una aserción de creación inválida de instancia porque no agregaría mucho valor - Hernan"
	self 
		should: [ MineField extent: 1@2 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:20'!
test02BoardExtentYMustBeGreaterOrEqualTo2

	self 
		should: [ MineField extent: 2@1 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidBoardExtentErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test03PlayerMustStartAtRow1

	self 
		should: [ MineField extent: 2@2 startingAt: 1@2 lives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:20'!
test04PlayerLivesMustBeStrictlyPositive

	self 
		should: [ MineField extent: 2@2 startingAt: 1@1 lives: 0 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidNumberOfLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test05PlayerLivesMustBeInteger

	self 
		should: [ MineField extent: 2@2 startingAt: 1@1 lives: 1.5 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidNumberOfLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test06PlayerMustStartInsideBoard

	self 
		should: [ MineField extent: 2@2 startingAt: 0@1 lives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	self 
		should: [ MineField extent: 2@2 startingAt: 3@1 lives: 1 elements: #() randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription 
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test07PlayerMustStartAtAnEmptyPosition

	self 
		should: [ MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: { LowPowerMine at: 1@1 } randomizingWith: self]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription.
		
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test08PlayerCanMoveUp

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerUp.
	
	self deny: (mineField isPlayerAt: 1@1).
	self assert: (mineField isPlayerAt: 1@2).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test09PlayerCanMoveLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 2@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerLeft.
	
	self deny: (mineField isPlayerAt: 2@1).
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:20'!
test10PlayerCanMoveRight

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerRight.
	
	self deny: (mineField isPlayerAt: 1@1).
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:20'!
test11PlayerCanMoveDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerUp; movePlayerDown.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test12PlayerStaysOnBoardWhenMovingDown

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerDown.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test13PlayerStaysOnBoardWhenMovingLeft

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingAt: 1@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerLeft.
	
	self assert: (mineField isPlayerAt: 1@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:20'!
test14PlayerStaysOnBoardWhenMovingRight

	| mineField |
	
	mineField :=  MineField extent: 2@3 startingAt: 2@1 lives: 1 elements: #() randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test15PlayerLoosesLiveWhenStepsIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { LowPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 11/28/2023 12:52:21'!
test16LowPowerMineExplotesOnlyOnce

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { LowPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 2@1).! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:26:44'!
test17PlayerLoosesLiveWhenStepsIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: mineField playerLives equals: 0.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 09:27:11'!
test18HighPowerMineExplotesOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 3 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: mineField playerLives equals: 1.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 09:27:41'!
test19PlayerFliesWhenSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(-1 1).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 3 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 1@2)! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:32:07'!
test20PlayerDoesNotMoveWhenFliesOutOfBoardSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(10 10).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:29:30'!
test21PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. LowPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:29:36'!
test22PlayerDoesNotLooseLiveWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(0 0).
	mineField :=  MineField extent: 5@5 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:32:16'!
test23PlayerFliesHalfWhenWearingLightArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 5@5 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: LightArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 3@3)
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:36:35'!
test24HeavyArmorCanUsedTwiceWhenSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField 
		extent: 3@3 
		startingAt: 1@1 
		lives: 2 
		elements: { 
			ArmorRack at: 2@1 with: HeavyArmor new. 
			LowPowerMine at: 2@2.
			LowPowerMine at: 1@2 } 
		randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp; movePlayerLeft.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:29:51'!
test24PlayerDoesNotLooseLiveWhenWearingHeavyArmorAndSteppingIntoLowPowerMine

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. LowPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:34:34'!
test26PlayerDoesNotLooseLifeNorFliesWhenWearingHeavyArmorAndSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. HighPowerMine at: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp.
	
	self assert: mineField playerLives equals: 2.
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 09:31:51'!
test27ArmorIsWeardOnlyOnce

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingAt: 1@1 lives: 2 elements: { 
		ArmorRack at: 2@1 with: HeavyArmor new. 
		HighPowerMine at: 2@2 .
		LowPowerMine at: 1@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerUp; movePlayerDown; movePlayerLeft; movePlayerUp.
	
	self assert: mineField playerLives equals: 1.
	self assert: (mineField isPlayerAt: 1@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:43:04'!
test28WhenPlayerSteppsIntoFirstTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingAt: 1@1 lives: 2 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@2)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 20:50:03'!
test29WhenPlayerSteppsIntoSecondTunnelHoleAppearsInOther

	| mineField |
	
	self randomPositionIncrementsAre: #(3 3).
	mineField :=  MineField extent: 3@3 startingAt: 1@1 lives: 2 elements: { Tunnel at: 2@1 and: 2@2 } randomizingWith: self.
	
	mineField movePlayerRight; movePlayerLeft; movePlayerRight.
	
	self assert: (mineField isPlayerAt: 2@1)
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/7/2023 22:58:26'!
test30FieldElementsCanNotSharePosition

	self assertCannotSharePositionsFor: { LowPowerMine at: 2@2. HighPowerMine at: 2@3. HighPowerMine at: 2@3.} ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:17:22'!
test31TunnelDoesNotSharePositionForFirstHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. LowPowerMine at: 2@2. } 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:17:32'!
test32TunnelDoesNotSharePositionWithSecondHole

	self assertCannotSharePositionsFor: { Tunnel at: 2@2 and: 3@3. Tunnel at: 1@2 and: 3@3. } 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 21:12:18'!
test33PlayerWinsWhenAtTopRowAndLeftLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self assert: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 21:14:12'!
test34PlayerDoesNotWinWhenAtTopRowButWithoutLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {LowPowerMine at: 1@2} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 21:17:49'!
test35PlayerDoesNotWinWhenNotAtTopRow

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {} randomizingWith: self.
	
	self deny: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/2/2023 21:22:40'!
test36GameIsOverWhenNoLivesLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {LowPowerMine at: 2@1} randomizingWith: self.
	mineField movePlayerRight.
	
	self assert: mineField isOver.
	self deny: mineField hasPlayerWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 11:59:12'!
test37CannotMoveWhenGameIsOver

	| mineField |
	
	mineField :=  MineField extent: 3@3 startingAt: 1@1 lives: 1 elements: {LowPowerMine at: 2@2} randomizingWith: self.
	mineField movePlayerRight;movePlayerUp.
	
	self 
		assertIsOverWhenMoving: [mineField movePlayerUp ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerDown ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerRight ] in: mineField;
		assertIsOverWhenMoving: [ mineField movePlayerLeft ] in: mineField
		
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:00:12'!
test38TunnelMustHaveDifferentHoles

	self 
		should: [ Tunnel at: 1@1 and: 1@1 ]
		raise: Error
		withMessageText: Tunnel holesMustBeAtDifferentPositionsErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:16:11'!
test39TunnelErrorsWhenAskForExitingFromInvalidHole

	| tunnel |
	
	tunnel := Tunnel at: 1@1 and: 2@2.
	
	self 
		should: [ tunnel exitWhenEnteringAt: 3@3 ]
		raise: Error
		withMessageText: Tunnel invalidHoleErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/4/2023 12:24:34'!
test40ElementsMustBeInsideBoard

	self
		should: [ MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: { LowPowerMine at: 3@3 } randomizingWith: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsMustBeInsideBoardErrorDescription! !


!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 19:19:32'!
nextInteger: aMaxValue

	| random |
	
	random := randoms peek.
	randoms next.
	
	^random! !

!MineFieldTest methodsFor: 'random simulation' stamp: 'HAW 11/27/2023 20:03:52'!
randomPositionIncrementsAre: aCollectionOfRandoms 
	
	randoms := ReadStream on: (aCollectionOfRandoms collect: [ :aPosition | aPosition + 4 ])! !


!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/4/2023 12:17:07'!
assertCannotSharePositionsFor: elements

	self
		should: [ MineField 
			extent: 3@3 
			startingAt: 1@1 
			lives: 2 
			elements: elements
			randomizingWith: self. ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField fieldElementsShouldNotSharePositionsErrorDescription! !

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:58:37'!
assertIsOverWhenMoving: aMovingBlock in: aMineField

	self 
		should: aMovingBlock 
		raise:  Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MineField gameIsOverErrorDescription.
			self assert: (aMineField isPlayerAt: 2@2) ]. 
	! !


!classDefinition: #Armor category: #'ISW1-2023-2C-2doParcial'!
Object subclass: #Armor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:37'!
defendFromHighPowerMine: aHighPowerMine in: aMineField

	self subclassResponsibility! !

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:41'!
defendFromLowPowerMine: aLowPowerMine in: aMineField

	self subclassResponsibility! !


!Armor methodsFor: 'flying' stamp: 'HAW 12/4/2023 09:35:05'!
flyingThroughtTheAirStep: aMineField

	^ (aMineField nextInteger: 7) - 4 @ ((aMineField nextInteger: 7) - 4)! !


!classDefinition: #HeavyArmor category: #'ISW1-2023-2C-2doParcial'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'usedTimesWithLowPowerMine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 11/27/2023 20:04:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	aMineField armorUsed.
	^0@0! !

!HeavyArmor methodsFor: 'defend from mine' stamp: 'HAW 12/2/2023 20:38:07'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	usedTimesWithLowPowerMine := usedTimesWithLowPowerMine + 1.
	usedTimesWithLowPowerMine = 2 ifTrue: [ aMineField armorUsed ]! !


!HeavyArmor methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:38:26'!
initialize

	super initialize.
	usedTimesWithLowPowerMine := 0.! !


!classDefinition: #LightArmor category: #'ISW1-2023-2C-2doParcial'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:28'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField armorUsed.
	step := (self flyingThroughtTheAirStep: aMineField) // 2.
	
	^step
! !

!LightArmor methodsFor: 'defend from mine' stamp: 'HAW 11/28/2023 10:21:42'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField armorUsed! !


!classDefinition: #NoArmor category: #'ISW1-2023-2C-2doParcial'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	| step |
	
	aMineField decreasePlayerLives; decreasePlayerLives.
	step := self flyingThroughtTheAirStep: aMineField.
	
	^step
	! !

!NoArmor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 11:00:16'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	aMineField decreasePlayerLives ! !


!classDefinition: #FieldElement category: #'ISW1-2023-2C-2doParcial'!
Object subclass: #FieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!FieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField

	self subclassResponsibility! !


!classDefinition: #EmptyFieldElement category: #'ISW1-2023-2C-2doParcial'!
FieldElement subclass: #EmptyFieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!EmptyFieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	! !


!classDefinition: #NotEmptyFieldPosition category: #'ISW1-2023-2C-2doParcial'!
FieldElement subclass: #NotEmptyFieldPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:40'!
isAt: aPosition

	self subclassResponsibility! !

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:12'!
isSharingPositionWith: aFieldElement

	self subclassResponsibility! !


!classDefinition: #ArmorRack category: #'ISW1-2023-2C-2doParcial'!
NotEmptyFieldPosition subclass: #ArmorRack
	instanceVariableNames: 'position armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!ArmorRack methodsFor: 'initialization' stamp: 'HAW 11/27/2023 20:00:21'!
initializeAt: aPosition with: anArmor
	
	position := aPosition.
	armor := anArmor ! !


!ArmorRack methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:28:56'!
isAt: aPosition

	^position = aPosition ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:10'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!ArmorRack methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:04:55'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !


!ArmorRack methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoArmorRack: self with: armor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArmorRack class' category: #'ISW1-2023-2C-2doParcial'!
ArmorRack class
	instanceVariableNames: ''!

!ArmorRack class methodsFor: 'instance creation' stamp: 'HAW 11/27/2023 20:00:05'!
at: aPosition with: anArmor

	^self new initializeAt: aPosition with: anArmor! !


!classDefinition: #Mine category: #'ISW1-2023-2C-2doParcial'!
NotEmptyFieldPosition subclass: #Mine
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Mine methodsFor: 'initialization' stamp: 'HAW 11/27/2023 19:08:03'!
initializeAt: aPosition 
	
	position := aPosition.! !


!Mine methodsFor: 'position testing' stamp: 'HAW 11/27/2023 19:08:09'!
isAt: aPosition 
	
	^position = aPosition ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:25:42'!
isInsideBoardOf: anExtent 
	
	^position between: 1@1 and: anExtent ! !

!Mine methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:43:04'!
isSharingPositionWith: aFieldElement 
	
	^aFieldElement isAt: position ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Mine class' category: #'ISW1-2023-2C-2doParcial'!
Mine class
	instanceVariableNames: ''!

!Mine class methodsFor: 'instance creation' stamp: 'HAW 11/28/2023 12:55:22'!
at: aPosition 
	
	^self new initializeAt: aPosition! !


!classDefinition: #HighPowerMine category: #'ISW1-2023-2C-2doParcial'!
Mine subclass: #HighPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!HighPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoHighPowerMine: self! !


!classDefinition: #LowPowerMine category: #'ISW1-2023-2C-2doParcial'!
Mine subclass: #LowPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!LowPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoLowPowerMine: self! !


!classDefinition: #Tunnel category: #'ISW1-2023-2C-2doParcial'!
NotEmptyFieldPosition subclass: #Tunnel
	instanceVariableNames: 'hole anotherHole'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!Tunnel methodsFor: 'initialization' stamp: 'HAW 12/2/2023 20:44:14'!
initializeAt: aHole and: anAnotherHole 
	
	hole := aHole.
	anotherHole := anAnotherHole.! !


!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 20:45:30'!
isAt: aPosition 
	
	^hole = aPosition or: [ anotherHole = aPosition ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/4/2023 12:26:43'!
isInsideBoardOf: anExtent 
	
	^(hole between: 1@1 and: anExtent) and: [ anotherHole between: 1@1 and: anExtent ]! !

!Tunnel methodsFor: 'position testing' stamp: 'HAW 12/2/2023 21:08:52'!
isSharingPositionWith: aFieldElement 
	
	^(aFieldElement isAt: hole) or: [ aFieldElement isAt: anotherHole ]! !


!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 12:04:59'!
exitWhenEnteringAt: aPosition 
	
	aPosition = hole ifTrue: [ ^anotherHole ].
	aPosition = anotherHole ifTrue: [ ^hole ].
	
	self error: self class invalidHoleErrorDescription 
	
	
	! !

!Tunnel methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoTunnel: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tunnel class' category: #'ISW1-2023-2C-2doParcial'!
Tunnel class
	instanceVariableNames: ''!

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
assert: aHole doesNotSharePositionWith: anotherHole

	^ aHole = anotherHole ifTrue: [ self error: self holesMustBeAtDifferentPositionsErrorDescription ]! !

!Tunnel class methodsFor: 'instance creation' stamp: 'HAW 12/4/2023 12:02:03'!
at: aHole and: anotherHole 
	
	self assert: aHole doesNotSharePositionWith: anotherHole.
	
	^self new initializeAt: aHole and: anotherHole ! !


!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:00:43'!
holesMustBeAtDifferentPositionsErrorDescription
	
	^'Holes must be at different positions'! !

!Tunnel class methodsFor: 'error description' stamp: 'HAW 12/4/2023 12:04:05'!
invalidHoleErrorDescription
	
	^'Invalid hole'! !


!classDefinition: #MineField category: #'ISW1-2023-2C-2doParcial'!
Object subclass: #MineField
	instanceVariableNames: 'boardExtent playerPosition playerLives fieldElements playerArmor random'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-2doParcial'!

!MineField methodsFor: 'initialization' stamp: 'HAW 11/28/2023 12:52:54'!
initializeExtent: anExtent startingAt: aStartingPosition lives: aNumberOfLives elements: aCollectionOfFieldElements randomizingWith: aRandom  
	
	boardExtent := anExtent.
	playerPosition := aStartingPosition.
	playerLives := aNumberOfLives.
	fieldElements := aCollectionOfFieldElements asOrderedCollection .
	playerArmor := NoArmor new.
	random := aRandom! !


!MineField methodsFor: 'random' stamp: 'HAW 11/28/2023 12:53:15'!
nextInteger: aMaxInteger

	^random nextInteger: aMaxInteger ! !


!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 10:48:44'!
hasPlayerWon
	
	^self isOver and: [ self isPlayerStillAlive ]! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 10:48:44'!
isOver
	
	^self isPlayerAtTopRow or: [self isPlayerStillAlive not]! !

!MineField methodsFor: 'testing' stamp: 'HAW 11/27/2023 12:19:50'!
isPlayerAt: aPosition

	^playerPosition = aPosition ! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/2/2023 21:24:26'!
isPlayerAtTopRow

	^ playerPosition y = boardExtent y! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 10:48:44'!
isPlayerStillAlive

	^ playerLives > 0! !


!MineField methodsFor: 'player' stamp: 'HAW 11/27/2023 19:37:17'!
armorUsed
	
	playerArmor := NoArmor new! !

!MineField methodsFor: 'player' stamp: 'HAW 12/4/2023 11:00:16'!
decreasePlayerLives
	
	playerLives := playerLives - 1! !

!MineField methodsFor: 'player' stamp: 'HAW 11/27/2023 18:56:06'!
playerLives
	
	^playerLives! !


!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:24:49'!
movePlayerDown
	
	self movePlayer: 0@-1! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:00'!
movePlayerLeft
	
	self movePlayer: -1@0! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:25:09'!
movePlayerRight
	
	self movePlayer: 1@0! !

!MineField methodsFor: 'moving' stamp: 'HAW 11/27/2023 12:24:20'!
movePlayerUp
	
	self movePlayer: 0@1! !


!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:08:15'!
fieldElementAtPlayerPosition

	^ fieldElements detect: [ :aFieldElement | aFieldElement isAt: playerPosition ] ifNone: [ EmptyFieldElement new ]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:01:47'!
isInBoard: aPosition

	^ aPosition between: 1@1 and: boardExtent! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:01:18'!
movePlayer: aStep

	^self movePlayer: aStep ifGameOver: [ self error: self class gameIsOverErrorDescription ].! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:02:53'!
movePlayer: aStep ifGameOver: aBlock

	| newPosition |
	
	self isOver ifTrue: [ ^aBlock value ].
	
	newPosition := playerPosition + aStep.
	(self isInBoard: newPosition) ifTrue: [ self movePlayerTo: newPosition ]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/4/2023 11:07:58'!
movePlayerTo: newPosition

	playerPosition := newPosition.
	self fieldElementAtPlayerPosition playerSteppedIntoFrom: self! !


!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/4/2023 11:00:50'!
playerSteppedIntoArmorRack: anArmorRack with: anArmor 
	
	playerArmor := anArmor.
	self removeFieldElement: anArmorRack ! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/4/2023 11:01:18'!
playerSteppedIntoHighPowerMine: aHighPowerMine 
	
	| step |
	
	step := playerArmor defendFromHighPowerMine: aHighPowerMine in: self.
	self removeFieldElement: aHighPowerMine .
	self movePlayer: step ifGameOver: []
	
	! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/2/2023 20:20:14'!
playerSteppedIntoLowPowerMine: aLowPowerMine 
	
	playerArmor defendFromLowPowerMine: aLowPowerMine in: self.
	self removeFieldElement: aLowPowerMine ! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/2/2023 20:49:17'!
playerSteppedIntoTunnel: aTunnel 
	
	| exitPosition |
	
	exitPosition := aTunnel exitWhenEnteringAt: playerPosition.
	playerPosition := exitPosition.! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 11/27/2023 19:01:18'!
removeFieldElement: aFieldElement 
	
	fieldElements remove: aFieldElement ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: #'ISW1-2023-2C-2doParcial'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:56:39'!
assert: aStartingPosition isAtFirstRow: anExtent

	(aStartingPosition between: 1@1 and: anExtent x @ 1) ifFalse: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isInBoundsFor: anExtent andNotUsedBy: aCollectionOfFieldElements .
	
	self assert: aStartingPosition isAtFirstRow: anExtent.
	self assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:00'!
assert: aStartingPosition isNotUsedBy: aCollectionOfFieldElements

	^ (aCollectionOfFieldElements anySatisfy: [ :aFieldElement | aFieldElement isAt: aStartingPosition ]) 
		ifTrue: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/7/2023 23:20:51'!
assertElementsDoNotSharePosition: aCollectionOfFieldElements

	aCollectionOfFieldElements combinations: 2 atATimeDo: [ :elements |
		(elements first isSharingPositionWith: elements second) ifTrue: [
			self error: self fieldElementsShouldNotSharePositionsErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:12:42'!
assertIsValidExtent: anExtent

	^ anExtent >=(2@2) ifFalse: [ self error: self invalidBoardExtentErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/2/2023 20:57:32'!
assertIsValidNumberOfLives: aNumberOfLives

	^ (aNumberOfLives strictlyPositive and: [ aNumberOfLives isInteger ]) ifFalse: [ self error: self invalidNumberOfLivesErrorDescription ]! !


!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/4/2023 12:20:01'!
fieldElementsMustBeInsideBoardErrorDescription
	
	^'Field elements must be inside board'
! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:00:39'!
fieldElementsShouldNotSharePositionsErrorDescription
	
	^'Field elements should not share positions'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/2/2023 21:30:59'!
gameIsOverErrorDescription
	
	^'Cannot move when game is over'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 11:51:11'!
invalidBoardExtentErrorDescription
	
	^'Board extent must be greater or equal to 2@2'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:00:56'!
invalidNumberOfLivesErrorDescription
	
	^'Number of lives must be an strictly positive integer'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 11/27/2023 12:13:28'!
invalidStartingPositionErrorDescription
	
	^'Player must start at an empty position, inside the board and at row 1'! !


!MineField class methodsFor: 'instance creation' stamp: 'HAW 12/5/2023 16:50:37'!
assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent

	(aCollectionOfFieldElements allSatisfy: [ :aFieldElement | aFieldElement isInsideBoardOf: anExtent ]) 
		ifFalse: [ self error: self fieldElementsMustBeInsideBoardErrorDescription ]! !

!MineField class methodsFor: 'instance creation' stamp: 'HAW 12/5/2023 16:50:19'!
extent: anExtent startingAt: aStartingPosition lives: aNumberOfLives elements: aCollectionOfFieldElements randomizingWith: aRandom     
	
	self assertIsValidExtent: anExtent.
	self assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent.
	self assertElementsDoNotSharePosition: aCollectionOfFieldElements.
	self assert: aStartingPosition isInBoundsFor: anExtent andNotUsedBy: aCollectionOfFieldElements.
	self assertIsValidNumberOfLives: aNumberOfLives.
	
	^self new initializeExtent: anExtent startingAt: aStartingPosition lives: aNumberOfLives elements: aCollectionOfFieldElements randomizingWith: aRandom    
! !
