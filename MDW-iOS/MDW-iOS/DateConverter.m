//
//  DateConverter.m
//  MDW-iOS
//
//  Created by Michael on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "DateConverter.h"

@implementation DateConverter

+(NSString *)stringFromDate: (NSTimeInterval) timeInterval{

    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"hh:mm a"];
    
   return [formatter stringFromDate:date];
}

+(NSString *)dayStringFromDate: (NSTimeInterval) timeInterval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"dd"];
    
    return [formatter stringFromDate:date];
    
}


@end

