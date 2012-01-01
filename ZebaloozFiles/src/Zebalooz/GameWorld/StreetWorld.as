package Zebalooz.GameWorld 
{
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	import Zebalooz.GameBackground.RaseefBackdrop;
	import Zebalooz.GameBackground.SkyBackdrop;
	import Zebalooz.GameEntity.EnemyEntity.BuildingGeneratorEntity;
	import Zebalooz.GameEntity.EnemyEntity.CarEntity;
	import Zebalooz.GameEntity.EnemyEntity.CarGenerator;
	import Zebalooz.GameEntity.EnemyEntity.FixedObjectGeneratorEntity;
	import Zebalooz.GameEntity.EnemyEntity.ManHoleEntity;
	import Zebalooz.GameEntity.EnemyEntity.ManHoleGenerator;
	import Zebalooz.GameEntity.EnemyEntity.ThrowingGarbageEntity;
	import Zebalooz.GameEntity.GraphicEntity.CloudGeneratorEntity;
	import Zebalooz.GameEntity.GraphicEntity.WhiteEntity;
	import Zebalooz.GameEntity.PlayerEntity.PlayerEntity;
	import Zebalooz.GlobalObject;
	import Zebalooz.HUD.MainMenuEntity;
	import Zebalooz.HUD.ScoreHUDDrawer;
	import Zebalooz.HUD.StoryEntity;
	import Zebalooz.LayerConstant;
	/**
	 * ...
	 * @author Amidos
	 */
	public class StreetWorld extends World
	{
		private var skyBackground:SkyBackdrop = new SkyBackdrop();
		private var raseefBackground:RaseefBackdrop = new RaseefBackdrop();
		private var cloudGenerator:CloudGeneratorEntity = new CloudGeneratorEntity();
		private var fixedObjectGenerator:FixedObjectGeneratorEntity = new FixedObjectGeneratorEntity();
		private var carGenerator:CarGenerator = new CarGenerator();
		private var manHoleGenerator:ManHoleGenerator = new ManHoleGenerator();
		private var whiteLayer:WhiteEntity = new WhiteEntity();
		
		public function StreetWorld() 
		{
			addGraphic(skyBackground, LayerConstant.SKY_LAYER);
			addGraphic(raseefBackground, LayerConstant.RASEEF_LAYER, 0, GlobalObject.GameHeight - GlobalObject.RaseefBottom);
			
			add(cloudGenerator);
			add(fixedObjectGenerator);
			add(carGenerator);
			add(manHoleGenerator);
			add(whiteLayer);
			add(new StoryEntity());
		}
		
		override public function begin():void 
		{
			super.begin();
			cloudGenerator.Intailize();
			BuildingGeneratorEntity.Intialize();
		}
		
		private function UpdateBackground():void
		{
			skyBackground.update();
			raseefBackground.update();
		}
		
		override public function update():void 
		{
			super.update();
			
			UpdateBackground();
		}
	}

}