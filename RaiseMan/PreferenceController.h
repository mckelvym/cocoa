//
//  PreferenceController.h
//  RaiseMan
//
//  Created by mark mckelvy on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;
extern NSString * const BNRColorChangedNotification;

@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell * colorWell;
	IBOutlet NSButton * checkBox;
}

- (NSColor *)tableBackgroundColor;
- (BOOL)emptyDoc;
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)resetPreferences:(id)sender;

@end
