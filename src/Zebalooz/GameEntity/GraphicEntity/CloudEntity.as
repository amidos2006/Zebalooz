package Zebalooz.GameEntity.GraphicEntity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class CloudEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var cloudClass:Class;
		
		private const RANDOM_AMOUNT:int = 10;
		
		private var cloudImage:Image;
		private var cloudSpeed:Number;
		
		public function CloudEntity(xTemp:int = -1) 
		{
			var randomNumber:int = FP.rand(4);
			var rectangle:Rectangle;
			
			switch(randomNumber)
			{
				case 0:
					rectangle = new Rectangle(0, 160, 64, 32);
					break;
				case 1:
					rectangle = new Rectangle(64, 160, 64, 32);
					break;
				case 2:
					rectangle = new Rectangle(0, 192, 32, 32);
					break;
				case 3:
					rectangle = new Rectangle(32, 192, 32, 32);
					break;
			}
			
			cloudImage = new Image(cloudClass, rectangle);
			cloudImage.alpha = 0.9;
			layer = LayerConstant.CLOUD_LAYER;
			graphic = cloudImage;
			
			cloudSpeed = FP.random / 2 + 0.1;
			
			x = GlobalObject.GameWidth + FP.rand(RANDOM_AMOUNT);
			y = FP.rand(rectangle.height + GlobalObject.GameHeight / 2) - rectangle.height / 2;
			
			if (xTemp != -1)
			{
				x = xTemp;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed + cloudSpeed;
			
			if (x < -cloudImage.width)
			{
				FP.world.remove(this);
			}
		}
		
	}

}