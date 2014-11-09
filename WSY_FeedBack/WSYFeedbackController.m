//
//  WSYFeedbackController.m
//  WSY_FeedBack
//
//  Created by 袁仕崇 on 14/11/9.
//  Copyright (c) 2014年 wilson. All rights reserved.
//
#import "UMFeedback.h"
#import "WSYFeedbackController.h"
#import "WSYFeedbackCell.h"


@interface WSYFeedbackController ()<UMFeedbackDataDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *InputView;
@property (strong, nonatomic) UMFeedback *feedback;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *textFeild;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation WSYFeedbackController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.feedback = [UMFeedback sharedInstance];
    self.feedback.delegate = self;
    [self.feedback get];
    
    
    NSDictionary *dictionary = @{@"content": @"hahahhahahah"};
        [self.feedback post:dictionary];
    [self.tableView registerNib:[UINib nibWithNibName:@"WSYFeedbackCell" bundle:nil] forCellReuseIdentifier:@"WSYFeedbackCell"];
    [self.tableView setRowHeight:UITableViewAutomaticDimension];
    [self.tableView setEstimatedRowHeight:50];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"Back" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidChangeSize:)
                                                 name:UIKeyboardDidChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidChange:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)backButtonPressed
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
#pragma mark - umfeedback delegate method
- (void)getFinishedWithError:(NSError *)error {
    if (error != nil) {
//        NSLog(@"%@", error);
    } else {
//        NSLog(@"Get: %@", self.feedback.topicAndReplies);
    }
}

- (void)postFinishedWithError:(NSError *)error {
    if (error != nil) {
//        NSLog(@"%@", error);
    } else {
//        NSLog(@"Post%@", self.feedback.topicAndReplies);
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.feedback.topicAndReplies.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WSYFeedbackCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WSYFeedbackCell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = self.feedback.topicAndReplies[indexPath.row];
    NSString *content = dictionary[@"content"];
    [cell.content setText: content];
    
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
- (void)keyboardWillShow:(NSNotification *)notification
{
    [self.view removeConstraints:self.tableView.constraints];
    [self.view removeConstraints:self.InputView.constraints];
    NSDictionary *info = [notification userInfo];
    NSValue *keyBoardRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardHeight = [keyBoardRect CGRectValue].size.height;
    NSLog(@"keyBoardHeight: %f", keyBoardHeight);
    CGFloat duration = 0.25;
    NSDictionary *visiableView = NSDictionaryOfVariableBindings(_InputView, _tableView);
    NSString *tableViewString = [NSString stringWithFormat:@"V:|-[_tableView]-%f-|", keyBoardHeight+44];
    NSString *keyboardstring = [NSString stringWithFormat:@"V:[_InputView]-%f-|", keyBoardHeight];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableViewString options:0 metrics:nil views:visiableView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:keyboardstring options:0 metrics:nil views:visiableView]];
//        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_InputView(44)]" options:0 metrics:nil views:visiableView]];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)keyboardWillHide: (NSNotification *)notification
{
    [self.view removeConstraints:self.tableView.constraints];
    [self.view removeConstraints:self.InputView.constraints];
    
    NSDictionary *info = [notification userInfo];
    NSValue *keyBoardRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardHeight = [keyBoardRect CGRectValue].size.height;
        NSLog(@"keyBoardHeight: %f", keyBoardHeight);
    CGFloat duration = 0.25;
    NSDictionary *visiableView = NSDictionaryOfVariableBindings(_InputView, _tableView);
//    NSString *keyboardstring = [NSString stringWithFormat:@"V:[_tableView][_InputView]-|", keyBoardHeight];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tableView]-44-|" options:0 metrics:nil views:visiableView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableView][_InputView]|" options:0 metrics:nil views:visiableView]];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)keyboardDidChangeSize: (NSNotification *)notification
{
    [self.view removeConstraints:self.tableView.constraints];
    [self.view removeConstraints:self.InputView.constraints];
    
    NSDictionary *info = [notification userInfo];
    NSValue *keyBoardRect = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardHeight = [keyBoardRect CGRectValue].size.height;
    NSLog(@"keyBoardHeight: %f", keyBoardHeight);
    CGFloat duration = 0.25;
    NSDictionary *visiableView = NSDictionaryOfVariableBindings(_InputView, _tableView);
    NSString *tableViewString = [NSString stringWithFormat:@"V:|[_tableView]-%f-|", keyBoardHeight+44];
    NSString *keyboardstring = [NSString stringWithFormat:@"V:[_InputView]-%f-|", keyBoardHeight];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:tableViewString options:0 metrics:nil views:visiableView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:keyboardstring options:0 metrics:nil views:visiableView]];
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:_InputView
//                              attribute:NSLayoutAttributeHeight
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeHeight
//                              multiplier:0.1
//                              constant:0]];
    
    //        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_tableView]-0-[_InputView]" options:0 metrics:nil views:visiableView]];
    
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}
- (void)textFieldDidChange: (NSNotification *)notification
{

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{

    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.textFeild resignFirstResponder];
    return YES;
}
@end
