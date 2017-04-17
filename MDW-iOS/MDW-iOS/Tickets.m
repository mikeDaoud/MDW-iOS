//
//  Tickets.m
//  MDW-iOS
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "Tickets.h"
#import "Attendee.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "NameFormatter.h"
#import "WebServiceDataFetching.h"
#import "ZXBitMatrix.h"
#import "ZXMultiFormatWriter.h"
#import "ZXImage.h"

@interface Tickets ()

@end

@implementation Tickets

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data=[defaults objectForKey:@"userData"];
    Attendee *out=[NSKeyedUnarchiver unarchiveObjectWithData:data];
    NSString *code=out.code;
    [_img setImage:[[UIImage alloc]initWithCGImage:[self encodeQRCode:code]]];
    
  
    
}
-(CGImageRef)encodeQRCode: (NSString*) encodedData{
    
    //    encodedData = @"BEGIN:VCARD\nVERSION:3.0\nN:lastname;firstname\nFN:firstname lastname\nORG:organization\nTITLE:jobtitle\nADR:;;street;city;state;zipcode;country\nTEL;WORK;VOICE:0101671542\nTEL;CELL:mobilenum\nTEL;FAX:fax\nEMAIL;WORK;INTERNET:emailaddresss\nURL:website\nEND:VCARD";
    
    
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
        
        // This CGImageRef image can be placed in a UIImage, NSImage, or written to a file.
    }
    return image;
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
