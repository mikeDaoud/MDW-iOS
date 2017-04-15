//
//  DateConverter.h
//  MDW-iOS
//
//  Created by Michael on 4/15/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateConverter : NSObject

+(NSString *)stringFromDate: (NSTimeInterval) timeInterval;
+(NSString *)dayStringFromDate: (NSTimeInterval) timeInterval;

@end
