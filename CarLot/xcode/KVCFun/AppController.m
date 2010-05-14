//
//  AppController.m
//  KVCFun
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController
@synthesize fido;

- (id)init
{
	if (![super init])
		return nil;
	
	[self setValue:[NSNumber numberWithInt:2] forKey:@"fido"];
	NSNumber *n = [self valueForKey:@"fido"]; 
	// mn = [selectedPerson valueForKeyPath:@"spouse.scooter.modelName"];
	// theAverage = [employees valueForKeyPath:@"@avg.expectedRaise"];
	
	// Common operators:
	// @avg @count @max @min @sum
	
	// Example binding of a textfield:
	//[textField bind:@"value" toObject:employeeController
	//	withKeyPath:@"arrangedObjects.@avg.expectedRaise" options:nil];
	
	NSLog(@"fido = %@", n);
	return self;
}

- (void)awakeFromNib
{
	// observe fido
	//[theAppController addObserver:self forKeyPath:@"fido"
	//					  options:NSKeyValueObservingOld context:somePointer];
}

- (IBAction)incrementFido:(id)sender
{ 
	[self willChangeValueForKey:@"fido"];
	fido++; 
	NSLog(@"fido is now %d", fido);
	[self didChangeValueForKey:@"fido"];
}

- (IBAction)incrementFido2:(id)sender
{ 
	NSNumber * num = [self valueForKey:@"fido"];
	NSNumber * numInc = [NSNumber numberWithInt:[num intValue] + 1];
	[self setValue:numInc forKey:@"fido"];
}

- (IBAction)incrementFido3:(id)sender
{ 
	[self setFido:[self fido] + 1];
}

@end
