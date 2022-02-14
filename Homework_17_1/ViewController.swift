import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var switchLine1: [MySwitchView]!
    @IBOutlet var switchLine2: [MySwitchView]!
    @IBOutlet var switchLine3: [MySwitchView]!
    @IBOutlet var switchLine4: [MySwitchView]!
    @IBOutlet var switchLine5: [MySwitchView]!
    
    var switchesArray : [[MySwitchView]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switchesArray = [switchLine1,switchLine2,switchLine3,switchLine4,switchLine5]
        for switchLine in switchesArray {
            for singleSwitch in switchLine {
                singleSwitch.delegate = self
            }
        }
    }
    
    func randomSwitchTag() -> Int {
        return Int.random(in: 1...25)
    }
    
    func turnOffThreeSwitches(_ currentSwitchTag: Int) {
        let switchesFlatArray = switchesArray.flatMap { $0 }
        var countToThree = 0
        while countToThree < 3 {
            let randomTag = randomSwitchTag()
            if randomTag != currentSwitchTag {
                switchesFlatArray[randomTag - 1].isOn = false
                countToThree += 1
            }
        }
        checkLines()
    }
    
    func checkLines() {
        var counterSwitches = 0
        var counterLines = 0
        for switchLine in switchesArray {
            for singleSwitch in switchLine {
                if singleSwitch.isOn {
                    counterSwitches += 1
                }
            }
            if counterSwitches == 5 {
                counterLines += 1
            }
            counterSwitches = 0
        }
        if counterLines >= 2 {
            let alertVC = UIAlertController(
                title: "Congratulations!",
                message: "Winner winner chicken dinner!",
                preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(action)
            self.present(alertVC, animated: true, completion: resetSwitches)
        }
    }
    
    func resetSwitches() {
        let switchesFlatArray = switchesArray.flatMap { $0 }
        for sw in switchesFlatArray {
            sw.isOn = false
        }
    }
}

extension ViewController: MySwitchDelegate {
    func didChangeSwitchIsOn(_ isOn: Bool, targetSwitch: MySwitchView) {
        if isOn {
            turnOffThreeSwitches(targetSwitch.tag)
        }
    }
}


