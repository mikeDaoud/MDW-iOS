//
//  SpeakerDetailsViewController.m
//  MDW-iOS
//
//  Created by Aya on 4/21/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakerDetailsViewController.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "NameFormatter.h"

@interface SpeakerDetailsViewController ()

@end

@implementation SpeakerDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_speakerImageView SetwithImageInURL:_speaker.imageURL andPlaceholder:@"speaker.png"];
    [_speakerImageView.layer setBorderColor:[[UIColor orangeColor] CGColor]];
    [_speakerImageView.layer setBorderWidth: 2.0];
    _speakerName.text = [[[NameFormatter alloc] initWithFirstName:_speaker.firstName middleName:_speaker.middleName lastName:_speaker.lastName] fullName];
    
    UITextView *speakerTitle = [[UITextView alloc] initWithFrame:CGRectMake(0, _speakerName.frame.origin.y + _speakerName.frame.size.height, 288, 20)];
    speakerTitle.editable = NO;
    speakerTitle.scrollEnabled = NO;
    speakerTitle.backgroundColor = [UIColor clearColor];
    speakerTitle.text = _speaker.title;
    speakerTitle.textAlignment = 1;
    [self resizeTextView:speakerTitle];
    [_scrollView addSubview:speakerTitle];
    
    UITextView *speakerCompanyName = [[UITextView alloc] initWithFrame:CGRectMake(0, speakerTitle.frame.origin.y + speakerTitle.frame.size.height - 10, 288, 20)];
    speakerCompanyName.editable = NO;
    speakerCompanyName.scrollEnabled = NO;
    speakerCompanyName.backgroundColor = [UIColor clearColor];
    speakerCompanyName.font = [UIFont systemFontOfSize:15];
    speakerCompanyName.text = _speaker.companyName;
    speakerCompanyName.textAlignment = 1;
    [self resizeTextView:speakerCompanyName];
    [_scrollView addSubview:speakerCompanyName];
    
    UIView *spearatorView = [[UIView alloc] initWithFrame:CGRectMake(0, speakerCompanyName.frame.origin.y + speakerCompanyName.frame.size.height, 288, 1)];
    spearatorView.backgroundColor = [UIColor lightGrayColor];
    [_scrollView addSubview:spearatorView];
    
    UIWebView *speakerBiography = [[UIWebView alloc] initWithFrame:CGRectMake(0, spearatorView.frame.origin.y + spearatorView.frame.size.height + 5, 288, 40)];
    speakerBiography.scrollView.scrollEnabled = NO;
    speakerBiography.scrollView.bounces = NO;
    speakerBiography.delegate = self;
    [speakerBiography loadHTMLString:[NSString stringWithFormat:@"<div align='center'>%@<div>", _speaker.biography] baseURL:nil];
    [_scrollView addSubview:speakerBiography];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    // Make web view fits its content
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    // Make scroll View fits its content
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    [self.scrollView setContentSize:CGSizeMake(288, contentRect.size.height)];
}

-(void)resizeTextView:(UITextView *)textView {
    // Make text view fits its content
    CGRect frame = textView.frame;
    frame.size.height = 1;
    textView.frame = frame;
    CGSize fittingSize = [textView sizeThatFits:frame.size];
    frame.size.height = fittingSize.height;
    textView.frame = frame;
}

@end
