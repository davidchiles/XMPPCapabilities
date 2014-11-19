//
//  StreamManager.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamManager : NSObject

- (void)connectWithJID:(NSString *)JID password:(NSString *)password;

@end
