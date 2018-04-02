import SpriteKit

public class GameViewController: SKView {
    public override init(frame: CGRect){
        super.init(frame: frame)
        self.presentScene(GameScene(size: frame.size))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

