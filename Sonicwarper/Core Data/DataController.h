//
//  DataController.h
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface DataController : NSObject

@property (nonatomic, strong) NSManagedObjectContext *context;

// Designated initializer.
- (instancetype)initWithCompletionBlock:(void(^)(void))callback;

@end
