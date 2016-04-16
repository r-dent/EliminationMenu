//  Copyright (c) 2016 Roman Gille, http://romangille.com
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

public class EliminationMenu: UIView {
    
    public var align = UIControlContentHorizontalAlignment.Left
    public var font = UIFont.systemFontOfSize(UIFont.systemFontSize());
    public var color = UIColor.darkTextColor();
    public var buttonAnimationOffset = CGFloat(50)
    public var showAnimationDuration = NSTimeInterval(0.4)
    public var selectAnimationDuration = NSTimeInterval(0.25)
    public var margin = CGFloat(0)
    public var buttonHeight = CGFloat(44.0)
    
    public var selectionHandler: (selectedIdtem:Item) -> Void = {arg in};
    public var willAnimateHandler: (opening:Bool, animated:Bool) -> Void = {arg in};
    public var didAnimateHandler: (opening:Bool, animated:Bool) -> Void = {arg in};
    
    var buttons = [UIButton]()
    var extended = false
    
    private var _items = [Item]();
    private var _selectedIndex = 0;
    let tagOffset = 10;
    
    public var items: [Item] {
        get {return _items}
        set {
            if _items.count > 0 {
                for subview in self.subviews {
                    subview.removeFromSuperview()
                }
            }
            
            // Create first button.
            if buttons.count == 0 {
                let menuItem = newValue[0];
                let button = self.createButton(menuItem, tag: tagOffset);
                
                button.frame = CGRectMake(0, 0, max(button.intrinsicContentSize().width, self.bounds.size.width), self.buttonHeight);
                
                buttons.append(button)
                self.addSubview(button);
                
                self.invalidateIntrinsicContentSize();
            }
            
            _items = newValue;
            _selectedIndex = 0;
        }
    }
    
    var mainButton: UIButton {
        get {
            return buttonFor(_selectedIndex)!;
        }
    }
    
    func buttonPressed(sender: UIView) {
        let index = sender.tag - tagOffset;
        
        if (index == _selectedIndex) {
            show((buttons.count < 2), animated: true);
        }
        else {
            select(sender.tag - tagOffset, animated: true);
        }
    }
    
    func buttonFor(index: Int) -> UIButton? {
        return self.viewWithTag(tagOffset + index) as? UIButton;
    }
    
    func createButton(item:Item, tag:Int) -> UIButton {
        let button = UIButton();
        
        button.setTitle(item.title, forState: .Normal);
        button.setImage(item.icon, forState: .Normal);
        button.contentHorizontalAlignment = self.align;
        button.tag = tag;
        button.titleLabel?.font = self.font;
        button.setTitleColor(color, forState: .Normal);
        button.addTarget(self, action: #selector(buttonPressed), forControlEvents: .TouchUpInside);
        
        setIconInsets(item.iconInsets, button: button);
        
        return button;
    }
    
    func setIconInsets(iconInsets:UIEdgeInsets, button:UIButton) {
        button.imageEdgeInsets = UIEdgeInsets(top: iconInsets.top, left: iconInsets.left, bottom: iconInsets.bottom, right: 0);
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: iconInsets.right, bottom: 0, right: -iconInsets.right);
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: iconInsets.right);
    }
    
    func show(show: Bool, animated: Bool) {
        if show {
            var buttonIndex = 0;
            var buttonY:CGFloat = 0;
            
            self.willAnimateHandler(opening: true, animated:animated);
            
            // Add buttons for unselected items.
            for titleIndex in 0..<_items.count {
                if titleIndex != _selectedIndex {
                    let menuItem = _items[titleIndex];
                    let button = self.createButton(menuItem, tag: titleIndex + tagOffset);
                    
                    button.frame = CGRectMake(0, buttonY * CGFloat(buttonIndex ), button.intrinsicContentSize().width, self.buttonHeight);
                    
                    buttons.append(button)
                    self.addSubview(button);
                    buttonY = self.buttonHeight + margin;
                    buttonIndex += 1
                }
            }
            
            // Set all buttons to the same width and transform them out of viewport.
            let maxWidth = max(self.intrinsicContentSize().width, self.bounds.size.width);
            for i in 0..<buttons.count {
                let button = buttons[i]
                button.frame = CGRect(origin: button.frame.origin, size: CGSize(width: maxWidth, height: button.frame.size.height));
                
                if button.tag != _selectedIndex + tagOffset {
                    let xOffset = (CGFloat(buttons.count) * buttonAnimationOffset) - (buttonAnimationOffset * CGFloat(i));
                    
                    if (self.align == .Right) {
                        button.transform = CGAffineTransformMakeTranslation(maxWidth + xOffset, 0);
                    }
                    else {
                        button.transform = CGAffineTransformMakeTranslation(-xOffset, 0);
                    }
                }
            }
            
            mainButton.frame = CGRectMake(0, buttonY * CGFloat(buttons.count - 1), maxWidth, self.buttonHeight);
            
            // Update content size.
            self.invalidateIntrinsicContentSize();
            
            // Slide in buttons.
            UIView.animateWithDuration(showAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                for button in self.buttons {
                    button.transform = CGAffineTransformIdentity;
                }
            }, completion:{(success) -> Void in
                self.didAnimateHandler(opening: true, animated:animated);
            });
        }
        else {
            self.select(_selectedIndex, animated: animated);
        }
    }
    
    func select(index: Int?, animated: Bool) {
        let selectedIndex: Int = index ?? 0;
        let menuItem = _items[selectedIndex];
        
        if buttons.count > 1 {
            let selectionDidChange = mainButton.titleForState(.Normal) != menuItem.title;
            
            if selectionDidChange {
                self.selectionHandler(selectedIdtem: menuItem);
            }
            self.willAnimateHandler(opening: false, animated:animated);
            
            let selectedButton = buttonFor(selectedIndex);
            let selectionTargetFrame = CGRect(origin: self.mainButton.frame.origin, size: selectedButton!.frame.size);
            let nonSelectedTransfromation = CGAffineTransformMakeTranslation(0, self.frame.size.height - selectedButton!.frame.origin.y - selectedButton!.frame.size.height);
            
            UIView.animateWithDuration((animated ? selectAnimationDuration : 0), animations: { () -> Void in
                for button in self.buttons {
                    if button != selectedButton {
                        button.transform = nonSelectedTransfromation;
                        button.alpha = 0;
                    }
                }
                
                selectedButton?.frame = selectionTargetFrame;

            }, completion: { (success) -> Void in
                // Remove hidden buttons.
                for button in self.buttons {
                    if button != selectedButton {
                        button.removeFromSuperview()
                        
                        if let index = self.buttons.indexOf(button) {
                            self.buttons.removeAtIndex(index)
                        }
                    }
                }
                // Correct main button position.
                selectedButton?.frame = CGRect(
                    origin: CGPoint(x: 0, y: 0),
                    size: CGSize(width: selectedButton!.intrinsicContentSize().width, height: self.buttonHeight)
                );
                
                self._selectedIndex = selectedIndex;
                self.invalidateIntrinsicContentSize();
                
                self.didAnimateHandler(opening: true, animated:animated);
            })
        }
        else {
            selectionHandler(selectedIdtem: menuItem);
            self.willAnimateHandler(opening: false, animated:animated);
            
            mainButton.setTitle(menuItem.title, forState: .Normal);
            mainButton.setImage(menuItem.icon, forState: .Normal);
            
            setIconInsets(menuItem.iconInsets, button: mainButton);
            
            mainButton.frame = CGRect(
                origin: mainButton.frame.origin,
                size: CGSize(width: mainButton.intrinsicContentSize().width, height: self.buttonHeight)
            );
            mainButton.tag = selectedIndex + tagOffset;
            _selectedIndex = selectedIndex;
            
            self.didAnimateHandler(opening: true, animated:animated);
        }
    }
    
    func selectEntryWithValue(value: AnyObject!, animated: Bool) {
        for i in 0..<items.count {
            if items[i].value.isEqual(value) {
                select(i, animated: animated);
            }
        }
    }
    
    override public func intrinsicContentSize() -> CGSize {
        if buttons.count > 0 {
            var width: CGFloat = 0;
            var height: CGFloat = -margin;
            
            for button in buttons {
                let contentSize = button.intrinsicContentSize();
                height += self.buttonHeight + margin;
                if contentSize.width > width {
                    width = contentSize.width;
                }
            }
            return CGSizeMake(width, height);
        }
        return CGSizeMake(0, 0);
    }
    
    
    public class Item {
        public var title: String = "";
        public var icon: UIImage?;
        public var value: AnyObject!;
        public var iconInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        
        init(title:String, value:AnyObject!) {
            self.title = title;
            self.value = value;
        }
        
        init(title:String, value:AnyObject!, icon:UIImage) {
            self.title = title;
            self.value = value;
            self.icon = icon;
        }
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
