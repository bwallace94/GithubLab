//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Bria Wallace on 4/5/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

protocol SettingsDelegate: class {
    func starFilter(filter: SettingsViewController, didPickFilter starMin: Int?)
}

enum languageIdentifier : String {
    case Java = "Java"
    case JavaScript = "JavaScript"
    case ObjectiveC = "ObjectiveC"
    case Python = "Python"
    case Ruby = "Ruby"
    case Swift = "Swift"
}

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    weak var delegate: SettingsDelegate?
    
    var starMin = 0
    var languages = ["Java","JavaScript","Objective-C","Python","Ruby","Swift"]
    var selectedPreferences:[String] = []
    var existingPreferences:[String] = []
    
    @IBOutlet weak var languageTableView: UITableView!
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starNumberLabel: UILabel!
    
    @IBAction func starValueDidChange(_ sender: UISlider) {
        starMin = Int(sender.value)
        starNumberLabel.text = "\(starMin)"
        starNumberLabel.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterToggleCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LanguageSelectorCell", for: indexPath) as! LanguageSelectorCell
            cell.language = languages[indexPath.row - 1]
            return cell
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starSlider.maximumValue = 100000
        starSlider.minimumValue = 0
        starSlider.setValue(Float(starMin), animated: false)
        starNumberLabel.text = "\(starMin)"
        starNumberLabel.sizeToFit()
        languageTableView.delegate = self
        languageTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapSave(_ sender: Any) {
        delegate?.starFilter(filter: self, didPickFilter: starMin)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
