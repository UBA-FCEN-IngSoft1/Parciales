!classDefinition: #ImportTest category: 'CustomerImporter-Recu-1er-Parcial'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 10:00:20'!
cuitWithInvalidHeader
	^ ReadStream on:
'C,Pepe,Sanchez,C,19-25666777-9'! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test01ValidDataIsImportedCorrectly

	CustomerImporter valueFrom: self validImportData into: system..

	self assertImportedRightNumberOfCustomers.
	self assertPepeSanchezWasImportedCorrecty.
	self assertJuanPerezWasImportedCorrectly ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 21:15:52'!
test02CanNotImportAddressWithoutCustomer

	self
		should: [ CustomerImporter valueFrom: self addressWithoutCustomerData into: system. ]
		raise: Error - MessageNotUnderstood
		withMessageText: CustomerImporter canNotImportAddressWithoutCustomerErrorDescription

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test03DoesNotImportRecordsStartingWithCButMoreCharacters

	self
		shouldFailImporting: self invalidCustomerRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:03'!
test04DoesNotImportRecordsStartingWithAButMoreCharacters

	self
		shouldFailImporting: self invalidAddressRecordStartData
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:49:36'!
test05CanNotImportAddressRecordWithLessThanSixFields

	self
		shouldFailImporting: self addressRecordWithLessThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:51:14'!
test06CanNotImportAddressRecordWithMoreThanSixFields

	self
		shouldFailImporting: self addressRecordWithMoreThanSixFields
		messageText: CustomerImporter invalidAddressRecordErrorDescription
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test07CanNotImportCustomerRecordWithLessThanFiveFields

	self
		shouldFailImporting: self customerRecordWithLessThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 19:56:58'!
test08CanNotImportCustomerRecordWithMoreThanFiveFields

	self
		shouldFailImporting: self customerRecordWithMoreThanFiveFields
		messageText: CustomerImporter invalidCustomerRecordErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 5/22/2022 20:01:43'!
test09CannotImportEmptyLine

	self
		shouldFailImporting: self emptyLine
		messageText: CustomerImporter invalidRecordTypeErrorDescription
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:47:11'!
test10DNICannotBeLessThanOne

	self
		shouldFailImporting: self lessThanOneDNI
		messageText: 'Invalid DNI number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:49:46'!
test11DNICannotBeBiggerThan99999999

	self
		shouldFailImporting: self biggerThanValidDNINumber
		messageText: 'Invalid DNI number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:53:14'!
test12DNIMustBeAllDigits

	self
		shouldFailImporting: self dniWithoutDigit
		messageText: 'Invalid DNI number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:56:36'!
test13CuitSizeCannotBeLessThan12

	self
		shouldFailImporting: self lessThan12CuitSize
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:56:12'!
test14CuitSizeCannotBeBiggerThan13

	self
		shouldFailImporting: self biggerThan13CuitSize
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:57:23'!
test15CuitMustHaveDashAtThridPosition

	self
		shouldFailImporting: self cuitWithoutDashInThirdPosition
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 09:58:59'!
test16CuitMustHaveDashAtPenultimatePosition

	self
		shouldFailImporting: self cuitWithoutDashAnPenultimatePosition
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 10:00:09'!
test17CuitMustHaveValidHeader

	self
		shouldFailImporting: self cuitWithInvalidHeader
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 10:00:39'!
test18CuitMustHaveDigitAtEnd

	self
		shouldFailImporting: self cuitWithoutDigitAtEnd
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 10:02:02'!
test19CuitMustHaveAllDigits

	self
		shouldFailImporting: self cuitWithoutAllDigits
		messageText: 'Invalid CUIT number' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:09:46'!
test20OldZipCodeMustBeAllDigits

	self
		shouldFailImporting: self oldZipCodeWithLetters
		messageText: 'Invalid old zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:12:31'!
test21OldZipMustBeBiggerThan999

	self
		shouldFailImporting: self oldZipSmallerThan1000
		messageText: 'Invalid old zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:14:47'!
test22OldZipMustBeLessThan10000

	self
		shouldFailImporting: self oldZipBiggerThan9999
		messageText: 'Invalid old zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:18:36'!
test23NewZipCodeSizeCannotBeLessThan8

	self
		shouldFailImporting: self newZipCodeWithSizeLessThan8
		messageText: 'Invalid new zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:17:56'!
test24NewZipCodeSizeCannotBeBiggerThan8

	self
		shouldFailImporting: self newZipCodeWithSizeBiggerThan8
		messageText: 'Invalid new zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:19:36'!
test25NewZipCode4DigitsAfterFirstLetter

	self
		shouldFailImporting: self newZipCodeWithoutFourDigits
		messageText: 'Invalid new zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:21:38'!
test26NewZipCode4DigitsMustBeBiggerThan999

	self
		shouldFailImporting: self newZipCodeFourDigitsLessThan1000
		messageText: 'Invalid new zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:23:36'!
test27NewZipCodeMustEndWith3Letters

	self
		shouldFailImporting: self newZipCodeWithoutEnding3Letters
		messageText: 'Invalid new zipcode' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:28:33'!
test28IdTypeMustBeDNIOrCuit

	self
		shouldFailImporting: self invalidIdType
		messageText: 'Invalid identification type' 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 12:30:23'!
test29ZipCodeMustBeOldOrNew

	self
		shouldFailImporting: self invalidIdZipCode
		messageText: 'Invalid identification type' 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 10:24:17'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCode.
	self assert: aProvince equals: importedAddress province.
	
	^importedAddress 

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

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 10:26:42'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer address |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	
	self deny: importedCustomer hasDNIAsIdentification.
	self assert: 'No dni' equals: (importedCustomer dniNumberIfNone: [ 'No dni' ]).
	self assert: importedCustomer hasCUITAsIdentification.
	self assert: '23-25666777-9' equals: (importedCustomer cuitNumberIfNone: [self fail ]).
	
	address := self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.
	
	self assert: address hasOldZipCode.
	self assert: 1001 equals: (address oldZipCodeIfNone: [ self fail ]).
	self deny: address hasNewZipCode.
	self assert: 'has old zipcode' equals: (address newZipCodeIfNone: [ 'has old zipcode' ]).
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 12:06:54'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer address |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	
	self assert: importedCustomer hasDNIAsIdentification.
	self assert: 22333444 equals: (importedCustomer dniNumberIfNone: [ self fail ]).
	self deny: importedCustomer hasCUITAsIdentification.
	self assert: 'No cuit' equals: (importedCustomer cuitNumberIfNone: [ 'No cuit' ]).
	
	address := self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 'B1636BBE' province: 'BsAs'.
	self deny: address hasOldZipCode.
	self assert: 'has new zipcode' equals: (address oldZipCodeIfNone: [ 'has new zipcode' ]).
	self assert: address hasNewZipCode.
	self assert: 'B1636BBE' equals: (address newZipCodeIfNone: [ self fail ]).
		
	self assertAddressOf: importedCustomer at: 'Maipu' hasNumber: 888 town: 'Florida' zipCode: 1122 province: 'Buenos Aires'.
! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:15:52'!
shouldFailImporting: aReadStream messageText: anErrorMessageText asserting: anAssertionBlock

	self
		should: [ CustomerImporter valueFrom: aReadStream into: system. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anErrorMessageText equals: anError messageText.
			anAssertionBlock value ]

	! !


!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 21:36:16'!
setUp

	system := Environment current createCustomerSystem.
	system start.
	system beginTransaction.
! !

!ImportTest methodsFor: 'setUp/tearDown' stamp: 'HAW 5/22/2022 20:12:16'!
tearDown

	system commit.
	system stop
	! !


!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:41:20'!
addressRecordWithLessThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:51:35'!
addressRecordWithMoreThanSixFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:14:13'!
addressWithoutCustomerData

	^ReadStream on: 'A,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:56:45'!
biggerThan13CuitSize

	^ ReadStream on:
'C,Pepe,Sanchez,C,23-25666777-99'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:52:47'!
biggerThanValidDNINumber

	^ ReadStream on:
'C,Pepe,Sanchez,D,1000000000'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 10:08:54'!
cuitWithoutAllDigits

	^ ReadStream on:
'C,Pepe,Sanchez,C,23-a5666777-9'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:59:13'!
cuitWithoutDashAnPenultimatePosition

	^ ReadStream on:
'C,Pepe,Sanchez,C,23-2566677799'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:57:38'!
cuitWithoutDashInThirdPosition

	^ ReadStream on:
'C,Pepe,Sanchez,C,2325666777-99'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 10:00:49'!
cuitWithoutDigitAtEnd

	^ ReadStream on:
'C,Pepe,Sanchez,C,23-25666777-a'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:53:41'!
customerRecordWithLessThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:55:59'!
customerRecordWithMoreThanFiveFields

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444,x'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:53:53'!
dniWithoutDigit

	^ ReadStream on:
'C,Pepe,Sanchez,D,2233344a'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 20:02:57'!
emptyLine

	^ReadStream on: '
'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:34:25'!
invalidAddressRecordStartData

	^ReadStream on: 'C,Pepe,Sanchez,D,22333444
AA,San Martin,3322,Olivos,1636,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 5/22/2022 19:22:55'!
invalidCustomerRecordStartData

	^ReadStream on: 'CC,Pepe,Sanchez,D,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:28:09'!
invalidIdType
	^ ReadStream on:
'C,Pepe,Sanchez,A,22333444'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:29:25'!
invalidIdZipCode
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,+1636BBE,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:56:36'!
lessThan12CuitSize
	
	^ ReadStream on:
'C,Pepe,Sanchez,C,23-25666777-'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 09:49:05'!
lessThanOneDNI
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,0'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:22:04'!
newZipCodeFourDigitsLessThan1000
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B0999BBE,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:18:08'!
newZipCodeWithSizeBiggerThan8

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B1636BBEE,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:17:04'!
newZipCodeWithSizeLessThan8
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B1636BB,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:26:12'!
newZipCodeWithoutEnding3Letters
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B1636B2E,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:19:51'!
newZipCodeWithoutFourDigits
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B1a36BBE,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:15:13'!
oldZipBiggerThan9999
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,10000,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:08:43'!
oldZipCodeWithLetters
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1a00,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:12:56'!
oldZipSmallerThan1000
	
	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,999,BsAs'! !

!ImportTest methodsFor: 'test data' stamp: 'HAW 7/13/2022 12:02:30'!
validImportData

	^ ReadStream on:
'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,B1636BBE,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !


!classDefinition: #Address category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

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


!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 12:01:51'!
hasNewZipCode
	
	^zipCode isKindOf: String! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 12:01:13'!
hasOldZipCode
	
	^zipCode isKindOf: Integer! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 12:02:13'!
newZipCodeIfNone: aNoneBlock

	^self hasNewZipCode 
		ifTrue: [ zipCode ]
		ifFalse: aNoneBlock 
	! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 12:01:38'!
oldZipCodeIfNone: aNoneBlock

	^self hasOldZipCode 
		ifTrue: [ zipCode ]
		ifFalse: aNoneBlock ! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

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


!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 10:22:22'!
cuitNumberIfNone: aNoneClosure

	^self hasCUITAsIdentification 
		ifTrue: [ identificationNumber ]
		ifFalse: aNoneClosure! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 10:21:37'!
dniNumberIfNone: aNoneBlock

	^self hasDNIAsIdentification 
		ifTrue: [ Integer readFrom: identificationNumber readStream ]
		ifFalse: aNoneBlock ! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 10:21:50'!
hasCUITAsIdentification
	
	^identificationType = 'C'! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 10:21:13'!
hasDNIAsIdentification
	
	^identificationType = 'D'! !

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


!classDefinition: #CustomerImporter category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'readStream newCustomer line record system'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!CustomerImporter methodsFor: 'initialization' stamp: 'HAW 5/22/2022 21:15:17'!
initializeFrom: aReadStream into: aCustomerSystem

	readStream := aReadStream.
	system := aCustomerSystem ! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'HAW 5/22/2022 18:48:58'!
value

	[ self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord ].

	! !


!CustomerImporter methodsFor: 'customer' stamp: 'HAW 5/22/2022 19:59:39'!
assertValidCustomerRecord

	^ record size ~= 5 ifTrue: [ self error: self class invalidCustomerRecordErrorDescription ]! !

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 7/13/2022 12:28:16'!
importCustomer

	| idType idNumber |
	
	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	idType := record fourth.
	idNumber := record fifth.

	idType = 'D' 
		ifTrue: [ | dniNumber | 
			(idNumber allSatisfy: [ :idChar | idChar isDigit ]) ifFalse: [ self error: 'Invalid DNI number' ].
			dniNumber := Integer readFrom: idNumber readStream.
			(dniNumber between: 1 and: 99999999) ifFalse: [ self error: 'Invalid DNI number' ]]
		ifFalse: [ 
	idType = 'C' 
		ifTrue: [  
			"'23-25666777-9' size 13 "
			(idNumber size between: 12 and: 13) ifFalse: [ self error: 'Invalid CUIT number' ].
			(idNumber third = $- and: [ idNumber penultimate = $- ]) ifFalse: [ self error: 'Invalid CUIT number' ].
			({ '20'. '23'. '24'. '25'. '26'. '27'. '30'. '33'. '34'. } includes: (idNumber first: 2)) ifFalse: [ self error: 'Invalid CUIT number' ].
			idNumber last isDigit ifFalse: [ self error: 'Invalid CUIT number' ].
			((idNumber copyFrom: 4 to: idNumber size - 2) allSatisfy: [ :idChar | idChar isDigit ]) ifFalse: [ self error: 'Invalid CUIT number' ]]
		ifFalse: [ self error: 'Invalid identification type' ]].


	newCustomer identificationType: idType.
	newCustomer identificationNumber: idNumber.
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

!CustomerImporter methodsFor: 'address' stamp: 'HAW 7/13/2022 12:30:05'!
importAddress

	| newAddress zipCode importedZipCode newZipcodeOldZipCode |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	
	zipCode := record fifth.

	zipCode first isDigit 
		ifTrue: [ 
			(zipCode allSatisfy: [ :aChar | aChar isDigit ]) ifFalse: [ self error: 'Invalid old zipcode' ].
			importedZipCode := zipCode asNumber.
			(importedZipCode between: 1000 and: 9999) ifFalse: [ self error: 'Invalid old zipcode' ]]
		ifFalse: [
	zipCode first isLetter 
		ifTrue: [
			zipCode size ~= 8 ifTrue: [ self error: 'Invalid new zipcode' ].
			newZipcodeOldZipCode := zipCode copyFrom: 2 to: 5.
			(newZipcodeOldZipCode allSatisfy: [ :aChar | aChar isDigit ]) ifFalse: [ self error: 'Invalid new zipcode' ].
			newZipcodeOldZipCode asNumber > 999 ifFalse: [ self error: 'Invalid new zipcode' ].
			((zipCode last: 3) allSatisfy: [ :aChar | aChar isLetter ]) ifFalse: [ self error: 'Invalid new zipcode' ].
			importedZipCode := zipCode ]
		ifFalse: [ self error: 'Invalid identification type' ]].
			
	newAddress zipCode: importedZipCode.
	newAddress province: record sixth.
	
	newCustomer addAddress: newAddress.
	! !

!CustomerImporter methodsFor: 'address' stamp: 'HAW 5/22/2022 19:37:45'!
isAddressRecord

	^ record first = 'A'! !


!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:35'!
assertRecordNotEmpty

	record isEmpty ifTrue: [ self error: self class invalidRecordTypeErrorDescription ]! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:47:26'!
createRecord

	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 18:49:33'!
hasLineToImport

	line := readStream nextLine.
	^line notNil! !

!CustomerImporter methodsFor: 'evaluating - private' stamp: 'HAW 5/22/2022 20:04:06'!
importRecord

	self assertRecordNotEmpty.

	self isCustomerRecord ifTrue: [ ^self importCustomer ].
	self isAddressRecord ifTrue: [ ^self importAddress ].

	self error: self class invalidRecordTypeErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 21:15:35'!
from: aReadStream into: aCustomerSystem

	^self new initializeFrom: aReadStream into: aCustomerSystem! !


!CustomerImporter class methodsFor: 'importing' stamp: 'HAW 5/22/2022 21:15:52'!
valueFrom: aReadStream into: aCustomerSystem

	^(self from: aReadStream into: aCustomerSystem) value! !


!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:13:48'!
canNotImportAddressWithoutCustomerErrorDescription

	^'Cannot import address without customer'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:41:39'!
invalidAddressRecordErrorDescription

	^'Address record has to have six fields'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:53:56'!
invalidCustomerRecordErrorDescription

	^'Invalid Customer record'! !

!CustomerImporter class methodsFor: 'error messages' stamp: 'HAW 5/22/2022 19:24:11'!
invalidRecordTypeErrorDescription

	^'Invalid record type'! !


!classDefinition: #CustomerSystem category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:17:57'!
add: aCustomer

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:38'!
customerWithIdentificationType: anIdType number: anIdNumber

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:18:51'!
numberOfCustomers

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:04'!
beginTransaction

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:18:16'!
commit

	self subclassResponsibility ! !


!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:10'!
start

	self subclassResponsibility ! !

!CustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:18:13'!
stop

	self subclassResponsibility ! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:14:14'!
add: aCustomer

	^session persist: aCustomer ! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:09:50'!
customerWithIdentificationType: anIdType number: anIdNumber

	^(session
		select: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]
		ofType: Customer) anyOne! !

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:08:47'!
numberOfCustomers

	^(session selectAllOfType: Customer) size! !


!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:12:39'!
beginTransaction

	session beginTransaction.
! !

!PersistentCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 20:13:00'!
commit

	session commit ! !


!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:12:29'!
start

	session := DataBaseSession for: (Array with: Address with: Customer).
	! !

!PersistentCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 20:13:10'!
stop

	session close! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:21:06'!
start

	customers := OrderedCollection new! !

!TransientCustomerSystem methodsFor: 'system lifecycle' stamp: 'HAW 5/22/2022 21:23:17'!
stop

	customers := nil! !


!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:21:20'!
beginTransaction

	! !

!TransientCustomerSystem methodsFor: 'transactions' stamp: 'HAW 5/22/2022 21:23:01'!
commit

	! !


!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:32'!
add: aCustomer

	customers add: aCustomer ! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:22:52'!
customerWithIdentificationType: anIdType number: anIdNumber

	^customers detect: [ :aCustomer | aCustomer identificationType = anIdType and: [ aCustomer identificationNumber = anIdNumber ]]! !

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 5/22/2022 21:21:43'!
numberOfCustomers

	^customers size! !


!classDefinition: #DataBaseSession category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

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

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter-Recu-1er-Parcial'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !


!classDefinition: #Environment category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #Environment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!Environment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:41:06'!
createCustomerSystem

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Environment class' category: 'CustomerImporter-Recu-1er-Parcial'!
Environment class
	instanceVariableNames: ''!

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:10'!
current

	^(self subclasses detect: [ :anEnvironmentClass | anEnvironmentClass isCurrent ]) new! !

!Environment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:41:36'!
isCurrent

	self subclassResponsibility ! !


!classDefinition: #DevelopmentEnvironment category: 'CustomerImporter-Recu-1er-Parcial'!
Environment subclass: #DevelopmentEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!DevelopmentEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:38:39'!
createCustomerSystem

	^TransientCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DevelopmentEnvironment class' category: 'CustomerImporter-Recu-1er-Parcial'!
DevelopmentEnvironment class
	instanceVariableNames: ''!

!DevelopmentEnvironment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:37:58'!
isCurrent

	^true! !


!classDefinition: #IntegrationEnvironment category: 'CustomerImporter-Recu-1er-Parcial'!
Environment subclass: #IntegrationEnvironment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!IntegrationEnvironment methodsFor: 'customer system' stamp: 'HAW 5/22/2022 21:40:48'!
createCustomerSystem

	^PersistentCustomerSystem new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegrationEnvironment class' category: 'CustomerImporter-Recu-1er-Parcial'!
IntegrationEnvironment class
	instanceVariableNames: ''!

!IntegrationEnvironment class methodsFor: 'current' stamp: 'HAW 5/22/2022 21:40:36'!
isCurrent

	^DevelopmentEnvironment isCurrent not! !
