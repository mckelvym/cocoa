//
//  Employee.h
//  Departments
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface Employee :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * firstName;
@property (readonly) NSString * fullName;
@property (nonatomic, retain) NSManagedObject * department;

@end



