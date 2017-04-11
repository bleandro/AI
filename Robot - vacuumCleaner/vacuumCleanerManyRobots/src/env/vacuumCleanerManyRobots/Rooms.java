// CArtAgO artifact code for project vacuumCleanerRobot

package vacuumCleanerManyRobots;

import java.util.Random;

import cartago.*;

public class Rooms extends Artifact {
	private boolean dirtyRoom[] = null;
	private Random rnd = new Random(System.currentTimeMillis());	
	
	void init(int numberOfRooms) {
		dirtyRoom = new boolean[numberOfRooms];
		defineObsProperty("numberOfRooms", numberOfRooms);
		
		for (boolean dirty : dirtyRoom) {
			dirty = false;
		}
		
		execInternalOp("run");
	}
	
	@INTERNAL_OPERATION
	void run() {
		while(true)
		{
			if(rnd.nextDouble() <= 0.7) {
				int dirtyRoomIndex = rnd.nextInt(dirtyRoom.length);
				System.out.println("Trash in " + dirtyRoomIndex);
				dirtyRoom[dirtyRoomIndex] = true;
			}
			
			await_time(4000);
		}
	}
	
	@OPERATION
	void isRoomDirty(int roomIndex) {
		if (dirtyRoom[roomIndex])
			signal("dirty");
	}
	
	@OPERATION
	void clean(int roomIndex) {
		dirtyRoom[roomIndex] = false;
	}
}