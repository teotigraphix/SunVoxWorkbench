/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app;

import org.swiftsuspenders.utils.DescribedType;
import openfl.display.DisplayObjectContainer;
import openfl.events.EventDispatcher;
import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.enhancedLogging.impl.TraceLogTarget;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;
import robotlegs.bender.framework.impl.Context;
import signals.Signal;
import sunvox.api.Lib;
import sunvox.player.app.config.AppBundle;
import sunvox.player.app.config.AppConfig;

@:keep
class ApplicationController implements DescribedType {
	private static var _rootContext:Context;

	//-----------------------------------------------------------------------------
	// Inject :: Variables
	//-----------------------------------------------------------------------------
	public var __logger:ILogger;

	//-----------------------------------------------------------------------------
	// Private :: Variables
	//-----------------------------------------------------------------------------
	private static var __root:Main;

	private var sunVoxConfig:String = null;
	private var sunVoxSampleRate:Int = 44100;
	private var sunVoxNumChannels:Int = 2;
	private var sunVoxFlags:Int = 0;

	//-----------------------------------------------------------------------------
	// API :: Signals
	//-----------------------------------------------------------------------------
	public var onAudioEngineStateChange:Signal = new Signal();

	//-----------------------------------------------------------------------------
	// API :: Properties
	//-----------------------------------------------------------------------------
	//-----------------------------------
	// isAudioEngineRunning
	//-----------------------------------
	private var _isAudioEngineRunning:Bool;

	/**	 */
	public var isAudioEngineRunning(get, set):Bool;

	private function get_isAudioEngineRunning():Bool {
		return _isAudioEngineRunning;
	}

	private function set_isAudioEngineRunning(value:Bool):Bool {
		if (_isAudioEngineRunning == value)
			return _isAudioEngineRunning;

		_isAudioEngineRunning = value;

		onAudioEngineStateChange.dispatch();

		return _isAudioEngineRunning;
	}

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	public function new() {}

	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	/**
		Creates the root `Context` using the root `DisplayObject`.

		@param root `Main`
	 */
	public static function boot(root:Main):ApplicationController {
		__root = root;

		_rootContext = new Context();
		_rootContext.logLevel = LogLevel.DEBUG;
		_rootContext.addLogTarget(new TraceLogTarget(_rootContext));

		var logger = _rootContext.getLogger(root);

		logger.info("_rootContext.install()");
		_rootContext.install(MVCSBundle, AppBundle).configure(AppConfig, new ContextView(__root));

		_rootContext.get_injector().map(DisplayObjectContainer).toValue(__root);

		logger.info("_rootContext.initialize()");
		_rootContext.initialize();

		var applicationContext:ApplicationController = _rootContext.get_injector().getInstance(ApplicationController);

		return applicationContext;
	}

	/**
		Starts the audio bootstrap initialization.

		After the audio engine has been created and initialized, the application
		model with be created and started. Once the operations are complete, the
		`AUDIO_ENGINE_COMPLETE` signal will be broadcast.

		@event `AUDIO_ENGINE_COMPLETE` The audio engine
				has been initialized.
	 */
	public function startAsync():Void {
		initAudioEngineAsync();
	}

	//-----------------------------------------------------------------------------
	// Private :: Methods
	//-----------------------------------------------------------------------------
	private function status(message:String):Void {
		trace(message);
	}

	private function initAudioEngineAsync():Void {
		if (isAudioEngineRunning)
			return;

		// Global sound system init
		var ver:Int = Lib.sv_init(sunVoxConfig, sunVoxSampleRate, sunVoxNumChannels, sunVoxFlags);
		if (ver >= 0) {
			status("init ok");
			isAudioEngineRunning = true;
		} else {
			status("init error");
			isAudioEngineRunning = false;
		}

		if (isAudioEngineRunning) {
			trace("AudioEngine loaded");
		} else {
			trace("AudioEngine not loaded");
		}
	}

	public function clientGuesture() {
		isAudioEngineRunning = true;
		// XXX AppEvent.AUDIO_ENGINE_COMPLETE
	}
}
