#  CountryPickerTextField

This class will show County code in textfield , Here developers have the option to see county name , code , short name through the Country Structure

`Country(id: "38", sortName: "CA", name: "Canada", code: "+1")`


### How to use  this class
 * Set class in storyboard
  *  Make outlet
   *  use closure

```swift
@IBOutlet weak var txtCountryCode: CountryPickerTextField!


in `viewDidLoad`
txtCountryCode.closureDidSelectCountry = { country in

print(country)

```
## UIPart

![alt text](https://github.com/vijayvir/SwiftUtilities/blob/master/CountryCodes/CountryCodes/counrtyCodeSnapshot.png "Logo Title Text 1")
