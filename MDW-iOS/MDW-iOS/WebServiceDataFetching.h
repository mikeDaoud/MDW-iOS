//
//  WebServiceDataFetching.h
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "ServiceURLs.h"
#import "SWRevealViewController.h"
#import "Attendee.h"
#import "SessionDTO.h"
#import "SpeakerDTO.h"

@interface WebServiceDataFetching : NSObject

+(void)fetchSessionsFromWebServicewithSessionManager: (AFURLSessionManager *) mgr;

@end
