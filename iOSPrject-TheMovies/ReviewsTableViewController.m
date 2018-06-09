//
//  ReviewsTableViewController.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "ReviewsTableViewController.h"

@implementation ReviewsTableViewController\

-(void)viewDidLoad {
    [super viewDidLoad];
    
//    self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
//    self.tableView.separatorInset = UIEdgeInsetsMake(8, 8, 8, 8);
//    self.tableView.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 8);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _reviewsList.count;
}

//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [cell setSeparatorInset:UIEdgeInsetsZero];
//    [cell setPreservesSuperviewLayoutMargins:NO];
//    [cell setLayoutMargins:UIEdgeInsetsZero];
//}

//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//    [self.tableView setCellLayoutMarginsFollowReadableWidth:NO];
//}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
//    [cell setPreservesSuperviewLayoutMargins:NO];
//    [cell setSeparatorInset:UIEdgeInsetsMake(8, 8, 8, 8)];
//    [cell setLayoutMargins:UIEdgeInsetsMake(8, 8, 8, 8)];
    
    Review *review = [_reviewsList objectAtIndex:indexPath.row];
    
    UILabel *label = [cell viewWithTag:1];
    label.text = review.author;
    
    UITextView *textView = [cell viewWithTag:2];
    textView.text = review.content;
    
    return cell;
}

@end
