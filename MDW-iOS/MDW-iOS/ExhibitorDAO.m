//
//  ExhibitorDAO.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ExhibitorDAO.h"
#import "ExhibitorDTO.h"
#import <Realm/Realm.h>

@implementation ExhibitorDAO
    
    static RLMRealm *realm;
    
    +(void)initialize{
        realm = [RLMRealm defaultRealm];
    }
    
    -(void)addExhibitors: (NSArray*) exhibitors{
        [self deleteExhibitors];
        NSError *error;
        [realm beginWriteTransaction];
        [realm addObjects:exhibitors];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }

    -(id<NSFastEnumeration>)getExhibitors{
        RLMResults<ExhibitorDTO *> *exhibitors = [ExhibitorDTO allObjects];
        return exhibitors;
    }
    
    -(void)deleteExhibitors{
        NSError *error;
        [realm beginWriteTransaction];
        [realm deleteObjects:[ExhibitorDTO allObjects]];
        [realm commitWriteTransaction];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
@end
