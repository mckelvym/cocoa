//
//  Forwarder.m
//  forwarding
//
//  Created by mark mckelvy on 3/28/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Forwarder.h"


@implementation Forwarder

- (id) forward:(SEL)sel:(marg_list)args
{
    /*
     * Check whether the recipient actually responds to the message. 
     * This may or may not be desirable, for example, if a recipient
     * in turn does not respond to the message, it might do forwarding
     * itself.
     */
    if([recipient respondsTo:sel]) 
		return [recipient performv: sel : args];
    else
		return [self error:"Recipient does not respond"];
}

- (id) setRecipient: (id) _recipient
{
    recipient = _recipient;
    return self;
}

- (id) recipient
{
    return recipient;
}

@end
