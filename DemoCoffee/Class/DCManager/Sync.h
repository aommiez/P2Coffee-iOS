//
//  Sync.h
//  DemoCoffee
//
//  Created by MRG on 7/3/2557 BE.
//  Copyright (c) 2557 Platwo fusion. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Sync : NSManagedObject

@property (nonatomic, retain) NSString * folder;
@property (nonatomic, retain) NSString * product;

@end
