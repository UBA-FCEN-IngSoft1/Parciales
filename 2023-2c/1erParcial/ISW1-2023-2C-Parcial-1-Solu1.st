!classDefinition: #PenalesTest category: 'ISW1-2023-2C-Parcial-1-Solu1'!
TestCase subclass: #PenalesTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test01DelanteroNoPuedeApuntarHaciaAfueraDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: -1@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test02DelanteroNoPuedeApuntarHaciaAfueraDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 3@0 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test03DelanteroNoPuedeApuntarHaciaAbajoDelArco
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@-1 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test04DelanteroNoPuedeApuntarHaciaArribaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@3 arqueroSeLanzaEnDirección: 0@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionTiroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test05ArqueroNoPuedePasarseDelPaloIzquierdo
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: -1@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test06ArqueroNoPuedePasarseDelPaloDerecho
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 3@0.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test07ArqueroNoPuedeMeterseAbajoDeLaTierra
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@-1.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test08ArqueroNoPuedeSaltarPorEncimaDelTravesaño
	
	| arquero delantero juegoPenales pelota |
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	self 
		should: [ juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@3.] 
		raise: Error
		withExceptionDo: [ :error |
			self assert: Penales direccionArqueroFueraDeRango equals: error messageText.
			self assert: 0 equals: juegoPenales puntajeDeDelantero.
			self assert: 0 equals: juegoPenales puntajeDeArquero.]
	! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test09DireccionesDiferentesGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante
	"varXXXX es por VAR, de 'Video Assistant Referee'"! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test10MismasDireccionesInsuficienteFuerzaGolDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 10.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test11MismasDireccionesSuficienteFuerzaAtajaArquero
	
	| arquero delantero juegoPenales pelota |
	
	"Caso general del juego..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test12DelanteroQueTiraAColocarPierde50PorcFuerza
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"(delantero sacrificia potencia para ganar mayor precisión)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test13ArqueroQueEligeAntesDeTiroVsJabulaniAColocarSuma50PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige donde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	"(el arquero llega más cómodo y aprovecha mejor su fuerza)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 34.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 51 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test14FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que elige adonde tirarse antes de un tiro a colocar de jabulani gana 50% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 32.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 50 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 48 equals: juegoPenales varFuerzaResultanteDeAtajada.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test15ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAColocarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"El Arquero que espera y se adelanta ante un tiro de jabulani a colocar ignora la 2da coordenada (altura) al atajar..."	
	"(al adelanterse encara la pelota antes de que su elevación se transforme en un problema)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 50.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test16PelotaPlayeraUsadaAColocarLeHacePerder20PorcFuerzaExtraAlDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% de fuerza adicional al delantero que la use para colocar... (no importa el arquero)"
	"(no debería ser reglamentaria... al menos no es de trapo, nos responden)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@2.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test17ArqueroQueEligeAntesDeTiroVsPlayeraAColocarSuma100PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	"(a quien madruga...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 20.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:34'!
test18FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsPlayeraAColocar
	
	| arquero delantero juegoPenales pelota |
	
	"La fuerza del Delantero se reduce en 50% siempre que tira a colocar... (no importa pelota, ni arquero)"
	"La humilde pelota playera le hace perder un 20% adicional de fuerza al delantero que la use para colocar... (no importa el arquero)"
	"Arquero que elige donde lanzarse antes de un remate de una pelota playera lenta a colocar, gana un 100% de su fuerza extra..."
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 19.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante.
	self assert: 40 equals: juegoPenales varFuerzaResultanteDeTiro.
	self assert: 38 equals: juegoPenales varFuerzaResultanteDeAtajada! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test19ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAColocarEsDescubiertoYPuntoParaDelantero
	
	| arquero delantero juegoPenales pelota |
	
	"Arquero que espera y se adelanta ante tiro con la lenta pelota playera, siempre es descubierto por el Árbitro, y el punto se le otorga al Delantero..."
	"(lo que servía de ventaja ante la Jabulani rápida, acá es tan obvio por lo que tarda en llegar la pelota al arco, que marchás preso...)"
	
	delantero := Delantero decideTirarAColocarSuFuerzaBaseEs: 100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero  esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 0@0 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:52'!
test20DelanteroTiraAMatarAlAnguloInferiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 0@0.
	.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:47'!
test21DelanteroTiraAMatarAlAnguloSuperiorIzquierdoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:41'!
test22DelanteroTiraAMatarAlAnguloInferiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:36'!
test23DelanteroTiraAMatarAlAnguloSuperiorDerechoLaAlturaDelTiroPasaAMedio
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@2.
	
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:34:29'!
test24DelanteroTiraAMatarNoAlAnguloMantieneDireccionTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@2 arqueroSeLanzaEnDirección: 1@1.

	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test25DelanteroTiraAMatarUsa100PorcFuerzaBase
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"(tirar a matar no es tan preciso como tirar a colocar, hay desvios de altura. Sin embargo se usa el 100% de fuerza del jugador)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:150.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@0 arqueroSeLanzaEnDirección: 2@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 150 equals: juegoPenales varFuerzaResultanteDeTiro! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test26DelanteroTiraAMatarConJabulaniGana20PorcFuerzaExtra
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	"(Jabulani a matar es la elección de los guerreros Z)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 120.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:42:08'!
test27FuerzaInsuficienteDeArqueroQueEligeAntesDeTiroVsJabulaniAMatar
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando la jabulani rápida, el Delantero gana un 20% de fuerza extra... (no importa arquero)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 119.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante.
	self assert: 120 equals: juegoPenales varFuerzaResultanteDeTiro.! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:06'!
test28ArqueroQueEligeAntesDeTiroVsJabulaniAMatarIgnoraAlturaTiro
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que elige donde tirarse antes de un tiro de jabulani a matar, ignora la 2da coordenada (altura) al atajar..."		
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test29ArqueroQueEsperaPorTiroYSeAdelantaVsJabulaniAMatarNuncaAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera a ver la dirección del remate de una pelota jabulani rápida a matar antes de lanzarse, nunca la ataja sin importar nada, siquiera que se adelantó..."	
	"(su poder era de más de 9000!! era impresionante, no podía moverme, sólo la ví pasar... f )"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota jabulaniSudafricanaRapida.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@1 arqueroSeLanzaEnDirección: 1@1.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test30DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAdentro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(y voló.. y me hizo volar... y yo volé de él...  pero acá por la arbolada... y el voló.. y se estrelló por acá por la pared...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 1@0.
	
	self assert: 1 equals: juegoPenales puntajeDeDelantero.
	self assert: 0 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test31DelanteroQueNoPateaAlAnguloConPlayeraAMatarSuma2AAlturaDeDireccionPelotaAfuera
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"(El caso auspiciado por el Pipita...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 200.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@1 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@3 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test32ArqueroQueEligeAntesDeTiroVsPlayeraAMatarAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' a los ángulos, la 2da coordenada (altura) del remate pasa a 1 (altura media)... (no importa pelota, ni arquero)"	
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 0@0 arqueroSeLanzaEnDirección: 2@1.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 0@1 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 18:29:53'!
test33ArqueroQueEligeAntesDeTiroVsPlayeraAMatarNoAlAnguloIgnoraAnchoTiro
	
	| arquero delantero juegoPenales pelota |
	
	"Si se tira 'a matar' el Delantero usa el 100% de su fuerza... (no importa pelota, ni arquero)"
	"Si se tira 'a matar' usando una pelota playera a una dirección que no es un ángulo, la 2da coordenada del remate (altura) suma 2, es decir sale volando producto de su liviandez (y que quiere retornar al mar). Si la pelota se va fuera del arco, el puntaje va al arquero... (no importa arquero)"
	"Si el arquero elige donde tirarse antes del tiro a matar de la pelota playera, ignora la 1ra coordenada del remate (ancho) al atajar..."
	"(con agacharse, quedarse parado, o saltar le alcanza...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero eligeDireccionAntesDeTiroSuFuerzaBaseEs: 100.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 1@0 arqueroSeLanzaEnDirección: 0@2.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 1@2 equals: juegoPenales varDireccionRemateResultante! !

!PenalesTest methodsFor: 'tests' stamp: 'NR 9/24/2023 06:41:05'!
test34ArqueroQueEsperaPorTiroYSeAdelantaVsPlayeraAMatarSiempreAtaja
	
	| arquero delantero juegoPenales pelota |
	
	"El Arquero que espera y se adelanta ante una pelota playera lenta a matar, siempre la ataja sin importar nada..."	
	"(como la pelota es taaaan lentaaa, el arquero se puede ir a tomar un cafe, verse una serie, volver y aún atajar la pelota habiendose tirado a cualquier lado. Pero igual es más rapida que cuando se la tira a colocar, donde indefectiblemente el arbitro lo detecta...)"
	
	delantero := Delantero decideTirarAMatarSuFuerzaBaseEs:100.
	pelota := Pelota playeraLentaCostaAzul.
	arquero := Arquero esperaPorTiroYSeAdelantaSuFuerzaBaseEs: 1.
	
	juegoPenales := Penales conDelantero: delantero yArquero: arquero.
	
	juegoPenales arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: 2@2 arqueroSeLanzaEnDirección: 0@0.
	
	self assert: 0 equals: juegoPenales puntajeDeDelantero.
	self assert: 1 equals: juegoPenales puntajeDeArquero.
	self assert: 2@1 equals: juegoPenales varDireccionRemateResultante! !


!classDefinition: #Arquero category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #Arquero
	instanceVariableNames: 'estrategiaDeLanzarse fuerzaBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Arquero methodsFor: 'caracteristicas base' stamp: 'NR 9/21/2023 23:39:15'!
fuerza
	
	^fuerzaBase! !


!Arquero methodsFor: 'atajando penales' stamp: 'NR 9/21/2023 23:39:54'!
recibirRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales

	estrategiaDeLanzarse atajarRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales

	! !

!Arquero methodsFor: 'atajando penales' stamp: 'NR 9/21/2023 23:39:50'!
recibirRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarPelotaPlayera enDireccion: direccionTiro jugandoPenales: penales

	estrategiaDeLanzarse atajarRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarPelotaPlayera enDireccion: direccionTiro jugandoPenales: penales

	! !

!Arquero methodsFor: 'atajando penales' stamp: 'NR 9/21/2023 23:40:02'!
recibirRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales

	estrategiaDeLanzarse atajarRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales

	! !

!Arquero methodsFor: 'atajando penales' stamp: 'NR 9/21/2023 23:40:07'!
recibirRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales
	
	estrategiaDeLanzarse atajarRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales

	! !


!Arquero methodsFor: 'initialization' stamp: 'NR 9/22/2023 06:52:01'!
initializeConEstrategiaDeLanzarse: unaEstrategiaDeLanzarse conFuerza: fuerzaBaseDelArquero 
	
	estrategiaDeLanzarse := unaEstrategiaDeLanzarse with: self.
	fuerzaBase := fuerzaBaseDelArquero! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Arquero class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Arquero class
	instanceVariableNames: ''!

!Arquero class methodsFor: 'instance creation' stamp: 'NR 9/22/2023 06:50:54'!
eligeDireccionAntesDeTiroSuFuerzaBaseEs: fuerzaBaseDelArquero
	
	^self new initializeConEstrategiaDeLanzarse: ElegirDireccionAntesTiro conFuerza: fuerzaBaseDelArquero! !

!Arquero class methodsFor: 'instance creation' stamp: 'NR 9/24/2023 07:44:39'!
esperaPorTiroYSeAdelantaSuFuerzaBaseEs: fuerzaBaseDelArquero

	^self new initializeConEstrategiaDeLanzarse: EsperaTiroYSeAdelanta conFuerza: fuerzaBaseDelArquero! !


!classDefinition: #Atajada category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #Atajada
	instanceVariableNames: 'arquero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Atajada methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:27:29'!
atajarRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales
	
	self subclassResponsibility ! !

!Atajada methodsFor: 'para penales' stamp: 'NR 9/24/2023 08:05:17'!
atajarRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarConPlayera enDireccion: direccionTiro jugandoPenales: penales
	
	self subclassResponsibility ! !

!Atajada methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:27:57'!
atajarRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales
		
	self subclassResponsibility ! !

!Atajada methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:28:11'!
atajarRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales
		
	self subclassResponsibility ! !


!Atajada methodsFor: 'initialization' stamp: 'NR 9/21/2023 23:40:33'!
initializeWith: unArquero

	arquero := unArquero! !


!Atajada methodsFor: 'reglas' stamp: 'NR 9/24/2023 07:52:13'!
arqueroAtajaIgnorandoAlturaTiro

	^ [:coordTiro :coordAtaj | coordTiro x = coordAtaj x]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Atajada class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Atajada class
	instanceVariableNames: ''!

!Atajada class methodsFor: 'instance creation' stamp: 'NR 9/20/2023 06:53:21'!
with: unArquero

	^self new initializeWith: unArquero! !


!classDefinition: #ElegirDireccionAntesTiro category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Atajada subclass: #ElegirDireccionAntesTiro
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!ElegirDireccionAntesTiro methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:41:19'!
atajarRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales

	| fuerzaAtajadaPorElegirAntes |
	
	fuerzaAtajadaPorElegirAntes := arquero fuerza * 1.5.
	
	penales fuerzaDeTiroResultanteEnPenal: fuerzaTiroAColocar; fuerzaDeAtajadaResultanteEnPenal: fuerzaAtajadaPorElegirAntes! !

!ElegirDireccionAntesTiro methodsFor: 'para penales' stamp: 'NR 9/24/2023 08:04:23'!
atajarRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarConPlayera enDireccion: direccionTiro jugandoPenales: penales
	
	| fuerzaAtajada |
	
	fuerzaAtajada := arquero fuerza * 2.
	
	penales fuerzaDeTiroResultanteEnPenal: fuerzaTiroAColocarConPlayera; fuerzaDeAtajadaResultanteEnPenal: fuerzaAtajada! !

!ElegirDireccionAntesTiro methodsFor: 'para penales' stamp: 'NR 9/24/2023 08:02:18'!
atajarRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales
	
	| arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas := self arqueroAtajaIgnorandoAlturaTiro.
	
	penales fuerzaDeTiroResultanteEnPenal: fuerzaTiroAMatarConJabulani; direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatar; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas.! !

!ElegirDireccionAntesTiro methodsFor: 'para penales' stamp: 'NR 9/24/2023 07:41:33'!
atajarRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales

	| arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  :=  self arqueroAtajaIgnorandoAnchoTiro.
	
	penales direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas
	
	! !


!ElegirDireccionAntesTiro methodsFor: 'reglas' stamp: 'NR 9/24/2023 07:42:00'!
arqueroAtajaIgnorandoAnchoTiro

	^ [:coordTiro :coordAtaj | coordTiro y = coordAtaj y]! !


!classDefinition: #EsperaTiroYSeAdelanta category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Atajada subclass: #EsperaTiroYSeAdelanta
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!EsperaTiroYSeAdelanta methodsFor: 'para penales' stamp: 'NR 9/22/2023 00:15:45'!
atajarRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales

	| arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  := self arqueroAtajaIgnorandoAlturaTiro.
	
	penales fuerzaDeTiroResultanteEnPenal: fuerzaTiroAColocar; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas! !

!EsperaTiroYSeAdelanta methodsFor: 'para penales' stamp: 'NR 9/24/2023 08:04:53'!
atajarRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarConPlayera enDireccion: direccionTiro jugandoPenales: penales

	| arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  := self arqueroSiempreSeTiraBien.
	arqueroConFuerzaSuficiente := self aArqueroNuncaLeAlcanzaLaFuerza.
	
	penales fuerzaDeAtajadaResultanteEnPenal: fuerzaTiroAColocarConPlayera; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas; resolverFuerzaSuficienteDeArqueroEnPenalCon:  arqueroConFuerzaSuficiente! !

!EsperaTiroYSeAdelanta methodsFor: 'para penales' stamp: 'NR 9/24/2023 07:40:21'!
atajarRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales
	
	| arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas  := self arqueroSiempreSeTiraBien.
	arqueroConFuerzaSuficiente := self aArqueroNuncaLeAlcanzaLaFuerza.
	
	penales fuerzaDeAtajadaResultanteEnPenal: fuerzaTiroAMatarConJabulani; direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatar; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas; resolverFuerzaSuficienteDeArqueroEnPenalCon: arqueroConFuerzaSuficiente! !

!EsperaTiroYSeAdelanta methodsFor: 'para penales' stamp: 'NR 9/22/2023 00:15:56'!
atajarRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales

	| arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas |
	
	arqueroEnCoordenadasCorrectas := self arqueroSiempreSeTiraBien.
	arqueroConFuerzaSuficiente := self aArqueroSiempreLeAlcanzaLaFuerza.
	
	penales direccionDeRemateResultanteEnPenal: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar; resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroEnCoordenadasCorrectas; resolverFuerzaSuficienteDeArqueroEnPenalCon: arqueroConFuerzaSuficiente! !


!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'NR 9/24/2023 07:49:39'!
aArqueroNuncaLeAlcanzaLaFuerza

	^ [:fuerzaRemate :fuerzaAtraparla| false]! !

!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'NR 9/24/2023 07:51:54'!
aArqueroSiempreLeAlcanzaLaFuerza

	^ [:fuerzaRemate :fuerzaAtraparla | true]! !

!EsperaTiroYSeAdelanta methodsFor: 'reglas' stamp: 'NR 9/24/2023 07:49:51'!
arqueroSiempreSeTiraBien

	^ [:coordTiro :coordAtaj | true]! !


!classDefinition: #Delantero category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #Delantero
	instanceVariableNames: 'estrategiaDeTiro fuerzaBase'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Delantero methodsFor: 'caracteristicas base' stamp: 'NR 9/22/2023 06:52:39'!
fuerza
	
	^fuerzaBase ! !


!Delantero methodsFor: 'initialization' stamp: 'NR 9/22/2023 06:52:57'!
initializeEstrategiaDeTiro: unaEstrategiaDeTiro withFuerza: fuerzaBaseDelDelantero 
	
	estrategiaDeTiro := unaEstrategiaDeTiro with: self.
	fuerzaBase := fuerzaBaseDelDelantero! !


!Delantero methodsFor: 'para penales' stamp: 'NR 9/21/2023 00:34:53'!
patea: pelota conDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

	estrategiaDeTiro rematar: pelota conDireccion: direccionTiro aArquero: arquero jugandoPenales: penales.

	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Delantero class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Delantero class
	instanceVariableNames: ''!

!Delantero class methodsFor: 'instance creation' stamp: 'NR 9/22/2023 06:53:13'!
decideTirarAColocarSuFuerzaBaseEs: fuerzaBaseDelDelantero
	
	^self new initializeEstrategiaDeTiro: AColocar withFuerza: fuerzaBaseDelDelantero! !

!Delantero class methodsFor: 'instance creation' stamp: 'NR 9/22/2023 06:53:18'!
decideTirarAMatarSuFuerzaBaseEs: fuerzaBaseDelDelantero
	
	^self new initializeEstrategiaDeTiro: AMatar withFuerza: fuerzaBaseDelDelantero! !


!classDefinition: #Pelota category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #Pelota
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Pelota methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:29:39'!
siendoPateadaAColocarConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

	self subclassResponsibility ! !

!Pelota methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:30:05'!
siendoPateadaAMatarConFuerza: fuerzaTiroAMatar conDireccionOriginal: direccionOriginalTiro yendoEnDireccion: direccionTiroDesviadoPorAMatar aArquero: arquero jugandoPenales: penales

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Pelota class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Pelota class
	instanceVariableNames: ''!

!Pelota class methodsFor: 'instance creation' stamp: 'NR 9/22/2023 06:54:20'!
jabulaniSudafricanaRapida
	
	^Jabulani new! !

!Pelota class methodsFor: 'instance creation' stamp: 'NR 9/22/2023 06:54:26'!
playeraLentaCostaAzul
	
	^Playera new! !


!classDefinition: #Jabulani category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Pelota subclass: #Jabulani
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Jabulani methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:42:26'!
siendoPateadaAColocarConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

	arquero recibirRemateAColocarJabulaniConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro jugandoPenales: penales
! !

!Jabulani methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:42:32'!
siendoPateadaAMatarConFuerza: fuerzaTiroAMatar conDireccionOriginal: direccionOriginalTiro yendoEnDireccion: direccionTiroDesviadoPorAMatar aArquero: arquero jugandoPenales: penales

	| fuerzaTiroAMatarConJabulani |
	
	fuerzaTiroAMatarConJabulani := fuerzaTiroAMatar * 1.2.
	
	arquero recibirRemateAMatarJabulaniConFuerza: fuerzaTiroAMatarConJabulani enDireccion: direccionTiroDesviadoPorAMatar jugandoPenales: penales
! !


!classDefinition: #Playera category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Pelota subclass: #Playera
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Playera methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:42:39'!
siendoPateadaAColocarConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

	| fuerzaTiroAColocarPelotaPlayera |
	
	fuerzaTiroAColocarPelotaPlayera := fuerzaTiroAColocar * 0.8.

	arquero recibirRemateAColocarPlayeraConFuerza: fuerzaTiroAColocarPelotaPlayera enDireccion: direccionTiro jugandoPenales: penales
! !

!Playera methodsFor: 'para penales' stamp: 'NR 9/22/2023 00:07:09'!
siendoPateadaAMatarConFuerza: fuerzaTiroAMatar conDireccionOriginal: direccionOriginalTiro yendoEnDireccion: direccionTiroDesviadoPorAMatar aArquero: arquero jugandoPenales: penales

	| direccionTiroDesviadoPorAMatarOPorPlayeraAMatar |
	
	direccionTiroDesviadoPorAMatarOPorPlayeraAMatar := direccionTiroDesviadoPorAMatar.
	(penales tiroAlAngulo: direccionOriginalTiro) ifFalse: [direccionTiroDesviadoPorAMatarOPorPlayeraAMatar := self desviarDireccionDosHaciaArriba: direccionTiroDesviadoPorAMatar].
	
	arquero recibirRemateAMatarPlayeraConFuerza: fuerzaTiroAMatar enDireccion: direccionTiroDesviadoPorAMatarOPorPlayeraAMatar jugandoPenales: penales! !


!Playera methodsFor: 'desvios' stamp: 'NR 9/22/2023 00:05:48'!
desviarDireccionDosHaciaArriba: direccionTiro

	^(direccionTiro x)@(direccionTiro y+2)! !


!classDefinition: #Penales category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #Penales
	instanceVariableNames: 'delantero arquero varDireccionRemate varFuerzaResultanteDeTiro varFuerzaResultanteDeAtajada puntajeDeDelantero puntajeDeArquero arqueroConFuerzaSuficiente arqueroEnCoordenadasCorrectas varDireccionAtajada'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!Penales methodsFor: 'VAR' stamp: 'NR 9/24/2023 07:57:07'!
registrarValoresDelVARAnterioresAlRemateConDireccion: direccionTiro yArqueroLanzandoseA: direccionArquero

	varFuerzaResultanteDeTiro := delantero fuerza.
	varFuerzaResultanteDeAtajada := arquero fuerza.	
	varDireccionRemate := direccionTiro.
	varDireccionAtajada := direccionArquero! !

!Penales methodsFor: 'VAR' stamp: 'NR 9/21/2023 23:44:03'!
varDireccionRemateResultante
	
	^varDireccionRemate
	! !

!Penales methodsFor: 'VAR' stamp: 'NR 9/24/2023 07:56:02'!
varFuerzaResultanteDeAtajada
	
	^varFuerzaResultanteDeAtajada
	! !

!Penales methodsFor: 'VAR' stamp: 'NR 9/24/2023 07:57:07'!
varFuerzaResultanteDeTiro
	
	^varFuerzaResultanteDeTiro
	! !


!Penales methodsFor: 'juego' stamp: 'NR 9/21/2023 23:44:23'!
arbitroPitaConPelota: pelota delanteroRemataAlArcoConDireccion: direccionTiro arqueroSeLanzaEnDirección: direccionArquero 
	
	self assertValidasDireccionTiro: direccionTiro direccionArquero: direccionArquero.
	
	self registrarValoresDelVARAnterioresAlRemateConDireccion: direccionTiro yArqueroLanzandoseA: direccionArquero.
	self registrarReglasDePenalesBasicas.
	
	delantero patea: pelota conDireccion: direccionTiro aArquero: arquero jugandoPenales: self.
	
	self arbitroDeterminaGanadorEnBaseAReglasYVAR
! !

!Penales methodsFor: 'juego' stamp: 'NR 9/21/2023 23:44:28'!
direccionDeRemateResultanteEnPenal: direccionRemateResultante
	
	varDireccionRemate := direccionRemateResultante
	! !

!Penales methodsFor: 'juego' stamp: 'NR 9/24/2023 07:56:02'!
fuerzaDeAtajadaResultanteEnPenal: fuerzaAtajadaResultante
	
	varFuerzaResultanteDeAtajada := fuerzaAtajadaResultante
	! !

!Penales methodsFor: 'juego' stamp: 'NR 9/24/2023 07:57:07'!
fuerzaDeTiroResultanteEnPenal: fuerzaTiroResultante
	
	varFuerzaResultanteDeTiro := fuerzaTiroResultante
	! !


!Penales methodsFor: 'reglas' stamp: 'NR 9/21/2023 23:27:14'!
coordenadasAngulosDeArco

	^ {0@0. 0@2. 2@0. 2@2}! !

!Penales methodsFor: 'reglas' stamp: 'NR 9/24/2023 18:50:04'!
coordenadasDentroArco: direccion

	^direccion between: 0@0 and: 2@2! !

!Penales methodsFor: 'reglas' stamp: 'NR 9/21/2023 23:45:02'!
registrarReglasDePenalesBasicas

	arqueroEnCoordenadasCorrectas := [:coordTiro :coordAtaj | coordTiro = coordAtaj].
	arqueroConFuerzaSuficiente := [:fuerzaRemate :fuerzaAtraparla | fuerzaRemate <= fuerzaAtraparla]! !

!Penales methodsFor: 'reglas' stamp: 'NR 9/21/2023 23:45:07'!
resolverCoordenadasDeArqueroCorrectasDePenalCon: arqueroCoordenadasCorrectas 
	
	arqueroEnCoordenadasCorrectas := arqueroCoordenadasCorrectas
	
	! !

!Penales methodsFor: 'reglas' stamp: 'NR 9/21/2023 23:45:12'!
resolverFuerzaSuficienteDeArqueroEnPenalCon: arqueroFuerzaSuficiente
	
	arqueroConFuerzaSuficiente  := arqueroFuerzaSuficiente

	
	! !

!Penales methodsFor: 'reglas' stamp: 'NR 9/21/2023 23:27:14'!
tiroAlAngulo: direccionTiro
	
	^self coordenadasAngulosDeArco includes: direccionTiro! !


!Penales methodsFor: 'initialization' stamp: 'NR 9/24/2023 07:54:34'!
initializeConDelantero: unDelantero yArquero: unArquero 
	
	delantero := unDelantero.
	arquero := unArquero.
	puntajeDeDelantero  := 0.
	puntajeDeArquero := 0
	
	! !


!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:02'!
arbitroDeterminaGanadorEnBaseAReglasYVAR

	^ (self remateVaAlArco) ifFalse: 
		[self puntoParaArquero] ifTrue:
		[(self arqueroEligeCorrectamenteYTieneLaFuerzaParaDetenerElRemate) ifTrue: 
			[self atajoArquero] ifFalse: 
			[self golDelantero]]! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:08'!
arqueroEligeCorrectamenteYTieneLaFuerzaParaDetenerElRemate

	^ self arqueroSeLanzaAPosicionDelTiro and: [self arqueroTieneFuerzaSuficienteParaDetenerRemate]! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:12'!
arqueroSeLanzaAPosicionDelTiro

	^ arqueroEnCoordenadasCorrectas value: varDireccionRemate value: varDireccionAtajada! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/24/2023 07:57:07'!
arqueroTieneFuerzaSuficienteParaDetenerRemate

	^arqueroConFuerzaSuficiente value: varFuerzaResultanteDeTiro value: varFuerzaResultanteDeAtajada! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:22'!
atajoArquero

	self puntoParaArquero
! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:27'!
golDelantero

	self puntoParaDelantero
! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/24/2023 07:54:34'!
puntajeDeArquero
	
	^puntajeDeArquero
	! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/24/2023 07:54:24'!
puntajeDeDelantero
	
	^puntajeDeDelantero
	! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/24/2023 07:54:35'!
puntoParaArquero

	puntajeDeArquero := 1
! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/24/2023 07:54:24'!
puntoParaDelantero

	puntajeDeDelantero := 1
! !

!Penales methodsFor: 'ganador' stamp: 'NR 9/21/2023 23:43:51'!
remateVaAlArco

	^ self coordenadasDentroArco: varDireccionRemate! !


!Penales methodsFor: 'asserts' stamp: 'NR 9/19/2023 20:44:37'!
assertValidaDireccion: direccion error: mensajeError
	
	(self coordenadasDentroArco: direccion) ifFalse: [self error: mensajeError].	
	! !

!Penales methodsFor: 'asserts' stamp: 'NR 9/19/2023 08:11:10'!
assertValidasDireccionTiro: direccionTiro direccionArquero: direccionArquero

	self assertValidaDireccion: direccionTiro error: Penales direccionTiroFueraDeRango.
	self assertValidaDireccion:  direccionArquero error: Penales direccionArqueroFueraDeRango! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Penales class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Penales class
	instanceVariableNames: ''!

!Penales class methodsFor: 'instance creation' stamp: 'NR 5/2/2023 06:22:13'!
conDelantero: delantero yArquero: arquero 

	^self new initializeConDelantero: delantero yArquero: arquero ! !


!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:49'!
direccionArqueroFueraDeRango
	
	^'El arquero debe lanzarse a coordenadas válidas'! !

!Penales class methodsFor: 'message errors' stamp: 'NR 9/19/2023 06:12:32'!
direccionTiroFueraDeRango
	
	^'La pelota debe dirigirse a coordenadas válidas'! !


!classDefinition: #RemateAArco category: 'ISW1-2023-2C-Parcial-1-Solu1'!
Object subclass: #RemateAArco
	instanceVariableNames: 'delantero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!RemateAArco methodsFor: 'initialization' stamp: 'NR 9/21/2023 23:47:02'!
initializeWith: unDelantero

	delantero := unDelantero! !


!RemateAArco methodsFor: 'para penales' stamp: 'NR 9/21/2023 16:30:35'!
rematar: pelota conDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RemateAArco class' category: 'ISW1-2023-2C-Parcial-1-Solu1'!
RemateAArco class
	instanceVariableNames: ''!

!RemateAArco class methodsFor: 'instance creation' stamp: 'NR 9/20/2023 06:56:48'!
with: unDelantero
	
	^self new initializeWith: unDelantero! !


!classDefinition: #AColocar category: 'ISW1-2023-2C-Parcial-1-Solu1'!
RemateAArco subclass: #AColocar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!AColocar methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:47:15'!
rematar: pelota conDireccion: direccionTiro aArquero: arquero jugandoPenales: penales
	
	| fuerzaTiroAColocar |
	
	fuerzaTiroAColocar := delantero fuerza * 0.5.

	pelota siendoPateadaAColocarConFuerza: fuerzaTiroAColocar enDireccion: direccionTiro aArquero: arquero jugandoPenales: penales

! !


!classDefinition: #AMatar category: 'ISW1-2023-2C-Parcial-1-Solu1'!
RemateAArco subclass: #AMatar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ISW1-2023-2C-Parcial-1-Solu1'!

!AMatar methodsFor: 'para penales' stamp: 'NR 9/21/2023 23:58:24'!
rematar: pelota conDireccion: direccionOriginalTiro aArquero: arquero jugandoPenales: penales
	
	| direccionTiroDesviadoPorAMatar fuerzaTiroAMatar |
	
	fuerzaTiroAMatar := delantero fuerza.
	direccionTiroDesviadoPorAMatar := direccionOriginalTiro.
	(penales tiroAlAngulo: direccionOriginalTiro) ifTrue: [direccionTiroDesviadoPorAMatar:= self desviarDireccionAAlturaMedia: direccionOriginalTiro].
	
	pelota siendoPateadaAMatarConFuerza: fuerzaTiroAMatar conDireccionOriginal: direccionOriginalTiro yendoEnDireccion: direccionTiroDesviadoPorAMatar aArquero: arquero jugandoPenales: penales
! !


!AMatar methodsFor: 'desvios' stamp: 'NR 9/21/2023 23:58:24'!
desviarDireccionAAlturaMedia: direccionOriginalTiro

	^ (direccionOriginalTiro x)@1! !
