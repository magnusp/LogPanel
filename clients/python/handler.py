#!/usr/bin/env python
import stomp

import time
import logging

class STOMPHandler(logging.Handler):
    """
    A handler class which emits log messages to a STOMP destination.
    """

    brokerhost = None
    brokerport = None
    destination = None
    
    def __init__(self, brokerhost, brokerport, destination="/topic/pythonlogging", credentials=None):
        logging.Handler.__init__(self)
        self.brokerhost = brokerhost
        self.brokerport = brokerport
        self.destination = destination
        self.make_connection()
    
    def make_connection(self):
        try:
            self.conn = stomp.Connection([(self.brokerhost, self.brokerport)], reconnect_sleep_max=3, reconnect_attempts_max=1)
            self.conn.start()
            self.conn.connect()
        except:
            pass

    def emit(self, record):
        try:
            
            if not self.conn.is_connected():
                self.make_connection()
            
            self.conn.send(self.format(record), destination=self.destination)

        except (KeyboardInterrupt, SystemExit):
            raise

        except:
            self.handleError(record)
