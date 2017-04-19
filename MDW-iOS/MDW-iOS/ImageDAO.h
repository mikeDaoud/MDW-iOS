//
//  ImageDAO.h
//  MDW-iOS
//
//  Created by Aya on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImageDTO.h"

@interface ImageDAO : NSObject

    -(void)addImage:(ImageDTO *)image;
    
    -(ImageDTO *)getImage:(NSString *)imageURL;
    
    -(void)deleteImages;
    
@end
