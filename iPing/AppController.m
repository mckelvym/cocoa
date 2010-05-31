//
//  AppController.m
//  iPing
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (IBAction)startStopPing:(id)sender
{
	// Is the task running?
	if (task)
	{
		[task interrupt];
	}
	else
	{
		task = [[NSTask alloc] init];
		[task setLaunchPath:@"/sbin/ping"];
		NSArray * args = [NSArray arrayWithObjects:@"-c10", [hostField stringValue], nil];
		[task setArguments:args];
		
		// Release old pipe
		[pipe release];
		
		// Create a new pipe
		pipe = [[NSPipe alloc] init];
		[task setStandardOutput:pipe];
		
		NSFileHandle * handle = [pipe fileHandleForReading];
		
		NSNotificationCenter * nc;
		nc = [NSNotificationCenter defaultCenter];
		[nc removeObserver:self];
		[nc addObserver:self selector:@selector(dataReady:)
				   name:NSFileHandleReadCompletionNotification
				 object:handle];
		[nc addObserver:self selector:@selector(taskTerminated:)
				   name:NSTaskDidTerminateNotification
				 object:task];
		[task launch];
		[outputView setString:@""];
		
		[handle readInBackgroundAndNotify];
	}
}

- (void)appendData:(NSData *)data
{
	NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSTextStorage * tstorage = [outputView textStorage];
	[tstorage replaceCharactersInRange:NSMakeRange([tstorage length], 0) 
							withString:string];
	[string release];
}

- (void)dataReady:(NSNotification *)notification
{
	NSData * data;
	data = [[notification userInfo] valueForKey:NSFileHandleNotificationDataItem];
	NSLog(@"dataReady:%d bytes", [data length]);
	
	if ([data length])
	{
		[self appendData:data];
	}
	
	// If the task is running, start reading again
	if (task)
		[[pipe fileHandleForReading] readInBackgroundAndNotify];
}

- (void)taskTerminated:(NSNotification *)notification
{
	NSLog(@"task terminated.");
	
	[task release];
	task = nil;
	
	[startButton setState:0];
}

@end
