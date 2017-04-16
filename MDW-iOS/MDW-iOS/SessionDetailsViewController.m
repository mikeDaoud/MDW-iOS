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
#import "WebServiceDataFetching.h"
#import "SessionDAO.h"

@interface SessionDetailsViewController ()

@end

@implementation SessionDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    _sessionDate.text = [DateConverter dateStringFromDate:_session.date];
    _sessionTime.text = [NSString stringWithFormat:@"%@ - %@", [DateConverter stringFromDate:_session.startDate], [DateConverter stringFromDate:_session.endDate]];
    _sessionLocation.text = _session.location;
    [_sessionDescriptionWebView loadHTMLString:_session.sessionDescription baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        [_scrollView addSubview:speakersLabel];
        
        for (SpeakerDTO *speaker in _session.speakers) {
            // Add Speaker UIImageView to scroll view
            frame.size.height = frame.size.height + 35;
            UIImageView *speakerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, frame.origin.y + frame.size.height, 40, 40)];
            [speakerImageView SetwithImageInURL:speaker.imageURL andPlaceholder:@"speaker.png"];
            [_scrollView addSubview:speakerImageView];
            
            // Add Speaker's name UILabel to scroll view
            UILabel *speakerNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, frame.origin.y + frame.size.height, 203, 21)];
            speakerNameLabel.text = [[[NameFormatter alloc] initWithFirstName:speaker.firstName middleName:speaker.middleName lastName:speaker.lastName] fullName];
            [_scrollView addSubview:speakerNameLabel];
            
            // Add Speaker company name UILabel to scroll view
            frame.size.height = frame.size.height + 20;
            UILabel *speakerCompanyName = [[UILabel alloc] initWithFrame:CGRectMake(85, frame.origin.y + frame.size.height, 203, 21)];
            speakerCompanyName.text = speaker.companyName;
            speakerCompanyName.textColor = [UIColor lightGrayColor];
            speakerCompanyName.font = [UIFont systemFontOfSize:13];
            [_scrollView addSubview:speakerCompanyName];
        }
    }
    
    // Make scroll View fits its content
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    [self.scrollView setContentSize:CGSizeMake(288, contentRect.size.height)];
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
    if (_session.status != NOT_ADDED) {
        _sessionStatusImageView.image = [UIImage imageNamed:@"sessionnotadded.png"];
    }
    else {
        NSDictionary *result = [WebServiceDataFetching registerSessionWithID:_session.sessionId];
        if ([result objectForKey:@"oldSessionId"] == 0) {
            _session.status = [[result objectForKey:@"status"] intValue];
            [[SessionDAO new] updateSessionUserStatus:_session];
            if (_session.status == PENDING) {
                _sessionStatusImageView.image = [UIImage imageNamed:@"sessionpending.png"];
            }
            else {
                _sessionStatusImageView.image = [UIImage imageNamed:@"sessionapproved.png"];
            }
        }
        else {
            // Show Alert...
        }
    }
}

@end
