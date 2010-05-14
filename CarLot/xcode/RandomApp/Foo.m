//
//  Foo.m
//  RandomApp
//
//  Created by mark mckelvy on 3/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Foo.h"


@implementation Foo

- (void)awakeFromNib
{
	NSCalendarDate * now;
	now = [NSCalendarDate calendarDate];
	[textField setObjectValue:now];
}

- (IBAction)generate:(id)sender
{
	// Generate a random number between 1 and 100 inclusive
	int num;
	num = (random() % 100) + 1;
	
	NSLog(@"num = %d", num);
	
	// Ask the text field to change what it is displaying
	[textField setIntValue:num];
}

- (IBAction)seed:(id)sender
{
	// Seed the random number generator with the time
	srandom(time(NULL));
	[textField setStringValue:@"Generator seeded."];
}

@end
