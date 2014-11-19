//
//  Account.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic, strong, readonly) NSString *JID;
@property (nonatomic, strong, readonly) NSString *password;

+ (instancetype)accountWithJID:(NSString *)JID password:(NSString *)password;

+ (NSArray *)testAccounts;

@end
