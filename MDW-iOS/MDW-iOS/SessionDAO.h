//
//  SessionDAO.h
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionDTO.h"

@interface SessionDAO : NSObject
    
    //=================================================================================//
    //                          agenda view sessions methods                           //
    //=================================================================================//
    
    // replaces the data in the DB with the new data from the webservice ... clears the old data, and add the new data
    -(void)addSessions: (NSArray*) sessions;
    
    // Delete all sessions to update them with the new data
    -(void)deleteSessions;
    
    //returns a list of all sessions for the "all days" view
    -(id<NSFastEnumeration>)getAllSessions;
    
    //returns a list of sessions (filter by date)
    -(id<NSFastEnumeration>)getSessionsByDate:(AgendaDay)agendaDay;
    
    
    //=================================================================================//
    //                      user My agenda view sessions methods                       //
    //=================================================================================//
    
    //returns a list of all subscribed sessions for the attendee
    -(id<NSFastEnumeration>)getAllUserSessions;
    
    //returns a list of the user's subscribed sessions (filter by date)
    -(id<NSFastEnumeration>)getUserSessionsByDate:(AgendaDay)agendaDay;
    
    //gets a list of user's subscribed sessions and update them to subscribed in the database for retrieval later in the user "my agenda" view
    -(void)updateSessionUserStatus: (SessionDTO *)session status:(int)status;
    
@end
