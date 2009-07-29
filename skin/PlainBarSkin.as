package
{
	import flash.display.Graphics;
	
	import mx.skins.ProgrammaticSkin;

	public class PlainBarSkin extends ProgrammaticSkin
	{
		public function PlainBarSkin()
		{
			super();
		}
		
		override public function get measuredWidth():Number
		{
			return 5;
		}
		
		override public function get measuredHeight():Number
		{
			return 32;
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
	
			var g:Graphics = graphics;
			
			g.clear();
			
			g.beginFill(0xd6d6d6);
			g.drawRect(0, 0, w, h);
			g.endFill();
			
			g.beginFill(0xa7a6aa);
			g.drawRect(0, h-1, w, 1);
			g.endFill();
			
			//a7a6aa
		}
	}
}