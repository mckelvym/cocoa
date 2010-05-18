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
	[self prepareAttributes];
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
	[attributes release];
	[backgroundColor release];
	[string release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect
{
	NSRect bounds = [self bounds];
	[backgroundColor set];
	[NSBezierPath fillRect:bounds];
	[self drawStringCenteredIn:bounds];
	
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

- (void)prepareAttributes
{
	attributes = [[NSMutableDictionary alloc] init];
	
	[attributes setObject:[NSFont fontWithName:@"Helvetica" size:75] 
				   forKey:NSFontAttributeName];
	
	[attributes setObject:[NSColor redColor] forKey:NSForegroundColorAttributeName];
}

- (void)drawStringCenteredIn:(NSRect) r
{
	NSSize strSize = [string sizeWithAttributes:attributes];
	NSPoint strOrigin;
	strOrigin.x	 = r.origin.x + (r.size.width - strSize.width)/2;
	strOrigin.y  = r.origin.y + (r.size.height - strSize.height)/2;
	[string drawAtPoint:strOrigin withAttributes:attributes];
}

- (void)didEnd:(NSSavePanel *)sheet returnCode:(int)code contextInfo:(void *)contextInfo
{
	if (code != NSOKButton)
		return;
	
	NSRect r = [self bounds];
	NSData * data = [self dataWithPDFInsideRect:r];
	NSString * path = [sheet filename];
	NSError * error;
	
	BOOL successful = [data writeToFile:path options:0 error:&error];
	
	if (!successful)
	{
		NSAlert * alert = [NSAlert alertWithError:error];
		[alert runModal];
	}
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
	[self setNeedsDisplay:YES];
}

- (NSString *)string
{
	return string;
}

#pragma mark Actions

- (IBAction)savePDF:(id)sender
{
	NSSavePanel *panel = [NSSavePanel savePanel];
	[panel setRequiredFileType:@"pdf"];
	[panel beginSheetForDirectory:nil 
							 file:nil 
				   modalForWindow:[self window] 
					modalDelegate:self 
				   didEndSelector:@selector(didEnd:returnCode:contextInfo:)
					  contextInfo:NULL];
}

@end
