package github.c0dem4gnetic.controller
{
	import github.c0dem4gnetic.model.StompProxy;
	import github.c0dem4gnetic.view.LogPanelMediator;
	
	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class StartupCommand extends SimpleCommand implements ICommand
	{
		override public function execute(note:INotification):void
		{
			var app:Main = note.getBody() as Main;

			facade.registerMediator(new LogPanelMediator(app.logPanel));
			
			facade.registerProxy(new StompProxy());
			/*facade.registerCommand(SyncCommand.REGISTER, SyncCommand);
			facade.registerCommand(StratusProxy.STRATUSCONNECTED, StratusCommand);
			
			facade.registerProxy(new UserMappingProxy());
			facade.registerProxy(new DjangoProxy());	
			facade.registerProxy(new StratusProxy());
			
			facade.registerMediator(new ApplicationMediator(app));
			facade.registerMediator(new ChatMediator(app.chat));*/
			
		
		}
	}
}