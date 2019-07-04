    import UIKit

    class CustomInputCollectionViewController: UICollectionViewController {
        // MARK: Properties
        private let dataModel = DataModel(numberOfEntries: 9)
        private var layout = UICollectionViewFlowLayout()
        private let edgeInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        private let cellInterItemSpacing: CGFloat = 10
        private let cellLineSpacing: CGFloat = 10
        private let numberOfItemsPerRow: CGFloat = 3
        
        // MARK: Methods
        override func loadView() {
            let collectionView = CustomInputCollectionView(frame: .zero, collectionViewLayout: layout)
            self.collectionView = collectionView
            self.view = collectionView
        }
        
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            layout.invalidateLayout()
        }
    }

    extension CustomInputCollectionViewController: UICollectionViewDelegateFlowLayout {
        // MARK: Collection View Delegate And Data Source Extension
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = (collectionView.frame.width - (numberOfItemsPerRow + 1) * cellInterItemSpacing) / numberOfItemsPerRow
            return .init(width: size, height: size)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return cellInterItemSpacing
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return cellLineSpacing
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return edgeInset
        }
        
        override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return dataModel.count
        }
        
        override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomInputCell.reuseIdentifier, for: indexPath) as? CustomInputCell ?? CustomInputCell()
            cell.configure(indexPath, using: dataModel[indexPath.item])
            cell.inputDelegate = dataModel
            return cell
        }
        
        override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CustomInputCell, cell.canBecomeFirstResponder {
                cell.becomeFirstResponder()
            }
        }
    }
