//
//  ViewController.swift
//  EliminationMenu
//
//  Created by Roman Gille on 14.04.16.
//  Copyright © 2016 Roman Gille. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var eliminationMenu: EliminationMenu!
    @IBOutlet weak var infoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
            Set up the menu created in interface builder.
        */
        
        eliminationMenu.font = UIFont.boldSystemFontOfSize(24)
        eliminationMenu.color = UIColor.whiteColor()
        
        eliminationMenu.selectionHandler = {item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\"\n\nThe value is:\n\"\(item.value)\""
        }
        
        eliminationMenu.items = [
            EliminationMenu.Item(value: "SomeValue", title: "First"),
            EliminationMenu.Item(value: "SomeOtherValue", title: "Second"),
            EliminationMenu.Item(value: "This could also be an Image", title: "Third"),
            EliminationMenu.Item(value: "...or a view", title: "Fourth")
        ]
        
        /**
            Create menu in code.
            Using the convenience function.
         */
        
        let topRightMenuItems = [
            EliminationMenu.Item(value: UIColor(red: 57/255, green: 61/255, blue: 66/255, alpha: 1) , title: "Gray"),
            EliminationMenu.Item(value: UIColor.blueColor(), title: "Blue"),
            EliminationMenu.Item(value: UIColor.redColor(), title: "Red"),
            EliminationMenu.Item(value: UIColor.greenColor(), title: "Green")
        ]
        
        let topRightMenu = EliminationMenu.createMenu(withItems: topRightMenuItems, inView: view, aligned: .TopRight, margin: CGPoint(x: 20, y: 20)) { (item) in
            // Animate the backgroundColor of the view.
            if let color = item.value as? UIColor {
                UIView.animateWithDuration(0.5, animations: {
                    self.view.backgroundColor = color
                })
            }
        }
        
        // A little customization.
        topRightMenu.font = UIFont.boldSystemFontOfSize(24)
        topRightMenu.color = UIColor.whiteColor()
        // Call this after changing layout properties of an already added menu to apply the changes.
        topRightMenu.setup()
        
        /**
            Create menu in code.
            Manually adding it to the view and setting constraints.
        */
        
        let rightMenu = EliminationMenu()
        
        rightMenu.selectionHandler = {item in
            self.infoLabel.text = "Selected item:\n\"\(item.title)\"\n\nThe value is:\n\"\(item.value)\""
        }
        
        rightMenu.items = [
            EliminationMenu.Item(value: "Layer over layer.", icon: UIImage(named: "fabric")),
            EliminationMenu.Item(value: "There was this browser...", icon: UIImage(named: "safari")),
            EliminationMenu.Item(value: "Save to disk.", icon: UIImage(named: "disk")),
            EliminationMenu.Item(value: "Mic check. One, two...", icon: UIImage(named: "check")),
            EliminationMenu.Item(value: "To the heart!", icon: UIImage(named: "heart"))
        ]
        
        rightMenu.align = .BottomRight
        
        // Add menu to layout.
        
        rightMenu.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rightMenu)
        
        view.addConstraints([
            NSLayoutConstraint(item: view, attribute: .Right, relatedBy: .Equal, toItem: rightMenu, attribute: .Right, multiplier: 1, constant: 20),
            NSLayoutConstraint(item: view, attribute: .Bottom, relatedBy: .Equal, toItem: rightMenu, attribute: .Bottom, multiplier: 1, constant: 20)
            ])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

