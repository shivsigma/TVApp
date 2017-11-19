//
//  WelcomeViewController.m
//  UINDIE.xcodeproj1
//
//  Created by Nimit Bagadiya on 27/10/17.
//
//

#import "WelcomeViewController.h"

#import "ListItemViewController.h"

#import "AppDelegate.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

+(WelcomeViewController *)initViewController:(id<ListViewCallBackDelegate>)dd{
    WelcomeViewController * controller = [[WelcomeViewController alloc]initWithNibName:@"WelcomeViewController" bundle:nil];
    controller.del = dd;
    return controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (IBAction)actionDiscoverMusic:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (IBAction)actionBookDJ:(id)sender {
    
    ListItemViewController *controller = [ListItemViewController initViewController:_del];
    [self.navigationController pushViewController:controller animated:YES];
//
//    UINavigationController *navController = (UINavigationController *) [[AppDelegate appDelegate].window rootViewController];
//    
//    [navController pushViewController:controller animated:YES];
//    
////    [self.navigationController pushViewController:controller animated:YES];
//    
//    [self dismissViewControllerAnimated:YES completion:^{
//        
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
