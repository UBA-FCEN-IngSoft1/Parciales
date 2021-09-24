!classDefinition: #CityTest category: 'ISW1-2021-2C-1erParcial'!
TestCase subclass: #CityTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!CityTest methodsFor: 'tests' stamp: 'FRT 9/22/2021 19:15:27'!
test01CityWithoutPowerServicesHaveZeroEnergyProduced

	| city |

	city _ City new.
	self assert: 0 * ep equals: city energyProduced.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:08:35'!
test02CityWithSolarPlantWithoutZonesHave500EnergyAvailable

	| city |

	city _ self cityWithSolarPlant.
	
	self assert: 500 * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:20:40'!
test03CityWithSolarPlantWithResidentialZonesHave495EnergyAvailable

	self assertEnergyAvailableIs: 500 - 5 * ep afterAdding: [ :city | city addZone: self residentialZone ]
	
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:21:14'!
test04CityWithSolarPlantWithCommertialZonesHave492EnergyAvailable

	self assertEnergyAvailableIs: 500 - 5 - 8 * ep afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZone ].
		
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:21:38'!
test05CityWithSolarPlantWithIndustrialZonesHave490EnergyAvailable

	self assertEnergyAvailableIs: 500 - 10 * ep afterAdding: [ :city | 
		city addZone: self industrialZone ]! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:22:04'!
test06CityWithSolarPlantWithServeralZonesImpactEnergyAvailable

	self assertEnergyAvailableIs: 500 - 5 - 8 - (10 * 2) * ep afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZone.
		city addZone: self industrialZone.	
		city addZone: self industrialZone ]
		
	! !

!CityTest methodsFor: 'tests' stamp: 'FRT 9/22/2021 19:18:47'!
test07CityWithoutWaterServicesHaveZeroWaterProduced

	| city |

	city _ City new.
	self assert: 0 * wp equals: city waterProduced.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:14:46'!
test08CityWithWaterTowerWithoutZonesHave200WaterAvailable

	| city |

	city _ self cityWithWateTower.
	
	self assert: 200 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:23:20'!
test09CityWithWaterTowerWithResidentialZonesHave191WaterAvailable

	self assertWaterAvailableIs: 200 - 9 * wp afterAdding: [ :city | city addZone: self residentialZone ]
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:23:47'!
test10CityWithWaterTowerWithCommertialZonesHave198WaterAvailable

	self assertWaterAvailableIs: 200 - 9 - 2 * wp afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZone ]
! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:24:11'!
test11CityWithWaterTowerWithIndustrialZonesHave190WaterAvailable

	self assertWaterAvailableIs: 200 - 10 * wp afterAdding: [ :city | 
		city addZone: self industrialZone ]! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:24:33'!
test12CityWithWaterTowerWithServeralZonesImpactWaterAvailable

	self assertWaterAvailableIs:  200 - 31 * wp afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZone.
		city addZone: self industrialZone.
		city addZone: self industrialZone ]
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:09:10'!
test13CityWith2SolarPlantsHaveTwiceEnergyAvailable

	| city |

	city _ self cityWithSolarPlant.
	city addService: self solarPlant.
	
	self assert: (500 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:15:17'!
test14CityWith2WaterTowerHaveTwiceWaterAvailable

	| city |

	city _ self cityWithWateTower.
	city addService: self waterTower.
	
	self assert: (200 * 2) * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:25:33'!
test15AResidentialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	self assertCannotAdd: self residentialZone! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:25:45'!
test16ACommertialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	self assertCannotAdd: self commertialZone! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:25:55'!
test17AnIndustrialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	self assertCannotAdd: self industrialZone! !

!CityTest methodsFor: 'tests' stamp: 'FRT 9/22/2021 19:19:49'!
test18CityWithoutZonesHaveZeroEnergyConsumption

	| city |

	city _ City new.
	self assert: 0 * ep equals: city energyConsumption.! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:29:24'!
test19CityWithoutResidentialZonesCannotAddCommertialZone

	self assertCannotAdd: self commertialZone  to: self cityWithSolarPlantAndWateTower with: City cannotAddCommertialZoneErrorDescription
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:31:28'!
test20CityWithSolarPlantWithResidentialZoneWithManyCellsHave10LessEnergyAvailable

	self assertEnergyAvailableIs: 500 - (5 * 2) * ep afterAdding: [ :city | city addZone: self residentialZoneWithTwoCells ]
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:32:26'!
test21CityWithSolarPlantWithCommertialZoneWithManyCellsHave16LessEnergyAvailable

	self assertEnergyAvailableIs: 500 - 5 - (8 * 2) * ep afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZoneWithTwoCells ]
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:32:53'!
test22CityWithSolarPlantWithIndustrialZoneWithManyCellsHave20LessEnergyAvailable

	self assertEnergyAvailableIs: 500 - (10 * 2) * ep afterAdding: [ :city | 
		city addZone: self industrialZoneWithTwoCells ].
! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:33:27'!
test23CityWithWaterTowerWithResidentialZoneWithManyCellsHave18LessWaterAvailable

	self assertWaterAvailableIs: 200 - (9 * 2) * wp afterAdding: [ :city | 
		city addZone: self residentialZoneWithTwoCells] .
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:34:15'!
test24CityWithWaterTowerWithCommertialZoneWithManyCellsHave4LessWaterAvailable

	self assertWaterAvailableIs: 200 - 9 - (2 * 2) * wp afterAdding: [ :city | 
		city addZone: self residentialZone.
		city addZone: self commertialZoneWithTwoCells.]
	! !

!CityTest methodsFor: 'tests' stamp: 'HAW 9/24/2021 11:34:41'!
test25CityWithWaterTowerWithIndustrialZoneWithManyCellsHave20LessWaterAvailable

	self assertWaterAvailableIs: 200 - (10 * 2) * wp afterAdding: [ :city | 
		city addZone: self industrialZoneWithTwoCells].
	! !


!CityTest methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:27:30'!
assertCannotAdd: aZone

	self assertCannotAdd: aZone to: City new.
	
! !

!CityTest methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:28:55'!
assertCannotAdd: aZone to: city

	self assertCannotAdd: aZone to: city with: City cannotAddZoneErrorDescription! !

!CityTest methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:28:38'!
assertCannotAdd: aZone to: city with: anErrorMessage

	self 
		should: [ city addZone: aZone ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage.
			self assert: 0 equals: city zones size]
		! !

!CityTest methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:20:11'!
assertEnergyAvailableIs: energyAvailable afterAdding: aBlock

	| city |

	city _ self cityWithSolarPlantAndWateTower.
	aBlock value: city.
	
	self assert: energyAvailable equals: city energyAvailable.! !

!CityTest methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:22:48'!
assertWaterAvailableIs: waterAvailable afterAdding: aBlock

	| city |

	city _ self cityWithSolarPlantAndWateTower.
	aBlock value: city.
	
	self assert: waterAvailable equals: city waterAvailable.! !


!CityTest methodsFor: 'city creation' stamp: 'HAW 9/24/2021 11:08:45'!
cityWithSolarPlant
	
	| city |

	city _ City new.
	city addService: self solarPlant.
	
	^city! !

!CityTest methodsFor: 'city creation' stamp: 'HAW 9/24/2021 11:12:09'!
cityWithSolarPlantAndWateTower
	
	| city |

	city _ self cityWithSolarPlant.
	city addService: self waterTower.
	
	^city ! !

!CityTest methodsFor: 'city creation' stamp: 'HAW 9/24/2021 11:14:59'!
cityWithWateTower
	
	| city |

	city _ City new.
	city addService: self waterTower.
	
	^city! !


!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
commertialZone

	^ CommertialZone newWithCells: 1! !

!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
commertialZoneWithTwoCells
	
	^CommertialZone newWithCells: 2! !

!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
industrialZone

	^ IndustrialZone newWithCells: 1! !

!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
industrialZoneWithTwoCells
	
	^IndustrialZone newWithCells: 2! !

!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
residentialZone

	^ ResidentialZone newWithCells: 1! !

!CityTest methodsFor: 'zone creation' stamp: 'HAW 9/24/2021 11:02:52'!
residentialZoneWithTwoCells
	
	^ResidentialZone newWithCells: 2! !


!CityTest methodsFor: 'service creation' stamp: 'HAW 9/24/2021 10:23:23'!
solarPlant

	^ Service solarPlant! !

!CityTest methodsFor: 'service creation' stamp: 'HAW 9/24/2021 10:23:29'!
waterTower

	^ Service waterTower! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CityTest class' category: 'ISW1-2021-2C-1erParcial'!
CityTest class
	instanceVariableNames: ''!

!CityTest class methodsFor: 'class initialization' stamp: 'FRT 9/22/2021 19:22:41'!
initialize

	"Este método está para crear unidades"
	"No lo deben tocar ni darle importancia durante el parcial"
	
	| ep wp |
	ep := BaseUnit named: 'energypoint' sign: 'ep'.
	wp := BaseUnit named: 'waterpoint' sign: 'wp'.
	
	Smalltalk at: #ep put: ep.
	Smalltalk at: #wp put: wp.! !


!classDefinition: #City category: 'ISW1-2021-2C-1erParcial'!
Object subclass: #City
	instanceVariableNames: 'zones services'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!City methodsFor: 'energy' stamp: 'FRT 9/16/2021 21:06:00'!
energyAvailable
	
	^ self energyProduced - self energyConsumption

! !

!City methodsFor: 'energy' stamp: 'HAW 9/24/2021 10:41:10'!
energyConsumption
	
	^zones sum: [ :zone | zone totalEnergyConsumption ] ifEmpty: [ 0 * ep ]
! !

!City methodsFor: 'energy' stamp: 'HAW 9/24/2021 10:13:34'!
energyProduced
	
	^services sum: [ :service | service energyProduced ] ifEmpty: [ 0 * ep ]! !


!City methodsFor: 'initialization' stamp: 'HAW 9/24/2021 10:05:19'!
initialize

	services _ OrderedCollection new.
	zones _ OrderedCollection new! !


!City methodsFor: 'services' stamp: 'HAW 9/24/2021 10:05:28'!
addService: aService 

	services add: aService.! !


!City methodsFor: 'testing' stamp: 'HAW 9/24/2021 10:14:55'!
hasResidentialZones

	^zones anySatisfy: [ :zone | zone isResidential ]! !


!City methodsFor: 'water' stamp: 'FRT 9/16/2021 21:23:24'!
waterAvailable
	
	^ self waterProduced - self waterConsumption.! !

!City methodsFor: 'water' stamp: 'HAW 9/24/2021 10:41:36'!
waterConsumption
	
	^zones sum: [ :zone | zone totalWaterConsumption ] ifEmpty: [ 0 * wp ]! !

!City methodsFor: 'water' stamp: 'HAW 9/24/2021 10:18:34'!
waterProduced
	
	^services sum: [  :service | service waterProduced ] ifEmpty: [ 0*wp ]! !


!City methodsFor: 'zones' stamp: 'HAW 9/24/2021 10:36:40'!
addZone: aZone

	aZone assertCanBeAddedTo: self.
	
	zones add: aZone.
! !

!City methodsFor: 'zones' stamp: 'HAW 9/24/2021 10:06:32'!
zones

	^ zones.
! !


!City methodsFor: 'zones - assertions' stamp: 'HAW 9/24/2021 10:44:05'!
assertCanAddCommertialZone: aZone 
	
	self assertCanAddZone: aZone.
		
	self hasResidentialZones ifFalse: [ self error: City cannotAddCommertialZoneErrorDescription ].
	! !

!City methodsFor: 'zones - assertions' stamp: 'HAW 9/24/2021 10:44:05'!
assertCanAddIndustrialZone: aZone 
	
	self assertCanAddZone: aZone.
! !

!City methodsFor: 'zones - assertions' stamp: 'HAW 9/24/2021 10:44:05'!
assertCanAddResidentialZone: aZone 
	
	self assertCanAddZone: aZone.
	
! !

!City methodsFor: 'zones - assertions' stamp: 'HAW 9/24/2021 10:44:05'!
assertCanAddZone: aZone

	self energyAvailable < aZone energyConsumption ifTrue: [ self error: City cannotAddZoneErrorDescription ].
	self waterAvailable < aZone waterConsumption ifTrue: [ self error: City cannotAddZoneErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'City class' category: 'ISW1-2021-2C-1erParcial'!
City class
	instanceVariableNames: ''!

!City class methodsFor: 'error messages' stamp: 'FRT 9/16/2021 22:10:50'!
cannotAddCommertialZoneErrorDescription

	^ 'Cannot add commertial zone without Residential zones'.! !

!City class methodsFor: 'error messages' stamp: 'FRT 9/16/2021 21:41:32'!
cannotAddZoneErrorDescription

	^ 'Cannot add zone'.! !


!classDefinition: #Service category: 'ISW1-2021-2C-1erParcial'!
Object subclass: #Service
	instanceVariableNames: 'waterProduced energyProduced'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!Service methodsFor: 'initialization' stamp: 'HAW 9/24/2021 10:24:47'!
initializeWaterProduced: aWaterPoints energyProduced: anEnergyPoints 
	
	waterProduced := aWaterPoints.
	energyProduced := anEnergyPoints.! !


!Service methodsFor: 'production' stamp: 'HAW 9/24/2021 10:24:47'!
energyProduced
	
	^energyProduced ! !

!Service methodsFor: 'production' stamp: 'HAW 9/24/2021 10:24:40'!
waterProduced
	
	^waterProduced ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Service class' category: 'ISW1-2021-2C-1erParcial'!
Service class
	instanceVariableNames: ''!

!Service class methodsFor: 'instance creation' stamp: 'HAW 9/24/2021 10:22:11'!
solarPlant

	^self waterProduced:0 * wp energyProduced: 500 * ep! !

!Service class methodsFor: 'instance creation' stamp: 'HAW 9/24/2021 10:21:43'!
waterTower

	^self waterProduced: 200 * wp energyProduced: 0 * ep! !


!Service class methodsFor: 'instance creation - private' stamp: 'HAW 9/24/2021 10:22:39'!
waterProduced: aWaterPoints energyProduced: anEnergyPoints 
	
	^self new initializeWaterProduced: aWaterPoints energyProduced: anEnergyPoints ! !


!classDefinition: #Zone category: 'ISW1-2021-2C-1erParcial'!
Object subclass: #Zone
	instanceVariableNames: 'numberOfCells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!Zone methodsFor: 'initialization' stamp: 'HAW 9/24/2021 13:56:57'!
initializeNumberOfCells: aNumberOfCells  
	
	numberOfCells := aNumberOfCells ! !



!Zone methodsFor: 'water consumption' stamp: 'HAW 9/24/2021 13:57:39'!
totalWaterConsumption
	
	^self waterConsumption * numberOfCells ! !

!Zone methodsFor: 'water consumption' stamp: 'HAW 9/24/2021 13:57:11'!
waterConsumption
	
	self subclassResponsibility ! !


!Zone methodsFor: 'energy consumption' stamp: 'HAW 9/24/2021 13:57:17'!
energyConsumption
	
	self subclassResponsibility ! !

!Zone methodsFor: 'energy consumption' stamp: 'HAW 9/24/2021 13:57:32'!
totalEnergyConsumption

	^self energyConsumption *numberOfCells! !


!Zone methodsFor: 'testing' stamp: 'HAW 9/24/2021 10:44:34'!
isResidential
	
	self subclassResponsibility ! !


!Zone methodsFor: 'assertions' stamp: 'HAW 9/24/2021 11:03:51'!
assertCanBeAddedTo: aCity 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zone class' category: 'ISW1-2021-2C-1erParcial'!
Zone class
	instanceVariableNames: ''!

!Zone class methodsFor: 'instance creation' stamp: 'HAW 9/24/2021 13:56:37'!
newWithCells: aNumberOfCells 
	
	^self new initializeNumberOfCells: aNumberOfCells ! !


!classDefinition: #CommertialZone category: 'ISW1-2021-2C-1erParcial'!
Zone subclass: #CommertialZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!CommertialZone methodsFor: 'testing' stamp: 'HAW 9/24/2021 10:45:22'!
isResidential

	^false! !


!CommertialZone methodsFor: 'assertions' stamp: 'HAW 9/24/2021 10:39:02'!
assertCanBeAddedTo: aCity 
	
	aCity assertCanAddCommertialZone: self! !


!CommertialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:55:46'!
energyConsumption

	^ 8 * ep! !

!CommertialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:55:51'!
waterConsumption

	^ 2 * wp! !


!classDefinition: #IndustrialZone category: 'ISW1-2021-2C-1erParcial'!
Zone subclass: #IndustrialZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!IndustrialZone methodsFor: 'assertions' stamp: 'HAW 9/24/2021 10:39:44'!
assertCanBeAddedTo: aCity 
	
	aCity assertCanAddIndustrialZone: self! !


!IndustrialZone methodsFor: 'testing' stamp: 'HAW 9/24/2021 10:45:11'!
isResidential

	^false! !


!IndustrialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:55:56'!
energyConsumption

	^ 10 * ep! !

!IndustrialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:56:00'!
waterConsumption

	^ 10 * wp! !


!classDefinition: #ResidentialZone category: 'ISW1-2021-2C-1erParcial'!
Zone subclass: #ResidentialZone
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!ResidentialZone methodsFor: 'assertions' stamp: 'HAW 9/24/2021 10:38:19'!
assertCanBeAddedTo: aCity 
	
	aCity assertCanAddResidentialZone: self! !


!ResidentialZone methodsFor: 'testing' stamp: 'HAW 9/24/2021 10:44:43'!
isResidential
	
	^true! !


!ResidentialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:56:06'!
energyConsumption

	^ 5* ep! !

!ResidentialZone methodsFor: 'consumption' stamp: 'HAW 9/24/2021 13:56:10'!
waterConsumption

	^ 9 * wp! !

CityTest initialize!