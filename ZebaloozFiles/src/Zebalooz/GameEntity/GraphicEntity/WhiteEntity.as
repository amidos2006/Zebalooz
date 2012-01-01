package Zebalooz.GameEntity.GraphicEntity 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class WhiteEntity extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/WhiteLayer.png")]private var whiteLayerClass:Class;
		[Embed(source = "../../../../assets/Sounds/Explosion.mp3")]private var explosionClass:Class;
		
		public var image:Image = new Image(whiteLayerClass);
		public var explosionSfx:Sfx = new Sfx(explosionClass);
		
		private var alphaSpeed:Number = 0.03;
		
		public function WhiteEntity() 
		{
			image.alpha = 0;
			graphic = image;
			
			layer = LayerConstant.WHITE_LAYER;
		}
		
		override public function update():void 
		{
			super.update();
			
			image.alpha -= alphaSpeed;
			if (image.alpha <= 0)
			{
				image.alpha = 0;
			}
		}
		
		public static function ShowWhiteLayer():void
		{
			(FP.world.classFirst(WhiteEntity) as WhiteEntity).image.alpha = 1;
			(FP.world.classFirst(WhiteEntity) as WhiteEntity).explosionSfx.play();
		}
		
	}

}