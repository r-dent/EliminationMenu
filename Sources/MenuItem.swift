//
//  MenuItem.swift
//  RapScript
//
//  Created by Roman Gille on 26.06.15.
//  Copyright (c) 2015 RapScript. All rights reserved.
//

import UIKit

class MenuItem: NSObject {
    var title: String = "";
    var icon: UIImage?;
    var value: AnyObject!;
    var iconInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
    
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
