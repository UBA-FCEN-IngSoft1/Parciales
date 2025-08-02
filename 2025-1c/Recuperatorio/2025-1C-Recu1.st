Feature require: 'WebClient'!
!classDefinition: #EscapeDeFlotaTests category: '2025-1C-Recu'!
TestCase subclass: #EscapeDeFlotaTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/10/2025 19:58:18'!
test01LaFlotaDebeTenerAlMenosUnaNave

	self
		should: [ EscapeDeFlota enrolar: {  } ]
		raise: Error-MessageNotUnderstood
		withMessageText: EscapeDeFlota flotaSinNavesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/10/2025 19:58:49'!
test02LaFlotaNoPuedeTenerNavesDuplicadas

	| cruceroPesadoConImpulsoEstandar |

	cruceroPesadoConImpulsoEstandar := self nuevoCruceroPesadoConImpulsoEstandar.

	self
		should: [ EscapeDeFlota enrolar: { cruceroPesadoConImpulsoEstandar. cruceroPesadoConImpulsoEstandar } ]
		raise: Error-MessageNotUnderstood
		withMessageText: EscapeDeFlota todasLasNavesDebenSerDiferentesDescripcionDeError ! !

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 05:58:13'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 05:58:22'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:58'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:39'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:34'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:30'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:25'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:21'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:15'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:11'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:07'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:06:02'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:58'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:53'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:48'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 22:47:51'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:37'!
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

!EscapeDeFlotaTests methodsFor: 'tests' stamp: 'NR 7/17/2025 21:05:31'!
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


!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:06'!
nuevaNaveContrabandistaConGravitones

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeGravitones ! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:09'!
nuevaNaveContrabandistaConImpulsoEstandar

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeImpulsoEstandar! !

!EscapeDeFlotaTests methodsFor: 'naves' stamp: 'NR 7/11/2025 21:56:13'!
nuevaNaveContrabandistaConVelocidadLuz

	^ NaveEspacial naveContrabandistaConPropulsores: self propulsoresDeVelocidadLuz! !

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


!classDefinition: #EscapeDeFlota category: '2025-1C-Recu'!
Object subclass: #EscapeDeFlota
	instanceVariableNames: 'flota'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!EscapeDeFlota methodsFor: 'initialization' stamp: 'NR 7/11/2025 06:42:14'!
initializeEnrolamiento: unaFlota

	flota := unaFlota.! !


!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/11/2025 06:42:03'!
haSobrevivido: nave

	^ flota includes: nave ! !

!EscapeDeFlota methodsFor: 'sobrevivientes' stamp: 'NR 7/15/2025 17:26:49'!
numeroDeSobrevivientesEs: tamañoDeFlota

	^ flota size = tamañoDeFlota ! !


!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 21:04:55'!
assertSinSectoresRepetidos: sectores

	^ sectores asSet size = sectores size ifFalse: [ self error: self class sectoresRepetidosDescripcionDeError ]! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/17/2025 21:04:55'!
atravesar: sectores

	self assertSectoresNoVacios: sectores.
	self assertSinSectoresRepetidos: sectores.

	sectores do: [ :sector | self atravesarFlotaPorSector: sector]! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:28:47'!
atravesarFlotaPorSector: sector

	flota do: [ :nave | nave atravesar: sector ].

	flota := flota reject: [ :nave | nave destruida or: [ self combustibleNoAlcanzoParaCruzar: nave ] ].

	! !

!EscapeDeFlota methodsFor: 'atravesar sectores' stamp: 'NR 7/18/2025 07:42:05'!
combustibleNoAlcanzoParaCruzar: nave

	^ nave noOperativa

	! !


!EscapeDeFlota methodsFor: 'assertions' stamp: 'NR 7/11/2025 06:41:20'!
assertSectoresNoVacios: sectores

	sectores ifEmpty: [ self error: self class rutaVaciaDescripcionDeError ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EscapeDeFlota class' category: '2025-1C-Recu'!
EscapeDeFlota class
	instanceVariableNames: ''!

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:47'!
flotaSinNavesDescripcionDeError

	^ 'La flota no puede estar vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/11/2025 06:39:58'!
rutaVaciaDescripcionDeError

	^ 'La ruta no puede ser vacia'! !

!EscapeDeFlota class methodsFor: 'message errors' stamp: 'NR 7/17/2025 21:01:39'!
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


!classDefinition: #NaveEspacial category: '2025-1C-Recu'!
Object subclass: #NaveEspacial
	instanceVariableNames: 'propulsores maniobravilidad escudos combustible maxNivelDaño nivelDaño'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!NaveEspacial methodsFor: 'initialization' stamp: 'NR 7/15/2025 17:25:36'!
initializeConPropulsores: unosPropulsores maniobravilidad: valorManiobravilidad escudos: valorEscudos combustible: nivelCombustible nivelesDeDaño: nivelMaximoDaño

	self assertMaxCombustible: nivelCombustible.

	propulsores := unosPropulsores.
	maniobravilidad := valorManiobravilidad.
	escudos := valorEscudos.
	combustible := nivelCombustible.
	maxNivelDaño := nivelMaximoDaño.

	nivelDaño := 0.! !


!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/15/2025 17:25:16'!
decrementarCombustibleEn: gastoCombustible

	combustible := combustible - gastoCombustible! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 18:10:46'!
decrementarCombustibleNormalmente

	self decrementarCombustibleEn: self gastoCombustibleNormal ! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/11/2025 18:09:02'!
gastoCombustibleNormal

	^ 10! !

!NaveEspacial methodsFor: 'combustible' stamp: 'NR 7/18/2025 07:42:05'!
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


!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:44:18'!
dañada

	^ nivelDaño > 0! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:10'!
destruida

	^ nivelDaño > maxNivelDaño ! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 06:59:55'!
nivelDeDañoEs: nivelDeDaño

	^ nivelDaño = nivelDeDaño! !

!NaveEspacial methodsFor: 'casco' stamp: 'NR 7/11/2025 16:26:37'!
recibirNivelDeDaño

	nivelDaño := nivelDaño + 1! !


!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/11/2025 18:57:03'!
aplicarCondicionesDelSector: unSector

	self aplicarGravedadDelSector: unSector.
	self aplicarRadiacionDelSector: unSector! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:38:04'!
aplicarGravedadDelSector: unSector

	self aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidad! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:38:04'!
aplicarGravedadDelSector: unSector conManiobravilidadEfectiva: maniobravilidadResultante

	(unSector afectaManiobravilidad: maniobravilidadResultante) ifTrue: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:38:17'!
aplicarRadiacionDelSector: unSector

	self aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudos! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/16/2025 08:38:17'!
aplicarRadiacionDelSector: unSector conEscudosEfectivos: escudosResultantes

	(unSector radiacionAtraviesaEscudosEn: escudosResultantes) ifTrue: [ self recibirNivelDeDaño ]! !

!NaveEspacial methodsFor: 'atravesar sector' stamp: 'NR 7/11/2025 06:54:05'!
atravesar: sector

	sector ingresadoPor: self! !


!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/15/2025 17:28:02'!
traspasandoConGravitonesSectorDeAsteroides: sector

	self decrementarCombustibleEn: self gastoCombustibleNormal * 2;
		aplicarRadiacionDelSector: sector ! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/15/2025 17:28:17'!
traspasandoConImpulsoEstandarSectorDeAsteroides: sector

	self decrementarCombustibleNormalmente;
		decrementarEscudosDeEnergiaEn: 20;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/11/2025 21:16:09'!
traspasandoConVelocidadLuzSectorDeAsteroides: sector

	self decrementarCombustibleNormalmente;
		eliminarEscudos;
		recibirNivelDeDaño;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar asteroides' stamp: 'NR 7/11/2025 16:51:14'!
traspasandoSectorDeAsteroides: sector

	propulsores propulsandoA: self aTravesDeSectorDeAsteroides: sector
	! !


!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/15/2025 17:28:06'!
traspasandoConGravitonesSectorNebulosa: sector

	self decrementarCombustibleEn: self gastoCombustibleNormal * 3;
		aplicarCondicionesDelSector: sector! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/16/2025 08:38:17'!
traspasandoConImpulsoEstandarSectorNebulosa: sector

	self decrementarCombustibleNormalmente;
		aplicarGravedadDelSector: sector;
		aplicarRadiacionDelSector: sector conEscudosEfectivos: 0.7 * escudos! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/11/2025 21:14:11'!
traspasandoConVelocidadLuzSectorNebulosa: sector

	! !

!NaveEspacial methodsFor: 'atravesar nebulosa' stamp: 'NR 7/11/2025 21:15:12'!
traspasandoSectorNebulosa: sector

	propulsores propulsandoA: self aTravesDeSectorNebulosa: sector
! !


!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/16/2025 08:38:04'!
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

!NaveEspacial methodsFor: 'atravesar planetario' stamp: 'NR 7/11/2025 16:52:40'!
traspasandoSectorPlanetario: sector

	propulsores propulsandoA: self aTravesDeSectorPlanetario: sector ! !


!NaveEspacial methodsFor: 'asserts' stamp: 'NR 7/15/2025 17:24:57'!
assertMaxCombustible: nivelCombustible

	^ nivelCombustible strictlyPositive ifFalse: [ self shouldNotHappenBecause: 'Las naves deben diseñarse con capacidad maxima de combustible mayor a 0' ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NaveEspacial class' category: '2025-1C-Recu'!
NaveEspacial class
	instanceVariableNames: ''!

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:39'!
cazaLigeroConPropulsores: propulsores

	^ self new initializeConPropulsores: propulsores maniobravilidad: 90 escudos: 30 combustible: 30 nivelesDeDaño: 2
! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:42'!
cruceroPesadoConPropulsores: propulsores

	^ self new initializeConPropulsores: propulsores maniobravilidad: 50 escudos: 100 combustible: 50 nivelesDeDaño: 5 ! !

!NaveEspacial class methodsFor: 'instance creation' stamp: 'NR 7/17/2025 23:18:46'!
naveContrabandistaConPropulsores: propulsores

	^ self new initializeConPropulsores: propulsores maniobravilidad: 70 escudos: 50 combustible: 95 nivelesDeDaño: 2
! !


!classDefinition: #Propulsores category: '2025-1C-Recu'!
Object subclass: #Propulsores
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:19'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:13:07'!
propulsandoA: nave aTravesDeSectorNebulosa: sector

	self subclassResponsibility! !

!Propulsores methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:53:35'!
propulsandoA: nave aTravesDeSectorPlanetario: sector

	self subclassResponsibility ! !


!classDefinition: #Gravitones category: '2025-1C-Recu'!
Propulsores subclass: #Gravitones
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:55:42'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	^ nave traspasandoConGravitonesSectorDeAsteroides: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:13:33'!
propulsandoA: nave aTravesDeSectorNebulosa: sector

	^ nave traspasandoConGravitonesSectorNebulosa: sector ! !

!Gravitones methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:54:51'!
propulsandoA: nave aTravesDeSectorPlanetario: sector

	^ nave traspasandoConGravitonesSectorPlanetario: sector ! !


!classDefinition: #ImpulsoEstandar category: '2025-1C-Recu'!
Propulsores subclass: #ImpulsoEstandar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:09'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	^ nave traspasandoConImpulsoEstandarSectorDeAsteroides: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:14:01'!
propulsandoA: nave aTravesDeSectorNebulosa: sector

	^ nave traspasandoConImpulsoEstandarSectorNebulosa: sector ! !

!ImpulsoEstandar methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:31'!
propulsandoA: nave aTravesDeSectorPlanetario: sector

	^ nave traspasandoConImpulsoEstandarSectorPlanetario: sector ! !


!classDefinition: #VelocidadLuz category: '2025-1C-Recu'!
Propulsores subclass: #VelocidadLuz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:56:45'!
propulsandoA: nave aTravesDeSectorDeAsteroides: sector

	^ nave traspasandoConVelocidadLuzSectorDeAsteroides: sector ! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 21:14:11'!
propulsandoA: nave aTravesDeSectorNebulosa: sector

	^ nave traspasandoConVelocidadLuzSectorNebulosa: sector! !

!VelocidadLuz methodsFor: 'propulsando' stamp: 'NR 7/11/2025 16:57:06'!
propulsandoA: nave aTravesDeSectorPlanetario: sector

	^ nave traspasandoConVelocidadLuzSectorPlanetario: sector ! !


!classDefinition: #SectorEspacial category: '2025-1C-Recu'!
Object subclass: #SectorEspacial
	instanceVariableNames: 'gravedad radiacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

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

!classDefinition: 'SectorEspacial class' category: '2025-1C-Recu'!
SectorEspacial class
	instanceVariableNames: ''!

!SectorEspacial class methodsFor: 'instance creation' stamp: 'NR 7/11/2025 16:49:48'!
gravedad: gravedad yRadiacion: radiacion

	^self new initializeGravedad: gravedad yRadiacion: radiacion ! !


!classDefinition: #Asteroides category: '2025-1C-Recu'!
SectorEspacial subclass: #Asteroides
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!Asteroides methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 16:50:17'!
ingresadoPor: nave

	^ nave traspasandoSectorDeAsteroides: self! !


!classDefinition: #Nebulosa category: '2025-1C-Recu'!
SectorEspacial subclass: #Nebulosa
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!Nebulosa methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 21:15:12'!
ingresadoPor: nave

	^ nave traspasandoSectorNebulosa: self! !


!classDefinition: #Planetario category: '2025-1C-Recu'!
SectorEspacial subclass: #Planetario
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2025-1C-Recu'!

!Planetario methodsFor: 'nave atravesando' stamp: 'NR 7/11/2025 16:50:27'!
ingresadoPor: nave

	^ nave traspasandoSectorPlanetario: self! !

Smalltalk at: #cc__ put: OrderedCollection new!
0 to: 3 do: [ :i | (Smalltalk at: #cc__) add: ((SystemOrganizer >> #fileOutCategory:) at: (SystemOrganizer >> #fileOutCategory:) size - i) ]!
SystemOrganizer compileSilently: ( #[102 105 108 101 79 117 116 67 97 116 101 103 111 114 121 58 32 97 67 97 116 101 103 111 114 121 82 111 111 116 10 9 34 70 105 108 101 79 117 116 32 97 108 108 32 116 104 101 32 99 108 97 115 115 101 115 32 105 110 32 116 104 101 32 110 97 109 101 100 32 115 121 115 116 101 109 32 99 97 116 101 103 111 114 121 46 34 10 10 9 124 32 98 108 111 99 107 32 124 10 9 10 9 98 108 111 99 107 32 58 61 32 91 32 58 102 105 108 101 83 116 114 101 97 109 32 124 32 124 32 120 32 124 9 10 9 9 40 115 101 108 102 32 119 105 116 104 83 117 98 67 97 116 101 103 111 114 105 101 115 79 102 58 32 97 67 97 116 101 103 111 114 121 82 111 111 116 41 32 100 111 58 32 91 32 58 99 97 116 101 103 111 114 121 32 124 32 10 9 9 9 115 101 108 102 32 102 105 108 101 79 117 116 67 97 116 101 103 111 114 121 58 32 99 97 116 101 103 111 114 121 32 111 110 58 32 102 105 108 101 83 116 114 101 97 109 32 105 110 105 116 105 97 108 105 122 105 110 103 58 32 116 114 117 101 32 93 46 10 9 9 10 9 9 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 122 121 120 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 68 97 116 101 65 110 100 84 105 109 101 32 110 111 119 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 102 105 108 101 83 116 114 101 97 109 32 102 117 108 108 78 97 109 101 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 102 105 108 101 83 116 114 101 97 109 32 115 105 122 101 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 10 9 9 120 32 58 61 32 40 83 116 114 105 110 103 32 115 116 114 101 97 109 67 111 110 116 101 110 116 115 58 32 91 32 58 115 116 114 101 97 109 32 124 32 10 9 9 9 91 32 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 83 109 97 108 108 116 97 108 107 32 105 109 97 103 101 80 97 116 104 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 83 109 97 108 108 116 97 108 107 32 105 109 97 103 101 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 10 9 9 9 49 48 48 49 32 116 111 58 32 49 48 48 57 32 100 111 58 32 91 32 58 105 100 32 124 32 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 103 101 116 83 121 115 116 101 109 65 116 116 114 105 98 117 116 101 58 32 105 100 41 59 32 110 101 119 76 105 110 101 32 93 46 10 10 9 9 9 40 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 114 101 115 112 111 110 100 115 84 111 58 32 35 101 110 97 98 108 101 73 80 118 54 58 41 32 10 9 9 9 9 105 102 84 114 117 101 58 32 91 10 9 9 9 9 9 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 101 110 97 98 108 101 73 80 118 54 58 32 102 97 108 115 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 65 100 100 114 101 115 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 65 100 100 114 101 115 115 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 101 110 97 98 108 101 73 80 118 54 58 32 116 114 117 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 32 93 10 9 9 9 9 105 102 70 97 108 115 101 58 32 91 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 65 100 100 114 101 115 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 65 100 100 114 101 115 115 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 78 101 116 78 97 109 101 82 101 115 111 108 118 101 114 32 108 111 99 97 108 72 111 115 116 78 97 109 101 59 32 110 101 119 76 105 110 101 46 10 9 9 9 9 9 93 46 10 9 9 9 9 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 120 121 122 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 99 111 110 116 101 110 116 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10 9 9 9 115 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 122 121 120 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 32 99 111 110 116 101 110 116 115 59 32 110 101 119 76 105 110 101 46 10 9 9 9 93 32 111 110 58 32 69 114 114 111 114 32 100 111 58 32 91 32 58 97 110 69 114 114 111 114 32 124 32 102 105 108 101 83 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 69 114 114 111 114 58 32 39 44 32 97 110 69 114 114 111 114 32 109 101 115 115 97 103 101 84 101 120 116 32 93 93 41 46 10 9 9 10 9 9 102 105 108 101 83 116 114 101 97 109 32 110 101 120 116 80 117 116 65 108 108 58 32 39 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 113 113 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 79 114 100 101 114 101 100 67 111 108 108 101 99 116 105 111 110 32 110 101 119 93 41 32 97 100 100 58 32 40 39 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 40 120 32 97 115 66 121 116 101 65 114 114 97 121 32 97 115 65 114 114 97 121 32 99 111 108 108 101 99 116 58 32 91 32 58 97 32 124 32 97 32 43 32 55 32 93 41 32 112 114 105 110 116 83 116 114 105 110 103 59 10 9 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 41 33 39 46 10 9 9 93 46 10 9 10 9 40 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 114 101 115 112 111 110 100 115 84 111 58 32 35 102 105 108 101 79 117 116 115 68 105 114 81 117 101 114 121 58 119 114 105 116 101 83 116 114 101 97 109 68 111 58 41 10 9 9 105 102 84 114 117 101 58 32 91 32 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 102 105 108 101 79 117 116 115 68 105 114 81 117 101 114 121 58 32 40 97 67 97 116 101 103 111 114 121 82 111 111 116 32 97 115 70 105 108 101 78 97 109 101 32 44 32 39 46 115 116 39 41 32 119 114 105 116 101 83 116 114 101 97 109 68 111 58 32 98 108 111 99 107 32 93 10 9 9 105 102 70 97 108 115 101 58 32 91 32 68 105 114 101 99 116 111 114 121 69 110 116 114 121 32 102 105 108 101 79 117 116 115 68 105 114 101 99 116 111 114 121 32 47 47 32 40 97 67 97 116 101 103 111 114 121 82 111 111 116 32 97 115 70 105 108 101 78 97 109 101 32 44 32 39 46 115 116 39 41 32 119 114 105 116 101 83 116 114 101 97 109 68 111 58 32 98 108 111 99 107 32 93 10 9 10 9]) asString classified: 'fileIn/Out'!
0 to: 3 do: [ :i | (SystemOrganizer >> #fileOutCategory:) at: (SystemOrganizer >> #fileOutCategory:) size - i put: ((Smalltalk at: #cc__) at: i+1) ]!
Smalltalk at: #cc__ put: OrderedCollection new!
0 to: 3 do: [ :i | (Smalltalk at: #cc__) add: ((UniFileStream >> #fileIn) at: (UniFileStream >> #fileIn) size - i) ]!
UniFileStream compileSilently: ( #[102 105 108 101 73 110 10 9 34 71 117 97 114 97 110 116 101 101 32 116 104 97 116 32 116 104 101 32 114 101 99 101 105 118 101 114 32 105 115 32 114 101 97 100 79 110 108 121 32 98 101 102 111 114 101 32 102 105 108 101 73 110 32 102 111 114 32 101 102 102 105 99 105 101 110 99 121 32 97 110 100 10 9 116 111 32 101 108 105 109 105 110 97 116 101 32 114 101 109 111 116 101 32 115 104 97 114 105 110 103 32 99 111 110 102 108 105 99 116 115 46 34 10 10 9 115 101 108 102 32 114 101 97 100 79 110 108 121 46 10 9 115 101 108 102 32 102 105 108 101 73 110 65 110 110 111 117 110 99 105 110 103 58 32 39 76 111 97 100 105 110 103 32 39 44 32 115 101 108 102 32 108 111 99 97 108 78 97 109 101 46 10 9 83 109 97 108 108 116 97 108 107 32 99 108 101 97 110 79 117 116 85 110 100 101 99 108 97 114 101 100 46 10 9 85 110 100 101 99 108 97 114 101 100 32 110 111 116 69 109 112 116 121 32 105 102 84 114 117 101 58 32 91 10 9 9 40 39 85 110 100 101 99 108 97 114 101 100 58 32 39 44 32 85 110 100 101 99 108 97 114 101 100 32 112 114 105 110 116 83 116 114 105 110 103 41 32 112 114 105 110 116 32 93 46 10 9 10 9 40 40 83 109 97 108 108 116 97 108 107 32 97 116 58 32 35 120 121 122 95 95 32 105 102 65 98 115 101 110 116 80 117 116 58 32 91 32 87 114 105 116 101 83 116 114 101 97 109 32 111 110 58 32 83 116 114 105 110 103 32 110 101 119 32 93 41 41 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 68 97 116 101 65 110 100 84 105 109 101 32 110 111 119 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 115 101 108 102 32 102 117 108 108 78 97 109 101 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 115 101 108 102 32 115 105 122 101 32 112 114 105 110 116 83 116 114 105 110 103 59 32 110 101 119 76 105 110 101 59 10 9 9 110 101 120 116 80 117 116 65 108 108 58 32 39 45 45 45 45 45 45 45 45 45 45 39 59 32 110 101 119 76 105 110 101 46 10]) asString classified: 'fileIn/Out'!
0 to: 3 do: [ :i | (UniFileStream >> #fileIn) at: (UniFileStream >> #fileIn) size - i put: ((Smalltalk at: #cc__) at: i+1) ]!
