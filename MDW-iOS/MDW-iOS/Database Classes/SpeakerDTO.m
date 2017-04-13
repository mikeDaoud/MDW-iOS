//
//  SpeakerDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "SpeakerDTO.h"

@implementation SpeakerDTO
    
    -(instancetype)initWithSpeakerId:(int)speakerId firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName title:(NSString *)title companyName:(NSString *)companyName imageURL:(NSString *)imageURL biography:(NSString *)biography{
        self = [super init];
        if (self) {
            self.speakerId = speakerId;
            self.firstName = firstName;
            self.middleName = middleName;
            self.lastName = lastName;
            self.title = title;
            self.companyName = companyName;
            self.imageURL = imageURL;
            self.biography = biography;
        }
        return self;
    }
    
    -(NSString *)getFullName{
        NSString *fullName = _firstName;
        if (!_middleName && ![[_middleName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]) {
            fullName = [fullName stringByAppendingString:_middleName];
        }
        return [fullName stringByAppendingString:_lastName];
    }
    
@end
