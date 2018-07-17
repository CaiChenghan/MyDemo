//
//  UserListViewController.m
//  MyRealmDemo
//
//  Created by 蔡成汉 on 2018/7/16.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "UserListViewController.h"
#import "UserInfoCell.h"
#import "User.h"

@interface UserListViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation UserListViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self reloadUserData];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Realm数据库操作";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *addDataItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addData)];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.rightBarButtonItems = @[addDataItem,refreshItem];
}

- (void)refreshData {
    [self reloadUserData];
    [self.tableView reloadData];
}

- (void)addData {
    [self addUser];
}

- (void)reloadUserData {
    _dataArray = [NSMutableArray arrayWithArray:[self loadUserDataFromDB]];
}

- (NSArray *)loadUserDataFromDB {
    NSMutableArray *tpArray = [NSMutableArray array];
    RLMResults *results = [[User allObjects]sortedResultsUsingKeyPath:@"uid" ascending:YES];
    if (results.count > 0) {
        for (User *tpUser in results) {
            [tpArray addObject:tpUser];
        }
    }
    return tpArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

#pragma mark - 增加数据 - 单一增加

//添加数据方法一，简单的添加数据。开始和提交方法需成对出现。
//需要注意的是：若增加的是主键已经存在的数据，则会报错。若没有设置主键，则无影响。
- (void)methodOne {
    User *user = [[User alloc]init];
    user.name = @"张三";
    user.uid = 123;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addObject:user];
    [realm commitWriteTransaction];
}

//添加数据方法二，采用block块处理。
//其注意点同方法一。
- (void)methodTwo {
    User *user = [[User alloc]init];
    user.name = @"张三";
    user.uid = 123;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:user];
    }];
}


#pragma mark - 增加数据 - 更新增加

//添加数据方法三，更新式添加
//若数据存在，则更新，否则创建。
- (void)methodThree {
    User *user = [[User alloc]init];
    user.name = @"张三";
    user.uid = 123;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm addOrUpdateObject:user];
    [realm commitWriteTransaction];
}

//添加数据方法四，采用block块处理。
//若数据存在，则更新，否则创建。
- (void)methodFour {
    User *user = [[User alloc]init];
    user.name = @"张三";
    user.uid = 123;
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addOrUpdateObject:user];
    }];
}

#pragma mark - 删除用户

//删除用户时，需要先有目标对象，即需要删除的Realm数据，故需先查询符合条件的数据。
- (void)deleteUser:(NSInteger)uid {
    RLMResults *results = [User objectsWhere:@"uid = %ld",uid];
    if (results && results.count > 0) {
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm deleteObjects:results];
        }];
    }
}

- (void)addUser {
    NSString *name = [self createUserName];
    if (name) {
        User *user = [[User alloc]init];
        user.name = name;
        user.uid = [User allObjects].count + 1;
        user.line = [self createUserLine];
        user.online = [self createUserOnline];
        
        RLMRealm *realm = [RLMRealm defaultRealm];
        [realm transactionWithBlock:^{
            [realm addOrUpdateObject:user];
        }];
        [self reloadUserData];
        [self.tableView reloadData];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.dataArray.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (NSString *)createUserName {
    NSArray *nameArray = @[@"安其拉",@"白起",@"不知火舞",@"妲己",@"狄仁杰",@"典韦",@"韩信",@"老夫子",@"刘邦",@"刘禅",@"鲁班七号",@"墨子",@"孙膑",@"孙尚香",@"孙悟空",@"项羽",@"亚瑟",@"周瑜",@"周庄",@"蔡文姬",@"甄姬",@"廉颇",@"程咬金",@"后羿",@"扁鹊",@"钟无艳",@"小乔",@"王昭君",@"虞姬",@"李元芳",@"张飞",@"刘备",@"牛魔",@"张良",@"兰陵王",@"露娜",@"貂蝉",@"达摩",@"曹操",@"芈月",@"荆轲",@"高渐离",@"钟馗",@"花木兰",@"关羽",@"李白",@"宫本武藏",@"吕布",@"嬴政",@"娜可",@"露露",@"武则天",@"赵云",@"姜子牙",@"哪吒",@"诸葛亮",@"黄忠",@"大乔",@"东皇太一",@"庞统",@"干将",@"莫邪",@"鬼谷子",@"女娲"];
    RLMResults *allResults = [User allObjects];
    if (allResults.count == nameArray.count) {
        return nil;
    }
    NSInteger x = arc4random() % nameArray.count;
    NSString *tpName = nameArray[x];
    RLMResults *results = [User objectsWhere:@"name = %@",tpName];
    if (results && results.count > 0) {
        return [self createUserName];
    } else {
        return tpName;
    }
}

- (UserLine)createUserLine {
    UserLine line = LineOne;
    NSInteger x = arc4random() % 5;
    if (x == 0) {
        line = LineOne;
    }
    if (x == 1) {
        line = LineTwo;
    }
    if (x == 2) {
        line = LineThree;
    }
    if (x == 3) {
        line = LineFour;
    }
    if (x == 4) {
        line = LineFive;
    }
    return line;
}

- (BOOL)createUserOnline {
    NSInteger x = arc4random() % 100;
    if (x < 20) {
        return NO;
    } else {
        return YES;
    }
}

- (NSString *)getUserLineDes:(UserLine)line {
    NSString *lineDes = @"";
    if (line == LineOne) {
        lineDes = @"上路";
    }
    if (line == LineTwo) {
        lineDes = @"中路";
    }
    if (line == LineThree) {
        lineDes = @"下路";
    }
    if (line == LineFour) {
        lineDes = @"打野";
    }
    if (line == LineFive) {
        lineDes = @"辅助";
    }
    return lineDes;
}

- (BOOL)deleteRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.dataArray.count) {
        User *user = self.dataArray[indexPath.row];
        [self deleteUser:user.uid];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserInfoCell"];
    if (cell == nil) {
        cell = [[UserInfoCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UserInfoCell"];
    }
    User *user = _dataArray[indexPath.row];
    cell.textLabel.text = user.name;
    NSString *line = [self getUserLineDes:user.line];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"id:%ld  %@  %@",user.uid,line,user.online ? @"在线" : @"不在线"];
    
    __weak typeof(self) weakSelf = self;
    MGSwipeButton *deleteBtn = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] padding:30 callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        NSIndexPath *tpIndexPath = [tableView indexPathForCell:cell];
        return [weakSelf deleteRowAtIndexPath:tpIndexPath];
    }];
    cell.rightButtons = @[deleteBtn];
    cell.rightSwipeSettings.transition = MGSwipeTransitionStatic;
    cell.rightSwipeSettings.enableSwipeBounces = NO;
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
