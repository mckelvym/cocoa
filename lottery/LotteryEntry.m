//
//  LotteryEntry.m
//  lottery
//
//  Created by mark mckelvy on 3/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LotteryEntry.h"


@implementation LotteryEntry

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

- (NSString *)description
{
	NSString * description = [[NSString alloc] initWithFormat:@"%@: %d, %d", 
							  [entryDate descriptionWithCalendarFormat:@"%b %d %Y"],
							  firstNumber, 
							  secondNumber];
	return description;
}

- (id)init
{
	if (![super init])
		return nil;
	[self prepareRandomNumbers];
	return self;
}

@end
