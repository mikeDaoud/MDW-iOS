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

+(NSURLRequest *)loginRequestWithUserEmail: (NSString *)userEmail andPassword: (NSString *)password{
    
    signedInUserEmail = userEmail;
    

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/login?userName=%@&password=%@", userEmail, password]];
    return [[NSURLRequest alloc]initWithURL:url];
}


+(NSURLRequest *)allSessionsRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"http://www.mobiledeveloperweekend.net/MDW/service/getSessions?userName=%@", signedInUserEmail]];
    return [[NSURLRequest alloc]initWithURL:url];

}

+(NSURLRequest *)speakersRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"URL to be added here"]];
    return [[NSURLRequest alloc]initWithURL:url];

}

+(NSURLRequest *)userProfileRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"URL to be added here"]];
    return [[NSURLRequest alloc]initWithURL:url];

}

+(NSURLRequest *)profileImageRequest{

    NSURL * url = [[NSURL alloc]initWithString:[NSString stringWithFormat:@"URL to be added here"]];
    return [[NSURLRequest alloc]initWithURL:url];

}

@end
