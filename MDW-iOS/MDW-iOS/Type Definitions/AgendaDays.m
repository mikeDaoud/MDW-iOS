//
//  AgendaDays.m
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "AgendaDays.h"

@implementation AgendaDays
    
    static NSArray *agendaDayValues;
    
    +(void)initialize{
        agendaDayValues = @[[NSNumber numberWithLong:1460584800000], [NSNumber numberWithLong:1460671200000], [NSNumber numberWithLong:1460757600000]];
    }
    
    +(AgendaDay)dateToAgendaDay:(long)date{
        AgendaDay agendaDay = -1;
        if (date == [agendaDayValues[0] longValue]) {
            agendaDay = DAY_ONE;
        }
        else if (date == [agendaDayValues[1] longValue]) {
            agendaDay = DAY_TWO;
        }
        else if (date == [agendaDayValues[2] longValue]) {
            agendaDay = DAY_THREE;
        }
        return agendaDay;
    }
    
    +(long)agendaDayToDate:(AgendaDay)agendaDay{
        NSDictionary<NSNumber*, NSNumber*> *agendaDays = @{
                                                           @(DAY_ONE) : agendaDayValues[0],
                                                           @(DAY_TWO) : agendaDayValues[1],
                                                           @(DAY_THREE) : agendaDayValues[2]
                                                           };
        return [[agendaDays objectForKey:@(agendaDay)] longValue];
    }
    
@end
