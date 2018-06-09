//
//  Alerter.h
//  iOSPrject-TheMovies
//
//  Created by Omar Bdreldin on 5/11/18.
//  Copyright © 2018 Omar Bdreldin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Alerter : NSObject

+ (UIAlertController *) getAlertControllerForMessege: (NSString *) messege;

@end
