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
	public class MainMenuEntity extends Entity
	{
		[Embed(source = "../../../assets/Graphics/GameName.png")]private var mainMenu:Class;
		
		private var image:Image = new Image(mainMenu);
		private var credits1:Text;
		private var credits2:Text;
		private var credits3:Text;
		private var credits4:Text;
		private var pressSpaceToStart:Text;
		private var flashingAlarm:Alarm = new Alarm(30, FlashText, Tween.LOOPING);
		
		public function MainMenuEntity() 
		{
			GlobalObject.PlayMusic();
			image.centerOO();
			
			Text.size = 8;
			credits1 = new Text("Credits");
			credits1.color = 0x000000;
			credits1.originX = credits1.width;
			credits1.angle = 90;
			
			Text.size = 8;
			
			credits2 = new Text("Game by: Amidos");
			credits2.color = 0xFFFFFF;
			
			credits3 = new Text("Art by: Tomas Barrios");
			credits3.color = 0xFFFFFF;
			
			credits4 = new Text("Music by: Easyname");
			credits4.color = 0xFFFFFF;
			
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
				FP.world.add(new HowToPlayEntity());
				WhiteEntity.ShowWhiteLayer();
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
			
			credits1.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 50, y + GlobalObject.GameHeight / 2), FP.camera);
			credits2.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 40, y + GlobalObject.GameHeight / 2 + 1), FP.camera);
			credits3.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 40, y + GlobalObject.GameHeight / 2 + 11), FP.camera);
			credits4.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 - 40, y + GlobalObject.GameHeight / 2 + 21), FP.camera);
			
			pressSpaceToStart.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 + 3, y + GlobalObject.GameHeight / 2 + 80), FP.camera);
		}
	}

}