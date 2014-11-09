//
//  ViewController.m
//  WSY_FeedBack
//
//  Created by 袁仕崇 on 14/11/9.
//  Copyright (c) 2014年 wilson. All rights reserved.
//

#import "ViewController.h"
#import "UMFeedback.h"
#import "WSYFeedbackController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *toolView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBar.translucent = NO;
    NSDictionary *visiableDicitonary = NSDictionaryOfVariableBindings(_tableView, _toolView);
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.toolView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_tableView]|" options:0 metrics:nil views:visiableDicitonary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]-100-|" options:0 metrics:nil views:visiableDicitonary]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[_toolView]|" options:0 metrics:nil views:visiableDicitonary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView][_toolView]|" options:0 metrics:nil views:visiableDicitonary]];
    
    [super viewDidLoad];
    //创建标题
    UILabel *header = [[UILabel alloc] init];
    header.text = @"欢迎来到我的世界!";
    header.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview: header];
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.text = @"准备就绪!";
    [self.view addSubview: statusLabel];
    
    
    //添加自动布局约束
    [header setTranslatesAutoresizingMaskIntoConstraints: NO];
    [statusLabel setTranslatesAutoresizingMaskIntoConstraints: NO];
    
    NSMutableArray *contraits = [NSMutableArray array];
    NSMutableDictionary *metrics = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@5, @"HPadding", @5, @"VPadding", @20, @"TopMargin", nil];
    NSDictionary *views = NSDictionaryOfVariableBindings(header, statusLabel);
    [contraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[header]-5-|" options:0 metrics:metrics views:views]];
    [contraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[statusLabel]-5-|" options:0 metrics:metrics views:views]];
    [contraits arrayByAddingObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[statusLabel]-5-|" options:0 metrics:metrics views:views]];
    [contraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[header]-(>=0)-[statusLabel]-20-|" options:0 metrics:metrics views:views]];
    [contraits addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[header(100)]" options:0 metrics:metrics views:views]];
    
    [self.view addConstraints: contraits];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)feedBackButtonPressed:(id)sender {
    
    WSYFeedbackController *feedbackViewController = [[WSYFeedbackController alloc] initWithNibName:@"WSYFeedbackController" bundle:nil];
    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:feedbackViewController];
    [self.navigationController presentViewController:navigation animated:YES completion:^{
        
    }];
//    [self.navigationController presentViewController:[UMFeedback feedbackModalViewController] animated:YES completion:^{
//        
//    }];
}

@end
