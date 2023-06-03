# VDLayout: Methods and Extensions

This document outlines the primary methods and extensions provided by the VDLayout library.

## UIView Extensions

This extension for UIView objects provides chainable methods for various common UIView properties. This allows for more readable and concise code when setting up views. 

Here are the provided chainable methods:

### Appearance

- `cornerRadius(_:)`: Apply a corner radius to the view.
- `alpha(_:)`: Change the transparency of the view.
- `backgroundColor(_:)`: Fill the view with a color.
- `border(color:width:)`: Set the border color and width for the view.
- `shadowed(color:opacity:offset:radius:)`: Apply shadow to the view with given color, opacity, offset, and radius.

### Layout and User Interaction

- `clipped(_:)`: Set the clipping behaviour of the view.
- `userInteractionEnabled(_:)`: Enable or disable user interaction on the view.
- `contentMode(_:)`: Set the view's content mode (how content is laid out within its bounds).
- `hidden(_:)`: Hide or unhide the view.

### Margins and Padding

- `margins(_:)`: Set margins for the view.
- `padding(_:)`: Add padding to the view.

### Restoration Identifiers

- `restorationID(_:)`: Assign a restoration identifier to the view.
- `restorationID(file:line:function:)`: Assign a restoration identifier to the view using file, line, and function information.

### Content Hierarchy

- `UIView.subview(_:)`: Creates a view with subviews.
- `subview(_:)`: Add a subview to the view.
- `scrollable(_:showsIndicators:bounce:)`: Make the view scrollable.

### Content Prioritization and Layout

- `contentPriority(_:axis:type:)`: Set the content's priority for the view.

### Example

Here's an example of how you could use these extensions to configure a view:

```swift
UIView().chain
    .cornerRadius(10)
    .alpha(0.5)
    .backgroundColor(.blue)
    .border(color: .red, width: 2)
    .userInteractionEnabled()
    .hidden()
    .padding(5)
    .restorationID("exampleView")
    .contentPriority(.required, axis: .horizontal, type: .compression)
```

This code creates a new UIView, sets up a bunch of properties, adds a subview to it, and sets up some layout properties—all in a clean and readable way.

## UIStackView

- `vertical(_ spacing: CGFloat = .zero)`: Set the stack view to a vertical arrangement with optional spacing.
- `horizontal(_ spacing: CGFloat = .zero)`: Set the stack view to a horizontal arrangement with optional spacing.
- `alignment(_ alignment: UIStackView.Alignment)`: Set the alignment of the stack view.
- `distribution(_ distribution: UIStackView.Distribution)`: Set the distribution of the stack view.
- `margins(...)`: Various methods to set the margins of the stack view.
- `layoutMargins(_ insets: UIEdgeInsets)`: Set the layout margins of the stack view.
- `UIStackView.V(...)`: Static function to create a vertically arranged stack view.
- `UIStackView.H(...)`: Static function to create a horizontally arranged stack view.

## UIScrollView

- `bounces(_ axis: NSLayoutConstraint.AxisSet = .both)`: Set whether the scroll view should bounces at the end of scrollable content.
- `showsIndicators(_ axis: NSLayoutConstraint.AxisSet = .both)`: Control the visibility of scroll indicators.
- `hideIndicators()`: Hide scroll indicators.
- `paging(isEnabled: Bool = true)`: Enable or disable paging mode.
- `multitouch(isEnabled: Bool = true)`: Enable or disable multitouch events.
- `directionalLock(isEnabled: Bool = true)`: Enable or disable directional lock.
- `UIScrollView.V(...)`: Static function to create a vertically arranged scroll view.
- `UIScrollView.H(...)`: Static function to create a horizontally arranged scroll view.

## UIImageView

- `image(_ image: UIImage?)`: Set an image for the image view.
- `tinted(with color: UIColor?)`: Apply a tint color to the image view.

## UILabel

- `alignment(_ alignment: NSTextAlignment)`: Set the text alignment of the label.
- `multiline()`: Configure the label for multiline text display.
- `linesLimit(_ limit: Int)`: Set the maximum number of lines.
- `text(_ text: String)`: Set the text of the label.
- `attributedText(_ text: NSAttributedString)`: Set the attributed text of the label.
- `strikeThrough(_ text: String)`: Apply strikethrough style to the given text.
- `lineHeightMultiple(_ lineHeightMultiple: CGFloat)`: Set the line height multiple.
- `kern(_ kern: CGFloat)`: Adjust the kerning.
- `lineBreakMode(_ lineBreakMode: NSLineBreakMode)`: Set the line break mode.
- `font(_ font: UIFont, adjustsFontSizeToFitWidth: Bool = false)`: Set the font of the label and optionally allow the font size to adjust to fit the label's width.
- `textColor(_ color: UIColor)`: Set the text color of the label.

## UITextField

- `alignment(_ alignment: NSTextAlignment)`: Set the text alignment of the text field.
- `font(_ font: UIFont)`: Set the font of the text field.
- `textColor(_ color: UIColor)`: Set the text color of the text field.
- `tintColor(_ color: UIColor)`: Set the tint color of the text field.
- `keyboard(type: UIKeyboardType)`: Set the keyboard type of the text field.
- `placeholder(_ placeholder: String)`: Set the placeholder of the text field.
- `enabled(_ isEnabled: Bool = true)`: Set the enabled state of the text field.
- `autocorrectionType(_ autocorrectionType: UITextAutocorrectionType)`: Set the autocorrection type of the text field.

## UITextView

- `multiline()`: Configure the text view for multiline text display.
- `removePaddings()`: Remove padding from the text view.
- `font(_ font: UIFont)`: Set the font of the text view.
- `textColor(_ color: UIColor)`: Set the text color of the text view.
- `alignment(_ alignment: NSTextAlignment)`: Set the text alignment of the text view.
- `linesLimit(_ limit: Int)`: Set the maximum number of lines in the text view.
- `attributedText(_ attributedText: NSAttributedString)`: Set the attributed text of the text view.

## [ViewCellsReloadable](ReloadableViews.md)

- `reload(...)`: Various methods for reloading data in view cells.