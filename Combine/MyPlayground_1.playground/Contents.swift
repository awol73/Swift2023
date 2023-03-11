import Foundation
import Combine

//
//public func example(of description: String, action: () -> Void) {
//    print("\n -- Example of: \(description). ---")
//    action()
//}

/* En este ejemplo (funcion example) la salida no proviene del publisher que obtuvimos
 * en el punto 2
 */

/*
example(of: "Publisher") { // Closure
    
    // 1 Creacion del nombre de una notificacion
    let myNotificacion = Notification.Name("MyNotification")
    
    // 2 Accedo al metodo default del NotificationCenter para obtener un publisher
    let publisher = NotificationCenter.default.publisher(for: myNotificacion, object: nil)
    
    // 3
    let center = NotificationCenter.default
    
    // 4
    let observer = center.addObserver(forName: myNotificacion, object: nil, queue: nil) { notificacion in
            print("Notificacion recibida!")
        
    }
    
    // 5
    center.post(name: myNotificacion, object: nil)
    
    // 6
    center.removeObserver(observer)
}
 
 */
 
//public func example2(of description: String, action: () -> Void) {
//    print("\n -- Example 2 of: \(description). ---")
//    action()
//}


//example2(of: "Subscriber") {
//
//    let myNotificacion = Notification.Name("MyNotification")
//    let publisher = NotificationCenter.default.publisher(for: myNotificacion, object: nil)
//    let center = NotificationCenter.default
//
//    /* para que el publisher pueda emitir es necesario que si o si exista
//     * al menos un subscriber
//     */
//
//    let subscrition = publisher.sink { _ in
//        print("Notificacion recibida desde el publisher!")
//    }
//
//    center.post(name: myNotificacion, object: nil)
//
//    subscrition.cancel()
//}

public func example3(of description: String, action: () -> Void) {
    print("\n -- Example 3 of: \(description). ---")
    action()
}


// Just es una class de Combine
// A publisher that emits an output to each subscriber just once, and then finishes.
// Ver la API en Apple.
//
example3(of: "Just") {
  
    let just = Just("Hello world! Desde el publisher!")
    
    _ = just.sink(receiveCompletion: { cp in
        print("receiveCompletion:", cp)
    }, receiveValue: { vl in
        print("receiveValue:", vl)
    })
}
