
module MainArgs
	( MainArg(..)
	, mainArgs)
where
import System.Console.ParseArgs

data MainArg
	= ArgHelp
	| ArgWindowSize
	| ArgSolver
	| ArgMaxSteps
	| ArgDrawTree
	| ArgTimeStep
	| ArgRate
	| ArgBodyCount
	| ArgBodyMass
	| ArgEpsilon
	| ArgDiscSize
	| ArgStartSpeed
	deriving (Eq, Ord, Show)
	
mainArgs :: [Arg MainArg]
mainArgs
 = 	[ Arg	{ argIndex	= ArgHelp
		, argAbbr	= Just 'h'
		, argName	= Just "help"
		, argData	= Nothing
		, argDesc	= "Print this usage help." }

	, Arg	{ argIndex	= ArgWindowSize
		, argAbbr	= Nothing
		, argName	= Just "window"
		, argData	= argDataDefaulted "Int" ArgtypeInt 800
		, argDesc	= "Size of window in pixels (default 800)" }

	, Arg	{ argIndex	= ArgSolver
		, argAbbr	= Nothing
		, argName	= Just "solver"
		, argData	= argDataDefaulted "name" ArgtypeString "vector-naive"
		, argDesc	= "Solver to use. One of: list-bh, vector-naive, vector-bh, nested-bh." }

	, Arg	{ argIndex	= ArgMaxSteps
		, argAbbr	= Nothing
		, argName	= Just "max-steps"
		, argData	= argDataDefaulted "steps" ArgtypeInt 0
		, argDesc	= "Exit simulation after this many steps." }

	, Arg	{ argIndex	= ArgDrawTree
		, argAbbr	= Nothing
		, argName	= Just "tree"
		, argData	= Nothing
		, argDesc	= "Draw the Barnes-Hut quad tree"}

	, Arg	{ argIndex	= ArgTimeStep
		, argAbbr	= Just 't'
		, argName	= Just "timestep"
		, argData	= argDataDefaulted "Double" ArgtypeDouble 1
		, argDesc	= "Time step between states (default 1)" }

	, Arg	{ argIndex	= ArgRate
		, argAbbr	= Just 'r'
		, argName	= Just "rate"
		, argData	= argDataDefaulted "Double" ArgtypeInt 50
		, argDesc	= "Number of simulation steps per second of real time (default 50)" }

	, Arg	{ argIndex	= ArgBodyCount
		, argAbbr	= Just 'b'
		, argName	= Just "bodies"
		, argData	= argDataDefaulted "Int" ArgtypeInt 200 
		, argDesc	= "Number of bodies in simulation (default 200)" }

	, Arg	{ argIndex	= ArgBodyMass
		, argAbbr	= Just 'm'
		, argName	= Just "mass"
		, argData	= argDataDefaulted "Double" ArgtypeDouble 10
		, argDesc	= "Mass of each body (default 10)" }

	, Arg	{ argIndex	= ArgEpsilon
		, argAbbr	= Just 'e'
		, argName	= Just "epsilon"
		, argData	= argDataDefaulted "Double" ArgtypeDouble 100
		, argDesc	= "Smoothing parameter (default 100)" }
		
	, Arg	{ argIndex	= ArgDiscSize
		, argAbbr	= Just 'd'
		, argName	= Just "disc"
		, argData	= argDataDefaulted "Double" ArgtypeDouble 50
		, argDesc	= "Starting size of disc containing bodies (default 50)" }

	, Arg	{ argIndex	= ArgStartSpeed
		, argAbbr	= Just 's'
		, argName	= Just "speed"
		, argData	= argDataDefaulted "Double" ArgtypeDouble 0.5
		, argDesc	= "Starting rotation speed of bodies (default 0.5)" }
	]
