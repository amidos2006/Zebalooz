package Zebalooz.GameEntity.PlayerEntity 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class PlayerDeadEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		[Embed(source = "../../../../assets/Sounds/Lose.mp3")]private var loseClass:Class;
		
		private var image:Image;
		private var rotationSpeed:int = 10;
		private var loseSfx:Sfx = new Sfx(loseClass);
		
		private var vSpeed:Number = -5.5;
		
		public function PlayerDeadEntity(xIn:int, yIn:int, layerConstant:int) 
		{
			image = new Image(objectClass, new Rectangle(64, 192, 32, 32));
			image.centerOO();
			graphic = image;
			
			x = xIn;
			y = yIn;
			
			rotationSpeed = (1 + FP.random / 2) * rotationSpeed;
			
			vSpeed = (1 + FP.random) * vSpeed;
			
			loseSfx.play(0.5);
			
			layer = layerConstant;
		}
		
		override public function update():void 
		{
			super.update();
			
			image.angle += rotationSpeed;
			
			vSpeed += 1.5 * GlobalObject.gravity;
			
			y += vSpeed;
			
			if (y > GlobalObject.GameHeight + image.height)
			{
				FP.world.remove(this);
				GlobalObject.ShowHighScore();
			}
		}
		
	}

}