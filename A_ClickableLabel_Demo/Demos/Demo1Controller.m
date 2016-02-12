//
//  Demo1Controller.m
//  A_ClickableLabel_Demo
//
//  Created by Animax Deng on 2/10/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import "Demo1Controller.h"
#import "A_AttributedStringBuilder.h"
#import "A_ClickableLabel.h"
#import "DemoDisplayView.h"

@interface Demo1Controller ()

@property (weak, nonatomic) IBOutlet A_ClickableLabel *demoLabel;
@property (weak, nonatomic) IBOutlet DemoDisplayView *demoView;


@end

@implementation Demo1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.demoLabel setSentence:@"A fractal is %@ set that exhibits a repeating pattern that displays at every scale." withBuilder:[A_AttributedStringBuilder createWithSystemFontSize:16] andElements:
     
     @[[A_ClickableElement create:@"a natural phenomenon" withBuilder:[[A_AttributedStringBuilder createWithSystemFontSize:14] setUnderline:YES] andClick:^(A_ClickableElement *element, A_ClickableLabel *sender) {
            element.elementWords = @"a mathematical";
            [sender renderLabel];
        }]
    ]];
}

- (IBAction)onClick:(id)sender {
    [self.demoView draw:self.demoLabel.attributedText];
    [self.demoView setHidden:NO];
}


@end
