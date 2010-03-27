//
//  LotteryEntry.m
//  lottery
//
//  Created by mark mckelvy on 3/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LotteryEntry.h"


@implementation LotteryEntry

- (id)init
{
	return [self initWithEntryDate:[NSCalendarDate calendarDate]];
	
	// OR
	// [self dealloc];
	// @throw [NSException exceptionWIthName:@"Bad init call" reason:@"Dumb" userInfo:nil];
	// return nil;
}

- (id)initWithEntryDate:(NSCalendarDate *)date
{
	if (![super init])
		return nil;
	[self prepareRandomNumbers];
	NSAssert(date != nil, @"Date argument must be non-nil");
	entryDate = date;
	return self;	
}

- (NSString *)description
{
	NSString * description = [[NSString alloc] initWithFormat:@"%@: %d, %d", 
							  [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
							  firstNumber, 
							  secondNumber];
	return description;
}

- (void)prepareRandomNumbers
{
	firstNumber = random() % 100 + 1;
	secondNumber = random() % 100 + 1;
}

- (void)setEntryDate:(NSCalendarDate *)date
{
	entryDate = date;
}

- (NSCalendarDate *)getEntryDate
{
	return entryDate;
}

- (int)getFirstNumber
{
	return firstNumber;
}

- (int)getSecondNumber
{
	return secondNumber;
}

@end
