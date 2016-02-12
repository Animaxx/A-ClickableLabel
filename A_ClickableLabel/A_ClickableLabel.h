//
//  A_ClickableLabel.h
//
//  Created by Animax Deng on 2/8/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "A_AttributedStringBuilder.h"

@class A_ClickableElement;
@class A_ClickableLabel;
typedef void(^aClickableLabelTouchEvent)(A_ClickableElement *element, A_ClickableLabel *sender);

@interface A_ClickableElement : NSObject

@property (strong, nonatomic) NSDictionary<NSString *, id> *stringAttributes;
@property (strong, nonatomic) NSString *elementWords;
@property (assign, nonatomic) aClickableLabelTouchEvent touchEvent;

+ (A_ClickableElement *)create:(NSString *)words withAttributes:(NSDictionary<NSString *, id> *)attributes andClick:(aClickableLabelTouchEvent)touchEvent;
+ (A_ClickableElement *)create:(NSString *)words withBuilder:(A_AttributedStringBuilder *)builder andClick:(aClickableLabelTouchEvent)touchEvent;

@end


@interface A_ClickableLabel : UILabel

- (void)setSentence:(NSString *)sentence withBuilder:(A_AttributedStringBuilder *)builder andElements:(NSArray<A_ClickableElement *> *)elements;
- (void)setSentence:(NSString *)sentence withAttributes:(NSDictionary<NSString *, id> *)stringAttributes andElements:(NSArray<A_ClickableElement *> *)elements;

- (void)renderLabel;

@end
