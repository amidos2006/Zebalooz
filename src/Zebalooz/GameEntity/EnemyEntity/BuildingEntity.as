package Zebalooz.GameEntity.EnemyEntity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import Zebalooz.CollisionNames;
	import Zebalooz.GameEntity.GraphicEntity.ThrowingManEntity;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class BuildingEntity extends Entity
	{
		public static const BUILDING_WIDTH:int = 80;
		public static const GARBAGE_ALARM:int = GlobalObject.GameFrameRate * 7;
		
		[Embed(source = "../../../../assets/Graphics/Buildings.png")]private var buildingClass:Class;
		
		private var buildingImage:Image;
		private var pointsOfGeneration:Vector.<Point> = new Vector.<Point>();
		
		private var generatingPercentage:Number = 0;
		private var generatingAlarmPercentage:Number = 1;
		
		private var generateGarbage:Alarm;
		
		public function BuildingEntity(xTemp:int) 
		{
			var randomX:int = FP.rand(5);
			var randomY:int = FP.rand(2);
			var width:int = BUILDING_WIDTH;
			var height:int = 120;
			
			pointsOfGeneration.push(new Point(20, 30));
			pointsOfGeneration.push(new Point(60, 30));
			pointsOfGeneration.push(new Point(20, 70));
			pointsOfGeneration.push(new Point(60, 70));
			
			if (randomX <= 2)
			{
				randomY = 0;
				height = 240;
			}
			
			switch(randomX)
			{
				case 0:
					pointsOfGeneration.push(new Point(20, 110));
					pointsOfGeneration.push(new Point(60, 110));
					pointsOfGeneration.push(new Point(20, 150));
					pointsOfGeneration.push(new Point(60, 150));
					pointsOfGeneration.push(new Point(20, 190));
					pointsOfGeneration.push(new Point(60, 190));
					break;
				case 1:
					pointsOfGeneration[0] = new Point(20, 110);
					pointsOfGeneration[1] = new Point(60, 110);
					pointsOfGeneration.push(new Point(20, 150));
					pointsOfGeneration.push(new Point(60, 150));
					pointsOfGeneration.push(new Point(20, 190));
					pointsOfGeneration.push(new Point(60, 190));
					break;
				case 2:
					pointsOfGeneration[0] = new Point(20, 110);
					pointsOfGeneration[1] = new Point(60, 110);
					pointsOfGeneration[2] = new Point(20, 150);
					pointsOfGeneration[3] = new Point(60, 150);
					pointsOfGeneration.push(new Point(20, 190));
					pointsOfGeneration.push(new Point(60, 190));
					break;
			}
			
			buildingImage = new Image(buildingClass, new Rectangle(randomX * width, randomY * height, width, height));
			graphic = buildingImage;
			
			x = xTemp;
			y = GlobalObject.GameHeight - GlobalObject.RaseefBottom - height;
			
			generateGarbage = new Alarm(FP.random * GARBAGE_ALARM, GenerateGarbage, Tween.PERSIST);
			addTween(generateGarbage, true);
			
			layer = LayerConstant.BUILDING_LAYER;
			
			setHitbox(width, height);
			type = CollisionNames.BUILDING_COLLISION_NAME;
		}
		
		private function GenerateGarbage():void
		{
			var index:int = FP.rand(pointsOfGeneration.length);
			
			FP.world.add(new ThrowingManEntity(x + pointsOfGeneration[index].x, y + pointsOfGeneration[index].y));
			FP.world.add(new ThrowingGarbageEntity(x + pointsOfGeneration[index].x, y + pointsOfGeneration[index].y));
			
			generatingAlarmPercentage = 1 - Math.floor(GlobalObject.score / 1000) * 0.1;
			if (generatingAlarmPercentage < 0.5)
			{
				generatingAlarmPercentage = 0.5;
			}
			
			generateGarbage.reset((FP.random + 0.5) * GARBAGE_ALARM * generatingAlarmPercentage);
			
			generatingPercentage = Math.floor(GlobalObject.score / 500) * 0.1;
			if (generatingPercentage > 0.5)
			{
				generatingPercentage = 0.5;
			}
			
			if (FP.random < generatingPercentage)
			{
				generateGarbage.reset(FP.random * GARBAGE_ALARM / 3 * generatingAlarmPercentage);
			}
			
			generateGarbage.start();
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
			
			if (x < -BUILDING_WIDTH)
			{
				FP.world.remove(this);
				
				BuildingGeneratorEntity.GenerateBuilding(20);
			}
			
			if (collide(CollisionNames.BUILDING_COLLISION_NAME, x, y) && x > GlobalObject.GameWidth)
			{
				FP.world.remove(this);
				
				BuildingGeneratorEntity.GenerateBuilding(20);
			}
		}
		
	}

}