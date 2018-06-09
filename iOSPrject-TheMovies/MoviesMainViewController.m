//
//  FirstViewController.m
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/6/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import "MoviesMainViewController.h"

@interface MoviesMainViewController ()

@end

@implementation MoviesMainViewController {
    DatabaseManeger *databaseManeger;
    DownloadManeger *downloadManeger;
    int whichList;
    NSUserDefaults *defaults;
    UIRefreshControl *refreshControl;
    CGPoint popPosition;
    CGPoint topPostion;
}


static NSMutableArray *popularMoviesList;
static NSMutableArray *topRatedMoviesList;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    databaseManeger = [DatabaseManeger sharedInstance];
    databaseManeger.confirmationProtocol = self;
    
    [self checkDatabaseIsInitiated];
    
    downloadManeger = [[DownloadManeger alloc] init];
    downloadManeger.downloadMoviesProtocol = self;
    
    whichList = 0;
    
    defaults = [NSUserDefaults standardUserDefaults];
    
    [self setRefreshControl];
}

-(void)viewWillAppear:(BOOL)animated {
    [self prepareMoviesLists];
}

#pragma mark - Download & database Protocol callbacks

-(void)popularMoviesListIsDownloaded:(NSMutableArray *)moviesList {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    int pageNumber = [defaults integerForKey:@"popPageNumber"];
    if (pageNumber == 0) {
        popularMoviesList = moviesList;
    } else {
        [popularMoviesList addObjectsFromArray:moviesList];
    }
    [_collectionView reloadData];
    [defaults setInteger:++pageNumber forKey:@"popPageNumber"];
    [self saveDownLoadedListInDatabase:moviesList inList:0];
}

-(void)topRatedMoviesListIsDownloaded:(NSMutableArray *)moviesList {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    int pageNumber = [defaults integerForKey:@"topPageNumber"];
    if (pageNumber == 0) {
        topRatedMoviesList = moviesList;
    } else {
        [topRatedMoviesList addObjectsFromArray:moviesList];
    }
    [_collectionView reloadData];
    [defaults setInteger:++pageNumber forKey:@"topPageNumber"];
    [self saveDownLoadedListInDatabase:moviesList inList:1];
}

-(void)downloadManagerDidFail {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [self presentViewController:[Alerter getAlertControllerForMessege:@"Connection error!\nTry again later"] animated:YES completion:nil];
}

- (void)managerDidSave {
    [defaults setInteger:1 forKey:@"dbSavedFlag"];
}

- (void)databaseDidInitiate {
    [defaults setInteger:1 forKey:@"dbInitFlag"];
}

#pragma mark - CollectionView callbacks

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (whichList==0 && popularMoviesList) {
        return popularMoviesList.count;
    } else if (topRatedMoviesList) {
        return topRatedMoviesList.count;
    }
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    UIImageView *imageView = [cell viewWithTag:1];
    
    Movie *movie;
    if (whichList == 0) {
        if (indexPath.item <= popularMoviesList.count) {
            movie = [popularMoviesList objectAtIndex:indexPath.item];
        }
    } else {
        if (indexPath.item <= popularMoviesList.count) {
            movie = [topRatedMoviesList objectAtIndex:indexPath.item];
        }
    }
    if (movie) {
        NSURL *url = [NSURL URLWithString:movie.posterUrl];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"gray.jpg"]];
        
    }
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    int threshold;
    if (whichList == 0) {
        threshold = popularMoviesList.count -8;
    } else {
        threshold = topRatedMoviesList.count -8;
    }
    if (indexPath.item == threshold) {
//        NSLog(@"end");
        [self loadNextPage];
    }
}

# pragma mark - My custom controls actions

- (IBAction)sortControllerAction:(id)sender {
    
    if (_sortController.selectedSegmentIndex == 0) {
        whichList = 0;
        topPostion = _collectionView.contentOffset;
        _collectionView.contentOffset = popPosition;
    } else {
        popPosition = _collectionView.contentOffset;
        _collectionView.contentOffset = topPostion;
        whichList = 1;
    }
//    [_collectionView setContentOffset:CGPointZero animated:YES];
    [_collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"segueToDetail"]) {
        DetailViewController *controller = [segue destinationViewController];
        Movie *movie;
        if (whichList == 0) {
            movie = [popularMoviesList objectAtIndex:[_collectionView indexPathForCell:sender].item];
        } else {
            movie = [topRatedMoviesList objectAtIndex:[_collectionView indexPathForCell:sender].item];
        }
        
        controller.movie = movie;
    }
}

#pragma mark - Prepare list logic

- (void) checkDatabaseIsInitiated {
    if ([defaults integerForKey:@"dbInitFlag"]) {
        if ([defaults integerForKey:@"dbInitFlag"] == 0) {
            [databaseManeger initiateDatabase];
        }
    } else {
        [databaseManeger initiateDatabase];
    }
}

- (void) prepareMoviesLists {
    if (![defaults integerForKey:@"popPageNumber"]) {
        [defaults setInteger:0 forKey:@"popPageNumber"];
    }
    if (![defaults integerForKey:@"topPageNumber"]) {
        [defaults setInteger:0 forKey:@"topPageNumber"];
    }
    
    if ([defaults integerForKey:@"dbSavedFlag"]) {
        if ([defaults integerForKey:@"dbSavedFlag"] == 1) {
            popularMoviesList = [databaseManeger retreiveAllPopularMovies];
            topRatedMoviesList = [databaseManeger retreiveAllTopRatedMovies];
        } else {
            [downloadManeger downloadPopularMoviesListWithPage:[NSNumber numberWithInt:1]];
            [downloadManeger downloadTopRatedMoviesListWithPage:[NSNumber numberWithInt:1]];
            [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        }
    } else {
        [downloadManeger downloadPopularMoviesListWithPage:[NSNumber numberWithInt:1]];
        [downloadManeger downloadTopRatedMoviesListWithPage:[NSNumber numberWithInt:1]];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}

- (void) loadNextPage {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    int popPageNumber = [defaults integerForKey:@"popPageNumber"];
    int topPageNumber = [defaults integerForKey:@"topPageNumber"];
//    NSLog(@"%d %d", popPageNumber, topPageNumber);
    switch (whichList) {
        case 0:
            [downloadManeger downloadPopularMoviesListWithPage:[NSNumber numberWithInt:++popPageNumber]];
            break;
            
        case 1:
            [downloadManeger downloadTopRatedMoviesListWithPage:[NSNumber numberWithInt:++topPageNumber]];
            break;
    }
}

- (void) setRefreshControl {
    refreshControl = [UIRefreshControl new];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"Refreshing..."];
    refreshControl.tintColor = [UIColor blackColor];
    [refreshControl addTarget:self action:@selector(refreshMoviesData) forControlEvents:UIControlEventValueChanged];
    [_collectionView addSubview:refreshControl];
}

- (void) refreshMoviesData {
    switch (whichList) {
        case 0:
            for (Movie *movie in popularMoviesList) {
                if ([movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [databaseManeger deleteMovie:movie];
                }
            }
            [defaults setInteger:0 forKey:@"popPageNumber"];
            break;
            
        case 1:
            for (Movie *movie in topRatedMoviesList) {
                if ([movie.isFavourite isEqualToNumber:[NSNumber numberWithInt:0]]) {
                    [databaseManeger deleteMovie:movie];
                }
            }
            [defaults setInteger:0 forKey:@"topPageNumber"];
            break;
    }
    
    [defaults setInteger:0 forKey:@"dbSavedFlag"];
    [self prepareMoviesLists];
    [_collectionView reloadData];
    [refreshControl endRefreshing];
}

- (void) saveDownLoadedListInDatabase:(NSMutableArray *) list inList:(int) whichList{
    switch (whichList) {
        case 0:
            for (Movie *movie in list) {
                [databaseManeger insertMovie:movie inList:0];
            }
            break;
            
        case 1:
            for (Movie *movie in list) {
                [databaseManeger insertMovie:movie inList:1];
            }
            break;
    }
}
@end