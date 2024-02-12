//
//  Mappings.h
//  
//
//  Created by Kevin Ng on 5/12/17.
//

#import <Foundation/Foundation.h>

@interface Mappings : NSObject

@property (nonatomic) NSInteger currentPage;

+ (Mappings *)shared;

- (void)readAndSetSampleMapping;
- (void)overrideWithSampleMappingOnPage:(NSInteger)page;

@end
