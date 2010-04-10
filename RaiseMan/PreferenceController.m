//
//  PreferenceController.m
//  RaiseMan
//
//  Created by mark mckelvy on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"


@implementation PreferenceController

- (id)init
{
	// or BOOL successful = [NSBundle loadNibNamed:@"About" owner:someObject];
	if (![super initWithWindowNibName:@"Preferences"])
		return nil;
	return self;
}

- (void)windowDidLoad
{
	NSLog(@"Xib file is loaded.");
}

- (IBAction)changeBackgroundColor:(id)sender
{
	NSColor * color = [colorWell color];
	NSLog(@"Color changed: %@", color);
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkBox state];
	NSLog(@"Checkbox state changed: %d", state);
}

@end
