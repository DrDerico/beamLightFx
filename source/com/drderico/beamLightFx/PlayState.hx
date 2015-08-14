package com.drderico.beamLightFx;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.text.FlxText;
import flixel.util.FlxColor;


class PlayState extends FlxState {

	var bmfx:BeamLightFx;

    override public function create():Void {

		var s = new FlxSprite();
		s.loadGraphic("assets/images/bg.jpg");
		s.active = false;
		s.centerOrigin();
		s.setPosition((FlxG.width - s.width) / 2, (FlxG.height -s.height) / 2);
		add(s);

		bmfx = new BeamLightFx(50);
		bmfx.setPosition(FlxG.width / 2, FlxG.height / 2);
		add(bmfx);

		s = new FlxSprite();
		s.loadGraphic("assets/images/sword.png");
		s.active = false;
		s.centerOrigin();
		s.scale.set(0.5, 0.5);
		s.setPosition((FlxG.width - s.width) / 2, (FlxG.height - s.height) / 2);
		add(s);

		var t = new FlxText(0, FlxG.height - 30, FlxG.width, "press SPACE to toggle effect on/off", 16);
		t.alignment = FlxTextAlign.CENTER;
		add(t);

		bmfx.toggle();
    }

    override public function update(elapsed:Float):Void {

		if (FlxG.keys.justPressed.SPACE)
		{
			bmfx.toggle();
		}

		super.update(elapsed);
    }

}