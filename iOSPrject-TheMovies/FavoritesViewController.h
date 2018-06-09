//
//  SecondViewController.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManeger.h"
#import "DatabaseConfirmationProtocol.h"
#import "Movie.h"
#import "FavouriteButton.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface FavoritesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DatabaseConfirmationProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

