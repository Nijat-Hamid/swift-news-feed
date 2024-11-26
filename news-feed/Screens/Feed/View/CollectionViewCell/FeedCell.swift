import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feedImage: UIImageView!

    func configureCell(with model: FeedUIModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        feedImage.sd_setImage(with: model.imageUrl, placeholderImage: UIImage(named: "placeholder"))
    }
}
