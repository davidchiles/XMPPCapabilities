//
//  XMPPStreamDelegate.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"


@interface XMPPStreamDelegate : XMPPModule <XMPPStreamDelegate>

@property (nonatomic, strong) NSString *password;

@end
