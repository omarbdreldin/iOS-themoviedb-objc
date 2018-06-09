//
//  DatabaseConfirmationProtocol.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/8/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DatabaseConfirmationProtocol <NSObject>

@optional
- (void) databaseDidInitiate;
- (void) databaseDidNotInitiate;
- (void) managerDidSave;
- (void) managerDidNotSave;
- (void) managerDidDelete;
- (void) managerDidNotDelete;
- (void) managerDidUpdate;
- (void) managerDidNotUpdate;

@end
