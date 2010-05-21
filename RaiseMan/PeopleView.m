//
//  PeopleView.m
//  RaiseMan
//
//  Created by mark mckelvy on 5/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PeopleView.h"
#import "Person.h"

@implementation PeopleView

- (id)initWithPeople:(NSArray *)persons
{
	// Call the superclass'es designated initializer
	[super initWithFrame:NSMakeRect(0, 0, 700, 700)];
	
	people = [persons copy];
	
	// The attributes fo the text to be printed
	attributes = [[NSMutableDictionary alloc] init];
	NSFont * font = [NSFont fontWithName:@"Monaco" size:12.0];
	lineHeight = [font capHeight] * 1.7;
	[attributes setObject:font	forKey:NSFontAttributeName];
	return self;
}

- (void)dealloc
{
	[people release];
	[attributes release];
	[super dealloc];
}

#pragma mark Pagination

- (BOOL)knowsPageRange:(NSRange *)range
{
	NSPrintOperation * po = [NSPrintOperation currentOperation];
	NSPrintInfo * printInfo = [po printInfo];
	
	// Where can I draw?
	pageRect = [printInfo imageablePageBounds];
	NSRect newFrame;
	newFrame.origin = NSZeroPoint;
	newFrame.size = [printInfo paperSize];
	[self setFrame:newFrame];
	
	// How many lines per page?
	linesPerPage = pageRect.size.height / lineHeight;
	
	// Pages are 1-based
	range->location = 1;
	
	// How many pages will it take?
	range->length = [people count] / linesPerPage;
	if ([people count] % linesPerPage)
	{
		range->length = range->length + 1;
	}
	
	return YES;
}

- (NSRect)rectForPage:(int)i
{
	// Note the current page
	currentPage = i-1;
	
	// Returnt eh same page rect everytime
	return pageRect;
}

#pragma mark Drawing

// The origin of the view is at the upper-left corner
- (BOOL)isFlipped
{
	return YES;
}

- (void)drawRect:(NSRect)r
{
	NSRect nameRect;
	NSRect raiseRect;
	raiseRect.size.height = nameRect.size.height = lineHeight;
	nameRect.origin.x = pageRect.origin.x;
	nameRect.size.width = 200.0;
	raiseRect.origin.x = NSMaxX(nameRect);
	raiseRect.size.width = 100.0;
	
	int i;
	for (i = 0; i < linesPerPage; i++)
	{
		int index = (currentPage * linesPerPage) + 1;
		if (index >= [people count])
		{
			break;
		}
		
		Person * p = [people objectAtIndex:index];
		
		// Draw index and name
		nameRect.origin.y = pageRect.origin.y + (i * lineHeight);
		NSString * nameString = [NSString stringWithFormat:@"%2d %@", index, [p personName]];
		
		[nameString drawInRect:nameRect withAttributes:attributes];
		
		raiseRect.origin.y = nameRect.origin.y;
		NSString * raiseString = [NSString stringWithFormat:@"%4.1f%%", [p expectedRaise]];
		
		[raiseString drawInRect:raiseRect withAttributes:attributes];
	}
}

@end
