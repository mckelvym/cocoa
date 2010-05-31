//
//  Department.h
//  Departments
//
//  Created by mark mckelvy on 5/31/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>

@class Employee;

@interface Department :  NSManagedObject  
{
}

@property (nonatomic, retain) NSString * deptName;
@property (nonatomic, retain) NSSet* employees;
@property (nonatomic, retain) NSManagedObject * manager;

@end


@interface Department (CoreDataGeneratedAccessors)
- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)value;
- (void)removeEmployees:(NSSet *)value;

@end

