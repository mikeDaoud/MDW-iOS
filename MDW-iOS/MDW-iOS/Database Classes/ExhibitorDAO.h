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

-(NSArray *)getExhibitors;

-(void)deleteExhibitors;

@end
