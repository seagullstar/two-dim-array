//
//  IphoneSCBuilder.m
//  gfdb
//
//  Created by Yoshio Ono on 2014/07/06.
//  Copyright (c) 2014 miraikaizu. All rights reserved.
//

#import "IphoneSCBuilder.h"

#import "SKSTableView.h"
#import "SKSTableViewCell.h"

@interface IphoneSCBuilder ()

@property(nonatomic, strong) NSArray *contents;

@end

@implementation IphoneSCBuilder
@synthesize mData;

#pragma mark -
- (BOOL)prefersStatusBarHidden {
  return YES;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (NSArray *)contents {
  if (!_contents) {
    _contents = @[
      @[
        @[ @"呉海軍工廠", @"扶桑", @"長門" ],
        @[ @"横須賀海軍工廠", @"比叡", @"山城", @"陸奥", @"飛龍", @"翔鶴", @"信濃" ],
        @[ @"佐世保海軍工廠", @"龍田", @"球磨" ],
      ]
    ];
  }

  // 二次元配列の作り方（上記と同じ）
  //  NSArray *ar = [NSArray arrayWithObjects:[NSArray arrayWithObjects:[NSArray arrayWithObjects:@"呉海軍工廠", @"扶桑", @"長門", nil],
  //                                                                    [NSArray arrayWithObjects:@"横須賀海軍工廠", @"比叡", @"山城", @"陸奥",
  //                                                                                              @"飛龍", @"翔鶴", @"信濃", nil],
  //                                                                    [NSArray arrayWithObjects:@"佐世保海軍工廠", @"龍田", @"球磨", nil], nil],
  //                                          nil];
  //  NSLog(@"1. = %@", ar);
  //  int num[] = {[ar[0][0] intValue], [ar[1][2] intValue]}; //オブジェクト型をint型に変換する
  //  NSLog(@"%@ %d %d", ar[2][2], num[0], num[1]);

  return _contents;
}

#pragma mark - Managing the View
- (void)viewDidLoad {
  [super viewDidLoad];

  // 重要な一文
  self.tableView.SKSTableViewDelegate = self;

  NSString *sql = @"select * from gfsub130 where d2 ='建艦地'";
  mData = [DataCollection getDataCollection:sql saveStrings:self.svStr];

  //  NSArray *ar3 = [[NSArray alloc] initWithObjects:@"ID", @"NAME", @"PRICE", nil];
  //
  //  NSMutableArray *ar2 = [[NSMutableArray alloc] init];
  //  for (int i = 0; i < 5; i++) {
  //    [ar2 addObject:ar3];
  //  }
  //
  //  for (NSArray *ar3 in ar2) {
  //    NSLog(@"************");
  //    for (int i = 0; i < [ar3 count]; i++) {
  //      NSLog(@"%@", [ar3 objectAtIndex:i]);
  //    }
  //  }
}

// 二次元配列用意
//- (NSArray *)contents {
//  if (!_contents) {
//    _contents = @[
//      @[
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//        mData,
//      ]
//    ];
//  }
//  return _contents;
//}

#pragma mark - Responding to View Events
- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];
  [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];
  [self.tableView flashScrollIndicators];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.contents count];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // return [mData count]; // 仮データの方を必要な分だけ記述しておけば、このまま使用可能
  return 3;
  // return [self.contents[section] count];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//  XibTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scbuilderCell" forIndexPath:indexPath];
//  Data *data = [mData objectAtIndex:indexPath.row];
//  cell.scbadge.image = [UIImage imageNamed:[data.shipyardbadge objectForKey:data.d3]];
//  cell.scsub.text = data.d5;
//  cell.scmain.text = data.d4;
//  cell.scnumber.text = data.d6;
//  return cell;
//}

// SKSTableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"SKSTableViewCell";
  SKSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (!cell)
    cell = [[SKSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

  Data *data = [mData objectAtIndex:indexPath.row];
  cell.textLabel.text = data.d5;

  // cell.textLabel.text = self.contents[indexPath.section][indexPath.row][0];
  //  if ((indexPath.section == 0 && (indexPath.row == 1 || indexPath.row == 0)) || (indexPath.section == 1 && (indexPath.row == 0 || indexPath.row == 2)))
  //    cell.expandable = YES;
  //  else
  //    cell.expandable = NO;
  cell.expandable = YES;
  return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(SKSTableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if ([[UIScreen mainScreen] bounds].size.height == 480) {
    return 68.2;
  } else if ([[UIScreen mainScreen] bounds].size.height == 568) {
    return 72;
  } else if ([[UIScreen mainScreen] bounds].size.height == 667) {
    return 66.3;
  } else {
    return 72;
  }
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//  Data *data = [mData objectAtIndex:indexPath.row];
//  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"IphoneListView" bundle:nil];
//  IphoneListViewController *listViewController = [storyboard instantiateViewControllerWithIdentifier:@"iphoneListView"];
//  listViewController.svStr = data.d3;
//  listViewController.title = data.d4;
//  listViewController.saveAddress = data.d10;
//  listViewController.saveDescription = data.d11;
//  [self.navigationController pushViewController:listViewController animated:YES];
//
//  NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
//
//  [[[GAI sharedInstance] defaultTracker]
//      send:[[GAIDictionaryBuilder createEventWithCategory:@"RootBuilder >>> ListView(iPhone)" action:@"ListDisplay(iPhone)" label:nil value:nil] build]];
//}

// SKSTableView
#pragma mark - UITableViewDataSource
// SKSTableView  // count numberOfSubRows
- (NSInteger)tableView:(SKSTableView *)tableView numberOfSubRowsAtIndexPath:(NSIndexPath *)indexPath {
  return [self.contents[indexPath.section][indexPath.row] count] - 1;
}

// SKSTableView  //
- (BOOL)tableView:(SKSTableView *)tableView shouldExpandSubRowsOfCellAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.section == 1 && indexPath.row == 0) {
    return YES;
  }
  return NO;
}

// SKSTableView
- (UITableViewCell *)tableView:(UITableView *)tableView cellForSubRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"UITableViewCell";

  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

  if (!cell)
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

  cell.textLabel.text = [NSString stringWithFormat:@"%@", self.contents[indexPath.section][indexPath.row][indexPath.subRow]];
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  return cell;
}

// SKSTableView
//- (void)tableView:(SKSTableView *)tableView didSelectSubRowAtIndexPath:(NSIndexPath *)indexPath {
//  NSLog(@"Section: %ld, Row:%ld, Subrow:%ld", (long)indexPath.section, (long)indexPath.row, (long)indexPath.subRow);
//}

@end
