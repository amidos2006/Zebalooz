package Zebalooz.GameEntity.ParticleEntity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SmokeParticle extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		
		private var image:Image;
		
		private var directionVector:Point;
		private var scaleSpeed:Number;
		
		public function SmokeParticle(xIn:int, yIn:int, directionIn:int, speedIn:Number, layerConstant:int, scaleSpeedIn:Number = 0.1) 
		{
			x = xIn;
			y = yIn;
			
			image = new Image(objectClass, new Rectangle(16, 64, 8, 8));
			image.centerOO();
			image.scale = 0.5;
			graphic = image;
			
			speedIn = speedIn * (1 + 0.25 * FP.random);
			directionIn = (directionIn - 5) + 10 * FP.random;
			directionVector = new Point();
			FP.angleXY(directionVector, directionIn, speedIn);
			
			scaleSpeed = scaleSpeedIn;
			
			layer = layerConstant;
		}
		
		override public function update():void 
		{
			super.update();
			
			x += directionVector.x - GlobalObject.WorldSpeed;
			y += directionVector.y - FP.random;
			
			image.scale -= scaleSpeed;
			if (image.scale < 0)
			{
				FP.world.remove(this);
			}
		}
	}

}