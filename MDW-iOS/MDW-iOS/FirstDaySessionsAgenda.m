//
//  FirstDaySessionsAgenda.m
//  MDW-iOS
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "FirstDaySessionsAgenda.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "ImageDTO.h"
#import "ImageDAO.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "SessionDAO.h"
#import "SessionDTO.h"
#import "DateConverter.h"
#import "AgendaDays.h"
#import "SessionTypes.h"
#import "SessionDetailsViewController.h"
#import "WebServiceDataFetching.h"

@interface FirstDaySessionsAgenda ()
{
    
    NSArray *sessions;
    UIRefreshControl *refreshControl;
}

@end

@implementation FirstDaySessionsAgenda

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableview.delegate=self;
    self.mytableview.dataSource=self;
    
    NSArray * dbSessions =  (NSArray *) [[SessionDAO new] getSessionsByDate:DAY_ONE];
    
    if (dbSessions) {
        sessions = dbSessions;
    }else{
        sessions=[[NSArray alloc] init];
    }
    refreshControl=[[UIRefreshControl alloc] init];
    NSAttributedString *title=[[NSAttributedString alloc]initWithString:@"Fetching data"];
    [refreshControl setAttributedTitle:title];
    [refreshControl setTintColor:[UIColor blackColor]];
    
    //set background
    self.mytableview.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    //refresh table
    [refreshControl addTarget:self action:@selector(refreshMytableView) forControlEvents:UIControlEventValueChanged];
    
    [self.mytableview  addSubview:refreshControl];
    
}


// reload the dataa
-(void) refreshMytableView
{
    [WebServiceDataFetching fetchSessionsFromWebServiceAndUpdateTable:self];
    
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%lu",(unsigned long)[sessions count]);
    return [sessions count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    
    
    
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    //getting session object
    SessionDTO * session = sessions[indexPath.row];
    
    //Getting refrences to the cell components
    UIImageView *img =[cell  viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    UILabel *t2=[cell viewWithTag:3];
    UILabel *t3=[cell viewWithTag:4];
    UILabel *t4=[cell viewWithTag:5];
    
    //Setting the data
    name.attributedText = [self renderHTML:session.name];
    [t2 setText:session.location];
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:session.startDate],
                       [DateConverter stringFromDate:session.endDate]];
    [t3 setText:date];
    
    
    
    
    NSLog(@"================================%@", session.sessionType);
    
    if ([session.sessionType isEqualToString:@"Session"]) {
        [img setImage:[UIImage imageNamed:@"session.png"]];
        [t4 setText:[DateConverter dayStringFromDate:session.date]];
        // ADD the date to the label on the image [DateConverter dayStringFromDate:session.date];
    }else if ([session.sessionType isEqualToString:@"Workshop"]){
        [img setImage:[UIImage imageNamed:@"workshop.png"]];
        // ADD the date to the label on the image
        [t4 setText:[DateConverter dayStringFromDate:session.date]];
    }else if ([session.sessionType isEqualToString:@"Break"]){
        [img setImage:[UIImage imageNamed:@"breakicon.png"]];
        [t4 setText:@" "];
    }else if ([session.sessionType isEqualToString:@"Hackathon"]){
        [img setImage:[UIImage imageNamed:@"hacathon.png"]];
        // ADD the date to the label on the image
        [t4 setText:[DateConverter dayStringFromDate:session.date]];
    }
    
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SessionDetailsViewController *sessionDetailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"sessionDetails"];
    sessionDetailsViewController.session = sessions[indexPath.row];
    sessionDetailsViewController.tableReloadDelegate = self;
    [self.navigationController pushViewController:sessionDetailsViewController animated:YES];
}

-(void)reloadTableView{
    sessions =  (NSArray *) [[SessionDAO new] getSessionsByDate:DAY_ONE];
    [self.mytableview reloadData];
    [refreshControl endRefreshing];
}

-(void)showErrorMsgWithText:(NSString *)msg{
    
    [refreshControl endRefreshing];
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Failed to Load Data" message:msg delegate:nil cancelButtonTitle:@"Retry" otherButtonTitles: nil];
    [alert show];
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
