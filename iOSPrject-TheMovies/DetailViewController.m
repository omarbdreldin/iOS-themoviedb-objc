//
//  DetailViewController.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/7/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "DetailViewController.h"
#import "DatabaseManeger.h"
#import "DownloadManeger.h"

@interface DetailViewController ()

@end

@implementation DetailViewController {
    DatabaseManeger *databaseManeger;
    DownloadManeger *downloadManeger;
    NSMutableArray *reviewsList;
    NSMutableArray *videosList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    databaseManeger = [DatabaseManeger sharedInstance];
    
    downloadManeger = [[DownloadManeger alloc] init];
    downloadManeger.downloadVideosProtocol = self;
    downloadManeger.downloadReviewsProtocol = self;
    
    [self setDetailViewForMovie];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
//    databaseManeger.confirmationProtocol = self;
}

- (void) setDetailViewForMovie{
    if (_movie) {
        _titleLabel.text = _movie.title;
        NSURL *url = [NSURL URLWithString:_movie.posterUrl];
        [_posterImageView sd_setImageWithURL:url];
        _releaseLabel.text = [NSString stringWithFormat:@"%@", _movie.releaseYear];
        _voteAverageLabel.text = [NSString stringWithFormat:@"%.1f/10", [_movie.voteAverage floatValue]];
        _overviewTextView.text = _movie.overview;
        [_favouriteButton setSelected:([_movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:0]] ? NO : YES)];
//        NSLog(@"%@", _movie.isFavourite);
    }
    
    [downloadManeger downloadReviewsForMovie:_movie];
    [downloadManeger getVideosUrlsForMovie:_movie];
}

#pragma mark - Download protocols Conformation

-(void)videosListIsDownLoaded:(NSMutableArray *)list {
    videosList = list;
}

-(void)reviewsListIsDownLoaded:(NSMutableArray *)list {
    reviewsList = list;
}

#pragma mark - Other controls

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToVideos"]) {
        VideosCollectionViewController *controller = [segue destinationViewController];
        controller.videosList = videosList;
    } else if ([[segue identifier] isEqualToString:@"segueToReviews"]) {
        ReviewsTableViewController *controller = [segue destinationViewController];
        controller.reviewsList = reviewsList;
    }
}

-(BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ([identifier isEqualToString:@"segueToVideos"] && videosList) {
        return YES;
    } else if ([identifier isEqualToString:@"segueToReviews"] && reviewsList) {
        return YES;
    }
    return NO;
}

- (IBAction)favouriteButtonAction:(id)sender {
    FavouriteButton *button = sender;
    
    if ([_movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:1]]) {
        // Remove from favourites
        _movie.isFavourite = [NSNumber numberWithInt:0];
    } else {
        // Set in favourites
        _movie.isFavourite = [NSNumber numberWithInt:1];
    }

//    NSLog(@"%@", _movie.isFavourite);
    [databaseManeger setMovieAsFavourite:_movie];
    [button setSelected:!button.isSelected];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end
