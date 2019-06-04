# Weather iOS Challenge

## Project Dependencies

This project uses Alamofire for HTTP requests.
In a much larger project, I would likely utilize .gitignore for packages, however for simplicity I have included this one.

Everything should work as is, however if not I have included steps to resolve

1. In the project root, I have the following Podfile:

```
target 'weather' do
  use_frameworks!

  # Pods for weather
  pod 'Alamofire'
end

```

To integrate Alamofire, navigate to the project root in Terminal

2. `pod install`

3. `open weather.xcworkspace`
