//
//  SpeakerDTO.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpeakerDTO : NSObject

    @property int speakerId;
    @property NSString *firstName;
    @property NSString *middleName;
    @property NSString *lastName;
    @property NSString *title;
    @property NSString *companyName;
    @property NSString *imageURL;
    @property NSString *biography;
    
    -(instancetype)initWithSpeakerId:(int)speakerId firstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName title:(NSString *)title companyName:(NSString *)companyName imageURL:(NSString *)imageURL biography:(NSString *)biography;
    
    -(NSString *)getFullName;

-(void)printObjectData;
    
@end
