!classDefinition: #CoffeeShopTest category: #'IngSof1-2019-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'HAW 9/23/2019 08:55:28'!
setUp

	adaLovelace := CoffeeShopCustomer goldNamed: 'Ada Lovelace'.
	alanKay := CoffeeShopCustomer silverNamed: 'Alan Kay'.
	billGates := CoffeeShopCustomer normalNamed: 'Bill Gates'! !


!CoffeeShopTest methodsFor: 'test objects' stamp: 'HAW 9/23/2019 08:59:18'!
combo1

	^CoffeeShopProduct combo1! !

!CoffeeShopTest methodsFor: 'test objects' stamp: 'HAW 9/23/2019 08:59:25'!
combo2

	^CoffeeShopProduct combo2 ! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 20:22:35'!
assertSalesMadeTo: aCustomer are: aQuantity ofType: aProductTypeBlock

	| salesToCustomer |
	
	salesToCustomer := salesSystem salesMadeTo: aCustomer.
	self assert: aQuantity equals: salesToCustomer size.
	self assert: aQuantity equals: (salesToCustomer count: aProductTypeBlock)! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:18:36'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	salesSystem := CoffeeShopSalesSystem new.

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:18:36'!
test02CanQuerySalesByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	self assertSalesMadeTo: adaLovelace are: 1 ofType: [ :aProduct | aProduct = self combo1 ]
	! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:18:36'!
test03SalesAreDistinguishedByCustomer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	self assertSalesMadeTo: adaLovelace are: 2 ofType: [ :aProduct | aProduct = self combo1 ].
	self assertSalesMadeTo: alanKay are: 1 ofType: [ :aProduct | aProduct = self combo2 ]! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:18:36'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:18:36'!
test05VolumesSoldToCustomerIs_250_WhenOnlyCombo1WasBought

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:18:36'!
test06VolumesSoldToCustomerIs_100_WhenOnlyCombo2WasBought

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:18:36'!
test07VolumesSoldToCustomerIsTheSumOfAllSales

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 20:25:09'!
assertRewardOf: aCustomer is: aQuantity of: aRewardTypeBlock at: aPrice

	| customerReward |
	
	customerReward := salesSystem rewardOf: aCustomer ifNone: [ self fail ].

	self assert: aQuantity equals: customerReward quantity.
	self assert: (aRewardTypeBlock value: customerReward).
	self assert: aPrice equals: customerReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 20:29:19'!
registerSalesForCombo1RewardTo: aCustomer

	salesSystem registerSaleTo: aCustomer of: self combo1.
	salesSystem registerSaleTo: aCustomer of: self combo1.
	salesSystem registerSaleTo: aCustomer of: self combo2.! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:17:22'!
registerSalesForCombo1RewardTo: aCustomer andAssertPriceIs: aPrice

	self registerSalesForCombo1RewardTo: aCustomer.
	self assertRewardOf: aCustomer is: 2 of: [ :aReward | aReward isForCombo1 ] at: aPrice ! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 20:27:16'!
registerSalesForCombo2RewardTo: aCustomer

	salesSystem registerSaleTo: aCustomer of: self combo1.
	salesSystem registerSaleTo: aCustomer of: self combo2.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:15:55'!
registerSalesForCombo2RewardTo: aCustomer andAssertPriceIs: aPrice

	self registerSalesForCombo2RewardTo: aCustomer.
	self assertRewardOf: aCustomer is: 1 of: [ :aReward | aReward isForCombo2 ] at: aPrice! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test08WhenNothingHasBeenSoldToCustomerThereIsNoRewardForHer

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self fail.! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo2RewardTo: adaLovelace andAssertPriceIs: 60*peso! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo2RewardTo: alanKay andAssertPriceIs: 120*3/4*peso ! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo2RewardTo: billGates andAssertPriceIs: 120*9/10*peso ! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo1RewardTo: adaLovelace andAssertPriceIs: 75*peso 
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo1RewardTo: alanKay andAssertPriceIs: 83*peso
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:18:36'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	salesSystem := CoffeeShopSalesSystem new.
	self registerSalesForCombo1RewardTo: billGates andAssertPriceIs: 97*peso
! !


!classDefinition: #CoffeeShopCustomer category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'HAW 9/23/2019 08:54:02'!
initializeNamed: aName ofType: aType

	name := aName.
	type := aType.
	! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'HAW 9/22/2019 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !


!CoffeeShopCustomer methodsFor: 'reward price' stamp: 'HAW 9/23/2019 08:54:17'!
rewardPriceFor: aReward

	^type rewardPriceFor: aReward ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 08:53:09'!
goldNamed: aName 

	^self named: aName ofType: CoffeeShopGoldCustomer new! !

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 08:53:44'!
named: aName ofType: aType

	^self new initializeNamed: aName ofType: aType! !

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 08:53:28'!
normalNamed: aName 

	^self named: aName ofType: CoffeeShopNormalCustomer new! !

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 08:53:18'!
silverNamed: aName 

	^self named: aName ofType: CoffeeShopSilverCustomer new! !


!classDefinition: #CoffeeShopCustomerType category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopCustomerType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopCustomerType methodsFor: 'reward price' stamp: 'HAW 9/23/2019 08:54:32'!
rewardPriceFor: aCustomer

	self subclassResponsibility ! !


!classDefinition: #CoffeeShopGoldCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomerType subclass: #CoffeeShopGoldCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopGoldCustomer methodsFor: 'reward price' stamp: 'HAW 9/22/2019 21:32:02'!
rewardPriceFor: aReward

	^aReward rewardPriceForGoldCustomer! !


!classDefinition: #CoffeeShopNormalCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomerType subclass: #CoffeeShopNormalCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopNormalCustomer methodsFor: 'reward price' stamp: 'HAW 9/22/2019 21:33:38'!
rewardPriceFor: aReward

	^aReward rewardPriceForNormalCustomer! !


!classDefinition: #CoffeeShopSilverCustomer category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomerType subclass: #CoffeeShopSilverCustomer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopSilverCustomer methodsFor: 'reward price' stamp: 'HAW 9/22/2019 21:32:57'!
rewardPriceFor: aReward

	^aReward rewardPriceForSilverCustomer! !


!classDefinition: #CoffeeShopProduct category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopProduct
	instanceVariableNames: 'price volume'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopProduct methodsFor: 'price/volume' stamp: 'HAW 9/23/2019 08:57:19'!
price

	^price! !

!CoffeeShopProduct methodsFor: 'price/volume' stamp: 'HAW 9/23/2019 08:57:27'!
volume

	^volume ! !


!CoffeeShopProduct methodsFor: 'initialization' stamp: 'HAW 9/23/2019 09:02:56'!
initializeOf: aVolume at: aPrice

	volume := aVolume.
	price := aPrice.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopProduct class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopProduct class
	instanceVariableNames: 'combo1 combo2'!

!CoffeeShopProduct class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 09:02:40'!
combo1

	^combo1! !

!CoffeeShopProduct class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 09:02:46'!
combo2

	^combo2 ! !

!CoffeeShopProduct class methodsFor: 'instance creation' stamp: 'HAW 9/23/2019 09:02:29'!
of: aVolume at: aPrice 

	^self new initializeOf: aVolume at: aPrice 
! !


!CoffeeShopProduct class methodsFor: 'initialization' stamp: 'HAW 9/23/2019 09:03:14'!
initialize

	combo1 := self of: 250*milliliter at: 150*peso.
	combo2 := self of: 100*milliliter at: 120*peso! !


!classDefinition: #CoffeeShopReward category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopReward
	instanceVariableNames: 'price quantity product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopReward methodsFor: 'accessing' stamp: 'HAW 9/20/2019 17:54:42'!
price

	^price! !

!CoffeeShopReward methodsFor: 'accessing' stamp: 'HAW 9/21/2019 16:31:13'!
quantity

	^quantity ! !


!CoffeeShopReward methodsFor: 'initialization' stamp: 'HAW 9/22/2019 19:08:08'!
initializeOf: aProduct at: aPrice quantity: aQuantity

	product := aProduct.
	price := aPrice.
	quantity := aQuantity
	! !


!CoffeeShopReward methodsFor: 'testing' stamp: 'HAW 9/23/2019 09:00:41'!
isForCombo1
	
	^product = CoffeeShopProduct combo1 ! !

!CoffeeShopReward methodsFor: 'testing' stamp: 'HAW 9/23/2019 09:01:02'!
isForCombo2
	
	^product = CoffeeShopProduct combo2 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopReward class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopReward class
	instanceVariableNames: ''!

!CoffeeShopReward class methodsFor: 'instance creation' stamp: 'HAW 9/20/2019 17:53:14'!
of: aComboType at: aPrice quantity: aQuantity

	^self new initializeOf: aComboType at: aPrice quantity: aQuantity
! !


!classDefinition: #CoffeeShopSalesSystem category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopSalesSystem
	instanceVariableNames: 'sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopSalesSystem methodsFor: 'initialization' stamp: 'HAW 9/20/2019 17:17:34'!
initialize

	sales := Dictionary new! !


!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/22/2019 19:06:50'!
registerSaleTo: aCustomer of: aProduct

	| salesToCustomer |

	salesToCustomer := sales at: aCustomer ifAbsentPut: [ OrderedCollection new ].
	salesToCustomer add: aProduct ! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/20/2019 17:24:49'!
salesMadeTo: aCustomer

	^sales at: aCustomer ifAbsent: [ #() ]! !

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/22/2019 21:26:40'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | aProduct volume ] ifEmpty: [ 0*milliliter ]! !


!CoffeeShopSalesSystem methodsFor: 'rewarding' stamp: 'HAW 9/22/2019 19:53:42'!
rewardOf: aCustomer ifNone: noneBlock 

	| salesToCustomer volumeSoldToCustomer rewardRule |

	salesToCustomer := self salesMadeTo: aCustomer.
	volumeSoldToCustomer := self volumeSoldTo: aCustomer.
	
	rewardRule := RewardRule for: volumeSoldToCustomer ifNone: [^noneBlock value].
	^rewardRule createRewardFor: aCustomer.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopSalesSystem class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopSalesSystem class
	instanceVariableNames: ''!

!CoffeeShopSalesSystem class methodsFor: 'initialization' stamp: 'HAW 9/20/2019 17:32:54'!
initialize

	liter := BaseUnit named: 'liter'.
	milliliter := ProportionalDerivedUnit baseUnit: liter conversionFactor: 1/100 named: 'milliliter'.! !


!classDefinition: #RewardRule category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #RewardRule
	instanceVariableNames: 'product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 21:35:14'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	price := aCustomer rewardPriceFor: self.
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:26'!
productQuantity

	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:33'!
rewardedProduct

	self subclassResponsibility ! !


!RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:36:18'!
rewardPriceForGoldCustomer

	self subclassResponsibility ! !

!RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:36:31'!
rewardPriceForNormalCustomer

	self subclassResponsibility ! !

!RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:36:26'!
rewardPriceForSilverCustomer

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
RewardRule class
	instanceVariableNames: ''!

!RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 
		
	self subclassResponsibility ! !


!RewardRule class methodsFor: 'instance creation' stamp: 'HAW 9/22/2019 19:53:42'!
for: volumeSoldToCustomer ifNone: aNoneBlock

	^self subclasses 
		detect: [ :aRuleClass | aRuleClass isFor: volumeSoldToCustomer ] 
		ifFound: [ :aRuleClass | aRuleClass new ]
		ifNone: aNoneBlock ! !


!classDefinition: #Combo1RewardRule category: #'IngSof1-2019-2C-1Parcial'!
RewardRule subclass: #Combo1RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:54:35'!
productQuantity
	
	^2! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/23/2019 09:00:06'!
rewardedProduct
	
	^CoffeeShopProduct combo1 ! !


!Combo1RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:32:17'!
rewardPriceForGoldCustomer
	
	^ 75*peso
	! !

!Combo1RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:33:50'!
rewardPriceForNormalCustomer
	
	^ 97*peso ! !

!Combo1RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:33:10'!
rewardPriceForSilverCustomer

	^ 83*peso ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo1RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
Combo1RewardRule class
	instanceVariableNames: ''!

!Combo1RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer > (500*milliliter)! !


!classDefinition: #Combo2RewardRule category: #'IngSof1-2019-2C-1Parcial'!
RewardRule subclass: #Combo2RewardRule
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:23:07'!
productQuantity

	^1! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/23/2019 09:01:14'!
rewardedProduct
	
	^CoffeeShopProduct combo2 ! !


!Combo2RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:34:38'!
rewardPriceForGoldCustomer
	
	^product price/2 
	! !

!Combo2RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:35:06'!
rewardPriceForNormalCustomer
	
	^product price *9/10! !

!Combo2RewardRule methodsFor: 'price' stamp: 'HAW 9/22/2019 21:34:53'!
rewardPriceForSilverCustomer
	
	^product price*3/4
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopProduct initialize!
CoffeeShopSalesSystem initialize!