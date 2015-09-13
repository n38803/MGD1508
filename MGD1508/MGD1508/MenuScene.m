//
//  MenuScene.m
//  MGD1508
//
//  Created by Shaun Thompson on 8/21/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "MenuScene.h"
#import "GameScene.h"
#import "CreditsScene.h"
#import "TutorialScene.h"
#import "IntroScene.h"

@implementation MenuScene

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
    title.text = @"DOODLE WORLD";
    [self addChild:title];
    
    SKLabelNode *start = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    start.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)-50);
    start.fontSize = 30;
    [start setScale:1.0*screenScale];
    start.fontColor = [UIColor blackColor];
    start.text = @"- Play Game - ";
    start.name = @"start";
    [self addChild:start];
    
    SKLabelNode *tutorial = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    tutorial.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)-100);
    tutorial.fontSize = 30;
    [tutorial setScale:1.0*screenScale];
    tutorial.fontColor = [UIColor blackColor];
    tutorial.text = @"- How to Play -";
    tutorial.name = @"tutorial";
    [self addChild:tutorial];
    
    SKLabelNode *credits = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    credits.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)-150);
    credits.fontSize = 30;
    [credits setScale:1.0*screenScale];
    credits.fontColor = [UIColor blackColor];
    credits.text = @"- Credits - ";
    credits.name = @"credits";
    [self addChild:credits];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if next button touched, start transition to next scene
    if ([node.name isEqualToString:@"start"]) {
        NSLog(@"start pressed");
        
        SKScene *game = [[IntroScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:game transition:transition];
    }
    
    else if ([node.name isEqualToString:@"tutorial"]) {
        NSLog(@"tutorial pressed");
        
        SKScene *tutorial = [[TutorialScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:tutorial transition:transition];
    }
    
    else if ([node.name isEqualToString:@"credits"]) {
        NSLog(@"credits pressed");
        
        SKScene *credits = [[CreditsScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:credits transition:transition];
    }
}



@end
