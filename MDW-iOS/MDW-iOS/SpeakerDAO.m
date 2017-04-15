//
//  SpeakerDAO.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakerDAO.h"
#import "SpeakerDTO.h"
#import <Realm/Realm.h>

@implementation SpeakerDAO
    
    static RLMRealm *realm;
    
    +(void)initialize{
        realm = [RLMRealm defaultRealm];
    }
    
    -(void)addSpeakers : (NSMutableArray *) speakers{
        NSError *error;
        [realm beginWriteTransaction];
        [realm addOrUpdateObjectsFromArray:speakers];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
    -(id<NSFastEnumeration>)getSpeakers{
        RLMResults<SpeakerDTO *> *speakers = [SpeakerDTO allObjects];
        return speakers;
    }
    
    -(void)deleteSpeakers{
        NSError *error;
        [realm beginWriteTransaction];
        [realm deleteObjects:[SpeakerDTO allObjects]];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
    -(SpeakerDTO *)getSpeakerDetails:(NSInteger) speakerId{
        RLMResults<SpeakerDTO *> *speakers = [SpeakerDTO objectsWhere:@"speakerId = %d", speakerId];
        return [speakers firstObject];
    }
    
@end
