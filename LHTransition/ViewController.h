//
//  ViewController.h
//  LHTransition
//
//  Created by Apple on 17/2/7.
//  Copyright © 2017年 Linitial. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

