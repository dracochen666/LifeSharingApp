//
//  SceneDelegate.swift
//  LifeSharingApp
//
//  Created by 陈龙 on 2023/3/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
//        guard let _ = (scene as? UIWindowScene) else { return }
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        
        
        let rootVC = LS_TabBarViewController()
        let home = LS_TabBarNavigationController(rootViewController: rootVC)
        home.setNavigationBarHidden(true, animated: true)
        self.window?.rootViewController = home

//        let home1 = LS_LoginViewController()
//        let naviVC = UINavigationController(rootViewController: home1)
//        naviVC.isNavigationBarHidden = true
//        self.window?.rootViewController = naviVC

//        let home = NoteEditViewController()
//        self.window?.rootViewController = home
        
//        let home = LS_MemoPageViewController()
//        self.window?.rootViewController = home
        
//        let home = ChatViewController()
//        self.window?.rootViewController = home
        
//        let home = NoteDetailViewController()
//        self.window?.rootViewController = home
        
//        let home = NoteWaterFallViewController()
//        self.window?.rootViewController = home
        
//        let home = UserProfileViewController()
//        self.window?.rootViewController = home
//        
//        let home = afTestViewController()
//        self.window?.rootViewController = home
        
//        let home = RegisterViewController()
//        self.window?.rootViewController = home


//        let home = ChangeUserPasswordViewController()
//        self.window?.rootViewController = home
        
//        let home = DropDownMenuViewController()
//        self.window?.rootViewController = home

        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

