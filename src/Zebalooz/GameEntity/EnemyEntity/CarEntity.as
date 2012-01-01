package Zebalooz.GameEntity.EnemyEntity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Draw;
	import Zebalooz.CollisionNames;
	import Zebalooz.GameEntity.GraphicEntity.AttentionSpriteMap;
	import Zebalooz.GameEntity.ParticleEntity.SmokeParticle;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class CarEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		[Embed(source = "../../../../assets/Sounds/CarHorn3.mp3")]private var carHornClass:Class;
		
		private var spriteMap:Spritemap;
		private var carHornSfx:Sfx;
		
		private var speed:Number = 3;
		private var attention:AttentionSpriteMap;
		private var firstHorn:Boolean = true;
		
		public function CarEntity() 
		{
			var index:int = 2 * FP.rand(2);
			
			spriteMap = new Spritemap(objectClass, 64, 32);
			spriteMap.add("default", [6 + index, 7 + index], 0.1, true);
			spriteMap.play("default");
			spriteMap.originX = spriteMap.width / 2;
			spriteMap.originY = spriteMap.height;
			graphic = spriteMap;
			
			x = GlobalObject.GameWidth + spriteMap.width + 200 + FP.random * 50;
			y = GlobalObject.GameHeight - GlobalObject.RaseefBottom + 14 + FP.rand(44);
			
			attention = new AttentionSpriteMap(y);
			FP.world.add(attention);
			
			layer = GlobalObject.GetLayer(y);
			
			speed = (1 + FP.random) * speed;
			
			setHitbox(spriteMap.width, spriteMap.height - 22, spriteMap.originX, spriteMap.originY - 22);
			type = CollisionNames.CAR_COLLISION_NAME;
			
			carHornSfx = new Sfx(carHornClass);
		}
		
		override public function removed():void 
		{
			super.removed();
			FP.world.remove(attention);
		}
		
		override public function update():void 
		{
			super.update();
			
			FP.world.add(new SmokeParticle(x + spriteMap.width / 2 - 5, y - 5, 0, 1, layer + 1));
			FP.world.add(new SmokeParticle(x + spriteMap.width / 2 - 10, y - 5, 0, 1, layer + 1));
			
			x -= GlobalObject.WorldSpeed + speed;
			if (x < -spriteMap.width)
			{
				FP.world.remove(this);
			}
			
			if (x < GlobalObject.GameWidth + spriteMap.width / 2)
			{
				attention.visible = false;
				
				if (firstHorn)
				{
					firstHorn = false;
					carHornSfx.play(0.5);
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