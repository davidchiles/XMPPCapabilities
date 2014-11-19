//
//  XMPPCapability.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/19/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "YapDatabaseObject.h"

@interface XMPPCapability : YapDatabaseObject

@property (nonatomic, strong) NSString *serverDomain;
@property (nonatomic, strong) NSString *featureName;
@property (nonatomic, strong) NSString *XEP;

@end
