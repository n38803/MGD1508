//
//  TutorialScene.m
//  Doodle World
//
//  Created by Shaun Thompson on 8/28/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "TutorialScene.h"
#import "MenuScene.h"

@implementation TutorialScene

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;
float tinyScale;

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
    
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    title.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)+100);
    title.fontSize = 45;
    [title setScale:1.0*screenScale];
    title.fontColor = [UIColor whiteColor];
    title.text = @"TUTORIAL";
    [self addChild:title];
    
    
    SKLabelNode *one = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    one.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame));
    one.fontSize = 20;
    [one setScale:1.0*screenScale];
    one.fontColor = [UIColor blackColor];
    one.text = @"1. Keep up with the moving scene";
    [self addChild:one];
    
    SKLabelNode *two = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    two.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-25);
    two.fontSize = 20;
    [two setScale:1.0*screenScale];
    two.fontColor = [UIColor blackColor];
    two.text = @"2. Collect fish and berries";
    [self addChild:two];
    
    SKLabelNode *three = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    three.position = CGPointMake(CGRectGetMidX(self.frame),CGRectGetMidY(self.frame)-50);
    three.fontSize = 20;
    [three setScale:1.0*screenScale];
    three.fontColor = [UIColor blackColor];
    three.text = @"3. Avoid the bugs!";
    [self addChild:three];
    
    SKLabelNode *back = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    back.text = @"[ Back ]";
    back.name = @"back";
    [back setScale:1.0*screenScale];
    back.fontColor = [UIColor redColor];
    back.fontSize = 25;
    back.position = CGPointMake(100, 700);
    
    [self addChild:back];

    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        NSLog(@"back pressed");
        
        SKScene *menu = [[MenuScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:menu transition:transition];
    }
    
    
}


@end
