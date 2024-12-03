'From Cuis6.3 [latest update: #6350] on 3 December 2024 at 9:26:36 am'!

!PacmanGameTest methodsFor: 'tests' stamp: 'TRN 12/3/2024 01:40:03'!
test24GameIsNotOverWhenGhostsHoverOverPills

	| board game |

	board := StringPacmanBoard representedAs:#(
'#####'
'#-BC#'
'#*-p#'
'#####').

	nextIntegers := ReadStream on: #().
	game := PacmanGame on: board randomizingWith: self.
	4 timesRepeat: [game tick].
	
	self deny: game isOver.
	self assert: game stringRepresentationOfBoard equals:#(
'#####'
'#B=C#'
'#p==#'
'#####') .
! !


!PacmanElement methodsFor: 'testing' stamp: 'TRN 12/3/2024 01:39:09'!
isOrIsOnPill

	^false! !


!Ghost methodsFor: 'testing' stamp: 'TRN 12/3/2024 01:39:39'!
isOrIsOnPill

	^previousElement isOrIsOnPill ! !


!Pill methodsFor: 'testing' stamp: 'TRN 12/3/2024 01:39:09'!
isOrIsOnPill
	
	^true! !


!PacmanGame methodsFor: 'testing' stamp: 'TRN 12/3/2024 01:39:09'!
areThereNoPills
	
	^board allSatisfy: [ :aPacmanElement | aPacmanElement isOrIsOnPill not ]! !

