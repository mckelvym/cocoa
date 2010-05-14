//
//  CarArrayController.m
//  CarLot
//
//  Created by mark mckelvy on 4/9/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CarArrayController.h"


@implementation CarArrayController

- (id)newObject
{
	id newObject = [super newObject];
	NSDate * now = [NSDate date];
	[newObject setValue:now forKey:@"datePurchased"];
	return newObject;
}

@end
