package github.c0dem4gnetic.model
{
	import flash.filesystem.File;
	
	import org.puremvc.as3.multicore.utilities.air.xmldb.model.XMLDatabaseProxy;

	public class ConfigProxy extends XMLDatabaseProxy
	{
		public static const NAME:String = 'ConfigProxy';
		
		public function ConfigProxy()
		{
			super(NAME);
			initialize("ApplicationConfig.xml", File.applicationStorageDirectory);
		}
		
		override protected function build():XML
        {
            // Creating default configuration
            var dbXML:XML = 
            <config>
				<color defaultText="0x0" defaultRow="0xFFFFFF">
					<levels>
						<level value="ERROR" textcolor="0xFF0000"/>
						<level value="FATAL" textcolor="0xFF0000"/>
			  			<level value="WARN" textcolor="0xFF0000"/>
			  			<level value="WARNING" textcolor="0xFF0000"/>
					</levels>
				</color>
			</config>
            return dbXML;
        }

		public function get config():XML {
			return getData() as XML;
		}
	}
}