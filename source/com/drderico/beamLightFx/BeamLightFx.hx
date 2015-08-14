package com.drderico.beamLightFx;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * Light beams Fx
 * @author DrDerico (drderico.com, drderico.ru)
 */
class BeamLightFx extends FlxTypedSpriteGroup<BeamGfx>
{
	static var started:Bool;

	public function new(BEAMS_NUM:Int = 30)
	{
		super();

		// Filling circle with beams
		// Заполняем круг из лучей
		var angle = 360 / (BEAMS_NUM + 1);
		for (i in 0...BEAMS_NUM)
		{
			// Each beam will be rotated on defined angle
			// Каждый луч будет повёрнут на угол. Круг разбит на сектора
			var beam = new BeamGfx(FlxG.random.bool() ? BeamGfx.THIN : BeamGfx.THICK);
			beam.angle = angle * i;
			add(beam);
		}
		started = false;
		allowCollisions = FlxObject.NONE;
		moves = false;
	}

	public function toggle()
	{
		if (!started)
		{
			started = true;
			for (b in members)
				b.startTween();
		} else
		{
			started = false;
			for (b in members)
				b.stopTween();
		}
	}

	override public function destroy():Void
	{
	}

	public function stop()
	{
		started = false;
	}

}