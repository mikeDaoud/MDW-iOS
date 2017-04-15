//
//  ImageDAO.m
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ImageDAO.h"

@implementation ImageDAO
    
    static RLMRealm *realm;
    
    +(void)initialize{
        realm = [RLMRealm defaultRealm];
    }
    
    -(void)addImage:(ImageDTO *)image{
        NSError *error;
        [realm beginWriteTransaction];
        [realm addOrUpdateObject:image];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
    -(ImageDTO *)getImage:(NSString *)imageURL{
        RLMResults<ImageDTO *> *images = [ImageDTO objectsWhere:@"imageURL = %@", imageURL];
        return [images firstObject];
    }
    
    -(void)deleteImages{
        NSError *error;
        [realm beginWriteTransaction];
        [realm deleteObjects:[ImageDTO allObjects]];
        [realm commitWriteTransaction:&error];
        if (error != nil) {
            NSLog(@"%@", [error description]);
        }
    }
    
@end
