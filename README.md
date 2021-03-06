# EliminationMenu
[![Travis](https://img.shields.io/travis/r-dent/EliminationMenu.svg)](https://travis-ci.org/r-dent/EliminationMenu)
[![CocoaPods](https://img.shields.io/cocoapods/v/EliminationMenu.svg)](http://cocoadocs.org/docsets/EliminationMenu)
[![CocoaPods](https://img.shields.io/cocoapods/l/EliminationMenu.svg)](LICENSE)
[![Platform](https://img.shields.io/cocoapods/p/EliminationMenu.svg)](http://cocoadocs.org/docsets/EliminationMenu)

Some kind of menu that eliminates all values which were not selected.

<p align="center" >
    <img src="https://raw.githubusercontent.com/r-dent/EliminationMenu/master/Resources/EliminationMenu.gif" />
</p>

## Installation

Just drag the Folder `Sources` into your project.

### Cocoapods

If you´re using [CocoaPods](https://cocoapods.org), add this to your Podfile: 

	pod EliminationMenu

### Swift Package Manager

To add EliminationMenu to a [Swift Package Manager](https://swift.org/package-manager/) based project, add the following:

```swift
.package(url: "https://github.com/r-dent/EliminationMenu", from: "1.0.2")
```

to the `dependencies` value of your `Package.swift`.

	
## Usage

You can create an EliminationMenu view in Interface Builder or in code.
            
### Create entries
    
To set up the entries, create an array of instances conforming to `EliminationMenuItem` and set it to the `items` property of the menu object.

```swift
let menuEntries = [
    EliminationMenu.Item(value: "SomeValue", title: "First"),
    EliminationMenu.Item(value: "SomeOtherValue", title: "Second"),
    EliminationMenu.Item(value: UIImage(named: "filename"), title: "Third"), // You can use values of any kind.
    EliminationMenu.Item(value: "...or a view", title: "Fourth"),
    "Just a String",
    MyCustomType(customProperty: true, someOtherProperty: 5)
]
menu.items = menuEntries
```

*Hint*: The default type `EliminationMenu.Item` can be used to populate the menu. But you can also make your own types conform to `EliminationMenuItem` and use them directly.
`String` already conforms to it. So you can use Strings as menu items. See the example project for an overview.
    
### Create Menu

Use the convenience method to create a menu and add it as a subview to your view controllers view.

```swift
let menu = EliminationMenu.createMenu(withItems: menuEntries, inView: view, aligned: .topRight, margin: CGPoint(x: 0, y: 20)) { (item) in
	print("Selected value: \(item.value)")
}
```

If you want to use Interface Builder, just add a `UIView` and pin 2 of its edges (vertical and horizontal). Set `EliminationMenu` as the views class. Also add a width and a height constraint to supress warnings. Enable "_Remove at build time_" on the size constraints. The menu will get an intrinsic size at runtime.

You can also create an instance of `EliminationMenu` and constrain it yourself in a superview. Be shure to call `menu.setup()` after all.

See the [example code](EliminationMenu/ViewController.swift) for a better insight.
    
### Customize

You can customize the properties of your menu like this:

```swift
menu.font = UIFont.boldSystemFont(ofSize: 24)
menu.color = UIColor.white

menu.setup()
```
    
Be shure to call `menu.setup()` to apply your changes. See the [documentation](http://cocoadocs.org/docsets/EliminationMenu) for more ways to customize.

## License

`EliminationMenu` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.