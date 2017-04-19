//
//  Attendee.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attendee : NSObject <NSCoding>
    
    @property (readonly) NSString *fullName;
    @property NSString *firstName;
    @property NSString *middleName;
    @property NSString *lastName;
    @property NSString *title;
    @property NSString *companyName;
    @property NSString *email;
    @property NSString *mobile;
    @property NSString *imageURL;
    @property NSString *code;
    
    -(instancetype)initWithFirstName:(NSString *)firstName middleName:(NSString *)middleName lastName:(NSString *)lastName title:(NSString *)title companyName:(NSString *)companyName email:(NSString *)email mobile:(NSString *)mobile imageURL:(NSString *)imageURL code:(NSString *)code;
    
    -(void) printObjectData;
    
@end
