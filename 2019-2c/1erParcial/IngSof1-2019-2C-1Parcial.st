!classDefinition: #CoffeeShopTest category: #'IngSof1-2019-2C-1Parcial'!
TestCase subclass: #CoffeeShopTest
	instanceVariableNames: 'billGates adaLovelace alanKay salesSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopTest methodsFor: 'setUp/tearDown' stamp: 'HAW 9/22/2019 21:41:38'!
setUp

	adaLovelace := CoffeeShopCustomer named: 'Ada Lovelace' ofType: #Gold.
	alanKay := CoffeeShopCustomer named: 'Alan Kay' ofType: #Silver.
	billGates := CoffeeShopCustomer named: 'Bill Gates' ofType: #Normal! !


!CoffeeShopTest methodsFor: 'test objects' stamp: 'HAW 9/20/2019 17:15:53'!
combo1

	^#Combo1! !

!CoffeeShopTest methodsFor: 'test objects' stamp: 'HAW 9/20/2019 17:21:01'!
combo2

	^#Combo2! !


!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:41:51'!
test01ThereAreNoSalesWhenSalesSystemIsCreated

	salesSystem := CoffeeShopSalesSystem new.

	self assert: (salesSystem salesMadeTo: adaLovelace) isEmpty! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:41:51'!
test02CanQuerySalesByCustomer

	| salesToAdaLovelace |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	
	salesToAdaLovelace := salesSystem salesMadeTo: adaLovelace.
	self assert: 1 equals: salesToAdaLovelace size.
	self assert: 1 equals: (salesToAdaLovelace count: [ :aProduct | aProduct = self combo1 ])! !

!CoffeeShopTest methodsFor: 'tests - sales' stamp: 'HAW 9/22/2019 21:41:51'!
test03SalesAreDistinguishedByCustomer

	| salesToAdaLovelace salesToAlanKay |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	salesToAdaLovelace := salesSystem salesMadeTo: adaLovelace.
	self assert: 1 equals: salesToAdaLovelace size.
	self assert: 1 equals: (salesToAdaLovelace count: [ :aProduct | aProduct = self combo1 ]).

	salesToAlanKay := salesSystem salesMadeTo: alanKay.
	self assert: 1 equals: salesToAlanKay size.
	self assert: 1 equals: (salesToAlanKay  count: [ :aProduct | aProduct = self combo2 ])! !


!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:41:51'!
test04VolumeSoldToCustomerIsZeroWhenCustomerHasNoSaleRegistered

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 0*milliliter equals: volumeSoldToCustomer! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:19'!
test05VolumeIs_250_WhenOnlyCombo1WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 250*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:07'!
test06VolumeIs_100_WhenOnlyCombo2WasSoldToCustomer

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: 100*milliliter equals: volumeSoldToCustomer ! !

!CoffeeShopTest methodsFor: 'tests - volume sold' stamp: 'HAW 9/22/2019 21:46:41'!
test07VolumeSoldToCustomerIsTheSumOfAllSoldProducts

	| volumeSoldToCustomer |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	volumeSoldToCustomer := salesSystem volumeSoldTo: adaLovelace.

	self assert: (250*milliliter)+(100*milliliter) equals: volumeSoldToCustomer ! !


!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:48:39'!
test08NoRewardExpectedWhenCustomerHasNotBuyAnything

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem rewardOf: adaLovelace ifNone: [ ^self ].
	
	self failWith: 'No reward expected when customer has not buy anything'! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test09GoldCustomerGetsRewardedWithOneCombo2With50PercentItsPriceWhenRule1Holds

	| adaLovelaceReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assert: 1 equals: adaLovelaceReward quantity.
	self assert: adaLovelaceReward isForCombo2.
	self assert: 60*peso equals: adaLovelaceReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test10SilverCustomerGetsRewardedWithOneCombo2With75PercentItsPriceWhenRule1Holds

	| alaKayReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	alaKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assert: 1 equals: alaKayReward quantity.
	self assert: alaKayReward isForCombo2.
	self assert: 120*3/4*peso equals: alaKayReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test11NormalCustomerGetsRewardedWithOneCombo2With90PercentItsPriceWhenRule1Holds

	| billGatesReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].

	self assert: 1 equals: billGatesReward quantity.
	self assert: billGatesReward isForCombo2.
	self assert: 120*9/10*peso equals: billGatesReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test12GoldCustomerGetsRewardedWithOneCombo1At75PesosWhenRule2Holds

	| adaLovelaceReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo1.
	salesSystem registerSaleTo: adaLovelace of: self combo2.

	adaLovelaceReward := salesSystem rewardOf: adaLovelace ifNone: [ self fail ].

	self assert: 2 equals: adaLovelaceReward quantity.
	self assert: adaLovelaceReward isForCombo1.
	self assert: 75*peso equals: adaLovelaceReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test13SilverCustomerGetsRewardedWithOneCombo1At83PesosWhenRule2Holds

	| alanKayReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo1.
	salesSystem registerSaleTo: alanKay of: self combo2.

	alanKayReward := salesSystem rewardOf: alanKay ifNone: [ self fail ].

	self assert: 2 equals: alanKayReward quantity.
	self assert: alanKayReward isForCombo1.
	self assert: 83*peso equals: alanKayReward price.
! !

!CoffeeShopTest methodsFor: 'tests - rewards' stamp: 'HAW 9/22/2019 21:41:51'!
test14NormalCustomerGetsRewardedWithOneCombo1At97PesosWhenRule2Holds

	| billGatesReward |

	salesSystem := CoffeeShopSalesSystem new.

	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo1.
	salesSystem registerSaleTo: billGates of: self combo2.

	billGatesReward := salesSystem rewardOf: billGates ifNone: [ self fail ].

	self assert: 2 equals: billGatesReward quantity.
	self assert: billGatesReward isForCombo1.
	self assert: 97*peso equals: billGatesReward price.
! !


!classDefinition: #CoffeeShopCustomer category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #CoffeeShopCustomer
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!CoffeeShopCustomer methodsFor: 'type' stamp: 'HAW 9/21/2019 13:05:10'!
type

	^type! !


!CoffeeShopCustomer methodsFor: 'initialization' stamp: 'HAW 9/21/2019 13:00:45'!
initializeNamed: aName ofType: aType

	name := aName.
	type := aType ! !


!CoffeeShopCustomer methodsFor: 'printing' stamp: 'HAW 9/22/2019 18:57:07'!
printOn: aStream

	aStream
		nextPutAll: 'Customer named ';
		nextPutAll: name! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CoffeeShopCustomer class' category: #'IngSof1-2019-2C-1Parcial'!
CoffeeShopCustomer class
	instanceVariableNames: ''!

!CoffeeShopCustomer class methodsFor: 'instance creation' stamp: 'HAW 9/21/2019 13:00:21'!
named: aName ofType: aType

	^self new initializeNamed: aName ofType: aType! !


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


!CoffeeShopReward methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:07:57'!
isForCombo1
	
	^product = #Combo1! !

!CoffeeShopReward methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:07:57'!
isForCombo2
	
	^product = #Combo2! !

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

!CoffeeShopSalesSystem methodsFor: 'product volume' stamp: 'HAW 9/22/2019 19:51:19'!
volumeOf: aProduct

	aProduct = #Combo1 ifTrue: [ ^250*milliliter ].
	aProduct = #Combo2 ifTrue: [ ^100*milliliter ].

	self error: 'Invalid product'
	! !


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

!CoffeeShopSalesSystem methodsFor: 'selling' stamp: 'HAW 9/22/2019 19:51:19'!
volumeSoldTo: aCustomer

	 ^(self salesMadeTo: aCustomer) sum: [ :aProduct | self volumeOf: aProduct ] ifEmpty: [ 0*milliliter ]! !


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

!CoffeeShopSalesSystem class methodsFor: 'initialization' stamp: 'HAW 9/23/2019 08:50:03'!
initialize

	Smalltalk at: #milliliter put: (BaseUnit named: 'milliliter')! !


!classDefinition: #RewardRule category: #'IngSof1-2019-2C-1Parcial'!
Object subclass: #RewardRule
	instanceVariableNames: 'product'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IngSof1-2019-2C-1Parcial'!

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:03:50'!
createRewardFor: aCustomer 
	
	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:26'!
productQuantity

	self subclassResponsibility ! !

!RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:51:33'!
rewardedProduct

	self subclassResponsibility ! !


!RewardRule methodsFor: 'product price' stamp: 'HAW 9/22/2019 21:43:12'!
priceOf: aProduct

	aProduct = #Combo1 ifTrue: [ ^150*peso ].
	aProduct = #Combo2 ifTrue: [ ^120*peso ].

	self error: 'Invalid combo type'! !

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

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 21:41:45'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	aCustomer type = #Gold ifTrue: [ price := 75*peso ].
	aCustomer type = #Silver ifTrue: [ price := 83*peso ].
	aCustomer type = #Normal ifTrue: [ price := 97*peso ].
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:54:35'!
productQuantity
	
	^2! !

!Combo1RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:01:41'!
rewardedProduct
	
	^#Combo1! !

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

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 21:41:45'!
createRewardFor: aCustomer 
	
	| price |
	
	product := self rewardedProduct.
	
	aCustomer type = #Gold ifTrue: [ price := (self priceOf: product)/2 ].
	aCustomer type = #Silver ifTrue: [ price := (self priceOf: product)*3/4 ].
	aCustomer type = #Normal ifTrue: [ price := (self priceOf: product)*9/10 ].
	
	^CoffeeShopReward of: product at: price quantity: self productQuantity! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 10:23:07'!
productQuantity

	^1! !

!Combo2RewardRule methodsFor: 'reward creation' stamp: 'HAW 9/22/2019 19:00:28'!
rewardedProduct
	
	^#Combo2! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Combo2RewardRule class' category: #'IngSof1-2019-2C-1Parcial'!
Combo2RewardRule class
	instanceVariableNames: ''!

!Combo2RewardRule class methodsFor: 'testing' stamp: 'HAW 9/22/2019 19:53:22'!
isFor: volumeSoldToCustomer 

	^volumeSoldToCustomer between: 300*milliliter and: 500*milliliter
	! !

CoffeeShopSalesSystem initialize!