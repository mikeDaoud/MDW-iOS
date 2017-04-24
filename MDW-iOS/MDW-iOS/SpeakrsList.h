//
//  SpeakrsList.h
//  MDW-iOS
//
//  Created by JETS on 4/16/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableReloadDelegate.h"

@interface SpeakrsList : UIViewController<UITableViewDataSource,UITableViewDelegate, TableReloadDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MYTABLEVIEW;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end
