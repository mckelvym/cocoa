//
//  BigLetterView.m
//  TypingTutor
//
//  Created by mark mckelvy on 5/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BigLetterView.h"


@implementation BigLetterView

- (id)initWithFrame:(NSRect) rect
{
	if (![super initWithFrame:rect])
		return nil;
	
	NSLog(@"initializing view");
	backgroundColor = [[NSColor yellowColor] retain];
	string = @" ";
	isHighlighted = NO;
	
	[[self window] setAcceptsMouseMovedEvents:YES];
	return self;
}


// Tracking areas
- (void)viewDidMoveToWindow
{
	int options = NSTrackingMouseEnteredAndExited |
					NSTrackingActiveAlways |
					NSTrackingInVisibleRect;
	NSTrackingArea * trackingArea;
	trackingArea = [[NSTrackingArea alloc] initWithRect:NSZeroRect
												options:options 
												  owner:self 
											   userInfo:nil];
	[self addTrackingArea:trackingArea];
	[trackingArea release];
}

- (void)mouseEntered:(NSEvent *)event
{
	isHighlighted = YES;
	[self setNeedsDisplay:YES];
}

- (void)mouseExited:(NSEvent *)event
{
	isHighlighted = NO;
	[self setNeedsDisplay:YES];
}
	
- (void)dealloc
{
	[backgroundColor release];
	[string release];
	[self dealloc];
}

- (void)drawRect:(NSRect)rect
{
	NSRect bounds = [self bounds];
	[backgroundColor set];
	[NSBezierPath fillRect:bounds];
	
	// Am I the window's first responder?
	if ([[self window] firstResponder] == self &&
		[NSGraphicsContext currentContextDrawingToScreen])
	{
		[NSGraphicsContext saveGraphicsState];
		NSSetFocusRingStyle(NSFocusRingOnly);
		//[[NSColor keyboardFocusIndicatorColor] set];
		//[NSBezierPath setDefaultLineWidth:4.0];
		//[NSBezierPath strokeRect:bounds];
		[NSBezierPath fillRect:bounds];
		[NSGraphicsContext restoreGraphicsState];
	}
}

- (BOOL)isOpaque
{
	return YES;
}

- (BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)resignFirstResponder
{
	//[self setNeedsDisplay:YES];
	[self setKeyboardFocusRingNeedsDisplayInRect:[self bounds]];
	return YES;
}

- (BOOL)becomeFirstResponder
{
	[self setNeedsDisplay:YES];
	return YES;
}

- (void)keyDown:(NSEvent *)event 
{
	[self interpretKeyEvents:[NSArray arrayWithObject:event]];
}

- (void)insertText:(NSString *)input
{
	// Set string to be what the user typed
	[self setString:input];
}

- (void)insertTab:(id)sender
{
	[[self window] selectKeyViewFollowingView:self];
}

// Be careful with capitalization here "backtab" is considered one word
- (void)insertBacktab:(id)sender
{
	[[self window] selectKeyViewPrecedingView:self];
}

- (void)deleteBackward:(id)sender
{
	[self setString:@" "];
}

#pragma mark Accessors

- (void)setBackgroundColor:(NSColor *)color 
{
	[color retain];
	[backgroundColor release];
	backgroundColor = color;
	[self setNeedsDisplay:YES];
}

- (NSColor *)backgroundColor
{
	return backgroundColor;
}

- (void)setString:(NSString *)newChars
{
	newChars = [newChars copy];
	[string release];
	[newChars retain];
	string = newChars;
	NSLog(@"The string is now %@", string);
}

- (NSString *)string
{
	return string;
}


@end
