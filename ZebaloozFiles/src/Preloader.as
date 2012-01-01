package  
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.ProgressEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	import flash.utils.getDefinitionByName;
	import mochi.as3.MochiServices;
	import Zebalooz.GlobalObject;
	/**
	 * ...
	 * @author Amidos
	 */
	
	[SWF(width = "640", height = "480", backgroundColor="#11D2FF")]
	public class Preloader extends MovieClip
	{
		[Embed(source = 'net/flashpunk/graphics/04B_03__.TTF', embedAsCFF="false", fontFamily = 'GameFont')]static private var gameFont:Class;
		[Embed(source='../Assets/Graphics/AmidosLogo.png')]static private var sponsorImg:Class;
		[Embed(source = '../Assets/Graphics/LoadingScreen.png')]static private var loadingBackImg:Class;
		[Embed(source = '../Assets/Graphics/LoadingScreenDone.png')]static private var loadingBackDoneImg:Class;
		
		private var text:TextField = new TextField();
		private var sponsorLogo:Bitmap = new sponsorImg;
		private var background:Bitmap = new loadingBackImg;
		private var backgroundDone:Bitmap = new loadingBackDoneImg;
		private var loadingTextFormat:TextFormat = new TextFormat();
		private var textFormat:TextFormat = new TextFormat();
		private var font:Font = new gameFont() as Font;
		private var totalBytes:Number = 1790;
		private var notLoaded:Boolean = true;
		
		public function Preloader() 
		{
			MochiServices.connect("eeb55c1ea8d94ec9", root);
			
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
			addChild(backgroundDone);
			addChild(background);
			
			addChild(text);
			text.x = stage.stageWidth / 2 - 16;
			text.y = stage.stageHeight - 40;
			
			loadingTextFormat.font = font.fontName;
			loadingTextFormat.size = 24;
			
			textFormat.font = font.fontName;
			textFormat.size = 24;
			
			//addChild(sponsorLogo);
			//sponsorLogo.x = stage.stageWidth - sponsorLogo.width + 30;
			//sponsorLogo.y = stage.stageHeight - sponsorLogo.height;
			
			text.autoSize = TextFieldAutoSize.CENTER;
			text.defaultTextFormat = textFormat;
			text.embedFonts = true;
			text.textColor = 0xFFFFFF;
			text.x = stage.stageWidth / 2 - (text.text.length / 3) * 16;
			text.selectable = false;
		}
		
		private function progress(e:ProgressEvent):void 
		{
			if (e.bytesTotal != 0)
			{
				totalBytes = Math.ceil(e.bytesTotal / 1024);
			}
			
			text.text = Math.floor(Math.ceil(e.bytesLoaded/1024) / totalBytes * 100) + " % ";
		}
		
		private function checkFrame(e:Event):void 
		{
			if (currentFrame == totalFrames && notLoaded) 
			{
				notLoaded = false;
				stage.addEventListener(KeyboardEvent.KEY_DOWN, PlayClicked);
				removeChild(background);
			}
		}
		
		private function PlayClicked(eventObject: KeyboardEvent):void
		{
			if (eventObject.keyCode != Keyboard.SPACE)
			{
				return;
			}
			
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			stage.removeEventListener(KeyboardEvent.KEY_DOWN, PlayClicked);
			
			removeChild(text);
			//removeChild(sponsorLogo);
			removeChild(backgroundDone);
			
			startup();
		}
		
		private function startup():void 
		{
			//if (SiteLock())
			{
				var c:Class = getDefinitionByName("Main") as Class;
				addChild(new c as DisplayObject);
			}
		}
		
		private function SiteLock():Boolean
		{
			var url:String=stage.loaderInfo.url;
			var urlStart:Number = url.indexOf("://")+3;
			var urlEnd:Number = url.indexOf("/", urlStart);
			var domain:String = url.substring(urlStart, urlEnd);
			var LastDot:Number = domain.lastIndexOf(".")-1;
			var domEnd:Number = domain.lastIndexOf(".", LastDot)+1;
			domain = domain.substring(domEnd, domain.length);
			if (domain != "gametako.com") 
			{
				return false;
			}
			
			return true;
		}
		
	}

}