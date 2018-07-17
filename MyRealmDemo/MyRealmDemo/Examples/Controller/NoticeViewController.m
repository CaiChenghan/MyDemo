//
//  NoticeViewController.m
//  MyRealmDemo
//
//  Created by 蔡成汉 on 2018/7/16.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "NoticeViewController.h"

@interface NoticeViewController ()

@end

@implementation NoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"Realm使用简介";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView = [[UITextView alloc]initWithFrame:self.view.bounds];
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:15];
    textView.textColor = [UIColor grayColor];
    textView.text = @"1、关于数据库创建问题：\nRealm在使用时，会自行创建数据库，若要自定义数据库，只需要修改Realm的config下的URL即可。\n\n2、关于数据表创建问题：\nRealm会为每个继承自RLMObject的对象创建数据表，我们只需要使用模型对象即可，无需关心数据表问题。\n\n3、关于Realm存储的数据类型问题：\nRealm对数据类型有严格的要求，可使用的数据类型主要如下：BOOL、bool、int、NSInteger、long、float、double、CGFloat、NSString、NSDate以及NSData等。很不幸的是对NSUInteger的不支持，导致用户向Realm迁移的模型对象来说，可能会有点麻烦。\n\n4、使用思想变更：\n在使用sqlite、FMDB（其实也是sqlite）或者MySQL等其它关系型数据库时，我们所处的思想是对表的操作。一切的一切，都是基于对数据表的增删查改。但是在使用Realm时，思想可能需要改变一下。Realm虽然也是对数据库的增删查改，但是其思想更多的偏向于模型对象，及面向对象。主要体现在原本操作表的查询语句，几乎变成对象的方法。故在使用Realm时，可能更多的是查找其对象的api方法，而不是查询语句了。\n\n4、我们为什么要使用Realm？\n首先它是面向对象的，原本的查询方法现在可以直接使用对象的api方法来实现，这会使得数据库的使用变得更加简单；\n其次就是其超高的效率，几乎无延迟的就可以拿到想要的数据；\n然后是易维护，模型增删字段，必然导致数据表字段发生改变，此时我们只需要增加Realm版本号即可，其内部会自行对比操作。而sqlite、FMDB维护起来可能会比较麻烦；\n最后是其跨平台的支持，可同时支持iOS安卓。";
    [self.view addSubview:textView];
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
