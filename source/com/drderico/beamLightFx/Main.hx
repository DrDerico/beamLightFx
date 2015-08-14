package com.drderico.beamLightFx;

import com.drderico.beamLightFx.PlayState;
import flash.display.Sprite;
import flash.events.Event;
import flash.Lib;
import flixel.FlxGame;
import flixel.FlxState;

class Main extends Sprite
{
    public inline static var gameWidth:Int = 640; // Width of the game in pixels (might be less / more in actual pixels depending on your zoom).
    public inline static var gameHeight:Int = 640; // Height of the game in pixels (might be less / more in actual pixels depending on your zoom).
    var initialState:Class<FlxState> = PlayState; // The FlxState the game starts with.
    var zoom:Float = -1; // If -1, zoom is automatically calculated to fit the window dimensions.
    var framerate:Int = 60; // How many frames per second the game should run at.
    var skipSplash:Bool = true; // Whether to skip the flixel splash screen that appears in release mode.
    var startFullscreen:Bool = true; // Whether to start the game in fullscreen on desktop targets

    // You can pretty much ignore everything from here on - your code should go in your states.

    public static function main():Void
    {
        Lib.current.addChild(new Main());
    }

    public function new()
    {
        super();

        if (stage != null)
        {
            init();
        }
        else
        {
            addEventListener(Event.ADDED_TO_STAGE, init);
        }
    }

    function init(?E:Event):Void
    {
        if (hasEventListener(Event.ADDED_TO_STAGE))
        {
            removeEventListener(Event.ADDED_TO_STAGE, init);
        }

        setupGame();
    }

    function setupGame():Void
    {
		var game:FlxGame = new FlxGame(gameWidth, gameHeight, initialState, zoom, framerate, framerate, skipSplash, startFullscreen);
        addChild(game);

    }
}