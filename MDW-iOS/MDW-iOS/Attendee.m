//
//  Attendee.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "Attendee.h"

@implementation Attendee
    
    -(instancetype)initWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName title:(NSString *)title companyName:(NSString *)companyName email:(NSString *)email mobile:(NSString *)mobile imageURL:(NSString *)imageURL code:(NSString *)code;{
        self = [super init];
        if (self) {
            self.firstName = firstName;
            self.middleName = middleName;
            self.lastName = lastName;
            self.title = title;
            self.companyName = companyName;
            self.email = email;
            self.mobile = mobile;
            self.imageURL = imageURL;
            self.code = code;
        }
        return self;
    }
    
    -(void)encodeWithCoder:(NSCoder *)aCoder{
        [aCoder encodeObject:_firstName forKey:@"firstName"];
        [aCoder encodeObject:_middleName forKey:@"middleName"];
        [aCoder encodeObject:_lastName forKey:@"lastName"];
        [aCoder encodeObject:_title forKey:@"title"];
        [aCoder encodeObject:_companyName forKey:@"companyName"];
        [aCoder encodeObject:_email forKey:@"email"];
        [aCoder encodeObject:_mobile forKey:@"mobile"];
        [aCoder encodeObject:_imageURL forKey:@"image"];
        [aCoder encodeObject:_code forKey:@"code"];
    }
    
    -(instancetype)initWithCoder:(NSCoder *)aDecoder{
        self.firstName = [aDecoder decodeObjectForKey:@"firstName"];
        self.middleName = [aDecoder decodeObjectForKey:@"middleName"];
        self.lastName = [aDecoder decodeObjectForKey:@"lastName"];
        self.title = [aDecoder decodeObjectForKey:@"title"];
        self.companyName = [aDecoder decodeObjectForKey:@"companyName"];
        self.email = [aDecoder decodeObjectForKey:@"email"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.imageURL = [aDecoder decodeObjectForKey:@"image"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        return self;
    }
    
    -(void) printObjectData{
        NSLog(@"--------- code %@",_code);
        NSLog(@"--------- email %@",_email);
        NSLog(@"--------- title %@",_title);
        NSLog(@"--------- mobile%@",_mobile);
        NSLog(@"--------- imageURL %@",_imageURL);
        NSLog(@"--------- lastName %@",_lastName);
        NSLog(@"--------- firstName %@",_firstName);
        NSLog(@"--------- middleName%@",_middleName);
        NSLog(@"--------- companyName%@",_companyName);
    }
    
@end
