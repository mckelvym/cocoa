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
}
@property (retain, readwrite) NSColor * backgroundColor;
@property (copy, readwrite) NSString * string;
@end
