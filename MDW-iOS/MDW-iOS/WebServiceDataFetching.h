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
#import "ExhibitorDTO.h"
#import "ImageDTO.h"
#import "TableReloadDelegate.h"


@interface WebServiceDataFetching : NSObject

+(void)fetchSessionsFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView;

+(void)fetchSpeakersFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView;

+(void)fetchExhibitorsFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView;

+(void)fetchImageWithURL: (NSString *) imageURL andRefreshImageView: (UIImageView *) imageView;

@end
