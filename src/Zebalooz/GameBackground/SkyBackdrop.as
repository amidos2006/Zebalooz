package Zebalooz.GameBackground 
{
	import net.flashpunk.graphics.Backdrop;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	public class SkyBackdrop extends Backdrop
	{
		[Embed(source = "../../../assets/Graphics/Sky.png")]private var skyClass:Class;
		
		public function SkyBackdrop() 
		{
			super(skyClass);
		}
		
		override public function update():void 
		{
			super.update();
			
			x -= GlobalObject.WorldSpeed;
		}
		
	}

}