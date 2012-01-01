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
	public class FixedObjectGeneratorEntity extends Entity
	{
		private const GENERATOR_ALARM:int = GlobalObject.GameFrameRate * 4;
		
		private var generatingAlarmPercentage:Number = 1;
		
		public var generatorAlarm:Alarm;
		
		public function FixedObjectGeneratorEntity() 
		{
			generatorAlarm = new Alarm(GENERATOR_ALARM * (FP.random + 0.5), GenerateObject, Tween.PERSIST);
			addTween(generatorAlarm, true);
		}
		
		private function GenerateObject():void
		{
			FP.world.add(new FixedObjectEntity());
			
			generatingAlarmPercentage = 1 - Math.floor(GlobalObject.score / 200) * 0.1;
			if (generatingAlarmPercentage < 0.5)
			{
				generatingAlarmPercentage = 0.5;
			}
			
			generatorAlarm.reset(GENERATOR_ALARM * (FP.random + 0.5) * generatingAlarmPercentage);
			generatorAlarm.start();
		}
	}

}