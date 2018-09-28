//
//  MyCustomType.swift
//  Example App
//
//  Created by Roman Gille on 28.09.18.
//  Copyright © 2018 Roman Gille. All rights reserved.
//

import EliminationMenu

struct MyCustomType: EliminationMenuItem {
    
    var title: String {
        return String(describing: someOtherProperty)
    }
    
    var value: Any? {
        return customProperty
    }
    
    let customProperty: Bool
    let someOtherProperty: Int
    
}


