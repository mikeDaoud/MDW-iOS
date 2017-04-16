//
//  ServiceURLs.h
//  MDW-iOS
//
//  Created by Michael on 4/9/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceURLs : NSObject

+(NSURLRequest *)loginRequestWithUserEmail: (NSString *)userEmail andPassword: (NSString *)password;
+(NSURLRequest *)allSessionsRequest;
+(NSURLRequest *)speakersRequest;
+(NSURLRequest *)userProfileRequest;
+(NSURLRequest *)profileImageRequest;
+(NSURLRequest *)exhibitorsDataRequest;
+(NSURLRequest *)requestRegisterToSessionWithID: (NSInteger) sessionID;

@end
