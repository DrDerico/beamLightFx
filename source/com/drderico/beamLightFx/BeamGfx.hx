package com.drderico.beamLightFx;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import openfl.display.BlendMode;

/**
 * Beam graphics. Thin or thick
 * It changes its size, tranparency and is rotating to left or right direction
 *
 * Луч. Тонкий или толстый
 * Меняет свой размер, прозрачность и крутится в какую-либо сторону
 */
class BeamGfx extends FlxSprite
{

	public static inline var THIN = 0;
	public static inline var THICK = 1;

	var rotDir = 0;

	var _alphaTween:FlxTween;
	var _scaleTween:FlxTween;
	var _angleTween:FlxTween;
	var _stopTween:FlxTween;
	var _stopTween2:FlxTween;

	public function new(type:Int)
	{
		super();

		loadGraphic("assets/images/" + ((type == THIN) ? "thinStripe.png" : "wideStripe.png"));

		antialiasing = true;
		if (type == 0)
		{
			origin.set(0, height * 0.5 - 2);
			y -= 15;
		}
		else
		{
			origin.set(0, height * 0.5);
			y -= 29;
		}
		active = false;
		blend = BlendMode.ADD;
		alpha = 0;
		scale.set(0.5, 0.5);
	}

	/**
	 * Starting tween for beam
	 * Запуск твина. Лучи появляются и растут, а потом случайно уже работают
	 */
	public function startTween()
	{
		if (_stopTween != null)
		{
			_stopTween.cancel();
			_stopTween2.cancel();
			onTweenStop(null);
		}
		alpha = 0;
		scale.set(0.5, 0.5);

		rotDir = (FlxG.random.bool()) ? -360 : 360;
		_angleTween = FlxTween.angle(this, angle, angle + rotDir, FlxG.random.float(15, 35), { type:FlxTween.LOOPING } );
		onAlphaDownTweenComplete(null);
		onScaleDownTweenComplete(null);
	}

	/**
	 * Stoping tween for beam. Beam will decrease its size and transparency, but it will be still rotating
	 * Остановка луча. Плавная. Т.е. луч уменьшается и исчезает, при этом оставаясь крутиться
	 */
	public function stopTween()
	{
		if (_scaleTween != null)
		{
			_scaleTween.cancel();
			_scaleTween = null;
		}
		if (_alphaTween != null)
		{
			_alphaTween.cancel();
			_alphaTween = null;
		}
		_stopTween = FlxTween.tween(this, { alpha:0 }, 2, { onComplete:onTweenStop } );
		_stopTween2 = FlxTween.tween(this.scale, { x:0.2, y:0.2 }, 2);
	}

	function onTweenStop(_)
	{
		if (_angleTween != null)
		{
			_angleTween.cancel();
			_angleTween = null;
		}
		_stopTween = null;
		_stopTween2 = null;
	}

	function onAlphaUpdate(_num:Float)
	{
		alpha = _num;
	}

	function onAlphaUpTweenComplete(_)
	{
		_alphaTween = FlxTween.num(alpha, 0, FlxG.random.float(0.2, 1.5), { onComplete:onAlphaDownTweenComplete, startDelay:FlxG.random.float(0.2, 0.5) }, onAlphaUpdate );
	}

	function onAlphaDownTweenComplete(_)
	{
		_alphaTween = FlxTween.num(alpha, 1, FlxG.random.float(0.2, 1.5), { onComplete:onAlphaUpTweenComplete, startDelay:FlxG.random.float(0.2, 0.5) }, onAlphaUpdate );
	}

	function onScaleUpdate(_num:Float)
	{
		scale.set(_num,_num);
	}

	function onScaleUpTweenComplete(_)
	{
		_scaleTween = FlxTween.num(scale.x, 0.5, FlxG.random.float(1, 2.5), { onComplete:onScaleDownTweenComplete, startDelay:FlxG.random.float(0.2, 0.5) }, onScaleUpdate );
	}

	function onScaleDownTweenComplete(_)
	{
		_scaleTween = FlxTween.num(scale.x, 1, FlxG.random.float(1, 2.5), { onComplete:onScaleUpTweenComplete, startDelay:FlxG.random.float(0.2, 0.5) }, onScaleUpdate );
	}


}