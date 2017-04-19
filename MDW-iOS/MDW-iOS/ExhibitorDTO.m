//
//  ExhibitorDTO.m
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import "ExhibitorDTO.h"

@implementation ExhibitorDTO
    
    -(instancetype)initWithCompanyName:(NSString *)companyName companyUrl:(NSString *)companyUrl imageURL:(NSString *)imageURL;{
        self = [super init];
        if (self) {
            self.companyName = companyName;
            self.companyUrl = companyUrl;
            self.imageURL = imageURL;
        }
        return self;
    }
    
@end
