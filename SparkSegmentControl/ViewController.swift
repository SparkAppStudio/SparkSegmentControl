//
//  ViewController.swift
//  SparkSegmentControl
//
//  Created by YupinHuPro on 10/8/17.
//  Copyright © 2017 YupinHuPro. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SegmentDelegateProtocol {


    // MARK: - Variables

    lazy var ds: SegmentDataSource = {
        let ds = SegmentDataSource()
        return ds
    }()

    lazy var dele: SegmentDelegate = {
        let dele = SegmentDelegate()
        dele.delegate = self
        return dele
    }()


    // MARK: - IBs

    @IBOutlet weak var segmentControl: DesignableSegmentControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func segmentValueChanged(_ sender: DesignableSegmentControl) {
        print(sender.selectedSegmentIndex)
        let indexPath = IndexPath(item: sender.selectedSegmentIndex, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }


    // MARK: - View Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = ds
        collectionView.delegate = dele
    }

    func scrollEnded(_ offset: CGPoint) {
        // Was thinking of passing scrollView's content offset
        // and use collectionView.indexPathForItem(offset)
        // but for some strange reason it didn't workout

        /*
        guard let indexPath = collectionView.indexPathForItem(at: offset) else {
            assertionFailure("Must get an indexpath")
            return
        }
        // update the segment control
        segmentControl.updateToIndex(indexPath.row)
         */

        guard let cell = collectionView.visibleCells.first else { return }
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        segmentControl.updateToIndex(indexPath.row)
    }


}


class SegmentDataSource: NSObject, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .purple
        } else {
            cell.backgroundColor = .yellow
        }
        return cell
    }

}


protocol SegmentDelegateProtocol: class {
    func scrollEnded(_ offset: CGPoint)
}

class SegmentDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    weak var delegate: SegmentDelegateProtocol?

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = collectionView.bounds.width
        return CGSize(width: screenWidth, height: screenWidth)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        delegate?.scrollEnded(offset)
    }
}

