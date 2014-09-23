//
//  NotiView.h
//  MaoBoLi
//
//  Created by Mac_PC on 14-8-29.
//  Copyright (c) 2014年 H0meDev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXBlurView.h"
#import "UIImage+ImageEffects.h"


@interface NotiView : UIView<UITableViewDelegate,UITableViewDataSource>{
  
}
@property (weak, nonatomic) IBOutlet UIView *headView;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *FootView;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) UIImage *imagehehe;
@property (strong, nonatomic) UIImageView *imageView;
- (IBAction)ClickButtton:(id)sender;

@end
