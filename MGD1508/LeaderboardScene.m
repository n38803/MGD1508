//
//  LeaderboardScene.m
//  Doodle World
//
//  Created by Shaun Thompson on 9/17/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "LeaderboardScene.h"
#import "MenuScene.h"

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;

@implementation LeaderboardScene

// Init function
-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
    }
    return self;
}




-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    
    // Grab screen parameters
    screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
    NSLog(@"Screen Height: %f", screenHeight);
    NSLog(@"Screen Width: %f", screenWidth);
    screenScale = (screenHeight/768);
    NSLog(@"Screen Scale: %f", screenScale);
    
    // Title
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    title.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)+150);
    title.fontSize = 45;
    [title setScale:1.0*screenScale];
    title.fontColor = [UIColor whiteColor];
    title.text = @"Today's Top Scores";
    [self addChild:title];    
    
    
    // Back Button
    SKLabelNode *back = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    back.text = @"[ Back ]";
    back.name = @"back";
    [back setScale:1.0*screenScale];
    back.fontColor = [UIColor redColor];
    back.fontSize = 25;
    back.position = CGPointMake(100, 700);
    
    [self addChild:back];
    
    // Parse Data
    [self performSelector:@selector(queryParse)];
    
    // Tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMidY(self.frame), 310, 300, 400)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
    
    
    
    
    
}

- (void) queryParse {
    
    PFQuery *query = [PFQuery queryWithClassName:@"GameScore"];
    
    NSDate *now = [NSDate date];
    NSDateComponents *days = [NSDateComponents new];
    [days setDay:-1];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *yesterday = [cal dateByAddingComponents:days toDate:now options:0];
    [query whereKey:@"createdAt" greaterThan:yesterday];
    
    [query orderByDescending:@"score"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         
         if (!error){
             _scoreArray = [[NSMutableArray alloc] initWithArray:objects];
             NSLog(@"DATA REFRESHED! // %@", _scoreArray);
         }
         else {
             NSLog(@"DATA NOT REFRESHED! // %@", @"Parse Error");
         }
         
         // refresh table to populate parse data
         [self.tableView reloadData];
         
     }];
}

// Number of Sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)theTableView
{
    return 1;
}

// Number of row in Section
- (NSInteger)tableView:(UITableView *)theTableView numberOfRowsInSection:(NSInteger)section
{
    return self.scoreArray.count;
}

// Cell View
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainCell"];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MainCell"];
    }

    // pull info from parseobj
    PFObject *parseObj = [self.scoreArray objectAtIndex:indexPath.row];
    
    // store player name to local variable
    NSString *name = [parseObj objectForKeyedSubscript:@"playerName"];
    cell.textLabel.text =       [NSString stringWithFormat:@"Player: %@", name];
    
    // convert score to string & store to local variable
    NSString *score = [[parseObj objectForKeyedSubscript:@"score"] stringValue];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Score: %@", score];

    
    return cell;
}


// User touch on Table
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"selected %ld row", (long)indexPath.row);
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        NSLog(@"back pressed");
        
        [_tableView removeFromSuperview];
        SKScene *menu = [[MenuScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:menu transition:transition];
    }
    
    
}
@end
