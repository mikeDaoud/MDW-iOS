//
//  SignInViewController.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SignInViewController.h"
#import <AFNetworking.h>
#import "ServiceURLs.h"
#import "SWRevealViewController.h"
#import "Attendee.h"
#import "WebServiceDataFetching.h"

@interface SignInViewController ()

@property NSURLSessionConfiguration * config;
@property AFURLSessionManager * mgr;

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Instantiation configuration and session objects.
    _config = [NSURLSessionConfiguration defaultSessionConfiguration];
    _mgr = [[AFURLSessionManager alloc]initWithSessionConfiguration:_config];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


//Disabling Autorotaion in the view
-(BOOL)shouldAutorotate{
    return NO;
}

- (IBAction)OpenRegistrationForm:(id)sender {
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"http://mobiledeveloperweekend.net/attendee/registration.htm"]];
}


- (IBAction)signIn:(id)sender {
    
    NSString * email = _userEmail.text;
    NSString * password = _userPassword.text;
    
        //Starting the login request
        NSURLSessionDataTask *dataTask = [_mgr dataTaskWithRequest:[ServiceURLs loginRequestWithUserEmail:email andPassword:password] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Failed to login" message:@"Problems with connection" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles: nil];
                [alert show];
    
            } else { //Login Success
                NSLog(@"%@ ----  %@", response, responseObject);
                
                //Storing user data in NSUserDefaults
                NSDictionary * result = [responseObject objectForKey:@"result"];
                Attendee * userData = [[Attendee alloc] initWithFirstName:[result objectForKey:@"firstName"]
                                                               middleName:[result objectForKey:@"middleName"]
                                                               lastName:[result objectForKey:@"lastName"]
                                                               title:[result objectForKey:@"title"]
                                                               companyName:[result objectForKey:@"companyName"]
                                                               email:[result objectForKey:@"email"]
                                                               mobile:nil
                                                               imageURL:[result objectForKey:@"imageURL"]
                                                               code:[result objectForKey:@"code"]];
                [userData printObjectData];
                
                NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:userData] forKey:@"userData"];
                [defaults setObject:email forKey:@"userEmail"];
                [defaults setObject:@"yes" forKey:@"signedIn"];
                [defaults synchronize];
                
                //Going to the Home view
                SWRevealViewController * mainView = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
                
                [self presentViewController:mainView animated:YES completion:^{
                    //TODO: dealloc view controller
                    
                }];
                
                //Getting Sessions, speakers and exhibitors data and adding it to database
                [WebServiceDataFetching fetchSessionsFromWebServicewithSessionManager:_mgr];
                [WebServiceDataFetching fetchSpeakersFromWebServicewithSessionManager:_mgr];
                [WebServiceDataFetching fetchExhibitorsFromWebServicewithSessionManager:_mgr];
                [WebServiceDataFetching fetchImageWithURL:@"http://www.mobiledeveloperweekend.net/service/speakerImage?id=20624" andRefreshImageView:nil];
                
                
            }
        }];
        [dataTask resume];
    
}
@end
