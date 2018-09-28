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

/// A menu that eliminates all values which were not selected.
open class EliminationMenu: UIView {
    
    /// The alignment to a corner of the parent view.
    public enum Alignment {
        case topLeft, topRight, bottomLeft, bottomRight
    }
    
    /// A closure that provides information about the selected menu item.
    public typealias SelectionHandler = (_ selectedIdtem: EliminationMenuItem) -> Void
    /// A closure that provides information about an animation that will or did happen.
    public typealias AnimationHandler = (_ opening: Bool, _ animated: Bool) -> Void
    
    /// The alignment of the menu. It defines from which direction the entries will fly in. Defaults to .BottomLeft
    open var align: Alignment = .bottomLeft
    /// The font used in the menu entry buttons. Defaults to systemFontSize().
    open var font: UIFont = .systemFont(ofSize: UIFont.systemFontSize)
    /// The color of the text in menu entries. Defaults to darkTextColor().
    open var color: UIColor = .darkText
    /// The amount of points, the menu entries are offset from the screen before fading tehm in. Defaults to 50.
    open var buttonAnimationOffset: CGFloat = 50
    /// The duration in seconds, that the show animation will take. Defaults to 0.4.
    open var showAnimationDuration: TimeInterval = 0.4
    /// The duration in seconds, that the selection animation will take. Defaults to 0.25.
    open var selectAnimationDuration: TimeInterval = 0.25
    /// Margin between the entry buttons. Defaults to 0.
    open var margin: CGFloat = 0
    /// The height of the menu entry buttons. Defaults to 44.
    open var buttonHeight: CGFloat = 44
    
    /// A closure to react on the selection of a menu entry. This will not fire when the selected value has not changed.
    open var selectionHandler: SelectionHandler?
    /// A closure to react on menu opening/closing. This will be called before the animation runs.
    open var willAnimateHandler: AnimationHandler?
    /// A closure to react on menu opening/closing. This will be called after the animation has finished.
    open var didAnimateHandler: AnimationHandler?
    
    var buttons: [UIButton] = []
    
    fileprivate var _selectedIndex = 0
    fileprivate let _tagOffset = 10

    fileprivate var isLeftAligned: Bool {
        return (align == .bottomLeft) || (align == .topLeft)
    }

    fileprivate var isBottomAligned: Bool {
        return (align == .bottomLeft) || (align == .bottomRight)
    }
    
    /// The entries of the menu. Setting this will reinitialize the menu.
    open var items: [EliminationMenuItem] = [] {
        didSet {
            setup()
        }
    }
    
    /// The button for the selected item. This is the one that you see when the menu is closed.
    var mainButton: UIButton {
        return getButton(atIndex: _selectedIndex)!
    }
    
    /**
        Convenience method to create a new menu in a given view and constrain it to some edges.
        - parameter items: A collection of EleminationMenu.Item objects.
        - parameter view: The view where the menu is added as subview.
        - parameter aligned: The corner in which the menu is placed.
        - parameter margin: The distance the menu will have to the edges of its superview.
        - parameter selection: The closure that will be called upon selection of a menu item.
    */
    open class func createMenu(withItems items: [EliminationMenuItem], inView view: UIView, aligned: Alignment, margin: CGPoint = CGPoint(x: 0, y: 0), selection: SelectionHandler? = nil) -> EliminationMenu {
        let menu = EliminationMenu()
        menu.selectionHandler = selection
        menu.align = aligned
        
        menu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(menu)
        
        if menu.isLeftAligned {
            view.addConstraint(NSLayoutConstraint(
                item: menu, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: margin.x)
            )
        }
        else {
            view.addConstraint(NSLayoutConstraint(
                item: view, attribute: .right, relatedBy: .equal, toItem: menu, attribute: .right, multiplier: 1, constant: margin.x)
            )
        }
        
        if menu.isBottomAligned {
            view.addConstraint(NSLayoutConstraint(
                item: view, attribute: .bottom, relatedBy: .equal, toItem: menu, attribute: .bottom, multiplier: 1, constant: margin.y)
            )
        }
        else {
            view.addConstraint(NSLayoutConstraint(
                item: view, attribute: .top, relatedBy: .equal, toItem: menu, attribute: .top, multiplier: 1, constant: -margin.y)
            )
        }
        
        menu.items = items
        
        return menu
    }
    
    /**
        Initializes the menu interface. Call this when you changed layout properties, to apply them.
        - parameter index: An optional index of a menu item to show selected after setup
    */
    open func setup(withSelectedIndex index: Int = 0) {
        // Clear existing buttons.
        if items.count > 0 {
            for subview in self.subviews {
                subview.removeFromSuperview()
            }
            buttons = []
        }
        
        guard items.count > 0 else {return}
        
        let safeIndex = (index < items.count) ? index : 0
        
        // Create first button.
        if buttons.count == 0 {
            let menuItem = items[safeIndex]
            let button = self.createButton(menuItem, tag: _tagOffset)
            
            button.frame = CGRect(x: 0, y: 0, width: max(button.intrinsicContentSize.width, self.bounds.size.width), height: self.buttonHeight)
            
            buttons.append(button)
            self.addSubview(button)
            
            self.invalidateIntrinsicContentSize()
        }
        
        _selectedIndex = safeIndex
    }
    
    @objc func buttonPressed(_ sender: UIView) {
        let index = sender.tag - _tagOffset
        
        if (index == _selectedIndex) {
            show((buttons.count < 2), animated: true)
        }
        else {
            select(sender.tag - _tagOffset, animated: true)
        }
    }
    
    func getButton(atIndex index: Int) -> UIButton? {
        return self.viewWithTag(_tagOffset + index) as? UIButton
    }
    
    func createButton(_ item:EliminationMenuItem, tag:Int) -> UIButton {
        let button = UIButton()
        
        button.setTitle(item.title, for: .normal)
        button.setImage(item.icon, for: .normal)
        button.contentHorizontalAlignment = (isLeftAligned) ? .left : .right
        button.tag = tag
        button.titleLabel?.font = self.font
        button.setTitleColor(color, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        setIconInsets(item.iconInsets, button: button)
        
        return button
    }
    
    func setIconInsets(_ iconInsets:UIEdgeInsets, button:UIButton) {
        button.imageEdgeInsets = UIEdgeInsets(top: iconInsets.top, left: iconInsets.left, bottom: iconInsets.bottom, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: iconInsets.right, bottom: 0, right: -iconInsets.right)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: iconInsets.right)
    }
    
    func show(_ show: Bool, animated: Bool) {
        if show {
            var buttonIndex = 0
            let buttonVerticalSpace = CGFloat(buttonHeight + margin)
            
            willAnimateHandler?(true, animated)
            
            // Add buttons for unselected items.
            for titleIndex in 0..<items.count {
                if titleIndex != _selectedIndex {
                    let menuItem = items[titleIndex]
                    let button = self.createButton(menuItem, tag: titleIndex + _tagOffset)
                    var buttonY = buttonVerticalSpace * CGFloat(buttonIndex)
                    
                    if !isBottomAligned {
                        buttonY += buttonVerticalSpace
                    }
                    
                    button.frame = CGRect(x: 0, y: buttonY, width: button.intrinsicContentSize.width, height: self.buttonHeight)
                    
                    buttons.append(button)
                    self.addSubview(button)
                    buttonIndex += 1
                }
            }
            
            // Set all buttons to the same width and transform them out of viewport.
            let maxWidth = max(self.intrinsicContentSize.width, self.bounds.size.width)
            for i in 0..<buttons.count {
                let button = buttons[i]
                button.frame = CGRect(origin: button.frame.origin, size: CGSize(width: maxWidth, height: button.frame.size.height))
                
                if button.tag != _selectedIndex + _tagOffset {
                    var xOffset = buttonAnimationOffset * CGFloat(i)
                    
                    if isBottomAligned {
                        xOffset = (CGFloat(buttons.count) * buttonAnimationOffset) - xOffset
                    }
                    
                    if isLeftAligned {
                        button.transform = CGAffineTransform(translationX: -xOffset, y: 0)
                    }
                    else {
                        button.transform = CGAffineTransform(translationX: maxWidth + xOffset, y: 0)
                    }
                }
            }
            
            let mainButtonY = isBottomAligned ? buttonVerticalSpace * CGFloat(buttons.count - 1) : 0
            mainButton.frame = CGRect(x: 0, y: mainButtonY, width: maxWidth, height: self.buttonHeight)
            
            // Update content size.
            self.invalidateIntrinsicContentSize()
            
            // Slide in buttons.
            UIView.animate(withDuration: showAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.3, options: .curveEaseIn, animations: { () -> Void in
                for button in self.buttons {
                    button.transform = CGAffineTransform.identity
                }
            }, completion:{(success) -> Void in
                self.didAnimateHandler?(true, animated)
            })
        }
        else {
            self.select(_selectedIndex, animated: animated)
        }
    }
    
    func select(_ index: Int?, animated: Bool) {
        let selectedIndex: Int = index ?? 0
        let menuItem = items[selectedIndex]
        
        if buttons.count > 1 {
            let selectionDidChange = _selectedIndex != selectedIndex
            
            if selectionDidChange {
                selectionHandler?(menuItem)
            }
            willAnimateHandler?(false, animated)
            
            
            let selectedButton = getButton(atIndex: selectedIndex)
            let selectionTargetFrame = CGRect(origin: self.mainButton.frame.origin, size: selectedButton!.frame.size)
            let nonSelectedAnimationY: CGFloat
            
            if isBottomAligned {
                nonSelectedAnimationY = frame.size.height - selectedButton!.frame.origin.y - selectedButton!.frame.size.height
            }
            else {
                nonSelectedAnimationY = -(selectedButton!.frame.origin.y)
            }
            
            let nonSelectedTransfromation = CGAffineTransform(translationX: 0, y: nonSelectedAnimationY)
            
            UIView.animate(withDuration: (animated ? selectAnimationDuration : 0), animations: { () -> Void in
                for button in self.buttons {
                    if button != selectedButton {
                        button.transform = nonSelectedTransfromation
                        button.alpha = 0
                    }
                }
                
                selectedButton?.frame = selectionTargetFrame

            }, completion: { (success) -> Void in
                // Remove hidden buttons.
                for button in self.buttons {
                    if button != selectedButton {
                        button.removeFromSuperview()
                        
                        if let index = self.buttons.index(of: button) {
                            self.buttons.remove(at: index)
                        }
                    }
                }
                // Correct main button position.
                selectedButton?.frame = CGRect(
                    origin: CGPoint(x: 0, y: 0),
                    size: CGSize(width: selectedButton!.intrinsicContentSize.width, height: self.buttonHeight)
                )
                
                self._selectedIndex = selectedIndex
                self.invalidateIntrinsicContentSize()
                
                self.didAnimateHandler?(true, animated)
            })
        }
        else {
            selectionHandler?(menuItem)
            willAnimateHandler?(false, animated)
            
            mainButton.setTitle(menuItem.title, for: .normal)
            mainButton.setImage(menuItem.icon, for: .normal)
            
            setIconInsets(menuItem.iconInsets, button: mainButton)
            
            mainButton.frame = CGRect(
                origin: mainButton.frame.origin,
                size: CGSize(width: mainButton.intrinsicContentSize.width, height: self.buttonHeight)
            )
            mainButton.tag = selectedIndex + _tagOffset
            _selectedIndex = selectedIndex
            
            didAnimateHandler?(true, animated)
        }
    }
    
    func selectEntryWithValue(_ value: AnyObject!, animated: Bool) {
        for i in 0..<items.count {
            if (items[i].value as AnyObject).isEqual(value) {
                select(i, animated: animated)
            }
        }
    }
  
    /// Provides size of the view depending on the frames of shown buttons.
    override open var intrinsicContentSize : CGSize {
        if buttons.count > 0 {
            var width: CGFloat = 0
            var height: CGFloat = -margin
            
            for button in buttons {
                let contentSize = button.intrinsicContentSize
                height += self.buttonHeight + margin
                if contentSize.width > width {
                    width = contentSize.width
                }
            }
            return CGSize(width: width, height: height)
        }
        
        return CGSize(width: 0, height: 0)
    }

}
