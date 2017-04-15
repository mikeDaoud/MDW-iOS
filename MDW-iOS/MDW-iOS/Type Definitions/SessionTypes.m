//
//  SessionTypes.m
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionTypes.h"

@implementation SessionTypes
    
    static NSArray *sessionTypeValues;
    
    +(void)initialize{
        sessionTypeValues = @[@"Break", @"Hackathon", @"Session", @"Workshop"];
    }
    
    +(SessionType)stringToSessionType:(NSString *)stringValue{
        SessionType sessionType = -1;
        if ([stringValue isEqualToString:sessionTypeValues[0]]) {
            sessionType = BREAK;
        }
        else if ([stringValue isEqualToString:sessionTypeValues[1]]) {
            sessionType = HACKATHON;
        }
        else if ([stringValue isEqualToString:sessionTypeValues[2]]) {
            sessionType = SESSION;
        }
        else if ([stringValue isEqualToString:sessionTypeValues[3]]) {
            sessionType = WORKSHOP;
        }
        return sessionType;
    }
    
    +(NSString *)sessionTypeToString:(SessionType)SessionTypeValue{
        NSDictionary<NSNumber*, NSString*> *sessionTypes = @{
                                                             @(BREAK) : sessionTypeValues[0],
                                                             @(HACKATHON) : sessionTypeValues[1],
                                                             @(SESSION) : sessionTypeValues[2],
                                                             @(WORKSHOP) : sessionTypeValues[3]
                                                             };
        return [sessionTypes objectForKey:@(SessionTypeValue)];
    }
    
@end
