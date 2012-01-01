package Zebalooz.HUD 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class StoryEntity extends Entity
	{
		private var storyText:Text;
		
		private var storyLine1:Text;
		private var storyLine2:Text;
		private var storyLine3:Text;
		private var storyLine4:Text;
		private var storyLine5:Text;
		private var storyLine6:Text;
		private var storyLine7:Text;
		
		private var pressSpaceToStart:Text;
		
		private var flashingAlarm:Alarm = new Alarm(30, FlashText, Tween.LOOPING);
		
		public function StoryEntity() 
		{
			Text.size = 16;
			storyText = new Text("Introduction");
			storyText.angle = 90;
			storyText.color = 0x000000;
			storyText.centerOO();
			
			Text.size = 8;
			storyLine1 = new Text("Garbage became one of the most difficult");
			storyLine2 = new Text("problems that face our society.");
			storyLine3 = new Text("If we didn't find a solution for that problem");
			storyLine4 = new Text("in the simplest case when someone throw");
			storyLine5 = new Text("a garbage bag from the window it may fall");
			storyLine6 = new Text("on your head and kill you.");
			storyLine7 = new Text("This game shows the problem in a funny way.");
			
			storyLine1.color = 0xFFFFFF;
			storyLine2.color = 0xFFFFFF;
			storyLine3.color = 0xFFFFFF;
			storyLine4.color = 0xFFFFFF;
			storyLine5.color = 0xFFFFFF;
			storyLine6.color = 0xFFFFFF;
			storyLine7.color = 0xFFFFFF;
			
			pressSpaceToStart = new Text("Press Space to Start");
			pressSpaceToStart.color = 0xFFFFFF;
			pressSpaceToStart.centerOO();
			
			addTween(flashingAlarm, true);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				FP.world.remove(this);
				FP.world.add(new MainMenuEntity());
			}
		}
		
		private function FlashText():void
		{
			pressSpaceToStart.alpha = 1 - pressSpaceToStart.alpha;
		}
		
		override public function render():void 
		{
			super.render();
			
			storyText.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 100, y + GlobalObject.GameHeight / 2), FP.camera);
			
			storyLine1.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 - 45), FP.camera);
			storyLine2.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 - 35), FP.camera);
			storyLine3.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 - 15), FP.camera);
			storyLine4.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 - 5), FP.camera);
			storyLine5.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 + 5), FP.camera);
			storyLine6.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 + 15), FP.camera);
			storyLine7.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 90, y + GlobalObject.GameHeight / 2 + 35), FP.camera);
			
			pressSpaceToStart.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 + 3, y + GlobalObject.GameHeight / 2 + 80), FP.camera);
		}
	}

}