//
//  TableReloadDelegate.h
//  MDW-iOS
//
//  Created by Michael on 4/18/17.
//  Copyright © 2017 MAD. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TableReloadDelegate <NSObject>

-(void) refreshMytableView;

-(void)reloadTableView;

-(void)showErrorMsgWithText: (NSString *) msg;

//1. add the newData into the array holding the session or speakers or exhibitors
//2. reload table data

@end
