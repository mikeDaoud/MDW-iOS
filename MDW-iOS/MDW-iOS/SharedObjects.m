//
//  SharedObjects.m
//  MDW-iOS
//
//  Created by Michael on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SharedObjects.h"

@implementation SharedObjects

+ (AFURLSessionManager *)sharedSessionManager {
    
    static AFURLSessionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
        sharedManager = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    });
    return sharedManager;
}


+ (AFHTTPSessionManager *)sharedHTTPSessionManager {
    
    static AFHTTPSessionManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedManager = [AFHTTPSessionManager manager];
        sharedManager.responseSerializer  = [[AFImageResponseSerializer alloc] init];
    });
    return sharedManager;
}

@end
