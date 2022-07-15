!classDefinition: #ImportTest category: 'CustomerImporter-Recu-2doParcial'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:28:34'!
test10ImportsSaleWithExistingCustomer

	| importedSale productStream |
	
	CustomerImporter valueFrom: self validImportData into: system.
	
	SaleImporter valueFrom: self saleWithExistingCustomer into: system.
	
	self deny: system salesIsEmpty.
	self assert: 1 equals: system numberOfSales.
	importedSale := system saleForInvoiceNumber: '0001-00000022' ifNone: [ self fail ].
	self assert: '2022/08/10' equals: importedSale date.
	self assert: '0001-00000022' equals: importedSale invoiceNumber.
	self assert: 1000 equals: importedSale total.
	
	self assert: (system customerWithIdentificationType: 'D' number: '22333444') equals: importedSale buyer.
	
	productStream := importedSale productStream.
	self assertProduct: productStream next isDescribedAt: '1 kilo de huevos' total: 700.
	self assertProduct: productStream next isDescribedAt: '1 kilo de manzanas' total: 300.
	self assert: productStream atEnd.
	! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:28:42'!
test11ImportsSaleWithNewCustomer

	| importedSale productStream |
	
	SaleImporter valueFrom: self saleWithNewCustomer into: system.
	
	self assert: 1 equals: system numberOfSales.
	importedSale := system saleForInvoiceNumber: '0001-00000022' ifNone: [ self fail ].
	self assert: '2022/08/10' equals: importedSale date.
	self assert: '0001-00000022' equals: importedSale invoiceNumber.
	self assert: 700 equals: importedSale total.
	
	self assert: (system customerWithIdentificationType: 'D' number: '22333444') equals: importedSale buyer.
	
	productStream := importedSale productStream.
	self assertProduct: productStream next isDescribedAt: '1 kilo de huevos' total: 700.
	self assert: productStream atEnd.
	! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:28:57'!
test12CannotImportExistingCustomerWithoutSale

	self 
		shouldFailImportingSaleFrom: self existingCustomerWithoutSale
		messageText: SaleImporter saleRecordShouldCameFirstErrorDescription
		asserting: [ system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:29:10'!
test13CannotImportNewCustomerWithoutSale

	self 
		shouldFailImportingSaleFrom: self newCustomerWithoutSale
		messageText: SaleImporter saleRecordShouldCameFirstErrorDescription
		asserting: [ system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:29:20'!
test14CannotImportProductWithoutSale

	self 
		shouldFailImportingSaleFrom: self productWithoutSale
		messageText: SaleImporter saleRecordShouldCameFirstErrorDescription
		asserting: [ system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:29:29'!
test15CannotImportEndOfSaleWithoutSale

	self 
		shouldFailImportingSaleFrom: self endOfSaleWithoutSale
		messageText: SaleImporter saleRecordShouldCameFirstErrorDescription
		asserting: [ system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:30:34'!
test16FailsWhenInvalidRecordSequenceAfterImportingSale

	self 
		shouldFailImportingSaleFrom: self saleWithNewCustomerAndInvalidRecordSequence
		messageText: SaleImporter saleRecordShouldCameFirstErrorDescription
		asserting: [ self assert: 1 equals: system numberOfSales ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:30:14'!
test17CannotImportSaleWihtoutBuyerAfertImportingValidSale

	self 
		shouldFailImportingSaleFrom: self saleWithBuyerAndNewSaleWithoutBuyer 
		messageText: SaleImporter saleMustHaveBuyerErrorDescripton
		asserting: [ self assert: 1 equals: system numberOfSales ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:30:27'!
test18CannotImportSaleWithoutProducts

	self 
		shouldFailImportingSaleFrom: self saleWithoutProducts 
		messageText: Sale mustHaveProductsErrorDecription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:30:51'!
test19CannotImportSaleWithMorethanOneExistingBuyer

	CustomerImporter valueFrom: self validImportData into: system.
	
	self 
		shouldFailImportingSaleFrom: self saleWithMoreThanOneExistingBuyer
		messageText: SaleImporter saleMustHaveOneBuyerErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:31:04'!
test20CannotImportSaleWithMoreThanOneNewBuyer

	CustomerImporter valueFrom: self validImportData into: system.
	
	self 
		shouldFailImportingSaleFrom: self saleWithMoreThanOneNewBuyer
		messageText: SaleImporter saleMustHaveOneBuyerErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:31:26'!
test21CannotImportSaleWithLessThanFourFields

	self 
		shouldFailImportingSaleFrom: self saleWithLessThanFourFields
		messageText: SaleImporter invalidSaleRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:31:36'!
test22CannotImportSaleWithMoreThanFourdFields

	self 
		shouldFailImportingSaleFrom: self saleWithMoreThanFourFields
		messageText: SaleImporter invalidSaleRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:32:10'!
test23CannotImportSaleExistingBuyerWithLessThanThreeFields

	self 
		shouldFailImportingSaleFrom: self existingBuyerWithLessThanThreeFields
		messageText: SaleImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:32:06'!
test24CannotImportSaleExistingBuyerWithMoreThanThreeFields

	self 
		shouldFailImportingSaleFrom: self existingBuyerWithMoreThanThreeFields
		messageText: SaleImporter invalidExistingCustomerRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:32:43'!
test25CannotImportSaleImportSoldProductWithLessThanThreeFields

	self 
		shouldFailImportingSaleFrom: self soldProductWithLessThanThreeFields
		messageText: SaleImporter invalidSoldProductRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:33:17'!
test26CannotImportSaleWithSoldProductWithMoreThanThreeFields

	self 
		shouldFailImportingSaleFrom: self soldProductWithMoreThanThreeFields
		messageText: SaleImporter invalidSoldProductRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:33:37'!
test27CannotImportSaleWithEndOfSaleWithMoreThanOneField

	self 
		shouldFailImportingSaleFrom: self endOfSaleWithMoreThanOneField
		messageText: SaleImporter invalidEndOfSaleRecordErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:33:49'!
test28CannotImportSaleWithInvalidExistingCustomer

	self 
		shouldFailImportingSaleFrom: self invalidExisitingCustomer
		messageText: ERPSystem customerNotFoundErrorDescription
		asserting: [ self assert: system salesIsEmpty ]! !

!ImportTest methodsFor: 'tests - sale importer' stamp: 'HAW 7/15/2022 18:34:02'!
test29RecongnizesInvalidRecordType

	self 
		shouldFailImportingSaleFrom: self invalidRecordType
		messageText: SaleImporter invalidRecordTypeErrorDescription 
		asserting: [ self assert: system salesIsEmpty ]! !


!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImportingCustomerFrom: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImportingCustomerFrom: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImportingCustomerFrom: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImportingCustomerFrom: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImportingCustomerFrom: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImportingCustomerFrom: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests - customer importer' stamp: 'HAW 7/15/2022 17:32:22'!
test09CannotImportEmptyLine

	self
		shouldFailImportingCustomerFrom: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:22:05'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:30'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer |

	importedCustomer := system customerWithIdentificationType: anIdType number: anIdNumber.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: anIdType equals: importedCustomer identificationType.
	self assert: anIdNumber equals: importedCustomer identificationNumber.

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:34:37'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerWithIdentificationType: 'D' number: '22333444'.
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:45'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 18:28:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 1636 province: 'BsAs'.
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.


	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:18:16'!
assertProduct: aProduct isDescribedAt: aDescription total: aTotal
	
	self assert: aDescription equals: aProduct description.
	self assert: aTotal equals: aProduct total! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:33:32'!
shouldFailImporting: aReadStream 
	messageText: anErrorMessageText 
	asserting: anAssertionBlock 
	with: anImporterClass 
	
	self
		should: [ anImporterClass valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:33:09'!
shouldFailImportingCustomerFrom: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self 
		shouldFailImporting: aReadStream 
		messageText: anErrorMessageText 
		asserting: anAssertionBlock 
		with: CustomerImporter ! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:34:11'!
shouldFailImportingSaleFrom: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self 
		shouldFailImporting: aReadStream 
		messageText: anErrorMessageText 
		asserting: anAssertionBlock 
		with: SaleImporter ! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 7/15/2022 18:23:17'!
setUp

	system := Environment current createERPSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data - customer importer' stamp: 'HAW 5/22/2022 18:08:08'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:05:31'!
endOfSaleWithMoreThanOneField
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
NC,Juan,Perez,D,22333444
P,1 kilo de huevos,700
ES,x'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:38:15'!
endOfSaleWithoutSale
	
	^ReadStream on: 'ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:59:24'!
existingBuyerWithLessThanThreeFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
EC,D'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:59:54'!
existingBuyerWithMoreThanThreeFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
EC,D,22,x'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:29:22'!
existingCustomerWithoutSale
	
	^ReadStream on: 
'EC,D,22333444
P,1 kilo de huevos,700
P,1 kilo de manzanas,300
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:07:24'!
invalidExisitingCustomer
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
EC,D,22333444
P,1 kilo de huevos,700
P,1 kilo de manzanas,300
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:15:18'!
invalidRecordType
	
	^ReadStream on: 'X,1'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:36:34'!
newCustomerWithoutSale
	^ReadStream on: 
'NC,Juan,Perez,D,22333444'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:37:34'!
productWithoutSale
	
	^ReadStream on: 
'P,1 kilo de huevos,700'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:47:25'!
saleWithBuyerAndNewSaleWithoutBuyer

	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
NC,Juan,Perez,D,22333444
P,1 kilo de huevos,700
ES
S,2022/08/10,0001-00000023,700
P,1 kilo de huevos,700
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:15:22'!
saleWithExistingCustomer

	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
EC,D,22333444
P,1 kilo de huevos,700
P,1 kilo de manzanas,300
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:55:50'!
saleWithLessThanFourFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:23:57'!
saleWithMoreThanFourFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,100,x'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:50:25'!
saleWithMoreThanOneExistingBuyer
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
EC,D,22333444
EC,D,22333445
P,1 kilo de huevos,700
P,1 kilo de manzanas,300
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:53:33'!
saleWithMoreThanOneNewBuyer
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,1000 
NC,A,B,D,22333444
NC,A,B,D,22333445
P,1 kilo de huevos,700
P,1 kilo de manzanas,300
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:20:44'!
saleWithNewCustomer

	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
NC,Juan,Perez,D,22333444
P,1 kilo de huevos,700
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:39:10'!
saleWithNewCustomerAndInvalidRecordSequence

	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
NC,Juan,Perez,D,22333444
P,1 kilo de huevos,700
ES
P,1 kilo de huevos,700'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:40:40'!
saleWithoutBuyer

	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
P,1 kilo de huevos,700
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 17:44:36'!
saleWithoutProducts

	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
NC,Juan,Perez,D,22333444
ES'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:32:35'!
soldProductWithLessThanThreeFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
P,1 kilo de huevos'! !

!ImportTest methodsFor: 'test data - sale importer' stamp: 'HAW 7/15/2022 18:33:17'!
soldProductWithMoreThanThreeFields
	
	^ReadStream on: 
'S,2022/08/10,0001-00000022,700 
P,1 kilo de huevos,233,x'! !


!classDefinition: #Address category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 17:55:46'!
isAt: aStreetName

	^streetName = aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #CSVImporter category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #CSVImporter
	instanceVariableNames: 'line readStream record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!CSVImporter methodsFor: 'initialization' stamp: 'HAW 7/15/2022 16:52:56'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!CSVImporter methodsFor: 'evaluating' stamp: 'HAW 7/15/2022 16:53:02'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 16:54:16'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 16:54:20'!
createRecord

	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 16:54:23'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 16:54:29'!
importRecord

	self assertRecordNotEmpty.

	self importRecordWhenNotEmpty ! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 16:54:46'!
importRecordWhenNotEmpty 

	self subclassResponsibility ! !

!CSVImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 18:16:01'!
signalInvalidRecordType

	^ self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter-Recu-2doParcial'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'importing' stamp: 'HAW 7/15/2022 16:52:33'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CSVImporter class methodsFor: 'instance creation' stamp: 'HAW 7/15/2022 16:52:40'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CSVImporter class methodsFor: 'error messages' stamp: 'HAW 7/15/2022 16:54:11'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter-Recu-2doParcial'!
CSVImporter subclass: #CustomerImporter
	instanceVariableNames: 'newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 7/15/2022 17:25:56'!
importCustomer

	newCustomer := (RecordToCustomerMapper from: record) value.
	system add: newCustomer! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:23:55'!
isCustomerRecord

	^ record first = 'C'! !


!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:58:41'!
assertCustomerWasImported

	^ newCustomer ifNil: [ self error: self class canNotImportAddressWithoutCustomerErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
assertValidAddressRecord

	^ record size ~= 6 ifTrue: [ self error: self class invalidAddressRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:59:12'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newCustomer addAddress: newAddress.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: record fifth asNumber .
	newAddress province: record sixth! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 18:15:57'!
importRecordWhenNotEmpty

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self signalInvalidRecordType! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter-Recu-2doParcial'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 7/15/2022 18:02:05'!
invalidCustomerRecordErrorDescription

	^RecordToCustomerMapper invalidCustomerRecordErrorDescription ! !


!classDefinition: #SaleImporter category: 'CustomerImporter-Recu-2doParcial'!
CSVImporter subclass: #SaleImporter
	instanceVariableNames: 'saleRecord buyer products'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!SaleImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 17:42:40'!
assertHasBuyer
	
	buyer isNil ifTrue: [ self error: self class saleMustHaveBuyerErrorDescripton ]! !

!SaleImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 17:51:29'!
assertHasNoBuyer
	
	buyer notNil ifTrue: [ self error: self class saleMustHaveOneBuyerErrorDescription ]! !

!SaleImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 17:35:31'!
assertHasReadSaleRecord
	
	saleRecord isNil ifTrue: [ self error: self class saleRecordShouldCameFirstErrorDescription ]! !

!SaleImporter methodsFor: 'evaluating - private' stamp: 'HAW 7/15/2022 18:16:12'!
importRecordWhenNotEmpty
	
	self isSaleRecord ifTrue: [ ^self importSaleRecord. ].
	self isExistingCustomerRecord ifTrue: [ ^self importExistingCustomerRecord ].
	self isNewCustomerRecord ifTrue: [ ^self importNewCustomerRecord ].
	self isSoldProductRecord ifTrue: [ ^self importSoldProductRecord ].
	self isEndOfSaleRecord ifTrue: [ ^self importEndOfSaleRecord ].
	
	self signalInvalidRecordType ! !


!SaleImporter methodsFor: 'end of sale - private' stamp: 'HAW 7/15/2022 18:16:59'!
assertIsValidEndOfSaleRecord

	^ record size > 1 ifTrue: [ self error: self class invalidEndOfSaleRecordErrorDescription ]! !

!SaleImporter methodsFor: 'end of sale - private' stamp: 'HAW 7/15/2022 18:17:39'!
importEndOfSaleRecord

	self assertHasReadSaleRecord.
	self assertHasBuyer.
	self assertIsValidEndOfSaleRecord.
	
	system addSale: self createSale.
	
	self prepareForNewSale! !

!SaleImporter methodsFor: 'end of sale - private' stamp: 'HAW 7/15/2022 18:14:00'!
isEndOfSaleRecord

	^ record first = 'ES'! !

!SaleImporter methodsFor: 'end of sale - private' stamp: 'HAW 7/15/2022 18:17:25'!
prepareForNewSale

	saleRecord := nil.
	buyer := nil! !


!SaleImporter methodsFor: 'existing customer - private' stamp: 'HAW 7/15/2022 18:18:00'!
assertIsValidExistingCustomerRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidExistingCustomerRecordErrorDescription ]! !

!SaleImporter methodsFor: 'existing customer - private' stamp: 'HAW 7/15/2022 18:18:03'!
importExistingCustomerRecord

	self assertHasReadSaleRecord.
	self assertHasNoBuyer.
	self assertIsValidExistingCustomerRecord.
	
	buyer := system customerWithIdentificationType: record second number: record third! !

!SaleImporter methodsFor: 'existing customer - private' stamp: 'HAW 7/15/2022 18:12:43'!
isExistingCustomerRecord

	^ record first = 'EC'! !


!SaleImporter methodsFor: 'sale - private' stamp: 'HAW 7/15/2022 18:18:32'!
assertIsValidSaleRecord

	^ record size ~= 4 ifTrue: [ self error: self class invalidSaleRecordErrorDescription ]! !

!SaleImporter methodsFor: 'sale - private' stamp: 'HAW 7/15/2022 18:17:37'!
createSale

	^ Sale doneOn: saleRecord second numbered: saleRecord third total: saleRecord fourth asNumber buyer: buyer products: products! !

!SaleImporter methodsFor: 'sale - private' stamp: 'HAW 7/15/2022 18:18:34'!
importSaleRecord

	self assertIsValidSaleRecord.
	
	saleRecord := record.
	products := OrderedCollection new! !

!SaleImporter methodsFor: 'sale - private' stamp: 'HAW 7/15/2022 18:12:21'!
isSaleRecord

	^ record first = 'S'! !


!SaleImporter methodsFor: 'sold product - private' stamp: 'HAW 7/15/2022 18:32:43'!
assertIsValidSoldProductRecord

	^ record size ~= 3 ifTrue: [ self error: self class invalidSoldProductRecordErrorDescription ]! !

!SaleImporter methodsFor: 'sold product - private' stamp: 'HAW 7/15/2022 18:18:56'!
importSoldProductRecord

	self assertHasReadSaleRecord.
	self assertIsValidSoldProductRecord.
	
	products add: (SoldProduct describedAs: record second total: record third asNumber)! !

!SaleImporter methodsFor: 'sold product - private' stamp: 'HAW 7/15/2022 18:13:30'!
isSoldProductRecord

	^ record first = 'P'! !


!SaleImporter methodsFor: 'new customer - private' stamp: 'HAW 7/15/2022 18:18:15'!
importNewCustomerRecord

	self assertHasReadSaleRecord.
	self assertHasNoBuyer.
	
	buyer := (RecordToCustomerMapper from: record) value.
	system add: buyer! !

!SaleImporter methodsFor: 'new customer - private' stamp: 'HAW 7/15/2022 18:13:02'!
isNewCustomerRecord

	^ record first = 'NC'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SaleImporter class' category: 'CustomerImporter-Recu-2doParcial'!
SaleImporter class
	instanceVariableNames: ''!

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 18:07:35'!
customerNotFoundErrorDescription
	
	^'Customer not found'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 18:05:43'!
invalidEndOfSaleRecordErrorDescription
	
	^'Invalid end of sale record'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 17:58:52'!
invalidExistingCustomerRecordErrorDescription
	
	^'Invalid existing customer record'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 17:56:02'!
invalidSaleRecordErrorDescription
	
	^'Invalid sale record'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 18:32:49'!
invalidSoldProductRecordErrorDescription
	
	^'Invalid sold product record'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 17:41:51'!
saleMustHaveBuyerErrorDescripton
	
	^'Sale must have buyer'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 17:50:00'!
saleMustHaveOneBuyerErrorDescription
	
	^'Sale must have one buyer only'! !

!SaleImporter class methodsFor: 'error description' stamp: 'HAW 7/15/2022 17:29:40'!
saleRecordShouldCameFirstErrorDescription
	
	^'Sale record should came first'! !


!classDefinition: #Customer category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 17:55:17'!
addressAt: aStreetName ifNone: aNoneBlock

	^addresses detect: [ :address | address isAt: aStreetName ] ifNone: aNoneBlock ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 19:38:32'!
isAddressesEmpty

	^addresses isEmpty ! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 00:19:29'!
beginTransaction

	! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter-Recu-2doParcial'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #ERPSystem category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #ERPSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!ERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'customers' stamp: 'HAW 7/15/2022 18:27:28'!
customerWithIdentificationType: anIdType number: anIdNumber

	^self customerWithIdentificationType: anIdType number: anIdNumber ifNone: [ self error: self class customerNotFoundErrorDescription ].
! !

!ERPSystem methodsFor: 'customers' stamp: 'HAW 7/15/2022 18:25:42'!
customerWithIdentificationType: anIdType number: anIdNumber ifNone: aNoneBlock

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!ERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!ERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!ERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ERPSystem class' category: 'CustomerImporter-Recu-2doParcial'!
ERPSystem class
	instanceVariableNames: ''!

!ERPSystem class methodsFor: 'as yet unclassified' stamp: 'HAW 7/15/2022 18:10:19'!
customerNotFoundErrorDescription
	
	^'Customer not found'! !


!classDefinition: #PersistentERPSystem category: 'CustomerImporter-Recu-2doParcial'!
ERPSystem subclass: #PersistentERPSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!PersistentERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:14:14'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentERPSystem methodsFor: 'customers' stamp: 'HAW 7/15/2022 18:27:14'!
customerWithIdentificationType: anIdType number: anIdNumber ifNone: aNoneBlock

	| foundCustomers |
	
	foundCustomers := session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer.
	
	^foundCustomers isEmpty 
		ifTrue: aNoneBlock 
		ifFalse: [ foundCustomers anyOne ]! !

!PersistentERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:12:29'!
start

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !

!PersistentERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientERPSystem category: 'CustomerImporter-Recu-2doParcial'!
ERPSystem subclass: #TransientERPSystem
	instanceVariableNames: 'customers sales'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 7/15/2022 17:14:44'!
start

	customers := OrderedCollection new.
	sales := OrderedCollection new.! !

!TransientERPSystem methodsFor: 'system lifecycle' stamp: 'HAW 7/15/2022 17:14:49'!
stop

	customers := nil.
	sales := nil! !


!TransientERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientERPSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientERPSystem methodsFor: 'customers' stamp: 'HAW 7/15/2022 18:09:02'!
customerWithIdentificationType: anIdType number: anIdNumber ifNone: aNoneBlock

	^customers 
		detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ifNone: aNoneBlock ! !

!TransientERPSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!TransientERPSystem methodsFor: 'sales' stamp: 'HAW 7/15/2022 17:14:34'!
addSale: aSale 
	
	sales add: aSale.! !

!TransientERPSystem methodsFor: 'sales' stamp: 'HAW 7/15/2022 17:15:35'!
numberOfSales
	
	^sales size! !

!TransientERPSystem methodsFor: 'sales' stamp: 'HAW 7/15/2022 17:16:21'!
saleForInvoiceNumber: anInvoiceNumber ifNone: aNoneClosure

	^sales detect: [ :aSale | aSale hasInvoiceNumber: anInvoiceNumber ] ifNone: aNoneClosure ! !

!TransientERPSystem methodsFor: 'sales' stamp: 'HAW 7/15/2022 18:22:59'!
salesIsEmpty
	
	^sales isEmpty ! !


!classDefinition: #Environment category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!Environment methodsFor: 'customer system' stamp: 'HAW 7/15/2022 18:23:17'!
createERPSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter-Recu-2doParcial'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter-Recu-2doParcial'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'HAW 7/15/2022 18:23:17'!
createERPSystem

	^TransientERPSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter-Recu-2doParcial'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 7/15/2022 18:28:03'!
isCurrent

	^true! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter-Recu-2doParcial'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'HAW 7/15/2022 18:23:17'!
createERPSystem

	^PersistentERPSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter-Recu-2doParcial'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:40:36'!
isCurrent

	^DevelopmentEnvironment isCurrent not! !


!classDefinition: #RecordToCustomerMapper category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #RecordToCustomerMapper
	instanceVariableNames: 'record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!RecordToCustomerMapper methodsFor: 'initialization' stamp: 'HAW 7/15/2022 17:25:32'!
initializeFrom: aRecord
	record := aRecord.! !


!RecordToCustomerMapper methodsFor: 'evaluating' stamp: 'HAW 7/15/2022 18:02:18'!
assertIsValidRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!RecordToCustomerMapper methodsFor: 'evaluating' stamp: 'HAW 7/15/2022 18:02:18'!
value

	| customer |
	
	self assertIsValidRecord.

	customer := Customer new.
	customer firstName: record second.
	customer lastName: record third.
	customer identificationType: record fourth.
	customer identificationNumber: record fifth.
	
	^customer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RecordToCustomerMapper class' category: 'CustomerImporter-Recu-2doParcial'!
RecordToCustomerMapper class
	instanceVariableNames: ''!

!RecordToCustomerMapper class methodsFor: 'instance creation' stamp: 'HAW 7/15/2022 17:25:32'!
from: aRecord
	^self new initializeFrom: aRecord! !


!RecordToCustomerMapper class methodsFor: 'error descriptions' stamp: 'HAW 7/15/2022 18:01:50'!
invalidCustomerRecordErrorDescription
	
	^'Invalid Customer record'! !


!classDefinition: #Sale category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #Sale
	instanceVariableNames: 'issuedDate invoiceNumber total buyer soldProducts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!Sale methodsFor: 'initialization' stamp: 'HAW 7/15/2022 17:14:20'!
initializeDoneOn: anIssuedDate numbered: anInvoiceNumber total: aTotal buyer: aBuyer products: aSoldProducts 
	
	issuedDate := anIssuedDate.
	invoiceNumber := anInvoiceNumber.
	total := aTotal.
	buyer := aBuyer.
	soldProducts := aSoldProducts.! !


!Sale methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:17:14'!
buyer
	
	^buyer! !

!Sale methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:16:52'!
date
	
	^issuedDate ! !

!Sale methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:16:59'!
invoiceNumber
	
	^invoiceNumber! !

!Sale methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:17:27'!
productStream
	
	^ReadStream on: soldProducts ! !

!Sale methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:17:05'!
total
	
	^total! !


!Sale methodsFor: 'testing' stamp: 'HAW 7/15/2022 17:16:35'!
hasInvoiceNumber: anInvoiceNumber

	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'CustomerImporter-Recu-2doParcial'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HAW 7/15/2022 17:45:54'!
doneOn: anIssuedDate numbered: anInvoiceNumber total: aTotal buyer: aBuyer products: aSoldProducts 
	
	self assertHasSoldProducts: aSoldProducts.
	
	^self new initializeDoneOn: anIssuedDate numbered: anInvoiceNumber total: aTotal buyer: aBuyer products: aSoldProducts ! !


!Sale class methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:46:20'!
assertHasSoldProducts: soldProducts

	soldProducts isEmpty ifTrue: [ self error: self mustHaveProductsErrorDecription ].! !

!Sale class methodsFor: 'assertions' stamp: 'HAW 7/15/2022 17:45:32'!
mustHaveProductsErrorDecription
	
	^'Sale must have products'! !


!classDefinition: #SoldProduct category: 'CustomerImporter-Recu-2doParcial'!
Object subclass: #SoldProduct
	instanceVariableNames: 'description total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-2doParcial'!

!SoldProduct methodsFor: 'initialization' stamp: 'HAW 7/15/2022 17:10:11'!
initializeDescribedAs: aDescription total: aTotal 
	
	description := aDescription.
	total := aTotal.! !


!SoldProduct methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:18:22'!
description
	
	
	^description! !

!SoldProduct methodsFor: 'accesing' stamp: 'HAW 7/15/2022 17:18:59'!
total
	
	^total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SoldProduct class' category: 'CustomerImporter-Recu-2doParcial'!
SoldProduct class
	instanceVariableNames: ''!

!SoldProduct class methodsFor: 'instance creation' stamp: 'HAW 7/15/2022 17:10:06'!
describedAs: aDescription total: aTotal 
	
	^self new initializeDescribedAs: aDescription total: aTotal ! !
