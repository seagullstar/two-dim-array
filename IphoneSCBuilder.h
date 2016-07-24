//
//  IphoneSCBuilder.h
//  gfdb
//
//  Created by Yoshio Ono on 2014/07/06.
//  Copyright (c) 2014 miraikaizu. All rights reserved.
//

#import "Data.h"
#import "DataCollection.h"
#import "FMDatabase.h"
#import "IphoneGraphViewController.h"
#import "IphoneListViewController.h"
#import "XibTableViewCell.h"

#import "SKSTableView.h"
#import <UIKit/UIKit.h>

@interface IphoneSCBuilder : GAITrackedViewController <SKSTableViewDelegate>

@property(weak, nonatomic) IBOutlet SKSTableView *tableView;

@property(nonatomic, strong) NSString *svStr;
@property(nonatomic, strong) NSMutableArray *mData;
@property(nonatomic, strong) NSMutableArray *mData2;

@end
