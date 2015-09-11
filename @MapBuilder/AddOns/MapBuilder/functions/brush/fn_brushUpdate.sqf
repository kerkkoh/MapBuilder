private["_vector","_dir"];
if(MB_NodesDrawn == 0) then {
		if((MB_BrushLastNode vectorDistance MB_MousePosition)>=MB_BrushWidth) then {
			private["_vector","_dir"];
			_vector = MB_BrushLastNode vectorFromTo MB_MousePosition;
			_dir = (_vector select 0) atan2 (_vector select 1);
			[+MB_BrushLastNode,_dir] call MB_fnc_brusherDrawNode;
			MB_BrushLastNode = +MB_MousePosition;
			MB_BrushHelper setposATL MB_BrushLastNode;
			systemchat "Firstnode";
			//Log the angle:
			MB_BrushCamAngle = _dir;
			MB_BrushDirection = 0;
			MB_NodesDrawn = 1;
			
		} else {
			MB_3DVectors = [[+MB_BrushLastNode,+MB_MousePosition]];
			MB_BrushPoint setposATL (MB_MousePosition vectorAdd [0,0,0.5]);
			_vector = MB_BrushLastNode vectorFromTo MB_MousePosition;
			_dir = (_vector select 0) atan2 (_vector select 1);
			MB_BrushPoint setdir _dir;
			MB_BrushDirection = _dir;
		};
	} else {
		if((MB_BrushLastNode vectorDistance MB_MousePosition)>=MB_BrushWidth) then {
			private["_vector","_dir"];
			_vector = MB_BrushLastNode vectorFromTo MB_MousePosition;
			_dir = (_vector select 0) atan2 (_vector select 1);
			[+MB_BrushLastNode,_dir] call MB_fnc_brusherDrawNode;
			MB_BrushLastNode = +MB_MousePosition;
			MB_BrushHelper setposATL MB_BrushLastNode;
			MB_NodesDrawn = MB_NodesDrawn + 1;
		} else {
			MB_3DVectors = [[+MB_BrushLastNode,+MB_MousePosition]];
			MB_BrushPoint setposATL MB_MousePosition;
			_vector = MB_BrushLastNode vectorFromTo MB_MousePosition;
			_dir = (_vector select 0) atan2 (_vector select 1);
			MB_BrushPoint setdir _dir;
			MB_BrushDirection = _dir;
		};
	};