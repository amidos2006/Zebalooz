package Zebalooz.GameEntity.GraphicEntity 
{
	import flash.geom.Point;
	import flash.display.BitmapData;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import Zebalooz.GlobalObject;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class AttentionSpriteMap extends Entity
	{
		[Embed(source = "../../../../assets/Graphics/Objects.png")]private var objectClass:Class;
		
		private var spriteMap:Spritemap = new Spritemap(objectClass, 16, 16);
		
		public function AttentionSpriteMap(yIn:int) 
		{
			x = GlobalObject.GameWidth - 16;
			y = yIn - 12;
			
			spriteMap.add("default", [102, 103], 0.1);
			spriteMap.play("default");
			spriteMap.centerOO();
			
			graphic = spriteMap;
			
			layer = LayerConstant.HUD_LAYER;
		}
	}

}