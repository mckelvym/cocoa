//
//  AppController.m
//  CountCharacters
//
//  Created by mark mckelvy on 3/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"


@implementation AppController

- (IBAction)countChars:(id)sender
{
	[label setStringValue:[NSString stringWithFormat:@"%i", [[textField stringValue] length]]];
}
@end
