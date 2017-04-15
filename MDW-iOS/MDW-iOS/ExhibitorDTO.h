//
//  ExhibitorDTO.h
//  DTO
//
//  Created by Aya on 4/12/17.
//  Copyright © 2017 ITI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ExhibitorDTO : RLMObject
    
    @property NSString *companyName;
    @property NSString *companyUrl;
    @property NSString *imageURL;
    
    -(instancetype)initWithCompanyName:(NSString *)companyName companyUrl:(NSString *)companyUrl imageURL:(NSString *)imageURL;
    
@end
