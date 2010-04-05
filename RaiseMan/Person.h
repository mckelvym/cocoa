//
//  Person.h
//  RaiseMan
//
//  Created by mark mckelvy on 4/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
	NSString * personName;
	float expectedRaise;
}
@property (readwrite, copy) NSString * personName;
@property (readwrite) float expectedRaise;s

@end
