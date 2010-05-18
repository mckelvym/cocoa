//
//  BigLetterView.h
//  TypingTutor
//
//  Created by mark mckelvy on 5/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BigLetterView : NSView {
	NSColor *backgroundColor;
	NSString *string;
	BOOL isHighlighted;
	NSMutableDictionary * attributes;
}
@property (retain, readwrite) NSColor * backgroundColor;
@property (copy, readwrite) NSString * string;

- (void)prepareAttributes;
- (void)drawStringCenteredIn:(NSRect) r;
- (IBAction)savePDF:(id)sender;
- (IBAction)cut:(id)sender;
- (IBAction)copy:(id)sender;
- (IBAction)paste:(id)sender;
- (void)didEnd:(NSSavePanel *)sheet returnCode:(int)code contextInfo:(void *)contextInfo;
- (void)writeToPasteboard:(NSPasteboard *)board;
- (BOOL)readFromPasteboard:(NSPasteboard *)board;
@end
