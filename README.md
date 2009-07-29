## About ##

LogPanel is an Adobe AIR based application that consumes log messages
aggregated by a ([STOMP][]) message broker. It has been successfully tested
with [Apache ActiveMQ][] and [morbidq][]. The project supplies some sample
client implementations to get started fairly quickly.

The purpose of LogPanel is to provide an application that can display log
messages from multiple sources. With LogPanel there is no longer a need to
have multiple terminals open for each environment, such as when logging
client/server communication. You could say that the message broker acts like
a bucket for log messages and LogPanel grabs messages from this bucket :)

Some graphical assets have been snatched from [De MonsterDebugger][], credits
to them!

[STOMP]: http://stomp.codehaus.org/
[Apache ActiveMQ]: http://activemq.apache.org/
[morbidq]: http://www.morbidq.com/
[De MonsterDebugger]: http://demonsterdebugger.com


## Trying out LogPanel ##

The binary distribution is set up to connect to the message broker on
localhost port 61613 which is default for the STOMP protocol. Notice that
a broker is **required** for LogPanel to work!


### Message brokers ###

If you have python installed [morbidq][] is by far the easiest to get
started with. [Apache ActiveMQ][] is also quite straightforward but probably
includes far more functionality than necessary for the purposes of LogPanel. 

If you want to test LogPanel without first creating an application that
logs messages there are some alternatives.

   - **ActiveMQ**

     ActiveMQ provides an web based interface for sending messages. Usage
     should be self explanatory, format the message according to the section
     "Client implementors". In a default installation of ActiveMQ, the web
     interface can be found at http://localhost:8161/admin/.

   - **stomppy (stomp.py)**

     [stomppy](http://code.google.com/p/stomppy/) provides a commandline
     client that can be used for testing purposes.


## Building ##

External dependencies

   - [as3-stomp](http://code.google.com/p/as3-stomp/)
   - [PureMVC MultiCore](http://trac.puremvc.org/PureMVC_AS3_MultiCore)

Currently Flash Builder beta, build 234740, is being used to build the binary
distribution. The git repository is based from a Flash Builder workspace that
requires that the dependencies are placed in a directory "externals". Using
subversion, the following commands, run from the project root, will set
everything up:

	$ mkdir externals
	$ cd externals
	$ svn export http://svn.puremvc.org/PureMVC_AS3_MultiCore/trunk PureMVC_AS3_MultiCore
	$ svn export http://as3-stomp.googlecode.com/svn/trunk/ as3-stomp
	
That is, the externals directory should exist at the same level as the
src directory.

	README.md
	assets/
	bin-debug/
	clients/
	external/
	libs/
	skin/
	src/


## Client implementors ##

Log messages are by default read from the topic "logpanel". Logging clients
should format their messages as the following example demonstrates:

	<?xml version='1.0'?>
	<logentries>
		<logentry ts="{unix timestamp}" category="{log name, source, etc}" level="{log level}">
			{log message}
		</logentry>
	</logentries>