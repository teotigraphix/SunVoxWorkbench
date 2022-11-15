/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app.config;

import openfl.events.Event;
import openfl.events.IEventDispatcher;
import org.swiftsuspenders.utils.DescribedType;
import robotlegs.bender.extensions.contextView.ContextView;
import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IInjector;
import sunvox.player.context.ui.common.StartControl;
import sunvox.player.context.ui.common.mediators.StartControlMediator;
import sunvox.player.context.ui.screen.LoadingScreen;
import sunvox.player.context.ui.screen.mediators.LoadingScreenMediator;

class AppConfig implements DescribedType implements IConfig {
	public static final TAG:String = "AppConfig";

	//-----------------------------------------------------------------------------
	// Injection :: Variables
	//-----------------------------------------------------------------------------
	@inject public var __injector:IInjector;
	@inject public var __eventDispatcher:IEventDispatcher;
	@inject public var __mediatorMap:IMediatorMap;
	@inject public var __commandMap:IEventCommandMap;
	@inject public var __contextView:ContextView;

	//-----------------------------------------------------------------------------
	// Public :: Methods
	//-----------------------------------------------------------------------------
	public function configure():Void {
		trace(TAG, "configure()");

		// TODO Initialize assets

		// Map
		mapApplication();
		mapModel();
		mapMediators();
		mapCommands();
		mapServices();

		__eventDispatcher.dispatchEvent(new Event("configureComplete"));
	}

	private function mapApplication():Void {
		__injector.map(ApplicationController).asSingleton();
	}

	private function mapServices():Void {}

	private function mapModel():Void {}

	private function mapCommands():Void {
		// __commandMap.map(AppEvent.AUDIO_ENGINE_STARTUP).toCommand(AudioEngineStartupCommand);
	}

	private function mapMediators():Void {
		__mediatorMap.map(LoadingScreen).toMediator(LoadingScreenMediator);
		__mediatorMap.map(StartControl).toMediator(StartControlMediator);
	}
}
