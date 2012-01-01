package Zebalooz.GameEntity.GraphicEntity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ThrowingManEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		
		private var spriteMap:Spritemap;
		
		public function ThrowingManEntity(xIn:int, yIn:int) 
		{
			x = xIn;
			y = yIn;
			
			spriteMap = new Spritemap(objectClass, 16, 16, AnimationEnded);
			spriteMap.add("default", [128, 129, 130, 131, 130, 129, 128], 0.2, false);
			
			spriteMap.originX = spriteMap.width / 2;
			spriteMap.originY = spriteMap.height;
			
			graphic = spriteMap;
			spriteMap.play("default");
			
			layer = LayerConstant.THROWING_LAYER;
		}
		
		private function AnimationEnded():void
		{
			FP.world.remove(this);
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
			
			if (x < -spriteMap.width)
			{
				FP.world.remove(this);
			}
		}
		
	}

}