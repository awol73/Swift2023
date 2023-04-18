
/*
 Excerpt From
 Swift Cookbook
 Keith Moon
 https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewBook?id=0
 This material may be protected by copyright.
 */

import PlaygroundSupport
import Foundation
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

let urlString = "https://imgs.xkcd.com/comics/api.png"
let url = URL(string: urlString)!
let request = URLRequest(url: url)

let task = session.dataTask(with: request, completionHandler: {(data, response, error) in
    guard let imageData = data else {
        return // No se retorno ningula imagen, handler error
    }
    _ = UIImage(data: imageData)
})

task.resume()

var greeting = "Hello, playground"
