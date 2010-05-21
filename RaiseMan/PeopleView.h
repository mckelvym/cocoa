//
//  PeopleView.h
//  RaiseMan
//
//  Created by mark mckelvy on 5/20/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PeopleView : NSView {
	NSArray * people;
	NSMutableDictionary * attributes;
	float lineHeight;
	NSRect pageRect;
	int linesPerPage;
	int currentPage;
}

- (id)initWithPeople:(NSArray *)array;

@end
