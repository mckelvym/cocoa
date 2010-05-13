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
	opacity = 1.0;
	
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
	
	if (image)
	{
		NSRect imageRect;
		imageRect.origin = NSZeroPoint;
		imageRect.size = [image size];
		NSRect drawingRect = imageRect;
		[image drawInRect:drawingRect 
				fromRect:imageRect 
				operation:NSCompositeSourceOver 
				 fraction:opacity];
	}
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
	[image release];
	[super dealloc];
}

// Creating views programmatically
/*
NSView *superview = [window contentView]; 
NSRect frame = NSMakeRect(10, 10, 200, 100); 
NSButton *button = [[NSButton alloc] initWithFrame:frame]; 
[button setTitle:@"Click me!"]; 
[superview addSubview:button]; 
[button release];
 */

#pragma mark Events

- (void)mouseDown:(NSEvent *)event
{
	NSLog(@"mouseDown: %d", [event clickCount]);
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	NSLog(@"mouseDragged: %@", NSStringFromPoint(p));
}

- (void)mouseUp:(NSEvent *)event
{
	NSLog(@"mouseUp:");
}

#pragma mark Accessors

- (void)setImage:(NSImage *)newImage
{
	[newImage retain];
	[image release];
	image = newImage;
	[self setNeedsDisplay:YES];
}

- (float)opacity
{
	return opacity;
}

- (void)setOpacity:(float)x
{
	opacity = x;
	[self setNeedsDisplay:YES];
}

@end
