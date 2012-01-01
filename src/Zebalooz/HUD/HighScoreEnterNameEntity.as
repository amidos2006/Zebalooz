package Zebalooz.HUD 
{
	import flash.geom.Point;
	import mochi.as3.MochiScores;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class HighScoreEnterNameEntity extends Entity
	{
		private const maxPlayerName:Number = 8;
		
		private var yourScore:Text;
		private var bestScore:Text;
		private var enterYourNameText:Text = new Text("Enter Your Name");
		private var playerName:String = "";
		private var retryName:Text = new Text("Retry Again");
		private var pressEnterWhenFinish:Text = new Text("Submit your score");
		private var hintText:Text = new Text("Use Arrows to choose and Space to select");
		private var overChoice:Number = 0;
		private var playerNameText:Text = new Text("");
		private var playerScore:Number;
		private var enterPressed:Boolean = false;
		
		public function HighScoreEnterNameEntity(intialPlayerName:String, playerScoreIn:Number, bestScoreYouGet:Number) 
		{
			layer = LayerConstant.HUD_LAYER;
			playerName = intialPlayerName;
			playerScore = playerScoreIn;
			
			enterYourNameText.size = 16;
			enterYourNameText.color = 0x000000;
			enterYourNameText.centerOO();
			enterYourNameText.angle = 90;
			
			playerNameText.size = 16;
			playerNameText.color = 0xFFFFFF;
			
			pressEnterWhenFinish.size = 8;
			pressEnterWhenFinish.color = 0xFFFFFF;
			
			retryName.size = 8;
			retryName.color = 0xFFFFFF;
			
			hintText.size = 8;
			hintText.color = 0xFFFFFF;
			hintText.centerOO();
			
			yourScore = new Text("Your Score: " + playerScoreIn.toString());
			yourScore.size = 8;
			yourScore.color = 0xFFFFFF;
			
			bestScore = new Text("Best Score: " + bestScoreYouGet.toString());
			bestScore.size = 8;
			bestScore.color = 0xFFFFFF;
			
			yourScore.smooth = false;
			enterYourNameText.smooth = false;
			retryName.smooth = false;
			pressEnterWhenFinish.smooth = false;
			hintText.smooth = false;
			playerNameText.smooth = false;
		}
		
		override public function update():void 
		{
			super.update();
			
			if (!enterPressed)
			{
				if (Input.pressed(Key.BACKSPACE))
				{
					if (playerName.length > 0)
					{
						playerName = playerName.substr(0, playerName.length - 1);
					}
				}
				else if (Input.pressed(Key.SPACE))
				{
					if (overChoice == 1)
					{
						GlobalObject.playerName = playerName;
						MochiScores.setBoardID("75354b773d2839f2");
						MochiScores.submit(playerScore, playerName, this, "ScoreSubmited");
						enterPressed = true;
					}
					else
					{
						GlobalObject.StartGame();
						FP.world.remove(this);
					}
				}
				else if (Input.pressed(Key.UP))
				{
					overChoice -= 1;
					if (overChoice < 0)
					{
						overChoice = 1;
					}
				}
				else if (Input.pressed(Key.DOWN))
				{
					overChoice += 1;
					if (overChoice > 1)
					{
						overChoice = 0;
					}
				}
				else
				{
					var inputKey:String = "";
					
					for (var i:Number = Key.A; i <= Key.Z; i += 1)
					{
						if (Input.released(i))
						{
							inputKey = String.fromCharCode(i);
						}
					}
					
					for (i = Key.DIGIT_0; i <= Key.DIGIT_9; i += 1)
					{
						if (Input.released(i))
						{
							inputKey = String.fromCharCode(i);
						}
					}
					
					if (playerName.length < maxPlayerName)
					{
						playerName += inputKey;
					}
				}
			}
			
			playerNameText = new Text(playerName + "_");
			playerNameText.size = 16;
			playerNameText.color = 0xFFFFFF;
			
			if (overChoice == 0)
			{
				retryName.color = 0xFFFFFF;
				pressEnterWhenFinish.color = 0x000000;
			}
			else if(overChoice == 1)
			{
				retryName.color = 0x000000;
				pressEnterWhenFinish.color = 0xFFFFFF;
			}
		}
		
		public function ScoreSubmited(args:Object):void
		{
			if (args.error)
			{
				FP.world.remove(this);
				return;
			}
			
			MochiScores.requestList(this, "OnScoresReceived");
		}
		
		public function OnScoresReceived(args:Object):void
		{
			if (args.error)
			{
				FP.world.remove(this);
				return;
			}
			
			if (args.scores != null)
			{
				var newScores:Object = MochiScores.scoresArrayToObjects(args.scores);
				var count:Number = Math.min(10, newScores.alltime.length);
				
				for (var i:Number = 0; i < count; i += 1)
				{
					GlobalObject.PlayerHighScoreData[i].Name = newScores.alltime[i].name;
					GlobalObject.PlayerHighScoreData[i].Score = newScores.alltime[i].score;
				}
			}
			
			FP.world.remove(this);
			FP.world.add(new HighscoreTable());
		}
		
		override public function render():void 
		{
			super.render();
			
			enterYourNameText.render(FP.buffer, new Point(FP.width / 2 - 40, FP.height / 2 - 10), FP.camera);
			
			yourScore.render(FP.buffer, new Point(FP.width / 2 - 30, FP.height / 2 - 50), FP.camera);
			bestScore.render(FP.buffer, new Point(FP.width / 2 - 30, FP.height / 2 - 40), FP.camera);
			playerNameText.render(FP.buffer, new Point(FP.width / 2 - 30, FP.height / 2 - 20), FP.camera);
			retryName.render(FP.buffer, new Point(FP.width / 2 - 30, FP.height / 2 + 10), FP.camera);
			pressEnterWhenFinish.render(FP.buffer, new Point(FP.width / 2 - 30, FP.height / 2 + 20), FP.camera);
			
			hintText.render(FP.buffer, new Point(FP.width / 2, FP.height / 2 + 85), FP.camera);
		}
	}

}