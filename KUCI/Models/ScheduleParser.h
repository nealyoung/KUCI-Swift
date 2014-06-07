//
//  ScheduleParser.h
//  KUCI
//
//  Created by Nealon Young on 12/30/12.
//  Copyright (c) 2012 Nealon Young. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Show;

@interface ScheduleParser : NSObject

+ (void)allShowsWithCompletion:(void (^)(NSArray *shows))block;
+ (void)currentShowWithCompletion:(void (^)(Show *show))block;

@end
