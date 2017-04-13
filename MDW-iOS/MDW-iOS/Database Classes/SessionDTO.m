//
//  SessionDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "SessionDTO.h"

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
    
@end
