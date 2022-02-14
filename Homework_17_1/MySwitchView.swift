import UIKit

protocol MySwitchDelegate: AnyObject {
    func didChangeSwitchIsOn(_ isOn: Bool, targetSwitch: MySwitchView)
}

class MySwitchView: UISwitch {
    weak var delegate: MySwitchDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSwitch(self)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupSwitch(self)
    }
    
    func setupSwitch(_ mySwitch: UISwitch) {
        mySwitch.isOn = false
        mySwitch.addTarget(self, action: #selector(switchDidChange(_:)), for: .valueChanged)
    }
    
    @objc func switchDidChange(_ targetSwitch: MySwitchView) {
        delegate?.didChangeSwitchIsOn(targetSwitch.isOn, targetSwitch: self)
    }
}
