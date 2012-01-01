package Zebalooz.GameEntity.EnemyEntity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import Zebalooz.CollisionNames;
	import Zebalooz.GameEntity.PlayerEntity.PlayerEntity;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class ThrowingGarbageEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var garbageClass:Class;
		[Embed(source = "../../../../assets/Sounds/GarbageExplode.MP3")]private var garbageSound:Class;
		
		private const H_VELOCITY:int = 3;
		private const V_VELOCITY:int = 4;
		private const ROTATION_SPEED:int = 2;
		private const SCALE_SPEED:Number = 0.02;
		
		private var image:Image;
		private var shadowImage:Image;
		private var garbageSfx:Sfx = new Sfx(garbageSound);
		
		private var velocity:Point;
		private var rotationVelocity:int;
		private var yDestination:int;
		private var scaleVelocity:Number;
		
		public function ThrowingGarbageEntity(xIn:int, yIn:int) 
		{
			image = new Image(garbageClass, new Rectangle(32, 32, 32, 32));
			shadowImage = new Image(garbageClass, new Rectangle(32, 64, 32, 32));
			
			image.centerOO();
			shadowImage.centerOO();
			shadowImage.alpha = 0.6;
			
			image.scale = 0.25;
			
			graphic = image;
			
			x = xIn;
			y = yIn;
			
			velocity = new Point();
			velocity.x = (FP.random - 0.25) * H_VELOCITY;
			velocity.y = - (FP.random + 0.5) * V_VELOCITY;
			
			scaleVelocity = SCALE_SPEED;
			
			rotationVelocity = FP.random * ROTATION_SPEED;
			
			yDestination = (GlobalObject.GameHeight - GlobalObject.RaseefBottom + 5) + FP.rand(44);
			
			layer = GlobalObject.GetLayer(yDestination);
			
			setHitbox(image.width - 8, image.height - 8, image.originX - 6, image.originY - 8);
			type = CollisionNames.GARBAGE_COLLISION_NAME;
			
			shadowImage.scale = 1.2 - (GlobalObject.GameHeight - y) / GlobalObject.GameHeight;
			if (shadowImage.scale < 0)
			{
				shadowImage.scale = 0;
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			image.angle += rotationVelocity;
			image.scale += scaleVelocity;
			if (image.scale > 1)
			{
				image.scale = 1;
			}
			
			x += velocity.x - GlobalObject.WorldSpeed;
			y += velocity.y;
			
			velocity.y += GlobalObject.gravity;
			
			if (FP.distance(0, y + 10, 0, yDestination) < velocity.y)
			{
				FP.world.remove(this);
				
				var fixedGarbage:FixedGarbageEntity = new FixedGarbageEntity(x, yDestination + 10);
				if (x < GlobalObject.GameWidth && x > 0)
				{
					garbageSfx.play(0.5);
				}
				
				FP.world.add(fixedGarbage);
			}
			
			shadowImage.scale = 1.2 - (GlobalObject.GameHeight - y) / GlobalObject.GameHeight;
			if (shadowImage.scale < 0)
			{
				shadowImage.scale = 0;
			}
			
			CheckPlayerCollision();
		}
		
		private function CheckPlayerCollision():void
		{
			var player:PlayerEntity = collide(CollisionNames.PLAYER_COLLISION_NAME, x, y + 16) as PlayerEntity;
			if (player == null)
			{
				return;
			}
			
			if (player.status == PlayerEntity.JUMPING)
			{
				if (CorrectCollision(player) && player.y > y)
				{
					player.jumpVSpeed = velocity.y;
				}
			}
			else
			{
				if (CorrectCollision(player))
				{
					player.KillPlayer();
				}
			}
		}
		
		private function CorrectCollision(player:PlayerEntity):Boolean
		{
			return FP.distanceRectPoint(player.x, player.yDestination, x - shadowImage.scaledWidth / 2, 
										yDestination - shadowImage.scaledHeight / 2 + shadowImage.scale * 20, 
										shadowImage.scaledWidth, shadowImage.scaledHeight - shadowImage.scale * 20) < 10;
		}
		
		override public function render():void 
		{
			super.render();
			
			shadowImage.render(FP.buffer, new Point(x, yDestination), FP.camera);
			
			//Draw.rectPlus(x - shadowImage.scaledWidth / 2, yDestination - shadowImage.scaledHeight / 2 + shadowImage.scale * 20, shadowImage.scaledWidth, shadowImage.scaledHeight - shadowImage.scale * 20, 0xFF0000, 1, false);
			//Draw.hitbox(this);
		}
	}

}