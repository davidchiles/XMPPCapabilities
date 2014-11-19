//
//  YapDatabaseObject.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "YapDatabaseObject.h"
#import "YapDatabase.h"

@interface YapDatabaseObject ()

@property (nonatomic, strong) NSString *uniqueId;

@end

@implementation YapDatabaseObject

- (id)init
{
    if (self = [super init])
    {
        self.uniqueId = [[NSUUID UUID] UUIDString];
    }
    return self;
}

- (instancetype)initWithUniqueId:(NSString *)uniqueId
{
    if (self = [super init]) {
        self.uniqueId = uniqueId;
    }
    return self;
}

- (void)saveWithTransaction:(YapDatabaseReadWriteTransaction *)transaction
{
    [transaction setObject:self forKey:self.uniqueId inCollection:[[self class] collection]];
}

- (void)removeWithTransaction:(YapDatabaseReadWriteTransaction *)transaction
{
    [transaction removeObjectForKey:self.uniqueId inCollection:[[self class] collection]];
}

#pragma - mark Class Methods

+ (NSString *)collection
{
    return NSStringFromClass([self class]);
}

+ (instancetype) fetchObjectWithUniqueID:(NSString *)uniqueID transaction:(YapDatabaseReadTransaction *)transaction {
    return [transaction objectForKey:uniqueID inCollection:[self collection]];
}



@end
