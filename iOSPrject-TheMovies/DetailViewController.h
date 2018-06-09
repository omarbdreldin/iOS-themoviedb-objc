//
//  DetailViewController.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "DownloadVideosCallBackProtocol.h"
#import "DownloadReviewsCallBackProtocol.h"
#import "Review.h"
#import "VideosCollectionViewController.h"
#import "ReviewsTableViewController.h"
#import "FavouriteButton.h"
#import "DatabaseConfirmationProtocol.h"

@interface DetailViewController : UIViewController <DownloadVideosCallBackProtocol, DownloadReviewsCallBackProtocol, DatabaseConfirmationProtocol>

@property Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterImageView;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteAverageLabel;
@property (weak, nonatomic) IBOutlet UITextView *overviewTextView;
@property (weak, nonatomic) IBOutlet FavouriteButton *favouriteButton;
- (IBAction)favouriteButtonAction:(id)sender;

@end
