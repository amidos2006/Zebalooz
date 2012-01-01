package Zebalooz.GameEntity.PlayerEntity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerDeadWithManHoleEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		[Embed(source = "../../../../assets/Sounds/Lose.mp3")]private var loseClass:Class;
		
		private var spriteMap:Spritemap;
		private var loseSfx:Sfx = new Sfx(loseClass);
		
		public function PlayerDeadWithManHoleEntity(xIn:int, yIn:int, layerConstant:int) 
		{
			spriteMap = new Spritemap(objectClass, 32, 32, AnimationEnded);
			spriteMap.add("default", [31, 34, 35, 36, 37], 0.2, false);
			
			spriteMap.originX = spriteMap.width / 2;
			spriteMap.originY = spriteMap.height;
			
			graphic = spriteMap;
			spriteMap.play("default");
			
			x = xIn;
			y = yIn;
			
			loseSfx.play(0.5);
			
			layer = layerConstant;
		}
		
		private function AnimationEnded():void
		{
			GlobalObject.ShowHighScore();
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