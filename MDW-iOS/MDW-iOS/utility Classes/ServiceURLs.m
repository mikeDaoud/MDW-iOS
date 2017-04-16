//
//  ServiceURLs.m
//  MDW-iOS
//
//  Created by Michael on 4/9/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ServiceURLs.h"

@implementation ServiceURLs

static NSString * signedInUserEmail;

//Returning Login URLRequest
+(NSURLRequest *)loginRequestWithUserEmail: (NSString *)userEmail andPassword: (NSString *)password{
    
    signedInUserEmail = userEmail;
    

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/login?userName=%@&password=%@", userEmail, password]];
    return [[NSURLRequest alloc]initWithURL:url];
}


//Return a request to get all the sessions data
+(NSURLRequest *)allSessionsRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];

}

//Return a URL request to get all speakers Data
+(NSURLRequest *)speakersRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/getSpeakers?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];

}


//Return a URL request to get user profile data
+(NSURLRequest *)userProfileRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/getAttendeeProfile?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];

}

//return a URL request to get user Profile image
+(NSURLRequest *)profileImageRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/profileImage?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];

}

//return a URL request to get all Exhibitors data
+(NSURLRequest *)exhibitorsDataRequest{
    
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/getExhibitors?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];
}

//return a URL request to register to a certain session

+(NSURLRequest *)requestRegisterToSessionWithID: (NSInteger) sessionID{
    
    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/registerSession?userName=%@&sessionId=%ld&enforce=false&status=0", signedInUserEmail, (long)sessionID]];
    return [[NSURLRequest alloc]initWithURL:url];
}




@end
