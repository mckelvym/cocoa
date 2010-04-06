//
//  Person.m
//  RaiseMan
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Person.h"


@implementation Person
@synthesize personName;
@synthesize expectedRaise;

- (id)init
{
	[super init];
	expectedRaise = 5;
	personName = @"New Person";
	return self;
}

- (void)dealloc
{
	[personName release];
	[super dealloc];
}

- (void)setNilValueForKey:(NSString *)s
{
	if ([s isEqual:@"expectedRaise"])
		[self setExpectedRaise:0.0];
	else
		[super setNilValueForKey:s];
}

@end
