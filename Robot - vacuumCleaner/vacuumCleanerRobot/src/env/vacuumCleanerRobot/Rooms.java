// CArtAgO artifact code for project vacuumCleanerRobot

package vacuumCleanerRobot;

import java.util.Random;

import cartago.*;

public class Rooms extends Artifact {
	private boolean dirtyRoom[] = null;
	private int robotAt = 0;
	private Random rnd = new Random(System.currentTimeMillis());	
	
	void init(int numberOfRooms) {
		dirtyRoom = new boolean[numberOfRooms];
		defineObsProperty("at", 0);
		
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
	void goLeft() {
		if(this.robotAt - 1 >= 0)
		{
			this.robotAt--;
			getObsProperty("at").updateValue(this.robotAt);
			signal("arrive");
			if(dirtyRoom[this.robotAt])
				signal("dirty");
		}
		else
			signal("border");
	}
	
	@OPERATION
	void goRight() {
		if(this.robotAt + 1 < dirtyRoom.length)
		{
			this.robotAt++;
			getObsProperty("at").updateValue(this.robotAt);
			signal("arrive");
			if(dirtyRoom[this.robotAt])
				signal("dirty");
		}
		else
			signal("border");
	}
	
	@OPERATION
	void clean() {
		if (dirtyRoom[this.robotAt])
			dirtyRoom[this.robotAt] = false;
		else
			signal("noDirty");
	}
}