//
//  PFMapAllViewController.h
//  P2Coffee
//
//  Created by Pariwat on 6/16/14.
//  Copyright (c) 2014 Platwo fusion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PFMapView.h"
#import "CMMapLauncher.h"

@protocol PFMapAllViewControllerDelegate <NSObject>

- (void) PFMapAllViewControllerBack;

@end

@interface PFMapAllViewController : UIViewController <CLLocationManagerDelegate,MKMapViewDelegate>

@property (assign, nonatomic) id delegate;

@end
