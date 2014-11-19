//
//  Account.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "Account.h"

@implementation Account

- (instancetype)initWithJID:(NSString *)JID password:(NSString *)password
{
    if (self = [self init]) {
        _JID = JID;
        _password = password;
    }
    return self;
}


+ (instancetype)accountWithJID:(NSString *)JID password:(NSString *)password
{
    return [[self alloc] initWithJID:JID password:password];
}

+ (NSArray *)testAccounts
{
    return @[[self accountWithJID:@"test@test.com" password:@"password"]];
}

@end
