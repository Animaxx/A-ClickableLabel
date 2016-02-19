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
@class A_ClickedAdditionalInformation;

typedef void(^aClickableLabelTouchEvent)(A_ClickableElement *element, A_ClickableLabel *sender, A_ClickedAdditionalInformation *info);

@interface A_ClickableElement : NSObject

@property (strong, nonatomic) A_AttributedStringBuilder *styleBuilder;
@property (strong, nonatomic) NSString *elementWords;
@property (copy, nonatomic) aClickableLabelTouchEvent touchEvent;

+ (A_ClickableElement *)create:(NSString *)words withAttributes:(NSDictionary<NSString *, id> *)attributes andClick:(aClickableLabelTouchEvent)touchEvent;
+ (A_ClickableElement *)create:(NSString *)words withBuilder:(A_AttributedStringBuilder *)builder andClick:(aClickableLabelTouchEvent)touchEvent;

+ (A_ClickableElement *)create:(NSString *)words withAttributes:(NSDictionary<NSString *, id> *)attributes;
+ (A_ClickableElement *)create:(NSString *)words withBuilder:(A_AttributedStringBuilder *)builder;


@end

@interface A_ClickedAdditionalInformation : NSObject

@property (strong, nonatomic) NSString *selectedWord;
@property (nonatomic) NSInteger locateNumberOfLine;
@property (nonatomic) CGPoint clickedPoint;
@property (nonatomic) CGPoint clickedBaselinePoint;
@property (assign, nonatomic) CFIndex charIndexInSentence;

@end

@interface A_ClickableLabel : UILabel

- (void)setSentence:(NSString *)sentence withAttributes:(NSDictionary<NSString *, id> *)stringAttributes andElements:(NSArray<A_ClickableElement *> *)elements;
- (void)setSentence:(NSString *)sentence withBuilder:(A_AttributedStringBuilder *)builder andElements:(NSArray<A_ClickableElement *> *)elements;

- (void)setSentence:(NSString *)sentence withAttributes:(NSDictionary<NSString *, id> *)stringAttributes andElement:(A_ClickableElement *)element, ...NS_REQUIRES_NIL_TERMINATION;
- (void)setSentence:(NSString *)sentence withBuilder:(A_AttributedStringBuilder *)builder andElement:(A_ClickableElement *)element, ...NS_REQUIRES_NIL_TERMINATION;

- (void)renderLabel;

@end
