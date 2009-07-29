## Requirements ##

- [as3-commons (logging)][1]
- [as3-commons-logging-extensions][2]
- [as3-stomp][3]

[1]: http://code.google.com/p/as3-commons/
[2]: http://github.com/c0dem4gnetic/as3-commons-logging-extensions/tree/master
[3]: http://code.google.com/p/as3-stomp/

## Basic usage ##

The log formatter class LogPanelFormatter is included in this directory.

	import org.as3commons.logging.impl.FormattedLoggerFactory;
	import org.as3commons.logging.impl.StompLoggerFactory;
	import org.as3commons.logging.formatter.FormatterRegistry;
	import org.as3commons.logging.ILogger;
	import org.as3commons.logging.LoggerFactory;
	import org.codehaus.stomp.Stomp;

	public function logTest():void {
		var stomp:Stomp = new Stomp();
		stomp.connect(); // Defaults to localhost port 61613
		LoggerFactory.loggerFactory = new StompLoggerFactory(stomp, "/topic/logpanel");

		var logger:ILogger = LoggerFactory.getClassLogger(LogTest);
		FormatterRegistry.setFormatter(logger, LogPanelFormatter);
		logger.warn("Hello, world.");
	}