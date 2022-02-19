import h2d.Graphics;

class FlappyCube2d extends h2d.Graphics {
	public var mass:Float = 1;
	public var gravity:Float = 9.807;
	public var velocity = new h3d.Vector(0, 0);
	// 0 for no rotation, 1 for clockwise and -1 for couterclockwise rotation
	public var rotationDirection = 0;
	public var rotationSpeed = 2;

	private var mouseGravity = -300;

	// apply gravity acceleration on 60 fps rate
	private var lastGravityUpdatedTime:Float = 0;
	private var gravityUpdatePeriod:Float = 16.66 / 1000;

	private var interaction:h2d.Interactive;

	public function new(s2d:h2d.Scene) {
		super(s2d);
		interaction = new h2d.Interactive(s2d.width, s2d.height, s2d);
		interaction.onPush = function(event:hxd.Event) {
			var xDistance = this.x - event.relX;
			var yDixtance = this.y - event.relY;
			// normalize the distance
			var val = 1.0 / Math.sqrt((xDistance * xDistance) + (yDixtance * yDixtance));
			xDistance *= val;
			yDixtance *= val;

			// apply mouse gravity
			velocity.y = -mouseGravity * yDixtance;
			velocity.x = -mouseGravity * xDistance;

			rotationDirection = xDistance > 0 ? 1 : xDistance < 0 ? -1 : 0;
		}
	}

	public function init(x, y, width, height, color) {
		this.x = x;
		this.y = y;

		beginFill(color);
		drawRect(0, 0, width, height);
		endFill();
	}

	public function update(df:Float) {
		lastGravityUpdatedTime += df;
		if (lastGravityUpdatedTime > gravityUpdatePeriod) {
			lastGravityUpdatedTime -= gravityUpdatePeriod;
			velocity.y += gravity * mass;
		}

		x += velocity.x * df;
		y += velocity.y * df;

		rotation += rotationDirection * rotationSpeed * df;
	}
}
