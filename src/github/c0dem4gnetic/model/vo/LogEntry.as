package github.c0dem4gnetic.model.vo
{
	import mx.formatters.DateFormatter;

	public class LogEntry
	{
		public var ts:uint;
		public var category:String;
		public var level:String;
		public var message:String;
		
		
		
		public function LogEntry()
		{
			if(df==null) {
				df=new DateFormatter();
			}
		}
		
		public function get dateTime():String {
			df.formatString = LogEntry.DateTimeFormat;
			return df.format(new Date(ts));
		}
	}
}