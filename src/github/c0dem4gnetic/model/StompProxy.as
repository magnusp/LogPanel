package github.c0dem4gnetic.model
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.controls.Alert;
	import mx.formatters.DateFormatter;
	
	import org.codehaus.stomp.Stomp;
	import org.codehaus.stomp.event.ConnectedEvent;
	import org.codehaus.stomp.event.MessageEvent;
	import org.codehaus.stomp.event.STOMPErrorEvent;
	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class StompProxy extends Proxy implements IProxy
	{
		public static const NAME:String = "StompProxy";
		
		public static const MESSAGE:String = NAME+"Message";
		
		private static var df:DateFormatter;
		public static var DateTimeFormat:String = "YYYY-MM-DD JJ:NN:SS";
		
		private static const DESTINATION:String = "/topic/logpanel";
		var logCache:Array = new Array();
		public function StompProxy()
		{
			super(NAME, new Stomp());
			var cacheScanTimer:Timer = new Timer(500);
			cacheScanTimer.addEventListener(TimerEvent.TIMER, onCacheTimer);
			cacheScanTimer.start();
		}
		
		private function get stomp():Stomp {
			return getData() as Stomp;
		}
		
		override public function onRegister():void {
			df= new DateFormatter();
			stomp.addEventListener(MessageEvent.MESSAGE, onStompMessage);
			stomp.addEventListener(ConnectedEvent.CONNECTED, onConnected);
			stomp.addEventListener(STOMPErrorEvent.ERROR, onError);
			stomp.addEventListener(IOErrorEvent.IO_ERROR, onError);
			doConnect();
			
		}
		
		private function onError(event:Event):void {
			Alert.show("\n\nError connecting to message broker.\nRetrying when this dialog is closed", "Connection error", 4, null, doConnect);
		}
		
		private function doConnect(event:Event=null):void {
			stomp.connect();
		}
		
		private function onCacheTimer(event:TimerEvent):void {
			if(logCache.length > 0) {
				var copy:Array = logCache.concat();
				if(copy.length > logCache.length) {
					trace("adsflksdjöf");
				}
				logCache = new Array();
				sendNotification(StompProxy.MESSAGE, copy);
			}
		}
		private function onStompMessage(event:MessageEvent):void {
			var doc:XML = new XML(event.message.body.toString());

			df.formatString = StompProxy.DateTimeFormat;
			for each(var node:XML in doc..logentry) {
				node.@datetime = df.format(new Date(int(node.@ts)*1000));
				logCache.push(node);
			}
			
		}
		
		private function onConnected(event:ConnectedEvent):void {
			stomp.subscribe(DESTINATION);
		}
	}
}