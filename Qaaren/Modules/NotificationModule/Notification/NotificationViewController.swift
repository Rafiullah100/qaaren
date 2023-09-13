//
//  NotificationViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/13/23.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var muteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizationKeys.notifications.rawValue.localizeString()
        self.notificationLabel.text = LocalizationKeys.pushNotification.rawValue.localizeString()
        self.muteLabel.text = LocalizationKeys.muteNotification.rawValue.localizeString()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
