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
	import Zebalooz.GameEntity.GraphicEntity.WhiteEntity;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HowToPlayEntity extends Entity
	{
		[Embed(source = "../../../assets/Graphics/GameName.png")]private var mainMenu:Class;
		
		private var image:Image = new Image(mainMenu);
		private var howToPlay1:Text;
		private var howToPlay2:Text;
		private var howToPlay3:Text;
		private var howToPlay4:Text;
		private var howToPlay5:Text;
		private var howToPlay6:Text;
		private var howToPlay7:Text;
		private var controls1:Text;
		private var controls2:Text;
		private var controls3:Text;
		private var pressSpaceToStart:Text;
		private var flashingAlarm:Alarm = new Alarm(30, FlashText, Tween.LOOPING);
		
		public function HowToPlayEntity() 
		{
			GlobalObject.PlayMusic();
			image.centerOO();
			
			Text.size = 8;
			howToPlay1 = new Text("How to play?");
			howToPlay1.color = 0x000000;
			howToPlay1.originX = howToPlay1.width;
			howToPlay1.angle = 90;
			
			Text.size = 8;
			
			howToPlay2 = new Text("Keep Moving Forward and");
			howToPlay2.color = 0xFFFFFF;
			
			howToPlay3 = new Text("Avoid being killed so avoid");
			howToPlay3.color = 0xFFFFFF;
			
			howToPlay4 = new Text("(1) Get stuck by garbage");
			howToPlay4.color = 0xFFFFFF;
			
			howToPlay5 = new Text("(2) Hit by garbage bag");
			howToPlay5.color = 0xFFFFFF;
			
			howToPlay6 = new Text("(3) Hit by car");
			howToPlay6.color = 0xFFFFFF;
			
			howToPlay7 = new Text("(4) Fall in sewer manhole");
			howToPlay7.color = 0xFFFFFF;
			
			Text.size = 8;
			controls1 = new Text("Controls");
			controls1.color = 0x000000;
			controls1.originX = controls1.width;
			controls1.angle = 90;
			
			Text.size = 8;
			
			controls2 = new Text("Arrows: Move your player");
			controls2.color = 0xFFFFFF;
			
			controls3 = new Text("Space: Make player jump");
			controls3.color = 0xFFFFFF;
			
			pressSpaceToStart = new Text("Press Space to start");
			pressSpaceToStart.centerOO();
			pressSpaceToStart.color = 0xFFFFFF;
			
			layer = LayerConstant.HUD_LAYER;
			WhiteEntity.ShowWhiteLayer();
			
			addTween(flashingAlarm, true);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				FP.world.remove(this);
				GlobalObject.StartGame();
			}
		}
		
		private function FlashText():void
		{
			pressSpaceToStart.alpha = 1 - pressSpaceToStart.alpha;
		}
		
		override public function render():void 
		{
			super.update();
			
			image.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2, y + image.height / 2 - 10), FP.camera);
			
			howToPlay1.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 65, y + GlobalObject.GameHeight / 2 + 2 - 10), FP.camera);
			howToPlay2.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 1 - 10), FP.camera);
			howToPlay3.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 11 - 10), FP.camera);
			howToPlay4.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 21 - 10), FP.camera);
			howToPlay5.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 31 - 10), FP.camera);
			howToPlay6.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 41 - 10), FP.camera);
			howToPlay7.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 51 - 10), FP.camera);
			
			controls1.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 65, y + GlobalObject.GameHeight / 2 + 60), FP.camera);
			controls2.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 70), FP.camera);
			controls3.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 55, y + GlobalObject.GameHeight / 2 + 80), FP.camera);
			
			pressSpaceToStart.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 + 3, y + GlobalObject.GameHeight / 2 + 110), FP.camera);
		}
	}

}