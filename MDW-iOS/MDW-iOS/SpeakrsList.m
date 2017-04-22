//
//  SpeakrsList.m
//  MDW-iOS
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakrsList.h"
#import "SWRevealViewController.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "ImageDTO.h"
#import "ImageDAO.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "SpeakerDTO.h"
#import "SpeakerDAO.h"
#import "NameFormatter.h"
#import "SpeakerDetailsViewController.h"




@interface SpeakrsList ()
{
    
    
    NSArray *speakers;
    UIRefreshControl *refreshControl;
}


@end

@implementation SpeakrsList

- (void)viewDidLoad {
    [super viewDidLoad];
    self.MYTABLEVIEW.delegate=self;
    self.MYTABLEVIEW.dataSource=self;
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [self setTitle:@"MDW"];
   
    NSArray * dbSpeakers =  (NSArray *) [[SpeakerDAO new] getSpeakers];
    if (dbSpeakers) {
        speakers = dbSpeakers;
    }else{
        speakers=[[NSArray alloc] init];
    }
    
    refreshControl=[[UIRefreshControl alloc] init];
    //set background
    self.MYTABLEVIEW.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    //refresh table
    [refreshControl addTarget:self action:@selector(refreshMytableView) forControlEvents:UIControlEventValueChanged];
}



// reload the dataa
-(void) refreshMytableView
{
    [self.MYTABLEVIEW reloadData];
    [refreshControl endRefreshing];
    
}
//html label


-(NSAttributedString*) renderHTML:(NSString*) htmlString{
    
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    
    
    return attrStr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [speakers count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
   
    //getting session object
    SpeakerDTO * speaker = speakers[indexPath.row];
    
    //Getting refrences to the cell components
    UIImageView *img =[cell  viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    UILabel *description=[cell viewWithTag:3];
    
    
    //Setting the data
   NSString *fullName = [[[NameFormatter alloc] initWithFirstName:speaker.firstName middleName:speaker.middleName lastName:speaker.lastName] fullName];
    [name setText: fullName];
    [description setText:speaker.companyName];
    
    
    [img SetwithImageInURL:speaker.imageURL andPlaceholder:@"speaker.png"];
    
    
    
   
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SpeakerDetailsViewController *speakerDetailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"speakerDetails"];
    speakerDetailsViewController.speaker = speakers[indexPath.row];
    [self.navigationController pushViewController:speakerDetailsViewController animated:YES];
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
