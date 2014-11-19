//
//  DetailViewController.m
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import "DetailViewController.h"
#import "YapDatabaseView.h"
#import "YapDatabase.h"
#import "AppDelegate.h"
#import "DatabaseView.h"
#import "DatabaseManager.h"
#import "XMPPServer.h"
#import "XMPPCapability.h"
#import "PureLayout.h"

@interface DetailViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) YapDatabaseConnection *databaseConnection;
@property (nonatomic, strong) YapDatabaseViewMappings *mappings;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(XMPPServer *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    
    
    [self.databaseConnection beginLongLivedReadTransaction];
    
    NSArray *groups = @[];
    if (self.detailItem) {
        self.title = self.detailItem.uniqueId;
        groups = @[self.detailItem.uniqueId];
    }
    else {
        self.title = @"Capabilities";
    }
    
    self.mappings = [[YapDatabaseViewMappings alloc] initWithGroups:groups
                                                               view:kDatabaseviewXMPPCapabilities];
    
    [self.databaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        [self.mappings updateWithTransaction:transaction];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(yapDatabaseModified:)
                                                 name:YapDatabaseModifiedNotification
                                               object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.databaseConnection = [[AppDelegate sharedInstance].databaseManager newConnection];
    self.databaseConnection.name = NSStringFromClass([self class]);

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView autoPinEdgesToSuperviewMarginsExcludingEdge:ALEdgeTop];
    [self.tableView autoPinToTopLayoutGuideOfViewController:self withInset:0];
    
    [self configureView];
}

#pragma - mark Helper Methods

- (XMPPCapability *)capabilityForIndexPath:(NSIndexPath *)indexPath
{
    __block XMPPCapability *capability = nil;
    [self.databaseConnection readWithBlock:^(YapDatabaseReadTransaction *transaction) {
        capability = [[transaction ext:kDatabaseviewXMPPCapabilities] objectAtIndexPath:indexPath withMappings:self.mappings];
    }];
    return capability;
}

#pragma - mark UITableViewDataSource Methods

////// Required //////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.mappings numberOfItemsInSection:section];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self capabilityForIndexPath:indexPath].featureName;
    
    cell.userInteractionEnabled = NO;
    return cell;
}

////// Optional //////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.mappings numberOfSections];
}


#pragma - mark UITableViewDelegate Methods

#pragma - mark YapDatabase Methods

- (void)yapDatabaseModified:(NSNotification *)notification
{
    NSArray *notifications = [self.databaseConnection beginLongLivedReadTransaction];
    
    NSArray *sectionChanges = nil;
    NSArray *rowChanges = nil;
    
    [[self.databaseConnection ext:kDatabaseViewXMPPServer] getSectionChanges:&sectionChanges
                                                                  rowChanges:&rowChanges
                                                            forNotifications:notifications
                                                                withMappings:self.mappings];
    
    if ([sectionChanges count] == 0 && [rowChanges count] == 0)
    {
        // Nothing has changed that affects our tableView
        return;
    }
    
    [self.tableView beginUpdates];
    
    for (YapDatabaseViewSectionChange *sectionChange in sectionChanges)
    {
        switch (sectionChange.type)
        {
            case YapDatabaseViewChangeDelete :
            {
                [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionChange.index]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeInsert :
            {
                [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionChange.index]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeUpdate:
            case YapDatabaseViewChangeMove:
                break;
        }
    }
    
    for (YapDatabaseViewRowChange *rowChange in rowChanges)
    {
        switch (rowChange.type)
        {
            case YapDatabaseViewChangeDelete :
            {
                [self.tableView deleteRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeInsert :
            {
                [self.tableView insertRowsAtIndexPaths:@[ rowChange.newIndexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeMove :
            {
                [self.tableView deleteRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView insertRowsAtIndexPaths:@[ rowChange.newIndexPath ]
                                      withRowAnimation:UITableViewRowAnimationAutomatic];
                break;
            }
            case YapDatabaseViewChangeUpdate :
            {
                [self.tableView reloadRowsAtIndexPaths:@[ rowChange.indexPath ]
                                      withRowAnimation:UITableViewRowAnimationNone];
                break;
            }
        }
    }
    
    [self.tableView endUpdates];
}

@end
