//
//  WebServiceDataFetching.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "WebServiceDataFetching.h"
#import "AgendaDays.h"
#import "SessionTypes.h"
#import "ExhibitorDAO.h"
#import "SessionDAO.h"
#import "SpeakerDAO.h"
#import "ImageDAO.h"
#import "SharedObjects.h"

@implementation WebServiceDataFetching

+(void)fetchSessionsFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView{
    NSURLSessionDataTask *dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs allSessionsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
            [tableView showErrorMsgWithText:@"Problems with connection"];
        } else {
            NSMutableArray * sessions = [NSMutableArray new];
            NSDictionary * result = [responseObject objectForKey:@"result"];
            NSArray * agendas = [result objectForKey:@"agendas"];
            
            for (NSDictionary *day in agendas) {
                NSNumber * date = [day objectForKey:@"date"];
                NSArray * daySessions = [day objectForKey:@"sessions"];
                for (NSDictionary * session in daySessions) {
                    
                    //getting session speakers
                    NSMutableArray * sessionSpearkers = [NSMutableArray new];
                    NSArray * speakersList = [session objectForKey:@"speakers"];
                    if (![speakersList isKindOfClass:[NSNull class]]) {
                        for (NSDictionary * speaker in speakersList) {
                            NSNumber * speakerID = [speaker objectForKey:@"id"];
                            SpeakerDTO * speakerDTO = [[SpeakerDTO alloc]
                                                       initWithSpeakerId:[speakerID intValue]
                                                       firstName: [speaker objectForKey:@"firstName"]
                                                       middleName:[speaker objectForKey:@"middleName"]
                                                       lastName:[speaker objectForKey:@"lastName"]
                                                       title:[speaker objectForKey:@"title"]
                                                       companyName:[speaker objectForKey:@"companyName"]
                                                       imageURL:[speaker objectForKey:@"imageURL"]
                                                       biography:[speaker objectForKey:@"biography"]];
                            [sessionSpearkers addObject:speakerDTO];
                        }
                    }
                    
                    NSNumber * startDate = [session valueForKey:@"startDate"];
                    NSNumber * endDate = [session valueForKey:@"endDate"];
                    NSNumber * status = [session valueForKey:@"status"];
                    NSNumber * sessionID = [session valueForKey:@"id"];
                    
                     SessionDTO * sessiondto = [[SessionDTO alloc]
                                    initWithSessionId:[sessionID integerValue]
                                    agendaDay:[AgendaDays dateToAgendaDay:[date longValue]]
                                    name:[session objectForKey:@"name"]
                                    location:[session objectForKey:@"location"]
                                    startDate:[startDate longValue]
                                    endDate:[endDate longValue]
                                    sessionType:[SessionTypes stringToSessionType:[session objectForKey:@"sessionType"]]
                                    status: [status intValue]
                                    sessionDescription:[session objectForKey:@"description"]
                                    speakers:sessionSpearkers
                                                ];
                    
                    [sessions addObject:sessiondto];
                }
                
            }
            
            
            //Cashing data to DB
            [[SessionDAO new] addSessions:sessions];
            
            NSLog(@"Calling the table view refresh method ++++++++++++ ");
            [tableView reloadTableView];
            NSLog(@"Calling the table view refresh method ------------- ");
        }
    }];
    [dataTask resume];
}

+(void)fetchSpeakersFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView{
    
    NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs speakersRequest] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            [tableView showErrorMsgWithText:@"Problems with connection"];
        } else {
            NSMutableArray * speakersList = [[NSMutableArray alloc] init];
            NSArray * speakers = [responseObject objectForKey:@"result"];
            for (NSDictionary * speaker in speakers) {
                NSNumber * spID = [speaker objectForKey:@"id"];
                
                SpeakerDTO * speakerdto = [[SpeakerDTO alloc]
            initWithSpeakerId:[spID intValue]
            firstName:[speaker objectForKey:@"firstName"]
            middleName:[speaker objectForKey:@"middleName"]
            lastName:[speaker objectForKey:@"lastName"]
            title:[speaker objectForKey:@"title"]
            companyName:[speaker objectForKey:@"companyName"]
            imageURL:[speaker objectForKey:@"imageURL"]
            biography:[speaker objectForKey:@"biography"]
                                           ];
                [speakersList addObject:speakerdto];
            }
            
            //Caching data in DB
            [[SpeakerDAO new] addSpeakers:speakersList];
            
            [tableView reloadTableView];
        
        }
        
    }];
    [dataTask resume];

}

+(void)fetchExhibitorsFromWebServiceAndUpdateTable: ( id<TableReloadDelegate>) tableView{

    NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs exhibitorsDataRequest] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            [tableView showErrorMsgWithText:@"Problems with connection"];
        } else {
            NSMutableArray * exhibitorsList = [[NSMutableArray alloc] init];
            NSArray * exhibitors = [responseObject objectForKey:@"result"];
            for (NSDictionary * exhibitor in exhibitors) {
                
                ExhibitorDTO * exhibitordto = [[ExhibitorDTO alloc]
                                               initWithCompanyName:[exhibitor objectForKey:@"companyName"]
                                               companyUrl:[exhibitor objectForKey:@"companyUrl"]
                                               imageURL:[exhibitor objectForKey:@"imageURL"]];

                [exhibitorsList addObject:exhibitordto];
            }
            
            //Caching data in DB
            [[ExhibitorDAO new] addExhibitors:exhibitorsList];
            
            [tableView reloadTableView];
        }
        
    }];
    [dataTask resume];
    
}

+(void)fetchImageWithURL: (NSString *) imageURL andRefreshImageView: (UIImageView *) imageView{
    
    NSString * cutURL = [imageURL stringByReplacingOccurrencesOfString:@"www." withString:@""];
    
    [[SharedObjects sharedHTTPSessionManager] GET:cutURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        
        UIImage* img = (UIImage*) responseObject;
        
        //Caching the image in the database
        [[ImageDAO new] addImage:[[ImageDTO alloc] initWithImageURL:imageURL image:UIImageJPEGRepresentation(img, 0.7)]];
        [imageView setImage:img];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}


@end
