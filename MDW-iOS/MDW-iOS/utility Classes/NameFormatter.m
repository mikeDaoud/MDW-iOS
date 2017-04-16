//
//  NameFormatter.m
//  MDW-iOS
//
//  Created by Aya on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "NameFormatter.h"

@implementation NameFormatter

    -(instancetype)initWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName{
        self = [super init];
        if (self) {
            self.firstName = firstName;
            self.middleName = middleName;
            self.lastName = lastName;
        }
        return self;
    }

    -(NSString *)fullName{
        if (_middleName != nil) {
            _middleName = [_middleName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            if (![_middleName isEqualToString:@""]){
                return [NSString stringWithFormat:@"%@ %@ %@", _firstName, _middleName, _lastName];
            }
        }
        return [NSString stringWithFormat:@"%@ %@", _firstName, _lastName];
    }

@end
