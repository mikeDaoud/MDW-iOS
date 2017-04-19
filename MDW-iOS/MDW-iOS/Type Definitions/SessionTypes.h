//
//  SessionTypes.h
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {BREAK, HACKATHON, SESSION, WORKSHOP} SessionType;

@interface SessionTypes : NSObject
    
    +(SessionType)stringToSessionType:(NSString *)stringValue;
    
    +(NSString *)sessionTypeToString:(SessionType)SessionTypeValue;
    
@end
