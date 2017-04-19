//
//  AgendaDays.h
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {DAY_ONE, DAY_TWO, DAY_THREE} AgendaDay;

@interface AgendaDays : NSObject
    
    +(AgendaDay)dateToAgendaDay:(long)date;
    
    +(long)agendaDayToDate:(AgendaDay)agendaDay;
    
@end
