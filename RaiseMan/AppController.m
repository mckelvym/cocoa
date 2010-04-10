//
//  AppController.m
//  RaiseMan
//
//  Created by mark mckelvy on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "PreferenceController.h"

@implementation AppController

- (void)awakeFromNib
{
	NSLog(@"awakeFromNib");
}

- (void)windowControllerDidLoadNib
{
	NSLog(@"windowControllerDidLoadNib");
}

- (IBAction)showPreferencePanel:(id)sender
{
	// Is preferenceController nil?
	if (!preferenceController)
	{
		preferenceController = [[PreferenceController alloc] init];
	}
	
	NSLog(@"showing %@", preferenceController);
	[preferenceController showWindow:self];
}

- (IBAction)showAboutPanel:(id)sender
{
	BOOL successful = [NSBundle loadNibNamed:@"About" owner:self];
	NSLog(@"About panel shown successful: %d", successful);
}

@end
