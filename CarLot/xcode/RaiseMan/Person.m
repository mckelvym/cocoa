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
	NSLog(@"Person init");
	//expectedRaise = 5.0;
	[self setExpectedRaise:5.0];
	personName = @"A New Person";
	NSLog(@"Person description: %@", self);
	return self;
}

- (id)initWithCoder:(NSCoder *)coder;
{
	[super init];
	// [super initWithCoder:coder];
	NSLog(@"initWithCoder");
	[self setValue:[coder decodeObjectForKey:@"personName"] forKey:@"personName"];
	//personName = [coder decodeObjectForKey:@"personName"];
	NSLog(@"personName = %@", personName);
	[self setValue:[[NSNumber alloc] initWithFloat:[coder decodeFloatForKey:@"expectedRaise"]] 
			forKey:@"expectedRaise"];
	//expectedRaise = [coder decodeFloatForKey:@"expectedRaise"];
	NSLog(@"expectedRaise = %f", expectedRaise);
	return self;
}

- (NSString *)description
{
	NSString * description = [[NSString alloc] initWithFormat:@"%@, expected raise: %f", 
							  personName,
							  expectedRaise];
	[description autorelease];							
	return description;
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
	NSLog(@"Person setting Nil Value for key %@", s);
	if ([s isEqual:@"expectedRaise"])
		[self setExpectedRaise:1.0];
	else
		[super setNilValueForKey:s];
}

@end
