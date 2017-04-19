//
//  SessionDAO.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionDAO.h"
#import "SessionDTO.h"
#import <Realm/Realm.h>

@implementation SessionDAO
    
    static RLMRealm *realm;
    
    +(void)initialize{
        realm = [RLMRealm defaultRealm];
    }
    
    //=================================================================================//
    //                          agenda view sessions methods                           //
    //=================================================================================//
    
    -(void)addSessions: (NSArray*) sessions{
        [self deleteSessions];
        NSError *error;
        [realm beginWriteTransaction];
        [realm addOrUpdateObjectsFromArray:sessions];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
    -(void)deleteSessions{
        NSError *error;
        [realm beginWriteTransaction];
        [realm deleteObjects:[SessionDTO allObjects]];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
    -(id<NSFastEnumeration>)getAllSessions{
        RLMResults<SessionDTO *> *sessions = [SessionDTO allObjects];
        return sessions;
    }
    
    -(id<NSFastEnumeration>)getSessionsByDate:(AgendaDay)agendaDay{
        RLMResults<SessionDTO *> *sessions = [SessionDTO objectsWhere:@"date = %ld", [AgendaDays agendaDayToDate:agendaDay]];
        return sessions;
    }
    
    //=================================================================================//
    //                      user My agenda view sessions methods                       //
    //=================================================================================//
    
    -(id<NSFastEnumeration>)getAllUserSessions{
        RLMResults<SessionDTO *> *sessions = [SessionDTO objectsWhere:@"status = %d OR status = %d", PENDING, APPROVED];
        return sessions;
    }
    
    -(id<NSFastEnumeration>)getUserSessionsByDate:(AgendaDay)agendaDay{
        RLMResults<SessionDTO *> *sessions = [SessionDTO objectsWhere:@"date = %ld AND (status = %d OR status = %d)", [AgendaDays agendaDayToDate:agendaDay], PENDING, APPROVED];
        return sessions;
    }
    
    -(void)updateSessionUserStatus: (SessionDTO *)session{
        NSError *error;
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:session];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
@end
