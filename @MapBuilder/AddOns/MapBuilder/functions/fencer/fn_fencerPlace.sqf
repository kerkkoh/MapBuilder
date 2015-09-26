disableSerialization;
	private["_parent","_direction","_bbr","_dir","_fpos","_relPos","_class","_display","_ctrl"];
	
	_display = uinamespace getvariable 'mb_main_dialog';

	
	_parent = (MB_Selected select (count(MB_Selected)-1));
	_boundingParent = [_parent] call MB_FNC_FencerCalcBounding;
	
	_parentPos = _parent getvariable "MB_ObjVar_PositionATL";
	_ParentMaxWidth = _boundingParent select 1;
	_ParentMaxLength = _boundingParent select 0;
	_ParentMaxHeight = _boundingParent select 2;
	
	_dir =  _parent getvariable "MB_ObjVar_Yaw";
	
	_ctrl = _display displayCtrl 170412;
	if(count(MB_Selected)>0) then {
		_class = typeof (MB_Selected select ((count MB_Selected)-1));
	} else {
		_class = MB_CurClass;
	};
	if(ctrlChecked _ctrl) then {
		_class = MB_CurClass;
	};
	_created = [_class,_parentPos] call MB_fnc_CreateObject;
	_created setvariable ["MB_ObjVar_Yaw",_dir,false];
	_created setvariable ["MB_ObjVar_Bank",(_parent getvariable ["MB_ObjVar_Bank",false]),false];
	_created setvariable ["MB_ObjVar_Pitch",(_parent getvariable ["MB_ObjVar_Pitch",false]),false];
	_created setvariable ["MB_ObjVar_Simulate",(_parent getvariable ["MB_ObjVar_Simulate",false]),false];
	_created setvariable ["MB_ObjVar_Locked",(_parent getvariable ["MB_ObjVar_Locked",false]),false];
	
	_boundingCreated = [_created] call MB_FNC_FencerCalcBounding;
	
	_CreatedMaxWidth = _boundingCreated select 1;
	_CreatedMaxLength = _boundingCreated select 0;
	_CreatedMaxHeight = _boundingCreated select 2;
	
	
	
	_direction = MB_FencerDir;
		_offset = parseNumber (ctrlText 170410);
	switch (_direction) do {
		case 0: {
			_relPos = [_parent,_created,[0,(_CreatedMaxLength+_ParentMaxLength)/2+_offset,0]] call MB_fnc_CalcRelativePosition;
		};
		case 1: {
			_relPos = [_parent,_created,[0,-1*((_CreatedMaxLength+_ParentMaxLength)/2+_offset),0]] call MB_fnc_CalcRelativePosition;
		};
		case 2: {
			_relPos = [_parent,_created,[-1*((_CreatedMaxWidth+_ParentMaxWidth)/2+_offset),0,0]] call MB_fnc_CalcRelativePosition;
		};
		case 3: {
			_relPos = [_parent,_created,[(_CreatedMaxWidth+_ParentMaxWidth)/2+_offset,0,0]] call MB_fnc_CalcRelativePosition;
		};
		case 4: {
			_relPos = getPosATL _parent;
			_relPos set[2,(_relPos select 2)+_ParentMaxHeight+_offset];
		};
		case 5: {
			_relPos = getPosATL _parent;
			_relPos set[2,(_relPos select 2)-_CreatedMaxHeight-_offset];
		};
	};

	if(_direction<4) then {
		switch (MB_FencerHeightMode) do {
			case 0: {
				//Do Nothing. It is already ATL
				_relPos set [2,_parentPos select 2];
				_created setvariable ["MB_ObjVar_PositionATL",_relPos,false];
			};
			case 1: {
				//Height to Zero
				_relPos set [2,0];
				_created setvariable ["MB_ObjVar_PositionATL",_relPos,false];
			};
			case 2: {
				//Get the ASL Pos and transform to ATL at new position
				_relPos set [2,(getposASL _parent) select 2];
				_created setvariable ["MB_ObjVar_PositionATL",ASLtoATL _relPos,false];
			};
		};	
	} else {
		_created setvariable ["MB_ObjVar_PositionATL",_relPos,false];
	};
	
	_ctrl = _display displayCtrl 170412;
	if(ctrlChecked _ctrl) then {
		[_created] call MB_fnc_AlignObjectToTerrain;
	};
	
	[_created] call MB_fnc_UpdateObject;

	[_created] call MB_fnc_Select;
	[] call MB_FNC_FencerUpdatePreview;