//
//  LeaderboardScene.h
//  Doodle World
//
//  Created by Shaun Thompson on 9/17/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Parse/Parse.h>

@interface LeaderboardScene : SKScene <UITableViewDataSource, UITableViewDelegate>

@property UITableView *tableView;
@property NSMutableArray *scoreArray;

@end
