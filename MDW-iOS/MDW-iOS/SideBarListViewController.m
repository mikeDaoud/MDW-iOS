//
//  SideBarListViewController.m
//  MDW-iOS
//
//  Created by JETS on 4/13/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SideBarListViewController.h"
#import "SWRevealViewController.h"
#import "ImageDAO.h"
#import "ExhibitorDAO.h"
#import "SpeakerDAO.h"
#import "SessionDAO.h"

@interface SideBarListViewController ()

@end

@implementation SideBarListViewController
{
    NSArray *menue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableview.delegate=self;
    self.mytableview.dataSource=self;
    
    menue=@[@"Agenda",@"My Agenda",@"Speakers",@"Exhibitors",@"Profile",@"Log Out",@"fotter"];
    self.mytableview.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"leftSideMenuBackground.png"]];
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
    return [menue count] ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellident=[menue objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellident forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.row == 5) {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Log Out" message:@"Are you sure you want to logout?" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[[UIApplication sharedApplication] keyWindow].rootViewController dismissViewControllerAnimated:YES completion:nil];
            
            NSLog(@"Logged Out");
            
            [[ImageDAO new] deleteImages];
            [[ExhibitorDAO new] deleteExhibitors];
            [[SpeakerDAO new] deleteSpeakers];
            [[SessionDAO new] deleteSessions];
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            [defaults removeObjectForKey:@"userData"];
            [defaults setObject:@"no" forKey:@"signedIn"];
            [defaults synchronize];
            
        }]];
        
        [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
        
        //TODO: Show confirmation message to user and transfer the code below into the OK button Action
        
        

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue isKindOfClass:[SWRevealViewControllerSegueSetController class]])
    {
        UIViewController *dvc = [segue destinationViewController];
        
        UINavigationController *navCtrl = (UINavigationController *) self.revealViewController.frontViewController;
        
        [navCtrl setViewControllers:@[dvc] animated:NO];
        
        [self.revealViewController setFrontViewPosition:FrontViewPositionLeft animated:YES];
        
    }
}


@end
