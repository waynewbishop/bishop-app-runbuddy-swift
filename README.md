Run Buddy
====================

This project utilizes [Generative AI](https://www.linkedin.com/in/waynebishop) to help runners plan their next training run or event. Implemented in Swift,  the combines statisical weather data with Google's [Gemini API](https://ai.google.dev) to provide answers for frequently asked running questions. Considerations include variables such as location, distance, altitude, time of day, humidity as well as weather-based information.

Audience
---------------------

'To best utilize this project, you should already be familiar with the basics of Swift. This code also aims to provide an alternative for learning the basics of working with data and SwiftUI. Code examples include many Swift-specific features such as optionals, extensions, protocols and generics. Beyond Swift, audiences should be familiar with **Singleton** and **Factory** design patterns along with sets, arrays and dictionaries.


```swift
    let model = newTextModel(with: key)
    let prompt: String = prompt

    // Use streaming with text-only input
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

Usage
--------------------

Individuals are welcome to use the code with commercial and open-source projects. As a courtesy, please provide attribution to [Wayne Bishop](https://www.linkedin.com/in/waynebishop). For more information, review the complete [license agreement](https://github.com/waynewbishop/SwiftStructures/blob/master/License.md). 


Questions
--------------------

Have a question? Feel free to contact me on [LinkedIn](https://www.linkedin.com/in/waynebishop)</a>.
