!classDefinition: #EscapeDeFlotaTests category: 'ISW-Pto4-1C25'!
TestCase subclass: #EscapeDeFlotaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:02'!
test01LaFlotaDebeTenerAlMenosUnaNave
 
	self 
		should: [ EscapeDeFlota enrolarTacticas: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:30:18'!
test02LaFlotaNoPuedeTenerNavesDuplicadas

	| cruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	
	self 
		should: [ EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. cruceroPesadoConImpulso } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:30:30'!
test03LaRutaDeSectoresARecorrerNoPuedeSerVacia

	| cruceroPesadoConImpulso flota |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	self 
		should: [ flota atravesar: {  } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota rutaVaciaDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:30:41'!
test04CombustibleDeLaNaveDebeSerSuficienteParaAtravesarUnicoSectorPlanetarioYSobrevivir

	| sector flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	flota atravesar: { sector }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: (cruceroPesadoConImpulso valorCombustible: (50 - 10))
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:26:21'!
test05LaRutaDeSectoresARecorrerNoPuedeTenerSectoresRepetidos

	| cruceroPesadoConImpulso flota sector |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	self 
		should: [ flota atravesar: { sector. sector } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota sectoresRepetidosDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:30:54'!
test06NaveQueSeQuedaSinCombustibleMientrasCruzaSectorNoSobrevive

	| flota naveContrabandistaConImpulso |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso sinCombustible.

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConImpulso }.
	
	"Secuencia de 10 sistemas planetarios seguidos con combustible para 9.5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 10 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: naveContrabandistaConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:01'!
test07NavePuedeQuedarseSinCombustiblePeroSobrevivir

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	"Secuencia de 5 sistemas planetarios seguidos... Llega justo!!"
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso sinCombustible.
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:08'!
test08NaveQueSeQuedaSinCombustibleAntesDePasarPorTodosLosSectoresNoSobrevive

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.

	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	"Secuencia de 6 sistemas planetarios seguidos con combustible para 5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:15'!
test09NaveQueAtraviesaSectorConMayorGravedadQueSuManiobravilidadSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).

	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:24'!
test10NaveQueAtraviesaSectorConMayorRadiacionQueSusEscudosDeEnergiaSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:31'!
test11NaveAtravesandoSectorConMayorGravedadYRadiacionQueSuManiobravilidadYEscudosDeEnergiaSufreElDobleDeDaño

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 2).
	
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:39'!
test12NaveQueSufreMasNivelesDeDañoQueLaCapacidadDeSuCascoEsDestruidaYNoSobreviveAlEscape

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso destruida.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso }.
	
	"6 niveles de daño en una clase de naves que sólo admite 5 como máximo..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 70 yRadiacion: 200).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso destruida
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:25:08'!
test13NaveAtravesandoSectorPlanetarioUsandoVelocidadLuzIgnoraRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector planetario utilizando velocidad luz (Warp, Light Speed, Subluminal, FTL: Faster Than Light, o como tu autor de ciencia ficción favorito lo llame), se puede pasar tan rápido que se ignoran los efectos de la radiación"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConVelocidadLuz}.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: (95 - 10)).
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 90 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	
	"El daño proviene aquí de la alta gravedad y no de la radiación..."	
	self assert: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: (95 - 20))
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:25:04'!
test14NaveAtravesandoSectorPlanetarioUsandoGravitonesDecrementaManiobravilidadEn20Porciento

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector planetario utilizando propulsion por gravitones el piloto tiene mayor dificultad en controlar la nave en el sector. 20% de penalización en su maniobravilidad"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConGravitones }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 * 0.8 yRadiacion: 40 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 10).
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: (70 * 0.8) + 1 yRadiacion: 40 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	
	"La gravedad supera la coordinacion del piloto navegando sector planetario con gravitones, luego la nave es dañada"
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 20).

! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:31:54'!
test15NaveAtravesandoSectorDeAsteroidesUsandoImpulsoEstandarReduceSusEscudosDeEnergia

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa un sector de asteroides utilizando el propulsor de impulso estandar, los escudos indefectiblemente reciben el impacto de los asteroides (nada que pueda hacer el piloto con ese tipo de propulsores) y se reducen permanentemente en 20"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConImpulso}.
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 35 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50 - 20).
	
	"La nave sufre daño porque los escudos de energia descendieron por debajo de la radiacion del sector"
	self assert: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 1).
	
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:24:54'!
test16NaveAtravesandoSectorDeAsteroidesUsandoVelocidadLuzAgotaSusEscudosACeroYSufreDaños

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector de asteroides utilizando velocidad luz, vas derecho al desastre... quien sea que haya trazado ese curso estará condenado, porque irá en linea recta contra un cinturón de asteroides a la velocidad de la luz (duh!!). En terminos prácticos, la nave pierde todos sus escudos de energía permanentemente (pasan a 0) debido a los impactos con los asteroides, se le inflinje 1 nivel de daño al casco y además casi seguro se le suma otro nivel más por radiación al esta no contar más con sus escudos"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50).
	
	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 30 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	
	"Usar Velocidad Luz con asteroides acaba con los escudos y suma 1 nivel de daño al casco".
	"La radición daña adicionalmente al casco de la nave ya que sus escudos se reducen a 0"
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 0).
	self assert: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1 + 1).
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:24:49'!
test17NaveAtravesandoSectorDeAsteroidesUsandoGravitonesIgnoraGravedadPeroConsumeElDobleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector de asteroides utilizando el avanzado sistema de propulsores basado en Gravitones, el piloto automático de la nave puede sin problema eludirlos sin impactos. Como el piloto no participa, no se tiene en cuenta el rating de maniobrabilidad de la nave, ni la gravedad del sector"
	
	"Al mismo tiempo, lamentablemente el sistema consume el doble de combustible que lo normal"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	
	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConGravitones}.
	
	"La alta gravedad no son nada para el sistema avanzado de propulsores de Gravitones"
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 90 yRadiacion: 30 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	"Doble gasto de combustible"
	self assert: (naveContrabandistaConGravitones valorCombustible: (95 - 20)).

	"La radiación del sector es la que produce el daño (60 supera a los 50 de los escudos de la nave) y no la gravedad..."
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 90 yRadiacion: 60 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	"Doble gasto de combustible"
	self assert: (naveContrabandistaConGravitones valorCombustible: (95 - 40))
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:47:00'!
test18NaveAtravesandoSectorNebulosaUsandoImpulsoEstandarDecrementaEscudosAl30Porciento

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa una nebulosa con propulsores de impulso estandar, se esta mucho tiempo dentro de la misma y los escudos empiezan a perder efectividad. 30% de penalizacion a los escudos mientras se la cruza"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar .
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso valorCombustible: 95).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConImpulso }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 50 yRadiacion: 50 * 0.7 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso valorCombustible: 95 - 10).


	flota atravesar: { self nuevoSectorNebulosaConGravedad: 50 yRadiacion: (50 * 0.7) + 1}.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	"La radiación supera el desgaste extremo de los escudos, y por lo tanto la nave es dañada"
	self assert: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConImpulso valorCombustible: 95 - 20).
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:24:39'!
test19NaveAtravesandoSectorNebulosaUsandoVelocidadLuzNoConsumeCombustibleEIgnoraGravedadYRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se viaja hacia una nebulosa utilizando velocidad luz, el modulo Warp se revigoriza por un efecto cuántico bien conocido por el contacto con los gases de la nébula, y casi la teletransporta de inmediato al próximo sector galáctico de la trayectoria del viaje. Luego no se consume combustible, y no se efectua ninguno de los chequeos típicos de supervivencia en el sector"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:24:34'!
test20NaveAtravesandoSectorNebulosaUsandoGravitonesEsAfectadaPorGravedadYRadiacionNormalmentePeroConsumientoElTripleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"La nebulosa afecta los propulsores de gravitones haciendolos menos eficientes. Consume 3 veces el valor de combustible normal sin ningun otro beneficio"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones .
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConGravitones }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 70 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 30).

	flota atravesar: { self nuevoSectorNebulosaConGravedad: 71 yRadiacion: 51 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 2).
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 60)! !


!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:15:40'!
nuevaNaveContrabandistaConGravitones

	^ NaveTactica naveContrabandistaConPropulsores: self propulsoresDeGravitones ! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:15:45'!
nuevaNaveContrabandistaConImpulsoEstandar

	^ NaveTactica naveContrabandistaConPropulsores: self propulsoresDeImpulsoEstandar! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:17:00'!
nuevaNaveContrabandistaConVelocidadLuz

	^ NaveTactica naveContrabandistaConPropulsores: self propulsoresDeVelocidadLuz! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:15:49'!
nuevoCruceroPesadoConImpulsoEstandar

	^ NaveTactica cruceroPesadoConPropulsores: self propulsoresDeImpulsoEstandar! !


!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/12/2025 07:39:15'!
nuevoSectorDeAsteroidesConGravedad: gravity yRadiacion: radiation

	^ Asteroides gravedad: gravity yRadiacion: radiation ! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/12/2025 07:39:18'!
nuevoSectorNebulosaConGravedad: gravity yRadiacion: radiation

	^ Nebulosa gravedad: gravity yRadiacion: radiation ! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/12/2025 07:39:22'!
nuevoSectorPlanetarioConGravedad: gravity yRadiacion: radiation

	^ Planetario gravedad: gravity yRadiacion: radiation
! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/12/2025 07:39:26'!
nuevoTrayectoDeSectoresPlanetariosDeLongitud: numberOfSectors conGravedad: gravity yRadiacion: radiation 

	^ (1 to: numberOfSectors) collect: [ :sectorNumber | self nuevoSectorPlanetarioConGravedad: gravity yRadiacion: radiation ]
	! !


!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/11/2025 05:37:51'!
propulsoresDeGravitones

	^ Gravitones new! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/11/2025 05:37:43'!
propulsoresDeImpulsoEstandar

	^ ImpulsoEstandar new! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/11/2025 16:48:44'!
propulsoresDeVelocidadLuz

	^ VelocidadLuz new! !


!classDefinition: #NaveNodrizaTests category: 'ISW-Pto4-1C25'!
TestCase subclass: #NaveNodrizaTests
	instanceVariableNames: 'proximosRandoms'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!NaveNodrizaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 07:23:50'!
nuevoTrayectoDeSectores: tipoSector DeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion 

	^ (1 to: numeroDeSectores) collect: [ :numeroDeSector | tipoSector gravedad: gravedad yRadiacion: radiacion ]! !

!NaveNodrizaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 07:24:37'!
nuevoTrayectoDeSectoresNebulososDeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion 

	^ self nuevoTrayectoDeSectores: Nebulosa DeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion ! !

!NaveNodrizaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 07:25:01'!
nuevoTrayectoDeSectoresPlanetariosDeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion 

	^ self nuevoTrayectoDeSectores: Planetario DeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion ! !


!NaveNodrizaTests methodsFor: 'simular aleatoriedad' stamp: 'NR 7/15/2025 23:39:16'!
nextInteger: limite

	| proximo |
	
	self deny: proximosRandoms atEnd.
	proximo := proximosRandoms next.
	self deny: proximo > limite.
	
	^  proximo! !


!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/15/2025 08:45:56'!
setUp

	proximosRandoms :=  ReadStream on: ((1 to: 100) collect: [ :i | 1 ]).! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/15/2025 08:37:55'!
test01NaveNodrizaVaciaSeComportaComoCualquierOtraNave

	| flota cruceroPesadoConImpulso naveNodrizaConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar .
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	self deny: cruceroPesadoConImpulso dañada.
	self deny: naveNodrizaConImpulso dañada.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).	
	self assert: (naveNodrizaConImpulso valorCombustible: 200).

	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 100  yRadiacion: 100 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 2).
	
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).
	self assert: (cruceroPesadoConImpulso valorCombustible: 50 - 10).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	self assert: naveNodrizaConImpulso dañada.
	self assert: (naveNodrizaConImpulso nivelDeDañoEs: 2).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 10)
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/21/2025 20:13:11'!
test02NaveSinCombustibleAtracadaSobrevive

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar .
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).	
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/21/2025 20:13:36'!
test03NumeroDeSobrevivientesEsCorrectoConNavesAtracadasEnNodrizas

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso otroCruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 3).
	
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: otroCruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 08:49:50'!
test04NaveNodrizaNoAtracaNaveSinCombustibleEnSectorSiNoTieneSuficienteCapacidadLibre

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 3).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: otroCruceroPesadoConImpulso).
	
	self deny: (flota haSobrevivido: yOtroCruceroPesadoMas).! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/21/2025 06:40:51'!
test05NaveNodrizaNoAtracaNaveSinCombustibleDestruidaEnSector

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 100 yRadiacion: 200).
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 200 }.
		
	self assert: (flota numeroDeSobrevivientesEs: 1).
	
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 08:53:43'!
test06LaEleccionDeQueNaveAtracarPrimeroEsEquiprobable

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	proximosRandoms := ReadStream on: #(3 1 1 1).
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 3).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	self assert: (flota haSobrevivido: yOtroCruceroPesadoMas).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	
	self deny: (flota haSobrevivido: otroCruceroPesadoConImpulso).! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 08:53:38'!
test07AlAcabarseCapacidadDeNaveNodrizaSePasaALaProxima

	| flota naveNodrizaConImpulsoCap2 naveNodrizaConImpulsoCap5 cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoCap2 :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaConImpulsoCap5 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 5.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulsoCap2. naveNodrizaConImpulsoCap5 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 5).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoCap2).
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoCap5).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: otroCruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: yOtroCruceroPesadoMas).
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 08:53:33'!
test08LasNavesNodrizasDeMenorCapacidadSeOcupanPrimero

	| flota naveNodrizaConImpulsoCap2 naveNodrizaConImpulsoCap5 cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoCap2 := self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaConImpulsoCap5 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 5.
	
	self deny: (naveNodrizaConImpulsoCap2 tieneAtracada: cruceroPesadoConImpulso).
	self deny: (naveNodrizaConImpulsoCap2 tieneAtracada: otroCruceroPesadoConImpulso).
	self deny: (naveNodrizaConImpulsoCap5 tieneAtracada: yOtroCruceroPesadoMas).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulsoCap5. naveNodrizaConImpulsoCap2 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 5).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoCap2).
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoCap5).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: otroCruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: yOtroCruceroPesadoMas).
	
	self assert: (naveNodrizaConImpulsoCap2 tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulsoCap2 tieneAtracada: otroCruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulsoCap5 tieneAtracada: yOtroCruceroPesadoMas)
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 08:53:29'!
test09LasNavesNodrizasDeMenorCombustibleSeOcupanPrimeroAIgualCapacidad

	| flota naveNodrizaConImpulsoComb100 naveNodrizaConImpulsoComb200 cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoComb100 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 100 nivelesDeDaño: 10 capacidad: 2.
	naveNodrizaConImpulsoComb200 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 2.
	
	self deny: (naveNodrizaConImpulsoComb100 tieneAtracada: cruceroPesadoConImpulso).
	self deny: (naveNodrizaConImpulsoComb100 tieneAtracada: otroCruceroPesadoConImpulso).
	self deny: (naveNodrizaConImpulsoComb200 tieneAtracada: yOtroCruceroPesadoMas).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulsoComb200. naveNodrizaConImpulsoComb100 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 5).
	
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoComb100).
	self assert: (flota haSobrevivido: naveNodrizaConImpulsoComb200).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: otroCruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: yOtroCruceroPesadoMas).
	
	self assert: (naveNodrizaConImpulsoComb100 tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulsoComb100 tieneAtracada: otroCruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulsoComb200 tieneAtracada: yOtroCruceroPesadoMas)
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:35'!
test10NaveNodrizaNoAtracaNavesSiEllaSeQuedaSinCombustible

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50  combustible: 50 nivelesDeDaño:  10 capacidad: 2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 100 yRadiacion: 200).
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10 yRadiacion: 10).

	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 0).
	self deny: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso)
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:40'!
test11LasNavesAtracadasSonReabastecidasDeCombustible

	| flota naveNodrizaConImpulsoCap2 naveNodrizaConImpulsoCap5 cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoCap2 :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaConImpulsoCap5 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 5.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulsoCap5. naveNodrizaConImpulsoCap2 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 0).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 0).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 20).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 20).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 20)
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:43'!
test12LasNavesAtracadasSonReabastecidasDeCombustibleMientrasDisminuyeDeLasNodrizas

	| flota naveNodrizaConImpulsoCap2 naveNodrizaConImpulsoCap5 cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoCap2 :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaConImpulsoCap5 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 5.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulsoCap5. naveNodrizaConImpulsoCap2 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 0).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 0).
	self assert: (naveNodrizaConImpulsoCap2 valorCombustible: 200 - 50).
	self assert: (naveNodrizaConImpulsoCap5 valorCombustible: 200 - 50).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 20).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 20).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 20).
	self assert: (naveNodrizaConImpulsoCap2 valorCombustible: 200 - 70 - 40).
	self assert: (naveNodrizaConImpulsoCap5 valorCombustible: 200 - 70 - 20).
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:47'!
test13LasNavesReabastecidasNoSuperanSuMaximoValorDeCombustible

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	self deny: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 50).
	self assert: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10 yRadiacion: 10).
	
	self deny: (cruceroPesadoConImpulso valorCombustible: 60).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 110 - 50).
	
	
	
	
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:52'!
test14TodasLasNavesDejanDeSerReabastecidasSiNoAlcanzaCombustibleParaReabastecerlasATodas

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso otroCruceroPesadoConImpulso yOtroCruceroPesadoMas |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	yOtroCruceroPesadoMas := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 5.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso. yOtroCruceroPesadoMas } enrolarNodrizas: { naveNodrizaConImpulso  } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 0).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 50).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 30).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 30).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 30).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 80 - 90).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 30).
	self assert: (otroCruceroPesadoConImpulso valorCombustible: 30).
	self assert: (yOtroCruceroPesadoMas valorCombustible: 30).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 90 - 90)
	
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:55'!
test15LasNavesReabastecidasSeReincorporanALaFlotaExteriorSobreviviendo

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	self deny: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 50).
	self assert: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 10 yRadiacion: 10).
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 100 - 50).
	self assert: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	flota atravesar: { Planetario gravedad: 10  yRadiacion: 10 }.
	
	self assert: (cruceroPesadoConImpulso valorCombustible: 40).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 110 - 50).
	self deny: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:44:58'!
test16NaveNodrizaSinCombustiblePuedeAtracarEnOtraNaveNodrizaConCombustible

	| flota naveNodrizaConImpulso naveNodrizaConImpulsoComb30 |
	
	naveNodrizaConImpulsoComb30 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 30 nivelesDeDaño: 10 capacidad: 2.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: {  } enrolarNodrizas: { naveNodrizaConImpulso. naveNodrizaConImpulsoComb30 } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10  yRadiacion: 10).
	
	self assert: (naveNodrizaConImpulsoComb30 valorCombustible: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 30).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulsoComb30)! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:01'!
test17NaveNodrizaAtracadaNoReabasteceSusNavesPeroSiLasRepara

	| flota naveNodrizaConImpulso naveNodrizaConImpulsoComb31 naveConVeloLuzComb20 |
	
	"La parte de reparar naves, forma parte de lo opcional"
	
	naveConVeloLuzComb20 := NaveTactica naveExploradorCortoAlcanceConPropulsores: VelocidadLuz new.
	naveNodrizaConImpulsoComb31 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 31 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { naveConVeloLuzComb20 } enrolarNodrizas: { naveNodrizaConImpulso. naveNodrizaConImpulsoComb31 } randomizandoCon: self.
	
	flota atravesar: { Asteroides gravedad: 100 yRadiacion: 100. Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 0).
	self assert: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 3).
	self assert: (naveNodrizaConImpulsoComb31 tieneAtracada: naveConVeloLuzComb20).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 10).
	self assert: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 2).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulsoComb31).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10  yRadiacion: 10).
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 10).
	self deny: naveConVeloLuzComb20 dañada.
	self assert: (naveNodrizaConImpulsoComb31 tieneAtracada: naveConVeloLuzComb20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulsoComb31)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:05'!
test18NaveNodrizaReabastecidaYReparadaPuedeAtracarOtraNave

	| flota naveNodrizaConImpulso naveNodrizaConImpulsoComb20 cruceroPesadoConImpulso |
	
	"La reparación es parte de lo opcional"
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulsoComb20 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 20 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso := self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso. naveNodrizaConImpulsoComb20 } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 200. Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveNodrizaConImpulsoComb20 valorCombustible: 0).
	self assert: naveNodrizaConImpulsoComb20 dañada.
	self assert: (naveNodrizaConImpulsoComb20 nivelDeDañoEs: 2).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulsoComb20).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10  yRadiacion: 10).
	
	self assert: (naveNodrizaConImpulsoComb20 valorCombustible: 10).
	self deny: naveNodrizaConImpulsoComb20 dañada.
	self assert: (naveNodrizaConImpulsoComb20 nivelDeDañoEs: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 50 - 20).
	self deny: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulsoComb20).
	self assert: (naveNodrizaConImpulsoComb20 tieneAtracada: cruceroPesadoConImpulso)
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:08'!
test19NaveNodrizaConNavesAtracadasOcupaLosLugaresDeEllaYSusNavesParaOtrasNavesNodrizas

	| flota naveNodrizaConImpulsoCap1 naveNodrizaConImpulsoComb31Cap1 naveConVeloLuzComb20 otraNaveNodrizaConImpulsoCap1 |
	
	naveConVeloLuzComb20 := NaveTactica naveExploradorCortoAlcanceConPropulsores: VelocidadLuz new.
	naveNodrizaConImpulsoComb31Cap1 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 31 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulsoCap1 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 200 nivelesDeDaño: 10 capacidad: 1.
	otraNaveNodrizaConImpulsoCap1 :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 200 nivelesDeDaño: 10 capacidad: 1.
	
	flota := EscapeDeFlota enrolarTacticas: { naveConVeloLuzComb20 } enrolarNodrizas: { naveNodrizaConImpulsoCap1. otraNaveNodrizaConImpulsoCap1. naveNodrizaConImpulsoComb31Cap1 } randomizandoCon: self.
	
	flota atravesar: { Asteroides gravedad: 100 yRadiacion: 100. Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveNodrizaConImpulsoComb31Cap1 tieneAtracada: naveConVeloLuzComb20).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 10).
	self assert: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 2).
	self deny: (naveNodrizaConImpulsoCap1 tieneAtracada: naveNodrizaConImpulsoComb31Cap1).
	self deny: (naveNodrizaConImpulsoCap1 tieneAtracada: naveNodrizaConImpulsoComb31Cap1)! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:12'!
test20NaveNodrizaConNavesAtracadasEnPrimerNivelAfectaASuManiobravilidadCorrectamente

	| flota cruceroPesadoConImpulso naveNodrizaPrincipal naveNodrizaSecundaria |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaPrincipal :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaSecundaria :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso  } enrolarNodrizas: { naveNodrizaSecundaria } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 200 }.
	
	naveNodrizaPrincipal atracar: cruceroPesadoConImpulso.
	naveNodrizaPrincipal atracar: naveNodrizaSecundaria.
	
	flota := EscapeDeFlota enrolarTacticas: {  } enrolarNodrizas: { naveNodrizaPrincipal } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 50 - 3 yRadiacion: 50 }.
	
	self deny: naveNodrizaPrincipal dañada.
	
	flota atravesar: { Planetario gravedad: 50 - 3 + 1 yRadiacion: 50 }.
	
	self assert: naveNodrizaPrincipal dañada.
	self assert: (naveNodrizaPrincipal nivelDeDañoEs: 1)! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:16'!
test21NaveNodrizaConNavesAtracadasEnMasDeUnNivelAfectaASuManiobravilidadCorrectamente

	| flota cruceroPesadoConImpulso naveNodrizaPrincipal naveNodrizaSecundaria naveNodrizaTerciaria otroCruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaPrincipal :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaSecundaria :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	naveNodrizaTerciaria :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaSecundaria. naveNodrizaTerciaria } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 200 }.
	
	naveNodrizaPrincipal atracar: cruceroPesadoConImpulso.
	naveNodrizaPrincipal atracar: naveNodrizaSecundaria.
	naveNodrizaSecundaria atracar: otroCruceroPesadoConImpulso.
	naveNodrizaSecundaria atracar: naveNodrizaTerciaria.
	
	flota := EscapeDeFlota enrolarTacticas: {  } enrolarNodrizas: { naveNodrizaPrincipal } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 50 - 9 yRadiacion: 50 }.
	
	self deny: naveNodrizaPrincipal dañada.
	
	flota atravesar: { Planetario gravedad: 50 - 9 + 1 yRadiacion: 50 }.
	
	self assert: naveNodrizaPrincipal dañada.
	self assert: (naveNodrizaPrincipal nivelDeDañoEs: 1)! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:19'!
test22NaveNodrizaConNavesAtracadasEnMasDeUnNivelAfectaASusEscudosCorrectamente

	| flota cruceroPesadoConImpulso naveNodrizaPrincipal naveNodrizaSecundaria naveNodrizaTerciaria otroCruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	otroCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaPrincipal :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 200 combustible: 200 nivelesDeDaño: 10 capacidad: 10.
	naveNodrizaSecundaria :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 200 combustible: 200 nivelesDeDaño: 10 capacidad: 2.
	naveNodrizaTerciaria :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 200 combustible: 200 nivelesDeDaño: 10 capacidad: 2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso. otroCruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaSecundaria. naveNodrizaTerciaria } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 200 }.
	
	naveNodrizaPrincipal atracar: cruceroPesadoConImpulso.
	naveNodrizaPrincipal atracar: naveNodrizaSecundaria.
	naveNodrizaSecundaria atracar: otroCruceroPesadoConImpulso.
	naveNodrizaSecundaria atracar: naveNodrizaTerciaria.
	
	"216"
	naveNodrizaPrincipal fuerzaDeEscudosEn: 
	200 + 
		((0.05 * 100) + 
		(0.05 * 
			(200 + 
				((0.05 * 100) + 
				(0.05 * 200)) rounded
			)
		)) rounded.
	
	"Esta siguiente parte es importante, o podriamos olvidarnos de que el #atravesar use el método escudo, en vez del colaborador interno directamente..."
	
	flota := EscapeDeFlota enrolarTacticas: {  } enrolarNodrizas: { naveNodrizaPrincipal } randomizandoCon: self.
	
	flota atravesar: { Planetario gravedad: 50 - 9 yRadiacion: 216 }.
	
	self deny: naveNodrizaPrincipal dañada.
	
	flota atravesar: { Planetario gravedad: 50 - 9 + 1 yRadiacion: 216 + 1 }.
	
	self assert: naveNodrizaPrincipal dañada.
	self assert: (naveNodrizaPrincipal nivelDeDañoEs: 1)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:22'!
test23SobrevivenLasNavesAtracadasDentroDeNavesNodrizasAtracadasEnNaveNodrizaSobreviviente

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso naveNodrizaConImpulso60Comb naveNodrizaConImpulso70Comb |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso60Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 60 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso70Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 70 nivelesDeDaño: 10 capacidad: 2.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 200 nivelesDeDaño: 10 capacidad: 3.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso. naveNodrizaConImpulso60Comb. naveNodrizaConImpulso70Comb } randomizandoCon: self.
	
	flota atravesar: ( self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 7 conGravedad: 10  yRadiacion: 10 ).
	
	self assert: (naveNodrizaConImpulso60Comb tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso70Comb tieneAtracada: naveNodrizaConImpulso60Comb).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulso70Comb).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso60Comb).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso70Comb).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso)
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:26'!
test24NumeroDeSobrevivientesEsCorrectoCuandoSobrevivenLasNavesAtracadasDentroDeNavesNodrizasAtracadasEnNaveNodrizaSobreviviente

	| flota naveNodrizaConImpulso cruceroPesadoConImpulso naveNodrizaConImpulso60Comb naveNodrizaConImpulso70Comb |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso60Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 60 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso70Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 70 nivelesDeDaño: 10 capacidad: 2.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 200 nivelesDeDaño: 10 capacidad: 3.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso. naveNodrizaConImpulso60Comb. naveNodrizaConImpulso70Comb } randomizandoCon: self.
	
	flota atravesar: ( self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 7 conGravedad: 10  yRadiacion: 10 ).
	
	self assert: (naveNodrizaConImpulso60Comb tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso70Comb tieneAtracada: naveNodrizaConImpulso60Comb).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulso70Comb).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso60Comb).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso70Comb).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	
	self assert: (flota numeroDeSobrevivientesEs: 4)
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:30'!
test25NoSobrevivenLasNavesAtracadasDentroDeNavesNodrizasQueNoSobreviven

	| flota cruceroPesadoConImpulso naveNodrizaConImpulso60Comb naveNodrizaConImpulso70Comb |
	
	"Este test pasa de entrada usando TDD, pero lo dejo defensivamente y por completitud de testing..."
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso60Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 60 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso70Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 70 nivelesDeDaño: 10 capacidad: 2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso60Comb. naveNodrizaConImpulso70Comb } randomizandoCon: self.
	
	flota atravesar: ( self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 8 conGravedad: 10  yRadiacion: 10 ).
	
	self assert: (naveNodrizaConImpulso60Comb tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso70Comb tieneAtracada: naveNodrizaConImpulso60Comb).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self deny: (flota haSobrevivido: naveNodrizaConImpulso60Comb).
	self deny: (flota haSobrevivido: naveNodrizaConImpulso70Comb).
	
	self assert: (flota numeroDeSobrevivientesEs: 0). 
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:34'!
test26LaFlotaAunDebeTenerAlMenosUnaNave
	
	self 
		should: [ EscapeDeFlota enrolarTacticas: { } enrolarNodrizas: {  } randomizandoCon: self ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:37'!
test27LaFlotaAunNoPuedeTenerNavesDuplicadas

	| naveNodriza |
	
	naveNodriza := self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	self 
		should: [ EscapeDeFlota enrolarTacticas: {} enrolarNodrizas: { naveNodriza. naveNodriza } randomizandoCon: self ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:40'!
test28LaNavesTacticasNoPuedenEnrolarseComoNodrizas

	| naveTactica |
	
	naveTactica := self nuevoCruceroPesadoConImpulsoEstandar.
	
	self 
		should: [ EscapeDeFlota enrolarTacticas: {} enrolarNodrizas: { naveTactica } randomizandoCon: self ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota naveNodrizaNoPuedeSerTacticaDescripcionDeError ! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:43'!
test29NaveNodrizaNoPuedeCrearseDeCapacidadCero

	self 
		should: [ NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 0 ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: NaveNodriza nodrizaSinHangarDescripcionDeError ! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:47'!
test_OPCIONAL_01LasNavesAtracadasSonReparadasDeDaños

	| flota naveNodrizaConImpulso naveContrabandistaConGravitones |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	naveNodrizaConImpulso := self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConGravitones } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresNebulososDeLongitud: 2 conGravedad: 10 yRadiacion: 51).
	
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 60).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 2).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 20).
	
	flota atravesar: (self nuevoTrayectoDeSectoresNebulososDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	
	self assert: (naveContrabandistaConGravitones sinCombustible).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 2).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 40).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveContrabandistaConGravitones).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveContrabandistaConGravitones valorCombustible: 10).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveContrabandistaConGravitones valorCombustible: 20).
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 60 - 20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveContrabandistaConGravitones).
	
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones)
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:50'!
test_OPCIONAL_02LasNavesAtracadasReparadasNoPuedenQuedarEnNivelesDeDañoNegativos

	| flota naveNodrizaConImpulso naveContrabandistaConGravitones |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { naveContrabandistaConGravitones } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	"Mismo trayecto test anterior"
	flota atravesar: (self nuevoTrayectoDeSectoresNebulososDeLongitud: 2 conGravedad: 10 yRadiacion: 51).
	flota atravesar: (self nuevoTrayectoDeSectoresNebulososDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 10 yRadiacion: 10).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10 }.
	self assert: (naveContrabandistaConGravitones valorCombustible: 30).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 70 - 30).
	self deny: naveContrabandistaConGravitones dañada.
	self deny: (naveContrabandistaConGravitones nivelDeDañoEs: -1).
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 0).
	
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones)
	
	
	
	
	
	
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:45:55'!
test_OPCIONAL_03LasNavesReabastecidadsDebenEstarLibresDeDañoAntesDeReincorporarseALaFlota

	| flota naveNodrizaConImpulso naveConVeloLuzComb20 |
	
	"Nave diseñada para el test :)"
	"Nave Explorador Corto -> Maniobravilidad: 20. Escudos: 20. Combustible: 20. NivelesDeDañoCasco: 4."
	naveConVeloLuzComb20 := NaveTactica naveExploradorCortoAlcanceConPropulsores: VelocidadLuz new.
	naveNodrizaConImpulso :=  self nuevaNaveNodrizaConImpulsoYCapacidad2.
	
	flota := EscapeDeFlota enrolarTacticas: { naveConVeloLuzComb20 } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: { Asteroides gravedad: 100 yRadiacion: 100. Planetario gravedad: 10 yRadiacion: 10 }.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 0).
	self assert: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 3).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveConVeloLuzComb20).
	
	flota atravesar: ( self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 2 conGravedad: 10  yRadiacion: 10 ).
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 20).
	self assert: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 1).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 40 - 20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveConVeloLuzComb20).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10}.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 20).
	self deny: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 50 - 20).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveConVeloLuzComb20).
	
	flota atravesar: { Planetario gravedad: 10 yRadiacion: 10}.
	
	self assert: (naveConVeloLuzComb20 valorCombustible: 10).
	self deny: naveConVeloLuzComb20 dañada.
	self assert: (naveConVeloLuzComb20 nivelDeDañoEs: 0).
	self assert: (naveNodrizaConImpulso valorCombustible: 200 - 60 - 20).
	self deny: (naveNodrizaConImpulso tieneAtracada: naveConVeloLuzComb20)
	
	
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:46:01'!
test_OPCIONAL_04SonDestruidasLasNavesAtracadasDentroDeNavesNodrizasQueSonDestruidas

	| flota cruceroPesadoConImpulso naveNodrizaConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 1 capacidad: 2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10  yRadiacion: 10).
	
	self assert: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 100 }.
	
	self assert: (naveNodrizaConImpulso tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso destruida).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self deny: (flota haSobrevivido: naveNodrizaConImpulso).
	
	self assert: (cruceroPesadoConImpulso destruida)
	
	
	
	
	
	! !

!NaveNodrizaTests methodsFor: 'tests' stamp: 'NR 7/22/2025 19:46:05'!
test_OPCIONAL_05SonDestruidasLasNavesAtracadasDentroDeNavesNodrizasAtracadasEnNavesNodrizasQueSonDestruidasRecursivamente

	| flota cruceroPesadoConImpulso naveNodrizaConImpulso60Comb naveNodrizaConImpulso |
	
	"Este test pasa de entrada usando TDD, pero lo dejo de ejemplo y por completitud de testing..."
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	naveNodrizaConImpulso60Comb :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 100 combustible: 60 nivelesDeDaño: 10 capacidad: 1.
	naveNodrizaConImpulso :=  NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 1 capacidad: 2.
	
	flota := EscapeDeFlota enrolarTacticas: { cruceroPesadoConImpulso } enrolarNodrizas: { naveNodrizaConImpulso60Comb. naveNodrizaConImpulso } randomizandoCon: self.
	
	flota atravesar: ( self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 10  yRadiacion: 10 ).
	
	self assert: (naveNodrizaConImpulso60Comb tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulso60Comb).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso60Comb).
	self assert: (flota haSobrevivido: naveNodrizaConImpulso).
	
	flota atravesar: { Planetario gravedad: 100 yRadiacion: 100 }.
	
	self assert: (naveNodrizaConImpulso60Comb tieneAtracada: cruceroPesadoConImpulso).
	self assert: (naveNodrizaConImpulso tieneAtracada: naveNodrizaConImpulso60Comb).
	self assert: (naveNodrizaConImpulso destruida).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self deny: (flota haSobrevivido: naveNodrizaConImpulso60Comb).
	self deny: (flota haSobrevivido: naveNodrizaConImpulso).
	
	self assert: (naveNodrizaConImpulso60Comb destruida)	.
	self assert: (cruceroPesadoConImpulso destruida)
	! !


!NaveNodrizaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:15:56'!
nuevaNaveContrabandistaConGravitones

	^ NaveTactica naveContrabandistaConPropulsores: Gravitones new! !

!NaveNodrizaTests methodsFor: 'naves' stamp: 'NR 7/15/2025 06:20:18'!
nuevaNaveNodrizaConImpulsoYCapacidad2

	^ NaveNodriza conPropulsores: ImpulsoEstandar new maniobravilidad: 50 escudos: 50 combustible: 200 nivelesDeDaño: 10 capacidad: 2! !

!NaveNodrizaTests methodsFor: 'naves' stamp: 'NR 7/14/2025 05:16:00'!
nuevoCruceroPesadoConImpulsoEstandar

	^ NaveTactica cruceroPesadoConPropulsores: ImpulsoEstandar new! !


!classDefinition: #EscapeDeFlota category: 'ISW-Pto4-1C25'!
Object subclass: #EscapeDeFlota
	instanceVariableNames: 'flota nodrizasAunConCombustibleOrdenadas conjuntoNodrizasOriginal randomizador'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!EscapeDeFlota methodsFor: 'initialization' stamp: 'NR 7/15/2025 23:36:59'!
initializeEnrolamiento: unaFlota 
	
	flota := unaFlota.
	nodrizasAunConCombustibleOrdenadas := {}.
	conjuntoNodrizasOriginal := {}! !

!EscapeDeFlota methodsFor: 'initialization' stamp: 'NR 7/15/2025 23:36:41'!
initializeEnrolamiento: unaFlota conSoporteDeNodrizas: unaFlotaNodrizas yRandomizandoCon: unRandomizador 
	
	flota := unaFlota.
	nodrizasAunConCombustibleOrdenadas := unaFlotaNodrizas asSortedCollection: self ordenDeNavesNodrizas.
	conjuntoNodrizasOriginal := unaFlotaNodrizas asSet.
	randomizador := unRandomizador
	! !

!EscapeDeFlota methodsFor: 'initialization' stamp: 'NR 7/14/2025 05:34:32'!
ordenDeNavesNodrizas

	^ [ :naveNodriza1 :naveNodriza2 | naveNodriza1 capacidadTotal < naveNodriza2 capacidadTotal or: ([ naveNodriza1 capacidadTotal = naveNodriza2 capacidadTotal and: [ naveNodriza1 combustible < naveNodriza2 combustible ] ]) ]! !


!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/18/2025 06:42:11'!
haSobrevivido: nave

	^ (flota includes: nave) or: [ self naveAtracadaDentroDeOtraNaveSobreviviente: nave ]! !

!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/18/2025 06:42:11'!
naveAtracadaDentroDeOtraNaveSobreviviente: nave

	^ flota anySatisfy: [ :naveSobreviviente | naveSobreviviente tieneAtracada: nave ]! !

!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/18/2025 06:43:47'!
numeroDeSobrevivientesEs: tamañoDeFlota 
	
	| numeroAtracadas |
	
	numeroAtracadas := flota sum: [ :naveSobreviviente | naveSobreviviente numeroNavesAtracadas ] ifEmpty: [ 0 ].

	^ (flota size + numeroAtracadas) = tamañoDeFlota ! !


!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/14/2025 07:52:19'!
desatracarNavesReabastecidasYReparadas

	| navesReabastecidas |
	
	navesReabastecidas := OrderedCollection new.
	nodrizasAunConCombustibleOrdenadas do: [ :naveNodriza | navesReabastecidas addAll: naveNodriza desatracarNavesReabastecidasYReparadas ].
	
	^ navesReabastecidas
	
	! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/18/2025 08:26:54'!
intentarAtracarNaveEnFlotaNodriza: nave

	| naveNodrizaConCapacidad |
	
	naveNodrizaConCapacidad := nodrizasAunConCombustibleOrdenadas detect: [ :naveNodriza | naveNodriza tieneEspacioLibrePara: nave ] ifNone: [ ^ self ].
	naveNodrizaConCapacidad atracar: nave.
	flota remove: nave! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/18/2025 08:24:10'!
nodrizasAunOperativas

	^ nodrizasAunConCombustibleOrdenadas reject: [ :nodriza | nodriza sinCombustible ]! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/15/2025 10:07:29'!
reincorporarNavesOperativasAFlota: navesReabastecidas

	flota addAll: navesReabastecidas.
	nodrizasAunConCombustibleOrdenadas addAll: (navesReabastecidas select: [ :nave | conjuntoNodrizasOriginal includes: nave ])! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/18/2025 08:17:48'!
rescatable: nave

	^ nave destruida not and: [ nave sinCombustible ]! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/18/2025 08:25:07'!
rescatarNavesDeFormaEquiprobable: navesRescatables
	
	navesRescatables size timesRepeat: [ | indiceDeNaveARescatar |
		
		indiceDeNaveARescatar := randomizador nextInteger: navesRescatables size.
		self intentarAtracarNaveEnFlotaNodriza: (navesRescatables at: indiceDeNaveARescatar).
		navesRescatables removeAt: indiceDeNaveARescatar
	 
	]! !

!EscapeDeFlota methodsFor: 'salvataje nodrizas' stamp: 'NR 7/18/2025 08:30:15'!
rescatarNavesNoDestruidasSinCombustible
	
	| navesRescatables |
	
	nodrizasAunConCombustibleOrdenadas := self nodrizasAunOperativas.
	navesRescatables := flota select: [ :nave | self rescatable: nave ].
	
	( navesRescatables notEmpty and: [ nodrizasAunConCombustibleOrdenadas notEmpty]) ifTrue: [ self rescatarNavesDeFormaEquiprobable: navesRescatables ]
	
	
	! !


!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 21:22:25'!
atravesar: sectores 
	
	self assertSectoresNoVacios: sectores.
	self assertSinSectoresRepetidos: sectores.
	
	sectores do: [ :sector | self atravesarFlotaPorSector: sector]! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 8/2/2025 17:49:43'!
atravesarFlotaPorSector: sector

	self reincorporarNavesOperativasAFlota: self desatracarNavesReabastecidasYReparadas.
	
	flota do: [ :nave | nave atravesar: sector ].
	
	self rescatarNavesNoDestruidasSinCombustible.
	flota := flota reject: [ :nave | self varada: nave ]! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 08:12:07'!
combustibleNoAlcanzoParaCruzar: nave

	^ nave noOperativa! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:43:26'!
varada: nave

	^ nave destruida or: [ self combustibleNoAlcanzoParaCruzar: nave ]! !


!EscapeDeFlota methodsFor: 'assertions' stamp: 'NR 7/11/2025 06:41:20'!
assertSectoresNoVacios: sectores 
	
	sectores ifEmpty: [ self error: self class rutaVaciaDescripcionDeError ]! !

!EscapeDeFlota methodsFor: 'assertions' stamp: 'NR 7/17/2025 21:21:28'!
assertSinSectoresRepetidos: sectores

	^ sectores asSet size = sectores size ifFalse: [ self error: self class sectoresRepetidosDescripcionDeError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EscapeDeFlota class' category: 'ISW-Pto4-1C25'!
EscapeDeFlota class
	instanceVariableNames: ''!

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:47'!
flotaSinNavesDescripcionDeError

	^ 'La flota no puede estar vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/15/2025 06:43:30'!
naveNodrizaNoPuedeSerTacticaDescripcionDeError 

	^ 'Las naves tácticas no pueden hacer de nodrizas'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:58'!
rutaVaciaDescripcionDeError

	^ 'La ruta no puede ser vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/17/2025 21:20:08'!
sectoresRepetidosDescripcionDeError

	^ 'La ruta no puede tener sectores repetidos'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:40:15'!
todasLasNavesDebenSerDiferentesDescripcionDeError

	^ 'Todas las naves de la flota deben ser unicas'! !


!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'NR 7/15/2025 23:30:38'!
enrolarTacticas: flota 

	self assertFlotaValida: flota.
	
	^ self new initializeEnrolamiento: flota! !

!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 18:57:04'!
enrolarTacticas: flotaDeTacticas enrolarNodrizas: flotaDeNodrizas randomizandoCon: randomizador 

	| flota |
	
	flota := self ensamblarFlotaTactica: flotaDeTacticas conFlotaNodrizas: flotaDeNodrizas.
	self assertFlotaValida: flota.
	
	^ self new initializeEnrolamiento: flota conSoporteDeNodrizas: flotaDeNodrizas yRandomizandoCon: randomizador ! !

!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 18:57:04'!
ensamblarFlotaTactica: flotaTactica conFlotaNodrizas: flotaNodrizas

	| flota |

	self assertFlotaNodrizasSonNodrizas: flotaNodrizas.
	
	flota := OrderedCollection new.
	flota addAll: flotaTactica.
	flota addAll: flotaNodrizas.
	
	^ flota! !


!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/11/2025 16:58:11'!
assertFlotaEsNoVacia: flota 
	
	flota isEmpty ifTrue: [ self error: self flotaSinNavesDescripcionDeError ]! !

!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/17/2025 23:14:28'!
assertFlotaNodrizasSonNodrizas: flotaDeNodrizas

	"Nota: Se usa el #isKindOf: pues es para verificar errores de construccion de los tests. Crear un #esNodriza en la jerarquía puede llevar a que la usen para escribir ifs en vez de utilizar polimorfismo, y por eso es que se utilizan colecciones diferentes a lo largo del ejercicio para diferenciarlas al almacenarlas"

	^ (flotaDeNodrizas allSatisfy: [ :nave | nave isKindOf: NaveNodriza ]) ifFalse: [ self error: self naveNodrizaNoPuedeSerTacticaDescripcionDeError ]! !

!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/15/2025 23:30:37'!
assertFlotaValida: flota

	self assertFlotaEsNoVacia: flota.
	self assertNavesSonUnicasEn: flota! !

!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/11/2025 16:58:16'!
assertNavesSonUnicasEn: flota 
	
	flota asSet size = flota size ifFalse: [ self error: self todasLasNavesDebenSerDiferentesDescripcionDeError ]! !


!classDefinition: #NaveEspacial category: 'ISW-Pto4-1C25'!
Object subclass: #NaveEspacial
	instanceVariableNames: 'propulsores maniobravilidad escudos combustible maxNivelDaño nivelDaño maxNiveCombustible'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!NaveEspacial methodsFor: 'asserts' stamp: 'NR 7/15/2025 06:05:59'!
assertMaxCombustible: nivelCombustible

	^ nivelCombustible strictlyPositive ifFalse: [ self shouldNotHappenBecause: 'Las naves deben diseñarse con capacidad maxima de combustible mayor a 0' ]! !


!NaveEspacial methodsFor: 'initialization' stamp: 'NR 7/15/2025 06:06:53'!
initializeConPropulsores: unosPropulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: nivelCombustible nivelesDeDaño: nivelMaximoDaño     
	
	self assertMaxCombustible: nivelCombustible.
	
	propulsores := unosPropulsores.
	maniobravilidad := valorManiobravilidad.
	escudos := valorEscudos.
	combustible := nivelCombustible.
	maxNiveCombustible := nivelCombustible.
	maxNivelDaño := nivelMaximoDaño.
	
	nivelDaño := 0.! !


!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/13/2025 02:13:56'!
combustibleFaltante

	^ maxNiveCombustible - combustible! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/13/2025 00:28:00'!
consumoCombustibleNormalSector

	^ 10! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/18/2025 06:14:04'!
decrementarCombustibleEn: gastoCombustible

	^ combustible := combustible - gastoCombustible! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/13/2025 02:26:30'!
decrementarCombustibleNormalmente

	self decrementarCombustibleEn: self consumoCombustibleNormalSector ! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/18/2025 06:14:19'!
incrementarCombustibleEn: consumoCombustible

	^ combustible := combustible + consumoCombustible! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/13/2025 05:57:55'!
incrementarCombustibleNormalmente

	combustible < 0 ifTrue: [ combustible := 0 ].

	self incrementarCombustibleEn: (self consumoCombustibleNormalSector min: self combustibleFaltante)! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/18/2025 07:42:55'!
noOperativa
	
	^ combustible < 0! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 06:57:37'!
sinCombustible
	
	^ combustible <= 0! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 06:57:57'!
valorCombustible: nivelDeCombustible

	^ combustible = nivelDeCombustible ! !


!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/18/2025 06:13:42'!
decrementarEscudosDeEnergiaEn: valorDeReduccion

	^ escudos := escudos - valorDeReduccion! !

!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/18/2025 06:13:45'!
eliminarEscudos

	^ escudos := 0! !

!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/14/2025 04:57:34'!
escudos

	self subclassResponsibility! !

!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/14/2025 04:04:54'!
fuerzaDeEscudosEn: nivelDeEscudos

	^ self escudos = nivelDeEscudos ! !


!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:44:18'!
dañada
	
	^ nivelDaño > 0! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:10'!
destruida
	
	^ nivelDaño > maxNivelDaño ! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/18/2025 05:12:53'!
explotar
	
	nivelDaño := maxNivelDaño + 1! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:55'!
nivelDeDañoEs: nivelDeDaño
 
	^ nivelDaño = nivelDeDaño! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 16:26:37'!
recibirNivelDeDaño

	nivelDaño := nivelDaño + 1! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/13/2025 06:32:23'!
repararNivelDeDaño

	nivelDaño := 0 max: nivelDaño - 1! !


!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/11/2025 18:57:03'!
aplicarCondicionesDelSector: unSector

	self aplicarGravedadDelSector: unSector.
	self aplicarRadiacionDelSector: unSector! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:56:16'!
aplicarGravedadDelSector: unSector

	self aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: self maniobravilidad! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:41:41'!
aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidadResultante

	(unSector afectaManiobravilidad: maniobravilidadResultante) ifTrue: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:56:09'!
aplicarRadiacionDelSector: unSector

	self aplicarRadiacionDelSector: unSector conEscudosEfectivos: self escudos! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:40:37'!
aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudosResultantes

	(unSector radiacionAtraviesaEscudosEn: escudosResultantes) ifTrue: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 8/2/2025 06:34:23'!
atravesar: sector 
	
	self subclassResponsibility ! !


!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/13/2025 00:28:00'!
traspasandoConGravitonesSectorDeAsteroides: sector 
	
	self decrementarCombustibleEn: self consumoCombustibleNormalSector * 2;
		aplicarRadiacionDelSector: sector ! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/13/2025 00:38:41'!
traspasandoConImpulsoEstandarSectorDeAsteroides: sector 
	
	self decrementarCombustibleNormalmente;
		decrementarEscudosDeEnergiaEn: 20;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/13/2025 00:38:41'!
traspasandoConVelocidadLuzSectorDeAsteroides: sector 
	
	self decrementarCombustibleNormalmente;
		eliminarEscudos;
		recibirNivelDeDaño;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/11/2025 16:51:14'!
traspasandoSectorDeAsteroides: sector 

	propulsores propulsandoA: self aTravesDeSectorDeAsteroides: sector 
	! !


!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/18/2025 09:04:33'!
traspasandoConGravitonesSectorNebulosa: sector 
	
	self decrementarCombustibleEn: self consumoCombustibleNormalSector * 3;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/16/2025 18:07:22'!
traspasandoConImpulsoEstandarSectorNebulosa: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector;
		aplicarRadiacionDelSector: sector conEscudosEfectivos:  0.7 * self escudos! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/11/2025 21:14:11'!
traspasandoConVelocidadLuzSectorNebulosa: sector 
	
	! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/11/2025 21:15:12'!
traspasandoSectorNebulosa: sector 
	
	propulsores propulsandoA: self aTravesDeSectorNebulosa: sector
! !


!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/18/2025 09:04:21'!
traspasandoConGravitonesSectorPlanetario: sector 

	self aplicarGravedadDelSector: sector conManiobravilidadEfectiva: 0.8 * self maniobravilidad;
		aplicarRadiacionDelSector: sector;
		decrementarCombustibleNormalmente! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/13/2025 00:38:41'!
traspasandoConImpulsoEstandarSectorPlanetario: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/13/2025 00:38:41'!
traspasandoConVelocidadLuzSectorPlanetario: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector
	! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/11/2025 16:52:40'!
traspasandoSectorPlanetario: sector 
	
	propulsores propulsandoA: self aTravesDeSectorPlanetario: sector ! !


!NaveEspacial methodsFor: 'maniobravilidad' stamp: 'NR 7/14/2025 04:58:10'!
maniobravilidad

	self subclassResponsibility! !

!NaveEspacial methodsFor: 'maniobravilidad' stamp: 'NR 7/14/2025 04:58:31'!
penalizacionManiobravilidad: nivel

	self subclassResponsibility! !


!NaveEspacial methodsFor: 'capacidad' stamp: 'NR 7/14/2025 04:58:19'!
numeroLugaresQueOcupa

	self subclassResponsibility! !


!NaveEspacial methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:46:55'!
numeroNavesAtracadas

	self subclassResponsibility! !

!NaveEspacial methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:39:44'!
tieneAtracada: nave

	self subclassResponsibility! !


!classDefinition: #NaveNodriza category: 'ISW-Pto4-1C25'!
NaveEspacial subclass: #NaveNodriza
	instanceVariableNames: 'navesAtracadas capacidadTotal'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!NaveNodriza methodsFor: 'initialization' stamp: 'NR 7/12/2025 21:12:32'!
initializeConPropulsores: unosPropulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: valorCombustible nivelesDeDaño: maxNivelesDaño capacidad: capacidadEnNaves

	super initializeConPropulsores: unosPropulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: valorCombustible nivelesDeDaño: maxNivelesDaño.
	
	capacidadTotal := capacidadEnNaves.
	navesAtracadas := OrderedCollection new.


! !


!NaveNodriza methodsFor: 'asserts' stamp: 'NR 7/14/2025 05:08:22'!
assertNodrizaTieneCapacidadSufienteParaNave: nave

	"Está defensivamente..."
	
	(self tieneEspacioLibrePara: nave) ifFalse: [ self shouldNotHappenBecause: 'El escape de flota no debería haberle pedido a la nodriza atracar nave donde no tiene lugar...' ].! !


!NaveNodriza methodsFor: 'reabastecer' stamp: 'NR 7/14/2025 05:22:14'!
combustibleNecesarioParaReabastecerNavesAtracadas

	^ navesAtracadas sum: [ :nave | nave combustibleFaltante min: nave consumoCombustibleNormalSector ] ifEmpty: [ 0 ]! !

!NaveNodriza methodsFor: 'reabastecer' stamp: 'NR 7/14/2025 07:55:28'!
intentarReabastecerNaves

	| combustibleTotalNecesario |
	
	combustibleTotalNecesario := self combustibleNecesarioParaReabastecerNavesAtracadas.
	
	combustibleTotalNecesario < combustible ifTrue: [ 
		self reabastecerNavesAtracadas.
		self decrementarCombustibleEn: combustibleTotalNecesario.
	].

	! !

!NaveNodriza methodsFor: 'reabastecer' stamp: 'NR 7/14/2025 08:37:01'!
reabastecerNavesAtracadas

	navesAtracadas do: [ :nave | nave incrementarCombustibleNormalmente ]! !


!NaveNodriza methodsFor: 'capacidad' stamp: 'NR 7/13/2025 21:19:45'!
capacidadOcupada

	^ navesAtracadas sum: [ :nave | nave numeroLugaresQueOcupa ] ifEmpty: [ 0 ]! !

!NaveNodriza methodsFor: 'capacidad' stamp: 'NR 7/12/2025 23:46:38'!
capacidadTotal

	^ capacidadTotal! !

!NaveNodriza methodsFor: 'capacidad' stamp: 'NR 7/13/2025 21:16:40'!
numeroLugaresQueOcupa

	^ self capacidadOcupada + 1! !

!NaveNodriza methodsFor: 'capacidad' stamp: 'NR 7/13/2025 21:19:01'!
tieneEspacioLibrePara: nave

	^ (self capacidadOcupada + nave numeroLugaresQueOcupa) <= capacidadTotal! !


!NaveNodriza methodsFor: 'atracar' stamp: 'NR 7/13/2025 22:16:20'!
atracar: nave

	self assertNodrizaTieneCapacidadSufienteParaNave: nave.

	navesAtracadas add: nave! !

!NaveNodriza methodsFor: 'atracar' stamp: 'NR 7/14/2025 05:31:10'!
desatracarNavesReabastecidasYReparadas

	| navesSaliendo |
	
	navesSaliendo := self navesSalientes.
	navesAtracadas removeAll: navesSaliendo.
	
	^ navesSaliendo
	! !

!NaveNodriza methodsFor: 'atracar' stamp: 'NR 7/14/2025 05:31:10'!
navesSalientes

	^ navesAtracadas select: [ :nave | nave combustibleFaltante = 0 and: [ nave nivelDeDañoEs: 0 ] ]! !

!NaveNodriza methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:47:42'!
numeroNavesAtracadas

	^ navesAtracadas sum: [ :nave | 1 + nave numeroNavesAtracadas ] ifEmpty: [ 0 ]! !

!NaveNodriza methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:28:39'!
tieneAtracada: nave

	^ navesAtracadas anySatisfy: [ :naveAtracada | naveAtracada = nave or: [ naveAtracada tieneAtracada: nave ] ]! !


!NaveNodriza methodsFor: 'escudos' stamp: 'NR 7/14/2025 04:28:36'!
bonificacionEscudosNavesAtracadas

	^ (0.05 * (navesAtracadas sum: [ :nave | nave escudos ] ifEmpty: [ 0 ])) rounded! !

!NaveNodriza methodsFor: 'escudos' stamp: 'NR 7/14/2025 03:58:05'!
escudos
	
	^ escudos + self bonificacionEscudosNavesAtracadas! !


!NaveNodriza methodsFor: 'combustible' stamp: 'NR 7/13/2025 20:47:59'!
combustible

	^ combustible ! !


!NaveNodriza methodsFor: 'maniobrabilidad' stamp: 'NR 7/14/2025 02:48:40'!
maniobravilidad

	^ maniobravilidad - (self penalizacionPorNavesAtracadasEn: 1)
	! !

!NaveNodriza methodsFor: 'maniobrabilidad' stamp: 'NR 7/14/2025 02:48:32'!
penalizacionManiobravilidad: nivel

	^ (2 * nivel) + (self penalizacionPorNavesAtracadasEn: nivel + 1)
	! !

!NaveNodriza methodsFor: 'maniobrabilidad' stamp: 'NR 7/14/2025 02:48:14'!
penalizacionPorNavesAtracadasEn: nivel

	^ navesAtracadas sum: [ :nave | nave penalizacionManiobravilidad: nivel ] ifEmpty: [ 0 ]! !


!NaveNodriza methodsFor: 'casco' stamp: 'NR 7/18/2025 05:14:14'!
explotar
	
	super explotar.
	navesAtracadas do: [ :nave | nave explotar ]! !

!NaveNodriza methodsFor: 'casco' stamp: 'NR 7/18/2025 04:58:45'!
recibirNivelDeDaño

	super recibirNivelDeDaño.
	self destruida ifTrue: [ navesAtracadas do: [ :nave | nave explotar ] ]
	! !

!NaveNodriza methodsFor: 'casco' stamp: 'NR 7/13/2025 06:17:03'!
repararNaves
	
	navesAtracadas do: [ :nave | nave repararNivelDeDaño ]
	! !

!NaveNodriza methodsFor: 'casco' stamp: 'NR 7/18/2025 06:26:49'!
repararNivelDeDaño

	super repararNivelDeDaño.
	self repararNaves 
	! !


!NaveNodriza methodsFor: 'atravesar sector' stamp: 'NR 8/2/2025 06:32:00'!
atravesar: sector

	self intentarReabastecerNaves. 
	self repararNaves.
	
	sector ingresadoPor: self
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveNodriza class' category: 'ISW-Pto4-1C25'!
NaveNodriza class
	instanceVariableNames: ''!

!NaveNodriza class methodsFor: 'instance creation' stamp: 'NR 7/15/2025 05:56:26'!
conPropulsores: propulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: valorCombustible nivelesDeDaño: maxNivelesDaño capacidad: capacidadNodriza
	
	self assertCapacidadMayorACero: capacidadNodriza.

	^ self new initializeConPropulsores: propulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: valorCombustible nivelesDeDaño: maxNivelesDaño capacidad: capacidadNodriza! !


!NaveNodriza class methodsFor: 'assertions' stamp: 'NR 7/15/2025 05:56:26'!
assertCapacidadMayorACero: capacidadNodriza

	^ capacidadNodriza <= 0 ifTrue: [ self error: self nodrizaSinHangarDescripcionDeError ]! !


!NaveNodriza class methodsFor: 'message errors' stamp: 'NR 7/15/2025 05:54:30'!
nodrizaSinHangarDescripcionDeError 

	^ 'La nave nodriza debe tener capacidad mayor a cero'! !


!classDefinition: #NaveTactica category: 'ISW-Pto4-1C25'!
NaveEspacial subclass: #NaveTactica
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!NaveTactica methodsFor: 'escudos' stamp: 'NR 7/14/2025 04:51:03'!
escudos

	^ escudos! !


!NaveTactica methodsFor: 'capacidad' stamp: 'NR 7/14/2025 04:51:03'!
numeroLugaresQueOcupa

	^ 1! !


!NaveTactica methodsFor: 'maniobravilidad' stamp: 'NR 7/14/2025 04:51:03'!
maniobravilidad

	^ maniobravilidad! !

!NaveTactica methodsFor: 'maniobravilidad' stamp: 'NR 7/14/2025 04:51:03'!
penalizacionManiobravilidad: nivel

	^ 1 * nivel! !


!NaveTactica methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:46:12'!
numeroNavesAtracadas

	^ 0! !

!NaveTactica methodsFor: 'atracar' stamp: 'NR 7/14/2025 06:39:31'!
tieneAtracada: nave

	^ false! !


!NaveTactica methodsFor: 'atravesar sector' stamp: 'NR 8/2/2025 06:34:13'!
atravesar: sector 
	
	sector ingresadoPor: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveTactica class' category: 'ISW-Pto4-1C25'!
NaveTactica class
	instanceVariableNames: ''!

!NaveTactica class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:01'!
cazaLigeroConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 90 escudos: 30 combustible: 30 nivelesDeDaño: 2 
! !

!NaveTactica class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:05'!
cruceroPesadoConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 50 escudos: 100 combustible: 50 nivelesDeDaño: 5 ! !

!NaveTactica class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:09'!
naveContrabandistaConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 70 escudos: 50 combustible: 95 nivelesDeDaño: 2 
! !

!NaveTactica class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:13'!
naveExploradorCortoAlcanceConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 20 escudos: 20 combustible: 20 nivelesDeDaño: 4 
! !


!classDefinition: #Propulsores category: 'ISW-Pto4-1C25'!
Object subclass: #Propulsores
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:19'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:13:07'!
propulsandoA: nave aTravesDeSectorNebulosa: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:35'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	self subclassResponsibility ! !


!classDefinition: #Gravitones category: 'ISW-Pto4-1C25'!
Propulsores subclass: #Gravitones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:55:42'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConGravitonesSectorDeAsteroides: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:13:33'!
propulsandoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConGravitonesSectorNebulosa: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:54:51'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConGravitonesSectorPlanetario: sector ! !


!classDefinition: #ImpulsoEstandar category: 'ISW-Pto4-1C25'!
Propulsores subclass: #ImpulsoEstandar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:09'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConImpulsoEstandarSectorDeAsteroides: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:14:01'!
propulsandoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConImpulsoEstandarSectorNebulosa: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:31'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConImpulsoEstandarSectorPlanetario: sector ! !


!classDefinition: #VelocidadLuz category: 'ISW-Pto4-1C25'!
Propulsores subclass: #VelocidadLuz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:45'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConVelocidadLuzSectorDeAsteroides: sector ! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:14:11'!
propulsandoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConVelocidadLuzSectorNebulosa: sector! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:57:06'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConVelocidadLuzSectorPlanetario: sector ! !


!classDefinition: #SectorEspacial category: 'ISW-Pto4-1C25'!
Object subclass: #SectorEspacial
	instanceVariableNames: 'gravedad radiacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!SectorEspacial methodsFor: 'initialization' stamp: 'NR 7/11/2025 06:51:20'!
initializeGravedad: valorGravedad yRadiacion: valorRadiacion 
	
	gravedad := valorGravedad.
	radiacion := valorRadiacion.! !


!SectorEspacial methodsFor: 'gravedad' stamp: 'NR 7/11/2025 06:48:50'!
afectaManiobravilidad: maniobravilidad
	
	^ gravedad > maniobravilidad! !

!SectorEspacial methodsFor: 'gravedad' stamp: 'NR 7/11/2025 17:01:15'!
gravedad
	
	^ gravedad! !


!SectorEspacial methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 06:54:05'!
ingresadoPor: nave

	self subclassResponsibility! !


!SectorEspacial methodsFor: 'radiacion' stamp: 'NR 7/11/2025 06:50:18'!
radiacion
	
	^ radiacion! !

!SectorEspacial methodsFor: 'radiacion' stamp: 'NR 7/11/2025 06:50:36'!
radiacionAtraviesaEscudosEn: valorDeEscudos

	^ self radiacion > valorDeEscudos ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SectorEspacial class' category: 'ISW-Pto4-1C25'!
SectorEspacial class
	instanceVariableNames: ''!

!SectorEspacial class methodsFor: 'instance creation' stamp: 'NR 7/11/2025 16:49:48'!
gravedad: gravedad yRadiacion: radiacion 
	
	^self new initializeGravedad: gravedad yRadiacion: radiacion ! !


!classDefinition: #Asteroides category: 'ISW-Pto4-1C25'!
SectorEspacial subclass: #Asteroides
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!Asteroides methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 16:50:17'!
ingresadoPor: nave 
	
	^ nave traspasandoSectorDeAsteroides: self! !


!classDefinition: #Nebulosa category: 'ISW-Pto4-1C25'!
SectorEspacial subclass: #Nebulosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!Nebulosa methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 21:15:12'!
ingresadoPor: nave 
	
	^ nave traspasandoSectorNebulosa: self! !


!classDefinition: #Planetario category: 'ISW-Pto4-1C25'!
SectorEspacial subclass: #Planetario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Pto4-1C25'!

!Planetario methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 16:50:27'!
ingresadoPor: nave 
	
	^ nave traspasandoSectorPlanetario: self! !
