package Zebalooz.GameBackground 
{
	import net.flashpunk.graphics.Backdrop;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class RaseefBackdrop extends Backdrop
	{
		[Embed(source = "../../../assets/Graphics/Raseef.png")]private var raseefClass:Class;
		
		public function RaseefBackdrop() 
		{
			super(raseefClass, true, false);
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
		}
	}

}