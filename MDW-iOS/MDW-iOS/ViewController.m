//
//  ViewController.m
//  MDW-iOS
//
//  Created by Michael on 4/8/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)getRequest:(id)sender {
    
    NSURLSessionConfiguration * config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager * mgr = [[AFURLSessionManager alloc]initWithSessionConfiguration:config];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://jets.iti.gov.eg/FriendsApp/services/user/register?name=Mohamed&phone=01063109808"]];
    
    NSURLSessionDataTask *dataTask = [mgr dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ ----  %@", response, responseObject);

            NSDictionary * s = (NSDictionary *)responseObject;
            
            
            [_show setText: [s valueForKey:@"result"]];
            
        }
    }];
    [dataTask resume];
}
@end
