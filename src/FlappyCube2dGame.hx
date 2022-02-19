class FlappyCube2dGame extends hxd.App {
	var flappyCube:FlappyCube2d;

	override function init() {
		flappyCube = new FlappyCube2d(s2d);
		flappyCube.init(s2d.width / 2, 0, 20, 20, 0x0000FF);
	}

	override function update(df:Float) {
		flappyCube.update(df);
	}

	static function main() {
		hxd.Res.initEmbed();
		new FlappyCube2dGame();
	}
}
