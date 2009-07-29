## Requirements ##

- [stomppy][1]

   As it is now it is necessary to [patch stomppy][2] to provide some
   sanity if it cannot connect to the broker.

[1]: http://code.google.com/p/stomppy/
[2]: http://code.google.com/p/stomppy/issues/detail?id=4

## Basic usage ##

	#!/usr/bin/env python

	import logging
	from handler import STOMPHandler

	class LogPanelFormatter(logging.Formatter):
    	doc = "<?xml version='1.0'?>\n \
          	<logentries> \
            	<logentry ts='%(created)f' category='%(name)s' level='%(levelname)s'> \
            	%(message)s \
            	</logentry> \
        		</logentries>"
    	def __init__(self):
        	logging.Formatter.__init__(self, self.doc)


	handler = STOMPHandler("localhost", 61613, "/topic/logpanel")
	handler.setFormatter(LogPanelFormatter())

	logger = logging.getLogger("LogPanel example")
	logger.addHandler(handler)

	logger.warn("Hello, world.")
