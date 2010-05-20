//
//  ColorFormatter.m
//  TypingTutor
//
//  Created by mark mckelvy on 5/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ColorFormatter.h"

@interface ColorFormatter ()

- (NSString *)firstColorKeyForPartialString:(NSString *)string;

@end

@implementation ColorFormatter

- (id)init
{
	[super init];
	colorList = [[NSColorList colorListNamed:@"Apple"] retain];
	return self;
}

- (void)dealloc
{
	[colorList release];
	[super dealloc];
}

- (NSString *)firstColorKeyForPartialString:(NSString *)string
{
	// Is the key zero-length?
	if ([string length] == 0)
	{
		return nil;
	}
	
	// Loop through the color list
	for (NSString * key in [colorList allKeys])
	{
		NSRange whereFound = [key rangeOfString:string
										options:NSCaseInsensitiveSearch];
		// Does the string match the beginning of the color name?
		if ((whereFound.location == 0) && (whereFound.length > 0))
		{
			return key;
		}
	}
	// If no match is found, return nil
	return nil;
}

- (NSString *)stringForObjectValue:(id)obj
{
	// Not a color?
	if (![obj isKindOfClass:[NSColor class]])
		return nil;
	
	// Convert to an RGB Color Space
	NSColor * color;
	color = [obj colorUsingColorSpaceName:NSCalibratedRGBColorSpace];
	
	// Get components as floats between 0 and 1
	CGFloat r, g, b;
	[color getRed:&r
			green:&g 
			 blue:&b
			alpha:NULL];
	
	// Initialize distance
	float minDistance = 3.0;
	NSString * closestKey = nil;
	
	// Find the closest color
	for (NSString * key in [colorList allKeys])
	{
		NSColor * c = [colorList colorWithKey:key];
		CGFloat c_r, c_g, c_b;
		[c getRed:&c_r
			green:&c_g
			 blue:&c_b 
			alpha:NULL];
		
		// How far apart are 'color' and 'c'?
		float dist = pow(r - c_r, 2) + pow(g - c_g, 2) + pow(b - c_b, 2);
		
		// Is this the closest distance so far?
		if (dist < minDistance)
		{
			minDistance = dist;
			closestKey = key;
		}
	}
	
	// Return closest color
	return closestKey;
}

- (BOOL)getObjectValue:(id *)obj
			 forString:(NSString *)string
	  errorDescription:(NSString **)errorString
{
	NSLog(@"String to lookup: %@", string);
	// Look up the color for 'string'
	NSString * matchingKey = [self firstColorKeyForPartialString:string];
	if (matchingKey)
	{
		NSLog(@"Matching key: %@", matchingKey);
		*obj = [colorList colorWithKey:matchingKey];
		return YES;
	}
	else
	{
		// Occasionally, 'errorString' is NULL
		if (errorString != NULL)
		{
			*errorString = [NSString stringWithFormat:@"'%@' is not a color", string];
		}
		return NO;
	}
}

// Delegate of the text field
// If YES, control displays the string as is,
// If NO, delegate agrees with formatter.
- (BOOL)control:(NSControl *)control
		didFailToFormatString:(NSString *)string
		errorDescription:(NSString *)errorString
{
	NSLog(@"AppController told that formatting of %@ failed: %@",
		  string, errorString);
	return NO;
}

// To check partial strings for formatting,
// If NO, partial is not acceptable, formatter may
// supply the newString and an errorString
// If YES, newString and errorString are ignored.
/*
- (BOOL)isPartialStringValid:(NSString *)partial
			newEditingString:(NSString **)newString 
			errorDescription:(NSString **)errorString
{
	// Zero length is ok
	if ([partial length] == 0)
		return YES;
	
	NSString * match = [self firstColorKeyForPartialString:partial];
	if (match)
		return YES;
	else
	{
		if (errorString)
		{
			*errorString = @"No such color";
		}
		return NO;
	}
}
 */

// Autocomplete functionality
- (BOOL)isPartialStringValid:(NSString **)partial
	   proposedSelectedRange:(NSRange *)selPtr
			  originalString:(NSString *)origString
	   originalSelectedRange:(NSRange)origSel
			errorDescription:(NSString **)errorString
{
	// Zero length is fine
	if ([*partial length] == 0)
		return YES;
	
	NSString * match = [self firstColorKeyForPartialString:*partial];
	
	// No color match?
	if (!match)
	{
		return NO;
	}
	
	// If this would not move the beginning of the selection,
	// it is a delete
	if (origSel.location == selPtr->location)
	{
		return YES;
	}
	
	// If the partial string is shorter than the match,
	// provide the match and set the selection
	if ([match length] != [*partial length])
	{
		selPtr->location = [*partial length];
		selPtr->length = [match length] - selPtr->location;
		*partial = match;
		return NO;
	}
	return YES;
}

// For attributed strings, if the following method is
// defined, it will be used instead of stringForObjectValue:
// (NSAttributedString *)attributedStringForObjectValue:(id)obj 
//								withDefaultAttributes:(NSDictionary *)dict

- (NSAttributedString *)attributedStringForObjectValue:(id)obj
								 withDefaultAttributes:(NSDictionary *)attributes
{
	NSMutableDictionary * md = [attributes mutableCopy];
	NSString * match = [self stringForObjectValue:obj];
	if (match)
	{
		[md setObject:obj forKey:NSForegroundColorAttributeName];
	}
	else
	{
		match = @"";
	}
	
	NSAttributedString * atString;
	atString = [[NSAttributedString alloc] initWithString:match attributes:md];
	[md release];
	[atString autorelease];
	return atString;
}

@end
