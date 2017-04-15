//
//  AllSessionsAgenda.m
//  MDW-iOS
//
//  Created by JETS on 4/14/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "AllSessionsAgenda.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "ImageDTO.h"
#import "ImageDAO.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "SessionDAO.h"
#import "SessionDTO.h"
#import "DateConverter.h"
#import "AgendaDays.h"
#import "SessionTypes.h"


@interface AllSessionsAgenda ()
{
    NSArray *sessions;
    UIRefreshControl *refreshControl;
}

@end

@implementation AllSessionsAgenda

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSArray * dbSessions =  (NSArray *) [[SessionDAO new] getSessionsByDate:[AgendaDays dateToAgendaDay:DAY_ONE]];
    NSArray * dbSessions =  (NSArray *) [[SessionDAO new] getAllSessions];
    if (dbSessions) {
        sessions = dbSessions;
    }else{
        sessions=[[NSArray alloc] init];
    }
    
     refreshControl=[[UIRefreshControl alloc] init];
    //set background
        self.tableView.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    //refresh table
        [refreshControl addTarget:self action:@selector(refreshMytableView) forControlEvents:UIControlEventValueChanged];
}

// reload the dataa
-(void) refreshMytableView
{
    [self.tableView reloadData];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

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
    
    //Setting the data
    name.attributedText = [self renderHTML:session.name];
    [t2 setText:session.location];
    NSString * date = [NSString stringWithFormat:@"%@ - %@",
                       [DateConverter stringFromDate:session.startDate],
                       [DateConverter stringFromDate:session.endDate]];
    [t3 setText:date];
    
    
//    [img setImage:[UIImage imageNamed:@"firstDay.png"]];
    [img SetwithImageInURL:@"http://www.mobiledeveloperweekend.net/service/speakerImage?id=20605" andPlaceholder:@"firstDay.png"];
    
    NSLog(@"================================%@", session.sessionType);
    
    if ([session.sessionType isEqualToString:@"Session"]) {
        [img setImage:[UIImage imageNamed:@"session.png"]];
        // ADD the date to the label on the image [DateConverter dayStringFromDate:session.date];
    }else if ([session.sessionType isEqualToString:@"Workshop"]){
        [img setImage:[UIImage imageNamed:@"workshop.png"]];
        // ADD the date to the label on the image
    }else if ([session.sessionType isEqualToString:@"Break"]){
        [img setImage:[UIImage imageNamed:@"breakicon.png"]];
    }else if ([session.sessionType isEqualToString:@"Hackathon"]){
        [img setImage:[UIImage imageNamed:@"hacathon.png"]];
        // ADD the date to the label on the image
    }
    
    
    
    return cell;
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
