// CArtAgO artifact code for project vacuumCleanerRobot

package vacuumCleanerManyDimensions;

import java.util.Random;

import cartago.*;

public class Rooms extends Artifact {
	private RoomState roomStates[][] = null;
	private Random rnd = new Random(System.currentTimeMillis());	
	
	void init(int numberOfRooms_rows, int numberYOfRooms_cols) {
		roomStates = new RoomState[numberOfRooms_rows][numberYOfRooms_cols];
		defineObsProperty("rows", numberOfRooms_rows-1);
		defineObsProperty("cols", numberYOfRooms_cols-1);
		
		for (RoomState[] roomRows : roomStates) {
			for (RoomState roomCols : roomRows) {
				roomCols = RoomState.Clean;
			}
		}
		
		execInternalOp("run");
	}
	
	@INTERNAL_OPERATION
	void run() {
		while(true)
		{
			if(rnd.nextDouble() <= 0.7) {
				int roomRow = rnd.nextInt(roomStates.length);
				int roomCol = rnd.nextInt(roomStates[0].length);
				
				System.out.println("Trash in [" + roomRow + "," + roomCol + "]");
				roomStates[roomRow][roomCol] = RoomState.Dirty;
			}
			
			await_time(4000);
		}
	}
	
	@OPERATION
	void isRoomDirty(int roomRow, int roomCol) {
		if (roomStates[roomRow][roomCol] == RoomState.Dirty)
			signal("dirty");
	}
	
	@OPERATION
	void clean(int roomRow, int roomCol) {
		roomStates[roomRow][roomCol] = RoomState.Clean;
	}
}