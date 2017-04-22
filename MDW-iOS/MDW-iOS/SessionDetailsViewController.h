//
//  SessionDetailsViewController.h
//  MDW-iOS
//
//  Created by Aya on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "ViewController.h"
#import "SessionDTO.h"

@interface SessionDetailsViewController : ViewController <UIWebViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property SessionDTO *session;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITextView *sessionName;

@property (strong, nonatomic) IBOutlet UIView *viewHolder;
@property (strong, nonatomic) IBOutlet UILabel *sessionDate;
@property (strong, nonatomic) IBOutlet UILabel *sessionTime;

@property (strong, nonatomic) IBOutlet UIImageView *sessionStatusImageView;
@property (strong, nonatomic) IBOutlet UILabel *sessionLocation;
@property (strong, nonatomic) IBOutlet UIWebView *sessionDescriptionWebView;

- (IBAction)onStatusImageViewTapAction:(id)sender;

@end
