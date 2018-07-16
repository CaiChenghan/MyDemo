//
//  DBManager.m
//  MyRealmDemo
//
//  Created by 蔡成汉 on 2018/7/16.
//  Copyright © 2018年 蔡成汉. All rights reserved.
//

#import "DBManager.h"

@implementation DBManager

+ (void)createDataBaseWithName:(NSString *)dataBaseName {
    NSArray *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [docPath firstObject];
    NSString *filePath = [path stringByAppendingPathComponent:dataBaseName];
    NSLog(@"数据库路径%@",filePath);
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.fileURL = [NSURL URLWithString:filePath];
    NSInteger currentSchemaVersion = 1;
    config.schemaVersion = currentSchemaVersion;
    config.migrationBlock = ^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < currentSchemaVersion) {
            NSLog(@"执行数据库升级");
        }
    };
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

@end
