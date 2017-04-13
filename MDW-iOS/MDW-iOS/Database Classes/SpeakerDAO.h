//
//  SpeakerDAO.h
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SpeakerDTO.h"

@interface SpeakerDAO : NSObject

-(void)addSpeakers : (NSArray*) speakers;

-(NSArray *)getSpeakers;

-(void)deleteSpeakers;


//Returns a speaker object with all his/her details for the detail view
-(SpeakerDTO *)getSpeakerDetails;


@end
