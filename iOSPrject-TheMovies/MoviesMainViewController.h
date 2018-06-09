//
//  FirstViewController.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManeger.h"
#import "DownloadManeger.h"
#import "DownloadMoviesCallBackProtocol.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DetailViewController.h"
#import "DatabaseConfirmationProtocol.h"
#import "Alerter.h"

@interface MoviesMainViewController : UIViewController <DownloadMoviesCallBackProtocol, UICollectionViewDataSource, UICollectionViewDelegate, DatabaseConfirmationProtocol>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
- (IBAction)sortControllerAction:(id)sender;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sortController;

@end

