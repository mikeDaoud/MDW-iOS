//
//  SessionDTO.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SessionDTO : NSObject

    @property long date;
    @property NSString *name;
    @property NSString *location;
    @property long startDate;
    @property long endDate;
    @property NSString *sessionType;
    @property int status;
    @property NSString *sessionDescription;
    @property BOOL liked;
    @property NSArray *speakers;
    
    -(instancetype)initWithDate:(long)date name:(NSString *)name location:(NSString *)location startDate:(long)startDate endDate:(long)endDate sessionType:(NSString *)sessionType status:(int)status sessionDescription:(NSString *)sessionDescription liked:(BOOL)liked speakers:(NSArray *)speakers;


    -(void)printOject;
@end
