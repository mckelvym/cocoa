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

- (id)initWithCoder:(NSCoder *)coder;
{
	[super init];
	// [super initWithCoder:coder];
	NSLog(@"initWithCoder");
	personName = [coder decodeObjectForKey:@"personName"];
	NSLog(@"personName = %@", personName);
	expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	NSLog(@"expectedRaise = %f", expectedRaise);
	return self;
}

- (void)dealloc
{
	[personName release];
	[super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	// [super encodeWithCoder:coder];
	NSLog(@"encoding object %@", self);
	[coder encodeObject:personName forKey:@"personName"];
	[coder encodeFloat:expectedRaise forKey:@"expectedRaise"];
}

- (void)setNilValueForKey:(NSString *)s
{
	if ([s isEqual:@"expectedRaise"])
		[self setExpectedRaise:0.0];
	else
		[super setNilValueForKey:s];
}

@end
