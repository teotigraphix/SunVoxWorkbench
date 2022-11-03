/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.app.config;

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
	//-----------------------------------------------------------------------------
	// Injection :: Variables
	//-----------------------------------------------------------------------------
	@inject public var __injector:IInjector;
	@inject public var __mediatorMap:IMediatorMap;
	@inject public var __commandMap:IEventCommandMap;
	@inject public var __contextView:ContextView;

	//-----------------------------------------------------------------------------
	// Public :: Methods
	//-----------------------------------------------------------------------------
	public function configure():Void {
		trace("AppConfig", "configure()");

		__injector.map(ApplicationController).asSingleton();

		__mediatorMap.map(LoadingScreen).toMediator(LoadingScreenMediator);
		__mediatorMap.map(StartControl).toMediator(StartControlMediator);

		// __commandMap.map(AppEvent.AUDIO_ENGINE_STARTUP).toCommand(AudioEngineStartupCommand);
	}
}
