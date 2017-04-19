//
//  Exhibitors.h
//  MDW-iOS
//
//  Created by JETS on 4/17/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Exhibitors : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barbutton;

@end
