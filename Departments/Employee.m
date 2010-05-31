// 
//  Employee.m
//  Departments
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Employee.h"


@implementation Employee 

@dynamic lastName;
@dynamic firstName;
@dynamic department;

+ (NSSet *)keyPathsForValuesAffectingFullName
{
	return [NSSet setWithObjects:@"firstName", @"lastName", nil];
}

- (NSString *)fullName
{
	NSString * first = [self firstName];
	NSString * last = [self lastName];
	if (!first)
		return last;
	if (!last)
		return first;
	return [NSString stringWithFormat:@"%@ %@", first, last];
}

@end
