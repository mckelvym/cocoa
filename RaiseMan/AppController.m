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

+ (void)initialize
{
	// Create a dictionary
	NSMutableDictionary * defaultValues = [NSMutableDictionary dictionary];
	
	// Archive the color object
	NSData * colorAsData = [NSKeyedArchiver archivedDataWithRootObject:[NSColor yellowColor]];
	
	// Put defaults in the dictionary
	[defaultValues setObject:colorAsData	forKey:BNRTableBgColorKey];
	[defaultValues setObject:[NSNumber numberWithBool:YES] forKey:BNREmptyDocKey];
	
	// Register the dictionary of defaults
	[[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
	NSLog(@"registered defaults: %@", defaultValues);
}

- (void)awakeFromNib
{
	NSLog(@"awakeFromNib");
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
