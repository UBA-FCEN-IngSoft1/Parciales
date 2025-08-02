!classDefinition: #EscapeDeFlotaTests category: 'ISW-Ptos123-1C25'!
TestCase subclass: #EscapeDeFlotaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/10/2025 19:58:18'!
test01LaFlotaDebeTenerAlMenosUnaNave
	
	self 
		should: [ EscapeDeFlota enrolar: {  } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:16:20'!
test02LaFlotaNoPuedeTenerNavesDuplicadas

	| cruceroPesadoConImpulso |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	
	self 
		should: [ EscapeDeFlota enrolar: { cruceroPesadoConImpulso. cruceroPesadoConImpulso } ] 
		raise: Error-MessageNotUnderstood 
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:16:29'!
test03LaRutaDeSectoresARecorrerNoPuedeSerVacia

	| cruceroPesadoConImpulso flota |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	self 
		should: [ flota atravesar: {  } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota rutaVaciaDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:16:40'!
test04CombustibleDeLaNaveDebeSerSuficienteParaAtravesarUnicoSectorPlanetarioYSobrevivir

	| sector flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	flota atravesar: { sector }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: (cruceroPesadoConImpulso valorCombustible: (50 - 10))
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:15:57'!
test05LaRutaDeSectoresARecorrerNoPuedeTenerSectoresRepetidos

	| cruceroPesadoConImpulso flota sector |
	
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self assert: (cruceroPesadoConImpulso valorCombustible: 50).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	sector := self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 50.
	
	self 
		should: [ flota atravesar: { sector. sector } ] 
		raise: Error-MessageNotUnderstood  
		withExceptionDo: [ :error | 
			self assert: EscapeDeFlota sectoresRepetidosDescripcionDeError equals: error messageText.
			self assert: (cruceroPesadoConImpulso valorCombustible: 50) ]
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:16:54'!
test06NaveQueSeQuedaSinCombustibleMientrasCruzaSectorNoSobrevive

	| flota naveContrabandistaConImpulso |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso sinCombustible.

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso }.
	
	"Secuencia de 10 sistemas planetarios seguidos con combustible para 9.5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 10 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: naveContrabandistaConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:03'!
test07NavePuedeQuedarseSinCombustiblePeroSobrevivir

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"Secuencia de 5 sistemas planetarios seguidos... Llega justo!!"
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 5 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso sinCombustible.
	self assert: (cruceroPesadoConImpulso valorCombustible: 0).
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:13'!
test08NaveQueSeQuedaSinCombustibleAntesDePasarPorTodosLosSectoresNoSobrevive

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso sinCombustible.

	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"Secuencia de 6 sistemas planetarios seguidos con combustible para 5..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 6 conGravedad: 50 yRadiacion: 50).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso sinCombustible
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:19'!
test09NaveQueAtraviesaSectorConMayorGravedadQueSuManiobravilidadSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).

	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:24'!
test10NaveQueAtraviesaSectorConMayorRadiacionQueSusEscudosDeEnergiaSufreDaños

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 1).
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:30'!
test11NaveAtravesandoSectorConMayorGravedadYRadiacionQueSuManiobravilidadYEscudosDeEnergiaSufreElDobleDeDaño

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 70 yRadiacion: 200 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso ).
	self assert: cruceroPesadoConImpulso dañada.
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 2).
	
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:36'!
test12NaveQueSufreMasNivelesDeDañoQueLaCapacidadDeSuCascoEsDestruidaYNoSobreviveAlEscape

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: cruceroPesadoConImpulso destruida.
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	"6 niveles de daño en una clase de naves que sólo admite 5 como máximo..."
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 70 yRadiacion: 200).
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: cruceroPesadoConImpulso destruida
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:58'!
test13NaveAtravesandoSectorPlanetarioUsandoVelocidadLuzIgnoraRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector planetario utilizando velocidad luz (Warp, Light Speed, Subluminal, FTL: Faster Than Light, o como tu autor de ciencia ficción favorito lo llame), se puede pasar tan rápido que se ignoran los efectos de la radiación"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz}.
	
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:54'!
test14NaveAtravesandoSectorPlanetarioUsandoGravitonesDecrementaManiobravilidadEn20Porciento

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector planetario utilizando propulsion por gravitones el piloto tiene mayor dificultad en controlar la nave en el sector. 20% de penalización en su maniobravilidad"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones }.
	
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:17:55'!
test15NaveAtravesandoSectorDeAsteroidesUsandoImpulsoEstandarReduceSusEscudosDeEnergia

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa un sector de asteroides utilizando el propulsor de impulso estandar, los escudos indefectiblemente reciben el impacto de los asteroides (nada que pueda hacer el piloto con ese tipo de propulsores) y se reducen permanentemente en 20"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso}.
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 35 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConImpulso).
	self assert: (naveContrabandistaConImpulso fuerzaDeEscudosEn: 50 - 20).
	
	"La nave sufre daño porque los escudos de energia descendieron por debajo de la radiacion del sector"
	self assert: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso nivelDeDañoEs: 1).
	
	

	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:45'!
test16NaveAtravesandoSectorDeAsteroidesUsandoVelocidadLuzAgotaSusEscudosACeroYSufreDaños

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se atraviesa un sector de asteroides utilizando velocidad luz, vas derecho al desastre... quien sea que haya trazado ese curso estará condenado, porque irá en linea recta contra un cinturón de asteroides a la velocidad de la luz (duh!!). En terminos prácticos, la nave pierde todos sus escudos de energía permanentemente (pasan a 0) debido a los impactos con los asteroides, se le inflinje 1 nivel de daño al casco y además casi seguro se le suma otro nivel más por radiación al esta no contar más con sus escudos"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 0).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50).
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 30 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	
	"Usar Velocidad Luz con asteroides acaba con los escudos y suma 1 nivel de daño al casco".
	"La radición daña adicionalmente al casco de la nave ya que sus escudos se reducen a 0"
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 0).
	self assert: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1 + 1).
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:38'!
test17NaveAtravesandoSectorDeAsteroidesUsandoGravitonesIgnoraGravedadPeroConsumeElDobleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"Si se atraviesa un sector de asteroides utilizando el avanzado sistema de propulsores basado en Gravitones, el piloto automático de la nave puede sin problema eludirlos sin impactos. Como el piloto no participa, no se tiene en cuenta el rating de maniobrabilidad de la nave, ni la gravedad del sector"
	
	"Al mismo tiempo, lamentablemente el sistema consume el doble de combustible que lo normal"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones.
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones}.
	
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:46:20'!
test18NaveAtravesandoSectorNebulosaUsandoImpulsoEstandarDecrementaEscudosAl30Porciento

	| flota naveContrabandistaConImpulso |
	
	"Si se atraviesa una nebulosa con propulsores de impulso estandar, se esta mucho tiempo dentro de la misma y los escudos empiezan a perder efectividad. 30% de penalizacion a los escudos mientras se la cruza"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar .
	self deny: naveContrabandistaConImpulso dañada.
	self assert: (naveContrabandistaConImpulso valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConImpulso }.
	
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:27'!
test19NaveAtravesandoSectorNebulosaUsandoVelocidadLuzNoConsumeCombustibleEIgnoraGravedadYRadiacionDelSector

	| flota naveContrabandistaConVelocidadLuz |
	
	"Si se viaja hacia una nebulosa utilizando velocidad luz, el modulo Warp se revigoriza por un efecto cuántico bien conocido por el contacto con los gases de la nébula, y casi la teletransporta de inmediato al próximo sector galáctico de la trayectoria del viaje. Luego no se consume combustible, y no se efectua ninguno de los chequeos típicos de supervivencia en el sector"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: naveContrabandistaConVelocidadLuz dañada.
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).
! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:22'!
test20NaveAtravesandoSectorNebulosaUsandoGravitonesEsAfectadaPorGravedadYRadiacionNormalmentePeroConsumientoElTripleDeCombustible

	| flota naveContrabandistaConGravitones |
	
	"La nebulosa afecta los propulsores de gravitones haciendolos menos eficientes. Consume 3 veces el valor de combustible normal sin ningun otro beneficio"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones .
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones }.
	
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:30:56'!
test21NaveConTanqueAntimateriaRajadoAtravesandoSectorPierdeExponencialmenteCombustible

	| flota cruceroPesadoConImpulso |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	
	flota := EscapeDeFlota enrolar: { cruceroPesadoConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 301 yRadiacion: 200 }.
	
	self assert: (cruceroPesadoConImpulso dañada).
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 2).
	self assert: (cruceroPesadoConImpulso valorCombustible: 50 - 10).
	
	flota atravesar: (self nuevoTrayectoDeSectoresPlanetariosDeLongitud: 3 conGravedad: 10  yRadiacion: 10).
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConImpulso).
	self assert: (cruceroPesadoConImpulso dañada).
	self assert: (cruceroPesadoConImpulso nivelDeDañoEs: 2).
	self assert: (cruceroPesadoConImpulso valorCombustible: 50 - 40 - 1 - 2 - 4).
	
	
	.
	
	
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:48:23'!
test22NaveConTanqueAntimateriaRajadoAtravesandoSectorNebulosaUsandoImpulsoEstandarRecibeDobleDañoDeRadiacionSiEscudosNoResisten

	| flota naveCruceroPesadoConImpulso |
	
	"Si se atraviesa una nebulosa con propulsores de impulso estandar, se esta mucho tiempo dentro de la misma y los escudos empiezan a perder efectividad. 30% de penalizacion a los escudos mientras se la cruza"
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	naveCruceroPesadoConImpulso := self nuevoCruceroPesadoConImpulsoEstandar.
	self deny: naveCruceroPesadoConImpulso dañada.
	self assert: (naveCruceroPesadoConImpulso valorCombustible: 50).

	flota := EscapeDeFlota enrolar: { naveCruceroPesadoConImpulso }.

	flota atravesar: { self nuevoSectorNebulosaConGravedad: 301 yRadiacion: 10 }.
	
	self assert: naveCruceroPesadoConImpulso dañada.
	self assert: (naveCruceroPesadoConImpulso nivelDeDañoEs: 1).
	self assert: (naveCruceroPesadoConImpulso valorCombustible: 50 - 10).
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 10 yRadiacion: (100 * 0.7) + 1}.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveCruceroPesadoConImpulso).
	self assert: naveCruceroPesadoConImpulso dañada.
	self assert: (naveCruceroPesadoConImpulso nivelDeDañoEs: 3).
	self assert: (naveCruceroPesadoConImpulso valorCombustible: 50 - 20 - 1).
	
	
	
	
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:14:07'!
test23NaveConTanqueAntimateriaRajadoAtravesandoSectorNebulosaUsandoGravitonesRecibeDobleDañoDeRadiacionSiEscudosNoResisten

	| flota naveContrabandistaConGravitones |
	
	"La nebulosa afecta los propulsores de gravitones haciendolos menos eficientes. Consume 3 veces el valor de combustible normal sin ningun otro beneficio"
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConGravitones := self nuevaNaveContrabandistaConGravitones .
	self deny: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones valorCombustible: 95).

	flota := EscapeDeFlota enrolar: { naveContrabandistaConGravitones }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 301 yRadiacion: 50 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones dañada.
	self assert: (naveContrabandistaConGravitones nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConGravitones valorCombustible: 95 - 30).

	flota atravesar: { self nuevoSectorNebulosaConGravedad: 10 yRadiacion: 51 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: naveContrabandistaConGravitones).
	self assert: naveContrabandistaConGravitones destruida
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/20/2025 21:09:14'!
test24NaveConTanqueAntimateriaRajadoAtravesandoSectorNebulosaUsandoVelocidadLuzExplota

	| flota cruceroPesadoConVelocidadLuz |
	
	"Crucero Pesado -> Maniobravilidad: 50. Escudos: 100. Combustible: 50. NivelesDeDañoCasco: 5."
	cruceroPesadoConVelocidadLuz := NaveEspacial cruceroPesadoConPropulsores: self propulsoresDeVelocidadLuz.
	
	self deny: cruceroPesadoConVelocidadLuz dañada.
	self assert: (cruceroPesadoConVelocidadLuz valorCombustible: 50).

	flota := EscapeDeFlota enrolar: { cruceroPesadoConVelocidadLuz }.
	
	flota atravesar: {self nuevoSectorPlanetarioConGravedad: 301 yRadiacion: 10 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cruceroPesadoConVelocidadLuz).
	self assert: cruceroPesadoConVelocidadLuz dañada.
	self assert: (cruceroPesadoConVelocidadLuz nivelDeDañoEs: 1).
	self assert: (cruceroPesadoConVelocidadLuz valorCombustible: 50 - 10).
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 10 yRadiacion: 10 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cruceroPesadoConVelocidadLuz).
	self assert: cruceroPesadoConVelocidadLuz destruida
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:54:43'!
test25NaveConVelocidadLuzSobrecalentadaSeComportaComoImpulsoEstandarDuranteLosProximos2Sectores
	
	| flota naveContrabandistaConVelocidadLuz |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90 }.

	self deny: (naveContrabandistaConVelocidadLuz dañada ).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95).
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 10 yRadiacion: (50 * 0.7) + 1.  
					self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 10 }. 
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self assert: (naveContrabandistaConVelocidadLuz dañada).
	self assert: (naveContrabandistaConVelocidadLuz nivelDeDañoEs: 1).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50 - 20).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95 - 20).

	
	

	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:56:49'!
test26NaveConVelocidadLuzSobrecalentadaVuelveAVelocidadLuzAl3erSectorRecorrido
	
	| flota naveContrabandistaConVelocidadLuz |
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90. 
					self nuevoSectorDeAsteroidesConGravedad: 65 yRadiacion: 10.  
					self nuevoSectorDeAsteroidesConGravedad: 70 yRadiacion: 0 }. 
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: (naveContrabandistaConVelocidadLuz dañada).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50 - 40).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95 - 20).
	
	flota atravesar: { self nuevoSectorNebulosaConGravedad: 90 yRadiacion: 90 }. 
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: (naveContrabandistaConVelocidadLuz dañada).
	self assert: (naveContrabandistaConVelocidadLuz fuerzaDeEscudosEn: 50 - 40).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95 - 20)
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/18/2025 05:51:10'!
test27NaveConVelocidadLuzSeSobrecalientaSoloEnNebulasConTanqueAntimateriaIntacto
	
	| flota naveContrabandistaConVelocidadLuz |
	
	"Pasa de entrada usando TDD, pero lo dejo defensivamente y por completitud de testing..."
	
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConVelocidadLuz := self nuevaNaveContrabandistaConVelocidadLuz.
	
	flota := EscapeDeFlota enrolar: { naveContrabandistaConVelocidadLuz }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 90. 
	self nuevoSectorPlanetarioConGravedad: 50 yRadiacion: 90 }. 
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: naveContrabandistaConVelocidadLuz).
	self deny: (naveContrabandistaConVelocidadLuz dañada).
	self assert: (naveContrabandistaConVelocidadLuz valorCombustible: 95 - 20)

	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:13:40'!
test28NavesConParpadeoNMayorA1SeSalteanNSectoresCuandoAtreviesanRuta

	"Al tener parpadeo 2, la nave sólo recorre los sectores impares comenzando por el 1, luego el 3, luego el 5 y así...
	No hay todavía naves en el juego con mayor parpadeo, pero la idea es que sea similar. Por ej. parpadeo 5 arrancaría en el sector 1, luego saltaría al 6 y así..."
	
	| flota cazaLigeroConImpulso |
	
	"Caza Ligero: -> Maniobravilidad: 90. Escudos: 30. Combustible: 30. NivelesDeDañoCasco: 2. Parpadeo 2."
	cazaLigeroConImpulso := self nuevoCazaLigeroConImpulsoEstandar.

	flota := EscapeDeFlota enrolar: { cazaLigeroConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 100.  
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100.
					 self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cazaLigeroConImpulso ).
	self assert: (cazaLigeroConImpulso dañada ).
	self assert: (cazaLigeroConImpulso nivelDeDañoEs: 1).
	self assert: (cazaLigeroConImpulso valorCombustible: (30 - 20)).
	
	

	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 23:05:21'!
test29NavesQuedanVaradasEnElSectorCorrecto
	
	| flota cazaLigeroConImpulso naveContrabandistaConImpulso |

	"Caza Ligero: -> Maniobravilidad: 90. Escudos: 30. Combustible: 30. NivelesDeDañoCasco: 2. Parpadeo 2."
	cazaLigeroConImpulso := self nuevoCazaLigeroConImpulsoEstandar.
	"Nave Contrabandista: -> Maniobravilidad: 70. Escudos: 50. Combustible: 95. NivelesDeDañoCasco: 2."
	naveContrabandistaConImpulso := self nuevaNaveContrabandistaConImpulsoEstandar.

	flota := EscapeDeFlota enrolar: { cazaLigeroConImpulso. naveContrabandistaConImpulso. }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.  
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100.
					 self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100.
					 self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100.
					 self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 0).
	self deny: (flota haSobrevivido: cazaLigeroConImpulso ).
	self deny: (cazaLigeroConImpulso dañada).
	self assert: (cazaLigeroConImpulso sinCombustible).
	self assert: (flota nave: cazaLigeroConImpulso varadaEnSectorNumero: 7).
	
	self deny: (flota haSobrevivido: naveContrabandistaConImpulso ).
	self assert: (naveContrabandistaConImpulso destruida).
	self assert: (flota nave: naveContrabandistaConImpulso varadaEnSectorNumero: 4)
	
	! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 23:05:08'!
test30NavesQueSobrevivenNoQuedanVaradas
	
	| flota cazaLigeroConImpulso |

	"Caza Ligero: -> Maniobravilidad: 90. Escudos: 30. Combustible: 30. NivelesDeDañoCasco: 2. Parpadeo 2."
	cazaLigeroConImpulso := self nuevoCazaLigeroConImpulsoEstandar.
	
	flota := EscapeDeFlota enrolar: { cazaLigeroConImpulso }.
	
	flota atravesar: { self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.  
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100.
					 self nuevoSectorPlanetarioConGravedad: 10 yRadiacion: 10.
					 self nuevoSectorPlanetarioConGravedad: 100 yRadiacion: 100 }.
	
	self assert: (flota numeroDeSobrevivientesEs: 1).
	self assert: (flota haSobrevivido: cazaLigeroConImpulso ).
	self deny: (cazaLigeroConImpulso dañada).
	self assert: (cazaLigeroConImpulso valorCombustible: 30 - 20).
	
	self deny: (flota nave: cazaLigeroConImpulso varadaEnSectorNumero: 3).
	

	! !


!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:06'!
nuevaNaveContrabandistaConGravitones

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeGravitones ! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:09'!
nuevaNaveContrabandistaConImpulsoEstandar

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeImpulsoEstandar! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:13'!
nuevaNaveContrabandistaConVelocidadLuz

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeVelocidadLuz! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/16/2025 22:49:24'!
nuevoCazaLigeroConImpulsoEstandar

	^ NaveEspacial cazaLigeroConPropulsores: self propulsoresDeImpulsoEstandar! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:16'!
nuevoCruceroPesadoConImpulsoEstandar

	^ NaveEspacial cruceroPesadoConPropulsores: self propulsoresDeImpulsoEstandar! !


!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 17:22:27'!
nuevoSectorDeAsteroidesConGravedad: gravedad yRadiacion: radiacion

	^ Asteroides gravedad: gravedad yRadiacion: radiacion ! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 17:22:36'!
nuevoSectorNebulosaConGravedad: gravedad yRadiacion: radiacion
 
	^ Nebulosa gravedad: gravedad yRadiacion: radiacion! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 17:22:39'!
nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion

	^ Planetario gravedad: gravedad yRadiacion: radiacion
! !

!EscapeDeFlotaTests methodsFor: 'sectores' stamp: 'NR 7/15/2025 17:22:43'!
nuevoTrayectoDeSectoresPlanetariosDeLongitud: numeroDeSectores conGravedad: gravedad yRadiacion: radiacion

	^ (1 to: numeroDeSectores) collect: [ :numeroDeSector | self nuevoSectorPlanetarioConGravedad: gravedad yRadiacion: radiacion ]
	! !


!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/15/2025 17:22:59'!
propulsoresDeGravitones

	^ Gravitones new! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/15/2025 17:23:02'!
propulsoresDeImpulsoEstandar

	^ ImpulsoEstandar new! !

!EscapeDeFlotaTests methodsFor: 'propulsores' stamp: 'NR 7/15/2025 17:23:06'!
propulsoresDeVelocidadLuz

	^ VelocidadLuz new! !


!classDefinition: #EscapeDeFlota category: 'ISW-Ptos123-1C25'!
Object subclass: #EscapeDeFlota
	instanceVariableNames: 'flota navesVaradas rutaAtravesada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!EscapeDeFlota methodsFor: 'initialization' stamp: 'NR 7/17/2025 07:53:17'!
initializeEnrolamiento: unaFlota 
	
	flota := unaFlota asOrderedCollection.! !


!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/18/2025 07:18:34'!
haSobrevivido: nave

	^ flota includes: nave
	! !

!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/15/2025 17:26:49'!
numeroDeSobrevivientesEs: tamañoDeFlota 
	
	^ flota size = tamañoDeFlota ! !


!EscapeDeFlota methodsFor: 'naves varadas' stamp: 'NR 7/17/2025 21:51:55'!
nave: nave varadaEnSectorNumero: numeroDeSector

	(navesVaradas keys includes: nave) ifFalse: [ ^ false ].

	^ (rutaAtravesada findFirst: [ :sector | sector = (navesVaradas at: nave) ]) = numeroDeSector ! !


!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 21:58:24'!
assertRutaValida: sectores

	self assertSectoresNoVacios: sectores.
	self assertSinSectoresRepetidos: sectores! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 21:59:07'!
atravesar: sectores 
	
	self assertRutaValida: sectores.
	
	rutaAtravesada := sectores.
	navesVaradas := Dictionary new.
	
	flota do: [ :nave | self atravesarNave: nave porSectores: sectores ].
		
	flota removeAllFoundIn: navesVaradas keys.
	
	
			! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 09:21:59'!
atravesarNave: nave porSectores: sectores

	^ (nave rutaEfectiva: sectores) detect: [ :sector | self naveVarada: nave atravesando: sector ] ifFound: [ :sector | navesVaradas at: nave put: sector ] ifNone: []! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:42:32'!
combustibleNoAlcanzoParaCruzar: nave

	^ nave noOperativa! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:21:02'!
naveVarada: nave atravesando: sector

	nave atravesar: sector.
	
	^ self varada: nave
	
	! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:31:53'!
varada: nave

	^ nave destruida or: [ self combustibleNoAlcanzoParaCruzar: nave ]! !


!EscapeDeFlota methodsFor: 'assertions' stamp: 'NR 7/11/2025 06:41:20'!
assertSectoresNoVacios: sectores 
	
	sectores ifEmpty: [ self error: self class rutaVaciaDescripcionDeError ]! !

!EscapeDeFlota methodsFor: 'assertions' stamp: 'NR 7/17/2025 21:21:08'!
assertSinSectoresRepetidos: sectores

	^ sectores asSet size = sectores size ifFalse: [ self error: self class sectoresRepetidosDescripcionDeError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EscapeDeFlota class' category: 'ISW-Ptos123-1C25'!
EscapeDeFlota class
	instanceVariableNames: ''!

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:47'!
flotaSinNavesDescripcionDeError

	^ 'La flota no puede estar vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:58'!
rutaVaciaDescripcionDeError

	^ 'La ruta no puede ser vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/17/2025 21:19:23'!
sectoresRepetidosDescripcionDeError

	^ 'La ruta no puede tener sectores repetidos'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:40:15'!
todasLasNavesDebenSerDiferentesDescripcionDeError

	^ 'Todas las naves de la flota deben ser unicas'! !


!EscapeDeFlota class methodsFor: 'instance creation' stamp: 'NR 7/15/2025 06:36:02'!
enrolar: flota 
	
	self assertFlotaEsNoVacia: flota.
	self assertNavesSonUnicasEn: flota.
	
	^ self new initializeEnrolamiento: flota ! !


!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/11/2025 16:58:11'!
assertFlotaEsNoVacia: flota 
	
	flota isEmpty ifTrue: [ self error: self flotaSinNavesDescripcionDeError ]! !

!EscapeDeFlota class methodsFor: 'assertions' stamp: 'NR 7/11/2025 16:58:16'!
assertNavesSonUnicasEn: flota 
	
	flota asSet size = flota size ifFalse: [ self error: self todasLasNavesDebenSerDiferentesDescripcionDeError ]! !


!classDefinition: #NaveEspacial category: 'ISW-Ptos123-1C25'!
Object subclass: #NaveEspacial
	instanceVariableNames: 'propulsores maniobravilidad escudos combustible maxNivelDaño nivelDaño tanqueAntimateria perdidaCombustible parpadeo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!NaveEspacial methodsFor: 'initialization' stamp: 'NR 7/17/2025 22:21:31'!
initializeConPropulsores: unosPropulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: nivelCombustible nivelesDeDaño: nivelMaximoDaño parpadeo: factorDeParpadeo

	self assertMaxCombustible: nivelCombustible.
	
	propulsores := unosPropulsores.
	maniobravilidad := valorManiobravilidad.
	escudos := valorEscudos.
	combustible := nivelCombustible.
	maxNivelDaño := nivelMaximoDaño.
	parpadeo := factorDeParpadeo.
	
	tanqueAntimateria := Intacto para: self.
	perdidaCombustible := 0.
	nivelDaño := 0! !


!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/16/2025 10:22:14'!
decrementarCombustibleEn: gastoCombustible

	combustible := combustible - gastoCombustible - tanqueAntimateria perdida! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/16/2025 09:22:15'!
decrementarCombustibleNormalmente

	self decrementarCombustibleEn: self gastoCombustibleNormal! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 18:09:02'!
gastoCombustibleNormal

	^ 10! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/18/2025 07:42:31'!
noOperativa
	
	^ combustible < 0! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 06:57:37'!
sinCombustible
	
	^ combustible <= 0! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/15/2025 17:25:44'!
tieneSuficienteCombustible: gastoCombustible

	^ combustible >= gastoCombustible ! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 06:57:57'!
valorCombustible: nivelDeCombustible

	^ combustible = nivelDeCombustible ! !


!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/11/2025 18:07:19'!
decrementarEscudosDeEnergiaEn: valorDeReduccion

	^ escudos := escudos - valorDeReduccion! !

!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/11/2025 06:55:25'!
eliminarEscudos

	^ escudos := 0! !

!NaveEspacial methodsFor: 'escudos' stamp: 'NR 7/15/2025 17:25:25'!
fuerzaDeEscudosEn: nivelDeEscudos

	^ escudos = nivelDeEscudos ! !


!NaveEspacial methodsFor: 'tanque' stamp: 'NR 7/17/2025 22:21:31'!
tanqueRajado

	tanqueAntimateria := Rajado para: self.! !


!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:44:18'!
dañada
	
	^ nivelDaño > 0! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:10'!
destruida
	
	^ nivelDaño > maxNivelDaño ! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/18/2025 05:12:11'!
explotar
	
	nivelDaño := maxNivelDaño + 1! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:55'!
nivelDeDañoEs: nivelDeDaño
 
	^ nivelDaño = nivelDeDaño! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/16/2025 07:30:11'!
recibirNivelDeDaño

	nivelDaño := nivelDaño + 1! !


!NaveEspacial methodsFor: 'parpadeo' stamp: 'NR 7/17/2025 08:12:30'!
rutaEfectiva: sectores
	
	^ (1 to: sectores size by: parpadeo) collect: [ :numeroDeSector | sectores at: numeroDeSector ]! !


!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/11/2025 18:57:03'!
aplicarCondicionesDelSector: unSector

	self aplicarGravedadDelSector: unSector.
	self aplicarRadiacionDelSector: unSector! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:58:38'!
aplicarGravedadDelSector: unSector

	self aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidad ! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 09:38:03'!
aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidadResultante

	unSector cercanoAAgujeroNegro ifTrue: [ tanqueAntimateria rajarse ].

	(unSector afectaManiobravilidad: maniobravilidadResultante) ifTrue: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:59:59'!
aplicarRadiacionDelSector: unSector

	self aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudos! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 09:13:45'!
aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudosResultantes

	self aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudosResultantes conDañoEfectivo: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 09:13:03'!
aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudosResultantes conDañoEfectivo: dañoEfectivoBlock

	(unSector radiacionAtraviesaEscudosEn: escudosResultantes) ifTrue: dañoEfectivoBlock! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/17/2025 22:01:14'!
atravesar: sector 
	
	tanqueAntimateria utilizadoParaCruzarSector: sector! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/17/2025 22:04:58'!
cruzarSectorConTanqueIntacto: sector

	sector ingresadoConTanqueIntactoPor: self! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/17/2025 22:05:21'!
cruzarSectorConTanqueRajado: sector
	
	sector ingresadoConTanqueRajadoPor: self

	! !


!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/16/2025 09:59:27'!
traspasandoConGravitonesSectorDeAsteroides: sector 
	
	self aplicarRadiacionDelSector: sector;
		decrementarCombustibleEn: self gastoCombustibleNormal * 2.! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/15/2025 17:28:17'!
traspasandoConImpulsoEstandarSectorDeAsteroides: sector 
	
	self decrementarCombustibleNormalmente;
		decrementarEscudosDeEnergiaEn: 20;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/16/2025 07:30:11'!
traspasandoConVelocidadLuzSectorDeAsteroides: sector 
	
	self decrementarCombustibleNormalmente;
		eliminarEscudos;
		recibirNivelDeDaño;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/16/2025 06:58:24'!
traspasandoSectorDeAsteroides: sector 

	propulsores propulsandoA: self aTravesDeSectorDeAsteroides: sector 
	! !


!NaveEspacial methodsFor: 'velocidad luz sobrecalentada' stamp: 'NR 7/16/2025 21:04:28'!
velocidadLuzOperativa

	propulsores := VelocidadLuz new! !

!NaveEspacial methodsFor: 'velocidad luz sobrecalentada' stamp: 'NR 7/16/2025 21:05:58'!
velocidadLuzSobrecalentada

	propulsores := VelocidadLuzSobrecalentada new! !


!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:06:01'!
traspasandoConTanqueIntactoConGravitonesSectorNebulosa: sector 
	
	self decrementarCombustibleEn: self gastoCombustibleNormal * 3;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:06:14'!
traspasandoConTanqueIntactoConImpulsoEstandarSectorNebulosa: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector;
		aplicarRadiacionDelSector: sector conEscudosEfectivos: 0.7 * escudos! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:06:31'!
traspasandoConTanqueIntactoConVelocidadLuzSectorNebulosa: sector 
	
	! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:08:07'!
traspasandoConTanqueIntactoSectorNebulosa: sector 
	
	propulsores propulsandoConTanqueIntactoA: self aTravesDeSectorNebulosa: sector
! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:13:38'!
traspasandoConTanqueRajadoConGravitonesSectorNebulosa: sector 
	
	self decrementarCombustibleEn: self gastoCombustibleNormal * 3;
		aplicarGravedadDelSector: sector;
		aplicarRadiacionDelSector: sector conEscudosEfectivos: escudos conDañoEfectivo: [ self recibirNivelDeDaño. self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:07:21'!
traspasandoConTanqueRajadoConImpulsoEstandarSectorNebulosa: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector;
		aplicarRadiacionDelSector: sector conEscudosEfectivos: 0.7 * escudos conDañoEfectivo: [ self recibirNivelDeDaño. self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:07:31'!
traspasandoConTanqueRajadoConVelocidadLuzSectorNebulosa: sector 

	self explotar
	
	! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/17/2025 22:08:26'!
traspasandoConTanqueRajadoSectorNebulosa: sector 
	
	propulsores propulsandoConTanqueRajadoA: self aTravesDeSectorNebulosa: sector
! !


!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/16/2025 08:59:00'!
traspasandoConGravitonesSectorPlanetario: sector 

	self aplicarGravedadDelSector: sector conManiobravilidadEfectiva: 0.8 * maniobravilidad;
		aplicarRadiacionDelSector: sector;
		decrementarCombustibleNormalmente! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/12/2025 06:08:28'!
traspasandoConImpulsoEstandarSectorPlanetario: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/11/2025 21:16:59'!
traspasandoConVelocidadLuzSectorPlanetario: sector 
	
	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector
	! !

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/16/2025 07:52:11'!
traspasandoSectorPlanetario: sector 
	
	propulsores propulsandoA: self aTravesDeSectorPlanetario: sector ! !


!NaveEspacial methodsFor: 'asserts' stamp: 'NR 7/15/2025 17:24:57'!
assertMaxCombustible: nivelCombustible

	^ nivelCombustible strictlyPositive ifFalse: [ self shouldNotHappenBecause: 'Las naves deben diseñarse con capacidad maxima de combustible mayor a 0' ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveEspacial class' category: 'ISW-Ptos123-1C25'!
NaveEspacial class
	instanceVariableNames: ''!

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:28'!
cazaLigeroConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 90 escudos: 30 combustible: 30 nivelesDeDaño: 2 parpadeo: 2
! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:25'!
cruceroPesadoConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 50 escudos: 100 combustible: 50 nivelesDeDaño: 5 parpadeo: 1! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:21'!
naveContrabandistaConPropulsores: propulsores 
	
	^ self new initializeConPropulsores: propulsores maniobravilidad: 70 escudos: 50 combustible: 95 nivelesDeDaño: 2 parpadeo: 1
! !


!classDefinition: #Propulsores category: 'ISW-Ptos123-1C25'!
Object subclass: #Propulsores
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:19'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:35'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	self subclassResponsibility ! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:07'!
propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:26'!
propulsandoConTanqueRajadoA: nave aTravesDeSectorNebulosa: sector

	self subclassResponsibility! !


!classDefinition: #Gravitones category: 'ISW-Ptos123-1C25'!
Propulsores subclass: #Gravitones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:55:42'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConGravitonesSectorDeAsteroides: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:54:51'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConGravitonesSectorPlanetario: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:07'!
propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConTanqueIntactoConGravitonesSectorNebulosa: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:26'!
propulsandoConTanqueRajadoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConTanqueRajadoConGravitonesSectorNebulosa: sector ! !


!classDefinition: #ImpulsoEstandar category: 'ISW-Ptos123-1C25'!
Propulsores subclass: #ImpulsoEstandar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:09'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConImpulsoEstandarSectorDeAsteroides: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:31'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConImpulsoEstandarSectorPlanetario: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:07'!
propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConTanqueIntactoConImpulsoEstandarSectorNebulosa: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:26'!
propulsandoConTanqueRajadoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConTanqueRajadoConImpulsoEstandarSectorNebulosa: sector ! !


!classDefinition: #VelocidadLuz category: 'ISW-Ptos123-1C25'!
Propulsores subclass: #VelocidadLuz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:45'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ nave traspasandoConVelocidadLuzSectorDeAsteroides: sector ! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:57:06'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ nave traspasandoConVelocidadLuzSectorPlanetario: sector ! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:07'!
propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector 
	
	nave traspasandoConTanqueIntactoConVelocidadLuzSectorNebulosa: sector.
	nave velocidadLuzSobrecalentada! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:08:26'!
propulsandoConTanqueRajadoA: nave aTravesDeSectorNebulosa: sector 
	
	^ nave traspasandoConTanqueRajadoConVelocidadLuzSectorNebulosa: sector! !


!classDefinition: #VelocidadLuzSobrecalentada category: 'ISW-Ptos123-1C25'!
Propulsores subclass: #VelocidadLuzSobrecalentada
	instanceVariableNames: 'propulsoresResguardoDeImpulso usosSobrecalentado'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!VelocidadLuzSobrecalentada methodsFor: 'resguardo' stamp: 'NR 7/18/2025 17:26:30'!
cantidadUsosParaOperativo

	^ 2! !

!VelocidadLuzSobrecalentada methodsFor: 'resguardo' stamp: 'NR 7/18/2025 17:26:30'!
intentarReencenderVelocidadLuz: nave

	usosSobrecalentado := usosSobrecalentado + 1.
	usosSobrecalentado = self cantidadUsosParaOperativo ifTrue: [ nave velocidadLuzOperativa ]! !

!VelocidadLuzSobrecalentada methodsFor: 'resguardo' stamp: 'NR 7/16/2025 21:14:19'!
propulsarA: nave utilizandoPropulsorDeResguardo: usoDePropulsorDeResguardoBlock

	usoDePropulsorDeResguardoBlock value.
	self intentarReencenderVelocidadLuz: nave! !


!VelocidadLuzSobrecalentada methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:19:51'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector 
	
	^ self propulsarA: nave utilizandoPropulsorDeResguardo: [ propulsoresResguardoDeImpulso propulsandoA: nave aTravesDeSectorDeAsteroides: sector ]! !

!VelocidadLuzSobrecalentada methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:19:51'!
propulsandoA: nave aTravesDeSectorPlanetario: sector 
	
	^ self propulsarA: nave utilizandoPropulsorDeResguardo: [ propulsoresResguardoDeImpulso propulsandoA: nave aTravesDeSectorPlanetario: sector ]! !

!VelocidadLuzSobrecalentada methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:19:51'!
propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector 
	
	^ self propulsarA: nave utilizandoPropulsorDeResguardo: [ propulsoresResguardoDeImpulso propulsandoConTanqueIntactoA: nave aTravesDeSectorNebulosa: sector ]! !

!VelocidadLuzSobrecalentada methodsFor: 'propulsando' stamp: 'NR 7/17/2025 22:19:51'!
propulsandoConTanqueRajadoA: nave aTravesDeSectorNebulosa: sector 
	
	^ self propulsarA: nave utilizandoPropulsorDeResguardo: [ propulsoresResguardoDeImpulso propulsandoConTanqueRajadoA:  nave aTravesDeSectorNebulosa: sector ]! !


!VelocidadLuzSobrecalentada methodsFor: 'initialization' stamp: 'NR 7/17/2025 22:19:51'!
initialize

	propulsoresResguardoDeImpulso := ImpulsoEstandar new.
	usosSobrecalentado := 0! !


!classDefinition: #SectorEspacial category: 'ISW-Ptos123-1C25'!
Object subclass: #SectorEspacial
	instanceVariableNames: 'gravedad radiacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!SectorEspacial methodsFor: 'initialization' stamp: 'NR 7/11/2025 06:51:20'!
initializeGravedad: valorGravedad yRadiacion: valorRadiacion 
	
	gravedad := valorGravedad.
	radiacion := valorRadiacion.! !


!SectorEspacial methodsFor: 'gravedad' stamp: 'NR 7/11/2025 06:48:50'!
afectaManiobravilidad: maniobravilidad
	
	^ gravedad > maniobravilidad! !

!SectorEspacial methodsFor: 'gravedad' stamp: 'NR 7/16/2025 07:28:50'!
cercanoAAgujeroNegro

	^ gravedad > 300! !

!SectorEspacial methodsFor: 'gravedad' stamp: 'NR 7/11/2025 17:01:15'!
gravedad
	
	^ gravedad! !


!SectorEspacial methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:04:58'!
ingresadoConTanqueIntactoPor: nave

	self subclassResponsibility! !

!SectorEspacial methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:05:10'!
ingresadoConTanqueRajadoPor: nave

	self subclassResponsibility! !


!SectorEspacial methodsFor: 'radiacion' stamp: 'NR 7/11/2025 06:50:18'!
radiacion
	
	^ radiacion! !

!SectorEspacial methodsFor: 'radiacion' stamp: 'NR 7/11/2025 06:50:36'!
radiacionAtraviesaEscudosEn: valorDeEscudos

	^ self radiacion > valorDeEscudos ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SectorEspacial class' category: 'ISW-Ptos123-1C25'!
SectorEspacial class
	instanceVariableNames: ''!

!SectorEspacial class methodsFor: 'instance creation' stamp: 'NR 7/11/2025 16:49:48'!
gravedad: gravedad yRadiacion: radiacion 
	
	^self new initializeGravedad: gravedad yRadiacion: radiacion ! !


!classDefinition: #Asteroides category: 'ISW-Ptos123-1C25'!
SectorEspacial subclass: #Asteroides
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Asteroides methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:04:58'!
ingresadoConTanqueIntactoPor: nave 
	
	^ nave traspasandoSectorDeAsteroides: self! !

!Asteroides methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:05:10'!
ingresadoConTanqueRajadoPor: nave 
	
	^ nave traspasandoSectorDeAsteroides: self! !


!classDefinition: #Nebulosa category: 'ISW-Ptos123-1C25'!
SectorEspacial subclass: #Nebulosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Nebulosa methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:07:00'!
ingresadoConTanqueIntactoPor: nave 
	
	^ nave traspasandoConTanqueIntactoSectorNebulosa: self! !

!Nebulosa methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:07:42'!
ingresadoConTanqueRajadoPor: nave 
	
	^ nave traspasandoConTanqueRajadoSectorNebulosa: self! !


!classDefinition: #Planetario category: 'ISW-Ptos123-1C25'!
SectorEspacial subclass: #Planetario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Planetario methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:04:58'!
ingresadoConTanqueIntactoPor: nave 
	
	^ nave traspasandoSectorPlanetario: self! !

!Planetario methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:05:10'!
ingresadoConTanqueRajadoPor: nave 
	
	^ nave traspasandoSectorPlanetario: self! !


!classDefinition: #TanqueAntimateria category: 'ISW-Ptos123-1C25'!
Object subclass: #TanqueAntimateria
	instanceVariableNames: 'nave'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!TanqueAntimateria methodsFor: 'rajaduras' stamp: 'NR 7/16/2025 10:22:32'!
perdida

	self subclassResponsibility ! !

!TanqueAntimateria methodsFor: 'rajaduras' stamp: 'NR 7/16/2025 07:32:53'!
rajarse

	self subclassResponsibility! !


!TanqueAntimateria methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:41:18'!
utilizadoParaCruzarSector: sector

	self subclassResponsibility ! !


!TanqueAntimateria methodsFor: 'initialization' stamp: 'NR 7/17/2025 22:41:07'!
initializePara: unaNave

	nave := unaNave ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TanqueAntimateria class' category: 'ISW-Ptos123-1C25'!
TanqueAntimateria class
	instanceVariableNames: ''!

!TanqueAntimateria class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 22:21:53'!
para: unaNave

	^ self new initializePara: unaNave! !


!classDefinition: #Intacto category: 'ISW-Ptos123-1C25'!
TanqueAntimateria subclass: #Intacto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Intacto methodsFor: 'rajaduras' stamp: 'NR 7/16/2025 10:22:32'!
perdida

	^ 0! !

!Intacto methodsFor: 'rajaduras' stamp: 'NR 7/16/2025 07:32:53'!
rajarse 

	nave tanqueRajado.! !


!Intacto methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:41:40'!
utilizadoParaCruzarSector: sector

	nave cruzarSectorConTanqueIntacto: sector! !


!classDefinition: #Rajado category: 'ISW-Ptos123-1C25'!
TanqueAntimateria subclass: #Rajado
	instanceVariableNames: 'usos'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW-Ptos123-1C25'!

!Rajado methodsFor: 'rajaduras' stamp: 'NR 7/17/2025 22:39:32'!
perdida

	^ 2 raisedTo: (usos - 1)! !

!Rajado methodsFor: 'rajaduras' stamp: 'NR 7/16/2025 07:32:53'!
rajarse! !


!Rajado methodsFor: 'nave atravesando' stamp: 'NR 7/17/2025 22:41:52'!
utilizadoParaCruzarSector: sector

	usos := usos + 1.
	nave cruzarSectorConTanqueRajado: sector! !


!Rajado methodsFor: 'initialization' stamp: 'NR 7/17/2025 22:40:56'!
initializePara: unaNave

	super initializePara: unaNave.
	usos := 0
	! !
