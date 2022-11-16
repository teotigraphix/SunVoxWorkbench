/*
	SunVox Workbench

	Copyright 2022 Teoti Graphix, LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package sunvox.player.context.playlist.core;

import feathers.data.IFlatCollection;
import org.swiftsuspenders.utils.DescribedType;
import signals.Signal1;
import sunvox.player.context.playlist.api.PlayListListData;

class PlaylistContext implements DescribedType {
	//-----------------------------------------------------------------------------
	// API :: Signals
	//-----------------------------------------------------------------------------

	/**
		Dispatched when the loaded playlist has been parsed and instantiated.
	 */
	public var onLoadComplete(default, null):Signal1<IFlatCollection<PlayListListData>> = new Signal1<IFlatCollection<PlayListListData>>();

	//-----------------------------------------------------------------------------
	// Constructor
	//-----------------------------------------------------------------------------
	@inject public function new() {}

	//-----------------------------------------------------------------------------
	// API :: Methods
	//-----------------------------------------------------------------------------

	public function load(url:String):Void { // , complete:Playlist->Void, ?error:ResultDTO->Void
	}
}
