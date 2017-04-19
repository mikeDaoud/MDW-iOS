//
//  Exhibitors.m
//  MDW-iOS
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "Exhibitors.h"
#import "SWRevealViewController.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "ImageDTO.h"
#import "ImageDAO.h"
#import "UIImageView+UIImageView_CashingWebImage.h"
#import "ExhibitorDAO.h"
#import "ExhibitorDTO.h"


@interface Exhibitors ()
{
    
    
    NSArray *exhibitors;
    UIRefreshControl *refreshControl;
}

@end

@implementation Exhibitors


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mytableview.delegate=self;
    self.mytableview.dataSource=self;
    _barbutton.target=self.revealViewController;
    _barbutton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [self setTitle:@"MDW"];
    
    NSArray * dbExhibitors =  (NSArray *) [[ExhibitorDAO new] getExhibitors];
    if (dbExhibitors) {
        exhibitors = dbExhibitors;
    }else{
        exhibitors=[[NSArray alloc] init];
    }
    refreshControl=[[UIRefreshControl alloc] init];
    //set background
    self.mytableview.backgroundView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background.png"]];
    //refresh table
    [refreshControl addTarget:self action:@selector(refreshMytableView) forControlEvents:UIControlEventValueChanged];
   
}

// reload the dataa
-(void) refreshMytableView
{
    [self.mytableview reloadData];
    [refreshControl endRefreshing];
    
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
    
    return [exhibitors count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    
    //getting Exhibitor object
    ExhibitorDTO * exhibitor = exhibitors[indexPath.row];
    
    //Getting refrences to the cell components
    UIImageView *img =[cell  viewWithTag:1];
    UILabel * name = [cell viewWithTag:2];
    
    //Setting the data
  //  NSString *fullName = [NSString stringWithFormat:@"%@ %@ %@",speaker.firstName,speaker.middleName,speaker.lastName];
    [name setText: exhibitor.companyName];

    
    [img SetwithImageInURL:exhibitor.imageURL andPlaceholder:@"speaker.png"];
    
    return cell;
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
