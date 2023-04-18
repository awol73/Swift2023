/*
 Swift Cookbook
 Keith Moon
 https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewBook?id=0
*/

import UIKit
import Foundation
import PlaygroundSupport


var greeting = "Hello, playground"

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)

func fetchRepos(forUsername username: String) {
    
    let urlString = "https://api.github.com/users/\(username)/repos"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    
    request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    
    // dataTask es la encargada de realizar el request. Cuando lo el server
    // le da la respuesta entonces se ejecuta el closure que le pasamos
    // como parametro a continuacion.
    //
    let task = session.dataTask(with: request) { (data, response, error) in
        
        // Una vez que ya recibido la respuesta ya podemos
        // liberar al Playground.
        defer {
            PlaygroundPage.current.finishExecution()
        }
        
        // Primero hacemos un unwrap del optional data
        // Esta tecnica se puede ver tambien en el libro de
        // Jon Hoffman - Mastering Swift 5.3
        guard let jsonData = data else {
            print(error ?? "Network Error")
            return
        }
        
        do {
            let deserialised = try JSONSerialization.jsonObject(with: jsonData, options: [])
            print(deserialised)
            
            // Casteo del json a un array de diccionarios
            // deserialized es del tipo Any entonces necesitamos
            // castearlo a lagun tipo de datos.
            //
            guard let repos = deserialised as? [[String: Any]] else {
                print("Error en el casteo.")
                return
            }
            
            //print(repos)
            
        } catch {
            print(error)
        }
    }
    
    // Llamada a task para que ejecute el request
    // declarado anteriormente.
    //
    task.resume()
    
}

//fetchRepos(forUsername: "PacktPublishing")
fetchRepos(forUsername: "awol73")
