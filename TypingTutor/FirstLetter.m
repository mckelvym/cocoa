//
//  FirstLetter.m
//  TypingTutor
//
//  Created by mark mckelvy on 5/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FirstLetter.h"


@implementation NSString (FirstLetter)

- (NSString *)BNR_firstLetter
{
	if ([self length] <= 1)
		return self;
	
	NSRange range;
	range.location = 0;
	range.length = 1;
	
	return [self substringWithRange:range];
}
	
@end
