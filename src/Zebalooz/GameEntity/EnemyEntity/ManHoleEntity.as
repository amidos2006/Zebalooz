package Zebalooz.GameEntity.EnemyEntity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Draw;
	import Zebalooz.CollisionNames;
	import Zebalooz.GameEntity.PlayerEntity.PlayerEntity;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ManHoleEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectsClass:Class;
		
		private var image:Image;
		
		public function ManHoleEntity() 
		{	
			image = new Image(objectsClass, new Rectangle(64, 224, 32, 32));
			image.originX = image.width / 2;
			image.originY = image.height;
			
			graphic = image;
			
			x = GlobalObject.GameWidth + image.width;
			y = GlobalObject.GameHeight - GlobalObject.RaseefBottom + 25 + FP.rand(35);
			
			layer = LayerConstant.MAN_HOLE_LAYER;
			
			setHitbox(image.width - 5, image.height - 20, image.originX - 3, image.originY - 19);
			type = CollisionNames.MAN_HOLE_COLLISION_NAME;
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
			if (x < -image.width)
			{
				FP.world.remove(this);
			}
			
			var player:PlayerEntity = collide(CollisionNames.PLAYER_COLLISION_NAME, x, y) as PlayerEntity;
			if (player)
			{
				if (player.status != PlayerEntity.JUMPING)
				{
					player.KillPlayerWithManHole(x, y);
				}
			}
		}
		
		override public function render():void 
		{
			super.render();
			
			//Draw.hitbox(this);
		}
		
	}

}