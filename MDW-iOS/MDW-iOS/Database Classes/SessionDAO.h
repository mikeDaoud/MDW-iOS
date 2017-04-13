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
-(NSArray *)getAllSessions;

//returns a list of the first day sessions only (filter by date)
-(NSArray *)getFirstDaySessions;

//returns a list of the second day sessions only (filter by date)
-(NSArray *)getSecondtDaySessions;

//returns a list of the third day sessions only (filter by date)
-(NSArray *)getThirdDaySessions;


//=================================================================================//
//                      user My agenda view sessions methods                       //
//=================================================================================//

//returns a list of all subscribed sessions for the attendee
-(NSArray *)getAllUserSessions;

//returns a list of the user's subscribed first day sessions only (filter by date)
-(NSArray *)getUserFirstDaySessions;

//returns a list of the user's subscribed second day sessions only (filter by date)
-(NSArray *)getUserSecondDaySessions;

//returns a list of the user's subscribed third day sessions only (filter by date)
-(NSArray *)getUserThirdDaySessions;

//gets a list of user's subscribed sessions and update them to subscribed in the database for retrieval later in the user "my agenda" view
-(void)UpdateSessionUserStatus: (SessionDTO *) session;


@end
