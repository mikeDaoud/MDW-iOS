//
//  NameFormatter.h
//  MDW-iOS
//
//  Created by Aya on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NameFormatter : NSObject

    @property NSString *firstName;
    @property NSString *middleName;
    @property NSString *lastName;

    -(instancetype)initWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName;

    -(NSString *)fullName;

@end
