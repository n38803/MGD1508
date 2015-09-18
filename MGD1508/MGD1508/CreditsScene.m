//
//  CreditsScene.m
//  Doodle World
//
//  Created by Shaun Thompson on 8/28/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "CreditsScene.h"
#import "MenuScene.h"
#import "GameOverScene.h"

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;

@implementation CreditsScene

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
    
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    title.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame)+100);
    title.fontSize = 45;
    [title setScale:1.0*screenScale];
    title.fontColor = [UIColor whiteColor];
    title.text = @"CREDITS";
    [self addChild:title];
    
    SKLabelNode *creator = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    creator.position = CGPointMake(CGRectGetMidX(self.frame),
                                   CGRectGetMidY(self.frame)-50);
    creator.fontSize = 20;
    [creator setScale:1.0*screenScale];
    creator.fontColor = [UIColor blackColor];
    creator.text = @"Game Creator: NextGen Technologies";
    [self addChild:creator];
    
    SKLabelNode *art = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    art.position = CGPointMake(CGRectGetMidX(self.frame),
                               CGRectGetMidY(self.frame)-100);
    art.fontSize = 20;
    [art setScale:1.0*screenScale];
    art.fontColor = [UIColor blackColor];
    art.text = @"Game Art: Joe Kaiser (twitter: @Jotato | web: jotato.com)";
    [self addChild:art];
    
    
    
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
