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

@implementation WebServiceDataFetching

static AFHTTPSessionManager *sessionManager;

+(void)fetchSessionsFromWebServicewithSessionManager: (AFURLSessionManager *) mgr{
    NSURLSessionDataTask *dataTask = [mgr dataTaskWithRequest:[ServiceURLs allSessionsRequest] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
//            NSLog(@"%@ ----  %@", response, responseObject);
            NSMutableArray * sessions = [NSMutableArray new];
            NSDictionary * result = [responseObject objectForKey:@"result"];
            NSArray * agendas = [result objectForKey:@"agendas"];
            
//            NSLog(@"---------------- no.of days in resulsts is %lu", (unsigned long)[agendas count]);
            for (NSDictionary *day in agendas) {
                NSNumber * date = [day objectForKey:@"date"];
                NSLog(@"DAte is ------------------- %@", date);
                NSArray * daySessions = [day objectForKey:@"sessions"];
//                NSLog(@"---------------- no.of sessions in the day are is %lu", (unsigned long)[daySessions count]);
                //Getting list of sessions
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
//                            [speakerDTO printObjectData];
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
                    NSLog(@"Extracted date is: +++++++ %ld", [date longValue]);
                    NSLog(@"Session DAte is: +++++++ %ld", sessiondto.date );
                    NSLog(@"Session Speakers count: +++++++ %ld", [[sessiondto speakers] count]);
                    NSLog(@"Original Speakers count: +++++++ %ld", [sessionSpearkers count]);
                    
                    [sessions addObject:sessiondto];
//                    NSLog(@"---------------- no.ofsessions inside is %lu", (unsigned long)[sessions count]);
                    
                }
                
                
            }
            
//            NSLog(@"---------------- no.ofsessions is %lu", (unsigned long)[sessions count]);
            
            //Cashing data to DB
            for (SessionDTO * ses in sessions) {
                NSLog(@"Session Type ++=++====+=====++==== %@", ses.sessionType);
            }
            
            [[SessionDAO new] addSessions:sessions];
            
            
            
        }
    }];
    [dataTask resume];
}

+(void)fetchSpeakersFromWebServicewithSessionManager: (AFURLSessionManager *) mgr{
    
    NSURLSessionDataTask * dataTask = [mgr dataTaskWithRequest:[ServiceURLs speakersRequest] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
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
            for (SpeakerDTO * s in speakersList) {
//                [s printObjectData];
            }
//            NSLog(@"---------------- no.of Speakers is %lu", (unsigned long)[speakersList count]);
            
            //Caching data in DB
            [[SpeakerDAO new] addSpeakers:speakersList];
        
        }
        
    }];
    [dataTask resume];

}

+(void)fetchExhibitorsFromWebServicewithSessionManager: (AFURLSessionManager *) mgr{

    NSURLSessionDataTask * dataTask = [mgr dataTaskWithRequest:[ServiceURLs exhibitorsDataRequest] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
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
            
//            NSLog(@"---------------- no.of Exhibitors is %lu", (unsigned long)[exhibitorsList count]);
            
            //Caching data in DB
            [[ExhibitorDAO new] addExhibitors:exhibitorsList];
        }
        
    }];
    [dataTask resume];
    
}

+(void)fetchImageWithURL: (NSString *) imageURL andRefreshImageView: (UIImageView *) imageView{
 
    
    if (sessionManager == NULL) {
        sessionManager = [AFHTTPSessionManager manager];
        sessionManager.responseSerializer  = [[AFImageResponseSerializer alloc] init];
    }
    
    
    [sessionManager GET:imageURL parameters:nil progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"Image data: %@", responseObject);
        
        UIImage* img = (UIImage*) responseObject;
        
        //Caching the image in the database
        [[ImageDAO new] addImage:[[ImageDTO alloc] initWithImageURL:imageURL image:UIImagePNGRepresentation(img)]];
        [imageView setImage:img];
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

+(NSDictionary *)registerSessionWithID:(NSInteger)sessionId{
    __block NSDictionary *result;
    NSURLSessionDataTask * dataTask = [sessionManager dataTaskWithRequest:[ServiceURLs requestRegisterToSessionWithID:sessionId] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            result = [[responseObject objectForKey:@"result"] objectAtIndex:0];
        }
        
    }];
    [dataTask resume];
    return result;
}

@end
