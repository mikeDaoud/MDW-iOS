//
//  SessionDTO.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import "SpeakerDTO.h"
#import "SessionTypes.h"
#import "Statuses.h"
#import "AgendaDays.h"

RLM_ARRAY_TYPE(SpeakerDTO)

@interface SessionDTO : RLMObject
    
    @property NSInteger sessionId;
    @property long date;
    @property NSString *name;
    @property NSString *location;
    @property long startDate;
    @property long endDate;
    @property NSString *sessionType;
    @property int status;
    @property NSString *sessionDescription;
    @property RLMArray<SpeakerDTO*><SpeakerDTO> *speakers;
    
    -(instancetype)initWithSessionId:(NSInteger)sessionId agendaDay:(AgendaDay)agendaDay name:(NSString *)name location:(NSString *)location startDate:(long)startDate endDate:(long)endDate sessionType:(SessionType)sessionType status:(Status)status sessionDescription:(NSString *)sessionDescription speakers:(id<NSFastEnumeration>)speakers;
    
@end
