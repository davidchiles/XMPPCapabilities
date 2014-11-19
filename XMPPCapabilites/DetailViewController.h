//
//  DetailViewController.h
//  XMPPCapabilites
//
//  Created by David Chiles on 11/18/14.
//  Copyright (c) 2014 David Chiles. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XMPPServer;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) XMPPServer *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

