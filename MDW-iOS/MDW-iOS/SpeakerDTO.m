//
//  SpeakerDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "SpeakerDTO.h"

@implementation SpeakerDTO
    
    +(NSString *)primaryKey{
        return @"speakerId";
    }
    
    -(instancetype)initWithSpeakerId:(NSInteger)speakerId firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName title:(NSString *)title companyName:(NSString *)companyName imageURL:(NSString *)imageURL biography:(NSString *)biography{
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

    -(void)printObjectData{
        NSLog(@"---------- %@", _firstName);
        NSLog(@"---------- %@", _middleName);
        NSLog(@"---------- %@", _lastName);
        NSLog(@"---------- %@", _companyName);
        NSLog(@"---------- %@", _imageURL);
        NSLog(@"---------- %@", _title);
        NSLog(@"---------- %@", _biography);
        NSLog(@"---------- %ld", (long)_speakerId);
    }
    
@end
