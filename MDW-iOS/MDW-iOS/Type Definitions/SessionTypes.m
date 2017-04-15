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
        NSDictionary<NSString*, NSNumber*> *sessionTypes = @{
                                                             sessionTypeValues[0] : @(BREAK),
                                                             sessionTypeValues[1] : @(HACKATHON),
                                                             sessionTypeValues[2] : @(SESSION),
                                                             sessionTypeValues[3] : @(WORKSHOP)
                                                             };
        return (SessionType)[sessionTypes objectForKey:stringValue];
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
