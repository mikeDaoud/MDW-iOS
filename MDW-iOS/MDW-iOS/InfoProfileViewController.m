//
//  InfoProfileViewController.m
//  MDW-iOS
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "InfoProfileViewController.h"
#import "Attendee.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "NameFormatter.h"
#import "WebServiceDataFetching.h"

@interface InfoProfileViewController ()

@end

@implementation InfoProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data=[defaults objectForKey:@"userData"];
    Attendee *out=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@ %@",out.firstName,out.middleName,out.lastName];
    [_name setText: fullName];
    [_pos setText:out.title];
    [_img SetwithImageInURL:out.imageURL andPlaceholder:@"profile.png"];
    [_company setText:out.companyName];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [self setTitle:@"MDW"];
    

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

@end
