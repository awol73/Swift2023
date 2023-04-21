/*
 Swift Cookbook
 Keith Moon
 https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewBook?id=0
 Basado en un ejemplo del libro pero llamando a API de Discogs.
*/

import UIKit
import Foundation
import PlaygroundSupport

struct Pagination {
    let items : Int
    let page : Int
    let pages : Int
    let per_page : Int
    let urls : String
}

struct Release {
    let id : Int
    let status : String
    let type : String
    let format : String
    let label : String
    let title : String
    let resource_url : String
    let role : String
    let artist : String
    let year : Int
    let thumb : String
    let stats : Any
}


struct releases {
    let pagination : Pagination
    let releases : [Release]
}

var greeting = "Hello, Discogs"

PlaygroundPage.current.needsIndefiniteExecution = true

let config = URLSessionConfiguration.default
let session = URLSession(configuration: config)
let token = "kPQUnehGPhmJuSakPPSwxAPVLkYNAvaMjJLEjpnS"

func fetchRepos(forArtistID artist_id: String) {
    
    let urlString = "https://api.discogs.com/artists/\(artist_id)/releases?token=\(token)"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    
    //request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
    request.setValue("FooBarApp/3.0", forHTTPHeaderField: "user-agent")
    
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
            /*
            guard let repos = deserialised as? [[String: Any]] else {
                print("Error en el casteo.")
                return
            }*/
            
            // En el caso de la API de discogs casteo a un
            // diccionario de Objetos [String: Any]
            // En caso de otras APIs podria ser Array de
            // Diccionario de objetos [[String: Any]]
            guard let repos = deserialised as? [String: Any] else {
                print("Error en el casteo.")
                return
            }
            
            print("****** Resultado del Casteo: ******")
            print(repos)
            
            
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
//fetchRepos(forArtistID: "162564")

// Corazon de Leon: master: "1827681"
// Masters: Astor Piazzolla: 291591, 438644,
// Garbage: 26107 2164747
//
fetchArtistReleases(config: config, session: session, master: "2164747")
