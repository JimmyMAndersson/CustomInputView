import UIKit

class CustomInputCollectionView: UICollectionView {
    // MARK: Methods
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        register(CustomInputCell.self, forCellWithReuseIdentifier: CustomInputCell.reuseIdentifier)
        
        backgroundColor = .white
        let background = UIView()
        background.backgroundColor = .clear
        background.isUserInteractionEnabled = true
        background.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:))))
        backgroundView = background
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func backgroundTapped(_ sender: UIGestureRecognizer) {
        endEditing(true)
    }
}
