//
//  ImageDTO.m
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ImageDTO.h"

@implementation ImageDTO

    +(NSString *)primaryKey{
        return @"imageURL";
    }
    
    -(instancetype)initWithImageURL:(NSString *)imageURL image:(NSData *)image{
        self = [super init];
        if (self) {
            self.imageURL = imageURL;
            self.image = image;
        }
        return self;
    }
    
@end
