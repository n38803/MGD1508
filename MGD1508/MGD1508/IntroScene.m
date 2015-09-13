//
//  IntroScene.m
//  Doodle World
//
//  Created by Shaun Thompson on 9/12/15.
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "IntroScene.h"

@implementation IntroScene

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;
float screenScale;

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
    
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = -50;
    [bgImage setScale:0.75/screenScale];
    [self addChild:bgImage];
    
    
    
    // Story Portrait 1
    SKSpriteNode *scene1 = [SKSpriteNode spriteNodeWithImageNamed:@"Storyline1"];
    [scene1 setScale:0.8*screenScale];
    scene1.name = @"scene1";
    scene1.zPosition = 2;
    
    scene1.position = CGPointMake((CGRectGetMidX(self.frame)),
                                CGRectGetMidY(self.frame)+150);
    [self addChild:scene1];
    
    // Story Portrait 2
    SKSpriteNode *scene2 = [SKSpriteNode spriteNodeWithImageNamed:@"Storyline2"];
    [scene2 setScale:0.35*screenScale];
    scene2.name = @"scene2";
    
    scene2.position = CGPointMake((CGRectGetMidX(self.frame)),
                                  CGRectGetMidY(self.frame));
    [self addChild:scene2];
    
    

    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   /*
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    if ([node.name isEqualToString:@"back"]) {
        NSLog(@"back pressed");
        
        SKScene *menu = [[MenuScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:menu transition:transition];
    }
    
    */
    
    // set time delay before refresh to allow deletion to complete on parse
    double delayInSeconds = 5.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        
        //[alert dismissWithClickedButtonIndex:0 animated:YES];
        
    });
        
        
    
}



@end
