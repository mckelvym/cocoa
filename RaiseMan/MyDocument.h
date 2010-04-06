//
//  MyDocument.h
//  RaiseMan
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright __MyCompanyName__ 2010 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Person;

@interface MyDocument : NSDocument
{
	NSMutableArray * employees;
}

- (void)setEmployees:(NSMutableArray *)a;
- (void)insertObject:(Person *)p inEmployeesAtIndex:(int)index;
- (void)removeObjectFromEmployeesAtIndex:(int)index;

@end
