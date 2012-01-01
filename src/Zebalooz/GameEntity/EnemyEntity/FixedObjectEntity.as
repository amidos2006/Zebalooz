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
	public class FixedObjectEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectsClass:Class;
		
		private var image:Image;
		
		private var rectangles:Vector.<Rectangle> = new Vector.<Rectangle>();
		private var hitBoxes:Vector.<Rectangle> = new Vector.<Rectangle>();
		
		public function FixedObjectEntity() 
		{
			var index:int = FP.rand(3);
			
			rectangles.push(new Rectangle(96, 32, 32, 32));
			rectangles.push(new Rectangle(64, 64, 32, 32));
			rectangles.push(new Rectangle(96, 64, 32, 32));
			
			image = new Image(objectsClass, rectangles[index]);
			image.originX = image.width / 2;
			image.originY = image.height;
			
			graphic = image;
			
			hitBoxes.push(new Rectangle(image.originX - 5, image.originY - 18, image.width - 5, image.height - 18));
			hitBoxes.push(new Rectangle(image.originX, image.originY - 24, image.width, image.height - 24));
			hitBoxes.push(new Rectangle(image.originX, image.originY - 22, image.width, image.height - 22));
			
			x = GlobalObject.GameWidth + image.width;
			y = GlobalObject.GameHeight - GlobalObject.RaseefBottom + 15 + FP.rand(44);
			
			layer = GlobalObject.GetLayer(y);
			
			setHitbox(hitBoxes[index].width, hitBoxes[index].height, hitBoxes[index].x, hitBoxes[index].y);
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