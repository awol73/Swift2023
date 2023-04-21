import Foundation
import PlaygroundSupport


public func fetchArtistReleases(config : URLSessionConfiguration, session : URLSession, master id : String) {
    
    let token = "kPQUnehGPhmJuSakPPSwxAPVLkYNAvaMjJLEjpnS"
    
    let urlString = "https://api.discogs.com/masters/\(id)?token=\(token)"
    let url = URL(string: urlString)!
    var request = URLRequest(url: url)
    
    
    
    /* Creo el request */
    request.setValue("FooBarApp/3.0", forHTTPHeaderField: "user-agent")
    
    /* Ejecuto el request y despues capturo los datos con el closure */
    let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
        
        defer {
            PlaygroundPage.current.finishExecution()
        }
        
        guard let jsonData = data else {
            print("Erro al leer los datos del request")
            return
        }
        
        do {
            let datosDeserializados = try JSONSerialization.jsonObject(with: jsonData, options: [])
            
            //print(datosDeserializados)
            
            /* Luego de deserealizar casteo a un diccionario */
            guard let album = datosDeserializados as? [String: Any] else {
                print("Error en el casteo del json al dictionary.")
                return
            }
            
            let traks:Array<Any> = album["tracklist"] as! Array<Any>
            let track0 = traks[0]
            
            /*
            print("@@@@@@@@@@ \(track0)")
            */
            
            /*
            let demodic = track0 as! [String:Any] //let demodic = track0 as! NSDictionary
            */
            
            traks.forEach({ track in
                let auxTheme = track as! [String:Any]
                print("\(auxTheme["title"] ?? "")")
            })
            
            //print("????????? \(demodic["title"])")
            
            
            /*
            guard let track0 = traks[0] as? [String: Any] else {
                return
            }
             */
            
            
            
            //print(album)
            
        } catch {
            print(error)
        }
        
    })
    
    task.resume()
}

