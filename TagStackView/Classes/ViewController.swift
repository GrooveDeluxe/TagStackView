//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved..
//

import UIKit

class ViewController: UIViewController {

    private struct Constants {
        static let margin: CGFloat = 16.0
        static let bottomViewHeight: CGFloat = 100.0
    }

    private lazy var tagStackView: TagStackView = {
        let tagStackView = TagStackView()
        tagStackView.frame = CGRect(x: Constants.margin,
                                    y: Constants.margin * 3,
                                    width: view.frame.width - Constants.margin * 2,
                                    height: 0)
        tagStackView.autoresizingMask = [.flexibleTopMargin, .flexibleLeftMargin, .flexibleRightMargin,
                                         .flexibleWidth, .flexibleHeight, .flexibleBottomMargin]
        tagStackView.backgroundColor = UIColor(red: 0.85, green: 0.92, blue: 1.0, alpha: 1.0)
        return tagStackView
    }()

    private lazy var bottomView: BottomView = {
        let bottomView = BottomView(frame: .zero)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.setTitle("View with autolayout")
        return bottomView
    }()

    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        view.addSubview(tagStackView)
        view.addSubview(bottomView)
        setupConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tagStackView.setTags([
            "apple", "avocado", "banana", "blackberry", "blueberry",
            "cherry", "coconut", "durian", "grapefruit", "lemon", "melon"
            ])
    }
}

// MARK: Private
private extension ViewController {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: tagStackView.bottomAnchor, constant: Constants.margin),
            bottomView.leftAnchor.constraint(equalTo: tagStackView.leftAnchor),
            bottomView.rightAnchor.constraint(equalTo: tagStackView.rightAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: Constants.bottomViewHeight)
            ])
    }
}

