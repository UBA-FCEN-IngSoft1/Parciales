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

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:55'!
invalidCuitNumber

	^ CUIT invalidNumber ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:32'!
invalidDNINumber

	^ DNI invalidNumber ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:21'!
invalidNewZipCodeValue

	^ NewZipCode invalidValue ! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:16:55'!
invalidOldZipCodeValue

	^ OldZipcode invalidValue ! !

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

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:24'!
test10DNICannotBeLessThanOne

	self
		shouldFailImporting: self lessThanOneDNI
		messageText: self invalidDNINumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:24'!
test11DNICannotBeBiggerThan99999999

	self
		shouldFailImporting: self biggerThanValidDNINumber
		messageText: self invalidDNINumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:24'!
test12DNIMustBeAllDigits

	self
		shouldFailImporting: self dniWithoutDigit
		messageText: self invalidDNINumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test13CuitSizeCannotBeLessThan12

	self
		shouldFailImporting: self lessThan12CuitSize
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test14CuitSizeCannotBeBiggerThan13

	self
		shouldFailImporting: self biggerThan13CuitSize
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test15CuitMustHaveDashAtThridPosition

	self
		shouldFailImporting: self cuitWithoutDashInThirdPosition
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test16CuitMustHaveDashAtPenultimatePosition

	self
		shouldFailImporting: self cuitWithoutDashAnPenultimatePosition
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test17CuitMustHaveValidHeader

	self
		shouldFailImporting: self cuitWithInvalidHeader
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test18CuitMustHaveDigitAtEnd

	self
		shouldFailImporting: self cuitWithoutDigitAtEnd
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:49:46'!
test19CuitMustHaveAllDigits

	self
		shouldFailImporting: self cuitWithoutAllDigits
		messageText: self invalidCuitNumber 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:16:46'!
test20OldZipCodeMustBeAllDigits

	self
		shouldFailImporting: self oldZipCodeWithLetters
		messageText: self invalidOldZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:16:46'!
test21OldZipMustBeBiggerThan999

	self
		shouldFailImporting: self oldZipSmallerThan1000
		messageText: self invalidOldZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:16:46'!
test22OldZipMustBeLessThan10000

	self
		shouldFailImporting: self oldZipBiggerThan9999
		messageText: self invalidOldZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:13'!
test23NewZipCodeSizeCannotBeLessThan8

	self
		shouldFailImporting: self newZipCodeWithSizeLessThan8
		messageText: self invalidNewZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:13'!
test24NewZipCodeSizeCannotBeBiggerThan8

	self
		shouldFailImporting: self newZipCodeWithSizeBiggerThan8
		messageText: self invalidNewZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:13'!
test25NewZipCode4DigitsAfterFirstLetter

	self
		shouldFailImporting: self newZipCodeWithoutFourDigits
		messageText: self invalidNewZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:13'!
test26NewZipCode4DigitsMustBeBiggerThan999

	self
		shouldFailImporting: self newZipCodeFourDigitsLessThan1000
		messageText: self invalidNewZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:17:13'!
test27NewZipCodeMustEndWith3Letters

	self
		shouldFailImporting: self newZipCodeWithoutEnding3Letters
		messageText: self invalidNewZipCodeValue 
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:50:16'!
test28IdTypeMustBeDNIOrCuit

	self
		shouldFailImporting: self invalidIdType
		messageText: CustomerIdentification invalidIdentificationType 
		asserting: [ self assertNoCustomerWasImported ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 19:18:05'!
test29ZipCodeMustBeOldOrNew

	self
		shouldFailImporting: self invalidIdZipCode
		messageText: ZipCode invalidZipCodeType
		asserting: [ self assertImportedOneCustomerWithoutAddress ]

	! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:38:05'!
test30CustomerIdentificationsIsNotEqualWithDifferentType

	self deny: (CustomerIdentification forIdType: 'D' number: '22333444') = (CustomerIdentification forIdType: 'C' number: '23-22333444-9')! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:38:24'!
test31CustomerIdentificationsIsNotEqualWithDifferentNumber

	self deny: (CustomerIdentification forIdType: 'D' number: '22333444') = (CustomerIdentification forIdType: 'D' number: '29')! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:38:50'!
test32CustomerIdentificationsIsNotEqualToObjectsOfDifferentType

	self deny: (CustomerIdentification forIdType: 'D' number: '22333444') = 1! !

!ImportTest methodsFor: 'tests' stamp: 'HAW 7/13/2022 18:40:19'!
test33SameCustomerIdentificationHasSameHasn

	self assert: (CustomerIdentification forIdType: 'D' number: '22333444') hash = (CustomerIdentification forIdType: 'D' number: '22333444') hash! !


!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:19:32'!
assertAddressOf: importedCustomer at: aStreetName hasNumber: aNumber town: aTown zipCode: aZipCode province: aProvince

	| importedAddress |

	importedAddress := importedCustomer addressAt: aStreetName ifNone: [ self fail ].
	self assert: aStreetName equals: importedAddress streetName.
	self assert: aNumber equals: importedAddress streetNumber.
	self assert: aTown equals: importedAddress town.
	self assert: aZipCode equals: importedAddress zipCodeValue.
	self assert: aProvince equals: importedAddress province.
	
	^importedAddress 

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:32:34'!
assertCustomerWithIdentificationType: anIdType number: anIdNumber hasFirstName: aFirstName lastName: aLastName

	| importedCustomer identification |

	identification := CustomerIdentification forIdType: anIdType number: anIdNumber.
	importedCustomer := system customerIdentificationAs: identification.

	self assert: aFirstName equals: importedCustomer firstName.
	self assert: aLastName equals: importedCustomer lastName.
	self assert: (importedCustomer isIdentifiedAs: identification).

	^importedCustomer

	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:34:12'!
assertImportedOneCustomerWithoutAddress

	| importedCustomer |

	self assert: 1 equals: system numberOfCustomers.
	importedCustomer := system customerIdentificationAs: (CustomerIdentification forIdType: 'D' number: '22333444').
	self assert: importedCustomer isAddressesEmpty
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:18'!
assertImportedRightNumberOfCustomers

	^ self assert: 2 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:06:06'!
assertJuanPerezWasImportedCorrectly

	| importedCustomer address |

	importedCustomer := self assertCustomerWithIdentificationType: 'C' number: '23-25666777-9' hasFirstName: 'Juan' lastName: 'Perez'.
	
	self deny: importedCustomer hasDNIAsIdentification.
	self assert: 'No dni' equals: (importedCustomer dniNumberIfNone: [ 'No dni' ]).
	self assert: importedCustomer hasCUITAsIdentification.
	self assert: '23-25666777-9' equals: (importedCustomer cuitNumberIfNone: [self fail ]).
	
	address := self assertAddressOf: importedCustomer at: 'Alem' hasNumber: 1122 town: 'CABA' zipCode: 1001 province: 'CABA'.
	
	self assert: address hasOldZipCode.
	self assert: 1001 equals: (address oldZipCodeValueIfNone: [ self fail ]).
	self deny: address hasNewZipCode.
	self assert: 'has old zipcode' equals: (address newZipCodeValueIfNone: [ 'has old zipcode' ]).
	! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 5/22/2022 21:33:24'!
assertNoCustomerWasImported

	^ self assert: 0 equals: system numberOfCustomers! !

!ImportTest methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:06:05'!
assertPepeSanchezWasImportedCorrecty

	| importedCustomer address |

	importedCustomer := self assertCustomerWithIdentificationType: 'D' number: '22333444' hasFirstName: 'Pepe' lastName: 'Sanchez'.
	
	self assert: importedCustomer hasDNIAsIdentification.
	self assert: 22333444 equals: (importedCustomer dniNumberIfNone: [ self fail ]).
	self deny: importedCustomer hasCUITAsIdentification.
	self assert: 'No cuit' equals: (importedCustomer cuitNumberIfNone: [ 'No cuit' ]).
	
	address := self assertAddressOf: importedCustomer at: 'San Martin' hasNumber: 3322 town: 'Olivos' zipCode: 'B1636BBE' province: 'BsAs'.
	self deny: address hasOldZipCode.
	self assert: 'has new zipcode' equals: (address oldZipCodeValueIfNone: [ 'has new zipcode' ]).
	self assert: address hasNewZipCode.
	self assert: 'B1636BBE' equals: (address newZipCodeValueIfNone: [ self fail ]).
		
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


!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 18:56:26'!
hasNewZipCode
	
	^zipCode isNew! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 18:56:32'!
hasOldZipCode
	
	^zipCode isOld! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 19:05:54'!
newZipCodeValueIfNone: aNoneBlock

	^zipCode newZipCodeValueIfNone: aNoneBlock! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 19:06:06'!
oldZipCodeValueIfNone: aNoneBlock

	^zipCode oldZipCodeValueIfNone: aNoneBlock! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 7/13/2022 19:19:31'!
zipCodeValue

	^zipCode value! !


!classDefinition: #Customer category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #Customer
	instanceVariableNames: 'firstName lastName addresses identification'
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


!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:21:32'!
cuitNumberIfNone: aNoneClosure

	^identification cuitNumberIfNone: aNoneClosure! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:20:02'!
dniNumberIfNone: aNoneBlock

	^identification dniNumberIfNone: aNoneBlock! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:21:02'!
hasCUITAsIdentification
	
	^identification isCuit! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:19:15'!
hasDNIAsIdentification
	
	^identification isDNI! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:09:49'!
identification: aCustomerIdentification

	identification := aCustomerIdentification ! !

!Customer methodsFor: 'identification' stamp: 'HAW 7/13/2022 18:28:41'!
isIdentifiedAs: anIdentification

	^identification = anIdentification ! !


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!classDefinition: #CustomerIdentification category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #CustomerIdentification
	instanceVariableNames: 'number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!CustomerIdentification methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:41:01'!
cuitNumberIfNone: aNoneBlock

	self subclassResponsibility ! !

!CustomerIdentification methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:40:56'!
dniNumberIfNone: aNoneBlock

	self subclassResponsibility ! !

!CustomerIdentification methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:35:31'!
number
	
	^number! !

!CustomerIdentification methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:35:37'!
type
	
	^self class type! !


!CustomerIdentification methodsFor: 'initialization' stamp: 'HAW 7/13/2022 18:35:20'!
initializeFrom: dniNumber 
	
	number := dniNumber.! !


!CustomerIdentification methodsFor: 'comparing' stamp: 'HAW 7/13/2022 18:39:10'!
= anObject

	^(anObject isKindOf: self class) and: [ self type = anObject type and: [ self number = anObject number ]]! !

!CustomerIdentification methodsFor: 'comparing' stamp: 'HAW 7/13/2022 18:40:06'!
hash

	^self type hash bitXor: number hash! !


!CustomerIdentification methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:40:42'!
isCuit

	self subclassResponsibility ! !

!CustomerIdentification methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:40:46'!
isDNI

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerIdentification class' category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerIdentification class
	instanceVariableNames: ''!

!CustomerIdentification class methodsFor: 'instance creation' stamp: 'HAW 7/13/2022 18:48:31'!
forIdType: idType number: idNumber
 
	^self subclasses 
		detect: [ :aCustomerIdentificationClass | aCustomerIdentificationClass isFor: idType ]
		ifFound: [ :aCustomerIdentificationClass | aCustomerIdentificationClass from: idNumber ]
		ifNone: [ self error: self invalidIdentificationType ]



! !

!CustomerIdentification class methodsFor: 'instance creation' stamp: 'HAW 7/13/2022 18:48:31'!
invalidIdentificationType

	^ 'Invalid identification type'! !


!CustomerIdentification class methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:43:28'!
isFor: anIdType

	self subclassResponsibility ! !


!CustomerIdentification class methodsFor: 'type' stamp: 'HAW 7/13/2022 18:43:21'!
type

	self subclassResponsibility ! !


!CustomerIdentification class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 18:48:18'!
from: aNumber

	self subclassResponsibility ! !


!classDefinition: #CUIT category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerIdentification subclass: #CUIT
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!CUIT methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:21:45'!
cuitNumberIfNone: aNoneClosure

	^number ! !

!CUIT methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:20:47'!
dniNumberIfNone: aNoneBlock

	^aNoneBlock value! !


!CUIT methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:21:11'!
isCuit
	
	^true! !

!CUIT methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:20:34'!
isDNI
	
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CUIT class' category: 'CustomerImporter-Recu-1er-Parcial'!
CUIT class
	instanceVariableNames: ''!

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:45:06'!
assertDashesAreInValidPositions: idNumber

	^ (idNumber third = $- and: [ idNumber penultimate = $- ]) ifFalse: [ self signalInvalidNumber ]! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:45:23'!
assertHeaderIsValidFor: idNumber

	^ ({ '20'. '23'. '24'. '25'. '26'. '27'. '30'. '33'. '34'. } includes: (idNumber first: 2)) ifFalse: [ self signalInvalidNumber ]! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:45:37'!
assertLastDigitIsValid: idNumber

	^ idNumber last isDigit ifFalse: [ self signalInvalidNumber ]! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:45:53'!
assertNumberAreAllDigits: idNumber

	^ ((idNumber copyFrom: 4 to: idNumber size - 2) allSatisfy: [ :idChar | idChar isDigit ]) ifFalse: [ self signalInvalidNumber ]! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:44:47'!
assertValidSizeOf: idNumber

	^ (idNumber size between: 12 and: 13) ifFalse: [ self signalInvalidNumber ]! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:44:19'!
invalidNumber

	^ 'Invalid CUIT number'! !

!CUIT class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:44:31'!
signalInvalidNumber

	^ self error: self invalidNumber! !


!CUIT class methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:17:20'!
isFor: idType

	^self type = idType! !


!CUIT class methodsFor: 'type' stamp: 'HAW 7/13/2022 18:17:20'!
type

	^ 'C'! !


!CUIT class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 18:45:53'!
from: idNumber 
	
	self assertValidSizeOf: idNumber.
	self assertDashesAreInValidPositions: idNumber.
	self assertHeaderIsValidFor: idNumber.
	self assertLastDigitIsValid: idNumber.
	self assertNumberAreAllDigits: idNumber.
	
	^self new initializeFrom: idNumber ! !


!classDefinition: #DNI category: 'CustomerImporter-Recu-1er-Parcial'!
CustomerIdentification subclass: #DNI
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!DNI methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:22:07'!
cuitNumberIfNone: aNoneClosure

	^aNoneClosure value! !

!DNI methodsFor: 'accessing' stamp: 'HAW 7/13/2022 18:20:13'!
dniNumberIfNone: aNoneBlock

	^number ! !


!DNI methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:21:55'!
isCuit
	
	^false! !

!DNI methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:19:25'!
isDNI
	
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DNI class' category: 'CustomerImporter-Recu-1er-Parcial'!
DNI class
	instanceVariableNames: ''!

!DNI class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:47:00'!
assertAreAllDigits: idNumber

	^ (idNumber allSatisfy: [ :idChar | idChar isDigit ]) ifFalse: [ self signalInvalidNumber ]! !

!DNI class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:47:37'!
assertIsInRange: dniNumber

	^ (dniNumber between: 1 and: 99999999) ifFalse: [ self signalInvalidNumber ]! !

!DNI class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:46:41'!
invalidNumber

	^ 'Invalid DNI number'! !

!DNI class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 18:46:49'!
signalInvalidNumber

	^ self error: self invalidNumber! !


!DNI class methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:16:46'!
isFor: idType

	^self type = idType ! !


!DNI class methodsFor: 'type' stamp: 'HAW 7/13/2022 18:16:46'!
type

	^ 'D'! !


!DNI class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 18:47:37'!
from: idNumber 

	| dniNumber | 
	
	self assertAreAllDigits: idNumber.
	dniNumber := Integer readFrom: idNumber readStream.
	self assertIsInRange: dniNumber.
	
	^self new initializeFrom: dniNumber ! !


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

!CustomerImporter methodsFor: 'customer' stamp: 'HAW 7/13/2022 18:41:25'!
importCustomer

	self assertValidCustomerRecord.

	newCustomer := Customer new.
	newCustomer firstName: record second.
	newCustomer lastName: record third.
	newCustomer identification: (CustomerIdentification forIdType: record fourth number: record fifth).
	
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

!CustomerImporter methodsFor: 'address' stamp: 'HAW 7/13/2022 19:19:09'!
importAddress

	| newAddress |

	self assertCustomerWasImported.
	self assertValidAddressRecord.

	newAddress := Address new.
	newAddress streetName: record second.
	newAddress streetNumber: record third asNumber .
	newAddress town: record fourth.
	newAddress zipCode: (ZipCode from: record fifth).
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

!CustomerSystem methodsFor: 'customers' stamp: 'HAW 7/13/2022 18:34:47'!
customerIdentificationAs: aCustomerIdentification

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

!PersistentCustomerSystem methodsFor: 'customers' stamp: 'HAW 7/13/2022 18:25:50'!
customerIdentificationAs: aCustomerIdentification

	^(session
		select: [ :aCustomer | aCustomer isIdentifiedAs: aCustomerIdentification ]
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

!TransientCustomerSystem methodsFor: 'customers' stamp: 'HAW 7/13/2022 18:27:22'!
customerIdentificationAs: aCustomerIdentification

	^customers detect: [ :aCustomer | aCustomer isIdentifiedAs: aCustomerIdentification ]! !

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


!classDefinition: #ZipCode category: 'CustomerImporter-Recu-1er-Parcial'!
Object subclass: #ZipCode
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!ZipCode methodsFor: 'initialization' stamp: 'HAW 7/13/2022 19:08:49'!
initializeFor: aZipCodeValue 
	
	value := aZipCodeValue.! !


!ZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:09:40'!
newZipCodeValueIfNone: aNoneBlock

	self subclassResponsibility ! !

!ZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:09:35'!
oldZipCodeValueIfNone: aNoneBlock

	self subclassResponsibility ! !

!ZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:09:58'!
value

	self subclassResponsibility ! !


!ZipCode methodsFor: 'testing' stamp: 'HAW 7/13/2022 19:09:13'!
isNew

	self subclassResponsibility ! !

!ZipCode methodsFor: 'testing' stamp: 'HAW 7/13/2022 19:09:16'!
isOld

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZipCode class' category: 'CustomerImporter-Recu-1er-Parcial'!
ZipCode class
	instanceVariableNames: ''!

!ZipCode class methodsFor: 'instance creation' stamp: 'HAW 7/13/2022 19:18:32'!
from: aZipCodeValue

	^self subclasses 
		detect: [ :aZipcodeClass | aZipcodeClass isFor: aZipCodeValue ]
		ifFound: [ :aZipcodeClass | aZipcodeClass for: aZipCodeValue ]
		ifNone: [ self error: self invalidZipCodeType ]! !

!ZipCode class methodsFor: 'instance creation' stamp: 'HAW 7/13/2022 19:18:32'!
invalidZipCodeType

	^ 'Invalid zipcode type'! !


!ZipCode class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 19:15:06'!
for: aZipCodeValue

	self subclassResponsibility ! !


!ZipCode class methodsFor: 'testing' stamp: 'HAW 7/13/2022 19:15:12'!
isFor: aZipCodeValue

	self subclassResponsibility ! !


!classDefinition: #NewZipCode category: 'CustomerImporter-Recu-1er-Parcial'!
ZipCode subclass: #NewZipCode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!NewZipCode methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:57:37'!
isNew
	
	^true! !

!NewZipCode methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:57:07'!
isOld
	
	^false! !


!NewZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:08:12'!
newZipCodeValueIfNone: aNoneBlock

	^value ! !

!NewZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:06:05'!
oldZipCodeValueIfNone: aNoneClosure

	^aNoneClosure value! !

!NewZipCode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:08:15'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NewZipCode class' category: 'CustomerImporter-Recu-1er-Parcial'!
NewZipCode class
	instanceVariableNames: ''!

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:11:21'!
assertHasValidSize: aZipCodeValue

	^ aZipCodeValue size ~= 8 ifTrue: [ self signalInvalidValue ]! !

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:12:55'!
assertHasValidTail: aZipCodeValue

	^ ((aZipCodeValue last: 3) allSatisfy: [ :aChar | aChar isLetter ]) ifFalse: [ self signalInvalidValue ]! !

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:12:35'!
assertIsValidNumberPart: newZipcodeOldZipCode

	^ newZipcodeOldZipCode asNumber > 999 ifFalse: [ self signalInvalidValue ]! !

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:12:16'!
assertNumberPartAreDigits: newZipcodeOldZipCode

	^ (newZipcodeOldZipCode allSatisfy: [ :aChar | aChar isDigit ]) ifFalse: [ self signalInvalidValue ]! !

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:11:02'!
invalidValue

	^ 'Invalid new zipcode'! !

!NewZipCode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:11:11'!
signalInvalidValue

	^ self error: self invalidValue! !


!NewZipCode class methodsFor: 'testing' stamp: 'HAW 7/13/2022 19:03:07'!
isFor: zipCode

	^zipCode first isLetter 
		! !


!NewZipCode class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 19:12:58'!
for: aZipCodeValue 
	
	| newZipcodeOldZipCode |
	
	self assertHasValidSize: aZipCodeValue.
	newZipcodeOldZipCode := aZipCodeValue copyFrom: 2 to: 5.
	self assertNumberPartAreDigits: newZipcodeOldZipCode.
	self assertIsValidNumberPart: newZipcodeOldZipCode.
	self assertHasValidTail: aZipCodeValue.
	
	^self new initializeFor: aZipCodeValue ! !


!classDefinition: #OldZipcode category: 'CustomerImporter-Recu-1er-Parcial'!
ZipCode subclass: #OldZipcode
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter-Recu-1er-Parcial'!

!OldZipcode methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:59:37'!
isNew
	
	^false! !

!OldZipcode methodsFor: 'testing' stamp: 'HAW 7/13/2022 18:59:15'!
isOld
	
	^true! !


!OldZipcode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:05:54'!
newZipCodeValueIfNone: aNoneBlock

	^aNoneBlock value! !

!OldZipcode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:06:05'!
oldZipCodeValueIfNone: aNoneClosure

	^value ! !

!OldZipcode methodsFor: 'value' stamp: 'HAW 7/13/2022 19:08:01'!
value
	
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OldZipcode class' category: 'CustomerImporter-Recu-1er-Parcial'!
OldZipcode class
	instanceVariableNames: ''!

!OldZipcode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:14:10'!
assertAreAllDigits: aZipCodeValue

	^ (aZipCodeValue allSatisfy: [ :aChar | aChar isDigit ]) ifFalse: [ self signalInvalidValue ]! !

!OldZipcode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:14:21'!
assertIsInvalidRange: importedZipCode

	^ (importedZipCode between: 1000 and: 9999) ifFalse: [ self signalInvalidValue ]! !

!OldZipcode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:13:38'!
invalidValue

	^ 'Invalid old zipcode'! !

!OldZipcode class methodsFor: 'assertions' stamp: 'HAW 7/13/2022 19:13:55'!
signalInvalidValue

	^ self error: self invalidValue! !


!OldZipcode class methodsFor: 'testing' stamp: 'HAW 7/13/2022 19:02:47'!
isFor: zipCode

	^zipCode first isDigit 
	! !


!OldZipcode class methodsFor: 'instance creation - private' stamp: 'HAW 7/13/2022 19:14:33'!
for: aZipCodeValue 
	
	| value |
	
	self assertAreAllDigits: aZipCodeValue.
	value := aZipCodeValue asNumber.
	self assertIsInvalidRange: value.
	
	^self new initializeFor: value ! !
