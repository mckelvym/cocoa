//
//  BigLetterView.m
//  TypingTutor
//
//  Created by mark mckelvy on 5/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BigLetterView.h"
#import "FirstLetter.h"

// Declare private methods using a category
@interface BigLetterView ()

- (void)somePrivateMethod;

@end

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
	[self registerForDraggedTypes:[NSArray arrayWithObject:NSStringPboardType]];
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
	[mouseDownEvent release];
	[super dealloc];
}

- (void)drawRect:(NSRect)rect
{
	NSRect bounds = [self bounds];
	
	// Draw gradient background if highlighted
	if (isHighlighted)
	{
		NSGradient * gradient = [[NSGradient alloc] initWithStartingColor:[NSColor whiteColor] endingColor:backgroundColor];
		[gradient drawInRect:bounds relativeCenterPosition:NSZeroPoint];
		[gradient release];
	}
	else
	{
		[backgroundColor set];
		[NSBezierPath fillRect:bounds];
	}
	
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

- (IBAction)cut:(id)sender
{
	[self copy:sender];
	[self setString:@""];
}
	
- (IBAction)copy:(id)sender
{
	[self writeToPasteboard:[NSPasteboard generalPasteboard]];
}

- (IBAction)paste:(id)sender
{
	if (![self readFromPasteboard:[NSPasteboard generalPasteboard]])
		NSBeep();
}

- (void)writeToPasteboard:(NSPasteboard *)board
{
	// Declare types
	[board declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
	
	// Copy data to the pasteboard
	[board setString:string forType:NSStringPboardType];
	
	// To lazily copy the data, implement the following method:
	// - (void)pasteboard:(NSPasteboard *)sender provideDataForType:(NSString *)type
	
	// If you implement this method, it will be called when you are no longer responsible
	// for keeping a snapshot:
	// - (void)pasteboardChangedOwner:(NSPasteboard *)sender;
}

- (BOOL)readFromPasteboard:(NSPasteboard *)board
{
	// Is there a string on the pasteboard?
	NSArray * types = [board types];
	if ([types containsObject:NSStringPboardType])
	{
		// Read the string from the pasteboard
		NSString * value = [board stringForType:NSStringPboardType];
		
		[self setString:[value BNR_firstLetter]];
		return YES;
	}
	return NO;
}

// Indicates that this view can be a drag source
// This method is called twice, once for isLocal = YES, and isLocal = NO
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
	return NSDragOperationCopy | NSDragOperationDelete;
}

- (void)mouseDown:(NSEvent *)event
{
	[event retain];
	[mouseDownEvent release];
	mouseDownEvent = event;
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint down = [mouseDownEvent locationInWindow];
	NSPoint drag = [event locationInWindow];
	float distance = hypot(down.x - drag.x, down.y - drag.y);
	if (distance < 3)
		return;
	
	// Is the string of zero length?
	if ([string	 length] == 0)
		return;
	
	// Get the size of the string
	NSSize s = [string sizeWithAttributes:attributes];
	
	// Create the image that will be dragged
	NSImage * anImage = [[NSImage alloc] initWithSize:s];
	
	// Create a rect in which you will draw the letter in the image
	NSRect imageBounds;
	imageBounds.origin = NSZeroPoint;
	imageBounds.size = s;
	
	// Draw the letter on the image
	[anImage lockFocus];
	[self drawStringCenteredIn:imageBounds];
	[anImage unlockFocus];
	
	// Get the location of the mouseDown event
	NSPoint p = [self convertPoint:down fromView:nil];
	
	// Drag from the center of the image
	p.x = p.x - s.width / 2;
	p.y = p.y - s.height / 2;
	
	// Get the pasteboard
	NSPasteboard * board = [NSPasteboard pasteboardWithName:NSDragPboard];
	
	// Put the string on the pasteboard
	[self writeToPasteboard:board];
	
	// Start the drag
	[self dragImage:anImage at:p offset:NSMakeSize(0, 0) event:mouseDownEvent pasteboard:board source:self slideBack:YES];
	[anImage release];
	
	// When the drop occurs, the drag source will be notificed if you implement the following method:
	// - (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation;
}

- (void)draggedImage:(NSImage *)image endedAt:(NSPoint)screenPoint operation:(NSDragOperation)operation
{
	if (operation == NSDragOperationDelete)
	{
		[self setString:@""];
	}
}

#pragma mark Dragging Destination

- (NSDragOperation)draggingEntered:(id <NSDraggingInfo>)sender
{
	NSLog(@"Dragging entered.");
	if ([sender draggingSource] == self)
		return NSDragOperationNone;
	
	isHighlighted = YES;
	[self setNeedsDisplay:YES];
	return NSDragOperationCopy;
}

- (NSDragOperation)draggingUpdated:(id <NSDraggingInfo>)sender
{
	NSDragOperation operation = [sender draggingSourceOperationMask];
	NSLog(@"operation mask = %d", operation);
	if ([sender draggingSource] == self)
	{
		return NSDragOperationNone;
	}
	return NSDragOperationCopy;
}

- (void)draggingExited:(id <NSDraggingInfo>)sender
{
	NSLog(@"Dragging exited.");
	isHighlighted = NO;
	[self setNeedsDisplay:YES];
}

- (BOOL)prepareForDragOperation:(id <NSDraggingInfo>)sender
{
	return YES;
}

- (BOOL)performDragOperation:(id <NSDraggingInfo>)sender
{
	NSPasteboard * board = [sender draggingPasteboard];
	if (![self readFromPasteboard:board])
	{
		NSLog(@"Error: Could not read from dargging pasteboard.");
		return NO;
	}
	
	return YES;
}

- (void)concludeDragOperation:(id <NSDraggingInfo>)sender
{
	NSLog(@"Conclude drag operation.");
	isHighlighted = NO;
	[self setNeedsDisplay:YES];
}

@end
