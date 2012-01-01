package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import Zebalooz.GameWorld.StreetWorld;
	import Zebalooz.GlobalObject;
	
	/**
	 * ...
	 * @author Amidos
	 */
	public class Main extends Engine
	{
		
		public function Main() 
		{
			super(GlobalObject.GameWidth, GlobalObject.GameHeight, GlobalObject.GameFrameRate, true);
			FP.screen.scale = GlobalObject.GameScale;
			
			FP.world = new StreetWorld();
			
			GlobalObject.LoadScore();
			GlobalObject.IntializeHighScore();
		}
	}
	
}