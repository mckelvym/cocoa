//
//  StretchView.m
//  ImageFun
//
//  Created by mark mckelvy on 4/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "StretchView.h"


@implementation StretchView

- (id)initWithFrame:(NSRect)rect
{
	if (![super initWithFrame:rect])
		return nil;
	
	// Seed random number generator
	srandom(time(NULL));
	
	// Create path object
	bezierPath = [[NSBezierPath alloc] init];
	[bezierPath setLineWidth:3.0];
	
	NSPoint p = [self randomPoint];
	[bezierPath moveToPoint:p];
	int i;
	for (int i = 0; i < 15; i++)
	{
		p = [self randomPoint];
		[bezierPath lineToPoint:p];
	}
	[bezierPath closePath];
	
	return self;
}

- (void)drawRect:(NSRect)rect
{
	// rect is the region that is dirty, and may be less than bounds
	
	// [self setNeedsDisplay:YES];
	// [self setNeedsDisplayInRect:dirtyRect];
	// NSRect dirtyRect = NSMakeRect(0, 0, 50, 50);
	
	NSRect bounds = [self bounds];
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
	
	// Draw the path in white
	[[NSColor whiteColor] set];
	[bezierPath stroke];
}

- (NSPoint)randomPoint
{
	NSPoint result;
	NSRect r = [self bounds];
	result.x = r.origin.x + random() % (int) r.size.width;
	result.y = r.origin.y + random() % (int) r.size.height;
	
	return result;
}
	
- (void)dealloc
{
	[bezierPath release];
	[super dealloc];
}

@end
