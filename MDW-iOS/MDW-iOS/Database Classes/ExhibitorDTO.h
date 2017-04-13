//
//  ExhibitorDTO.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitorDTO : NSObject

    @property int exhibitorId;
    @property NSString *companyName;
    @property NSString *companyUrl;
    @property NSString *imageURL;
    
    -(instancetype)initWithExhibitorId:(int)exhibitorId companyName:(NSString *)companyName companyUrl:(NSString *)companyUrl imageURL:(NSString *)imageURL;
    
@end
