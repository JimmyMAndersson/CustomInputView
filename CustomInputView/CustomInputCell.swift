import UIKit

protocol CustomInputCellDelegate: class {
    func insertText(_ text: String, at indexPath: IndexPath, didFinishUpdate: ((Int) -> ())?)
    func deleteBackwards(at indexPath: IndexPath, didFinishUpdate: ((Int) -> ())?)
}

class CustomInputCell: UICollectionViewCell, UIKeyInput {
    // MARK: Properties
    static var reuseIdentifier: String { return String(describing: type(of: self)) }
    var keyboardType: UIKeyboardType = .numberPad
    private var indexPath = IndexPath()
    weak var inputDelegate: CustomInputCellDelegate?
    
    private let dataLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 26, weight: .semibold)
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = UIColor.black
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    // MARK: Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stylize()
    }
    
    private func initialize() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.1
        layer.borderWidth = 3
        
        addSubview(dataLabel)
        addSubview(titleLabel)
        
        dataLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        dataLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        stylize()
    }
    
    private func stylize() {
        layer.cornerRadius = min(frame.width, frame.height) / 4
        self.backgroundColor = (self.isFirstResponder) ? UIColor.black.withAlphaComponent(0.15) : UIColor.black.withAlphaComponent(0.05)
        self.layer.borderColor = (self.isFirstResponder) ? UIColor.black.cgColor : UIColor.lightGray.cgColor
    }
    
    public func configure(_ indexPath: IndexPath, using data: Int) {
        self.indexPath = indexPath
        self.dataLabel.text = "\(data)"
        self.titleLabel.text = "Number \(indexPath.item + 1)"
    }
    
    private func update(using data: Int) {
        self.dataLabel.text = "\(data)"
    }
}

extension CustomInputCell {
    // MARK: Input Related Extensions
    
    override var canBecomeFirstResponder: Bool { return true }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        let becameFirstResponder = super.becomeFirstResponder()
        stylize()
        return becameFirstResponder
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        let resignedFirstResponder = super.resignFirstResponder()
        stylize()
        return resignedFirstResponder
    }
    
    var hasText: Bool { return true }
    
    func insertText(_ text: String) {
        inputDelegate?.insertText(text, at: self.indexPath, didFinishUpdate: self.update(using:))
    }
    
    func deleteBackward() {
        inputDelegate?.deleteBackwards(at: self.indexPath, didFinishUpdate: self.update(using:))
    }
}
