//
//  PreferenceController.m
//  RaiseMan
//
//  Created by mark mckelvy on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PreferenceController.h"
#import "AppController.h"

@implementation PreferenceController

NSString * const BNRTableBgColorKey = @"TableBackgroundColor";
NSString * const BNREmptyDocKey = @"EmptyDocumentFlag";
NSString * const BNRColorChangedNotification = @"BNRColorChanged";

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
	[colorWell setColor:[self tableBackgroundColor]];
	[checkBox setState:[self emptyDoc]];
}

- (NSColor *)tableBackgroundColor
{
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	NSData * colorAsData = [defaults objectForKey:BNRTableBgColorKey];
	return [NSKeyedUnarchiver unarchiveObjectWithData:colorAsData];
}

- (BOOL)emptyDoc
{
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	return [defaults boolForKey:BNREmptyDocKey];
}

- (IBAction)changeBackgroundColor:(id)sender
{
	NSColor * color = [colorWell color];
	NSLog(@"Color changed: %@", color);
	NSData * colorAsData = [NSKeyedArchiver archivedDataWithRootObject:color];
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:colorAsData forKey:BNRTableBgColorKey];
	
	NSNotificationCenter * nc = [NSNotificationCenter defaultCenter];
	NSLog(@"Sending notification");
	NSDictionary * d = [NSDictionary dictionaryWithObject:color forKey:@"color"];
	[nc postNotificationName:BNRColorChangedNotification object:self userInfo:d];
}

- (IBAction)changeNewEmptyDoc:(id)sender
{
	int state = [checkBox state];
	NSLog(@"Checkbox state changed: %d", state);
	NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
	[defaults setBool:state	forKey:BNREmptyDocKey];
}

- (IBAction)resetPreferences:(id)sender
{
	NSLog(@"Not resetting preferences");
	
}

@end
