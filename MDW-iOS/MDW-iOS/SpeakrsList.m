//
//  SpeakrsList.m
//  MDW-iOS
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import "SpeakrsList.h"
#import "SWRevealViewController.h"

@interface SpeakrsList ()
{
    
    
    NSMutableArray *sessions;
    UIRefreshControl *refreshControl;
}


@end

@implementation SpeakrsList

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.MYTABLEVIEW.delegate=self;
    self.MYTABLEVIEW.dataSource=self;
    _barButton.target=self.revealViewController;
    _barButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]}];
    [self setTitle:@"MDW"];
   
    
    sessions=[[NSMutableArray alloc] init];
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
    //return [sessions count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"forIndexPath:indexPath];
    
    // Configure the cell...
    [cell setBackgroundColor: [UIColor clearColor]];
    
    UIImageView *img =[cell  viewWithTag:1] ;
    [img setImage:[UIImage imageNamed:@"speaker.png"]];
    UILabel * name = [cell viewWithTag:2];
    name.attributedText = [self renderHTML:@"<b>Name</b>"];
    UILabel *t2=[cell viewWithTag:3];
    [t2 setText:@"byee"];
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
