package
{
	import org.as3commons.logging.formatter.impl.DefaultFormatter;
	
	import org.as3commons.logging.LogLevel;
	import org.as3commons.logging.util.MessageUtil;

	public class LogPanelFormatter extends DefaultFormatter
	{
		override public function format(level:uint, message:String, params:Array):String {
			var doc:XML = new XML("<logentries></logentries>");

			doc.logentry = new XML("<logentry><![CDATA[" + MessageUtil.toString(message, params) + "]]></logentry>");
			doc.logentry.@ts = int((new Date()).getTime()/1000);
			doc.logentry.@category = contextDict['loggerName'];
			doc.logentry.@level = LogLevel.toString(level);

			return "<?xml version='1.0'?>\n" + doc.toXMLString();
		}
	}
}