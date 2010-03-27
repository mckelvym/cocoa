#import <Foundation/Foundation.h>
#import "LotteryEntry.h"

int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	int total = 10;
	NSCalendarDate * dateNow = [[NSCalendarDate alloc] init];
    NSMutableArray * array;
	array = [[NSMutableArray alloc] init];
	int i;
	
	srandom(time(NULL));
	
	
	for (i = 0; i < total; i++)
	{
		NSCalendarDate * iWeeksFromNow = [dateNow dateByAddingYears:0 months:0 days:(i*7) hours:0 minutes:0 seconds:0];
		LotteryEntry * entry = [[LotteryEntry alloc] init];
		[entry prepareRandomNumbers];
		[entry setEntryDate:iWeeksFromNow];
		[array addObject:entry];
	}
	
	for (LotteryEntry * entry in array)
	{
		NSLog(@"Entry: %@", entry);
	}
	
    NSLog(@"Hello, World!");
    [pool drain];
    return 0;
}
