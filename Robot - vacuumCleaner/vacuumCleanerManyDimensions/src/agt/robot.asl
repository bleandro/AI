// Agent robot in project vacuumCleanerRobot

!start.

/* Plans */

// Starting plans
+!start : true <- 
          !init;
          !searchArtifact;
          !searchTrash.
         
// Init some values. Gets what was passed or create as default.
+!init : true <-
         !initDirection;
         !initPosition.
          
//Effectively initiate values
+!initDirection : direction(X, Y).
-!initDirection <- +direction(right, down).
+!initPosition : at(X, Y).
-!initPosition <- +at(0, 0).
         
//Lookup the Artifact class "Rooms" that we need to use here
+!searchArtifact <- lookupArtifact("rooms", Id);
                    focus(Id).
-!searchArtifact <- !searchArtifact.
                  
//Initiate the search for trash                  
+!searchTrash <- .drop_all_intentions;
                 !turnDirection;
                 !move;
                 !searchTrash.
                 
//Change direction when it's needed according to rules of space
/* (RIGHT, DOWN) */
+!turnDirection : at(X, Y) & rows(X) & cols(Y) & direction(right, down)
                <- -+direction(left, up).
+!turnDirection : at(X, Y) & cols(Y) & direction(right, down)
                <- -+direction(left, down); !moveTo(X, Y, X+1, Y).

/* (RIGHT, UP) */
+!turnDirection : at(0, Y) & cols(Y) & direction(right, up)
                <- -+direction(left, down).
+!turnDirection : at(X, Y) & cols(Y) & direction(right, up) & X \== 0
                <- -+direction(left, up); !moveTo(X, Y, X-1, Y).

/* (LEFT, DOWN) */
+!turnDirection : at(X, 0) & rows(X) & direction(left, down)
                <- -+direction(right, up).
+!turnDirection : at(X, Y) & direction(left, down) & Y == 0
                <- -+direction(right, down); !moveTo(X, Y, X+1, Y).

/* (LEFT, UP) */
+!turnDirection : at(0, 0) & direction(left, up)
                <- -+direction(right, down).
+!turnDirection : at(X, Y) & direction(left, up) & Y == 0
                <- -+direction(right, up); !moveTo(X, Y, X-1, Y).
-!turnDirection.

//Check if the room is dirty and continue moving all the rooms
+!move : at(X, Y) & direction(right, _) <- !moveTo(X, Y, X, Y+1).
+!move : at(X, Y) & direction(left, _) <- !moveTo(X, Y, X, Y-1).

+!moveTo(I, J, X, Y) : true <- .wait(1000);
                               isRoomDirty(I, J);
                               .println("Moving to room [", X, ",", Y, "]");
                               -+at(X, Y).

//If the room was dirty the Artifact will send a signal. Here we get the signal and clean the room.
+dirty : at(X, Y) <- .println("Cleaning room [", X, ",", Y, "]");
                     clean(X, Y).

{ include("$jacamoJar/templates/common-cartago.asl") }
{ include("$jacamoJar/templates/common-moise.asl") }

// uncomment the include below to have a agent that always complies with its organization  
//{ include("$jacamoJar/templates/org-obedient.asl") }