//
//  LotteryEntry.h
//  lottery
//
//  Created by mark mckelvy on 3/27/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface LotteryEntry : NSObject {
	NSCalendarDate * entryDate;
	int firstNumber;
	int secondNumber;
}
/**
 * Designated initializer.
 */
- (id)initWithEntryDate:(NSCalendarDate *)date;
- (void)prepareRandomNumbers;
- (void)setEntryDate:(NSCalendarDate *)date;
- (NSCalendarDate *)getEntryDate;
- (int)getFirstNumber;
- (int)getSecondNumber;

@end
