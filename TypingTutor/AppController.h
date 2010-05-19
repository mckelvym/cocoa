//
//  AppController.h
//  TypingTutor
//
//  Created by mark mckelvy on 5/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BigLetterView;

@interface AppController : NSObject {
	IBOutlet BigLetterView * source;
	IBOutlet BigLetterView * destination;
	
	NSArray * letters;
	int lastIndex;
	
	// NSRunLoop is an object that waits for events
	// to arrive. It waits for timer events to arrive
	// and forwards them to NSTimer
	// To get the NSApplication's current event:
	// [NSApp currentEvent]
	NSTimer * timer;
	int count;
}

- (IBAction)stopAndGo:(id)sender;
- (void)incrementCount;
- (void)resetCount;
- (void)showAnotherLetter;

@end
