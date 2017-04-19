//
//  UIImageView+UIImageView_CashingWebImage.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "UIImageView+UIImageView_CashingWebImage.h"
#import "WebServiceDataFetching.h"
#import "ImageDAO.h"

@implementation UIImageView (UIImageView_CashingWebImage)

-(void)SetwithImageInURL:(NSString *) imageURL andPlaceholder:(NSString *) placeholderName{
    //First set the image view with the placeholder image
    [self setImage:[UIImage imageNamed:placeholderName]];
    
    ImageDAO * dao = [ImageDAO new];
    
    //Try to retrieve image from Database First
    ImageDTO * imgdata = [dao getImage:imageURL];
    
    NSLog(@"image data ------------- %@", imgdata);
    
    if (imgdata) {
        NSLog(@"the Image Exists =====================");
        [self setImage:[UIImage imageWithData:imgdata.image]];
    }else{
        NSLog(@"the Image Doesn't Exists =====================");

        [WebServiceDataFetching fetchImageWithURL:imageURL andRefreshImageView:self];
    }
    // If exists, then add it to the UIImageView [self setImage: UIImageObjectFromDatabase]
    // If doesn't exist then call the following method to download the image, add it to the database and set it in the view
    
}

@end
