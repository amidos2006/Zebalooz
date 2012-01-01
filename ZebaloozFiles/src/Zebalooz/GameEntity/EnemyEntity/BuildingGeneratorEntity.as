package Zebalooz.GameEntity.EnemyEntity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BuildingGeneratorEntity
	{
		private static const X_OFFSET:int = 10;
		
		private static var xTemp:int = 0;
		
		public static function GenerateBuilding(additionalOffset:int = 0):void
		{
			var x:int = GlobalObject.GameWidth + (0.5 + FP.random) * X_OFFSET + additionalOffset;
			
			FP.world.add(new BuildingEntity(x));
		}
		
		public static function Intialize():void
		{
			var amountOfGeneration:int = Math.ceil(GlobalObject.GameWidth / BuildingEntity.BUILDING_WIDTH) + 1;
			
			for (var i:Number = 0; i < amountOfGeneration; i += 1)
			{
				xTemp += (0.5 + FP.random) * X_OFFSET;
				
				FP.world.add(new BuildingEntity(i * BuildingEntity.BUILDING_WIDTH + xTemp));
			}
		}
		
	}

}