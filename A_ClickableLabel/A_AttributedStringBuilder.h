//
//  A_AttributedStringBuilder.h
//
//  Created by Animax Deng on 2/9/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface A_AttributedStringBuilder : NSObject

+ (A_AttributedStringBuilder *)createWithSystemFontSize:(CGFloat)size;
+ (A_AttributedStringBuilder *)createWithFontName:(NSString *)name withSize:(CGFloat)size;
+ (A_AttributedStringBuilder *)createFromAttributes:(NSDictionary *)attributes;

- (A_AttributedStringBuilder *)setAttributes:(NSDictionary *)attributes;
- (A_AttributedStringBuilder *)setSystemFontSize:(CGFloat)size;
- (A_AttributedStringBuilder *)setFontName:(NSString *)name withSize:(CGFloat)size;
- (A_AttributedStringBuilder *)setKern:(CGFloat)kern;
- (A_AttributedStringBuilder *)setParagraphStyle:(NSParagraphStyle *)style;
- (A_AttributedStringBuilder *)setUnderline:(BOOL)underline;
- (A_AttributedStringBuilder *)setShadow:(NSShadow *)shadow;
- (A_AttributedStringBuilder *)setObliqueness:(CGFloat)obliqueness;
- (A_AttributedStringBuilder *)setForegroundColor:(UIColor *)color;
- (A_AttributedStringBuilder *)setBackgroundColor:(UIColor *)color;
- (A_AttributedStringBuilder *)setStrokeColor:(UIColor *)color;
- (A_AttributedStringBuilder *)setBaselineOffset:(CGFloat)offest;
- (A_AttributedStringBuilder *)setUnderlineColor:(UIColor *)color;
- (A_AttributedStringBuilder *)setExpansion:(CGFloat)offest;

- (NSDictionary<NSString *, id> *)getStringAttributes;
- (NSAttributedString *)getAttributedString:(NSString *)string;

@end
