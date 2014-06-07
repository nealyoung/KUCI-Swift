//
//  ScheduleParser.m
//  KUCI
//
//  Created by Nealon Young on 12/30/12.
//  Copyright (c) 2012 Nealon Young. All rights reserved.
//

#import "ScheduleParser.h"
#import "HTMLParser.h"
#import "KUCI-Swift.h"

static NSString * const kHomepageURLString = @"http://kuci.org";
static NSString * const kScheduleURLString = @"http://kuci.org/schedule.shtml";

@implementation ScheduleParser

+ (void)allShowsWithCompletion:(void (^)(NSArray *shows))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *scheduleURL = [NSURL URLWithString:kScheduleURLString];
        NSMutableString *scheduleHTML = [NSMutableString stringWithContentsOfURL:scheduleURL encoding:NSUTF8StringEncoding error:NULL];
        
        if (scheduleHTML) {
            NSRange dayStartRange = [scheduleHTML rangeOfString:@"<!--- Loop would begin here --->"];
            NSRange dayEndRange = [scheduleHTML rangeOfString:@"<!--- end here --->"];
            
            NSMutableArray *shows = [[NSMutableArray alloc] init];
            
            while (dayStartRange.location != NSNotFound) {
                // The portion of the schedule representing a single day
                NSRange dayRange = NSMakeRange(dayStartRange.location, (dayEndRange.location + dayEndRange.length) - dayStartRange.location);
                NSMutableString *daySchedule = (NSMutableString *)[scheduleHTML substringWithRange:dayRange];
                
                NSError *error = nil;
                HTMLParser *parser = [[HTMLParser alloc] initWithString:daySchedule error:&error];
                
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil);
                    });
                }
                
                HTMLNode *scheduleBody = [parser body];
                NSArray *scheduleNodes = [scheduleBody findChildrenWithAttribute:@"class" matchingName:@"progschedule" allowPartial:FALSE];
                NSArray *descriptionNodes = [scheduleBody findChildrenWithAttribute:@"class" matchingName:@"smallDark" allowPartial:FALSE];
                
                NSMutableArray *dayShows = [[NSMutableArray alloc] init];
                
                // Add shows to the array
                for (NSInteger i = 0; i < [scheduleNodes count]; i += 2) {
                    NSString *time = [[scheduleNodes[i] allContents] substringFromIndex:1];
                    NSString *title = [[scheduleNodes[i + 1] allContents] substringFromIndex:1];
                    NSString *description = [descriptionNodes[i] allContents];
                    NSString *host = [[descriptionNodes[i + 1] allContents] substringFromIndex:3];
                    
                    Show *show = [[Show alloc] initWithTitle:title host:host information:description time:time];
                    [dayShows addObject:show];
                }
                
                // After processing the day's schedule, remove it from the main schedule HTML
                [scheduleHTML deleteCharactersInRange:dayRange];
                
                // Set dayStartRange and dayEndRange to the beginning and ending positions of the next day
                dayStartRange = [scheduleHTML rangeOfString:@"<!--- Loop would begin here --->"];
                dayEndRange = [scheduleHTML rangeOfString:@"<!--- end here --->"];
                
                // Remove the duplicate last show from the day array
                [dayShows removeLastObject];
                
                // Convert the mutable array to NSArray
                [shows addObject:[NSArray arrayWithArray:dayShows]];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(shows);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
            });
        }
    });
}

+ (void)currentShowWithCompletion:(void (^)(Show *show))block {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSURL *homepageURL = [NSURL URLWithString:kHomepageURLString];
        NSMutableString *homepageHTML = [NSMutableString stringWithContentsOfURL:homepageURL encoding:NSUTF8StringEncoding error:NULL];
        
        if (homepageHTML) {
            NSRange dayStartRange = [homepageHTML rangeOfString:@"<!--- Loop would begin here --->"];
            NSRange dayEndRange = [homepageHTML rangeOfString:@"<!--- end here --->"];
            
            while (dayStartRange.location != NSNotFound) {
                // The portion of the schedule representing a single day
                NSRange dayRange = NSMakeRange(dayStartRange.location, (dayEndRange.location + dayEndRange.length) - dayStartRange.location);
                NSMutableString *daySchedule = (NSMutableString *)[homepageHTML substringWithRange:dayRange];
                
                NSError *error = nil;
                HTMLParser *parser = [[HTMLParser alloc] initWithString:daySchedule error:&error];
                
                if (error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(nil);
                    });
                }
                
                HTMLNode *scheduleBody = [parser body];
                NSArray *scheduleNodes = [scheduleBody findChildrenWithAttribute:@"class" matchingName:@"currentlyplaying" allowPartial:FALSE];
                
                if ([scheduleNodes count]) {
                    // Oh god
                    NSArray *descriptionNodes = [[[[[[[scheduleNodes firstObject] parent] nextSibling] nextSibling] children] objectAtIndex:3] children];
                    
                    NSString *time = [[[scheduleNodes firstObject] allContents] substringFromIndex:1];
                    NSString *title = [[[scheduleNodes lastObject] allContents] substringFromIndex:1];
                    NSString *description = [descriptionNodes[1] allContents];
                    NSString *host = [[descriptionNodes[4] allContents] substringFromIndex:3];
                    
                    Show *currentShow = [[Show alloc] initWithTitle:title host:host information:description time:time];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        block(currentShow);
                    });
                    
                    return;
                }
                
                // After processing the day's schedule, remove it from the main schedule HTML
                [homepageHTML deleteCharactersInRange:dayRange];
                
                // Set dayStartRange and dayEndRange to the beginning and ending positions of the next day
                dayStartRange = [homepageHTML rangeOfString:@"<!--- Loop would begin here --->"];
                dayEndRange = [homepageHTML rangeOfString:@"<!--- end here --->"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                block(nil);
            });
        }
    });
}

@end
