!classDefinition: #MineFieldTest category: #'ISW1-2023-2C-Recuperatorio'!
TestCase subclass: #MineFieldTest
	instanceVariableNames: 'randoms currentTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 18:57:29'!
test04PlayerLivesMustBeStrictlyPositive

	self 
		should: [SoldierWithBayonet at: 1@1 lives: 0]
		raise: Error - MessageNotUnderstood 
		withMessageText: SoldierWithBayonet invalidNumberOfLivesErrorDescription
		
		! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 19:00:14'!
test05PlayerLivesMustBeInteger

	self 
		should: [ SoldierWithBayonet at: 1@1 lives: 1.5 ]
		raise: Error - MessageNotUnderstood 
		withMessageText: SoldierWithBayonet invalidNumberOfLivesErrorDescription
		
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

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:17:12'!
test20PlayerDoesNotMoveWhenFliesOutOfBoardSteppingIntoHighPowerMine

	| mineField |
	
	self randomPositionIncrementsAre: #(10 10).
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 3 elements: { HighPowerMine at: 2@1 } randomizingWith: self.
	
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

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 19:32:46'!
test33PlayerWinsWhenAtTopRowAndLeftLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self assert: mineField hasTeamOneWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 19:32:46'!
test34PlayerDoesNotWinWhenAtTopRowButWithoutLives

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {LowPowerMine at: 1@2} randomizingWith: self.
	
	mineField movePlayerUp.
	
	self assert: mineField isOver.
	self deny: mineField hasTeamOneWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 19:32:46'!
test35PlayerDoesNotWinWhenNotAtTopRow

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {} randomizingWith: self.
	
	self deny: mineField isOver.
	self deny: mineField hasTeamOneWon.
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/9/2023 19:32:46'!
test36GameIsOverWhenNoLivesLeft

	| mineField |
	
	mineField :=  MineField extent: 2@2 startingAt: 1@1 lives: 1 elements: {LowPowerMine at: 2@1} randomizingWith: self.
	mineField movePlayerRight.
	
	self assert: mineField isOver.
	self deny: mineField hasTeamOneWon.
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

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:09:24'!
test41TeamsMustHaveSameAmountOfPlayers

	self
		should: [ MineField 
			extent: 2@2 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 2@1 lives: 1.})
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@2 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self  ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField teamMustHaveSameAmountOfPlayersErrorDescription! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:09:42'!
test42TeamOnePlayersMustStartAtFirstRow

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 1@3 lives: 1. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 2@3 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:09:55'!
test43TeamOnePlayersMustStartAtDifferentPositions

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 1@1 lives: 1. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 2@3 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:10:06'!
test44TeamTwoPlayersMustStartAtLastRow

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 2@1 lives: 1. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 1@2 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:10:16'!
test45TeamTwoPlayersMustStartAtEmptyPositions

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 2@1 lives: 1. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 2@3 lives: 1 })
			elements: { LowPowerMine at: 1@3 } 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:07:59'!
test46TeamTwoPlayersMustStartAtDifferentPositions

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 2@1 lives: 1. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 1@3 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField invalidStartingPositionErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:08:47'!
test47TeamsMustHaveSameSumOfPlayersLives

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: { SoldierWithBayonet at: 1@1 lives: 1. SoldierWithBayonet at: 2@1 lives: 2. })
			playingAgainst: (Team with: { SoldierWithBayonet at: 1@3 lives: 1. SoldierWithBayonet at: 2@3 lives: 1 })
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
		withMessageText: MineField totalTeamLivesMustBeTheSameErrorDescription ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:13:15'!
test48PlayersAreMovedOncePerTeam

	| mineField teamOnePlayer teamTwoPlayer teamOneAnotherPlayer teamTwoAnotherPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamOneAnotherPlayer := SoldierWithBayonet at: 3@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	teamTwoAnotherPlayer := SoldierWithBayonet at: 3@3 lives: 1.
	mineField := MineField 
		extent: 4@3 
		with: (Team with: { teamOnePlayer. teamOneAnotherPlayer })
		playingAgainst: (Team with: { teamTwoPlayer. teamTwoAnotherPlayer })
		elements: {} 
		randomizingWith: self 
		clock: self.
		
	6 timesRepeat: [ mineField movePlayerRight ].
	
	self assert: (teamOnePlayer isAt: 3@1).
	self assert: (teamOneAnotherPlayer isAt: 4@1).
	self assert: (teamTwoPlayer isAt: 3@3).
	self assert: (teamTwoAnotherPlayer isAt: 4@3).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:10:56'!
test49TeamTwoWinsWhenOneOfItsPlayersReachesFirstRow

	| mineField teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. })
		playingAgainst: (Team with: { teamTwoPlayer. })
		elements: {} 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerDown; movePlayerRight; movePlayerDown.
	
	self assert: mineField isOver.
	self assert: mineField hasTeamTwoWon.
	self deny: mineField hasTeamOneWon 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:11:01'!
test50GameIsOverWhenAllPlayersDie

	| mineField teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. })
		playingAgainst: (Team with: { teamTwoPlayer. })
		elements: { LowPowerMine at: 2@1. LowPowerMine at: 2@3} 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerRight.
	
	self assert: mineField isOver.
	self deny: mineField hasTeamTwoWon.
	self deny: mineField hasTeamOneWon 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:20:12'!
test51DeadPlayerGoesOutOfGame

	| mineField teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. })
		playingAgainst: (Team with: { teamTwoPlayer. })
		elements: { LowPowerMine at: 2@1 } 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerRight; movePlayerRight.
	
	self deny: teamOnePlayer isAlive.
	self deny: (teamOnePlayer isAliveAt: 2@1).
	self assert: (teamTwoPlayer isAt: 3@3).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:11:13'!
test52TeamOneLoosesRoundWhenMovingIntoPlayerOfSameTeam

	| mineField teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. SoldierWithBayonet at: 2@1 lives: 1})
		playingAgainst: (Team with: { teamTwoPlayer. SoldierWithBayonet at: 2@3 lives: 1.})
		elements: {} 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerDown.
	
	self assert: (teamOnePlayer isAt: 1@1).
	self assert: (teamTwoPlayer isAt: 1@2).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/10/2023 22:09:09'!
test53TeamTwoLoosesRoundWhenMovingIntoPlayerOfSameTeam

	| mineField teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. SoldierWithBayonet at: 3@1 lives: 1})
		playingAgainst: (Team with: { teamTwoPlayer. SoldierWithBayonet at: 2@3 lives: 1.})
		elements: {} 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerRight; movePlayerUp.
	
	self assert: (teamOnePlayer isAt: 2@1).
	self assert: (teamTwoPlayer isAt: 1@3).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:07:06'!
test54ArrivingSoldiersWithBayonetLoosesLiveWhenMeetsOtherAndSecondEven

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:10.
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:07:27'!
test55ReceiverSoldiersWithBayonetLoosesLiveWhenMeetsOtherAndSecondOdd

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:11.
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 2.
	
	self assertWins: teamTwoPlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:08:45'!
test56SoldierWithBayonetBeatsOneWithMachineGun

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithMachineGun at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:08:56'!
test57SoldierWithMachineGunLoosesAgainstBayonet

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithMachineGun at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 2.
	
	self assertWins: teamTwoPlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:09:17'!
test58SoldierWithBayonetBeatsOneWithPistol

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithPistol at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:09:31'!
test59SoldierWithPistolLoosesAgainstBayonet

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithPistol at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 2.
	
	self assertWins: teamTwoPlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:09:46'!
test60ReceivingSoldierWithPistolBeatsArrivingWithMachineGun

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithPistol at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithMachineGun at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:10:05'!
test61ArrivingSoldierWithPistolLoosesAReceivingOneWithMachineGun

	| teamOnePlayer teamTwoPlayer |
	
	teamOnePlayer := SoldierWithMachineGun at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithPistol at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:10:30'!
test62ArrivingSoldiersWithPistolLoosesLiveWhenMeetsOtherAndSecondsEven

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:10.
	teamOnePlayer := SoldierWithPistol at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithPistol at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:10:43'!
test63ReceiverSoldiersWithPistolLoosesLiveWhenMeetsOtherAndSecondsOdd

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:11.
	teamOnePlayer := SoldierWithPistol at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithPistol at: 1@3 lives: 2.
	
	self assertWins: teamTwoPlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:10:55'!
test64ArrivingSoldiersWithMachineGunLoosesLiveWhenMeetsOtherAndSecondsEven

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:10.
	teamOnePlayer := SoldierWithMachineGun at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithMachineGun at: 1@3 lives: 2.
	
	self assertWins: teamOnePlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 13:11:07'!
test65ReceiverSoldiersWithMachineLoosesLiveWhenMeetsOtherAndSecondsOdd

	| teamOnePlayer teamTwoPlayer |
	
	currentTime := December/10/2023 at: 10:10:11.
	teamOnePlayer := SoldierWithMachineGun at: 1@1 lives: 2.
	teamTwoPlayer := SoldierWithMachineGun at: 1@3 lives: 2.
	
	self assertWins: teamTwoPlayer when: teamOnePlayer fightsAgainst: teamTwoPlayer 
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 12:40:29'!
test66PlayerDoesNotLoseRoundWhenMovingIntoADeadPlayerOfSameTeam

	| mineField teamOnePlayer teamTwoPlayer teamOneAnotherPlayer |
	
	teamOnePlayer := SoldierWithBayonet at: 1@1 lives: 1.
	teamOneAnotherPlayer := SoldierWithBayonet at: 3@1 lives: 1.
	teamTwoPlayer := SoldierWithBayonet at: 1@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer. teamOneAnotherPlayer})
		playingAgainst: (Team with: { teamTwoPlayer. SoldierWithBayonet at: 2@3 lives: 1.})
		elements: { LowPowerMine at: 2@1 } 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerRight; movePlayerDown; movePlayerLeft.
	
	self deny: (teamOnePlayer isAliveAt: 2@1).
	self assert: (teamOneAnotherPlayer isAliveAt: 2@1).
	self assert: (teamTwoPlayer isAt: 1@2).
	! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 16:52:33'!
test67SoldierWithPistolCannotWareArmor

	| playerThatCannotWearArmor |
	
	playerThatCannotWearArmor := SoldierWithPistol at: 1@1 lives: 1.
	
	self assertCannotWearArmor: playerThatCannotWearArmor ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 16:52:57'!
test68SoldierWithMachineGunCannotWareArmor

	| playerThatCannotWearArmor |
	
	playerThatCannotWearArmor := SoldierWithMachineGun at: 1@1 lives: 1.
	
	self assertCannotWearArmor: playerThatCannotWearArmor ! !

!MineFieldTest methodsFor: 'tests' stamp: 'HAW 12/11/2023 21:27:05'!
test69TeamOneMustHaveAtLeastOnePlayer

	self
		should: [ MineField 
			extent: 3@3 
			with: (Team with: {})
			playingAgainst: (Team with: {})
			elements: {} 
			randomizingWith: self 
			clock: self ]
		raise: Error - MessageNotUnderstood 
 		withMessageText: MineField teamOneMustHaveOnePlayerAtLeastErrorDescription
			
	! !


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

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/11/2023 16:52:09'!
assertCannotWearArmor: aPlayerThatCannotWearArmor

	| mineField playerThatCanWareAremor |
	
	playerThatCanWareAremor := SoldierWithBayonet at: 2@3 lives: 1.
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { aPlayerThatCannotWearArmor })
		playingAgainst: (Team with: { playerThatCanWareAremor })
		elements: { ArmorRack at: 1@2  with: LightArmor new. LowPowerMine at: 2@2. LowPowerMine at: 3@2 } 
		randomizingWith: self 
		clock: self.
		
	mineField movePlayerUp; movePlayerLeft; movePlayerRight.
	
	self deny: aPlayerThatCannotWearArmor isAlive.
	
	mineField movePlayerDown; movePlayerRight; movePlayerRight.
	
	self assert: playerThatCanWareAremor isAlive.
	! !

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:58:37'!
assertIsOverWhenMoving: aMovingBlock in: aMineField

	self 
		should: aMovingBlock 
		raise:  Error 
		withExceptionDo: [ :anError | 
			self assert: anError messageText equals: MineField gameIsOverErrorDescription.
			self assert: (aMineField isPlayerAt: 2@2) ]. 
	! !

!MineFieldTest methodsFor: 'assertions' stamp: 'HAW 12/11/2023 13:07:56'!
assertWins: winner when: teamOnePlayer fightsAgainst: teamTwoPlayer 

	| mineField looser |
	
	looser := winner = teamOnePlayer ifTrue: [ teamTwoPlayer ] ifFalse: [ teamOnePlayer ].
	
	mineField := MineField 
		extent: 3@3 
		with: (Team with: { teamOnePlayer })
		playingAgainst: (Team with: { teamTwoPlayer })
		elements: {} 
		randomizingWith: self 
		clock: self  .
		
	mineField movePlayerUp; movePlayerDown.
	

	self assert: (winner isAt: 1@2).
	self assert: winner lives equals: 2.
	
	self assert: looser isAtOriginalPoisition.
	self assert: looser lives equals: 1.
	
	! !


!MineFieldTest methodsFor: 'time simulation' stamp: 'HAW 12/10/2023 10:11:07'!
now
	
	^currentTime ! !


!classDefinition: #Armor category: #'ISW1-2023-2C-Recuperatorio'!
Object subclass: #Armor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:37'!
defendFromHighPowerMine: aHighPowerMine in: aMineField

	self subclassResponsibility! !

!Armor methodsFor: 'defend from mine' stamp: 'HAW 12/4/2023 09:35:41'!
defendFromLowPowerMine: aLowPowerMine in: aMineField

	self subclassResponsibility! !


!Armor methodsFor: 'flying' stamp: 'HAW 12/4/2023 09:35:05'!
flyingThroughtTheAirStep: aMineField

	^ (aMineField nextInteger: 7) - 4 @ ((aMineField nextInteger: 7) - 4)! !


!classDefinition: #HeavyArmor category: #'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #HeavyArmor
	instanceVariableNames: 'usedTimesWithLowPowerMine'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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


!classDefinition: #LightArmor category: #'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #LightArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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


!classDefinition: #NoArmor category: #'ISW1-2023-2C-Recuperatorio'!
Armor subclass: #NoArmor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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


!classDefinition: #FieldElement category: #'ISW1-2023-2C-Recuperatorio'!
Object subclass: #FieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!FieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField

	self subclassResponsibility! !


!classDefinition: #EmptyFieldElement category: #'ISW1-2023-2C-Recuperatorio'!
FieldElement subclass: #EmptyFieldElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!EmptyFieldElement methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	! !


!classDefinition: #NotEmptyFieldPosition category: #'ISW1-2023-2C-Recuperatorio'!
FieldElement subclass: #NotEmptyFieldPosition
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:40'!
isAt: aPosition

	self subclassResponsibility! !

!NotEmptyFieldPosition methodsFor: 'position testing' stamp: 'HAW 12/4/2023 10:42:12'!
isSharingPositionWith: aFieldElement

	self subclassResponsibility! !


!classDefinition: #ArmorRack category: #'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #ArmorRack
	instanceVariableNames: 'position armor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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


!ArmorRack methodsFor: 'as yet unclassified' stamp: 'HAW 12/11/2023 14:57:46'!
armor
	
	^armor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ArmorRack class' category: #'ISW1-2023-2C-Recuperatorio'!
ArmorRack class
	instanceVariableNames: ''!

!ArmorRack class methodsFor: 'instance creation' stamp: 'HAW 11/27/2023 20:00:05'!
at: aPosition with: anArmor

	^self new initializeAt: aPosition with: anArmor! !


!classDefinition: #Mine category: #'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #Mine
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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

!classDefinition: 'Mine class' category: #'ISW1-2023-2C-Recuperatorio'!
Mine class
	instanceVariableNames: ''!

!Mine class methodsFor: 'instance creation' stamp: 'HAW 11/28/2023 12:55:22'!
at: aPosition 
	
	^self new initializeAt: aPosition! !


!classDefinition: #HighPowerMine category: #'ISW1-2023-2C-Recuperatorio'!
Mine subclass: #HighPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!HighPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoHighPowerMine: self! !


!classDefinition: #LowPowerMine category: #'ISW1-2023-2C-Recuperatorio'!
Mine subclass: #LowPowerMine
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!LowPowerMine methodsFor: 'stepped into' stamp: 'HAW 12/4/2023 11:07:58'!
playerSteppedIntoFrom: aMineField 
	
	aMineField playerSteppedIntoLowPowerMine: self! !


!classDefinition: #Tunnel category: #'ISW1-2023-2C-Recuperatorio'!
NotEmptyFieldPosition subclass: #Tunnel
	instanceVariableNames: 'hole anotherHole'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

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

!classDefinition: 'Tunnel class' category: #'ISW1-2023-2C-Recuperatorio'!
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


!classDefinition: #MineField category: #'ISW1-2023-2C-Recuperatorio'!
Object subclass: #MineField
	instanceVariableNames: 'boardExtent fieldElements random teamOne teamTwo clock currentPlayer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!MineField methodsFor: 'initialization' stamp: 'HAW 12/11/2023 12:32:06'!
initializeExtent: anExtent teamOnePlayers: aTeamOne teamTwoPlayers: aTeamTwo elements: aCollectionOfFieldElements randomizingWith: aRandom clock: aClock  
	
	boardExtent := anExtent.
	teamOne := aTeamOne.
	teamTwo := aTeamTwo.
	fieldElements := aCollectionOfFieldElements asOrderedCollection.
	random := aRandom.
	clock := aClock.
	
	teamOne destinationRow: boardExtent y; opponent: teamTwo.
	teamTwo destinationRow: 1; opponent: teamOne.
	
	currentPlayer := teamOne nextPlayerIfNone: [].! !


!MineField methodsFor: 'random' stamp: 'HAW 11/28/2023 12:53:15'!
nextInteger: aMaxInteger

	^random nextInteger: aMaxInteger ! !


!MineField methodsFor: 'testing' stamp: 'HAW 12/10/2023 17:10:11'!
areAllPlayersDead

	^ teamOne areAllPlayersDead and: [ teamTwo areAllPlayersDead ]! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/10/2023 17:03:54'!
hasTeamOneWon
	
	^teamOne hasWon! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/10/2023 17:09:30'!
hasTeamTwoWon
	
	^teamTwo hasWon ! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/4/2023 11:01:47'!
isInBoard: aPosition

	^ aPosition between: 1@1 and: boardExtent! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/10/2023 22:00:19'!
isOver
	
	^self hasTeamOneWon or: [ self hasTeamTwoWon or: [self areAllPlayersDead ]]! !

!MineField methodsFor: 'testing' stamp: 'HAW 12/11/2023 12:33:49'!
isPlayerAt: aPosition

	^currentPlayer isAt: aPosition ! !


!MineField methodsFor: 'player' stamp: 'HAW 12/11/2023 12:23:11'!
armorUsed
	
	currentPlayer armorUsed! !

!MineField methodsFor: 'player' stamp: 'HAW 12/11/2023 12:23:37'!
decreasePlayerLives
	
	currentPlayer decreaseLives! !

!MineField methodsFor: 'player' stamp: 'HAW 12/11/2023 12:52:18'!
playerLives
	
	^currentPlayer lives! !


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


!MineField methodsFor: 'moving - private' stamp: 'HAW 12/11/2023 12:31:30'!
defineCurrentPlayer

	currentPlayer := currentPlayer opponentTeam nextPlayerIfNone: [ currentPlayer team nextPlayerIfNone: [ ^self ]]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/11/2023 12:32:51'!
fieldElementAtPlayerPosition

	^ fieldElements detect: [ :aFieldElement | aFieldElement isAt: currentPlayer position ] ifNone: [ EmptyFieldElement new ]! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/11/2023 12:34:04'!
movePlayer: aStep

	self movePlayer: aStep ifGameOver: [ self error: self class gameIsOverErrorDescription ].! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/10/2023 22:02:45'!
movePlayer: aStep ifGameOver: aBlock

	| newPosition |
	
	self isOver ifTrue: [ ^aBlock value ].
	
	newPosition := currentPlayer  position + aStep.
	(self isInBoard: newPosition) ifTrue: [ self movePlayerTo: newPosition ].
	
	self defineCurrentPlayer
	! !

!MineField methodsFor: 'moving - private' stamp: 'HAW 12/11/2023 12:51:52'!
movePlayerTo: newPosition

	currentPlayer position: newPosition.
	self fieldElementAtPlayerPosition playerSteppedIntoFrom: self.
	
	currentPlayer doesSharePositionWithTeamMembers 
		ifTrue: [ currentPlayer moveToInitialPosition ]
		ifFalse: [ currentPlayer ifSharesPositionWithOpponent: [ :anOpponent | currentPlayer fightWith: anOpponent in: self ]].
	
	
	! !


!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/11/2023 14:57:11'!
playerSteppedIntoArmorRack: anArmorRack with: anArmor 
	
	currentPlayer wearArmorFrom: anArmorRack in: self.
	! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/11/2023 12:52:33'!
playerSteppedIntoHighPowerMine: aHighPowerMine 
	
	| step |
	
	step := currentPlayer defendFromHighPowerMine: aHighPowerMine in: self.
	self removeFieldElement: aHighPowerMine .
	self movePlayer: step ifGameOver: []
	
	! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/11/2023 12:52:36'!
playerSteppedIntoLowPowerMine: aLowPowerMine 
	
	currentPlayer defendFromLowPowerMine: aLowPowerMine in: self.
	self removeFieldElement: aLowPowerMine ! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 12/11/2023 12:52:57'!
playerSteppedIntoTunnel: aTunnel 
	
	| exitPosition |
	
	exitPosition := aTunnel exitWhenEnteringAt: currentPlayer position.
	currentPlayer position: exitPosition.! !

!MineField methodsFor: 'steep into field element' stamp: 'HAW 11/27/2023 19:01:18'!
removeFieldElement: aFieldElement 
	
	fieldElements remove: aFieldElement ! !


!MineField methodsFor: 'time' stamp: 'HAW 12/11/2023 11:24:30'!
timeOfDaySeconds
	
	^clock now timeOfDay seconds! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MineField class' category: #'ISW1-2023-2C-Recuperatorio'!
MineField class
	instanceVariableNames: ''!

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/9/2023 12:42:04'!
assert: players areInBounds: anExtent atRow: aRow 

	(players allSatisfy: [ :aPlayer | aPlayer isAtValidPositionOf: anExtent andRow: aRow ]) 
		ifFalse: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/9/2023 18:43:32'!
assert: players areInBounds: anExtent atRow: aRow andNotUsedBy: aCollectionOfFieldElements 
	
	self assert: players areInBounds: anExtent atRow: aRow.
	self assert: players areNotAtSamePositionOf: aCollectionOfFieldElements! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/5/2023 16:50:37'!
assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent

	(aCollectionOfFieldElements allSatisfy: [ :aFieldElement | aFieldElement isInsideBoardOf: anExtent ]) 
		ifFalse: [ self error: self fieldElementsMustBeInsideBoardErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/9/2023 18:43:59'!
assert: players areNotAtSamePositionOf: aCollectionOfFieldElements

	^ (aCollectionOfFieldElements anySatisfy: [ :aFieldElement | 
		players anySatisfy: [ :aPlayer | aFieldElement isAt: aPlayer position ]])
		ifTrue: [self error: self invalidStartingPositionErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/10/2023 21:57:31'!
assert: aTeamOne hasSameNumberOfPlayersAs: aTeamTwo

	^ (self isForOnlyOnePlayerOf: aTeamOne and: aTeamTwo) ifFalse: [
		aTeamOne playersSize = aTeamTwo playersSize ifFalse: [ 
			self error: self teamMustHaveSameAmountOfPlayersErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/10/2023 21:58:00'!
assert: aTeamOne hasSamePlayersLivesAs: aTeamTwo

	^ (self isForOnlyOnePlayerOf: aTeamOne and: aTeamTwo) ifFalse: [
		aTeamOne totalPlayersLives  = aTeamTwo totalPlayersLives
			ifFalse: [ self error: self totalTeamLivesMustBeTheSameErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/7/2023 23:20:51'!
assertElementsDoNotSharePosition: aCollectionOfFieldElements

	aCollectionOfFieldElements combinations: 2 atATimeDo: [ :elements |
		(elements first isSharingPositionWith: elements second) ifTrue: [
			self error: self fieldElementsShouldNotSharePositionsErrorDescription ]]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/11/2023 21:29:07'!
assertHasAtLeastOnePlayer: aTeamOne 
	
	aTeamOne hasNoPlayers ifTrue: [ self error: self teamOneMustHaveOnePlayerAtLeastErrorDescription ]! !

!MineField class methodsFor: 'assertions' stamp: 'HAW 12/4/2023 11:12:42'!
assertIsValidExtent: anExtent

	^ anExtent >=(2@2) ifFalse: [ self error: self invalidBoardExtentErrorDescription ]! !


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

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/11/2023 12:59:28'!
invalidStartingPositionErrorDescription
	
	^Team invalidStartingPositionErrorDescription! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/9/2023 12:01:21'!
teamMustHaveSameAmountOfPlayersErrorDescription
	
	^'Teams must have same amount of players'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/11/2023 21:24:53'!
teamOneMustHaveOnePlayerAtLeastErrorDescription
	
	^'Team one must have at least one player'! !

!MineField class methodsFor: 'error descriptions' stamp: 'HAW 12/9/2023 19:03:11'!
totalTeamLivesMustBeTheSameErrorDescription
	
	^'Total team lives must the same for both teams'! !


!MineField class methodsFor: 'instance creation' stamp: 'HAW 12/10/2023 10:29:05'!
extent: anExtent startingAt: aStartingPosition lives: aNumberOfLives elements: aCollectionOfFieldElements randomizingWith: aRandom     
	
	^self 
		extent: anExtent 
		with: (Team with: { SoldierWithBayonet at: aStartingPosition lives: aNumberOfLives })
		playingAgainst: (Team with: {})
		elements: aCollectionOfFieldElements 
		randomizingWith: aRandom 
		clock: GregorianDateTime  
     
! !

!MineField class methodsFor: 'instance creation' stamp: 'HAW 12/11/2023 21:25:39'!
extent: anExtent with: aTeamOne playingAgainst: aTeamTwo elements: aCollectionOfFieldElements randomizingWith: aRandom clock: aClock  
	
	self assertIsValidExtent: anExtent.
	self assert: aCollectionOfFieldElements areInsideBoardOfExtent: anExtent.
	self assertElementsDoNotSharePosition: aCollectionOfFieldElements.
	
	self assertHasAtLeastOnePlayer: aTeamOne.
	self assert: aTeamOne hasSameNumberOfPlayersAs: aTeamTwo.
	aTeamOne assertPlayerAreInBounds: anExtent atRow: 1 andNotUsedBy: aCollectionOfFieldElements.
	aTeamTwo assertPlayerAreInBounds: anExtent atRow: anExtent y andNotUsedBy: aCollectionOfFieldElements.
	self assert: aTeamOne hasSamePlayersLivesAs: aTeamTwo.
			
	^self new 
		initializeExtent: anExtent 
		teamOnePlayers: aTeamOne
		teamTwoPlayers: aTeamTwo 
		elements: aCollectionOfFieldElements 
		randomizingWith: aRandom 
		clock: aClock 
! !


!MineField class methodsFor: 'testing' stamp: 'HAW 12/10/2023 16:47:22'!
isForOnlyOnePlayerOf: aTeamOne and: aTeamTwo

	^ aTeamOne hasOnePlayer and: [ aTeamTwo hasNoPlayers ]! !


!classDefinition: #Player category: #'ISW1-2023-2C-Recuperatorio'!
Object subclass: #Player
	instanceVariableNames: 'position lives armor initialPosition team'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Player methodsFor: 'team' stamp: 'HAW 12/11/2023 12:25:53'!
opponentTeam

	^ team opponent! !

!Player methodsFor: 'team' stamp: 'HAW 12/11/2023 12:27:30'!
team
	
	^team! !

!Player methodsFor: 'team' stamp: 'HAW 12/11/2023 10:56:11'!
team: aTeam 
	
	team := aTeam ! !


!Player methodsFor: 'initialization' stamp: 'HAW 12/11/2023 10:55:17'!
initializeAt: aPlayerPosition lives: aNumberOfLives  
	
	initialPosition := position := aPlayerPosition.
	
	lives := aNumberOfLives.
	armor := NoArmor new.! !


!Player methodsFor: 'lives' stamp: 'HAW 12/11/2023 10:54:35'!
decreaseLives
	
	lives := lives - 1.
	! !

!Player methodsFor: 'lives' stamp: 'HAW 12/11/2023 10:55:28'!
isAlive
	
	^lives > 0! !

!Player methodsFor: 'lives' stamp: 'HAW 12/11/2023 12:43:25'!
isAliveAt: aPosition

	^self isAlive and: [ self isAt: aPosition ]! !

!Player methodsFor: 'lives' stamp: 'HAW 12/11/2023 10:55:45'!
lives
	
	^lives! !


!Player methodsFor: 'armor' stamp: 'HAW 12/11/2023 10:54:29'!
armorUsed
	
	armor := NoArmor new! !

!Player methodsFor: 'armor' stamp: 'HAW 12/11/2023 10:54:44'!
defendFromHighPowerMine: aHighPowerMine in: aMineField 
	
	^armor defendFromHighPowerMine: aHighPowerMine in: aMineField 
! !

!Player methodsFor: 'armor' stamp: 'HAW 12/11/2023 10:54:47'!
defendFromLowPowerMine: aLowPowerMine in: aMineField 
	
	^armor defendFromLowPowerMine: aLowPowerMine in: aMineField 
! !

!Player methodsFor: 'armor' stamp: 'HAW 12/11/2023 15:42:47'!
wearArmorFrom: anArmorRack in: aMineField

	self subclassResponsibility! !


!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:57:37'!
fightWith: aPlayer in: aMineField

	self subclassResponsibility! !

!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:57:42'!
fightWithSoldierWithBayonet: aSoldierWithBayonet in: aMineField

	self subclassResponsibility! !

!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:57:49'!
fightWithSoldierWithMachineGun: aSoldierWithMachineGun in: aMineField

	self subclassResponsibility! !

!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:57:53'!
fightWithSoldierWithPistol: aSoldierWithPistol in: aMineField

	self subclassResponsibility! !

!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:05:27'!
loosesIfSecondEvent: anOpponent in: aMineField 
	
	| looser |
	
	looser := aMineField timeOfDaySeconds even ifTrue: [ anOpponent ] ifFalse: [ self ].
	looser loseFight   ! !

!Player methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:21:13'!
loseFight
	
	self 
		decreaseLives;
		moveToInitialPosition ! !


!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 12:51:10'!
doesSharePositionWithTeamMembers
	
	^team doesSharePositionWithTeamMembers: self! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 12:49:45'!
ifSharesPositionWithOpponent: aBlock

	^self opponentTeam if: self sharesPositionWithAnotherPlayerDo: aBlock ! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 12:19:37'!
isAt: aPosition 
	
	^position = aPosition ! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 13:08:12'!
isAtOriginalPoisition
	
	^position = initialPosition ! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 10:55:33'!
isAtRow: aRow

	^position y = aRow ! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 10:55:40'!
isAtValidPositionOf: anExtent andRow: aRow  
	
	^position between: 1@aRow and: anExtent x @ aRow! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 10:55:51'!
moveToInitialPosition
	
	position := initialPosition ! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 10:55:55'!
position
	
	^position! !

!Player methodsFor: 'position' stamp: 'HAW 12/11/2023 10:56:00'!
position: newPosition 
	
	position := newPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Player class' category: #'ISW1-2023-2C-Recuperatorio'!
Player class
	instanceVariableNames: ''!

!Player class methodsFor: 'instance creation' stamp: 'HAW 12/11/2023 11:02:23'!
at: aPlayerPosition lives: aNumberOfLives  
	
	self assertIsValidNumberOfLives: aNumberOfLives.

	^self new initializeAt: aPlayerPosition lives: aNumberOfLives ! !


!Player class methodsFor: 'assertions' stamp: 'HAW 12/11/2023 11:02:28'!
assertIsValidNumberOfLives: aNumberOfLives

	^ (aNumberOfLives strictlyPositive and: [ aNumberOfLives isInteger ]) ifFalse: [ self error: self invalidNumberOfLivesErrorDescription ]! !


!Player class methodsFor: 'error description' stamp: 'HAW 12/11/2023 11:02:32'!
invalidNumberOfLivesErrorDescription
	
	^'Number of lives must be an strictly positive integer'
	
	! !


!classDefinition: #SoldierWithBayonet category: #'ISW1-2023-2C-Recuperatorio'!
Player subclass: #SoldierWithBayonet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!SoldierWithBayonet methodsFor: 'fighting' stamp: 'HAW 12/9/2023 21:07:36'!
fightWith: aPlayer in: aMineField 
	
	^aPlayer fightWithSoldierWithBayonet: self in: aMineField ! !

!SoldierWithBayonet methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:05:44'!
fightWithSoldierWithBayonet: aSoldierWithBayonet in: aMineField 
	
	self loosesIfSecondEvent: aSoldierWithBayonet in: aMineField ! !

!SoldierWithBayonet methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:46:12'!
fightWithSoldierWithMachineGun: aSoldierWithMachineGun in: aMineField 
	
	aSoldierWithMachineGun loseFight   ! !

!SoldierWithBayonet methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:46:16'!
fightWithSoldierWithPistol: aSoldierWithPistol in: aMineField 
	
	aSoldierWithPistol loseFight  
		 ! !


!SoldierWithBayonet methodsFor: 'armor' stamp: 'HAW 12/11/2023 14:57:40'!
wearArmorFrom: anArmorRack in: aMineField 
	
	armor := anArmorRack armor.
	aMineField removeFieldElement: anArmorRack ! !


!classDefinition: #SoldierWithMachineGun category: #'ISW1-2023-2C-Recuperatorio'!
Player subclass: #SoldierWithMachineGun
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!SoldierWithMachineGun methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:11:00'!
fightWith: aPlayer in: aMineField

	^aPlayer fightWithSoldierWithMachineGun: self in: aMineField ! !

!SoldierWithMachineGun methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:46:22'!
fightWithSoldierWithBayonet: aSoldierWithBayonet in: aMineField 
	
	self loseFight    ! !

!SoldierWithMachineGun methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:06:00'!
fightWithSoldierWithMachineGun: aSoldierWithMachineGun in: aMineField 
	
	self loosesIfSecondEvent: aSoldierWithMachineGun in: aMineField ! !

!SoldierWithMachineGun methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:00:50'!
fightWithSoldierWithPistol: aSoldierWithPistol in: aMineField 
	
	aSoldierWithPistol loseFight ! !


!SoldierWithMachineGun methodsFor: 'armor' stamp: 'HAW 12/11/2023 15:42:07'!
wearArmorFrom: anArmorRack in: aMineField 
	
	! !


!classDefinition: #SoldierWithPistol category: #'ISW1-2023-2C-Recuperatorio'!
Player subclass: #SoldierWithPistol
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!SoldierWithPistol methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:11:54'!
fightWith: aPlayer in: aMineField 
	
	^aPlayer fightWithSoldierWithPistol: self in: aMineField ! !

!SoldierWithPistol methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:46:28'!
fightWithSoldierWithBayonet: aSoldierWithBayonet in: aMineField 
	
	self loseFight  
	  ! !

!SoldierWithPistol methodsFor: 'fighting' stamp: 'HAW 12/11/2023 11:20:50'!
fightWithSoldierWithMachineGun: aSoldierWithMachineGun in: aMineField 
	
	aSoldierWithMachineGun loseFight! !

!SoldierWithPistol methodsFor: 'fighting' stamp: 'HAW 12/11/2023 12:05:20'!
fightWithSoldierWithPistol: aSoldierWithPistol in: aMineField 
	
	self loosesIfSecondEvent: aSoldierWithPistol in: aMineField ! !


!SoldierWithPistol methodsFor: 'armor' stamp: 'HAW 12/11/2023 14:58:02'!
wearArmorFrom: anArmorRack in: aMineField 
	
	! !


!classDefinition: #Team category: #'ISW1-2023-2C-Recuperatorio'!
Object subclass: #Team
	instanceVariableNames: 'players destinationRow playersOrder opponent'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Recuperatorio'!

!Team methodsFor: 'initialization' stamp: 'HAW 12/11/2023 13:00:04'!
initializeWith: aPlayers 
	
	players := aPlayers.
	players do: [ :aPlayer | aPlayer team: self ].
	
	playersOrder := CircularReadStream on: players moving: NullUnit new.
	players notEmpty ifTrue: [ playersOrder previous ].
	
	! !


!Team methodsFor: 'opponent' stamp: 'HAW 12/10/2023 17:31:32'!
opponent
	
	^opponent! !

!Team methodsFor: 'opponent' stamp: 'HAW 12/10/2023 22:14:01'!
opponent: anOpponentTeam

	opponent := anOpponentTeam ! !


!Team methodsFor: 'testing' stamp: 'HAW 12/10/2023 17:08:48'!
hasWon
	
	^players anySatisfy: [ :aPlayer | aPlayer isAlive and: [ aPlayer isAtRow: destinationRow ]]
		! !


!Team methodsFor: 'assertions' stamp: 'HAW 12/10/2023 16:54:33'!
assertPlayerAreInBounds: anExtent atRow: aRow andNotUsedBy: aCollectionOfFieldElements 
	
	self assertPlayersAreInBounds: anExtent atRow: aRow.
	self assertPlayersAreNotAtSamePositionOf: aCollectionOfFieldElements.! !

!Team methodsFor: 'assertions' stamp: 'HAW 12/10/2023 16:53:35'!
assertPlayersAreInBounds: anExtent atRow: aRow 
	
	(players allSatisfy: [ :aPlayer | aPlayer isAtValidPositionOf: anExtent andRow: aRow ]) 
		ifFalse: [self error: MineField invalidStartingPositionErrorDescription ]! !

!Team methodsFor: 'assertions' stamp: 'HAW 12/10/2023 16:54:20'!
assertPlayersAreNotAtSamePositionOf: aCollectionOfFieldElements 
	
	(aCollectionOfFieldElements anySatisfy: [ :aFieldElement | 
		players anySatisfy: [ :aPlayer | aFieldElement isAt: aPlayer position ]])
			ifTrue: [self error: MineField invalidStartingPositionErrorDescription ]! !


!Team methodsFor: 'position' stamp: 'HAW 12/10/2023 17:07:21'!
destinationRow: aRow

	destinationRow := aRow! !

!Team methodsFor: 'position' stamp: 'HAW 12/11/2023 12:50:58'!
doesSharePositionWithTeamMembers: aPlayer

	self if: aPlayer sharesPositionWithAnotherPlayerDo: [ :sharedPositionPlayer | ^true ].
	^false! !

!Team methodsFor: 'position' stamp: 'HAW 12/11/2023 12:49:45'!
if: aPlayer sharesPositionWithAnotherPlayerDo: aBlock 
	
	^players 
		detect: [ :anotherPlayer | anotherPlayer ~= aPlayer and: [ anotherPlayer isAliveAt: aPlayer position ]]
		ifFound: aBlock
		ifNone: []! !


!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 17:10:41'!
areAllPlayersDead
	
	^players allSatisfy: [ :aPlayer | aPlayer isAlive not ]! !

!Team methodsFor: 'players' stamp: 'HAW 12/11/2023 12:27:00'!
firstPlayer
	
	^players first! !

!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 16:46:15'!
hasNoPlayers
	
	^players isEmpty ! !

!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 16:46:03'!
hasOnePlayer
	
	^players size = 1! !

!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 17:16:23'!
nextPlayerIfNone: aNoneBlock

	^self areAllPlayersDead 
		ifTrue: aNoneBlock 
		ifFalse: [ 
			[ playersOrder next isAlive ] whileFalse.
			playersOrder current ].! !

!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 21:38:17'!
playersSize
	
	^players size! !

!Team methodsFor: 'players' stamp: 'HAW 12/10/2023 21:39:00'!
totalPlayersLives
	
	^players sum: [ :aPlayer | aPlayer lives ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Team class' category: #'ISW1-2023-2C-Recuperatorio'!
Team class
	instanceVariableNames: ''!

!Team class methodsFor: 'instance creation' stamp: 'HAW 12/11/2023 12:58:36'!
with: aPlayers 

	self assertDoNotSharePositions: aPlayers.

	^self new initializeWith: aPlayers ! !


!Team class methodsFor: 'error descriptions' stamp: 'HAW 12/11/2023 12:59:15'!
invalidStartingPositionErrorDescription
	
	^'Player must start at an empty position, inside the board and at the right row'! !


!Team class methodsFor: 'assertions' stamp: 'HAW 12/11/2023 12:59:12'!
assertDoNotSharePositions: aPlayers

	^ aPlayers combinations: 2 atATimeDo: [ :twoPlayers | (twoPlayers first isAt: twoPlayers second position) 
		ifTrue: [ self error: self invalidStartingPositionErrorDescription ]]! !
