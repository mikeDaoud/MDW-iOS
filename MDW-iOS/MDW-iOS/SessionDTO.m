//
//  SessionDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "SessionDTO.h"

@implementation SessionDTO
    
    +(NSString *)primaryKey{
        return @"sessionId";
    }
    
    -(instancetype)initWithSessionId:(NSInteger)sessionId agendaDay:(AgendaDay)agendaDay name:(NSString *)name location:(NSString *)location startDate:(long)startDate endDate:(long)endDate sessionType:(SessionType)sessionType status:(Status)status sessionDescription:(NSString *)sessionDescription speakers:(id<NSFastEnumeration>)speakers{
        self = [super init];
        if (self) {
            self.sessionId = sessionId;
            self.date = [AgendaDays agendaDayToDate:agendaDay];
            self.name = name;
            self.location = location;
            self.startDate = startDate;
            self.endDate = endDate;
            self.sessionType = [SessionTypes sessionTypeToString:sessionType];
            self.status = [@(status) intValue];
            self.sessionDescription = sessionDescription;
            [[self speakers] addObjects:speakers];
        }
        return self;
    }

    -(void)printOject{
        NSLog(@"--------- date %ld", _date);
        NSLog(@"--------- name %@", _name);
        NSLog(@"--------- status %d", _status);
        NSLog(@"--------- endDate %ld", _endDate);
        NSLog(@"--------- location %@", _location);
        NSLog(@"--------- startDate %ld", _startDate);
        NSLog(@"--------- sessionType %@", _sessionType);
        NSLog(@"--------- Description%@", _sessionDescription);
    
        for (SpeakerDTO *speaker in _speakers) {
            [speaker printObjectData];
        }
    }
    
@end
