//
//  Created by Dmitry Sochnev.
//  Copyright © 2018 Sochnev Dmitry. All rights reserved..
//

import UIKit

class TagStackView: UIView {

    private struct Constants {
        static let margin: CGFloat = 8.0
        static let spacing: CGFloat = 8.0
        static let labelsOrigin = CGPoint(x: margin, y: margin)
        static let tagHorizontalInset: CGFloat = 20
        static let tagVerticalInset: CGFloat = 16
        static let labelCornerRadius = tagHorizontalInset / 4
        static let labelBackgroundColor = UIColor(red: 0.29, green: 0.565, blue: 0.887, alpha: 1.0)
        static let borderColor = UIColor(red: 0.29, green: 0.565, blue: 0.887, alpha: 1.0)
        static let borderWidth: CGFloat = 1
    }

    private var tagLabels: [UILabel] = []

    convenience init(tags: [String]) {
        self.init(frame: .zero)
        setTags(tags)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.borderColor = Constants.borderColor.cgColor
        layer.borderWidth = Constants.borderWidth
        layoutTagLabels()
    }

    override var intrinsicContentSize: CGSize {
        return frame.size
    }
}

// MARK: Public
extension TagStackView {
    func setTags(_ tags: [String]) {
        tagLabels = tags.map { createLabel(withTag: $0) }
        tagLabels.forEach { addSubview($0) }
    }

    func addTag(_ tag: String) {
        let tagLabel = createLabel(withTag: tag)
        tagLabels.append(tagLabel)
        addSubview(tagLabel)
    }
}

// MARK: Private
private extension TagStackView {

    func createLabel(withTag tag: String) -> UILabel {
        let label = UILabel(frame: .zero)
        label.backgroundColor = Constants.labelBackgroundColor
        label.textColor = .white
        label.textAlignment = .center
        label.layer.cornerRadius = Constants.labelCornerRadius
        label.layer.masksToBounds = true
        label.text = tag
        return label
    }

    func layoutTagLabels() {
        var position = Constants.labelsOrigin
        var labelsMaxY = position.y
        tagLabels.forEach { label in
            var size = label.sizeThatFits(.zero)
            size = CGSize(width: size.width + Constants.tagHorizontalInset,
                          height: size.height + Constants.tagVerticalInset)
            if position.x + size.width + Constants.margin > frame.width {
                position = CGPoint(x: Constants.margin, y: position.y + size.height + Constants.spacing)
            }
            label.frame = CGRect(origin: position, size: size)
            position.x += size.width + Constants.spacing
            labelsMaxY = position.y + size.height
        }
        let height = labelsMaxY + Constants.margin
        frame = CGRect(origin: frame.origin, size: CGSize(width: frame.width, height: height))
    }
}
