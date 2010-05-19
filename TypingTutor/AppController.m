//
//  AppController.m
//  TypingTutor
//
//  Created by mark mckelvy on 5/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "BigLetterView.h"

#define MAX_COUNT (100)

@implementation AppController

- (id)init
{
	[super init];
	
	// Create an array of letters
	letters = [[NSArray alloc] 
			   initWithObjects:@"a", @"s", @"d", @"f", @"j", @"k", @"l", @";", nil];
	
	// Seed the random number generator
	srandom(time(NULL));
	stepSize = 5;
	return self;
}

- (void)awakeFromNib
{
	[self showAnotherLetter];
}

- (IBAction)stopAndGo:(id)sender
{
	if (timer == nil)
	{
		NSLog(@"Starting");
		
		// Create a timer
		timer = [[NSTimer scheduledTimerWithTimeInterval:0.1
												target:self
												selector:@selector(checkThem:)
												userInfo:nil
												 repeats:YES] retain];
	}
	else
	{
		NSLog(@"Stopping");
		
		// Invalidate and release the timer
		[timer invalidate];
		[timer release];
		timer = nil;
	}
}


- (IBAction)showSpeedSheet:(id)sender
{
	[NSApp beginSheet:speedSheet
		modalForWindow:[source window]
		modalDelegate:nil
	   didEndSelector:NULL
		  contextInfo:NULL];
}

- (IBAction)endSpeedSheet:(id)sender
{
	[NSApp endSheet:speedSheet];
	
	[speedSheet orderOut:sender];
}

- (void)incrementCount
{
	[self willChangeValueForKey:@"count"];
	count = count + stepSize;
	if (count > MAX_COUNT)
	{
		count = MAX_COUNT;
	}
	[self didChangeValueForKey:@"count"];
}

- (void)resetCount
{
	[self willChangeValueForKey:@"count"];
	count = 0;
	[self didChangeValueForKey:@"count"];
}

- (void)showAnotherLetter
{
	// Choose random numbers until you get a different
	// number than last time
	int x = lastIndex;
	while (x == lastIndex)
	{
		x = random() % [letters count];
	}
	lastIndex = x;
	[destination setString:[letters objectAtIndex:lastIndex]];
	
	// Start the count again
	[self resetCount];
}

- (void)checkThem:(NSTimer *)aTimer
{
	if ([[source string] isEqual:[destination string]])
	{
		[self showAnotherLetter];
	}
	if (count == MAX_COUNT)
	{
		NSBeep();
		[self resetCount];
	}
	else
	{
		[self incrementCount];
	}
}
@end
