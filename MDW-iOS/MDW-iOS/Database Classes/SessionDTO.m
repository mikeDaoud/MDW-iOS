//
//  SessionDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "SessionDTO.h"
#import "SpeakerDTO.h"

@implementation SessionDTO
    
    static NSArray *sessionTypes;
    static NSArray *statuses;
    
    +(void)initialize{
        sessionTypes = @[@"Break", @"Hackathon", @"Session", @"Workshop"];
        statuses = @[@0, @1, @2];
    }
    
    -(instancetype)initWithDate:(long)date name:(NSString *)name location:(NSString *)location startDate:(long)startDate endDate:(long)endDate sessionType:(NSString *)sessionType status:(int)status sessionDescription:(NSString *)sessionDescription liked:(BOOL)liked speakers:(NSArray *)speakers{
        self = [super init];
        if (self) {
            self.date = date;
            self.name = name;
            self.location = location;
            self.startDate = startDate;
            self.endDate = endDate;
            self.sessionType = sessionType;
            self.status = status;
            self.sessionDescription = sessionDescription;
            self.liked = liked;
            self.speakers = speakers;
        }
        return self;
    }

-(void)printOject{
    NSLog(@"--------- date %ld", _date);
    NSLog(@"--------- name %@", _name);
    NSLog(@"--------- liked %@", (_liked?@"YES" : @"NO"));
    NSLog(@"--------- status %d", _status);
    NSLog(@"--------- endDate %ld", _endDate);
    NSLog(@"--------- location %@", _location);
    NSLog(@"--------- startDate %ld", _startDate);
    NSLog(@"--------- sessionType %@", _sessionType);
    NSLog(@"--------- Description%@", _sessionDescription);
    
    for (SpeakerDTO * speaker in _speakers) {
        [speaker printObjectData];
    }
    
}
    
@end
