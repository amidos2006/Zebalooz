package Zebalooz.GameEntity.GraphicEntity 
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
	public class CloudGeneratorEntity extends Entity
	{
		private const AMOUNT_GENERATION:int = GlobalObject.GameFrameRate * 1;
		private const INTIALIZE_AMOUNT:int = 4;
		
		private var generator1Alarm:Alarm;
		private var generator2Alarm:Alarm;
		
		public function CloudGeneratorEntity() 
		{
			generator1Alarm = new Alarm(FP.random * AMOUNT_GENERATION + AMOUNT_GENERATION / 2, GenerateCloud, Tween.LOOPING);
			
			addTween(generator1Alarm, true);
		}
		
		private function GenerateCloud():void
		{
			FP.world.add(new CloudEntity());
		}
		
		public function Intailize():void
		{
			for (var i:int = 0; i < INTIALIZE_AMOUNT + FP.random * INTIALIZE_AMOUNT; i += 1)
			{
				FP.world.add(new CloudEntity(FP.random * GlobalObject.GameWidth));
			}
		}
	}

}