# A-ClickableLabel
A clickable and replaceable label, you can define touch event for each character.

### Demo
![demo gif](https://raw.githubusercontent.com/Animaxx/A-ClickableLabel/master/demo.gif)

### Classes
**A_AttributedStringBuilder** is for generating custom style for your label; it can apply to either the whole sentence or a clickable element.

**A_ClickableElement** representing a clickable and replaceable element in the label.

**A_ClickedAdditionalInformation** included all infomration about the click event: clicked point, baseline point, clicked at which character, clicked at which line ,and current word.

**A_ClickableLabel** derived from UILabel for handle clickable and replaceable events.

### Usage
```objective-c
[self.demoLabel setSentence:@"Hello %@." // set the sentence as "Hello world"

				// set style for whole sentence
                withBuilder:[[A_AttributedStringBuilder createWithSystemFontSize:14] setUnderline:YES]

                 // the "world" is the clickable element in this label
                 andElement:[A_ClickableElement create:@"world"

                 						   // set the style for this element
                                           withBuilder:[[A_AttributedStringBuilder createWithSystemFontSize:18] setUnderlineColor:[UIColor redColor]]
                                              andClick:^(A_ClickableElement *element, A_ClickableLabel *sender, A_ClickedAdditionalInformation *info) {
                                                  
                                                  // when user click on the element, update the style
                                                  [element.styleBuilder setUnderlineColor:[UIColor greenColor]];
                                                  
                                              }], nil
 ];
```