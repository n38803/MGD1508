//
//  IAD1509
//  Copyright (c) 2015 Shaun Thompson. All rights reserved.
//

#import "GameOverScene.h"
#import "MenuScene.h"
#import "GameScene.h"

@implementation GameOverScene

CGRect screenRect;
CGFloat screenHeight;
CGFloat screenWidth;




-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */

    
    // Grab screen parameters
    screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    screenWidth = screenRect.size.width;
    
    // Background image
    SKSpriteNode *bgImage = [SKSpriteNode spriteNodeWithImageNamed:@"paperbackground"];
    bgImage.position = CGPointMake(self.size.width/2, self.size.height/2);
    bgImage.zPosition = -50;
    bgImage.xScale = 1;
    bgImage.yScale = 1;
    [self addChild:bgImage];
    
    // Game Over Label
    SKLabelNode *gameOver = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOver.text = @"GAME OVER";
    gameOver.zPosition = 100;
    gameOver.name = @"Game Over";
    gameOver.fontColor = [UIColor blackColor];
    gameOver.fontSize = 45;
    gameOver.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame)+200);
    [self addChild:gameOver];
    
    
    // Game Over Face
    SKSpriteNode *deadHero = [SKSpriteNode spriteNodeWithImageNamed:@"gameover"];
    deadHero.xScale = 1;
    deadHero.yScale = 1;
    deadHero.name = @"hero";
    deadHero.position = CGPointMake(CGRectGetMidX(self.frame),
                                 CGRectGetMidY(self.frame));
    [self addChild:deadHero];
    
    // Play Again Label
    SKLabelNode *play = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    play.text = @"[ Main Menu ]";
    play.zPosition = 100;
    play.name = @"Main Menu";
    play.fontColor = [UIColor blackColor];
    play.fontSize = 25;
    play.position = CGPointMake(CGRectGetMidX(self.frame),
                                    CGRectGetMidY(self.frame)-200);
    [self addChild:play];
    
    // Score set to 0 for testing purposes
    int score = 0;
    int test = [GameScene alloc] 
    
    // Score Label
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 70, 150, 30)];
    scoreLabel.font = [UIFont fontWithName:@"Arial" size:25.0];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
    [self.view addSubview:scoreLabel];
    
    
    // Name Label
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 100, 160, 50)];
    nameLabel.text = @"Name: ";
    [self.view addSubview:nameLabel];
    
    // Name Input
    UITextField *nameInput = [[UITextField alloc] initWithFrame:CGRectMake(40, 150, 170, 30)];
    nameInput.backgroundColor = [UIColor grayColor];
    [self.view addSubview:nameInput];
    
    // PW Label
    UILabel *pwLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 200, 160, 50)];
    pwLabel.text = @"Password: ";
    [self.view addSubview:pwLabel];
    
    // PW Input
    UITextField *pwInput = [[UITextField alloc] initWithFrame:CGRectMake(40, 250, 170, 30)];
    pwInput.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pwInput];
    
    // Submit / Cancel Buttons
    UIButton *submit = [[UIButton alloc] initWithFrame:CGRectMake(40, 300, 80, 30)];
    [submit setTitle:@"Submit" forState:UIControlStateNormal];
    [[submit layer] setBorderWidth:2.0f];
    [[submit layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:submit];
    
    UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(130, 300, 80, 30)];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [[cancel layer] setBorderWidth:2.0f];
    [[cancel layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:cancel];
    
    // Register button
    UIButton *reg = [[UIButton alloc] initWithFrame:CGRectMake(40, 350, 170, 30)];
    [reg setTitle:@"Register" forState:UIControlStateNormal];
    [[reg layer] setBorderWidth:2.0f];
    [[reg layer] setBorderColor:[UIColor blackColor].CGColor];
    [self.view addSubview:reg];
    
    
    
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    SKNode *node = [self nodeAtPoint:location];
    
    // if next button touched, start transition to next scene
    if ([node.name isEqualToString:@"Main Menu"]) {
        NSLog(@"Player opted to play again");
        
        SKScene *myScene = [[MenuScene alloc] initWithSize:self.size];
        SKTransition *transition = [SKTransition doorsCloseHorizontalWithDuration:0.5];
        [self.view presentScene:myScene transition:transition];
    }
}


@end
