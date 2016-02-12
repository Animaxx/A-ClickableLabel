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

- (A_AttributedStringBuilder *)setSystemFontSize:(CGFloat)size;
- (A_AttributedStringBuilder *)setFontName:(NSString *)name withSize:(CGFloat)size;
- (A_AttributedStringBuilder *)setKern:(CGFloat)kern;
- (A_AttributedStringBuilder *)setParagraphStyle:(NSParagraphStyle *)style;
- (A_AttributedStringBuilder *)setUnderline:(BOOL)underline;
- (A_AttributedStringBuilder *)setShadow:(NSShadow *)shadow;
- (A_AttributedStringBuilder *)setObliqueness:(CGFloat)obliqueness;

- (NSDictionary<NSString *, id> *)getStringAttributes;
- (NSAttributedString *)getAttributedString:(NSString *)string;

@end
