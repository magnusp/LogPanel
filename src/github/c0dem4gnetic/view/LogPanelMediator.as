package github.c0dem4gnetic.view
{
	import github.c0dem4gnetic.model.ConfigProxy;
	import github.c0dem4gnetic.model.StompProxy;
	import github.c0dem4gnetic.view.component.LogPanel;
	
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.mediator.Mediator;

	public class LogPanelMediator extends Mediator
	{
		
		public static const NAME:String = 'LogPanelMediator';
		private var defaultLabelColor:uint;
		private var defaultRowColor:uint;
		
		public function LogPanelMediator(viewComponent:LogPanel)
		{
			super(NAME, viewComponent);
		}
		
		override public function onRegister():void {
			var configProxy:ConfigProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
			defaultLabelColor = uint(configProxy.config.color.@defaultText);
			defaultRowColor = uint(configProxy.config.color.@defaultRow);
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
			var configProxy:ConfigProxy;
			switch(note.getName()) {
				case StompProxy.MESSAGE:
					configProxy = facade.retrieveProxy(ConfigProxy.NAME) as ConfigProxy;
					for each(var logEntry:XML in note.getBody() as Array) {
						logEntry.@textcolor = defaultLabelColor;
						logEntry.@rowcolor = defaultRowColor;
						
						var configColorNode:XML = configProxy.config.color.levels.level.(attribute("value") == logEntry.attribute("level"))[0];
						if(configColorNode) {
							logEntry.@textcolor = configColorNode.hasOwnProperty("@textcolor") ? uint(configColorNode.@textcolor) : defaultLabelColor;
							logEntry.@rowcolor = configColorNode.hasOwnProperty("@rowcolor") ? uint(configColorNode.@rowcolor) : defaultRowColor;
						}
						
						logPanel.logEntries.addItem(logEntry);
					}
					break;
			}
		}
	}
}