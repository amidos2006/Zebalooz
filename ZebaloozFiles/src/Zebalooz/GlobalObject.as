package Zebalooz 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Data;
	import Zebalooz.GameEntity.EnemyEntity.*;
	import Zebalooz.GameEntity.GraphicEntity.WhiteEntity;
	import Zebalooz.GameEntity.PlayerEntity.PlayerDeadWithManHoleEntity;
	import Zebalooz.GameEntity.PlayerEntity.PlayerEntity;
	import Zebalooz.HUD.HighScoreEnterNameEntity;
	import Zebalooz.HUD.PlayerData;
	import Zebalooz.HUD.ScoreHUDDrawer;
	/**
	 * ...
	 * @author Amidos
	 */
	public class GlobalObject 
	{
		[Embed(source = "../../assets/Sounds/Zebalooz.mp3")]private static var music:Class;
		
		public static const FILE_NAME:String = "ZebaloozSave";
		
		private static var musicSfx:Sfx = new Sfx(music);
		private static var soundPlaying:Boolean = false;
		
		public static var playerName:String = "default";
		public static var PlayerHighScoreData:Vector.<PlayerData> = new Vector.<PlayerData>();
		public static var FixedWorldSpeed:Number = 1;
		public static var WorldSpeed:Number = 1;
		public static var gravity:Number = 0.2;
		public static var RaseefBottom:int = 56;
		public static var score:int = 0;
		public static var bestScore:int = 0;
		
		public static var GameWidth:int = 320;
		public static var GameHeight:int = 240;
		public static var GameScale:int = 2;
		public static var GameFrameRate:int = 60;
		
		public static function GetLayer(y:int):int
		{
			return LayerConstant.STREET_LAYER - (y -(GameHeight -RaseefBottom));
		}
		
		public static function UpdateScore():void
		{
			score += WorldSpeed;
		}
		
		public static function GetTimeForJump():int
		{
			var player:PlayerEntity = FP.world.classFirst(PlayerEntity) as PlayerEntity;
			
			if (player)
			{
				return player.allowJumpAlarm.remaining;
			}
			
			return -1;
		}
		
		public static function StartGame():void
		{
			WhiteEntity.ShowWhiteLayer();
			PlayMusic();
			RemoveAllHarmObjects();
			FP.world.add(new PlayerEntity());
		}
		
		public static function RemoveAllHarmObjects():void
		{
			var array:Array = new Array();
			var i:int = 0;
			
			FP.world.getClass(CarEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
			
			FP.world.getClass(FixedGarbageEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
			
			FP.world.getClass(FixedObjectEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
			
			FP.world.getClass(ManHoleEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
			
			FP.world.getClass(PlayerDeadWithManHoleEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
			
			FP.world.getClass(ThrowingGarbageEntity, array)
			for (i = 0; i < array.length; i += 1)
			{
				FP.world.remove(array[i]);
			}
		}
		
		public static function IntializeHighScore():void
		{
			for (var i:int = 0; i < 10; i += 1)
			{
				PlayerHighScoreData.push(new PlayerData("None", 0));
			}
		}
		
		public static function ShowHighScore():void
		{
			FP.world.add(new HighScoreEnterNameEntity(playerName, score, bestScore));
			
			if (score > bestScore)
			{
				bestScore = score;
			}
			
			SaveScore();
		}
		
		public static function SaveScore():void
		{
			Data.writeInt("bestScore", bestScore);
			Data.writeString("playerName", playerName);
			Data.save(FILE_NAME);
		}
		
		
		public static function LoadScore():void
		{
			Data.load(FILE_NAME);
			bestScore = Data.readInt("bestScore", 0);
			playerName = Data.readString("playerName", "default");
		}
		
		public static function PlayMusic():void
		{
			if (!soundPlaying)
			{
				musicSfx.loop();
				soundPlaying = true;
			}
		}
		
		public static function StopMusic():void
		{
			soundPlaying = false;
			musicSfx.stop();
		}
	}

}