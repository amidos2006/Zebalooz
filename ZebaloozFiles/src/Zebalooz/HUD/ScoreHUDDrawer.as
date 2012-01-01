package Zebalooz.HUD 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ScoreHUDDrawer extends Entity
	{
		[Embed(source = "../../../assets/Graphics/HighScore.png")]private var highScoreClass:Class;
		
		private var highScoreImage:Image;
		private var currentHighScoreText:Text;
		private var bestHighScoreText:Text;
		
		public function ScoreHUDDrawer(currentHighScore:int, bestHighScore:int) 
		{
			Text.size = 16;
			currentHighScoreText = new Text(currentHighScore.toString());
			currentHighScoreText.centerOO();
			currentHighScoreText.color = 0xDDDDDD;
			
			Text.size = 8;
			bestHighScoreText = new Text(bestHighScore.toString());
			bestHighScoreText.centerOO();
			bestHighScoreText.color = 0xDDDDDD;
			
			highScoreImage = new Image(highScoreClass);
			
			layer = LayerConstant.HUD_LAYER;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.pressed(Key.SPACE))
			{
				RemoveHighScore();
				
				GlobalObject.StartGame();
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			highScoreImage.render(FP.buffer, new Point(0, 0), FP.camera);
			currentHighScoreText.render(FP.buffer, new Point(160, 108), FP.camera);
			bestHighScoreText.render(FP.buffer, new Point(160, 144), FP.camera);
		}
		
		public static function ShowHighScore(currentHighScore:int, bestHighScore:int):void
		{
			FP.world.add(new ScoreHUDDrawer(currentHighScore, bestHighScore));
		}
		
		public static function RemoveHighScore():void
		{
			FP.world.remove(FP.world.classFirst(ScoreHUDDrawer));
		}
	}

}