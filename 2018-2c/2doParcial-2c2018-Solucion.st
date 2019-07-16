!classDefinition: #FintechTest category: #'ISW1-Fintech'!
TestCase subclass: #FintechTest
	instanceVariableNames: 'clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
clock : <ManualClock>
"!

!FintechTest methodsFor: 'set up' stamp: 'HAW 12/11/2018 14:07:15'!
setUp

	clock := ManualClock now: DateAndTime now! !


!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test01WhenCreatingAWalletItsBalanceIsOneISW1Coin

	| fintech walletId |
	
	fintech := Fintech measuringTimeWith: clock.
	
	walletId := fintech createWallet.
	
	self assert: (fintech balanceOf: walletId) equals: 1*fintech coin! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test02CanNotGetBalanceOfInvalidWalletId

	| fintech |
	
	fintech := Fintech measuringTimeWith: clock.
	
	self 
		should: [ fintech balanceOf: Object new ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech invalidWalletIdErrorMessage ]
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test03CreateWalletUsesDifferentIds

	| fintech sourceWalletId targetWalletId |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	self deny: sourceWalletId = targetWalletId 
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test04SlowTransferWithdrawsAmountAndComisionFromSourceWallet

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer - transferAmount - (fintech slowTransferCommissionOf: transferAmount)
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test05SlowTransferDepositsAreNotImpactedBeforeOneHour

	| fintech sourceWalletId targetWalletId transferAmount targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test06SlowTransferDepositsAreNotImpactedAfterOneHour

	| fintech sourceWalletId targetWalletId transferAmount targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	clock advanceTime: 1 hours.
	
	self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer + transferAmount
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:57:57'!
test06_01SlowTransfersRegistersDepositAndWithdraw

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletTransactions targetWalletTransactions |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	sourceWalletTransactions := fintech allTransactionsOf: sourceWalletId.
	targetWalletTransactions := fintech allTransactionsOf: targetWalletId.
	
	self assert: sourceWalletTransactions size equals: 1.
	self assert: targetWalletTransactions size equals: 1.
	self assert: (sourceWalletTransactions anyOne isOfSameTransferAs: targetWalletTransactions anyOne)
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/11/2018 12:27:54'!
test06_02SlowTransferDepositsArePendingBeforeImpactTime

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletTransactions targetWalletTransactions |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	sourceWalletTransactions := fintech allTransactionsOf: sourceWalletId.
	targetWalletTransactions := fintech allPendingTransactionsOf: targetWalletId.
	
	self assert: sourceWalletTransactions size equals: 1.
	self assert: targetWalletTransactions size equals: 1.
	self assert: (sourceWalletTransactions anyOne isOfSameTransferAs: targetWalletTransactions anyOne)
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:57:32'!
test06_03SlowTransferDepositsAreNotPendingAftermpactTime

	| fintech sourceWalletId targetWalletId transferAmount targetWalletTransactions |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	clock advanceTime: fintech slowImpactDuration.
	
	targetWalletTransactions := fintech allPendingTransactionsOf: targetWalletId.
	
	self assert: targetWalletTransactions isEmpty ! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:58:46'!
test06_04SlowTransferWithdrawAreNeverPending

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletTransactions |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	sourceWalletTransactions := fintech allPendingTransactionsOf: sourceWalletId.
	
	self assert: sourceWalletTransactions isEmpty ! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test07CanNotMakeASlowTransferFromAnInvalidSourceWalletId

	| fintech sourceWalletId targetWalletId transferAmount targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := Object new.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self 
		should: [ fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech invalidWalletIdErrorMessage.
			clock advanceTime: 1 hours.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ]
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test08CanNotMakeASlowTransferToAnInvalidTargetWalletId

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := Object new.
	transferAmount := 0.5*fintech coin.
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	
	self 
		should: [ fintech slowTransfer: transferAmount from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech invalidWalletIdErrorMessage.
			self assert: (fintech balanceOf: sourceWalletId ) equals: sourceWalletBalanceBeforeTransfer ]
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test09FastTransferWithdrawsAmountAndComisionFromSourceWallet

	| fintech sourceWalletId targetWalletId transferAmount sourceWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	fintech fastTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer - transferAmount - (fintech fastTransferCommissionOf: transferAmount)
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test10FastTransferDepositsAreNotImpactedBeforeOneHour

	| fintech sourceWalletId targetWalletId transferAmount targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	fintech fastTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	
	self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test11FastTransferDepositsAreNotImpactedAfterTenMinutes

	| fintech sourceWalletId targetWalletId transferAmount targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	transferAmount := 0.5*fintech coin.
	
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	fintech fastTransfer: transferAmount from: sourceWalletId to: targetWalletId.
	clock advanceTime: 10 minutes.
	
	self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer + transferAmount
	
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test12CanNotSlowTransferWhenNoEnoughBalance

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech slowTransfer: sourceWalletBalanceBeforeTransfer from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech notEnoughBalanceErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech slowImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
			
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test13CanNotFastTransferWhenNoEnoughBalance

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech fastTransfer: sourceWalletBalanceBeforeTransfer from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech notEnoughBalanceErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech fastImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
			
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test14CanNotSlowTransferWhenImpactTimeIsBetween23and24

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	clock := ManualClock now: (DateAndTime year: 2018 month: 1 day: 1 hour: 22 minute: 00).
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech slowTransfer: 0.1*fintech coin from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech outOfTransactionTimeErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech slowImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
			
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/4/2018 19:08:58'!
test15CanNotFastTransferWhenImpactTimeIsBetween23and24

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	clock := ManualClock now: (DateAndTime year: 2018 month: 1 day: 1 hour: 22 minute: 50).
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech fastTransfer: 0.1*fintech coin from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech outOfTransactionTimeErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech fastImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
			
	! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/11/2018 12:32:01'!
test16CanNotMakeSlowTransferWithLessThanMinimumAmount

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech slowTransfer: 0.0000009*fintech coin from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech transferAmountTooSmallErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech slowImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
! !

!FintechTest methodsFor: 'tests' stamp: 'HAW 12/11/2018 12:32:22'!
test17CanNotMakeFastTransferWithLessThanMinimumAmount

	| fintech sourceWalletId targetWalletId sourceWalletBalanceBeforeTransfer targetWalletBalanceBeforeTransfer |
	
	fintech := Fintech measuringTimeWith: clock.
	sourceWalletId := fintech createWallet.
	targetWalletId := fintech createWallet.
	
	sourceWalletBalanceBeforeTransfer := fintech balanceOf: sourceWalletId.
	targetWalletBalanceBeforeTransfer := fintech balanceOf: targetWalletId.
	
	self
		should: [ fintech fastTransfer: 0.0000009*fintech coin from: sourceWalletId to: targetWalletId ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: fintech transferAmountTooSmallErrorDescription.
			self assert: (fintech balanceOf: sourceWalletId) equals: sourceWalletBalanceBeforeTransfer.
			clock advanceTime: fintech fastImpactDuration.
			self assert: (fintech balanceOf: targetWalletId) equals: targetWalletBalanceBeforeTransfer ].
! !


!classDefinition: #Clock category: #'ISW1-Fintech'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 14:23'!
today

	self subclassResponsibility ! !


!classDefinition: #ManualClock category: #'ISW1-Fintech'!
Clock subclass: #ManualClock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
now : <DateAndTime>
"!

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 12:54'!
advanceTime: aDuration

	now := now + aDuration ! !

!ManualClock methodsFor: 'time change' stamp: 'HernanWilkinson 6/22/2013 13:08'!
revertTime: aDuration

	now := now + aDuration negated ! !


!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:56'!
now

	^ now! !

!ManualClock methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:53'!
today

	^now date! !


!ManualClock methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:52'!
initializeNow: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #'ISW1-Fintech'!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:52'!
now: aTime

	^self new initializeNow: aTime ! !


!classDefinition: #Fintech category: #'ISW1-Fintech'!
Object subclass: #Fintech
	instanceVariableNames: 'wallets coin lastId clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
wallets : <Dictionary>
coin : <BaseUnit>
lastId : <SmallInteger>
clock : <ManualClock>
"!

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:48:38'!
allPendingTransactionsOf: aWalletId

	^(self walletIdentifiedAs: aWalletId) pendingTransactionsAt: clock now! !

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:45:02'!
allTransactionsOf: aWalletId

	^(self walletIdentifiedAs: aWalletId) allTransactions! !

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:38:23'!
balanceOf: aWalletId

	^(self walletIdentifiedAs: aWalletId) balanceAt: clock now! !

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:12:54'!
createWallet
	
	lastId := lastId + 1.
	wallets at: lastId put: (Wallet with: 1*self coin).
	
	^lastId ! !

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:04:03'!
fastTransfer: anAmount from: sourceWalletId to: targetWalletId
 
		self transfer: anAmount from: sourceWalletId to: targetWalletId commission: (self fastTransferCommissionOf: anAmount) impactDuration: self fastImpactDuration
! !

!Fintech methodsFor: 'service protocol' stamp: 'HAW 12/4/2018 19:03:51'!
slowTransfer: anAmount from: sourceWalletId to: targetWalletId
 
	self transfer: anAmount from: sourceWalletId to: targetWalletId commission: (self slowTransferCommissionOf: anAmount) impactDuration: self slowImpactDuration.
	! !


!Fintech methodsFor: 'coin' stamp: 'HAW 12/4/2018 14:31:55'!
coin
	
	coin isNil ifTrue: [ coin := BaseUnit named: 'ISW1Coin' ].
	
	^coin! !


!Fintech methodsFor: 'transfer configuration' stamp: 'HAW 12/4/2018 19:04:03'!
fastImpactDuration
	
	^10 minutes! !

!Fintech methodsFor: 'transfer configuration' stamp: 'HAW 12/4/2018 17:35:09'!
fastTransferCommissionOf: anAmount

	^anAmount * 0.04! !

!Fintech methodsFor: 'transfer configuration' stamp: 'HAW 12/4/2018 19:03:51'!
slowImpactDuration
	
	^1 hours! !

!Fintech methodsFor: 'transfer configuration' stamp: 'HAW 12/4/2018 17:34:57'!
slowTransferCommissionOf: anAmount

	^anAmount * 0.02! !


!Fintech methodsFor: 'transfer - private' stamp: 'HAW 12/11/2018 12:29:50'!
transfer: anAmount from: sourceWalletId to: targetWalletId commission: aCommision impactDuration: anImpactDuration
 
	| sourceWallet targetWallet |
	
	self assertAmountBigEnough: anAmount.
	
	sourceWallet := self walletIdentifiedAs: sourceWalletId.
	targetWallet := self walletIdentifiedAs: targetWalletId.

	Transfer registerOf: anAmount from: sourceWallet to: targetWallet at: self now costing: aCommision impactingAfter: anImpactDuration 
! !

!Fintech methodsFor: 'transfer - private' stamp: 'HAW 12/4/2018 19:10:37'!
walletIdentifiedAs: aWalletId

	^wallets at: aWalletId ifAbsent: [ self signalInvalideWalletId ]! !


!Fintech methodsFor: 'initialization' stamp: 'HAW 12/4/2018 19:10:15'!
initializeMeasuringTimeWith: aClock

	clock := aClock.
	wallets := Dictionary new.
	lastId := 0 ! !


!Fintech methodsFor: 'time' stamp: 'HAW 12/4/2018 16:51:46'!
now
	
	^clock now! !


!Fintech methodsFor: 'assertions' stamp: 'HAW 12/11/2018 12:30:33'!
assertAmountBigEnough: anAmount

	anAmount < (0.000001*self coin) ifTrue: [ self signalTransferAmountTooSmall ]! !


!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/4/2018 14:36:46'!
invalidWalletIdErrorMessage
	
	^'Invalid wallet id'! !

!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/4/2018 19:09:15'!
notEnoughBalanceErrorDescription
	
	^Wallet notEnoughBalanceErrorDescription ! !

!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/4/2018 19:09:15'!
outOfTransactionTimeErrorDescription
	
	^Wallet outOfTransactionTimeErrorDescription ! !

!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/4/2018 14:37:42'!
signalInvalideWalletId
	
	^self error: self invalidWalletIdErrorMessage ! !

!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/11/2018 12:33:00'!
signalTransferAmountTooSmall
	
	self error: self transferAmountTooSmallErrorDescription
! !

!Fintech methodsFor: 'exceptions and error descriptions' stamp: 'HAW 12/11/2018 12:30:58'!
transferAmountTooSmallErrorDescription
	
	^'Transfer amount too small'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fintech class' category: #'ISW1-Fintech'!
Fintech class
	instanceVariableNames: ''!

!Fintech class methodsFor: 'instance creation' stamp: 'HAW 12/4/2018 16:45:05'!
measuringTimeWith: aClock 

	^self new initializeMeasuringTimeWith: aClock ! !


!classDefinition: #Transfer category: #'ISW1-Fintech'!
Object subclass: #Transfer
	instanceVariableNames: 'amount sourceWallet targetWallet commission depositLeg withdrawLeg transactionMoment impactDuration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
amount : <SimpleMeasure>
sourceWallet : <Wallet>
targetWallet : <Wallet>
commission : <SimpleMeasure>
depositLeg : <TransferDeposit>
withdrawLeg : <TransferWithdraw>
transactionMoment : <DateAndTime>
impactDuration : <Duration>
"!

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:28:11'!
amount
	
	^amount! !

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:28:33'!
commission
	
	^commission! !

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:25:51'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:37:41'!
impactDuration
	
	^impactDuration! !

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:37:00'!
transactionMoment
	
	^transactionMoment! !

!Transfer methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:25:39'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'HAW 12/4/2018 17:37:27'!
initializeOf: anAmount from: aSourceWallet to: aTargetWallet at: aTransactionMoment costing: aCommission impactingAfter: anImpactDuration 

	amount := anAmount.
	sourceWallet := aSourceWallet.
	targetWallet := aTargetWallet.
	transactionMoment := aTransactionMoment.
	commission := aCommission.
	impactDuration := anImpactDuration.
	
	depositLeg := TransferDeposit for: self.
	withdrawLeg := TransferWithdraw for: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'ISW1-Fintech'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'HAW 12/4/2018 17:36:29'!
of: anAmount from: sourceWallet to: targetWallet at: transactionMoment costing: aCommission impactingAfter: aDuration 

	^self new initializeOf: anAmount from: sourceWallet to: targetWallet at: transactionMoment costing: aCommission impactingAfter: aDuration ! !


!Transfer class methodsFor: 'registration' stamp: 'HAW 12/5/2018 08:35:55'!
registerOf: anAmount from: sourceWallet to: targetWallet at: transactionMoment costing: aCommision impactingAfter: aDuration 
	
	| transfer |
	
	transfer := self of: anAmount from: sourceWallet to: targetWallet at: transactionMoment costing: aCommision impactingAfter: aDuration.
	 
	"Hay distintas manera de verificar si se puede registrar la transaccion. Yo elegui que este en el register de Wallet para que siempre se 
	verifiquen las precondiciones, pero eso hace mas compleja esta parte, como handlear cuando no se puede registrar la depositLeg para 
	deregistrar la withdrawLeg. Otra opcion seria aca verificar las precondiciones, algo como:
	
	sourceWallet assertCanRegisterTransferWithdraw: transfer withdrawLeg.
	targetWallet assertCanRegisterTransferDeposit: transfer depositLeg.
	....
	
	Otra seria:
	sourceWallet assertCanRegister: transfer withdrawLeg.
	targetWallet assertCanRegister: transfer depositLeg.
	....
	y que el assertCanRegister: haga un DD con la transaccion - Hernan"
	
	sourceWallet register: transfer withdrawLeg.
	[ targetWallet register: transfer depositLeg ]
		on: Error
		do: [ :anError | 
			sourceWallet unregister: transfer withdrawLeg.
			anError pass ]! !


!classDefinition: #TransferLeg category: #'ISW1-Fintech'!
Object subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
transfer : <Transfer>
"!

!TransferLeg methodsFor: 'balance' stamp: 'HAW 12/4/2018 17:33:23'!
affectBalance: aBalance at: aDateAndTime 

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:32:23'!
amount
	
	^ transfer amount! !

!TransferLeg methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:32:27'!
commission
	
	^transfer commission! !

!TransferLeg methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:37:41'!
impactDuration
	
	^transfer impactDuration! !

!TransferLeg methodsFor: 'accessing' stamp: 'HAW 12/4/2018 17:37:00'!
transactionMoment
	
	^transfer transactionMoment! !

!TransferLeg methodsFor: 'accessing' stamp: 'HAW 12/4/2018 19:45:45'!
transfer
	
	^transfer! !


!TransferLeg methodsFor: 'initialization' stamp: 'HAW 12/4/2018 17:32:33'!
initializeFor: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'testing' stamp: 'HAW 12/4/2018 19:45:35'!
isOfSameTransferAs: aTransferLeg

	^transfer = aTransferLeg transfer! !

!TransferLeg methodsFor: 'testing' stamp: 'HAW 12/4/2018 20:00:31'!
isPendingAt: aDateAndTime

	self subclassResponsibility ! !


!TransferLeg methodsFor: 'assertions' stamp: 'HAW 12/4/2018 19:38:56'!
assertCanRegisterIn: aWallet

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'ISW1-Fintech'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'HAW 12/11/2018 14:09:31'!
for: aTransfer 
	
	^self new initializeFor: aTransfer ! !


!classDefinition: #TransferDeposit category: #'ISW1-Fintech'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!TransferDeposit methodsFor: 'accessing' stamp: 'HAW 12/4/2018 18:52:35'!
impactTime
	
	^(self transactionMoment + self impactDuration) time! !


!TransferDeposit methodsFor: 'balance' stamp: 'HAW 12/4/2018 20:00:01'!
affectBalance: aBalance at: aDateAndTime 
	
	^(self isPendingAt: aDateAndTime)
		ifTrue: [ aBalance ]
		ifFalse: [ aBalance + self amount ]! !


!TransferDeposit methodsFor: 'assertions' stamp: 'HAW 12/5/2018 08:37:58'!
assertCanRegisterIn: aWallet

	"La verdad no es necesario hacer un DD aca... se podria hacer la verificacion
	directamente. Hago el DD porque me parece mas lindo que la verificacion quede en 
	la Wallet y no en la transaccion - Hernan"
	
	aWallet assertCanRegisterTransferDeposit: self! !


!TransferDeposit methodsFor: 'testing' stamp: 'HAW 12/4/2018 19:49:51'!
isPendingAt: aDateAndTime 
	
	^(aDateAndTime - self transactionMoment) < self impactDuration! !


!classDefinition: #TransferWithdraw category: #'ISW1-Fintech'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'!

!TransferWithdraw methodsFor: 'balance' stamp: 'HAW 12/4/2018 17:26:16'!
affectBalance: aBalance at: aTime 

	^aBalance - self amount - self commission ! !


!TransferWithdraw methodsFor: 'assertions' stamp: 'HAW 12/5/2018 08:38:20'!
assertCanRegisterIn: aWallet

	"Ver comentario de TransferDeposit>>#assertCanRegisterIn: - Hernan"
	
	aWallet assertCanRegisterTransferWithdraw: self
! !


!TransferWithdraw methodsFor: 'testing' stamp: 'HAW 12/4/2018 19:58:54'!
isPendingAt: aDateAndTime 
	
	^false! !


!classDefinition: #Wallet category: #'ISW1-Fintech'!
Object subclass: #Wallet
	instanceVariableNames: 'initialBalance transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-Fintech'
"
initialBalance : <SimpleMeasure>
transactions : <OrderedCollection>
"!

!Wallet methodsFor: 'transactions' stamp: 'HAW 12/4/2018 19:45:12'!
allTransactions
	
	^transactions copy! !

!Wallet methodsFor: 'transactions' stamp: 'HAW 12/4/2018 19:49:08'!
pendingTransactionsAt: aDateAndTime 
	
	^transactions select: [ :aTransaction | aTransaction isPendingAt: aDateAndTime ]! !

!Wallet methodsFor: 'transactions' stamp: 'HAW 12/4/2018 17:54:25'!
register: aTransaction

	aTransaction assertCanRegisterIn: self.
	
	transactions add: aTransaction ! !

!Wallet methodsFor: 'transactions' stamp: 'HAW 12/4/2018 19:02:00'!
unregister: aTransaction

	transactions remove: aTransaction ! !


!Wallet methodsFor: 'assertions' stamp: 'HAW 12/4/2018 18:57:59'!
assertCanRegisterTransferDeposit: aTransferDeposit 
	
	(aTransferDeposit impactTime between: (Time hour: 23 minute: 0 second: 0) and: (Time hour: 23 minute: 59 second: 59))
		ifTrue: [ self signalOutOfTransactionTime]! !

!Wallet methodsFor: 'assertions' stamp: 'HAW 12/11/2018 14:11:44'!
assertCanRegisterTransferWithdraw: aTransferWithdraw 
	
	| futureBalance |
	
	futureBalance := aTransferWithdraw affectBalance: (self balanceAt: aTransferWithdraw transactionMoment) at: aTransferWithdraw transactionMoment.
	futureBalance negative ifTrue: [ self signalNotEnoughBalance]! !


!Wallet methodsFor: 'balance' stamp: 'HAW 12/4/2018 19:38:23'!
balanceAt: aTime
	
	^transactions 
		inject: initialBalance 
		into: [ :balance :transaction | transaction affectBalance: balance at: aTime ]! !


!Wallet methodsFor: 'initialization' stamp: 'HAW 12/4/2018 19:11:28'!
initializeWith: anInitialBalance

	initialBalance := anInitialBalance.
	transactions := OrderedCollection new! !


!Wallet methodsFor: 'exceptions' stamp: 'HAW 12/4/2018 18:00:10'!
signalNotEnoughBalance
	
	self error: self class notEnoughBalanceErrorDescription! !

!Wallet methodsFor: 'exceptions' stamp: 'HAW 12/4/2018 18:59:19'!
signalOutOfTransactionTime
	
	^self error: self class outOfTransactionTimeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Wallet class' category: #'ISW1-Fintech'!
Wallet class
	instanceVariableNames: ''!

!Wallet class methodsFor: 'error messages' stamp: 'HAW 12/4/2018 18:00:28'!
notEnoughBalanceErrorDescription
	
	^'No enough balance to register transaction'! !

!Wallet class methodsFor: 'error messages' stamp: 'HAW 12/4/2018 18:59:33'!
outOfTransactionTimeErrorDescription
	
	^'Out of transaction time'! !


!Wallet class methodsFor: 'instance creation' stamp: 'HAW 12/4/2018 19:12:25'!
with: anInitialBalance

	^self new initializeWith: anInitialBalance
! !
