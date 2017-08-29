//
//  ZHTransitionViewController.m
//  TEST
//
//  Created by Zason_Hao on 2017/8/22.
//  Copyright © 2017年 郝兆超. All rights reserved.
//

#import "ZHTransitionViewController.h"
#import "ZHTransitionPresentViewController.h"
#import "ZHTransitionNavigationViewController.h"
#import "ZHTransitionPresentPointSpread.h"
#import "ZHTransitionNavigationPointSpread.h"

#import "UIViewController+ZHTransition.h"
#import "UINavigationController+ZHTransition.h"

@interface ZHTransitionViewController ()<UIViewControllerTransitioningDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataSource;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation ZHTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"ViewController切换";
    
    [self.view addSubview:self.tableView];
}

-(NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource = @[@"由下而上(类似present)",@"由下而上并有弹簧效果",@"由右向左(类似push)",@"由右向左并有弹簧效果",@"点扩散",@"由右向左翻页"];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
    }
    cell.textLabel.text = _dataSource[indexPath.row];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        ZHTransitionPresentViewController *vc = [[ZHTransitionPresentViewController alloc] init];
        if (indexPath.row == 0) {
            [self presentViewControllerWithPresentModal:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 1){
            [self presentSpringViewControllerWithPresentModal:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 2){
            [self pushViewControllerWithPresentModal:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 3){
            [self pushSpringViewControllerWithPresentModal:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 4){
            ZHTransitionPresentPointSpread *point = [[ZHTransitionPresentPointSpread alloc] init];
            [self pointSpreadViewControllerWithPresentModal:point animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 5){
            [self pageViewControllerWithPresentModal:vc animation:YES completion:^{
                
            }];
        }
    }else{
        ZHTransitionNavigationViewController *vc = [[ZHTransitionNavigationViewController alloc] init];
        if (indexPath.row == 0) {
            [self.navigationController presentViewControllerWithNavigation:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 1){
            [self.navigationController presentSpringViewControllerWithNavigation:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 2){
            [self.navigationController pushViewControllerWithNavigation:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 3){
            [self.navigationController pushSpringViewControllerWithNavigation:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 4){
            ZHTransitionNavigationPointSpread *point = [[ZHTransitionNavigationPointSpread alloc] init];
            [self.navigationController pointSpreadViewControllerWithNavigation:point animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
            return;
        }else if (indexPath.row == 5){
            [self.navigationController pageViewControllerWithNavigation:vc animation:YES completion:^{
                NSLog(@"transiton complete !");
            }];
        }
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    sectionTitle.text = section == 0 ? @"PresentModal" : @"Navigate";
    sectionTitle.backgroundColor = [UIColor lightGrayColor];
    return sectionTitle;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40.0f;
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
