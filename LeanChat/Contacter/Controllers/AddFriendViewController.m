//
//  AddFriendViewController.m
//  LeanChat
//
//  Created by gao on 15/11/18.
//  Copyright © 2015年 gao. All rights reserved.
//

#import "AddFriendViewController.h"

@interface AddFriendViewController () <NIMUserManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *friendIDTextField;
- (IBAction)addFriend:(UIButton *)sender;

@end

@implementation AddFriendViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self = [super initWithNibName:@"AddFriendViewController" bundle:nil]) {
        [[[NIMSDK sharedSDK] userManager] addDelegate:self];
    }
    return self;
}
- (void)dealloc
{
    [[[NIMSDK sharedSDK] userManager] removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addFriend:(UIButton *)sender {
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = self.friendIDTextField.text;
    request.operation = NIMUserOperationAdd;
    request.message = @"跪求通过";
    [[[NIMSDK sharedSDK] userManager] requestFriend:request completion:^(NSError *error) {
        if (!error) {
            NSLog(@"请求成功");
        }
    }];
}

- (void)onFriendChanged:(NIMUser *)user
{
    self.block();
    [self.navigationController popViewControllerAnimated:YES];
}
@end