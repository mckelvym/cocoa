//
//  EmployeeController.m
//  Departments
//
//  Created by mark mckelvy on 5/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EmployeeController.h"


@implementation EmployeeController

- (id)init
{
	if (![super initWithNibName:@"EmployeeView" bundle:nil])
	{
		return nil;
	}
	
	[self setTitle:@"Employees"];
	return self;
}

@end
