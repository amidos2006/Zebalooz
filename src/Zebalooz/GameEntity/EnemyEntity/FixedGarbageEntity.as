package Zebalooz.GameEntity.EnemyEntity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import Zebalooz.CollisionNames;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class FixedGarbageEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		
		private var image:Image;
		
		public function FixedGarbageEntity(xIn:int, yIn:int, scale:Number = 1) 
		{
			x = xIn;
			y = yIn;
			
			image = new Image(objectClass, new Rectangle(64, 32, 32, 32));
			image.originX = image.width / 2;
			image.originY = image.height;
			image.scale = scale;
			
			graphic = image;
			
			layer = GlobalObject.GetLayer(y);
			
			setHitbox(image.width, image.height - 24, image.originX, image.originY - 24);
			type = CollisionNames.CONST_COLLISION_NAME;
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
			
			if (x < -image.width)
			{
				FP.world.remove(this);
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			//Draw.hitbox(this);
		}
		
	}

}