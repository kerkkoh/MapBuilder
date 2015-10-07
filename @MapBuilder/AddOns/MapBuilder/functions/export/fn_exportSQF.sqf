_filename = [_this,0,"noFilename"] call bis_fnc_param;
if(_filename == "") exitWith {systemChat "Error: Export needs a name!";};

_folder = ["export"] call mb_fnc_getFolderContent;
_confirmed = true;
if(format["%1.sqf",_filename] in _folder) then {
	_confirmed = ["File with this name already exists. Overwrite?",0] call MB_fnc_showPopupDialog;
};
if(_confirmed) then {
	startLoadingScreen ["Exporting scriptfile...","MB_LoadingScreen"];
	_path = ("MB_FileIO" callExtension format["open_w|export\%1.sqf",_filename]);
	systemChat format["Opening %1",_path];
	private["_number","_digits","_acc"];
	"MB_FileIO" callExtension "write|//This file was generated by Map Builder";
	"MB_FileIO" callExtension "write|//To load this objects copy this script to your mission and put";
	"MB_FileIO" callExtension format["write|// nil = [] execVM ""%1.sqf"";",_filename];
	"MB_FileIO" callExtension "write|//in your init.sqf or a trigger-activation.";
	systemChat ("MB_FileIO" callExtension "write|private[""_obj""];");
	_count = 0;
	{
		if(!isNull(_x)) then {
			_obj = _x;

		
			_type = (typeof _obj);
			_obj = _x;
			
			_pos = [_obj,[0,0]] call MB_fnc_getExactPosition;
			_pitch = _obj getvariable "MB_ObjVar_Pitch";
			_bank = _obj getvariable "MB_ObjVar_Bank";
			_yaw = _obj getvariable "MB_ObjVar_Yaw";
			//_scale = _obj getvariable "MB_ObjVar_Scale";
			
			_dirAndUp = [_pitch,_bank,_yaw] call MB_fnc_CalcDirAndUpVector;
			_string = format["write|_obj = ""%1"" createvehicle [%2,%3,%4];",_type,_pos select 0,_pos select 1,_pos select 2];
			"MB_FileIO" callExtension _string;
			_string = format["write|_obj setposATL [%1,%2,%3];",_pos select 0,_pos select 1,_pos select 2];
			"MB_FileIO" callExtension _string;
			_string = format["write|_obj setVectorDirAndUp %1;",_dirAndUp];
			"MB_FileIO" callExtension _string;
			_string = format["write|_obj setposATL [%1,%2,%3];",_pos select 0,_pos select 1,_pos select 2];
			"MB_FileIO" callExtension _string;
		};
		_count = _count + 1;
		progressLoadingScreen (_count/count(MB_Objects));
	} foreach MB_Objects;
	systemChat ("MB_FileIO" callExtension "close");
	systemchat format["%1 objects exported to %2.",_count,_path];
	endLoadingScreen;
};