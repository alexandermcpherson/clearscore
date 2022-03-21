//
//  ScoreView.swift
//  ClearScore
//
//  Created by Alex McPherson on 10/03/2022.
//

import UIKit

class ScoreView: UIView {

    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!

    // MARK: - Properties
    private var scoreArcColor = UIColor(red: 235/255, green: 221/255, blue: 155/255, alpha: 1.0)
    private var outerArcColor = UIColor.black
    var currentScore: Int = 0
    var maxScoreValue: Int = 0

    // MARK: - Constants
    private enum Constants {
        static let outerArcWidth: CGFloat = 2
        static let scoreArcWidth: CGFloat = 20
        static let startAngle: CGFloat = 3 * .pi / 2
    }

    // MARK: - Methods
    override func draw(_ rect: CGRect) {
        let center = CGPoint(x: bounds.width / 2,
                             y: bounds.height / 2)

        drawOuterCircle(rect: rect, center: center)
        drawScoreArc(rect: rect, center: center)
    }

    private func drawOuterCircle(rect: CGRect, center: CGPoint) {

        // Draw black thin circle
        let outerArcRadius = min(bounds.width - Constants.outerArcWidth,
                                 bounds.height - Constants.outerArcWidth)

        let outerArcEndAngle: CGFloat = Constants.startAngle + 2 * .pi

        let outerArcPath = UIBezierPath(
          arcCenter: center,
          radius: outerArcRadius / 2 - Constants.outerArcWidth,
          startAngle: Constants.startAngle,
          endAngle: outerArcEndAngle,
          clockwise: true)
        outerArcPath.lineWidth = Constants.outerArcWidth
        outerArcColor.setStroke()
        outerArcPath.stroke()
    }

    private func drawScoreArc(rect: CGRect, center: CGPoint) {

        // Draw credit score arc
        let scoreArcRadius = min(bounds.width - Constants.scoreArcWidth,
                         bounds.height - Constants.scoreArcWidth)

        // Convert our values into radians for the purpose of drawing the arcs range
        let valueToPercentage = Double().valueToPercentage(Double(currentScore), maxValue: Double(maxScoreValue))
        let percentageToDegrees = Double().percentageToDegress(valueToPercentage)
        let degreesToRadians = Double().degreesToRadians(percentageToDegrees)
        let endAngle = degreesToRadians + Constants.startAngle

        let scoreArcPath = UIBezierPath(
          arcCenter: center,
          radius: scoreArcRadius / 2 - Constants.scoreArcWidth / 4,
          startAngle: Constants.startAngle,
          endAngle: endAngle,
          clockwise: true)

        scoreArcPath.lineWidth = Constants.scoreArcWidth
        scoreArcPath.lineCapStyle = .round
        scoreArcColor.setStroke()
        scoreArcPath.stroke()
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        let bundle = Bundle(for: ScoreView.self)
        bundle.loadNibNamed(String(describing: ScoreView.self), owner: self, options: nil)
    }
}
