//
//  UIImageView+UIImageView_CashingWebImage.m
//  MDW-iOS
//
//  Created by Michael on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "UIImageView+UIImageView_CashingWebImage.h"
#import "WebServiceDataFetching.h"

@implementation UIImageView (UIImageView_CashingWebImage)

-(void)SetwithImageInURL:(NSString *) imageURL andPlaceholder:(NSString *) placeholderName{
    //First set the image view with the placeholder image
    [self setImage:[UIImage imageNamed:placeholderName]];
    
    //Try to retrieve image from Database First
    // If exists, then add it to the UIImageView [self setImage: UIImageObjectFromDatabase]
    // If doesn't exist then call the following method to download the image, add it to the database and set it in the view
    [WebServiceDataFetching fetchImageWithURL:imageURL andRefreshImageView:self];
}

@end
