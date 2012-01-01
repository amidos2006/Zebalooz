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
	public class CarGenerator extends Entity
	{
		private const GENERATOR_ALARM:int = GlobalObject.GameFrameRate * 5;
		
		public var generatingAlarmPercentage:Number = 1;
		
		public var generatorAlarm:Alarm;
		
		public function CarGenerator() 
		{
			generatorAlarm = new Alarm(GENERATOR_ALARM * (FP.random + 0.5), GenerateObject, Tween.PERSIST);
			addTween(generatorAlarm, true);
		}
		
		private function GenerateObject():void
		{
			if (GlobalObject.score > 500)
			{
				FP.world.add(new CarEntity());
				
				generatingAlarmPercentage = 1 - Math.floor(GlobalObject.score / 1000) * 0.1;
				if (generatingAlarmPercentage < 0.5)
				{
					generatingAlarmPercentage = 0.5;
				}
			}
			
			generatorAlarm.reset(GENERATOR_ALARM * (FP.random + 0.5) * generatingAlarmPercentage);
			generatorAlarm.start();
		}
	}

}