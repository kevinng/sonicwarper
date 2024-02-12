//
//  Mappings.m
//  
//
//  Created by Kevin Ng on 5/12/17.
//

@import CoreData;
#import "Mappings.h"
#import "AppDelegate.h"
#import "BowswitchView.h"
#import "Groot.h"
#import "ViewController.h"
#import "FMDatabase.h"

@implementation Mappings

#pragma mark - Singleton initializers

+ (Mappings *)shared {
  static Mappings *shared = nil;
  if (!shared) {
    shared = [[self alloc] initPrivate];
  }
  return shared;
}

- (instancetype)init {
  @throw [NSException exceptionWithName:@"Singleton"
                                 reason:@"Use + [Mappings shared]"
                               userInfo:nil];
}

- (instancetype)initPrivate {
  self = [super init];
  if (self) {
    
  }
  return self;
}

- (NSInteger)currentPage {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  // Will return 0 if currentPage is not set in defaults.
  return [defaults integerForKey:@"currentPage"];
}

- (void)setCurrentPage:(NSInteger)currentPage {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setInteger:currentPage forKey:@"currentPage"];
}

- (void)overrideWithSampleMappingOnPage:(NSInteger)page {
  
  if (page == -1) {
    NSLog(@"Page number must be equal -1. -1 is reserved for sample mapping preset.");
    return;
  }
  
  NSLog(@"Override with sample mapping on page %ld...", (long)page);
  
  // Delete all mappings currently belonging to the page.
  
  NSLog(@"\tDeleting behaviors for page %ld...", page);
  
  DataController *dataController = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = dataController.context;
  
  NSFetchRequest *getBehs = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  [getBehs setPredicate:[NSPredicate predicateWithFormat:@"page == %ld", (long)page]];
  NSArray *behResults = [context executeFetchRequest:getBehs error:nil];
  for (NSManagedObject *beh in behResults) {
    [context deleteObject:beh];
  }
  NSLog(@"\tDeleted %ld behaviors for page %ld..", behResults.count, (long)page);
  
  NSLog(@"\tCopying sample mapping behaviors to page %ld", (long)page);
  
  NSFetchRequest *getSampBehs = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  [getSampBehs setPredicate:[NSPredicate predicateWithFormat:@"page == -1"]];
  NSArray *sampBehResults = [context executeFetchRequest:getSampBehs error:nil];
  for (NSManagedObject *samp in sampBehResults) {
    NSManagedObject *beh = [NSEntityDescription
                            insertNewObjectForEntityForName:@"Behavior"
                            inManagedObjectContext:context];
    [beh setValue:[samp valueForKey:@"bowswitch"] forKey:@"bowswitch"];
    [beh setValue:[samp valueForKey:@"button"] forKey:@"button"];
    [beh setValue:[samp valueForKey:@"continueFromLastCC"] forKey:@"continueFromLastCC"];
    [beh setValue:[samp valueForKey:@"midiCCControllerNo"] forKey:@"midiCCControllerNo"];
    [beh setValue:[samp valueForKey:@"midiCCValue"] forKey:@"midiCCValue"];
    [beh setValue:[samp valueForKey:@"midiChannel"] forKey:@"midiChannel"];
    [beh setValue:[samp valueForKey:@"midiNote"] forKey:@"midiNote"];
    [beh setValue:[samp valueForKey:@"midiNoteIsOn"] forKey:@"midiNoteIsOn"];
    [beh setValue:[samp valueForKey:@"midiType"] forKey:@"midiType"];
    [beh setValue:[samp valueForKey:@"midiVelocity"] forKey:@"midiVelocity"];
    [beh setValue:[samp valueForKey:@"motionReverse"] forKey:@"motionReverse"];
    [beh setValue:[samp valueForKey:@"motionStartCCValue"] forKey:@"motionStartCCValue"];
    [beh setValue:[samp valueForKey:@"motionType"] forKey:@"motionType"];
    [beh setValue:[samp valueForKey:@"type"] forKey:@"type"];
    [beh setValue:[samp valueForKey:@"behaviorDescription"] forKey:@"behaviorDescription"];
    [beh setValue:[NSString stringWithFormat:@"%F", [[NSDate new] timeIntervalSince1970]] forKey:@"createdTimestamp"];
    [beh setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
  }
  NSLog(@"\tCopied %ld behaviors for page %ld..", sampBehResults.count, (long)page);
  
  NSFetchRequest *getSampLooks = [NSFetchRequest fetchRequestWithEntityName:@"Look"];
  [getSampLooks setPredicate:[NSPredicate predicateWithFormat:@"page == -1"]];
  NSArray *sampLookResults = [context executeFetchRequest:getSampLooks error:nil];
  for (NSManagedObject *samp in sampLookResults) {
    NSManagedObject *look = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Look"
                             inManagedObjectContext:context];
    [look setValue:[samp valueForKey:@"bowswitch"] forKey:@"bowswitch"];
    [look setValue:[samp valueForKey:@"button"] forKey:@"button"];
    [look setValue:[samp valueForKey:@"color"] forKey:@"color"];
    [look setValue:[samp valueForKey:@"mainLabel"] forKey:@"mainLabel"];
    [look setValue:[samp valueForKey:@"smallLabel"] forKey:@"smallLabel"];
    [look setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
  }
  
  // Save context.
  NSError *error = nil;
  if ([context save:&error] == NO) {
    NSAssert(NO, @"\t\t\tError saving context: %@\n%@",
             [error localizedDescription],
             [error userInfo]);
  }
}

- (void)readAndSetSampleMapping {
  
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  BOOL firstTimeLoading = [defaults boolForKey:@"firstTimeLoading"];
  if (!firstTimeLoading) {
    NSLog(@"First time loading the app - reading sample mapping into Core Data...");
    [defaults setBool:true forKey:@"firstTimeLoading"];
  } else {
    NSLog(@"Not first time loading the app. Not reading sample mapping into Core Data.");
    return;
  }
  
  NSLog(@"Reading sample mapping into Core Data...");
  
  // Form the URL to the SQLite database file.
  NSURL *mbUrl = [[NSBundle mainBundle] resourceURL];
  NSURL *sqliteUrl = [mbUrl URLByAppendingPathComponent:@"Sample Mapping/Sonicwarper.sqlite"];
  FMDatabase *sqliteDb = [FMDatabase databaseWithURL:sqliteUrl];
  
  if(![sqliteDb open]) {
    NSLog(@"Failed to open sample database at URL:\n\t%@", sqliteUrl);
    return;
  }
  
  NSLog(@"\tCopying behaviors...");
  
  NSString *selBehs = @"SELECT * from ZBEHAVIOR";
  FMResultSet *behSet = [sqliteDb executeQuery:selBehs];

  DataController *controller = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).dataController;
  NSManagedObjectContext *context = controller.context;
  
  // Page number for the sample mapping is -1.
  NSInteger page = -1;
  
  int behCopied = 0;
  while ([behSet next]) {
    // Get row values.
    int bowswitch = [behSet intForColumn:@"ZBOWSWITCH"];
    int button = [behSet intForColumn:@"ZBUTTON"];
    BOOL continueFromLastCC = [behSet boolForColumn:@"ZCONTINUEFROMLASTCC"];
    int midiCCControllerNo = [behSet intForColumn:@"ZMIDICCCONTROLLERNO"];
    int midiCCValue = [behSet intForColumn:@"ZMIDICCVALUE"];
    int midiChannel = [behSet intForColumn:@"ZMIDICHANNEL"];
    int midiNote = [behSet intForColumn:@"ZMIDINOTE"];
    BOOL midiNoteIsOn = [behSet boolForColumn:@"ZMIDINOTEISON"];
    int midiType = [behSet intForColumn:@"ZMIDITYPE"];
    int midiVelocity = [behSet intForColumn:@"ZMIDIVELOCITY"];
    BOOL motionReverse = [behSet boolForColumn:@"ZMOTIONREVERSE"];
    int motionStartCCValue = [behSet intForColumn:@"ZMOTIONSTARTCCVALUE"];
    int motionType = [behSet intForColumn:@"ZMOTIONTYPE"];
    int type = [behSet intForColumn:@"ZTYPE"];
    NSString *behaviorDescription = [behSet stringForColumn:@"ZBEHAVIORDESCRIPTION"];
    NSString *createdTimestamp = [behSet stringForColumn:@"ZCREATEDTIMESTAMP"];
    
    NSManagedObject *behavior = [NSEntityDescription
                                 insertNewObjectForEntityForName:@"Behavior"
                                 inManagedObjectContext:context];
    [behavior setValue:[NSNumber numberWithInt:bowswitch] forKey:@"bowswitch"];
    [behavior setValue:[NSNumber numberWithInt:button] forKey:@"button"];
    [behavior setValue:[NSNumber numberWithBool:continueFromLastCC] forKey:@"continueFromLastCC"];
    [behavior setValue:[NSNumber numberWithInt:midiCCControllerNo] forKey:@"midiCCControllerNo"];
    [behavior setValue:[NSNumber numberWithInt:midiCCValue] forKey:@"midiCCValue"];
    [behavior setValue:[NSNumber numberWithInt:midiChannel] forKey:@"midiChannel"];
    [behavior setValue:[NSNumber numberWithInt:midiNote] forKey:@"midiNote"];
    [behavior setValue:[NSNumber numberWithBool:midiNoteIsOn] forKey:@"midiNoteIsOn"];
    [behavior setValue:[NSNumber numberWithInt:midiType] forKey:@"midiType"];
    [behavior setValue:[NSNumber numberWithInt:midiVelocity] forKey:@"midiVelocity"];
    [behavior setValue:[NSNumber numberWithBool:motionReverse] forKey:@"motionReverse"];
    [behavior setValue:[NSNumber numberWithInt:motionStartCCValue] forKey:@"motionStartCCValue"];
    [behavior setValue:[NSNumber numberWithInt:motionType] forKey:@"motionType"];
    [behavior setValue:[NSNumber numberWithInt:type] forKey:@"type"];
    [behavior setValue:behaviorDescription forKey:@"behaviorDescription"];
    [behavior setValue:createdTimestamp forKey:@"createdTimestamp"];
    [behavior setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    behCopied++;
  }
  
  NSLog(@"\tCopying looks...");
  
  NSString *selLooks = @"SELECT * from ZLOOK";
  FMResultSet *lookSet = [sqliteDb executeQuery:selLooks];
  
  int lookCopied = 0;
  while ([lookSet next]) {
    int bowswitch = [lookSet intForColumn:@"ZBOWSWITCH"];
    int button = [lookSet intForColumn:@"ZBUTTON"];
    int color = [lookSet intForColumn:@"ZCOLOR"];
    NSString *mainLabel = [lookSet stringForColumn:@"ZMAINLABEL"];
    NSString *smallLabel = [lookSet stringForColumn:@"ZSMALLLABEL"];
    
    NSManagedObject *look = [NSEntityDescription
                             insertNewObjectForEntityForName:@"Look"
                             inManagedObjectContext:context];
    [look setValue:[NSNumber numberWithInt:bowswitch] forKey:@"bowswitch"];
    [look setValue:[NSNumber numberWithInt:button] forKey:@"button"];
    [look setValue:[NSNumber numberWithInt:color] forKey:@"color"];
    [look setValue:mainLabel forKey:@"mainLabel"];
    [look setValue:smallLabel forKey:@"smallLabel"];
    [look setValue:[NSNumber numberWithInteger:page] forKey:@"page"];
    
    lookCopied++;
  }
  
  // Save context.
  NSError *error = nil;
  if ([context save:&error] == NO) {
    NSAssert(NO, @"\t\t\tError saving context: %@\n%@",
             [error localizedDescription],
             [error userInfo]);
  }
  
  NSLog(@"\tBehaviors copied: %d", behCopied);
  NSLog(@"\tLooks copied: %d", lookCopied);
  
  NSLog(@"\tQuerying copied sample behaviors...");
  
  NSFetchRequest *getBehs = [NSFetchRequest fetchRequestWithEntityName:@"Behavior"];
  [getBehs setPredicate:[NSPredicate predicateWithFormat:@"page == -1"]];
  NSInteger behCount = [context countForFetchRequest:getBehs error:nil];
  NSLog(@"\tBehaviors count: %ld", (long)behCount);
  
  NSFetchRequest *getLooks = [NSFetchRequest fetchRequestWithEntityName:@"Look"];
  [getLooks setPredicate:[NSPredicate predicateWithFormat:@"page == -1"]];
  NSInteger lookCount = [context countForFetchRequest:getLooks error:nil];
  NSLog(@"\tLooks count: %ld", (long)lookCount);
  
  // Override page 0 with sample mapping.
  [self overrideWithSampleMappingOnPage:0];
}

@end

