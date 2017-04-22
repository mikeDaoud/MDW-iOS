//
//  SpeakerDetailsViewController.h
//  MDW-iOS
//
//  Created by Aya on 4/21/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeakerDTO.h"

@interface SpeakerDetailsViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *speakerImageView;
@property (strong, nonatomic) IBOutlet UILabel *speakerName;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property SpeakerDTO *speaker;

@end
