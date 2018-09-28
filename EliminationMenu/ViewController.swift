//
//  ViewController.swift
//  EliminationMenu
//
//  Created by Roman Gille on 14.04.16.
//  Copyright © 2016 Roman Gille. All rights reserved.
//

import UIKit
import EliminationMenu

class ViewController: UIViewController {
    
    @IBOutlet weak var eliminationMenu: EliminationMenu!
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
            Set up the menu created in interface builder.
        */
        
        eliminationMenu.font = .boldSystemFont(ofSize: 24)
        eliminationMenu.color = .white
        
        eliminationMenu.selectionHandler = { item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\""
            if let value = item.value {
                self.infoLabel.text?.append( "\n\nThe value is:\n\"\(value)\"" )
            }
        }
        
        eliminationMenu.items = [
            EliminationMenu.Item(value: "SomeValue", title: "First"),
            // String already conforms to EliminationMenuItem an can be used out of the box.
            "Just a String",
            EliminationMenu.Item(value: "This could also be an Image", title: "Third"),
            EliminationMenu.Item(value: "...or a view", title: "Fourth"),
            // Add an Element of MyCustomType which conforms to EliminationMenuItem.
            MyCustomType(customProperty: true, someOtherProperty: 5)
        ]
      
        /**
            Create menu in code.
            Using the convenience function.
         */
        
        let topRightMenuItems = [
            EliminationMenu.Item(value: UIColor(red: 57/255, green: 61/255, blue: 66/255, alpha: 1) , title: "Gray"),
            EliminationMenu.Item(value: UIColor.blue, title: "Blue"),
            EliminationMenu.Item(value: UIColor.red, title: "Red"),
            EliminationMenu.Item(value: UIColor.green, title: "Green")
        ]
      
        let topRightMenu = EliminationMenu.createMenu(
            withItems: topRightMenuItems,
            inView: view,
            aligned: .topRight,
            margin: CGPoint(x: 20, y: 20)
        ) { (item) in
            // Animate the backgroundColor of the view.
            if let color = item.value as? UIColor {
                UIView.animate(withDuration: 0.5, animations: {
                    self.view.backgroundColor = color
                })
            }
        }
        
        // A little customization.
        topRightMenu.font = .boldSystemFont(ofSize: 24)
        topRightMenu.color = .white
        // Call this after changing layout properties of an already added menu to apply the changes.
        topRightMenu.setup()
        
        /**
            Create menu in code.
            Manually adding it to the view and setting constraints.
        */
        
        let rightMenu = EliminationMenu()
        
        rightMenu.selectionHandler = {item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\""
            if let value = item.value {
                self.infoLabel.text?.append( "\n\nThe value is:\n\"\(value)\"" )
            }
        }
        
        rightMenu.items = [
            EliminationMenu.Item(value: "Layer over layer.", icon: UIImage(named: "fabric")),
            EliminationMenu.Item(value: "There was this browser...", icon: UIImage(named: "safari")),
            EliminationMenu.Item(value: "Save to disk.", icon: UIImage(named: "disk")),
            EliminationMenu.Item(value: "Mic check. One, two...", icon: UIImage(named: "check")),
            EliminationMenu.Item(value: "To the heart!", icon: UIImage(named: "heart"))
        ]
        
        rightMenu.align = .bottomRight
        
        // Add menu to layout.
        
        rightMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightMenu)
        
        view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: rightMenu, attribute: .right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: rightMenu, attribute: .bottom, multiplier: 1, constant: 20)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

