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
#import "SharedObjects.h"

@interface SignInViewController ()

@property UIActivityIndicatorView * indicator;


@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Instantiation configuration and session objects.
    
//    _userEmail.rightViewMode = UITextFieldViewModeAlways;
    
    NSString * useremail = [[NSUserDefaults standardUserDefaults]objectForKey:@"userEmail"];
    
    if (useremail) {
        _userEmail.text = useremail;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{

    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
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
    
    [_indicator startAnimating];
    
        //Starting the login request
        NSURLSessionDataTask *dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs loginRequestWithUserEmail:email andPassword:password] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
            if (error) {
                NSLog(@"Error: %@", error);
                
                [_indicator stopAnimating];
                
                UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Failed to login" message:@"Problems with connection" delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles: nil];
                [alert show];
    
            } else {
                //Login Success
                _userPassword.text = @"";
                
                if ([[responseObject objectForKey:@"status"] isEqualToString:@"view.success"]) {
                    //Successfull login
                    //Storing user data in NSUserDefaults
                    NSDictionary * result = [responseObject objectForKey:@"result"];
                    Attendee * userData = [[Attendee alloc] initWithFirstName:[result objectForKey:@"firstName"]
                                                                   middleName:[result objectForKey:@"middleName"]
                                                                     lastName:[result objectForKey:@"lastName"]
                                                                        title:[result objectForKey:@"title"]
                                                                  companyName:[result objectForKey:@"companyName"]
                                                                        email:[result objectForKey:@"email"]
                                                                       mobile:[result objectForKey:@"mobiles"]
                                                                     imageURL:[result objectForKey:@"imageURL"]
                                                                         code:[result objectForKey:@"code"]];
                    
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
                    
                    [_indicator stopAnimating];
                    
                }else{
                    
                    [_indicator stopAnimating];
                    
                    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Failed to login" message:[responseObject objectForKey:@"result"] delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles: nil];
                    [alert show];
                    
                }
                
            }
        }];
        [dataTask resume];
    
}

//-(void)dealloc{
//    NSLog(@"deallocatoin the sign in view controller");
//}
@end
