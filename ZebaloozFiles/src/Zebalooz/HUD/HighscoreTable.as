package Zebalooz.HUD 
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
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
	public class HighscoreTable extends Entity
	{
		private var TextNameDrawer:Array = new Array();
		private var TextScoreDrawer:Array = new Array();
		private var highscoreTableName:Text = new Text("Highscore Table");
		private var pressEnterToReturn:Text = new Text("Press Space to try again");
		private var flashingAlarm:Alarm = new Alarm(30, FlashText, Tween.LOOPING);
		
		public function HighscoreTable() 
		{
			highscoreTableName.size = 16;
			highscoreTableName.color = 0x000000;
			highscoreTableName.centerOO();
			highscoreTableName.angle = 90;
			
			for (var i:Number = 0; i < 10; i += 1)
			{
				var textName:Text = new Text(GlobalObject.PlayerHighScoreData[i].Name);
				textName.size = 8;
				textName.color = 0xFFFFFF;
				
				TextNameDrawer.push(textName);
				
				var textScore:Text = new Text(GlobalObject.PlayerHighScoreData[i].Score.toString());
				textScore.size = 8;
				textScore.color = 0xFFFFFF;
				textScore.x = -textScore.width;
				
				TextScoreDrawer.push(textScore);
			}
			
			pressEnterToReturn.size = 8;
			pressEnterToReturn.color = 0xFFFFFF;
			pressEnterToReturn.centerOO();
			
			addTween(flashingAlarm, true);
			
			layer = LayerConstant.HUD_LAYER;
		}
		
		private function FlashText():void
		{
			pressEnterToReturn.alpha = 1 - pressEnterToReturn.alpha;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (Input.released(Key.SPACE))
			{
				FP.world.remove(this);
				GlobalObject.StartGame();
			}
		}
		
		override public function render():void 
		{
			super.render();
			highscoreTableName.render(FP.buffer, new Point(FP.width / 2 - 80, FP.height/2 - 18), FP.camera);
			
			for (var i:Number = 0; i < 10; i += 1)
			{
				TextNameDrawer[i].render(FP.buffer, new Point(90, 50 + i * 11), FP.camera);
				TextScoreDrawer[i].render(FP.buffer, new Point(FP.width - 90, 50 + i * 11), FP.camera);
			}
			
			pressEnterToReturn.render(FP.buffer, new Point(FP.width / 2, FP.height - 40), FP.camera);
		}
		
	}

}