// Agent robot in project vacuumCleanerRobot

/* Initial beliefs and rules */

/* Initial goals */

!start.

/* Plans */

+!start : true <- 
          !initDirection;
          !initPosition;
          !searchArtifact;
          !searchTrash.
          
+!initDirection : direction(X).
-!initDirection <- +direction(right).
+!initPosition : at(X).
-!initPosition <- +at(0).
         
+!searchArtifact <- lookupArtifact("rooms", Id);
                    focus(Id).
-!searchArtifact <- !searchArtifact.
                  
+!searchTrash <- .drop_all_intentions;
                 !turnDirection;
                 !move;
                 .wait(1000);
                 !searchTrash.
                 
+!turnDirection : at(X) & numberOfRooms(Y) & direction(right) & X == Y - 1 <- -+direction(left).
+!turnDirection : at(X) & numberOfRooms(Y) & direction(left) & X == 0 <- -+direction(right).
-!turnDirection.

+!move : at(X) & direction(right) <- isRoomDirty(X);
                                     .println("Moving to room ", X+1);
                                     -+at(X+1).
+!move : at(X) & direction(left) <- isRoomDirty(X);
                                    .println("Moving to room ", X-1);
                                    -+at(X-1).

+dirty : at(X) <- .println("Cleaning room ", X);
                  clean(X). 

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
//{ include("$jacamoJar/templates/org-obedient.asl") }