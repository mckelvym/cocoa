//
//  StretchView.m
//  ImageFun
//
//  Created by mark mckelvy on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StretchView.h"


@implementation StretchView

- (void)drawRect:(NSRect)rect
{
	// rect is the region that is dirty, and may be less than bounds
	
	// [self setNeedsDisplay:YES];
	// [self setNeedsDisplayInRect:dirtyRect];
	// NSRect dirtyRect = NSMakeRect(0, 0, 50, 50);
	
	NSRect bounds = [self bounds];
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
}

@end
