//
//  SessionDetailsViewController.m
//  MDW-iOS
//
//  Created by Aya on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SessionDetailsViewController.h"
#import "DateConverter.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "NameFormatter.h"
#import "SharedObjects.h"
#import "ServiceURLs.h"
#import "SessionDAO.h"

@interface SessionDetailsViewController () {
    
    NSDictionary<NSNumber*, NSString*> *sessionStatusImage;
}

@end

@implementation SessionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    sessionStatusImage = @{
                           [NSNumber numberWithInt:0] : @"sessionnotadded.png",
                           [NSNumber numberWithInt:1] : @"sessionpending.png",
                           [NSNumber numberWithInt:2] : @"sessionapproved.png"
                           };
    
    self.scrollView.bounces = NO;
    
    _sessionDescriptionWebView.scrollView.scrollEnabled = NO;
    _sessionDescriptionWebView.scrollView.bounces = NO;
    _sessionDescriptionWebView.delegate = self;
    
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithData:[_session.name dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    NSMutableAttributedString *newString = [[NSMutableAttributedString alloc] initWithAttributedString:attributedString];
    NSRange range = (NSRange){0,[newString length]};
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    [newString enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIFont *replacementFont =  [UIFont systemFontOfSize:25];
        [newString addAttribute:NSFontAttributeName value:replacementFont range:range];
        [newString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    }];
    _sessionName.attributedText = newString;
    
    // Make session name text view fits its content
    [self resizeTextView:_sessionName];
    
    CGRect frame = _viewHolder.frame;
    frame.origin.y = _sessionName.frame.origin.y + _sessionName.frame.size.height + 3;
    _viewHolder.frame = frame;
    
    _sessionDate.text = [DateConverter dateStringFromDate:_session.date];
    _sessionTime.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate:_session.startDate], [DateConverter stringFromDate:_session.endDate]];
    _sessionLocation.text = _session.location;
    _sessionStatusImageView.image = [UIImage imageNamed:[sessionStatusImage objectForKey:[NSNumber numberWithInt:_session.status]]];
    [_sessionDescriptionWebView loadHTMLString:_session.sessionDescription baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL] options:@{} completionHandler:nil];
        return NO;
    }
    return YES;
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    // Make web view fits its content
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    if (fittingSize.height == 8) {
        fittingSize.height = 40;
    }
    frame.size = fittingSize;
    webView.frame = frame;
    
    if (_session.speakers.count > 0) {
        // Add Speakers UILabel to scroll view
        frame.size.height = frame.size.height + 8;
        UILabel *speakersLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height, 71, 21)];
        speakersLabel.text = @"Speakers";
        [_viewHolder addSubview:speakersLabel];
        
        for (SpeakerDTO *speaker in _session.speakers) {
            // Add Speaker UIImageView to scroll view
            frame.size.height = frame.size.height + 35;
            UIImageView *speakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, frame.origin.y + frame.size.height, 40, 40)];
            [speakerImageView SetwithImageInURL:speaker.imageURL andPlaceholder:@"speaker.png"];
            [_viewHolder addSubview:speakerImageView];
            
            // Add Speaker's name UILabel to scroll view
            UILabel *speakerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, frame.origin.y + frame.size.height, 203, 21)];
            speakerNameLabel.text = [[[NameFormatter alloc] initWithFirstName:speaker.firstName middleName:speaker.middleName lastName:speaker.lastName] fullName];
            [_viewHolder addSubview:speakerNameLabel];
            
            // Add Speaker company name UILabel to scroll view
            frame.size.height = frame.size.height + 20;
            UITextView *speakerCompanyName = [[UITextView alloc] initWithFrame:CGRectMake(81, frame.origin.y + frame.size.height, 203, 21)];
            speakerCompanyName.text = speaker.companyName;
            speakerCompanyName.textColor = [UIColor lightGrayColor];
            speakerCompanyName.font = [UIFont systemFontOfSize:13];
            speakerCompanyName.editable = NO;
            speakerCompanyName.scrollEnabled = NO;
            speakerCompanyName.backgroundColor = [UIColor clearColor];
            // Make speaker's company name text view fits its content
            [self resizeTextView:speakerCompanyName];
            [_viewHolder addSubview:speakerCompanyName];
        }
    }
    
    // Make view holder fits its content
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.viewHolder.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    frame = _viewHolder.frame;
    frame.size.height = contentRect.size.height;
    _viewHolder.frame = frame;
    
    // Make scroll View fits its content
    contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    [self.scrollView setContentSize:CGSizeMake(288, contentRect.size.height)];
}

-(void)resizeTextView:(UITextView *)textView{
    // Make text view fits its content
    CGRect frame = textView.frame;
    frame.size.height = 1;
    textView.frame = frame;
    CGSize fittingSize = [textView sizeThatFits:frame.size];
    frame.size.height = fittingSize.height;
    textView.frame = frame;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onStatusImageViewTapAction:(id)sender {
    NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs requestRegisterToSessionWithID:_session.sessionId enforce:@"false" status:_session.status] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error : %@", error);
        } else {
            NSDictionary *result = [responseObject objectForKey:@"result"];
            
            // Check there is no session registered at the same time
            if ([[result objectForKey:@"oldSessionId"] intValue] == 0) {
                [self updateSessionStatus:[[result objectForKey:@"status"] intValue]];
            }
            else {
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"You are already registered in another session at the same time" preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *replaceAction = [UIAlertAction actionWithTitle:@"Replace" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
                    
                    NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs requestRegisterToSessionWithID:_session.sessionId enforce:@"true" status:NOT_ADDED] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                        
                        [self updateSessionStatus:[[[responseObject objectForKey:@"result"] objectForKey:@"status"] intValue]];
                    }];
                    
                    [dataTask resume];
                }];
                
                UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:nil];
                
                [alert addAction:replaceAction];
                [alert addAction:ignoreAction];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
    [dataTask resume];
}

-(void)updateSessionStatus:(int)status {
    
    // Update session status in Database
    [[SessionDAO new] updateSessionUserStatus:_session status:status];
    
    // Update session status in View
    _sessionStatusImageView.image = [UIImage imageNamed:[sessionStatusImage objectForKey:[NSNumber numberWithInteger:status]]];
}

@end
