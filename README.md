Run Buddy
====================

This project utilizes [Generative AI](https://www.linkedin.com/in/waynebishop) to help runners plan their next training run or event. Implemented in Swift, Run Buddy integrates training, location and statistical weather information with Google's [Gemini API](https://ai.google.dev) to provide answers for frequently asked running questions. This includes suggested strategies for nutrition, hydration, clothing and overall performance. 

Audience
---------------------

To best utilize this project, you should already be familiar with the basics of Swift. This project also aims to provide an alternative for learning the basics of adding **Generative AI** to a project or existing workflow. While many Run Buddy concepts are functional, users are welcome to submit pull requests for new features or to complete stubbed areas of planned functionality. To userstand the code, developers should be familar with Swift-specific features such as optionals, extensions, protocols and generics. Beyond Swift, audiences should be familiar with **Singleton** and **Factory** and **Binding** design patterns along with sets, arrays and dictionaries.

```swift 
let model = newTextModel(with: key)

let prompt: String = prompt
let contentStream = model.generateContentStream(prompt)
        
do {
    for try await chunk in contentStream {
        if let text = chunk.text {
            print(text)
            
            //update published property on main thread
            DispatchQueue.main.async {
                self.chunkResponse += text
            }
        }
    }
} //end do
catch {
    //throw general exception
    print("something went wrong..")
    throw error
}
```

Configuration
---------------------

To run this project, you will need to provide your own API key and set up the configuration file. Follow these steps:

1. Create a new file called `BuddyConfig.plist` in the project directory.
2. Open the `BuddyConfig.plist` file and add the following content, replacing `MyApiKey` with your actual API key:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>MyAPIKey</key>
    <string>your_api_key_value_here</string>
</dict>
</plist>
```

Usage
--------------------

Individuals are welcome to use the code with commercial and open-source projects. As a courtesy, please provide attribution to [Wayne Bishop](https://www.linkedin.com/in/waynebishop). For more information, review the complete [license agreement](https://github.com/waynewbishop/SwiftStructures/blob/master/License.md). 


Questions
--------------------

Have a question? Feel free to contact me on [LinkedIn](https://www.linkedin.com/in/waynebishop)</a>.
