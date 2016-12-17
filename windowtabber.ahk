
Gui, +AlwaysOnTop +ToolWindow -Border
Gui, Color, bfbfbf
Gui, Add, Button, x0 y-3 w14 h25 gReset, R
Gui, Add, Button, x13 y-3 h25 gAddTab, Add Tab

Gui, Show, x-1680 y0 w1674 h20, No Activation

buttonNextPos := 80

tab_list := Object()

Return

AddTab:
    Send !{ESC}
    WinGet, lastwindow, , A
    maketabkey(lastwindow)
    WinGetTitle, wintitle, A
    StringLeft, wintitle, wintitle, 12
    Gui, Add, Button, x%buttonNextPos% y-3 w80 h25 hwndButton%lastwindow%, %wintitle%
    gFunc:=Func("TabCallback").Bind(lastwindow)
    GuiControl, +g, % Button%lastwindow%, % gFunc
    buttonNextPos += 79
Return

TabCallback(id)
{
    WinActivate, ahk_id %id%
    WinMove, A, , -1680, 24, 1680, 1030
    Return
}

maketabkey(id)
{
    global
    tab_list.Push(id)
    num := tab_list.Length()
    if (num == 10)
        num := 0
    if (num > 10)
        Return
    Hotkey, ^!%num%, HotkeyCallbackFocus
    Hotkey, !+%num%, HotkeyCallback
    Return
}

HotkeyCallbackFocus:
    key := 0
    Loop, 10
    {
        GetKeyState, keystate, %key%
        if keystate = D
            break
        key += 1
    }
    if (key == 0)
        key := 10
    TabCallback(tab_list[key])
    for index, val in tab_list
    {
        if (win_id == val)
            Return
    }
Return

HotkeyCallback:
    WinGet, win_id, ID, A
    key := 0
    Loop, 10
    {
        GetKeyState, keystate, %key%
        if keystate = D
            break
        key += 1
    }
    if (key == 0)
        key := 10
    TabCallback(tab_list[key])
    for index, val in tab_list
    {
        if (win_id == val)
            Return
    }
    WinActivate, ahk_id %win_id%
Return


Reset:
    Reload