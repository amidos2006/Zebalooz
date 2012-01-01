package Zebalooz.GameEntity.PlayerEntity 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Draw;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import Zebalooz.CollisionNames;
	import Zebalooz.GameEntity.EnemyEntity.CarEntity;
	import Zebalooz.GameEntity.ParticleEntity.SmokeParticle;
	import Zebalooz.GlobalObject;
	import Zebalooz.HUD.HUDDrawer;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerEntity extends Entity
	{
		public static const MOVING:String = "Moving";
		public static const STANDING:String = "Standing";
		public static const JUMPING:String = "Jumping";
		
		private const UP:String = "up";
		private const DOWN:String = "down";
		private const RIGHT:String = "right";
		private const LEFT:String = "left";
		private const JUMP:String = "jump";
		
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		[Embed(source = "../../../../assets/Sounds/Jump.MP3")]private var jumpSound:Class;
		
		private var spriteMap:Spritemap;
		private var jumpSfx:Sfx = new Sfx(jumpSound);
		private var shadowImage:Image;
		
		private var velocity:Point = new Point();
		private var movingSpeed:int = 2;
		private var jumpSpeed:int = 4;
		private var upBoundry:int;
		private var bottomBoundry:int;
		private var rightBoundry:int;
		private var jumpAllowed:Boolean = true;
		
		public var allowJumpAlarm:Alarm;
		public var yDestination:int;
		public var jumpVSpeed:Number = 0;
		public var status:String;
		
		public function PlayerEntity(xIn:int = 130, yIn:int = 220) 
		{
			status = STANDING;
			
			spriteMap = new Spritemap(objectClass, 32, 32);
			spriteMap.add(STANDING, [0]);
			spriteMap.add(MOVING, [0, 1, 2, 1, 0, 28, 29, 28], 0.2);
			spriteMap.add(JUMPING, [3]);
			
			spriteMap.originX = spriteMap.width / 2;
			spriteMap.originY = spriteMap.height;
			
			shadowImage = new Image(objectClass, new Rectangle(0, 32, 32, 32));
			shadowImage.originX = shadowImage.width / 2;
			shadowImage.originY = shadowImage.height;
			shadowImage.alpha = 0.6;
			
			graphic = spriteMap;
			
			x = xIn;
			y = yIn;
			yDestination = yIn;
			
			upBoundry = GlobalObject.GameHeight - GlobalObject.RaseefBottom + 12;
			bottomBoundry = GlobalObject.GameHeight;
			rightBoundry = GlobalObject.GameWidth - 130;
			
			IntializeControls();
			
			setHitbox(spriteMap.width - 24, spriteMap.height - 26, spriteMap.originX - 11, spriteMap.originY - 26);
			type = CollisionNames.PLAYER_COLLISION_NAME;
			
			allowJumpAlarm = new Alarm(GlobalObject.GameFrameRate * 2, AllowJump, Tween.PERSIST);
			addTween(allowJumpAlarm);
			
			HUDDrawer.ShowHUD();
			
			GlobalObject.score = 0;
		}
		
		private function AllowJump():void
		{
			jumpAllowed = true;
		}
		
		public function KillPlayer():void
		{
			FP.world.remove(this);
			GlobalObject.StopMusic();
			GlobalObject.WorldSpeed = GlobalObject.FixedWorldSpeed;
			HUDDrawer.RemoveHUD();
			FP.world.add(new PlayerDeadEntity(x, y, layer));
		}
		
		public function KillPlayerWithManHole(xIn:int, yIn:int):void
		{
			FP.world.remove(this);
			GlobalObject.StopMusic();
			GlobalObject.WorldSpeed = GlobalObject.FixedWorldSpeed;
			HUDDrawer.RemoveHUD();
			FP.world.add(new PlayerDeadWithManHoleEntity(xIn, yIn, layer));
		}
		
		private function IntializeControls():void
		{
			Input.define(UP, Key.W, Key.UP);
			Input.define(DOWN, Key.S, Key.DOWN);
			Input.define(RIGHT, Key.D, Key.RIGHT);
			Input.define(LEFT, Key.A, Key.LEFT);
			Input.define(JUMP, Key.SPACE);
		}
		
		private function UpdateKeys():void
		{
			velocity.x = 0;
			velocity.y = 0;
			
			if (Input.check(UP))
			{
				velocity.y = -movingSpeed;
			}
			
			if (Input.check(DOWN))
			{
				velocity.y = movingSpeed;
			}
			
			if (Input.check(RIGHT))
			{
				velocity.x = movingSpeed;
			}
			
			if (Input.check(LEFT))
			{
				velocity.x = -movingSpeed;
			}
			
			if (jumpAllowed)
			{
				if (Input.pressed(JUMP))
				{
					jumpVSpeed = -jumpSpeed;
					jumpAllowed = false;
					allowJumpAlarm.start();
					jumpSfx.play(0.5);
					
					FP.world.add(new SmokeParticle(x, y, 30, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 25, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 20, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 15, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 10, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 170, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 165, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 160, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 155, 0.5, layer + 1, 0.03));
					FP.world.add(new SmokeParticle(x, y, 150, 0.5, layer + 1, 0.03));
				}
			}
		}
		
		private function UpdatePhysics():void
		{
			GlobalObject.WorldSpeed = GlobalObject.FixedWorldSpeed;
			
			if (yDestination + velocity.y > bottomBoundry || yDestination + velocity.y < upBoundry)
			{
				velocity.y = 0;
			}
			
			if (x + velocity.x > rightBoundry)
			{
				GlobalObject.WorldSpeed = velocity.x;
			}
			
			if (status != JUMPING)
			{
				if (collide(CollisionNames.CONST_COLLISION_NAME, x + velocity.x - GlobalObject.WorldSpeed, yDestination))
				{
					velocity.x = 0;
				}
				
				if (collide(CollisionNames.CONST_COLLISION_NAME, x - 2, yDestination + velocity.y))
				{
					velocity.y = 0;
				}
				
				if (velocity.x < 0 && collide(CollisionNames.CAR_COLLISION_NAME, x + velocity.x - GlobalObject.WorldSpeed, yDestination))
				{
					velocity.x = 0;
				}
				
				if (collide(CollisionNames.CAR_COLLISION_NAME, x - 2, yDestination + velocity.y))
				{
					velocity.y = 0;
				}
			}
			
			jumpVSpeed += GlobalObject.gravity;
			if (distanceToPoint(x, yDestination) < jumpVSpeed)
			{
				jumpVSpeed = 0;
			}
			
			x += velocity.x - GlobalObject.WorldSpeed;
			y += velocity.y + jumpVSpeed;
			yDestination += velocity.y;
		}
		
		private function UpdateGraphics():void
		{
			if (jumpVSpeed == 0)
			{
				status = STANDING;
				
				if (velocity.x != 0)
				{
					status = MOVING;
				}
				
				if (velocity.y != 0)
				{
					status = MOVING;
				}
			}
			else
			{
				status = JUMPING;
			}
			
			layer = GlobalObject.GetLayer(yDestination);
			
			spriteMap.play(status);
		}
		
		private function UpdateLogic():void
		{
			var carEntity:CarEntity = collide(CollisionNames.CAR_COLLISION_NAME, x, yDestination) as CarEntity;
			if (carEntity)
			{
				KillPlayer();
			}
			
			if (velocity.x > 0)
			{
				GlobalObject.UpdateScore();
			}
			
			if (x < -10)
			{
				KillPlayer();
			}
		}
		
		override public function update():void 
		{
			super.update();
			
			UpdateKeys();
			
			UpdatePhysics();
			
			UpdateLogic();
			
			UpdateGraphics();
		}
		
		override public function render():void 
		{
			shadowImage.render(FP.buffer, new Point(x - 1, yDestination + 3), FP.camera);
			
			super.render();
			
			//Draw.hitbox(this);
			
			//Draw.circle(x, yDestination, 1, 0x00FF00);
		}
	}

}