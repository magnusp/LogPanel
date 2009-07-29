package github.c0dem4gnetic.view
{
	import github.c0dem4gnetic.model.StompProxy;
	import github.c0dem4gnetic.view.component.LogPanel;
	
	import mx.utils.ObjectProxy;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LogPanelMediator extends Mediator
	{
		
		public static const NAME:String = 'LogPanelMediator';

		
		public function LogPanelMediator(viewComponent:LogPanel)
		{
			super(NAME, viewComponent);
			
		}
		
		override public function onRegister():void {

		}
		
		protected function get logPanel():LogPanel
		{
			return viewComponent as LogPanel;
		}

		override public function listNotificationInterests():Array
		{
			return [StompProxy.MESSAGE]
		}
		
		override public function handleNotification(note:INotification):void
		{		
			switch(note.getName()) {
				case StompProxy.MESSAGE:
					for each(var logEntry:XML in note.getBody() as Array) {
						logPanel.logEntries.addItem(logEntry);
					}
					break;
			}
		}
	}
}