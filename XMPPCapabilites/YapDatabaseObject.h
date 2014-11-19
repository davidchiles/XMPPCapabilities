//
//  YapDatabaseObject.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "MTLModel+NSCoding.h"

@class  YapDatabaseReadTransaction, YapDatabaseReadWriteTransaction;

@interface YapDatabaseObject : MTLModel

@property (nonatomic, readonly) NSString *uniqueId;

- (instancetype)initWithUniqueId:(NSString *)uniqueId;

- (void)saveWithTransaction:(YapDatabaseReadWriteTransaction *)transaction;
- (void)removeWithTransaction:(YapDatabaseReadWriteTransaction *)transaction;

+ (NSString *)collection;

+ (instancetype)fetchObjectWithUniqueID:(NSString*)uniqueID transaction:(YapDatabaseReadTransaction*)transaction;

@end
