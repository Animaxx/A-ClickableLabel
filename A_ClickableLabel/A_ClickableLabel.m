//
//  A_ClickableLabel.m
//
//  Created by Animax Deng on 2/8/16.
//  Copyright © 2016 Animax Deng. All rights reserved.
//

#import "A_ClickableLabel.h"
#import <CoreText/CoreText.h>

@interface A_ClickableElement()

@property (assign, nonatomic) NSRange changableRange;

@end

@implementation A_ClickableElement

+ (A_ClickableElement *)create:(NSString *)words withAttributes:(NSDictionary<NSString *, id> *)attributes andClick:(aClickableLabelTouchEvent)touchEvent {
    
    A_ClickableElement *element = [[A_ClickableElement alloc] init];
    
    element.elementWords = words;
    element.stringAttributes = attributes;
    element.touchEvent = touchEvent;
    
    return element;
}
+ (A_ClickableElement *)create:(NSString *)words withBuilder:(A_AttributedStringBuilder *)builder andClick:(aClickableLabelTouchEvent)touchEvent {
    return [self create:words withAttributes:[builder getStringAttributes] andClick:touchEvent];
}

@end


@implementation A_ClickableLabel {
    NSString                            *_contentSentence;
    NSDictionary<NSString *, id>        *_attributes;
    NSArray<A_ClickableElement *>       *_elements;
}

- (void)setSentence:(NSString *)sentence withBuilder:(A_AttributedStringBuilder *)builder andElements:(NSArray<A_ClickableElement *> *)elements {
    self.userInteractionEnabled = YES;
    
    _contentSentence = sentence;
    _elements = elements;
    _attributes = [builder getStringAttributes];
    
    [self renderLabel];
}
- (void)setSentence:(NSString *)sentence withAttributes:(NSDictionary<NSString *, id> *)stringAttributes andElements:(NSArray<A_ClickableElement *> *)elements {
    self.userInteractionEnabled = YES;
    
    _contentSentence = sentence;
    _elements = elements;
    _attributes = stringAttributes;
    
    [self renderLabel];
}

- (void)renderLabel {
    // calculate the range for each element words
    NSString *content = [_contentSentence copy];
    for (int i = 0; i < _elements.count; i++) {
        NSRange range = [content rangeOfString:@"%@"];
        content = [content stringByReplacingCharactersInRange:range  withString:_elements[i].elementWords];

        range.length = _elements[i].elementWords.length;
        _elements[i].changableRange = range;
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:content];
    [string addAttributes:_attributes range:NSMakeRange(0, content.length)];
    for (A_ClickableElement *item in _elements) {
        [string addAttributes:item.stringAttributes range:item.changableRange];
    }
    
    [self setAttributedText:string];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CFIndex index = [self characterIndexAtPoint:[touch locationInView:self]];
    if (index == NSNotFound) return;
    
    for (A_ClickableElement *item in _elements) {
        if (item.changableRange.location <= index && (item.changableRange.location + item.changableRange.length) >= index && item.touchEvent) {
            
            item.touchEvent(item, self);
            break;
        }
    }
}

#pragma mark - Helping methods
- (CFIndex)characterIndexAtPoint:(CGPoint)p {
    // * This method is reference from TTTAttributedLabel
    // https://github.com/TTTAttributedLabel/TTTAttributedLabel/blob/master/TTTAttributedLabel/TTTAttributedLabel.m
    
    if (!CGRectContainsPoint(self.bounds, p)) {
        return NSNotFound;
    }
    
    CGRect textRect = [self textRectForBounds:self.bounds limitedToNumberOfLines:self.numberOfLines];
    textRect.origin.y = (self.bounds.size.height - textRect.size.height) / 2;
    
    if (self.textAlignment == NSTextAlignmentCenter) {
        textRect.origin.x = (self.bounds.size.width - textRect.size.width) / 2;
    }
    if (self.textAlignment == NSTextAlignmentRight) {
        textRect.origin.x = self.bounds.size.width - textRect.size.width;
    }
    
    if (!CGRectContainsPoint(textRect, p)) {
        return NSNotFound;
    }
    
    // Offset tap coordinates by textRect origin to make them relative to the origin of frame
    p = CGPointMake(p.x - textRect.origin.x, textRect.size.height - (p.y - textRect.origin.y));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, textRect);
    
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)self.attributedText);
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, (CFIndex)[self.attributedText length]), path, NULL);
    if (frame == NULL) {
        CFRelease(path);
        return NSNotFound;
    }
    
    CFArrayRef lines = CTFrameGetLines(frame);
    NSInteger numberOfLines = self.numberOfLines > 0 ? MIN(self.numberOfLines, CFArrayGetCount(lines)) : CFArrayGetCount(lines);
    if (numberOfLines == 0) {
        CFRelease(frame);
        CFRelease(path);
        return NSNotFound;
    }
    
    CFIndex idx = NSNotFound;
    
    CGPoint lineOrigins[numberOfLines];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, numberOfLines), lineOrigins);
    
    for (CFIndex lineIndex = 0; lineIndex < numberOfLines; lineIndex++) {
        CGPoint lineOrigin = lineOrigins[lineIndex];
        CTLineRef line = CFArrayGetValueAtIndex(lines, lineIndex);
        
        // Get bounding information of line
        CGFloat ascent = 0.0f, descent = 0.0f, leading = 0.0f;
        CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        CGFloat yMin = (CGFloat)floor(lineOrigin.y - descent);
        CGFloat yMax = (CGFloat)ceil(lineOrigin.y + ascent);
        
        // Apply penOffset using flushFactor for horizontal alignment to set lineOrigin since this is the horizontal offset from drawFramesetter
        CGFloat flushFactor = 0.0f;
        if (self.textAlignment == NSTextAlignmentCenter) {
            flushFactor = 0.5f;
        }
        else if (self.textAlignment == NSTextAlignmentRight) {
            flushFactor = 1.0f;
        }
        
        CGFloat penOffset = (CGFloat)CTLineGetPenOffsetForFlush(line, flushFactor, textRect.size.width);
        lineOrigin.x = penOffset;
        
        // Check if we've already passed the line
        if (p.y > yMax) {
            break;
        }
        // Check if the point is within this line vertically
        if (p.y >= yMin) {
            // Check if the point is within this line horizontally
            if (p.x >= lineOrigin.x && p.x <= lineOrigin.x + width) {
                // Convert CT coordinates to line-relative coordinates
                CGPoint relativePoint = CGPointMake(p.x - lineOrigin.x, p.y - lineOrigin.y);
                idx = CTLineGetStringIndexForPosition(line, relativePoint);
                break;
            }
        }
    }
    
    CFRelease(frame);
    CFRelease(path);
    
    return idx;
}

@end
