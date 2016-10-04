$*Capslock::
	;Defines number of divisions in the x and y coordinates.
	XTilesN = 4
	YTilesN = 3
	Gui, 99:+ToolWindow
	Gui, 99:Show, x-1 w1 NoActivate, Capslock Is Down
	keywait, Capslock
	Gui, 99:Destroy
	return
						
;Modifier 1
#IfWinExist, Capslock Is Down
	$*w::
		SysGet, Mon, MonitorWorkArea
		TWidth := MonRight/XTilesN
		THeight := MonBottom/YTilesN
		Gui, 98:+ToolWindow
		Gui, 98:Show, x-1 w1 NoActivate, w Is Down
		Gui, 99:Destroy
		return
	$*q::
		Gui, 98:+ToolWindow
		Gui, 98:Show, x-1 w1 NoActivate, q Is Down
		Gui, 99:Destroy
		return
	k::Up
	j::Down
	l::Right
	h::Left
	m::AppsKey
	1::Insert
	d::Delete
	b::Backspace
	u::PgDn
	i::PgUp
	o::End
	y::Home
	9:: 
		Send {Volume_Mute}  
		SetTimer, Mute, -58000
		return
	0:: 
		Send {Volume_Mute}  
		SetTimer, Mute, -28000
		return
	; To Focus different windows {{{
	!h::
		SysGet, Mon, MonitorWorkArea
		TWidth := MonRight/XTilesN
		CoordMode, Mouse

		MouseGetPos, MXPos, MYPos
		PreviousTileWidth := round(MXPos / TWidth)
		MouseMove, TWidth * (PreviousTileWidth-1) + 10, MYPos

		MouseGetPos,,, WinUMID
		WinActivate, ahk_id %WinUMID%
		return
	!j::
		SysGet, Mon, MonitorWorkArea
		THeight := MonBottom/YTilesN
		CoordMode, Mouse

		MouseGetPos, MXPos, MYPos
		PreviousTileHeight := round(MYPos / THeight)
		MouseMove, MXPos, THeight * (PreviousTileHeight+1) + 10

		MouseGetPos,,, WinUMID
		WinActivate, ahk_id %WinUMID%
		return
	!k::
		SysGet, Mon, MonitorWorkArea
		THeight := MonBottom/YTilesN
		CoordMode, Mouse

		MouseGetPos, MXPos, MYPos
		PreviousTileHeight := round(MYPos / THeight)
		MouseMove, MXPos, THeight * (PreviousTileHeight-1) + 10

		MouseGetPos,,, WinUMID
		WinActivate, ahk_id %WinUMID%
		return
	!l::
		SysGet, Mon, MonitorWorkArea
		TWidth := MonRight/XTilesN
		CoordMode, Mouse

		MouseGetPos, MXPos, MYPos
		PreviousTileWidth := round(MXPos / TWidth)
		MouseMove, TWidth * (PreviousTileWidth+1) + 10, MYPos

		MouseGetPos,,, WinUMID
		WinActivate, ahk_id %WinUMID%
		return
;}}}
#IfWinExist

; Function to toggle mute/unmute
Mute:  
Send {Volume_Mute}  
return

;Modifier 2, q needs to be pressed while capslock is down for the modifier 2 be activated {{{
#IfWinExist, q Is Down
	$*q::
		keywait, q
		Gui, 98:Destroy
		return
	h::Home
	j::PgDn
	k::PgUp
	l::End
	e:: MouseClick, Left, 700, 730
	d:: MouseClick, Left, 700, 770
	r:: MouseClick, Left, 900, 730
	l:: MouseClick, Left, 750, 760
	v:: MouseClick, Left, 985, 815
	f:: MouseClick, Left, 900, 770
	j:: MouseClick, Left, 450, 760
	k:: MouseClick, Left, 590, 760
	a:: MouseClick, Left, 450, 705
#IfWinExist
;}}}

;Modifier 3, "w" that handles windows sizes, positions and focus
#IfWinExist, w Is Down
	$*w::
		keywait, w
		Gui, 98:Destroy
		return
	; Positioning window {{{
	^h::
		WinGetPos, XPos, , , , A
		PreviousTilePos := round(XPos / TWidth)
		WinMove, A, , TWidth * (PreviousTilePos-1) - 7, , , 
		return
	^j::
		WinGetPos, , YPos, , , A
		PreviousTilePos := round(YPos / THeight)
		WinMove, A, , , THeight * (PreviousTilePos+1), , 
		return
	^k::
		WinGetPos, , YPos, , , A
		PreviousTilePos := round(YPos / THeight)
		WinMove, A, , , THeight * (PreviousTilePos-1), , 
		return
	^l::
		WinGetPos, XPos, , , , A
		PreviousTilePos := round(XPos / TWidth)
		WinMove, A, , TWidth * (PreviousTilePos+1) - 7, , , 
		return
; }}}
; Resizing {{{
	h::
		WinGetPos, , , WinWidth, WinHeight, A
		PreviousTileWidth := round(WinWidth / TWidth)
		WinMove, A, , , , TWidth * (PreviousTileWidth-1) + 15, 
		return
	j::
		WinGetPos, , , WinWidth, WinHeight, A
		PreviousTileHeight := round(WinHeight / THeight)
		WinMove, A, , , , , THeight * (PreviousTileHeight+1) + 8
		return
	k::
		WinGetPos, , , WinWidth, WinHeight, A
		PreviousTileHeight := round(WinHeight / THeight)
		WinMove, A, , , , , THeight * (PreviousTileHeight-1) + 8
		return
	l::
		WinGetPos, , , WinWidth, WinHeight, A
		PreviousTileWidth := round(WinWidth / TWidth)
		WinMove, A, , , , TWidth * (PreviousTileWidth+1) + 15, 
		return
; }}}
	t::
		CoordMode, Mouse
		MouseMove, 0, 0
		MouseGetPos,,, WinUMID
		WinActivate, ahk_id %WinUMID%
		;MsgBox, Width: %FinalWidth% -- Height: %FinalHeight%.
		;WinMove, A, , , , TWidth * 2, THeight * 2
		return
#IfWinExist

RShift & LShift::
	SetCapsLockState, % (State:=!State) ? "On" : "Off"
	return

LShift & RShift::
	SetCapsLockState, % (State:=!State) ? "On" : "Off"
	return
