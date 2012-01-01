package Zebalooz.HUD 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HUDDrawer extends Entity
	{
		[Embed(source = "../../../assets/Graphics/ScoreImage.png")]private var scoreImage:Class;
		
		private var scoreWordText:Text;
		private var scoreText:Text;
		private var timeReaming:int;
		private var scoreWordImage:Image;
		private var jumpText:Text;
		private var jumpReady:Boolean = true;
		
		public function HUDDrawer()
		{
			Text.size = 8;
			
			scoreWordText = new Text("Score");
			scoreWordText.centerOO();
			scoreWordText.color = 0x000000;
			
			Text.size = 16;
			
			scoreText = new Text("0");
			scoreText.centerOO();
			scoreText.color = 0x000000;
			
			Text.size = 8;
			
			scoreWordImage = new Image(scoreImage);
			scoreWordImage.centerOO();
			
			jumpText = new Text("Jump Ready");
			jumpText.centerOO();
			jumpText.color = 0xFFFFFF;
			
			layer = LayerConstant.HUD_LAYER;
		}
		
		override public function update():void 
		{
			super.update();
			scoreText.text = GlobalObject.score.toString();
			scoreText.centerOO();
			
			timeReaming = Math.ceil(GlobalObject.GetTimeForJump() / GlobalObject.GameFrameRate);
			jumpReady = timeReaming == 0;
			
			if (jumpReady)
			{
				jumpText = new Text("Jump Ready");
			}
			else
			{
				jumpText.text = "Jump will be ready in " + timeReaming.toString() + " secs";
			}
			
			jumpText.centerOO();
			jumpText.color = 0xFFFFFF;
		}
		
		override public function render():void 
		{
			super.render();
			
			scoreWordImage.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2, y + scoreWordImage.height/2), FP.camera);
			scoreWordText.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 + 1, y + 5), FP.camera)
			scoreText.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2 + 1, y + 18), FP.camera);
			
			jumpText.render(FP.buffer, new Point(x + GlobalObject.GameWidth / 2, y + GlobalObject.GameHeight - 4), FP.camera);
		}
		
		public static function ShowHUD():void
		{
			FP.world.add(new HUDDrawer());
		}
		
		public static function RemoveHUD():void
		{
			FP.world.remove(FP.world.classFirst(HUDDrawer));
		}
	}

}