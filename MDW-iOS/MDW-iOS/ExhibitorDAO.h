//
//  ExhibitorDAO.h
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExhibitorDAO : NSObject
    
    -(void)addExhibitors: (NSArray*) exhibitors;
    
    -(id<NSFastEnumeration>)getExhibitors;
    
    -(void)deleteExhibitors;
    
@end
