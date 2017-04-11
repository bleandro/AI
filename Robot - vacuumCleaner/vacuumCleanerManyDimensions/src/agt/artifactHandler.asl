// Agent artifactHandler in project vacuumCleanerManyRobots

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- makeArtifact("rooms", "vacuumCleanerManyDimensions.Rooms", [5,5], ID).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
//{ include("$jacamoJar/templates/org-obedient.asl") }
