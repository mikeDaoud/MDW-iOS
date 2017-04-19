//
//  ImageDTO.h
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ImageDTO : RLMObject

    @property NSString *imageURL;
    @property NSData *image;
    
    -(instancetype)initWithImageURL:(NSString *)imageURL image:(NSData *)image;
    
@end
