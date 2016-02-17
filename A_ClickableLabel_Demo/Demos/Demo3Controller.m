//
//  Demo3Controller.m
//  A_ClickableLabel_Demo
//
//  Created by Animax Deng on 2/16/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import "Demo3Controller.h"
#import "A_ClickableLabel.h"

@interface Demo3Controller ()

@property (weak, nonatomic) IBOutlet A_ClickableLabel *demoLabel;
@property (strong, nonatomic) UIView *explainArea;

@end

@implementation Demo3Controller {
    A_ClickableLabel *switchLabel;
    A_ClickableElement *world;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // the clickable and changable element
    world = [A_ClickableElement create:@"World" withBuilder:[[[[A_AttributedStringBuilder createWithFontName:@"Helvetica-Bold" withSize:20] setForegroundColor:[UIColor blackColor]] setUnderline:YES] setUnderlineColor:[UIColor greenColor]] andClick:^(A_ClickableElement *element, A_ClickableLabel *sender, A_ClickedAdditionalInformation *info) {
        
        self.explainArea.frame = CGRectMake(sender.frame.origin.x + info.clickedPoint.x - 40.0f, sender.frame.origin.y + info.clickedPoint.y, 110, 30);
        
    }];
    
    // Draw popup
    _explainArea = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _explainArea.backgroundColor = [UIColor blackColor];
    _explainArea.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:_explainArea];
    
    switchLabel = [[A_ClickableLabel alloc] init];
    [switchLabel setSentence:@" %@|%@ " withBuilder:[[A_AttributedStringBuilder createWithSystemFontSize:14] setForegroundColor:[UIColor whiteColor]] andElement:
     [A_ClickableElement create:@"World" withBuilder:[A_AttributedStringBuilder createWithSystemFontSize:16] andClick:^(A_ClickableElement *element, A_ClickableLabel *sender, A_ClickedAdditionalInformation *info) {
        
        world.elementWords = @"World";
        [self.demoLabel renderLabel];
        _explainArea.frame = CGRectMake(0, 0, 0, 0);
        
    }], [A_ClickableElement create:@"Animax" withBuilder:[A_AttributedStringBuilder createWithSystemFontSize:16] andClick:^(A_ClickableElement *element, A_ClickableLabel *sender, A_ClickedAdditionalInformation *info) {

        world.elementWords = @"Animax";
        [self.demoLabel renderLabel];
        _explainArea.frame = CGRectMake(0, 0, 0, 0);
        
    }], nil];
    [_explainArea addSubview:switchLabel];
    
    switchLabel.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight);
    
    

    
    // Draw the sentence
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowBlurRadius = 0.6f;
    shadow.shadowColor = [UIColor orangeColor];
    
    [self.demoLabel setSentence:@"%@%@%@%@%@ %@\n" withBuilder:[A_AttributedStringBuilder createWithSystemFontSize:16] andElement:
     [A_ClickableElement create:@"H" withBuilder:[[A_AttributedStringBuilder createWithSystemFontSize:18] setForegroundColor:[UIColor redColor]]],
     [A_ClickableElement create:@"e" withBuilder:[[[A_AttributedStringBuilder createWithFontName:@"Helvetica-Bold" withSize:10] setForegroundColor:[UIColor blackColor]] setBaselineOffset:6]],
     [A_ClickableElement create:@"l" withBuilder:[[[A_AttributedStringBuilder createWithSystemFontSize:14] setForegroundColor:[UIColor blueColor]] setObliqueness:0.1f]],
     [A_ClickableElement create:@"l" withBuilder:[[[A_AttributedStringBuilder createWithSystemFontSize:16] setForegroundColor:[UIColor greenColor]] setShadow:shadow]],
     [A_ClickableElement create:@"o" withBuilder:[[[[A_AttributedStringBuilder createWithSystemFontSize:16] setForegroundColor:[UIColor redColor]] setExpansion:0.8f] setShadow:shadow]],
     world, nil
    ];
}



@end
