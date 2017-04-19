//
//  SharedObjects.h
//  MDW-iOS
//
//  Created by Michael on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface SharedObjects : NSObject

+ (AFURLSessionManager *)sharedSessionManager;
+ (AFHTTPSessionManager *)sharedHTTPSessionManager;

@end
