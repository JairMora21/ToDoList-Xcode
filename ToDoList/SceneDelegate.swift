//
//  SceneDelegate.swift
//  ToDoList
//
//  Created by Alumno on 19/10/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    //lo que hace este metodo es instanciar una vista
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    // todos estos metodos que estan abajo estaban en el app delegate pero con la nueva actualizacion de iOS 13 se actualizaronnlas vistas
    //e implementaron esta clase llamada SceneDelegate
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
        // esto nos escena nos permite persistir datos, poner en pausa , hacer x cantidad de tareas cuando la escena se desconecta

    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Esta nos escena se llama cuando la escena pasa de inactivo o a activo
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        //Esto nos avisa antes de que cambie de inactivo a activo
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // avisa de cuando va a entrar de background a foreground
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // avisa de cuando va ya entro de background a foreground

        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

