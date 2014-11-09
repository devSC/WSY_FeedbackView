//
//  WSYFeedbackCell.h
//  WSY_FeedBack
//
//  Created by 袁仕崇 on 14/11/9.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSYFeedbackCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;

@end
