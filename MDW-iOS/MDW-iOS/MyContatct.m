//
//  MyContatct.m
//  MDW-iOS
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "MyContatct.h"
#import "Attendee.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "NameFormatter.h"
#import "WebServiceDataFetching.h"
#import "ZXBitMatrix.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"

@interface MyContatct ()

@end

@implementation MyContatct

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data=[defaults objectForKey:@"userData"];
    Attendee *out=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    NSString *phone = [NSString stringWithFormat:@"%@ %@",@" ",out.mobile];
    NSString *email = [NSString stringWithFormat:@"%@ %@",@" ",out.email];

    [_phone setText:phone];
    [_email setText:email];
 

    NSString *encodedData=[ NSString stringWithFormat:@"BEGIN:VCARD\nVERSION:3.0\nN:%@;%@\nFN:\nORG:%@\nTITLE:%@\nTEL;CELL:%@\nEMAIL;WORK;INTERNET:%@\nURL:\nEND:VCARD", out.firstName, out.lastName, out.companyName, out.title, out.mobile, out.email];
    
    NSError *error = nil;
    CGImageRef image = nil;
    ZXMultiFormatWriter *writer = [ZXMultiFormatWriter writer];
    ZXBitMatrix* result = [writer encode:encodedData
                                  format:kBarcodeFormatQRCode
                                   width:500
                                  height:500
                                   error:&error];
    if (result) {
        image = [[ZXImage imageWithMatrix:result] cgimage];
        
         [_img setImage:[[UIImage alloc]initWithCGImage:image]];
    }
    
    
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
