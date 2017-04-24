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
#import "SpeakerDetailsViewController.h"

@interface SessionDetailsViewController () {
    
    NSDictionary<NSNumber*, NSString*> *sessionStatusImage;
    NSArray *speakers;
}

@property UIActivityIndicatorView * indicator;

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
    [_sessionDescriptionWebView loadHTMLString:[NSString stringWithFormat:@"<div align='center'>%@<div>", _session.sessionDescription] baseURL:nil];
    
    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _indicator.frame = CGRectMake(0.0, 0.0, 120.0, 120.0);
    [_indicator setBackgroundColor:[UIColor colorWithWhite:0.0f alpha:0.6f]];
    _indicator.center = self.view.center;
    [self.view addSubview:_indicator];
    [_indicator bringSubviewToFront:self.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL] ];
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
        
        speakers = (NSArray *)_session.speakers;
        frame.size.height = frame.size.height + 35;
        UITableView *speakersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, frame.origin.y + frame.size.height, 288, 50)];
        speakersTableView.backgroundColor = [UIColor clearColor];
        speakersTableView.scrollEnabled = NO;
        speakersTableView.bounces = NO;
        speakersTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        speakersTableView.dataSource = self;
        speakersTableView.delegate = self;
        
        // Make table view fits its content
        CGFloat tableHeight = 0.0f;
        for (int i = 0; i < [speakers count]; i ++) {
            tableHeight += [self tableView:speakersTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        }
        speakersTableView.frame = CGRectMake(speakersTableView.frame.origin.x, speakersTableView.frame.origin.y, speakersTableView.frame.size.width, tableHeight);
        
        [_viewHolder addSubview:speakersTableView];
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

-(void)resizeTextView:(UITextView *)textView {
    // Make text view fits its content
    CGRect frame = textView.frame;
    frame.size.height = 1;
    textView.frame = frame;
    CGSize fittingSize = [textView sizeThatFits:frame.size];
    frame.size.height = fittingSize.height;
    textView.frame = frame;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [speakers count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // Configure the cell...
    [cell.imageView SetwithImageInURL:[speakers[indexPath.row] imageURL] andPlaceholder:@"speaker.png"];
    cell.textLabel.text = [[[NameFormatter alloc] initWithFirstName:[speakers[indexPath.row] firstName] middleName:[speakers[indexPath.row] middleName] lastName:[speakers[indexPath.row] lastName]] fullName];
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.numberOfLines = 0;
    cell.detailTextLabel.text = [speakers[indexPath.row] companyName];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpeakerDetailsViewController *speakerDetailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"speakerDetails"];
    speakerDetailsViewController.speaker = speakers[indexPath.row];
    [self.navigationController pushViewController:speakerDetailsViewController animated:YES];
}

- (IBAction)onStatusImageViewTapAction:(id)sender {
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = TRUE;
    
    [_indicator startAnimating];
    
    NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs requestRegisterToSessionWithID:_session.sessionId enforce:@"false" status:_session.status] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error : %@", error);
        } else {
            
            if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
                
                NSDictionary *result = [responseObject objectForKey:@"result"];
                // Check there is no session registered at the same time
                if ([[result objectForKey:@"oldSessionId"] intValue] == 0) {
                    
                    [self updateSessionStatus:[[result objectForKey:@"status"] intValue]];
                    
                    [_indicator stopAnimating];
                    
                    [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                }
                else {
                    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Info" message:@"You are already registered in another session at the same time" preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction *replaceAction = [UIAlertAction actionWithTitle:@"Replace" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
                        
                        NSURLSessionDataTask * dataTask = [[SharedObjects sharedSessionManager] dataTaskWithRequest:[ServiceURLs requestRegisterToSessionWithID:_session.sessionId enforce:@"true" status:NOT_ADDED] completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                            
                            if ([[responseObject objectForKey:@"result"] isKindOfClass:[NSDictionary class]]) {
                                
                                [self updateSessionStatus:[[[responseObject objectForKey:@"result"] objectForKey:@"status"] intValue]];
                                
                                [_tableReloadDelegate refreshMytableView];
                                
                                [_tableReloadDelegate reloadTableView];
                                
                                [_indicator stopAnimating];
                                
                                [UIApplication sharedApplication].networkActivityIndicatorVisible = FALSE;
                            }
                            else {
                                [self showAlertForStatusError];
                            }
                        }];
                        
                        [dataTask resume];
                    }];
                    
                    UIAlertAction *ignoreAction = [UIAlertAction actionWithTitle:@"Ignore" style:UIAlertActionStyleDefault handler:nil];
                    
                    [alert addAction:replaceAction];
                    [alert addAction:ignoreAction];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }
            else {
                [self showAlertForStatusError];
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

-(void)showAlertForStatusError{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed to Register" message:@"Couldn't register to this session" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction* _Nonnull action) {
        
        [_tableReloadDelegate refreshMytableView];
        
        [_tableReloadDelegate reloadTableView];
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
