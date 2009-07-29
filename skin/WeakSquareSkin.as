package 
{
	import flash.display.Graphics;
	
	import mx.skins.ProgrammaticSkin;

	public class WeakSquareSkin extends ProgrammaticSkin
	{
		public function WeakSquareSkin()
		{
			super();
		}
		
		override public function get measuredWidth():Number
		{
			return 2;
		}
		
		override public function get measuredHeight():Number
		{
			return 2;
		}
		
		override protected function updateDisplayList(w:Number, h:Number):void
		{
			super.updateDisplayList(w, h);
	
			var g:Graphics = graphics;
			
			g.clear();
			g.beginFill(0,0.15);
			g.drawRect(0, 0, w, h);
			g.endFill();
		}
	}
}