//
//  DataController.m
//  Sonicwarper
//
//  Created by Kevin Ng on 28/4/17.
//  Copyright © 2017 Sonicwarper. All rights reserved.
//

#import "DataController.h"

@implementation DataController

- (instancetype)initWithCompletionBlock:(void(^)(void))callback {
  self = [super init];
  if (self) {
    
    // This resource is the same name as your xcdatamodeld contained in the project
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Sonicwarper" withExtension:@"momd"];
    NSAssert(modelURL, @"Failed to locate momd bundle in application");
    
    // The managed object model for the application. It is a fatal error for the application not to
    // be able to find and load its model.
    NSManagedObjectModel *mom = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    NSAssert(mom, @"Failed to initialize mom from URL: %@", modelURL);
    
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc]
                                                 initWithManagedObjectModel:mom];
    
    NSManagedObjectContext *moc = [[NSManagedObjectContext alloc]
                                   initWithConcurrencyType:NSMainQueueConcurrencyType];
    
    [moc setPersistentStoreCoordinator:coordinator];
    self.context = moc;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
      
      NSPersistentStoreCoordinator *psc = [self.context persistentStoreCoordinator];
      NSFileManager *fileManager = [NSFileManager defaultManager];
      
      // The directory the application uses to store the Core Data store file. This code uses a
      // file names "Sonicwarper.sqlite" in the application's documents directory.
      NSURL *documentsURL = [[fileManager URLsForDirectory:NSDocumentDirectory
                                                 inDomains:NSUserDomainMask] lastObject];
      NSURL *storeURL = [documentsURL URLByAppendingPathComponent:@"Sonicwarper.sqlite"];
      
      NSError *error = nil;
      NSPersistentStore *store = [psc addPersistentStoreWithType:NSSQLiteStoreType
                                                   configuration:nil
                                                             URL:storeURL
                                                         options:nil
                                                           error:&error];
      if (!store) {
        NSLog(@"Failed to initialize persistent store: %@\n%@",
              [error localizedDescription], [error userInfo]);
        abort();
      }
      
      if (callback) {
        
        // The callback block is expected to complete the user interface and therefore should be
        // presented back on the main queue so that the user interface does not need to be
        // concerned with which queue this call is coming from.
        dispatch_sync(dispatch_get_main_queue(), ^{
          callback();
        });
      }
    });
  }
  return self;
}

@end
