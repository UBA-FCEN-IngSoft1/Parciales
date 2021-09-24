!classDefinition: #CityTest category: 'ISW1-2021-2C-1erParcial'!
TestCase subclass: #CityTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:04'!
commertialZone

	^ Zone withType: #Commertial! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:14'!
industrialZone

	^ Zone withType: #Industrial! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:08:55'!
residentialZone

	^ Zone withType: #Residential! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:08:33'!
solarPlant

	^ Service withType: #SolarPlant! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:15:27'!
test01CityWithoutPowerServicesHaveZeroEnergyProduced

	| city |

	city _ City new.
	self assert: 0 * ep equals: city energyProduced.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:24'!
test02CityWithSolarPlantWithoutZonesHave500EnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	
	self assert: 500 * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:36'!
test03CityWithSolarPlantWithResidentialZonesHave495EnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	
	self assert: 500 - 5 * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:47'!
test04CityWithSolarPlantWithCommertialZonesHave492EnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.
	
	city addZone: self residentialZone.
	city addZone: self commertialZone.
	
	self assert: 500 - 5 - 8 * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:09:58'!
test05CityWithSolarPlantWithIndustrialZonesHave490EnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self industrialZone.
	
	self assert: 500 - 10 * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:10:16'!
test06CityWithSolarPlantWithServeralZonesImpactEnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	city addZone: self commertialZone.
	city addZone: self industrialZone.	
	city addZone: self industrialZone.
	
	self assert: 500 - 5 - 8 - (10 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:18:47'!
test07CityWithoutWaterServicesHaveZeroWaterProduced

	| city |

	city _ City new.
	self assert: 0 * wp equals: city waterProduced.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:10:26'!
test08CityWithWaterTowerWithoutZonesHave200WaterAvailable

	| city |

	city _ City new.
	city addService: self waterTower.
	
	self assert: 200 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:10:39'!
test09CityWithWaterTowerWithResidentialZonesHave191WaterAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	
	self assert: 200 - 9 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:10:52'!
test10CityWithWaterTowerWithCommertialZonesHave198WaterAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	city addZone: self commertialZone.
	
	self assert: 200 - 9 - 2 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:11:03'!
test11CityWithWaterTowerWithIndustrialZonesHave190WaterAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.
	
	city addZone: self industrialZone.
	
	self assert: 200 - 10 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:11:21'!
test12CityWithWaterTowerWithServeralZonesImpactWaterAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	city addZone: self commertialZone.
	city addZone: self industrialZone.
	city addZone: self industrialZone.
	
	self assert: 200 - 31 * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:11:29'!
test13CityWith2SolarPlantsHaveTwiceEnergyAvailable

	| city |

	city _ City new.
	city addService: self solarPlant.
	city addService: self solarPlant.
	
	self assert: (500 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:11:38'!
test14CityWith2WaterTowerHaveTwiceWaterAvailable

	| city |

	city _ City new.
	city addService: self waterTower.
	city addService: self waterTower.
	
	self assert: (200 * 2) * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:12:07'!
test15AResidentialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	| city |

	city _ City new.
	
	self 
		should: [ city addZone: self residentialZone. ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: City cannotAddZoneErrorDescription.
			self assert: 0 equals: city zones size]
		! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:12:28'!
test16ACommertialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	| city |

	city _ City new.
	
	self 
		should: [ city addZone: self commertialZone ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: City cannotAddZoneErrorDescription.
			self assert: 0 equals: city zones size ]
		! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:12:48'!
test17AnIndustrialZoneCannotBeAddedWithoutEnergyAndWaterAvailable

	| city |

	city _ City new.
	
	self 
		should: [ city addZone: self industrialZone ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: City cannotAddZoneErrorDescription.
			self assert: 0 equals: city zones size ]
		! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:19:49'!
test18CityWithoutZonesHaveZeroEnergyConsumption

	| city |

	city _ City new.
	self assert: 0 * ep equals: city energyConsumption.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:13:13'!
test19CityWithoutResidentialZonesCannotAddCommertialZone

	| city |

	city _ City new.
	
	city addService: self solarPlant.
	city addService: self waterTower.
	
	self 
		should: [ city addZone: self commertialZone ] 
		raise: Error
		withExceptionDo: [ :error | 
			self assert: error messageText equals: City cannotAddCommertialZoneErrorDescription.
			self assert: 0 equals: city zones size ]! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:13:27'!
test20CityWithSolarPlantWithResidentialZoneWithManyCellsHave10LessEnergyAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	zone _ self residentialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 500 - (5 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:13:41'!
test21CityWithSolarPlantWithCommertialZoneWithManyCellsHave16LessEnergyAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.
	
	city addZone: self residentialZone.
	
	zone _ self commertialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 500 - 5 - (8 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:13:50'!
test22CityWithSolarPlantWithIndustrialZoneWithManyCellsHave20LessEnergyAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	zone _ self industrialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 500 - (10 * 2) * ep equals: city energyAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:13:59'!
test23CityWithWaterTowerWithResidentialZoneWithManyCellsHave18LessWaterAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	zone _ self residentialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 200 - (9 * 2) * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:14:10'!
test24CityWithWaterTowerWithCommertialZoneWithManyCellsHave4LessWaterAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.

	city addZone: self residentialZone.
	
	zone _ self commertialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 200 - 9 - (2 * 2) * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:14:20'!
test25CityWithWaterTowerWithIndustrialZoneWithManyCellsHave20LessWaterAvailable

	| city zone |

	city _ City new.
	city addService: self solarPlant.
	city addService: self waterTower.
	
	zone _ self industrialZone.
	zone setNumberOfCells: 2.
	city addZone: zone.
	
	self assert: 200 - (10 * 2) * wp equals: city waterAvailable.! !

!CityTest methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 10:08:45'!
waterTower

	^ Service withType: #WaterTower! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CityTest class' category: 'ISW1-2021-2C-1erParcial'!
CityTest class
	instanceVariableNames: ''!

!CityTest class methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:22:41'!
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
	instanceVariableNames: 'zones name services'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 20:57:01'!
addService: aService 

	services ifNil: [ services _ OrderedCollection new].
	services add: aService.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:17:50'!
addZone: aZone

	zones ifNil: [ zones _ OrderedCollection new].

	aZone type = #Residential ifTrue: [
		self energyAvailable < (5 * ep) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
		self waterAvailable < (9 * wp) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
	].

	aZone type = #Commertial ifTrue: [
		self energyAvailable < (2 * ep) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
		self waterAvailable < (8 * wp) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
		
		self hasResidentialZones ifFalse: [ self error: City cannotAddCommertialZoneErrorDescription ].
	].

	aZone type = #Industrial ifTrue: [
		self energyAvailable < (10 * ep) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
		self waterAvailable < (10 * wp) ifTrue: [ self error: City cannotAddZoneErrorDescription ].
	].

	zones add: aZone.
! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 21:06:00'!
energyAvailable
	
	^ self energyProduced - self energyConsumption

! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:14:23'!
energyConsumption
	
	| index total |
	
	zones ifNil: [zones _ OrderedCollection new].
	
	index _ 1.
	total _ 0.
	
	[index <= zones size] whileTrue: [ | zone |
		zone _ zones at: index.
		zone type = #Residential ifTrue: [ total _ total + ((5 * ep) * zone getNumberOfCells) ].	
		zone type = #Commertial ifTrue: [ total _ total +((8 * ep) * zone getNumberOfCells) ].	
		zone type = #Industrial ifTrue: [ total _ total + ((10 * ep) * zone getNumberOfCells) ].	
		index := index + 1.
	].

	^ total.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:21:30'!
energyProduced
	
	| index total |
	
	services ifNil: [services _ OrderedCollection new].
	
	index _ 1.
	total _ 0 * ep.
	
	[index <= services size] whileTrue: [ | service |
		service _ services at: index.
		service type = #SolarPlant ifTrue: [ total _ total + (500 * ep)].	
		index := index + 1.
	].

	^ total.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 22:14:26'!
hasResidentialZones

	| index |
	zones ifNil: [ ^ false ].

	index _ 1.
	
	[index <= zones size] whileTrue: [ | zone |
		zone _ zones at: index.
		zone type = #Residential ifTrue: [ ^ true].	
		index := index + 1.
	].

	^ false.
! !

!City methodsFor: 'as yet unclassified' stamp: 'HAW 9/23/2021 11:04:39'!
setName: aName

	name _ aName.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 21:23:24'!
waterAvailable
	
	^ self waterProduced - self waterConsumption.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:15:10'!
waterConsumption
	
	| index total |
	
	zones ifNil: [zones _ OrderedCollection new].
	
	index _ 1.
	total _ 0.
	
	[index <= zones size] whileTrue: [ | zone |
		zone _ zones at: index.
		zone type = #Residential ifTrue: [ total _ total + ((9 * wp) * zone getNumberOfCells) ].	
		zone type = #Commertial ifTrue: [ total _ total + ((2 * wp) * zone getNumberOfCells) ].	
		zone type = #Industrial ifTrue: [ total _ total + ((10 * wp) * zone getNumberOfCells) ].	
		index := index + 1.
	].

	^ total.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/22/2021 19:22:04'!
waterProduced
	| index total |
	
	services ifNil: [services _ OrderedCollection new].
	
	index _ 1.
	total _ 0.
	
	[index <= services size] whileTrue: [ | service |
		service _ services at: index.
		service type = #WaterTower ifTrue: [ total _ total + (200 * wp)].	
		index := index + 1.
	].

	^ total.! !

!City methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 21:43:27'!
zones

	zones ifNil: [ zones _ OrderedCollection new].

	^ zones.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'City class' category: 'ISW1-2021-2C-1erParcial'!
City class
	instanceVariableNames: ''!

!City class methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 22:10:50'!
cannotAddCommertialZoneErrorDescription

	^ 'Cannot add commertial zone without Residential zones'.! !

!City class methodsFor: 'as yet unclassified' stamp: 'FRT 9/16/2021 21:41:32'!
cannotAddZoneErrorDescription

	^ 'Cannot add zone'.! !


!classDefinition: #Service category: 'ISW1-2021-2C-1erParcial'!
Object subclass: #Service
	instanceVariableNames: 'type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!Service methodsFor: 'initialization' stamp: 'HAW 9/23/2021 11:04:53'!
initializeWithType: aServiceType 

	type _ aServiceType.! !


!Service methodsFor: 'accessing' stamp: 'FRT 9/16/2021 20:59:49'!
type
	
	^type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Service class' category: 'ISW1-2021-2C-1erParcial'!
Service class
	instanceVariableNames: ''!

!Service class methodsFor: 'instance creation' stamp: 'FRT 9/16/2021 20:55:41'!
withType: aServiceType

	^self new initializeWithType: aServiceType ! !


!classDefinition: #Zone category: 'ISW1-2021-2C-1erParcial'!
Object subclass: #Zone
	instanceVariableNames: 'type numberOfCells'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2021-2C-1erParcial'!

!Zone methodsFor: 'initialization' stamp: 'FRT 9/16/2021 20:27:04'!
initializeWithType: aZoneType 

	type := aZoneType.! !


!Zone methodsFor: 'accessing' stamp: 'FRT 9/20/2021 17:00:06'!
getNumberOfCells

	numberOfCells ifNil: [ ^ 1].	
	
	^ numberOfCells! !

!Zone methodsFor: 'accessing' stamp: 'HAW 9/23/2021 11:05:04'!
setNumberOfCells: aNumberOfCells
	
	numberOfCells _ aNumberOfCells! !

!Zone methodsFor: 'accessing' stamp: 'FRT 9/16/2021 20:27:43'!
type
	
	^ type! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zone class' category: 'ISW1-2021-2C-1erParcial'!
Zone class
	instanceVariableNames: ''!

!Zone class methodsFor: 'instance creation' stamp: 'FRT 9/16/2021 20:26:23'!
withType: aZoneType 

	^ self new initializeWithType: aZoneType. ! !

CityTest initialize!