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

public extension EliminationMenu {
    
    // MARK: - Class: Item
    
    /**
     An item representing a menu entry in EliminationMenu.
     */
    public class Item {
        /// The title that will be shown in the menu.
        open var title: String = ""
        /// The icon that will be shown in the menu.
        open var icon: UIImage?
        /// The object that you will receive in the selectionHandler.
        open var value: Any!
        /// These insets will also set titleInsets and contentInsets of the items entry button.
        open var iconInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        /**
         - parameter value: The value that will be passed to the selection handler.
         - parameter title: An optional text that is shown as menu entry.
         - parameter icon: An optional image. Shown before the title in the menu entry.
         */
        public init(value:Any, title: String = "", icon: UIImage? = nil) {
            self.title = title
            self.value = value
            self.icon = icon
        }
    }
    
}
